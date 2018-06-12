function [ E,Esqr, Eproj ] = meshm_field_e( headmesh,dipe)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
k=9*10^9;
N_step=size(dipe.Loc,1);
Vertices=headmesh.Vertices;
Faces=headmesh.Faces;
%[Vertices, Faces] = tess_remove_vert(headmesh.Vertices, headmesh.Faces, [round(numel(headmesh.Vertices(:,1))/2):numel(headmesh.Vertices(:,1))]);
%[Vertices, Faces] = tess_remove_vert(headmesh.Vertices, headmesh.Faces, [1:round(numel(headmesh.Vertices(:,1))/2)]);
VertConn=tess_vertconn(Vertices,Faces);
VertNormals = tess_normals(Vertices, Faces, VertConn);
for i=1:N_step
r=Vertices-repmat((dipe.Loc(i,:)+dipe.Amp(i,:))/2,size(Vertices(:,1)),1);
rsqr=sqrt(sum(r.^2,2));
rLoc=Vertices-repmat(dipe.Loc(i,:),size(Vertices(:,1)),1);
rLoc=rLoc./repmat(sqrt(sum(rLoc.^2)),size(rLoc(:,1)),1);
rAmp=Vertices-repmat(dipe.Amp(i,:),size(Vertices(:,1)),1);
rAmp=rAmp./repmat(sqrt(sum(rAmp.^2)),size(rAmp(:,1)),1);
rdip=rLoc+rAmp;
p=sqrt(sum((dipe.Loc(i,:)-dipe.Amp(i,:)).^2));
E(:,:,i)=repmat(k*p*sqrt(sum(rdip.^2,2)).^(-3),1,3).*(rLoc-rAmp);
Esqr(:,i)=squeeze(sqrt(sum(E(:,:,i).^2,2)));
Eproj(:,i)=diag(VertNormals*E(:,:,i)');  
end
end

