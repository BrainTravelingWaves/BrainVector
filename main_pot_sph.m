load('dip.mat')
load('eegfon128.mat')
load('cortexfile.mat')
load('headfile.mat')
load('scalpfile.mat')

pot_scalp=meschm_pot_sphere(cortexfile,headfile,scalpfile,eegfon128.Channel,dip,'equiv');