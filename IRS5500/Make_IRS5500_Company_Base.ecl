IMPORT Address, AID, Business_Header, Business_Header_SS, MDR, NID, ut, PromoteSupers;

export make_irs5500_Company_base (string pFileDate, string pFormYear) := function 

f := IRS5500.Standardize_Input.fAll(IRS5500.File_In, pFormYear);

// Dedup by unique field, the name cleaning seems to
// have introduced extra rows.
f_ded := DEDUP(f, document_locator_number, ALL);

extr := irs5500.Infile_Is_Extract;

// Note: the flag is always false.  I think the extract was for much older data.  No adjustments
//       were made for the "if" path, since it's no longer traversed. (11/21/13 AJ)
#if(extr)
IRS5500.Layout_IRS5500_AID Slim(f l) := TRANSFORM
	SELF.mail_addr := FALSE;
/*
	SELF.spons_prim_range := l.prim_range;
	SELF.spons_predir := l.predir;
	SELF.spons_prim_name := l.prim_name;
	SELF.spons_addr_suffix := l.addr_suffix;
	SELF.spons_postdir := l.postdir;
	SELF.spons_unit_desig := l.unit_desig;
	SELF.spons_sec_range := l.sec_range;
	SELF.spons_p_city_name := l.v_city_name;
	SELF.spons_st := l.st;
	SELF.spons_zip5 := l.zip;
	SELF.spons_zip4 := l.zip4;
	SELF.spons_cart := l.cart;
	SELF.spons_cr_sort_sz := l.cr_sort_sz;
	SELF.spons_lot := l.lot;
	SELF.spons_lot_order := l.lot_order;
	SELF.spons_dpbc := l.dpbc;
	SELF.spons_chk_digit := l.chk_digit;
	SELF.spons_rec_type := l.record_type;
	SELF.spons_county := l.fipscounty;
	SELF.spons_geo_lat := l.geo_lat;
	SELF.spons_geo_long := l.geo_long;
	SELF.spons_msa := l.msa;
	SELF.spons_geo_blk := l.geo_blk;
	SELF.spons_geo_match := l.geo_match;
	SELF.spons_err_stat := l.err_stat;
*/
	SELF.spons_prep_addr_line1 		 := Address.Addr1FromComponents(
																				stringlib.stringtouppercase(if(trim(left.spons_dfe_mail_str_address) <> '', trim(left.spons_dfe_mail_str_address), trim(left.spons_dfe_loc_01_addr)))
																				,''
																				,''
																				,''
																				,''
																				,''
																				,''
																			); ; 
	SELF.spons_prep_addr_line_last := Address.Addr2FromComponents(
																				 stringlib.stringtouppercase(l.spons_dfe_city )	
																				,stringlib.stringtouppercase(l.spons_dfe_state	)	
																				,trim(l.spons_dfe_zip_code,left,right)[1..5]
																			);;
																			
	SELF.spons_sign_title := l.name_prefix;
	SELF.spons_sign_fname := l.name_first;
	SELF.spons_sign_mname := l.name_middle;
	SELF.spons_sign_lname := l.name_last;
	SELF.spons_sign_suffix := l.name_suffix;
	SELF.spons_sign_name_score := (UNSIGNED1) l.score;
	SELF := l;
	SELF := [];
END;

#else
// For now, we just want the sponsored company and sponsor
// signer name info

clean_mail(f l) := address.CleanAddress182(
	l.spons_dfe_mail_str_address,
	l.spons_dfe_city + ' ' + l.spons_dfe_state + ' ' + l.spons_dfe_zip_code);
	
clean_str(f l) := address.CleanAddress182(
	l.spons_dfe_loc_01_addr + ' ' +	l.spons_dfe_loc_02_addr,
	l.spons_dfe_city + ' ' + l.spons_dfe_state + ' ' + l.spons_dfe_zip_code);
	
