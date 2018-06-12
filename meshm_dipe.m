function [ dipe ] = meshm_dipe( mesh, Amp )
% [Vertices, Faces] = tess_remove_vert(mesh.Vertices, mesh.Faces, [round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1))]);
% mesh_dist(round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1)))=[];
tic
Vertices=mesh.Vertices;
Faces=mesh.Faces;
% VertConn=tess_vertconn(Vertices,Faces);
VertNormals = tess_normals(Vertices, Faces, tess_vertconn(Vertices,Faces));
N_step=size(Amp,2);
md=(Amp(:,2)~=0);
md3=repmat(md,1,3);
ElemLoc=zeros(N_step,size(Vertices,1),size(Vertices,2));
ElemAmp=zeros(N_step,size(Vertices,1),size(Vertices,2));
for i=1:N_step 
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
end
dipe.Loc=DipLoc;
dipe.Amp=DipAmplitude;
dipe.Ampsqr=sqrt(sum(DipAmplitude.^2,2));
dipe.elem.Loc=ElemLoc;
dipe.elem.Amp=ElemAmp;
toc
end