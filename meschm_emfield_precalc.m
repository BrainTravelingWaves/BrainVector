function [ Rec ] = meschm_emfield_precalc( dipe, Gain)
for i=1:size(dipe.Loc,1)
Rec(:,i)=Gain*reshape((squeeze(dipe.elem.Amp(i,:,:)))',size(Gain,2), 1);
end
end

