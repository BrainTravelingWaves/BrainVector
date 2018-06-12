function [] = meshm_viewd(mesh,Amp,dipe) % ����� �����
  [Vertices, Faces] = tess_remove_vert(mesh.Vertices, mesh.Faces, [round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1))]); % ������� ���������
  Amp(round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1)),:)=[];
  figure;
  for k=1:size(Amp,2)
    % trisurf(Faces,Vertices(:,1),Vertices(:,2),Vertices(:,3),Amp(:,k)); % ������ ����
    al=0.1;
    alpha(al); 
    hold on;
    plot3([dipe.Loc(k,1) dipe.Amp(k,1)],[dipe.Loc(k,2) dipe.Amp(k,2)],[dipe.Loc(k,3) dipe.Amp(k,3)],'-mo','LineWidth',2); % ������ ������������� ������
    hold off;
    colorbar;
    az = 0.0*360; % ������������ ���
    el = 0.0*180;
    view(az,el);
    pause(0.05);
  end
end
