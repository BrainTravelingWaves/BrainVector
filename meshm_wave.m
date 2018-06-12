% distances array (mesh_dist) 
% max distace     (max_dist) 
% length wave     (l_wave) 
% number steps    (N_step)
% wave frequency  (w), 
% sampling rate   (SR)
function [Amp] = meshm_wave(mesh_dist, max_dist, l_wave, N_step, w, SR)
tic
Amp=[];
md=(mesh_dist<max_dist)-(mesh_dist==0);
for i=1:N_step 
    %Amp(:,i)=sin(2*pi*mesh_dist/l_wave+2*pi*i*w/SR).*md;
    Amp(:,i)=sin(2*pi*mesh_dist/l_wave-2*pi*i*w/SR).*md; 
end
toc
end


