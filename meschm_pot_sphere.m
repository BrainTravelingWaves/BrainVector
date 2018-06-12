function [ Rec ] = meschm_pot_sphere( cortexfile, skullfile, scalpfile,channel,dipe, elem)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
scalp=load(scalpfile);
skull=load(skullfile);
cortex=load(cortexfile);
centerSc=0;
centerSk=0;
SkR=0;
ScR=0;
CortStep=100;
ScSphere=bst_os(channel,scalp.Vertices,scalp.Faces);
for k=1:length(ScSphere) 
    centerSc=centerSc+ScSphere(k).Center;
    ScRk=ScR+ScSphere(k).Radius;
end
centerSc=centerSc/k;
SkSphere=bst_os(channel,skull.Vertices,skull.Faces);
for k=1:length(SkSphere) 
    centerSk=centerSk+SkSphere(k).Center;
    SkRk=SkR+SkSphere(k).Radius;
end
centerSk=centerSk/k;
center=mean(cat(2,centerSk,centerSc),2);
k0=0;
for k=1:CortStep:size(cortex.Vertices,1);
    k0=k0+1;
    CortRk(k0,:)=cortex.Vertices(k,:)-center';
end
CortR=mean(sqrt(sum(CortRk.^2,2)));
SkR=mean(sqrt(sum(SkRk.^2,2)));
ScR=mean(sqrt(sum(ScRk.^2,2)));
R=cat(2,CortR,SkR,ScR);
for z=1:length(channel)
ChannelGrid(z,:)=channel(z).Loc;
end
if strcmp(elem,'equiv')
for i=1:size(dipe.Loc,1)
GridLoc=dipe.Loc(i,:);
GridOrient=(dipe.Amp(i,:)-dipe.Loc(i,:))/norm(dipe.Amp(i,:)-dipe.Loc(i,:));
G = bst_eeg_sph(GridLoc, ChannelGrid, center', R, [0.33 0.0041 0.33]);
Rec(:,i)=G*(dipe.Amp(i,:)-dipe.Loc(i,:))';
end
end
if strcmp(elem,'elem')
GridLoc=squeeze(dipe.elem.Loc(1,:,:));
G = bst_eeg_sph(GridLoc, ChannelGrid, center', R, [1 0.0125 1]);
for i=1:size(dipe.Loc,1)
Rec(:,i)=G*(dipe.elem.Amp(i,:)-dipe.elem.Loc(i,:))';
end
end
end

