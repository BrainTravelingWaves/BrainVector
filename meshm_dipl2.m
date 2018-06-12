function [ dipe,Dipole,ElemDip ] = meshm_dipl2( mesh, Amp,SR)
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
for i=1:N_step 
    Dipole.Dipole(i).Index=i;
            Dipole.Dipole(i).Time=(i-1)/(SR);
    for k=1:3 
    DipAmplitude(i,k)=sum(VertNormals(:,k).*(Amp(:,i)))/size(VertNormals,1);  
    end
        Dip_proj(:,i)=sum(VertNormals.*(repmat(Amp(:,i),1,3)).*md3.*repmat(DipAmplitude(i,:),size(VertNormals,1),1),2);
        Dip_proj((Dip_proj(:,i))<0,i)=0;
        DipLoc(i,:)=sum(Vertices.*repmat(Dip_proj(:,i),1,3),1)/sum(Dip_proj(:,i));
        DipAmplitude(i,:)=DipAmplitude(i,:)+DipLoc(i,:);
        ElemLoc(i,:,:)=Vertices(Amp(:,i)~=0,:);
        ElemAmp(i,:,:)=VertNormals(Amp(:,i)~=0,:).*repmat(Amp(Amp(:,i)~=0,i),1,3);
            Dipole.Dipole(i).Loc=DipLoc(i,:);
            Dipole.Dipole(i).Amplitude= DipAmplitude(i,:);
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
            ElemDip.Dipole(i).Index=i;
            ElemDip.Dipole(i).Loc=squeeze(ElemLoc(i,:,:))';
            ElemDip.Dipole(i).Amplitude= squeeze(ElemAmp(i,:,:))';
            ElemDip.Dipole(i).Time=(i-1)/(SR);
            ElemDip.Dipole(i).Origin=[0 0 0];
            ElemDip.Dipole(i).Errors=0;
            ElemDip.Dipole(i).Goodness=[];
            ElemDip.Dipole(i).Errors=0;
            ElemDip.Dipole(i).Noise=[];
            ElemDip.Dipole(i).SingleError=[];
            ElemDip.Dipole(i).ErrorMatrix=[];
            ElemDip.Dipole(i).ConfVol=[];
            ElemDip.Dipole(i).Khi2=[];
            ElemDip.Dipole(i).DOF=[];
            ElemDip.Dipole(i).Probability=[];
            ElemDip.Dipole(i).NoiseEstimate=[];
            ElemDip.Dipole(i).Perform=[];
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
ElemDip.DipoleNames={'elems'};
ElemDip.DataFile='';
ElemDip.History='';
end