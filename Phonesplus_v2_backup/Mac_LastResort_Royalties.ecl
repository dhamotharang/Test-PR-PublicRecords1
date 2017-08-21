export Mac_LastResort_Royalties(in_ds,vendor,countentity,royalty) := Macro

#uniquename(royal_rec)
%royal_rec% := record
	string Royalty_Type; 
	unsigned royalty_count; 
	unsigned non_royalty_count;
	string count_entity := '';
end;

#uniquename(LR_royal_trans)
%royal_rec% %LR_royal_trans%(in_ds L):= transform
	self.Royalty_Type := L.vendor;
	self.Royalty_count := 1;
	self.non_royalty_count := 0;
	self.count_entity := L.countentity;
end;

#uniquename(LastResort_royal)
%LastResort_royal% := project(in_ds(vendor in Phonesplus_v2.Constants.LastResortRoyalty),%LR_royal_trans%(Left));

#uniquename(royal_roll)
%royal_rec% %royal_roll%(%royal_rec% lr,%royal_rec% rr) := transform
	self.Royalty_count := lr.Royalty_count + rr.Royalty_count;
	self := rr;
end;

royalty :=  rollup(sort(%LastResort_royal%,Royalty_Type,count_entity),
																	left.Royalty_Type = right.Royalty_Type and left.count_entity = right.count_entity,
																	%royal_roll%(left,right));

endmacro;