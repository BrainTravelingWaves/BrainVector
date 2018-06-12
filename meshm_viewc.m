%mesh  - ����������� ����,
%Amp   - �������� �������� �������
%right - 0-����� ���������, 1-������, >1 ��� ���������
%views - ����
%al    - ������������ �� 0.0 �� 1.0
%interpol 0-��� �������������
function [] = meshm_viewc(mesh,Amp,dipe,lendip,right,views,al,video) % ����� ����� � ����� ���������
  if right==0
     [Vertices, Faces] = tess_remove_vert(mesh.Vertices, mesh.Faces, [round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1))]);
     Amp(round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1)),:)=[]; % ������� ������ ���������
  end
  if right==1
     [Vertices, Faces] = tess_remove_vert(mesh.Vertices, mesh.Faces, [1:round(numel(mesh.Vertices(:,1))/2)]); % ������� ����� �������� � ���������� mesh_dist ???
      Amp(1:round(numel(mesh.Vertices(:,1))/2),:)=[];  
  end
  if right > 1
     Vertices=mesh.Vertices;
     Faces=mesh.Faces;
  end
  if views==0 %'left'
      az = 0;
      el = 0; 
  end
  if views==1 %'right'
      az = 180;
      el = 0; 
  end
  if views==2 %'back'
      az = -90;
      el = 0; 
  end
  if views==3 %'top'
      az = -90; 
      el = 90; 
  end
  if views==4 %'front'
      az = 90; 
      el = 0; 
  end
  if views==5 %'bottom'
      az = -90; 
      el = -90; 
  end
  figure('units','normalized','outerposition',[0 0 1 1])
  maxA=max(max(Amp));
  minA=min(min(Amp));
  %lendip=5.0; % ����������� ������� ������ ������ � diplen ���
  dipe.Amp=lendip*(dipe.Amp-dipe.Loc)+dipe.Loc;
  if video==1 
      M(1:size(Amp,2)+1) = struct('cdata', [],...  %
    'colormap', []); % 
  end
  for k=1:size(Amp,2)   
    trisurf(Faces,Vertices(:,1),Vertices(:,2),Vertices(:,3),Amp(:,k));
    hold on;
    plot3([dipe.Loc(k,1) dipe.Amp(k,1)],[dipe.Loc(k,2) dipe.Amp(k,2)],[dipe.Loc(k,3) dipe.Amp(k,3)],'-','LineWidth',3,'Color','magenta');
    plot3([dipe.Loc(k,1)],[dipe.Loc(k,2)],[dipe.Loc(k,3)],'o','MarkerSize',7,'MarkerFaceColor','magenta');
    hold off;
    % al=0.5; ������������
    alpha(al);
    %axis square
    view(az,el);
    colormap('jet');
    caxis([minA,maxA])
    colorbar('Position',[0.95 0.11 0.025 0.5]);
    if video==1 
        M(k)=getframe(gcf); %
    end
    pause(0.01);
  end
    trisurf(Faces,Vertices(:,1),Vertices(:,2),Vertices(:,3),Amp(:,k));
    for k=1:size(Amp,2) 
    hold on;
    plot3([dipe.Loc(k,1) dipe.Amp(k,1)],[dipe.Loc(k,2) dipe.Amp(k,2)],[dipe.Loc(k,3) dipe.Amp(k,3)],'-','LineWidth',1,'Color','magenta');
    plot3([dipe.Loc(k,1)],[dipe.Loc(k,2)],[dipe.Loc(k,3)],'o','MarkerSize',3,'MarkerFaceColor','magenta');
    hold off;
    end
    % al=0.5; ������������
    alpha(al);
    %axis square
    view(az,el);
    colormap('jet');
    caxis([minA,maxA])
    colorbar('Position',[0.95 0.11 0.025 0.5]);
    if video==1 
        M(k+1)=getframe(gcf);%
        movie(M);%
        movie2avi(M,'WaveMovie.avi', 'compression', 'None');%
    end
end
