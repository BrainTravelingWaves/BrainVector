function [ dipe,Dipole,ElemDip ] = meshm_dipl_full_surface( mesh, Amp,SR)
% UNTITLED Summary of this function goes here
% Detailed explanation goes here
% [Vertices, Faces] = tess_remove_vert(mesh.Vertices, mesh.Faces, [round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1))]);
% mesh_dist(round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1)))=[];
Vertices=mesh.Vertices;
Faces=mesh.Faces;
VertConn=tess_vertconn(Vertices,Faces);
VertNormals = tess_normals(Vertices, Faces, VertConn);
N_step=size(Amp,2);
md=(Amp(:,2)~=0);
md3=repmat(md,1,3);
ElemLoc=zeros(N_step,size(Vertices,1),size(Vertices,2));
ElemAmp=zeros(N_step,size(Vertices,1),size(Vertices,2));
for i=1:N_step 
    Dipole.Dipole(i).Index=1;
            Dipole.Dipole(i).Time=(i-1)/(SR);
    for k=1:3 
    DipAmplitude(i,k)=sum(VertNormals(:,k).*(Amp(:,i)))/size(VertNormals,1);  
    end
        Dip_proj(:,i)=sum(VertNormals.*(repmat(Amp(:,i),1,3)).*md3.*repmat(DipAmplitude(i,:),size(VertNormals,1),1),2);
        Dip_proj((Dip_proj(:,i))<0,i)=0;
        DipLoc(i,:)=sum(Vertices.*repmat(Dip_proj(:,i),1,3),1)/sum(Dip_proj(:,i));
        try
        ElemLoc(i,Amp(:,i)~=0,:)=Vertices(Amp(:,i)~=0,:);
        catch
        disp('sdf');    
        end
        ElemAmp(i,Amp(:,i)~=0,:)=(VertNormals(Amp(:,i)~=0,:).*repmat(Amp(Amp(:,i)~=0,i),1,3));
            Dipole.Dipole(i).Loc=DipLoc(i,:)';
            Dipole.Dipole(i).Amplitude= DipAmplitude(i,:)';
            DipAmplitude(i,:)=DipAmplitude(i,:)+DipLoc(i,:);
            Dipole.Dipole(i).Origin=[0 0 0];
            Dipole.Dipole(i).Errors=0;
            Dipole.Dipole(i).Goodness=[];
            Dipole.Dipole(i).Errors=0;
            Dipole.Dipole(i).Noise=[];
            Dipole.Dipole(i).SingleError=[];
            Dipole.Dipole(i).ErrorMatrix=[];
            Dipole.Dipole(i).ConfVol=[];
            Dipole.Dipole(i).Khi2=[];
            Dipole.Dipole(i).DOF=[];
            Dipole.Dipole(i).Probability=[];
            Dipole.Dipole(i).NoiseEstimate=[];
            Dipole.Dipole(i).Perform=[];
            %Elementary dipoles in bst structure
%             for k=1:size(ElemLoc,2)
%                 idx=(i-1)*size(ElemLoc,2)+k;
%                 ElemDip.Dipole(idx).Index=i;
%                 ElemDip.Dipole(idx).Loc=squeeze(ElemLoc(i,k,:));
%                 ElemDip.Dipole(idx).Amplitude= squeeze(ElemAmp(i,k,:));
%                 ElemDip.Dipole(idx).Time=(i-1)/(SR);
%                 ElemDip.Dipole(idx).Origin=[0 0 0];
%                 ElemDip.Dipole(idx).Errors=0;
%                 ElemDip.Dipole(idx).Goodness=[];
%                 ElemDip.Dipole(idx).Errors=0;
%                 ElemDip.Dipole(idx).Noise=[];
%                 ElemDip.Dipole(idx).SingleError=[];
%                 ElemDip.Dipole(idx).ErrorMatrix=[];
%                 ElemDip.Dipole(idx).ConfVol=[];
%                 ElemDip.Dipole(idx).Khi2=[];
%                 ElemDip.Dipole(idx).DOF=[];
%                 ElemDip.Dipole(idx).Probability=[];
%                 ElemDip.Dipole(idx).NoiseEstimate=[];
%                 ElemDip.Dipole(idx).Perform=[];
% %                 if length(ElemDip.DipoleNames)<size(ElemLoc,2)
% %                     ElemDip.DipoleNames{k}=strcat('elem',num2str(k));
% %                 end
%             end
end
dipe.Loc=DipLoc;
dipe.Amp=DipAmplitude;
dipe.Ampsqr=sqrt(sum(DipAmplitude.^2,2));
dipe.elem.Loc=ElemLoc;
dipe.elem.Amp=ElemAmp;
Dipole.Comment='Dipoles_test';
Dipole.Time=1/N_step:1/N_step:1;
Dipole.DipoleNames={'try'};
Dipole.DataFile='';
Dipole.History='';
ElemDip.Comment='Dipoles_elem_test';
ElemDip.Time=0:1/SR:N_step/SR;
ElemDip.DataFile='';
ElemDip.History='';
end