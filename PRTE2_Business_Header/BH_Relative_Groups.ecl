import Business_Header, ut, PRTE2;

export BH_Relative_Groups(

	dataset(Layouts.Temporary.Layout_Relatives	)				pBH_Rel_Types		= PRTE2_Business_Header.BH_Rel_Types()
	
) :=
function
	
	Layouts.Temporary.Layout_Rel_Types tNorm_BH_Rel_Types(pBH_Rel_Types l, unsigned c) := transform,
			skip((c = 1 and trim(l.rel1_type) ='') or 
					 (c = 2 and trim(l.rel2_type) ='') or 
					 (c = 3 and trim(l.rel3_type) ='') or
					 (c = 4 and trim(l.rel4_type) ='') or
					 (c = 5 and trim(l.rel5_type) ='') or
					 (c = 6 and trim(l.rel6_type) ='') or
					 (c = 7 and trim(l.rel7_type) ='') or
					 (c = 8 and trim(l.rel8_type) ='') or
					 (c = 9 and trim(l.rel9_type) ='') or
					 (c = 10 and trim(l.rel10_type) ='') or
					 (c = 11 and trim(l.rel11_type) ='')
					)
			self.bdid1							:= l.bdid1;
			self.bdid2							:= l.bdid2;
			self.link_fein					:= l.link_fein;
			self.link_inc_date			:= l.link_inc_date;
			self.orig_fein					:= l.orig_fein;
			self.bus_name						:= l.bus_name;
			self.long_bus_name			:= l.long_bus_name;

			self.rel_type						:= choose(c, l.rel1_type, l.rel2_type, l.rel3_type, l.rel4_type, l.rel5_type,
																					 l.rel6_type, l.rel7_type, l.rel8_type, l.rel9_type, l.rel10_type,
																					 l.rel11_type
																			 );
			self 										:= l;
	end;
	
	dBH_Rel_Type_Norm := Normalize(pBH_Rel_Types, 11, tNorm_BH_Rel_Types(left, counter));
	
	return dBH_Rel_Type_Norm;
	
end;