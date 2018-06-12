function [] = meshm_viewh(mesh,Bsqr,dipe,lendip,views,video) % показ поля
%[Vertices, Faces] = tess_remove_vert(mesh.Vertices, mesh.Faces, [round(numel(mesh.Vertices(:,1))/2):numel(mesh.Vertices(:,1))]);
Vertices=mesh.Vertices;
Faces=mesh.Faces;
  figure('units','normalized','outerposition',[0 0 1 1]);
  maxB=max(max(Bsqr(:,2:end)));
  minB=min(min(Bsqr(:,2:end)));
  if video==1 
      M(1:size(Bsqr,2)+1) = struct('cdata', [],...  %
    'colormap', []); % 
  end
   % lendip=7.0; % увеличиваем видимую длинну диполя в lendip раз
  dipe.Amp=lendip*(dipe.Amp-dipe.Loc)+dipe.Loc;
  for k=1:size(Bsqr,2)    
    maxB=max(Bsqr(:,k));
    minB=min(Bsqr(:,k));
    trisurf(Faces,Vertices(:,1),Vertices(:,2),Vertices(:,3),Bsqr(:,k));
    hold on;
    plot3([dipe.Loc(k,1) dipe.Amp(k,1)],[dipe.Loc(k,2) dipe.Amp(k,2)],[dipe.Loc(k,3) dipe.Amp(k,3)],'-','LineWidth',3,'Color','magenta');
    plot3([dipe.Loc(k,1)],[dipe.Loc(k,2)],[dipe.Loc(k,3)],'o','MarkerSize',7,'MarkerFaceColor','magenta');
    hold off;
    al=0.5;
    alpha(al);
    axis square
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
    shading interp;  
    view(az,el);
    colormap('jet');
    caxis([minB,maxB]);
    colorbar('Position',[0.95 0.11 0.025 0.5]);
    if video==1 
        M(k)=getframe(gcf); %
    end
    pause(0.01);
  end
    trisurf(Faces,Vertices(:,1),Vertices(:,2),Vertices(:,3),Bsqr(:,k));
    hold on;
    for k=1:size(Bsqr,2)   
    plot3([dipe.Loc(k,1) dipe.Amp(k,1)],[dipe.Loc(k,2) dipe.Amp(k,2)],[dipe.Loc(k,3) dipe.Amp(k,3)],'-','LineWidth',1,'Color','magenta');
    plot3([dipe.Loc(k,1)],[dipe.Loc(k,2)],[dipe.Loc(k,3)],'o','MarkerSize',3,'MarkerFaceColor','magenta');
    end
    
    hold off;
    al=0.5;
    alpha(al);
    axis square
    %az = 0;%-90;
    %el = 0;%90;
    shading interp;  
    view(az,el);
    colormap('jet');
    caxis([minB,maxB])
    colorbar('Position',[0.95 0.11 0.025 0.5]);
    if video==1 
        M(k+1)=getframe(gcf);%
        movie(M);%
        movie2avi(M,'WaveMovie.avi', 'compression', 'None');%
    end
end
