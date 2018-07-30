/* *********************************************************************************************
	PRTE2_Liens_Ins.fSprays
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins,LiensV2, PromoteSupers, PRTE2_Common, Address, PRTE2_Common;

EXPORT fSprays := MODULE


	//***************************************************************************************************************************
	// Main doesn't need initialization or transformation EXCEPT we flag all records to have bcbflag:=TRUE
	//***************************************************************************************************************************
	EXPORT fSpray_Main (STRING CSVName) := FUNCTION

			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								Constants.SourcePathForCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Group(),									// destination THOR cluster
																								Files.main_TmpFile_Name,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								TRUE												  			// compress
																								);																					 

			//***********************************************************************************************
			//**** Any preprocessing needed? *****************************************************************
			//***********************************************************************************************
			newMainData0 := Files.main_TmpFile_DS;
			newMainData := PROJECT(newMainData0,TRANSFORM({newMainData0},SELF.bcbflag:=TRUE, SELF := LEFT));
			//***********************************************************************************************
			// newMainData := PROJECT(Files.main_TmpFile_DS,tBaseStatus(LEFT));
			//TODO - I think we need to intialize some fields in there too.
			// No let's leave the "IN" file in the raw layout, then do the TRANSFORM above before writing the final base file.
			// 		The IN file will be the pure CSV file, the BASE file then will be the Boca Compatible base file
			//    and BASE is prepared by second step after the spray PRTE2_Liens_Ins.proc_build_base
			//***********************************************************************************************
			
			// PRTE2_Common.Mac_SF_BuildProcess(newMainData, Files.Main_IN_Name, build_main_in,,TargetCluster);		// BUGGY
			PromoteSupers.Mac_SF_BuildProcess(newMainData, Files.Main_IN_Name, build_main_in);
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.main_TmpFile_Name);
			RETURN SEQUENTIAL( sprayFile, build_main_in, delSprayedFile );
			
	END;
	//***************************************************************************************************************************



	//***************************************************************************************************************************
	// PARTY needs initialization - Address cleaning, name fields, etc
	//***************************************************************************************************************************
	EXPORT fSpray_Party(STRING CSVName)  := FUNCTION

			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								Constants.SourcePathForCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Group(),									// destination THOR cluster
																								Files.party_TmpFile_Name,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								TRUE												  			// compress
																								);																					 

			//**** Any preprocessing needed *****************************************************************
			// see proc_build_base for persistent_record_id generation - those are the primary fields to start with
			//***********************************************************************************************
			newpartyData := PRTE2_Common.mac_ConvertToUpperCase(Files.party_TmpFile_DS , fname, mname, lname);
			FinalPartyData := PROJECT(newpartyData,
																	TRANSFORM({newpartyData},
																			// ------------------ clean / prepare name fields ----------------------
																				TempPname					:= Address.CleanPersonFML73(LEFT.orig_full_debtorname);

																				// If data team has filled in the main name fields don't replace them.
																				self.title				:= IF(LEFT.title<>'',LEFT.title,TempPname[1..5]);
																				self.fname				:= IF(LEFT.fname<>'',LEFT.fname,TempPname[6..25]);
																				self.mname				:= IF(LEFT.mname<>'',LEFT.mname,TempPname[26..45]);
																				self.lname				:= IF(LEFT.lname<>'',LEFT.lname,TempPname[46..65]);
																				self.name_suffix	:= IF(LEFT.name_suffix<>'',LEFT.name_suffix, TempPname[66..70]);
																				
																				self.name_score		:= TempPname[71..73];
																				SELF.orig_name 		:= ''; 	// not used.
																				SELF.orig_fname 	:= IF(LEFT.orig_fname<>'',LEFT.orig_fname,SELF.fname);
																				SELF.orig_mname 	:= IF(LEFT.orig_mname<>'',LEFT.orig_mname,SELF.mname);
																				SELF.orig_lname 	:= IF(LEFT.orig_lname<>'',LEFT.orig_lname,SELF.lname);
																				SELF.orig_suffix	:= IF(LEFT.orig_suffix<>'',LEFT.orig_suffix,SELF.name_suffix);

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
																	)
																);
			//***********************************************************************************************
			PromoteSupers.Mac_SF_BuildProcess(FinalPartyData, Files.party_IN_Name, build_party_in);
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.party_TmpFile_Name);
			RETURN SEQUENTIAL( sprayFile, build_party_in, delSprayedFile );
	END;
	//***************************************************************************************************************************

// Not needed?
	// EXPORT fSpray_Status() := FUNCTION
	// END;

END;