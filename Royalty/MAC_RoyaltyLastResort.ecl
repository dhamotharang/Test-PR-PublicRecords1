// Same code previously located in Phonesplus_v2.Mac_LastResort_Royalties
EXPORT MAC_RoyaltyLastResort(inf, royalty_out, vendor='vendor_id',countentity='phone') := macro

	#uniquename(LR_royal_trans)
	Royalty.Layouts.Royalty %LR_royal_trans%(inf L):= transform
		self.Royalty_Type_Code :=  Royalty.Constants.RoyaltyCode.LAST_RESORT;
		self.Royalty_Type :=  Royalty.Constants.RoyaltyType.LAST_RESORT;
		self.Royalty_count := 1;
		self.non_royalty_count := 0;
		self.count_entity := L.countentity;
	end;

	#uniquename(LastResort_royal)
	%LastResort_royal% := project(inf(vendor in Royalty.Constants.LastResortRoyalty),%LR_royal_trans%(left));

	#uniquename(royal_roll)
	Royalty.Layouts.Royalty %royal_roll%(Royalty.Layouts.Royalty  lr, Royalty.Layouts.Royalty  rr) := transform
		self.Royalty_count := lr.Royalty_count + rr.Royalty_count;
		self := rr;
	end;

	royalty_out :=  rollup(sort(%LastResort_royal%,Royalty_Type_Code,count_entity),
															left.Royalty_Type_Code = right.Royalty_Type_Code and left.count_entity = right.count_entity,
															%royal_roll%(left,right));

endmacro;
