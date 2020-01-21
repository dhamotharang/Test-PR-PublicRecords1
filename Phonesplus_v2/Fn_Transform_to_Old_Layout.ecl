//--------Funtion to transform to old layout and to eliminate duplications
import phonesplus;
export Fn_Transform_to_Old_Layout(dataset(recordof(Phonesplus_v2.Layout_PhonesPlus_Base/*DF-25784*/)) phplus_in) := function
//----Transform to a v1 layout
phonesplus.layoutCommonOut t_reformat(phplus_in le) := transform
eq_src 			 :=  phonesplus_v2.Translation_Codes.fGet_eq_sources_from_bitmap(le.src_all);
other_header_src :=  phonesplus_v2.Translation_Codes.fGet_other_hdr_sources_from_bitmap(le.src_all);
other_src        :=  phonesplus_v2.Translation_Codes.fGet_other_sources_from_bitmap(le.src_all);

	//self.InitScoreType 			:= le.rules;
	self.Phone7IDKey 			:= le.phone7_did_key;
	self.dt_nonglb_last_seen	:= le.dt_nonglb_last_seen;
 	self.glb_dppa_flag			:= le.glb_dppa_flag;
	self.ActiveFlag				:= if(le.eda_active_flag, 'Y', '');
	self.ConfidenceScore 		:= if(le.in_flag, 11, 0); 
	//---using field to store rules indicator
	self.RecordKey 				:= (string)le.rules;
	self.Vendor 				:= if(other_src <> '', other_src[..2], 'HD');
	
	//self.StateOrigin := '';
	self.SourceFile 			:= if(other_src <> '', 
								   PhonesPlus_V2.Translation_Codes.source_file(other_src[..2]), 
								   PhonesPlus_V2.Translation_Codes.source_file('HD'));
	self.src				    := if(other_src <> '', '',
									  if(other_header_src <> '', other_header_src[..2],eq_src));			

	self.NameFormat 			:= '';

	self.Country 				:= (string)le.src_all ;
	//---using field to store prior area codes
	self.Dob 					:= le.append_prior_area_code;
	//---using field to store different source bit map
	self.HomePhone 				:= '';
	self.CellPhone 				:= le.npa + le.Phone7;
	self.ListingType 			:= StringLib.StringFindReplace(le.orig_listing_type[..2], ',', '');
	self.PublishCode			:= if(PhonesPlus_V2.Translation_Codes.fFlagIsOn(le.rules, PhonesPlus_V2.Translation_Codes.rules_bitmap_code('Non-pub')), 'N', '');
	self.OrigTitle 				:= '';
 	self.RegistrationDate 		:= le.orig_phone_reg_dt;
	//---using field to store phone type
	self.PhoneModel 			:= le.append_phone_type;
	//---using field to store sources
	self.IPAddress 				:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(other_src + '  ' + other_header_src + ' ' + eq_src, ',', ' '));
	//---using field to store latest phone owner flag 
	self.CarrierCode 			:= if(le.append_latest_phone_owner_flag, '1', '0');
	//---using field to store vendor current confidence score
	self.CountryCode 			:= (string) le.cur_orig_conf_score;
	//---using field to store address best match flag
	self.KeyCode 				:= if(le.append_best_addr_match_flag, '1', '0');
	//---using field to store hhid
	self.GlobalKeyCode 			:= (string)le.hhid;
	self.name_score				:= (string) le.name_score;
	self.did				    := if (le.pdid = 0, le.did, 0);
	self.did_score				:= (string) le.did_score;
	self						:=le;
end;

reformat_old := project(phplus_in(current_rec = true), t_reformat(left));

return reformat_old;

end;