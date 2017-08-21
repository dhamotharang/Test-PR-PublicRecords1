IMPORT PRTE2_FCC, FCC, PRTE2, ut, PromoteSupers, Address, STD;

//Input
	dMain := PRTE2_FCC.Files.FCC_in;
	
//Base file - keeps consistent sequence by only sequencing new records
	dMainBase := PRTE2_FCC.Files.FCC_base_ext;

//Project to expected base layout which includes clean name/address fields
	PRTE2_FCC.Layouts.FCC_Base_ext CleanFields(dMain L) := TRANSFORM
		//Clean Attention line name
		tempName 													:= Address.CleanPersonFML73(L.LICENSEES_ATTENTION_LINE);

		SELF.licensees_phone              := ut.CleanPhone(L.licensees_phone);
		SELF.contact_firms_phone_number   := ut.CleanPhone(L.contact_firms_phone_number);
		SELF.contact_firms_fax_number     := ut.CleanPhone(L.contact_firms_fax_number);
		SELF.attention_title		         	:= tempName[1..5];
		SELF.attention_fname	            := tempName[6..25];
		SELF.attention_mname	            := tempName[26..45];
		SELF.attention_lname		         	:= tempName[46..65];
		SELF.attention_name_suffix	      := tempName[66..70];
		SELF.attention_name_score  	      := tempName[71..73];
		prep_line1_licensees			 	      := ut.CleanSpacesAndUpper(L.LICENSEES_STREET);
		prep_line_last_licensees		      := address.Addr2FromComponents(L.LICENSEES_CITY, L.LICENSEES_STATE, L.LICENSEES_ZIP[1..5]);
		TempLicAddr												:= Address.CleanAddress182(prep_line1_licensees, prep_line_last_licensees);
		SELF.prim_range										:= TempLicAddr[1..10];
		SELF.predir												:= TempLicAddr[11..12];
		SELF.prim_name										:= TempLicAddr[13..40];
		SELF.addr_suffix									:= TempLicAddr[41..44];
		SELF.postdir											:= TempLicAddr[45..46];
		SELF.unit_desig										:= TempLicAddr[47..56];
		SELF.sec_range										:= TempLicAddr[57..64];
		SELF.p_city_name									:= TempLicAddr[65..89];
		SELF.v_city_name									:= TempLicAddr[90..114];
		SELF.st														:= TempLicAddr[115..116];
		SELF.zip5													:= TempLicAddr[117..121];
		SELF.zip4													:= TempLicAddr[122..125];
		SELF.cart													:= TempLicAddr[126..129];
		SELF.cr_sort_sz										:= TempLicAddr[130];
		SELF.lot													:= TempLicAddr[131..134];
		SELF.lot_order										:= TempLicAddr[135];
		SELF.dpbc													:= TempLicAddr[136..137];
		SELF.chk_digit										:= TempLicAddr[138];
		SELF.addr_rec_type								:= TempLicAddr[139..140];
		SELF.fips_state										:= TempLicAddr[141..142];
 		SELF.fips_county									:= TempLicAddr[143..145];
		SELF.geo_lat											:= TempLicAddr[146..155];
		SELF.geo_long											:= TempLicAddr[156..166];
		SELF.cbsa													:= TempLicAddr[167..170];
		SELF.geo_blk											:= TempLicAddr[171..177];
		SELF.geo_match										:= TempLicAddr[178];
		SELF.err_stat											:= TempLicAddr[179..182];
		SELF.clean_licensees_name  				:= ut.CleanSpacesAndUpper(L.licensees_name);
    SELF.clean_DBA_name        				:= ut.CleanSpacesAndUpper(L.DBA_name);
    SELF.clean_firm_name       				:= ut.CleanSpacesAndUpper(L.firm_preparing_application);
		prep_line1_firm     			 	      := ut.CleanSpacesAndUpper(L.CONTACT_FIRMS_STREET_ADDRESS);
		prep_line_last_firm     		      := address.Addr2FromComponents(L.CONTACT_FIRMS_CITY, L.CONTACT_FIRMS_STATE, L.CONTACT_FIRMS_ZIPCODE[1..5]);
		TempFirmAddr											:= Address.CleanAddress182(prep_line1_firm, prep_line_last_firm);
		SELF.firm.prim_range			        := TempFirmAddr[1..10];
	  SELF.firm.predir					        := TempFirmAddr[11..12];
	  SELF.firm.prim_name			          := TempFirmAddr[13..40];
	  SELF.firm.addr_suffix		          := TempFirmAddr[41..44];
	  SELF.firm.postdir				          := TempFirmAddr[45..46];
	  SELF.firm.unit_desig			        := TempFirmAddr[47..56];
	  SELF.firm.sec_range			          := TempFirmAddr[57..64];
	  SELF.firm.p_city_name		          := TempFirmAddr[65..89];
	  SELF.firm.v_city_name		          := TempFirmAddr[90..114];
	  SELF.firm.st							        := TempFirmAddr[115..116];
	  SELF.firm.zip5						        := TempFirmAddr[117..121];
	  SELF.firm.zip4						        := TempFirmAddr[122..125];
	  SELF.firm.cart						        := TempFirmAddr[126..129];
	  SELF.firm.cr_sort_sz			        := TempFirmAddr[130];
	  SELF.firm.lot						          := TempFirmAddr[131..134];
	  SELF.firm.lot_order			          := TempFirmAddr[135];
	  SELF.firm.dpbc						        := TempFirmAddr[136..137];
	  SELF.firm.chk_digit			          := TempFirmAddr[138];
		SELF.firm.addr_rec_type						:= TempLicAddr[139..140];
		SELF.firm.fips_state 		          := TempFirmAddr[141..142];
	  SELF.firm.fips_county		          := TempFirmAddr[143..145];
	  SELF.firm.geo_lat				          := TempFirmAddr[146..155];
	  SELF.firm.geo_long				        := TempFirmAddr[156..166];
	  SELF.firm.cbsa						        := TempFirmAddr[167..170];
	  SELF.firm.geo_blk				          := TempFirmAddr[171..177];
	  SELF.firm.geo_match			          := TempFirmAddr[178];
	  SELF.firm.err_stat				        := TempFirmAddr[179..182];
		SELF.licensee_bdid								:= IF(TRIM(L.FEIN) <> '',Prte2.fn_AppendFakeID.bdid(SELF.clean_licensees_name, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip5, l.cust_name),0);
		SELF.dba_bdid											:= IF(TRIM(L.DBA_NAME) <> '',Prte2.fn_AppendFakeID.bdid(SELF.clean_DBA_name, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip5, l.cust_name),0);
		SELF.firm_bdid										:= IF(TRIM(L.firm_preparing_application) <> '',
																					Prte2.fn_AppendFakeID.bdid(SELF.clean_firm_name, self.firm.prim_range, self.firm.prim_name, self.firm.v_city_name, self.firm.st, self.firm.zip5, l.cust_name),0);
		SELF.attention_did								:= IF(TRIM(L.LICENSEES_ATTENTION_LINE) <> '',
																					Prte2.fn_AppendFakeID.did(SELF.attention_fname, SELF.attention_lname, L.ATTENTION_SSN, L.ATTENTION_DOB, L.CUST_NAME),0);
		//Appending linkid(s)
		vLinkingIds := prte2.fn_AppendFakeID.LinkIds(self.clean_licensees_name, L.FEIN, L.INC_DATE, self.prim_range, self.prim_name, self.sec_range, self.v_city_name, self.st, self.zip5, L.cust_name);
		SELF.powid	:= vLinkingIds.powid;
		SELF.proxid	:= vLinkingIds.proxid;
		SELF.seleid	:= vLinkingIds.seleid;
		SELF.orgid	:= vLinkingIds.orgid;
		SELF.ultid	:= vLinkingIds.ultid;
		
		SELF										          := L;
	END;
	
	pMainClean	:= PROJECT(dMain, CleanFields(LEFT));
	
	//Populate BIP fields
	
	
/* For future use
 FCC.File_FCC_base_bip Persist_SRCRecID(pMainClean L, dMainBase R) := transform
    self.source_rec_id := r.source_rec_id;
    self := l;
  end;

  //Join the update file with the base file for source_rec_id persistence 
  ds_with_srcid := join(distribute(pMainClean,hash(unique_key)),
								        distribute(dMainBase,hash(unique_key)),
								        left.unique_key=right.unique_key,
								        Persist_SRCRecID(left,right),
								        left outer,
								        local);
*/

	//Populate FCC_SEQ
	ut.MAC_Sequence_Records(pMainClean,fcc_seq,with_seq);

	//Add the source_rec_id
  ut.MAC_Append_Rcid(with_seq, source_rec_id, full_file_recid);
	
	PromoteSupers.Mac_SF_BuildProcess(full_file_recid, Constants.BASE_PREFIX + 'fcc', build_base);
	
EXPORT proc_build_base	:= build_base;

