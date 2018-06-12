function [ B,Bsqr,Bproj ] = meshm_field_m( headmesh,dipe, SR,elem)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mu0=1.257*10^(-6);
N_step=size(dipe.Loc,1);
Vertices=headmesh.Vertices;
Faces=headmesh.Faces;
%[Vertices, Faces] = tess_remove_vert(headmesh.Vertices, headmesh.Faces, [round(numel(headmesh.Vertices(:,1))/2):numel(headmesh.Vertices(:,1))]);
VertConn=tess_vertconn(Vertices,Faces);
VertNormals = tess_normals(Vertices, Faces, VertConn);
if elem==1
for i=1:N_step
        for k=1:3
        if i>1
        dist_vert_beg(:,i,k)=Vertices(:,k)-dipe.Loc(i,k);
        dist_vert_end(:,i,k)=Vertices(:,k)-dipe.Amp(i,k);
        Vdip_beg(i-1,k)=(dipe.Loc(i,k)-dipe.Loc(i-1,k))*SR;
        Vdip_end(i-1,k)=(dipe.Amp(i,k)-dipe.Amp(i-1,k))*SR;
        end
        end
    if i>1
        Vdip_beg_c=repmat(Vdip_beg(i-1,:), size(dist_vert_beg(:,i,:),1),1);
        Vdip_end_c=repmat(Vdip_end(i-1,:), size(dist_vert_end(:,i,:),1),1);
        rsqr_beg=repmat(sum(dist_vert_beg(:,i,:).^2,3),1,3);
        rsqr_end=repmat(sum(dist_vert_end(:,i,:).^2,3),1,3);
        B1(:,:,i)=(mu0/(4*pi))*cross(squeeze(dist_vert_beg(:,i,:)),Vdip_beg_c)./rsqr_beg;
        B2(:,:,i)=(mu0/(4*pi))*cross(squeeze(dist_vert_end(:,i,:)),Vdip_end_c)./rsqr_end;
        B=B1-B2;
        Bsqr(:,i)=squeeze(sqrt(sum(B(:,:,i).^2,2)));
             Bproj(:,i)=diag(VertNormals*B(:,:,i)');  
    end
end

else
for i=1:N_step
    for t=1:size(dipe.elem.Loc,2)
        for k=1:3
        if i>1
        dist_vert_beg(:,i,k)=Vertices(:,k)-dipe.elem.Loc(i,t,k);
        dist_vert_end(:,i,k)=Vertices(:,k)-dipe.elem.Amp(i,t,k);
        Vdip_beg(i-1,k)=(dipe.elem.Loc(i,t,k)-dipe.elem.Loc(i-1,t,k))*SR;
        Vdip_end(i-1,k)=(dipe.elem.Amp(i,t,k)-dipe.elem.Amp(i-1,t,k))*SR;
        end
        end
    if i>1
        Vdip_beg_c=repmat(Vdip_beg(i-1,:), size(dist_vert_beg(:,i,:),1),1);
        Vdip_end_c=repmat(Vdip_end(i-1,:), size(dist_vert_end(:,i,:),1),1);
        rsqr_beg=repmat(sum(dist_vert_beg(:,i,:).^2,3),1,3);
        rsqr_end=repmat(sum(dist_vert_end(:,i,:).^2,3),1,3);
        B1(:,:,t,i)=(mu0/(4*pi))*cross(squeeze(dist_vert_beg(:,i,:)),Vdip_beg_c)./rsqr_beg;
        B2(:,:,t,i)=(mu0/(4*pi))*cross(squeeze(dist_vert_end(:,i,:)),Vdip_end_c)./rsqr_end;
        B=B1-B2;
        Bsqr_elem(:,t,i)=squeeze(sqrt(sum(B(:,:,i).^2,2)));
    end
    end
end  

Bsqr=sum(Bsqr_elem,2);

end
end

