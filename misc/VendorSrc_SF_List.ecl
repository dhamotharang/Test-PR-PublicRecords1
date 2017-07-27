IMPORT ut;

EXPORT VendorSrc_SF_List(STRING pVersion) := MODULE
		
		// EXPORT Update_List_Load								:= '~thor_data400::in::vendor_src_load_update_' + pVersion;
		
		EXPORT Update_Bank_Court							:= '~thor_data400::in::vendor_src::court_bank_' + pVersion;
		
		EXPORT Update_Lien_Court							:= '~thor_data400::in::vendor_src::court_lien_' + pVersion;
		
		EXPORT Update_Riskview								:= '~thor_data400::in::vendor_src::riskview_ffd_' + pVersion;
		
		EXPORT Old_Vendor_Src									:= '~thor_data400::base::vendor_src::old_data';
		
		// EXPORT Update_Non_Bank								:= '~thor_data400::in::vendor_src::non_court_temp_base_' + pVersion;

		EXPORT Source_List_Load								:= '~thor_data400::in::vendor_src_info_load';

		EXPORT Source_List_Load_Father				:= '~thor_data400::in::vendor_src_info_load_father';
			
		EXPORT Source_List_Base								:= '~thor_data400::base::vendor_src_info';

		EXPORT Source_List_Base_Prev					:= '~thor_data400::base::vendor_src_info_father';
		
		EXPORT Combined_Base									:= '~thor_data400::base::vendor_src_info';
		
END;
