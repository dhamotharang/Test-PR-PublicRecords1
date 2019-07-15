// PRTE2_Phonesplus_Ins.Fn_Spray_And_Build_BaseMain

// *** someday, we should redo Fn_Spray_And_Build_BaseMain to split out a Build_base attribute

IMPORT ut, RoxieKeyBuild, Address, PRTE2_Common;

EXPORT Fn_Spray_And_Build_BaseMain(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION
			SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,						// file LZ
																								SourcePathForCSV+CSVName, 					// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Group(),									// destination THOR cluster
																								Files.FILE_SPRAY,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 

			new_CSV_Base := PRTE2_Common.mac_ConvertToUpperCase(Files.SPRAYED_DS, fname, mname, lname);
			appendIf5 := PRTE2_Common.Functions.appendIf5;
			// *********************************************************************************************************************
			// transform data of CSV usinf clean address (simulate action of RMPO on request sent).
			// *********************************************************************************************************************
			Layouts.Alpha_CSV_Layout Clean_Address_Transform(new_CSV_Base L) := TRANSFORM
				STODAY 	:= PRTE2_Common.Constants.TodayString;																						// if it's a new record use today
				ExistDay := (STRING) IF(L.datelastseen=0,L.datevendorfirstreported,L.datelastseen)+'01';		// if existing, use best last date
				TODAY	:= (STRING) IF(ExistDay='',STODAY,ExistDay);
				TODAY6	:= (INTEGER3) TODAY[1..6];
				todayLess30_6				:= (INTEGER3) (ut.date_math(TODAY,-30)[1..6]);
				todayLess2y_6				:= (INTEGER3) (ut.date_Math(TODAY,365*-2)[1..6]);
				todayLess3y_6				:= (INTEGER3) (ut.date_Math(TODAY,365*-3)[1..6]);

				// I am splitting out the add process so don't fill in too many fields for the full update process here.
				
				// SELF.datevendorfirstreported := IF(L.datevendorfirstreported=0,todayLess2y_6,L.datevendorfirstreported);
				// SELF.datevendorlastreported := IF(L.datevendorlastreported=0,TODAY6,L.datevendorlastreported);
				// SELF.datefirstseen := IF(L.datefirstseen=0,todayLess3y_6,L.datefirstseen);
				// SELF.datelastseen := IF(L.datelastseen=0,todayLess30_6,L.datelastseen);
				
				cleanAddress	:= PRTE2_Common.Clean_Address.FromLine(L.address1, L.p_city_name, L.state, L.zip5, L.zip4);
				SELF.address1 := Address.Addr1FromComponents(cleanAddress.prim_range,cleanAddress.predir,cleanAddress.prim_name,
															cleanAddress.addr_suffix,cleanAddress.postdir,cleanAddress.unit_desig,cleanAddress.sec_range);
				SELF.prim_range		:=	cleanAddress.prim_range;		//string10
				SELF.predir					:=	cleanAddress.predir;				//string2
				SELF.prim_name			:=	cleanAddress.prim_name;			//string28
				SELF.addr_suffix		:=	cleanAddress.addr_suffix;		//string4
				SELF.postdir				:=	cleanAddress.postdir;				//string2
				SELF.unit_desig		:=	cleanAddress.unit_desig;		//string10
				SELF.sec_range			:=	cleanAddress.sec_range;			//string8
				SELF.p_city_name		:=	cleanAddress.v_city_name;		//string25
				SELF.v_city_name		:=	cleanAddress.v_city_name;		//string25
				SELF.state						:=	cleanAddress.st;						//string2
				SELF.zip5						:=	cleanAddress.zip;						//string5
				SELF.zip4						:=	cleanAddress.zip4;					//string4
				SELF.cart						:=	cleanAddress.cart;					//string4
				SELF.cr_sort_sz		:=	cleanAddress.cr_sort_sz;		//string1
				SELF.lot							:=	cleanAddress.lot;						//string4
				SELF.lot_order			:=	cleanAddress.lot_order;			//string1
				SELF.dpbc						:=	cleanAddress.dbpc;					//string2
				SELF.chk_digit			:=	cleanAddress.chk_digit;			//string1
				SELF.rec_type				:=	cleanAddress.rec_type;			//string2
				SELF.ace_fips_st 	:=	cleanAddress.fips_state;		//string2
				SELF.ace_fips_county 	:=	cleanAddress.fips_county;		//string3
				SELF.geo_lat 				:=	cleanAddress.geo_lat;				//string10
				SELF.geo_long 			:=	cleanAddress.geo_long;			//string11
				SELF.msa							:=	cleanAddress.msa;						//string4
				SELF.geo_blk				:=	cleanAddress.geo_blk;				//string7
				SELF.geo_match			:=	cleanAddress.geo_match;			//string1
				SELF.err_stat				:=	cleanAddress.err_stat;			//string4
				// all of the following should leave existing records as-is
				T_origname			:= appendIf5(L.title,L.fname,L.mname,L.lname,L.name_suffix);
				SELF.origname			:= IF(L.origname='',T_origname,L.origname);
				SELF.did 						:= IF(L.did=0,L.l_did,L.did);
				// SELF.name_score		:= IF(L.name_score='','98',L.name_score);
				// SELF.did_score			:= IF(L.did_score='','98',L.did_score);
				// SELF.src							:= IF(L.src='','EQ',L.src);
				// SELF.glb_dppa_flag		:= IF(L.glb_dppa_flag='','G',L.glb_dppa_flag);
				SELF := L;
				SELF := [];
			END;

			newBase := PROJECT(new_CSV_Base, Clean_Address_Transform(LEFT) );

			// This macro is what builds the super files with generations: QA, Father, Grandfather
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(newBase,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.AllData_Suffix,
																					 fileVersion, buildBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);

			// --------------------------------------------------
			finalNewBase := Files.PhonesPlus_Base_SF_DS;
			// ShowResults := CHOOSEN(finalNewBase, 200);	// Testing purpose only.
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildBase,
															delSprayedFile/*,
															OUTPUT(ShowResults)*/
															);

			RETURN sequentialSteps;

END;