function [ surf_square ] = surfsquare(surf,mesh_dist,max_dist)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
insideVertices=find((mesh_dist<max_dist)-(mesh_dist==0));
insideFaces=[];
for i=1:length(insideVertices)
    insideFaces=cat(1,insideFaces,surf.Faces(any(surf.Faces==insideVertices(i),2),:));
end
insideFaces=unique(insideFaces,'rows');
S=zeros(1,size(surf.Faces,1));
for i=1:size(insideFaces,1)
    v=insideFaces(i,:);
    vec1=surf.Vertices(v(2),:)-surf.Vertices(v(1),:);
    vec2=surf.Vertices(v(3),:)-surf.Vertices(v(1),:);
    [~,indx]=ismember(v,surf.Faces,'rows');
    S(indx)=norm(cross(vec1,vec2));
end
surf_square=S;
end

