IMPORT PRTE2_Header_Ins;

EXPORT Layouts := MODULE


	EXPORT VIN_Simple_Layout := RECORD
			STRING17 VIN;
			STRING   Year;
			STRING   Make;
			STRING   Model;
	END;

// ?????????????? use the version in Layouts_Alpha ???
	// EXPORT Layout_Merged_IHDR_BHDR := RECORD
			// STRING1 Required_BC;
			// Layouts_Alpha.Layout_InsHead;
			// STRING addr_match_flag;
			// PRTE2_Header_Ins.Layouts.Base_Layout;
	// END;


	EXPORT Layout_XREF_MHDR := RECORD
			Layouts_Alpha.Layout_Merged_IHDR_BHDR;
			UNSIGNED6 eir_source_boca_did;			
			UNSIGNED2 AM_cnt;
			UNSIGNED2 AR_cnt;
			UNSIGNED2 BK_cnt;
			UNSIGNED2 E1_cnt;
			UNSIGNED2 E2_cnt;
			UNSIGNED2 E3_cnt;
			UNSIGNED2 L2_cnt;
			UNSIGNED2 LI_cnt;
			UNSIGNED2 PL_cnt;	
			UNSIGNED2 Criminal_cnt;	
			UNSIGNED2 UCC_cnt;	
			UNSIGNED2 SexOff_cnt;	
	END;

	EXPORT Layout_Experian_SSNs := RECORD
      STRING9  NEW_SSN  ;
      STRING9  OLD_SSN  ;
      STRING   FNAME    ;
      STRING   MNAME    ;
      STRING   LNAME    ;
      STRING   HOUSE_NUM;
      STRING   STR_NAME ;
      STRING   STR_SUF  ;
      STRING   UNIT     ;
      STRING   UNIT_NUM ;
      STRING   CITY     ;
      STRING   STATE    ;
      STRING   ZIP      ;
	END;
END;