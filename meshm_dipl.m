function [ dipe ] = meshm_dipl( mesh, Amp)
% UNTITLED Summary of this function goes here
% Detailed explanation goes here
% [Vertices, Faces] = tess_remove_vert(mesh.Vertices, mesh.Faces, [round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1))]);
% mesh_dist(round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1)))=[];
Vertices=mesh.Vertices;
Faces=mesh.Faces;
% VertConn=tess_vertconn(Vertices,Faces);
VertNormals = mesh.VertNormals;  % VertNormals =tess_normals(Vertices, Faces, VertConn);
N_step=size(Amp,2);
md=(Amp(:,2)~=0);
md3=repmat(md,1,3);
for i=1:N_step 
    for k=1:3 
        DipAmplitude(i,k)=sum(VertNormals(:,k).*(Amp(:,i)))/numel(VertNormals(:,1));  
    end
        Dip_proj(:,i)=sum(VertNormals.*md3.*repmat(DipAmplitude(i,:),size(VertNormals,1),1),2);
        Dip_proj((Dip_proj(:,i))<0,i)=0;
        DipLoc(i,:)=sum(Vertices.*repmat(Dip_proj(:,i),1,3),1)/sum(Dip_proj(:,i));
        DipAmplitude(i,:)=DipAmplitude(i,:)+DipLoc(i,:);
end
dipe.Loc=DipLoc;
dipe.Amp=DipAmplitude;
end