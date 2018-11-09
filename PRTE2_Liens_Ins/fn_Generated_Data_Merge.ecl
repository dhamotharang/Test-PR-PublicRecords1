/* ************************************************************************************************
anything used in proc_build_base but not populated in Linda's data?
************************************************************************************************ */

IMPORT Address,PRTE2_Liens_Ins,PromoteSupers,PRTE2_Common;

EXPORT fn_Generated_Data_Merge(BOOLEAN UseProdData=TRUE) := FUNCTION
	//***********************************************************************************************
	// Linda's Main generated - I'm trusting she filled in bug_num and cust_name
	//***********************************************************************************************
			newMainData := Files.TmpGeneratedMAIN_DS;		
			// existingMain := IF(UseProdData, Files.Main_IN_DS_Prod, Files.Main_IN_DS);
			existingMain := Files.Main_IN_DS;
			gen_MainData := PROJECT(newMainData,
															TRANSFORM({PRTE2_Liens_Ins.Layouts.BaseMain_in_raw},
															SELF.bcbflag:=TRUE, 
															SELF := LEFT,
															SELF := [])
														);

			ALL_MainData := gen_MainData+existingMain;
	//***********************************************************************************************
	// Linda's Party generated - I'm trusting she filled in bug_num and cust_name
	//***********************************************************************************************
			newpartyData := Files.TmpGeneratedPARTY_DS;
			// existingParty := IF(UseProdData, Files.Party_IN_DS_Prod, Files.Party_IN_DS);
			existingParty := Files.Party_IN_DS;
			gen_PartyData := PROJECT(newpartyData,
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

			ALL_PartyData := gen_PartyData+existingParty;
																
		//***********************************************************************************************
		PromoteSupers.Mac_SF_BuildProcess(ALL_MainData, Files.Main_IN_Name, build_main_in);		
		PromoteSupers.Mac_SF_BuildProcess(ALL_PartyData, Files.party_IN_Name, build_party_in);
		//***********************************************************************************************
		RETURN SEQUENTIAL(build_main_in,build_party_in);
END;