IRS5500.Layout_IRS5500_AID Slim(f l) := TRANSFORM

	SELF.mail_addr := IF(
		CASE(clean_mail(l)[179],'E'=>1,' '=>3,'U'=>2,0) <
		CASE(clean_str(l)[179],'E'=>1,' '=>3,'U'=>2,0), TRUE, FALSE);

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Prepare Addresses for Cleaning using macro
	//////////////////////////////////////////////////////////////////////////////////////
	
	SELF.spons_prep_addr_line1 		 := Address.Addr1FromComponents(
																			if(SELF.mail_addr,
																			   l.spons_dfe_mail_str_address, 
																				 if(l.spons_dfe_loc_01_addr <> '',
																				    trim(l.spons_dfe_loc_01_addr) + ' ' +	l.spons_dfe_loc_02_addr,
																						l.spons_dfe_mail_str_address))
																			,''
																			,''
																			,''
																			,''
																			,''
																			,''
																		); 

  // I would think that if it's not a mail address, that the remaining pieces should come from the
	// location attributes, if possible.  So, now we try to use the location attributes first.
	the_city := IF(SELF.mail_addr,
	               l.spons_dfe_city,
								 IF(l.spons_dfe_loc_us_city != '', l.spons_dfe_loc_us_city, l.spons_dfe_city));
	the_state := IF(SELF.mail_addr,
	                l.spons_dfe_state,
								  IF(l.spons_dfe_loc_us_state != '', l.spons_dfe_loc_us_state, l.spons_dfe_state));
	the_zip := IF(SELF.mail_addr,
	              l.spons_dfe_zip_code[1..5],
								IF(l.spons_dfe_loc_us_zip != '', l.spons_dfe_loc_us_zip[1..5], l.spons_dfe_zip_code[1..5]));
	SELF.spons_prep_addr_line_last := Address.Addr2FromComponents(the_city, the_state, the_zip);

	SELF							 						 := l;
	SELF 													 := [];
END;

#end

IRS5500_update := PROJECT(f_ded, Slim(LEFT));

// The THOR fix takes care of all old data not having the prep lines filled... just need to simply
// bring in the base file now. (11/21/13 AJ)
IRS5500_Prev_base := IRS5500.File_IRS5500_Base_AID;

IRS5500_Base := IRS5500_update + 
								IRS5500_Prev_base;

NID.Mac_CleanFullNames(IRS5500_Base, IRS5500_cleaned, SPONS_SIGNED_NAME);

IRS5500.Layout_IRS5500_AID add_clean_name(IRS5500_cleaned L) := TRANSFORM
	SELF.spons_sign_title 		 := l.cln_title;
	SELF.spons_sign_fname 		 := l.cln_fname;
	SELF.spons_sign_mname 		 := l.cln_mname;
	SELF.spons_sign_lname 		 := l.cln_lname;
	SELF.spons_sign_suffix 		 := l.cln_suffix;
	SELF.spons_sign_name_score := 0;

	SELF := L;
END;

IRS5500_Base_w_cleannames := PROJECT(IRS5500_cleaned, add_clean_name(LEFT));

//*** Applying AID macro to clean the addresses.
HasAddress	:=	trim(IRS5500_Base_w_cleannames.spons_prep_addr_line_last, left,right) != '';
								
dPrep_file_With_address			:= IRS5500_Base_w_cleannames(HasAddress);
dPrep_file_Without_address	:= IRS5500_Base_w_cleannames(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dPrep_file_With_address, spons_prep_addr_line1, spons_prep_addr_line_last, Raw_AID, dCleaned_withAID, lFlags);

