/* *****************************************************************************************
PRTE2_Gong_Ins.Fn_Spray_And_Build_BaseMain
1. Spray the file
2. Create SF with Alpha CSV base file
3. Call proc to do any transforms and create final Boca file.
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
				// SELF.dual_name_flag						// N unless the listed name is 2 names like: JOHN & MARY SMITH
				SELF.listing_type_res := 'R';	// residential
				SELF.publish_code := 'P';			// ? public or private?

				SELF.omit_address := 'N';
				SELF.omit_phone		:= 'N';
				SELF.omit_locality := 'N';
				
				SELF.hhid := 0;
				SELF.bdid := 0;
				
				// Clean the address from the fields that the Alpha Data team uses
				cleanAddress	:= PRTE2_Common.Clean_Address.FromLine(L.address1, L.City, L.state, L.zip, '');
				SELF.address1 := Address.Addr1FromComponents(cleanAddress.prim_range,cleanAddress.predir,cleanAddress.prim_name,
															cleanAddress.addr_suffix,cleanAddress.postdir,cleanAddress.unit_desig,cleanAddress.sec_range);
				SELF.prim_range		:=	cleanAddress.prim_range;
				SELF.predir				:=	cleanAddress.predir;
				SELF.prim_name		:=	cleanAddress.prim_name;
				SELF.suffix				:=	cleanAddress.addr_suffix;
				SELF.postdir			:=	cleanAddress.postdir;
				SELF.unit_desig		:=	cleanAddress.unit_desig;
				SELF.sec_range		:=	cleanAddress.sec_range;
				SELF.p_city_name	:=	cleanAddress.v_city_name;
				SELF.v_city_name	:=	cleanAddress.v_city_name;
				// SELF.v_predir  		:=	cleanAddress.predir;			// NOTE the data Linda provided 
				// SELF.v_prim_name 	:=	cleanAddress.prim_name; 	// ALL of these v_* were blank
				// SELF.v_suffix 		:=	cleanAddress.addr_suffix; 	// Except v_city_name
				// SELF.v_postdir 		:=	cleanAddress.postdir;			// So we will not use cleaned data for these
				SELF.county_code 	:=	cleanAddress.fips_county;
				SELF.st						:=	cleanAddress.st;
				SELF.z5						:=	cleanAddress.zip;
				SELF.z4						:=	cleanAddress.zip4;
				SELF.cart					:=	cleanAddress.cart;
				SELF.cr_sort_sz		:=	cleanAddress.cr_sort_sz;
				SELF.lot					:=	cleanAddress.lot;
				SELF.lot_order		:=	cleanAddress.lot_order;
				SELF.dpbc					:=	cleanAddress.dbpc;
				SELF.chk_digit		:=	cleanAddress.chk_digit;
				SELF.rec_type			:=	cleanAddress.rec_type;
				SELF.geo_lat 			:=	cleanAddress.geo_lat;
				SELF.geo_long 		:=	cleanAddress.geo_long;
				SELF.msa					:=	cleanAddress.msa;
				SELF.geo_blk			:=	cleanAddress.geo_blk;
				SELF.geo_match		:=	cleanAddress.geo_match;
				SELF.err_stat			:=	cleanAddress.err_stat;
				// Not sure we want to do this - might want other options later.
				// SELF.xSponsor			:= IF(std.str.StartsWith(L.xSponsor,'IN_PR'),L.xSponsor,'IN_PR:'+L.xSponsor);
				SELF := L;
				SELF := [];
			END;

			newBase := PROJECT(new_CSV_Base, Clean_Address_Transform(LEFT) );

			PromoteSupers.Mac_SF_BuildProcess(newBase, Files.Gong_Base_CSV, buildBase);																					 
			BuildBase2 := PRTE2_Gong_Ins.Proc_Build_Compatible_Base;		// CRITICAL: This reads the base created above.
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);
			// --------------------------------------------------
			AlphaNewBase := Files.Gong_Base_CSV_DS;
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildBase, BuildBase2, 
															delSprayedFile, output(AlphaNewBase)
															);

			RETURN sequentialSteps;

END;