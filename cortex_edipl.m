function [ElemDip] = cortex_edipl(mesh, dist, PARAM)
%% Load mesh
Vertices=mesh.Vertices;
%Faces=mesh.Faces;
VertNormals = mesh.VertNormals;
%% Load amp
% dist(dist==Inf)=0;
Amp=zeros(size(Vertices,1),PARAM.N_step);
md=(dist<PARAM.max_dist);
%for i=1:PARAM.N_step 
%    Amp(:,i)=sin(2*pi*dist/PARAM.l_wave-2*pi*i*PARAM.w_frequ/PARAM.SR).*md; 
%end
for i=1:PARAM.N_step 
    Amp(:,i)=(PARAM.shift+cos(2*pi*dist/PARAM.l_wave-2*pi*i*PARAM.w_frequ/PARAM.SR)).*md; 
end
%Amp=Amp*PARAM.ca/(1+PARAM.shift);
Amp=Amp*PARAM.ca; %0.000000050; % A (50 nA/mm2) nano 10e-9
%% Create dipe
ElemDip=zeros(size(Vertices,1),size(Vertices,2),PARAM.N_step);
for i=1:PARAM.N_step 
    ElemDip(Amp(:,i)~=0,:,i)=(VertNormals(Amp(:,i)~=0,:).*repmat(Amp(Amp(:,i)~=0,i),1,3));
end
end