IRS5500_CleanedAddr := project(
	dCleaned_withAID
	,transform(
		IRS5500.Layout_IRS5500_AID
		,
		self.ace_aid							:= left.aidwork_acecache.aid					;
		self.raw_aid							:= left.aidwork_rawaid								;
				
		self.spons_prim_range			:= left.aidwork_acecache.prim_range	;
		self.spons_predir					:= left.aidwork_acecache.predir			;
		self.spons_prim_name			:= left.aidwork_acecache.prim_name	;
		self.spons_addr_suffix		:= left.aidwork_acecache.addr_suffix;
		self.spons_postdir				:= left.aidwork_acecache.postdir		;
		self.spons_unit_desig			:= left.aidwork_acecache.unit_desig	;
		self.spons_sec_range			:= left.aidwork_acecache.sec_range	;
		self.spons_p_city_name		:= left.aidwork_acecache.p_city_name;
		self.spons_v_city_name		:= left.aidwork_acecache.v_city_name;
		self.spons_st							:= left.aidwork_acecache.st					;
		self.spons_zip5						:= left.aidwork_acecache.zip5				;
		self.spons_zip4						:= left.aidwork_acecache.zip4				;
		self.spons_cart						:= left.aidwork_acecache.cart				;
		self.spons_cr_sort_sz			:= left.aidwork_acecache.cr_sort_sz	;
		self.spons_lot						:= left.aidwork_acecache.lot				;
		self.spons_lot_order			:= left.aidwork_acecache.lot_order	;
		self.spons_dpbc						:= left.aidwork_acecache.dbpc				;
		self.spons_chk_digit			:= left.aidwork_acecache.chk_digit	;
		self.spons_rec_type				:= left.aidwork_acecache.rec_type		;
		self.spons_county					:= left.aidwork_acecache.county			;
		self.spons_geo_lat				:= left.aidwork_acecache.geo_lat		;
		self.spons_geo_long				:= left.aidwork_acecache.geo_long		;
		self.spons_msa						:= left.aidwork_acecache.msa				;
		self.spons_geo_match			:= left.aidwork_acecache.geo_match	;
		self.spons_err_stat				:= left.aidwork_acecache.err_stat		;	

		self											:= left															;
	)
)
+ project(dPrep_file_Without_address, transform(IRS5500.Layout_IRS5500_AID, self := left, self := []));
//*** End of AID.
tempLayout	:=	record
	IRS5500.Layout_IRS5500_AID;
	string2 	source;
end;

BaseFile	:=	project(IRS5500_CleanedAddr,transform(templayout,self.source := MDR.sourceTools.src_IRS_5500; self	:= LEFT;));

// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(BaseFile, IRS5500_Base_BDID_Init,
																	FALSE, bdid,
																	FALSE, MDR.sourceTools.src_IRS_5500,
																	TRUE, document_locator_number,
																	sponsor_dfe_name,
																	spons_prim_range, spons_prim_name, spons_sec_range, spons_zip5,
																	TRUE, spon_dfe_phone_num,
																	TRUE, ein,
																	TRUE, document_locator_number
																	);
																	
BDID_Matchset := ['A'];

Business_Header_SS.MAC_Add_BDID_Flex(IRS5500_Base_BDID_Init,
                                  BDID_Matchset,
                                  sponsor_dfe_name,
                                  spons_prim_range, spons_prim_name, spons_zip5,
                                  spons_sec_range, spons_st,
                                  spon_dfe_phone_num, ein,
                                  bdid, tempLayout,
                                  FALSE, BDID_score_field,
                                  IRS5500_Base_BDID_Rematch,
																	,,,BIPV2.xlink_version_set,,,
																	spons_p_city_name,spons_sign_fname,
																	spons_sign_mname,spons_sign_lname
														      ,									// Contact_SSN
																	,source						// Source  MDR.sourceTools
																	,source_rec_id		//Source_Reccord_Id
																	,true							//Src_Matching_is_priorty
																	);

IRS5500_Base_BDID_ALL_proj := PROJECT(IRS5500_Base_BDID_Rematch, IRS5500.Layout_IRS5500_AID);

IRS5500_Base_BDID_All_sort := sort(distribute(IRS5500_Base_BDID_ALL_proj, hash(document_locator_number)),
															     document_locator_number, source_rec_id, local);

IRS5500.Layout_IRS5500_AID rollupIRS(IRS5500.Layout_IRS5500_AID L, IRS5500.Layout_IRS5500_AID R) := TRANSFORM
	SELF.source_rec_id := IF(L.source_rec_id = 0, R.source_rec_id, L.source_rec_id);

	SELF := L;
END;

NewBase := ROLLUP(IRS5500_Base_BDID_All_sort,
								  rollupIRS(LEFT, RIGHT),
								  document_locator_number,
								  LOCAL);

ut.MAC_Append_Rcid(NewBase,Source_rec_id,out_file);

//OUTPUT(IRS5500_Base_BDID_All,, '~thor_data400::BASE::IRS5500_' + IRS5500.Version, OVERWRITE);
PromoteSupers.MAC_SF_BuildProcess(out_file,'~thor_data400::base::irs5500',do1,3,,true);

return do1;

end;

