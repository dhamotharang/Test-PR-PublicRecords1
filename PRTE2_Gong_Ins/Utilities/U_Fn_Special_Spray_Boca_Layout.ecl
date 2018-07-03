/* *****************************************************************************************
PRTE2_Gong_Ins.U_Fn_Special_Spray_Boca_Layout
This is because Linda handed us some data in the final Boca layout and no one noticed.
So I have to convert it to our layout too.  Differences from the standard Fn_Spray_And_Build_BaseMain:
1. We spray a CSV file which is in Boca layout
2. We read that temp CSV file
3. We transform it into our Layouts.Alpha_CSV_Layout (note all 'x' fields were lost!)
4. We save this as a new Files.Gong_Base_CSV
5. We also save the sprayed in file as the Boca base (since that's how it originally was)

 *** We have lost any special Alpha-only CSV fields and need to refill them.
***************************************************************************************** */

IMPORT ut, RoxieKeyBuild, Address, PRTE2, PRTE2_Common,PromoteSupers, PRTE2_Gong_Ins;
Constants := PRTE2_Gong_Ins.Constants;
Files := PRTE2_Gong_Ins.Files;
Layouts := PRTE2_Gong_Ins.Layouts;

EXPORT U_Fn_Special_Spray_Boca_Layout(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION
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

			// Oddball spray if the CSV is in Boca layout - use the same name since it is just a temp file.																		 
			SPRAYED_DS_BOCALAY	:= DATASET(Files.FILE_SPRAY, Layouts.Boca_Base_Layout,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));																			 

			// Read the CSV data but in the final BOCA_LAYOUT that Linda created
			oddball_Boca_Lay_Spray := SPRAYED_DS_BOCALAY;
			
			// appendIf5 := PRTE2_Common.Functions.appendIf5;
			// *********************************************************************************************************************
			// transform data of CSV usinf clean address (simulate action of RMPO on request sent).
			// *********************************************************************************************************************
			Layouts.Alpha_CSV_Layout Clean_Address_Transform(oddball_Boca_Lay_Spray L) := TRANSFORM

					// SELF.dual_name_flag						// N unless the listed name is 2 names like: JOHN & MARY SMITH
					SELF.listing_type_res := 'R';	// residential
					SELF.publish_code := 'P';			// ? public or private?

					SELF.omit_address := 'N';
					SELF.omit_phone		:= 'N';
					SELF.omit_locality := 'N';
					
					SELF.hhid := 0;
					SELF.bdid := 0;
					// Linda's data in Boca Compatible Layout includes these same fields as the Alpha Data team uses.
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
					SELF.xSponsor := L.cust_name,
					SELF.xBug_Num := L.bug_num,
				SELF := L;
				SELF := [];
			END;

			// In this case - it will convert the Boca base into our layout, but note: it lost any 'x' field values.
			newBase := PROJECT(oddball_Boca_Lay_Spray, Clean_Address_Transform(LEFT) );

			PromoteSupers.Mac_SF_BuildProcess(newBase, Files.Gong_Base_CSV, buildBase);
			// we want to use this to capture any cleaning done above.
			BuildBCBase := PRTE2_Gong_Ins.Proc_Build_Compatible_Base;		// CRITICAL: This reads the base created above.
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);
			// --------------------------------------------------
			AlphaNewBase := Files.Gong_Base_CSV_DS;
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildBase,  BuildBCBase,
															delSprayedFile, output(AlphaNewBase)
															);

			RETURN sequentialSteps;

END;