IMPORT PRTE2_Header;

EXPORT Layouts := MODULE

	EXPORT Layout_Merged_IHDR_BHDR := RECORD
			STRING1 Required_BC;
			PRTE2_X_DataCleanse.Layouts_Alpha.Layout_InsHead;
			STRING addr_match_flag;
			PRTE2_Header.Layouts.Expanded_Main_Header_Layout;
	END;


	EXPORT Layout_XREF_MHDR := RECORD
			Layout_Merged_IHDR_BHDR;
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
	END;

END;