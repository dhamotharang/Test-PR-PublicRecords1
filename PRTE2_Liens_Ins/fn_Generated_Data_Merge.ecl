/* ************************************************************************************************
PRTE2_Liens_Ins.fn_Generated_Data_Merge
  Is there anything used in proc_build_base but not populated in Linda's data?  Keep looking...

Dec 2018, for new data, use Boca Hash to set Persistent_Record_ID field so it can be used for Dempsey
************************************************************************************************ */

IMPORT Address,PRTE2_Liens_Ins,PromoteSupers,PRTE2_Common;

EXPORT fn_Generated_Data_Merge(BOOLEAN UseProdData=TRUE) := FUNCTION
	//***********************************************************************************************
	// Linda's Main generated - I'm trusting she filled in bug_num and cust_name
	//***********************************************************************************************
			newMainData := Files.TmpGeneratedMAIN_DS;		
			existingMain := IF(UseProdData, Files.Main_IN_DS_Prod, Files.Main_IN_DS);
			// existingMain := Files.Main_IN_DS_Prod;
			gen_MainData1 := PROJECT(newMainData,
															TRANSFORM({PRTE2_Liens_Ins.Layouts.BaseMain_in_raw},
															SELF.bcbflag:=TRUE, 
															SELF := LEFT,
															SELF := [])
														);
			// do this after all the fields got populated as well as possible, and the file is in the "IN" layout.
			// TMP CALC ALL - if we activate these, have to change the existing gen_MainData1 above to gen_MainData1a
			// gen_MainData1 := gen_MainData1a+existingMain;		//TMP CALC ALL
			gen_MainData := PROJECT(gen_MainData1,
															TRANSFORM({gen_MainData1},
															SELF.persistent_record_id := 	HASH64(trim(LEFT.tmsid,left,right)+ ','+
																		trim(LEFT.rmsid,left,right)+  ','+
																		trim(LEFT.record_code,left,right)+  ','+
																		trim(LEFT.date_vendor_removed ,left,right)+  ','+
																		trim(LEFT.filing_jurisdiction,left,right)+  ','+
																		trim(LEFT.filing_state ,left,right)+  ','+
																		trim(LEFT.orig_filing_number ,left,right)+  ','+
																		trim(LEFT.orig_filing_type ,left,right)+  ','+
																		trim(LEFT.orig_filing_date ,left,right)+  ','+
																		trim(LEFT.orig_filing_time ,left,right)+ ','+ 
																		trim(LEFT.case_number   ,left,right)+  ','+
																		trim(LEFT.filing_number ,left,right)+  ','+
																		trim(LEFT.filing_type_desc ,left,right)+  ','+
																		trim(LEFT.filing_date ,left,right)+  ','+
																		trim(LEFT.filing_time ,left,right)+  ','+
																		trim(LEFT.vendor_entry_date ,left,right)+  ','+
																		trim(LEFT.judge ,left,right)+  ','+
																		trim(LEFT.case_title ,left,right)+  ','+
																		trim(LEFT.filing_book ,left,right)+  ','+
																		trim(LEFT.filing_page ,left,right)+  ','+
																		trim(LEFT.release_date ,left,right)+  ','+
																		trim(LEFT.amount ,left,right)+  ','+
																		trim(LEFT.eviction ,left,right)+  ','+
																		trim(LEFT.satisifaction_type ,left,right)+  ','+
																		trim(LEFT.judg_satisfied_date ,left,right)+  ','+
																		trim(LEFT.judg_vacated_date ,left,right)+  ','+
																		trim(LEFT.tax_code ,left,right)+  ','+
																		trim(LEFT.irs_serial_number ,left,right)+  ','+
																		trim(LEFT.effective_date ,left,right)+  ','+
																		trim(LEFT.lapse_date ,left,right)+  ','+
																		trim(LEFT.accident_date ,left,right)+  ','+
																		trim(LEFT.sherrif_indc ,left,right)+  ','+
																		trim(LEFT.expiration_date ,left,right)+  ','+
																		trim(LEFT.agency ,left,right)+  ','+
																		trim(LEFT.agency_city ,left,right)+  ','+
																		trim(LEFT.agency_state ,left,right)+  ','+
																		trim(LEFT.agency_county ,left,right)+  ','+
																		trim(LEFT.legal_lot ,left,right)+  ','+
																		trim(LEFT.legal_block ,left,right)+  ','+
																		trim(LEFT.legal_borough ,left,right)+  ','+
																		trim(LEFT.certificate_number ,left,right)+ ','+
																		trim(LEFT.filing_status ,left,right)+trim(LEFT.filing_status_desc,left,right)),
															SELF := LEFT));
			// ALL_MainData := gen_MainData;				//TMP CALC ALL if activate this, then comment the line below
			ALL_MainData := gen_MainData+existingMain;
	//***********************************************************************************************
	// Linda's Party generated - I'm trusting she filled in bug_num and cust_name, and DID
	//***********************************************************************************************
			newpartyData := Files.TmpGeneratedPARTY_DS;
			existingParty := IF(UseProdData, Files.Party_IN_DS_Prod, Files.Party_IN_DS);

			gen_PartyData1 := PROJECT(newpartyData,
																	TRANSFORM({PRTE2_Liens_Ins.Layouts.Baseparty_in},
																			SELF.xBug_num := LEFT.Bug_Num;
																			SELF.xSponsor := LEFT.cust_name;
																			// ------------------ clean / prepare name fields ----------------------
																			TempPname					:= Address.CleanPersonFML73(LEFT.orig_full_debtorname);
																			self.title				:= TempPname[1..5];
																			self.fname				:= TempPname[6..25];
																			self.mname				:= TempPname[26..45];
																			self.lname				:= TempPname[46..65];
																			self.name_suffix	:= IF(LEFT.orig_suffix <> '',LEFT.orig_suffix, TempPname[66..70]);
																			self.name_score		:= TempPname[71..73];
																			SELF.orig_name := ''; 	// not used.
																			SELF.orig_fname := IF(LEFT.orig_fname<>'',LEFT.orig_fname,SELF.fname);
																			SELF.orig_mname := IF(LEFT.orig_mname<>'',LEFT.orig_mname,SELF.mname);
																			SELF.orig_lname := IF(LEFT.orig_lname<>'',LEFT.orig_lname,SELF.lname);
																			SELF.orig_suffix := IF(LEFT.orig_suffix<>'',LEFT.orig_suffix,SELF.name_suffix);

																			// ------------------ no businesses so just blank fields ----------------------
																			self.cname				:= '';  	// IF(LEFT.orig_name = '', ut.CleanSpacesAndUpper(LEFT.orig_full_debtorname),'');
																			SELF.BDID 				:= '';		// no businesses
																			SELF.tax_id 			:= '';		// no businesses		// NOTE: SSN field is persons only, tax_id is business only. these are always separate
																			
																			// ------------------ clean address fields ----------------------
																			// (I believe if Address2 ever contains anything it is not City,state,zip but a continuation of the main address line.
																			MainAddressLine := PRTE2_Common.Functions.AppendIF(LEFT.orig_address1,LEFT.orig_address2);
																			MainZip := PRTE2_Common.Functions.appendIfz5z4(LEFT.orig_zip5,LEFT.orig_zip4);  // no separator, just merge together
																			MainCSZ := PRTE2_Common.Functions.appendIfCSZ(LEFT.orig_city,LEFT.orig_state,MainZip);
																			TempAddr					:= Address.CleanAddress182(MainAddressLine,MainCSZ);
																			self.prim_range 		:= TempAddr[1..10];
																			self.predir     		:= TempAddr[11..12];
																			self.prim_name			:= TempAddr[13..40];
																			self.addr_suffix		:= TempAddr[41..44];
																			self.postdir				:= TempAddr[45..46];
																			self.unit_desig			:= TempAddr[47..56];
																			self.sec_range			:= TempAddr[57..64];
																			self.p_city_name		:= TempAddr[65..89];
																			self.v_city_name		:= TempAddr[90..114];
																			self.st							:= TempAddr[115..116];
																			self.zip						:= TempAddr[117..121];
																			self.zip4						:= TempAddr[122..125];
																			self.cart						:= TempAddr[126..129];
																			self.cr_sort_sz			:= TempAddr[130];
																			self.lot						:= TempAddr[131..134];
																			self.lot_order			:= TempAddr[135];
																			self.dbpc						:= TempAddr[136..137];
																			self.chk_digit			:= TempAddr[138];
																			self.rec_type				:= TempAddr[139..140];
																			self.county					:= TempAddr[143..145];	
																			self.geo_lat				:= TempAddr[146..155];
																			self.geo_long				:= TempAddr[156..166];
																			self.msa						:= TempAddr[167..170];
																			self.geo_match			:= TempAddr[178];
																			self.err_stat				:= TempAddr[179..182];
																			self := LEFT;
																			SELF := [];
																	)
																);
			// do this after all the fields got populated as well as possible, and the file is in the "IN" layout.
			// TMP CALC ALL - if we activate these, have to change the existing gen_PartyData1 above to gen_PartyData1a
			// gen_PartyData1 := gen_PartyData1a+existingParty;				//TMP CALC ALL
			gen_PartyData := PROJECT(gen_PartyData1,TRANSFORM({gen_PartyData1},
												self.persistent_record_id := hash64(trim(LEFT.tmsid,left,right)+','+
																trim(LEFT.rmsid,left,right)+','+
																trim(LEFT.orig_full_debtorname,left,right)+','+
																trim(LEFT.orig_name ,left,right)+','+
																trim(LEFT.orig_lname,left,right)+','+
																trim(LEFT.orig_fname,left,right)+','+
																trim(LEFT.orig_mname ,left,right)+','+
																trim(LEFT.orig_suffix ,left,right)+','+
																trim(LEFT.tax_id ,left,right)+','+
																trim(LEFT.ssn ,left,right)+','+
																trim(LEFT.cname ,left,right)+','+
																trim(LEFT.orig_address1 ,left,right)+','+
																trim(LEFT.orig_address2 ,left,right)+','+
																trim(LEFT.orig_city ,left,right)+','+
																trim(LEFT.orig_state ,left,right)+','+
																trim(LEFT.orig_zip5 ,left,right)+','+
																trim(LEFT.orig_zip4 ,left,right)+','+
																trim(LEFT.orig_county ,left,right)+','+
																trim(LEFT.orig_country ,left,right)+','+
																trim(LEFT.phone ,left,right)+ ','+
																trim(LEFT.name_type ,left,right) +','+ trim(LEFT.bdid,left,right) +','+trim(LEFT.did,left,right)+','+trim(LEFT.zip,left,right)
																+trim(LEFT.fname,left,right)+','+trim(LEFT.lname,left,right)+','+trim(LEFT.mname,left,right)+','+trim(LEFT.name_suffix,left,right) +','+ trim(LEFT.zip4,left,right)); // orig name has multiple names 
												self := LEFT;
												));
			// ALL_PartyData := gen_PartyData;				//TMP CALC ALL if activate this, then comment the line below
			ALL_PartyData := gen_PartyData+existingParty;

																
		//***********************************************************************************************
		PromoteSupers.Mac_SF_BuildProcess(ALL_MainData, Files.Main_IN_Name, build_main_in);		
		PromoteSupers.Mac_SF_BuildProcess(ALL_PartyData, Files.party_IN_Name, build_party_in);
		//***********************************************************************************************
		RETURN SEQUENTIAL(build_main_in,build_party_in);
END;