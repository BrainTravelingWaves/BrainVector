function [ Rec ] = meschm_pot( cortexfile,inner,head,outer,channel,iEeg,dipe, elem)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% Creating OPTIONS structure for bst_openmeeg
OPTIONS.Comment='';
OPTIONS.HeadModelFile=head;
OPTIONS.HeadModelType='surface';
OPTIONS.Channel=channel;
OPTIONS.MEGMethod='';
OPTIONS.EEGMethod='openmeeg';
OPTIONS.ECOGMethod='';
OPTIONS.SEEGMethod='';
OPTIONS.CortexFile=cortexfile;
OPTIONS.InnerSkullFile=inner;
OPTIONS.BemFiles={head, outer, inner};
OPTIONS.BemNames={'Scalp' 'Skull' 'Brain'};
OPTIONS.BemCond=[0.33 0.0041 0.33];
OPTIONS.iEeg=iEeg;
OPTIONS.BemSelect=[1 1 1];
OPTIONS.isAdjoint=0;
OPTIONS.isAdaptative=1;
OPTIONS.isSplit=0;
% checking for elem option. if 'equiv' then only one dipole is used for
% forward modelling (dipe.Loc - location of dipole, dipe.Amp - the location of an end of dipole. Dipole vector is dipe.Amp-dipe.Loc).
% if 'elem' then dipoles are used which are placed in the vertices of the
% mesh (dipe.elem - elemental dipoles. only
% then iterating for time points (i)
if strcmp(elem,'equiv')
for i=1:size(dipe.Loc,1)
    % location of the dipole and its orientation (via unit vector)
OPTIONS.GridLoc=dipe.Loc(i,:);
OPTIONS.GridOrient=(dipe.Amp(i,:)-dipe.Loc(i,:))/norm(dipe.Amp(i,:)-dipe.Loc(i,:));
G=bst_openmeeg(OPTIONS);
Rec(:,i)=G*(dipe.Amp(i,:)-dipe.Loc(i,:))';
end
elseif strcmp(elem,'elem')
OPTIONS.GridLoc=squeeze(dipe.elem.Loc(1,:,:));
OPTIONS.GridOrient=squeeze((dipe.elem.Amp(1,:,:))/norm(squeeze(dipe.elem.Amp(1,:,:))));
G=bst_openmeeg(OPTIONS);
for i=1:size(dipe.Loc,1)
Rec(:,i)=G*reshape(((dipe.elem.Loc(i,:,:)-dipe.elem.Amp(i,:,:))),size(G,2), 1);
end
end
end

