function [mesh_new] = meshm_remov(mesh,right) % выделяем полушарие
  if right==0
    [Vertices, Faces] = tess_remove_vert(mesh.Vertices, mesh.Faces, [round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1))]);
  end
  if right==1
    [Vertices, Faces] = tess_remove_vert(mesh.Vertices, mesh.Faces, [1:round(numel(mesh.Vertices(:,1))/2)]);    
  end
  mesh_new.Vertices=Vertices;
  mesh_new.Faces=Faces;
end

