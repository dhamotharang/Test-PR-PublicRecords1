﻿/* *****************************************************************************************
PRTE2_Gong_Ins.Fn_Spray_And_Build_BaseMain
***************************************************************************************** */

IMPORT ut, RoxieKeyBuild, Address, PRTE2, PRTE2_Common,PromoteSupers;

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

			// PRTE2.CleanFields(Files.SPRAYED_DS, new_CSV_Base);
			new_CSV_Base := Files.SPRAYED_DS;
			
			// appendIf5 := PRTE2_Common.Functions.appendIf5;
			// *********************************************************************************************************************
			// transform data of CSV usinf clean address (simulate action of RMPO on request sent).
			// *********************************************************************************************************************
			Layouts.Alpha_CSV_Layout Clean_Address_Transform(new_CSV_Base L) := TRANSFORM

				// WHAT FIELDS TO INITIALIZE IN GONG?

				// cleanAddress	:= PRTE2_Common.Clean_Address.FromLine(L.address1, L.p_city_name, L.state, L.zip5, L.zip4);
				// SELF.address1 := Address.Addr1FromComponents(cleanAddress.prim_range,cleanAddress.predir,cleanAddress.prim_name,
															// cleanAddress.addr_suffix,cleanAddress.postdir,cleanAddress.unit_desig,cleanAddress.sec_range);
				// SELF.prim_range		:=	cleanAddress.prim_range;		//string10
				// SELF.predir					:=	cleanAddress.predir;				//string2
				// SELF.prim_name			:=	cleanAddress.prim_name;			//string28
				// SELF.addr_suffix		:=	cleanAddress.addr_suffix;		//string4
				// SELF.postdir				:=	cleanAddress.postdir;				//string2
				// SELF.unit_desig		:=	cleanAddress.unit_desig;		//string10
				// SELF.sec_range			:=	cleanAddress.sec_range;			//string8
				// SELF.p_city_name		:=	cleanAddress.v_city_name;		//string25
				// SELF.v_city_name		:=	cleanAddress.v_city_name;		//string25
				// SELF.state						:=	cleanAddress.st;						//string2
				// SELF.zip5						:=	cleanAddress.zip;						//string5
				// SELF.zip4						:=	cleanAddress.zip4;					//string4
				// SELF.cart						:=	cleanAddress.cart;					//string4
				// SELF.cr_sort_sz		:=	cleanAddress.cr_sort_sz;		//string1
				// SELF.lot							:=	cleanAddress.lot;						//string4
				// SELF.lot_order			:=	cleanAddress.lot_order;			//string1
				// SELF.dpbc						:=	cleanAddress.dbpc;					//string2
				// SELF.chk_digit			:=	cleanAddress.chk_digit;			//string1
				// SELF.rec_type				:=	cleanAddress.rec_type;			//string2
				// SELF.ace_fips_st 	:=	cleanAddress.fips_state;		//string2
				// SELF.ace_fips_county 	:=	cleanAddress.fips_county;		//string3
				// SELF.geo_lat 				:=	cleanAddress.geo_lat;				//string10
				// SELF.geo_long 			:=	cleanAddress.geo_long;			//string11
				// SELF.msa							:=	cleanAddress.msa;						//string4
				// SELF.geo_blk				:=	cleanAddress.geo_blk;				//string7
				// SELF.geo_match			:=	cleanAddress.geo_match;			//string1
				// SELF.err_stat				:=	cleanAddress.err_stat;			//string4
				// all of the following should leave existing records as-is
				SELF := L;
				SELF := [];
			END;

			newBase := PROJECT(new_CSV_Base, Clean_Address_Transform(LEFT) );

			//???? WHICH SUPER FILE TO USE?
			PromoteSupers.Mac_SF_BuildProcess(newBase, Files.Gong_Base_SF, buildBase);
			// RoxieKeyBuild.Mac_SF_BuildProcess_V2(newBase,
																					 // Files.BASE_PREFIX_NAME, 
																					 // Files.AllData_Suffix,
																					 // fileVersion, buildBase, 3,
																					 // false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);

			// --------------------------------------------------
			finalNewBase := Files.Gong_Base_SF_DS;
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildBase,
															delSprayedFile, output(finalNewBase)
															);

			RETURN sequentialSteps;

END;