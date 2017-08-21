//--------Funtion to transform to old layout and to eliminate duplications
import phonesplus;
export Fn_Map_v1_Fields(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function
//----Transform to a v1 layout
recordof(phplus_in) t_reformat(phplus_in le) := transform
eq_src 			 :=  phonesplus_v2.Translation_Codes.fGet_eq_sources_from_bitmap(le.src_all);
other_header_src :=  phonesplus_v2.Translation_Codes.fGet_other_hdr_sources_from_bitmap(le.src_all);
other_src        :=  phonesplus_v2.Translation_Codes.fGet_other_sources_from_bitmap(le.src_all);
	self.ActiveFlag				:= if(le.eda_active_flag, 'Y', '');
	self.ConfidenceScore 		:= if(le.in_flag, 11, 0); 
	//---using field to store rules indicator
	self.Vendor 				:= if(other_src <> '', other_src[..2], 'HD');
	self.src				    := if(other_src <> '', '',
									  if(other_header_src <> '', other_header_src[..2],eq_src));			
	self.ListingType 			:= StringLib.StringFindReplace(le.orig_listing_type[..2], ',', '');
	self.did				    := if (le.pdid = 0, le.did, 0);
	self						:=le;
end;

reformat_old := project(phplus_in, t_reformat(left));

return reformat_old;

end;