/*2015-08-14T00:44:02Z (Cyndy Yu)
This is an original copy of Fn_Spray_And_Build_BaseMain that Cyndy used to initialize some data from header
*/
IMPORT ut, RoxieKeyBuild, PRTE2_Email_Data_Ins, PRTE2_Common, PRTE2_Header_Ins;
IMPORT PRTE2_Common as Common;

// - we need to use Boca header for actual sprays and builds.
BocaHeader := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;
Constants    := PRTE2_Email_Data_Ins.Constants;
Files        := PRTE2_Email_Data_Ins.Files;
Layouts      := PRTE2_Email_Data_Ins.Layouts;

// EXPORT Fn_Spray_And_Build_BaseMain(STRING lzFilePath, STRING fileVersion, STRING overridePath='') := FUNCTION
EXPORT U_Spray_And_UpdateFromHeader(STRING lzFilePath, STRING fileVersion, STRING overridePath='') := FUNCTION

			// --------------------------------------------------
			SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					  // file LZ
																								lzFilePath,                         // path to file on landing zone
																								Constants.CSVMaxCount,															// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.FILE_SPRAY,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);						
		
			// This macro is what builds the super files with generations: QA, Father, Grandfater
			// RoxieKeyBuild.Mac_SF_BuildProcess_V2(Files.SPRAYED_DS,             //thedataset - is the dataset to be written to disk
																					 // Files.BASE_PREFIX_NAME,       //prefix - base name 
																					 // Files.EMAIL_Spreadsheet_name, //Suffix
																					 // fileVersion,                  //File date
																					 // buildSpreadsheet,             //seq_name - is the action         
																					 // 3,                        //numgenerations is currently to be just 2 or 3    
																					 // false,                    //csvout - optional should you need a csv output
																					 // true);                    //pcompress - optional should you need the file to be compressed.
	
			// --------------------------------------------------
			PRTE2_Email_Data_Ins.Layouts.baseHeader xGetResult(BocaHeader L)	:= Transform
        SELF.clean_name.title          := L.title;                 
        SELF.clean_name.fname          := L.fname;
        SELF.clean_name.mname          := L.mname;
        SELF.clean_name.lname          := L.lname;
        SELF.clean_name.name_suffix    := L.name_suffix;
        SELF.clean_name.name_score     := '99';
        SELF.clean_address.prim_range  := L.prim_range;
        SELF.clean_address.predir      := L.predir;
        SELF.clean_address.prim_name   := L.prim_name;
        SELF.clean_address.addr_suffix := L.suffix;
        SELF.clean_address.postdir     := L.postdir;
        SELF.clean_address.unit_desig  := L.unit_desig;
        SELF.clean_address.sec_range   := L.sec_range;
        SELF.clean_address.p_city_name := L.p_city_name;
        SELF.clean_address.v_city_name := L.v_city_name;
        SELF.clean_address.st          := L.st;
        SELF.clean_address.zip         := L.zip;
        SELF.clean_address.zip4        := L.zip4;
        SELF.clean_address.cart        := L.cart;
        SELF.clean_address.cr_sort_sz  := L.cr_sort_sz;
        SELF.clean_address.lot         := L.lot;
        SELF.clean_address.lot_order   := L.lot_order;
        SELF.clean_address.dbpc        := L.dbpc;
        SELF.clean_address.chk_digit   := L.chk_digit ;
        SELF.clean_address.rec_type    := L.rec_type;
        SELF.clean_address.county      := L.county;
        SELF.clean_address.geo_lat     := L.geo_lat;
        SELF.clean_address.geo_long    := L.geo_long;
        SELF.clean_address.msa         := L.msa;
        SELF.clean_address.geo_blk     := L.geo_blk;
        SELF.clean_address.geo_match   := L.geo_match;
        SELF.clean_address.err_stat    := L.err_stat;
        SELF.append_rawaid             := L.rawaid;              
        SELF.best_ssn                  := L.ssn;
        SELF.best_dob                  := (unsigned4) L.dob;
        SELF.date_first_seen           := (string8) L.dt_first_seen;      
        SELF.date_last_seen            := (string8) L.dt_last_seen;
        SELF.date_vendor_first_reported:= (string8) L.dt_vendor_first_reported; 
        SELF.date_vendor_last_reported := (string8) L.dt_nonglb_last_seen;
        SELF:= L;
        SELF :=[];
			END;
			
			newBocaHeader := PROJECT(BocaHeader, xGetResult(left));
			newBaseAll      := PROJECT(JOIN(Files.SPRAYED_DS, newBocaHeader,
			                           LEFT.DID = RIGHT.DID,
											           LEFT OUTER), PRTE2_Email_Data_Ins.Layouts.base) ;
      newBase         := DEDUP(SORT(newBaseAll, RECORD), RECORD);
			
			// This macro is what builds the super files with generations: QA, Father, Grandfater
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(newBase,                  //thedataset - is the dataset to be written to disk
																					 Files.BASE_PREFIX_NAME,   //prefix - base name 
																					 Files.EMAIL_ALP_BASE_NAME,    //Suffix
																					 fileVersion,              //File date
																					 buildAlphaBase,           //seq_name - is the action         
																					 3,                        //numgenerations is currently to be just 2 or 3    
																					 false,                    //csvout - optional should you need a csv output
																					 true);                    //pcompress - optional should you need the file to be compressed.
																					 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile(Files.FILE_SPRAY);

			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
														  sprayFile,
															// buildSpreadsheet,
															buildAlphaBase,
															delSprayedFile);

			RETURN sequentialSteps;

END;