/* ************************************************************************************************
PRTE2_Email_Data_Ins.Fn_Spray_And_Add_New

Nov 2017 - re-write to new LZ and base layouts
************************************************************************************************ */

IMPORT ut, RoxieKeyBuild, PRTE2_Email_Data_Ins, PRTE2_Common, Address, Email_Data, STD;
IMPORT PRTE2_Common as Common;

Constants    := PRTE2_Email_Data_Ins.Constants;
Files        := PRTE2_Email_Data_Ins.Files;
Layouts      := PRTE2_Email_Data_Ins.Layouts;

EXPORT Fn_Spray_And_Add_New(STRING lzFilePath, STRING fileVersion, BOOLEAN isProdBase=TRUE, STRING overridePath='' ) := FUNCTION
			
			ExistingEmail_DS := IF(isProdBase, Files.Email_Base_DS_PROD, Files.Email_Base_DS); 

			// --------------------------------------------------
			SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					  // file LZ
																								lzFilePath,                         // path to file on landing zone
																								Constants.CSVMaxCount,															// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Group(),									// destination THOR cluster
																								Files.FILE_SPRAY,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);						

			// Safety step added by Fan - upper case names just in case data person put in spreadsheet not upper case
			SPRAYED_DS_UP_AddedOnly := PRTE2_Common.mac_ConvertToUpperCase(Files.SPRAYED_DS , orig_first_name, orig_last_name);		
			
			SPRAYED_DS_UP_AddedOnly trxfrm(SPRAYED_DS_UP_AddedOnly L) := TRANSFORM
						cleanAddress	:= PRTE2_Common.Clean_Address.FromLine(L.orig_address, L.orig_city, L.orig_state, L.orig_zip, L.orig_zip4);
						SELF.orig_address := Address.Addr1FromComponents(cleanAddress.prim_range,cleanAddress.predir,cleanAddress.prim_name,
																									cleanAddress.addr_suffix,cleanAddress.postdir,cleanAddress.unit_desig,cleanAddress.sec_range);
						SELF.clean_address.prim_range		:=	cleanAddress.prim_range;		//string10
						SELF.clean_address.predir					:=	cleanAddress.predir;				//string2
						SELF.clean_address.prim_name			:=	cleanAddress.prim_name;			//string28
						SELF.clean_address.addr_suffix	:=	cleanAddress.addr_suffix;		//string4
						SELF.clean_address.postdir				:=	cleanAddress.postdir;				//string2
						SELF.clean_address.unit_desig		:=	cleanAddress.unit_desig;		//string10
						SELF.clean_address.sec_range			:=	cleanAddress.sec_range;			//string8
						SELF.clean_address.p_city_name	:=	cleanAddress.v_city_name;		//string25
						SELF.clean_address.v_city_name	:=	cleanAddress.v_city_name;		//string25
						SELF.clean_address.st							:=	cleanAddress.st;						//string2
						SELF.clean_address.zip							:=	cleanAddress.zip;						//string5
						SELF.clean_address.zip4						:=	cleanAddress.zip4;					//string4
						SELF.clean_address.cart						:=	cleanAddress.cart;					//string4
						SELF.clean_address.cr_sort_sz		:=	cleanAddress.cr_sort_sz;		//string1
						SELF.clean_address.lot							:=	cleanAddress.lot;						//string4
						SELF.clean_address.lot_order			:=	cleanAddress.lot_order;			//string1
						SELF.clean_address.dbpc						:=	cleanAddress.dbpc;					//string2
						SELF.clean_address.chk_digit			:=	cleanAddress.chk_digit;			//string1
						SELF.clean_address.rec_type			:=	cleanAddress.rec_type;			//string2
						// SELF.clean_address.ace_fips_st 	:=	cleanAddress.fips_state;		//string2
						SELF.clean_address.county				 	:=	cleanAddress.fips_county;		//string3
						SELF.clean_address.geo_lat 			:=	cleanAddress.geo_lat;				//string10
						SELF.clean_address.geo_long 			:=	cleanAddress.geo_long;			//string11
						SELF.clean_address.msa							:=	cleanAddress.msa;						//string4
						SELF.clean_address.geo_blk				:=	cleanAddress.geo_blk;				//string7
						SELF.clean_address.geo_match			:=	cleanAddress.geo_match;			//string1
						SELF.clean_address.err_stat			:=	cleanAddress.err_stat;			//string4

						origNameCalc := PRTE2_Common.Functions.AppendIF(L.orig_first_name, L.orig_last_name);
						cleanedName 				:= Address.CleanPersonFML73_fields(origNameCalc);
						SELF.clean_name.title	:= cleanedName.title;
						SELF.clean_name.fname	:= cleanedName.fname;
						SELF.clean_name.mname	:= cleanedName.mname;
						SELF.clean_name.lname	:= cleanedName.lname;
						SELF.clean_name.name_suffix := cleanedName.name_suffix;
						SELF.clean_name.name_score:= cleanedName.name_score;

						// INPUT S/B = L.orig_email field's value
						v_email_orig := STD.Str.ToUpperCase(STD.Str.CleanSpaces(L.orig_email));
						self.orig_email 	:= v_email_orig;
						self.clean_email 	:= v_email_orig;
						v_append_email_username  := STD.Str.ToUpperCase(email_data.Fn_Clean_Email_Username(v_email_orig));
						v_append_domain 				 := v_email_orig[length(v_append_email_username)+2..];
						v_append_domain_root 	 	:= TRIM(v_append_domain[1..STD.Str.Find(v_append_domain, '.', 1) -1], right);	
						v_append_domain_ext			 := v_append_domain[length(v_append_domain_root)+1..];
						self.append_email_username 	 := v_append_email_username;
						self.append_domain 					 := v_append_domain;
						self.append_domain_root 		 := v_append_domain_root;
						self.append_domain_ext 			 := v_append_domain_ext;
						SELF.append_domain_type := PRTE2_Common.Functions.Pick1(L.append_domain_type,'FREE');				//????
						// 4 Boolean fields: This is add only logic, so I'm just going to initialize with what the BC3800 team used.
						SELF.append_is_tld_state := FALSE;
						SELF.append_is_tld_country := FALSE;
						SELF.append_is_tld_generic := TRUE;
						SELF.append_is_valid_domain_ext := TRUE;
						SELF.email_src := PRTE2_Common.Functions.Pick1(L.email_src, 'M1');											//????
						SELF.rec_src_all := PRTE2_Common.Functions.Pick1Int(L.rec_src_all, 16);											//????
						SELF.email_src_all := PRTE2_Common.Functions.Pick1Int(L.email_src_all, 16);										//????
						SELF.email_src_num := PRTE2_Common.Functions.Pick1Int(L.email_src_num, 1);										//????
						SELF.num_email_per_did := PRTE2_Common.Functions.Pick1Int(L.num_email_per_did, 1);								//????
						SELF.num_did_per_email := PRTE2_Common.Functions.Pick1Int(L.num_did_per_email, 1);								//????

						self.email_rec_key  := Email_Data.Email_rec_key(SELF.clean_email,
																																						SELF.clean_address.prim_range,
																																						SELF.clean_address.prim_name, 	
																																						SELF.clean_address.sec_range, 
																																						SELF.clean_address.zip,
																																						SELF.clean_name.lname, 
																																						SELF.clean_name.fname);

						// We could join with BHDR using did - ???
						// SELF.did_score := ??;
						// SELF.did_type := ??;
						// SELF.is_did_prop := ??;
						// SELF.hhid := ??;


						// SELF.date_first_seen
						// SELF.date_last_seen
						// SELF.date_vendor_first_reported
						// SELF.date_vendor_last_reported
						SELF := L;
			END;
			
			// New_DS_ALL_DATA := PROJECT(SPRAYED_DS_UP_AddedOnly,trxfrm(LEFT));		// just initial test
			DS_New_Initialized := PROJECT(SPRAYED_DS_UP_AddedOnly,trxfrm(LEFT));
			New_DS_ALL_DATA := ExistingEmail_DS+DS_New_Initialized;
			// --------------------------------------------------
			// Build the alpha spray/despray base file before creating the Boca compatible version.
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(New_DS_ALL_DATA,             //thedataset - is the dataset to be written to disk
																					 Files.BASE_PREFIX_NAME,       //prefix - base name 
																					 Files.EMAIL_ALP_BASE_NAME,        //Suffix
																					 fileVersion,                  //File date
																					 buildAlphaBase,               //seq_name - is the action         
																					 3,                            //numgenerations is currently to be just 2 or 3    
																					 false,                        //csvout - optional should you need a csv output
																					 true);                        //pcompress - optional should you need the file to be compressed.

			// --------------------------------------------------
			// Build the BOCA BASE FILE with the compatible name and layout that the Boca build expects
			AlphaCompatible := PROJECT(New_DS_ALL_DATA,Layouts.Boca_Compatible);
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(AlphaCompatible,             //thedataset - is the dataset to be written to disk
																					 Files.BASE_PREFIX_NAME,       //prefix - base name 
																					 Files.EMAIL_BASE_NAME,        //Suffix
																					 fileVersion,                  //File date
																					 buildAlphaCompatBase,               //seq_name - is the action         
																					 3,                            //numgenerations is currently to be just 2 or 3    
																					 false,                        //csvout - optional should you need a csv output
																					 true);                        //pcompress - optional should you need the file to be compressed.
																					 																					 													 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile(Files.FILE_SPRAY);

			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
														  sprayFile,
															buildAlphaBase, buildAlphaCompatBase,
															delSprayedFile);

			RETURN sequentialSteps;

END;