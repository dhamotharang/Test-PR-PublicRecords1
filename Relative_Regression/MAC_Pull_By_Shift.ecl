export MAC_Pull_By_Shift(count_by_did, old_rel, new_rel, link, link1, link2, shift_type, how_many, myolds, mynews, lost, gain)
	:= macro

#uniquename(dids_list)
%dids_list% := choosen(count_by_did(shift = shift_type), how_many);

#uniquename(pullold)
typeof(old_rel) %pullold%(old_rel l) := transform
	self := l;
end;

#uniquename(pullnew)
typeof(new_rel) %pullnew%(new_rel l) := transform
	self := l;
end;


myolds := join(old_rel, %dids_list%, left.link1 = right.link, %pullold%(left), lookup);
mynews := join(new_rel, %dids_list%, left.link1 = right.link, %pullnew%(left), lookup);

lost := join(myolds, mynews, left.link2 = right.link2, %pullold%(left), left only, hash);
gain := join(mynews, myolds, left.link2 = right.link2, %pullnew%(left), left only, hash);


endmacro;