function [ dipc ] = centre_dipoles( dipr )
% Making the mirror and simmetry dipoles
dipl=dipr;
dipl.Loc(:,2)=dipl.Loc(:,2)*-1;
dipl.Amp(:,2)=dipl.Amp(:,2)*-1;
% dipc=dipr+dipl
dipc=[];
dipc.Amp=(dipr.Amp-dipr.Loc)+(dipl.Amp-dipl.Loc);
dipc.Loc=(dipr.Loc+dipl.Loc)/2;
dipc.Amp=dipc.Amp+dipc.Loc;
end

