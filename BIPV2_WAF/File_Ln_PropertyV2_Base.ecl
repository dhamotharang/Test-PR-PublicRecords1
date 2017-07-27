import LN_PropertyV2, mdr;

prop_search_base := LN_PropertyV2.File_Search_DID(~((length(trim(cname))<4	and	cname<>'')	or
																										 (trim(prim_range)='' and trim(prim_name)='' and trim(v_city_name)='' and trim(st)='' and trim(zip)='')
																									 ) and 
																									 ln_fares_id <> '' and ln_fares_id[1] <> 'D' and
																									 ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID and
																									 ultid <> 0
																								 );

EXPORT File_Ln_PropertyV2_Base := project(prop_search_base,
																					transform({recordof(prop_search_base),string17 source := ''},
																										self.source	:= MDR.sourceTools.fProperty(left.ln_fares_id)+ left.source_code[1..2] + left.vendor_source_flag + left.ln_fares_id[1..12],
																										self				:= left)
																				 ): persist('~thor_data400::persist::BIPV2_WAF::File_LN_ProperyV2_Base');
																		