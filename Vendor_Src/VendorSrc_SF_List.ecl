IMPORT ut,Data_services;

EXPORT VendorSrc_SF_List(STRING pVersion) := MODULE
		
		// EXPORT Update_List_Load						:= '~thor_data400::in::vendor_src_load_update_' + pVersion;
		
		EXPORT Update_Bank_Court							:= Data_Services.foreign_prod+'thor_data400::in::vendor_src::court_bank_20190128';
		
		EXPORT Update_Lien_Court							:= Data_Services.foreign_prod+'thor_data400::in::vendor_src::court_lien_20190128';
		
		EXPORT Update_Riskview								:= Data_Services.foreign_prod+'thor_data400::in::vendor_src::riskview_ffd_20190128';
		
		EXPORT Update_Old_Format				  		:= Data_Services.foreign_prod+'thor_data400::in:vendor_src::old_vendor_src_base_';
		
		EXPORT Old_Vendor_Src									:= Data_Services.foreign_prod+'thor_data400::base::vendor_src::old_data';
		
		EXPORT Update_Court_Locations					:= Data_Services.foreign_prod+'thor::in::vendor_src::courtlocations';

		// EXPORT Update_Non_Bank								:= '~thor_data400::in::vendor_src::non_court_temp_base_' + pVersion;

		EXPORT Source_List_Load								:= Data_Services.foreign_prod+'thor_data400::in::vendor_src_info_load';

		EXPORT Source_List_Load_Father				:= Data_Services.foreign_prod+'thor_data400::in::vendor_src_info_load_father  ';
			                                                                  
	  EXPORT Source_List_Base								:= Data_Services.foreign_prod+'thor_data400::base::vendor_src_info';

		EXPORT Source_List_Base_Prev	        := Data_Services.foreign_prod+'thor_data400::base::vendor_src_info_father';
		
		EXPORT Combined_Base				         	:= Data_Services.foreign_prod+'thor_data400::base::vendor_src_info';
		
		// new for crim srouces
		EXPORT MasterSources					:= Data_Services.foreign_prod+'thor::in::vendor_src::all_sources';
		EXPORT CrimSources				  	:= Data_Services.foreign_prod+'thor::in::vendor_src::crim_sources';
		EXPORT CrimOffenses				  	:= Data_Services.foreign_prod+'thor::in::vendor_src::crim_offenses';
		EXPORT SO_Main				      	:= Data_Services.foreign_prod+'thor::in::vendor_src::offender_main';
		EXPORT SO_Offenses				  	:= Data_Services.foreign_prod+'thor::in::vendor_src::offender_offenses';
		EXPORT MasterList				    	:= Data_Services.foreign_prod+'thor::in::vendor_src::masterlist';
		EXPORT CollegeLocator			  	:= Data_Services.foreign_prod+'thor::in::vendor_src::collegelocator_father';
		EXPORT CollegeLocator_Father	:= Data_Services.foreign_prod+'thor::in::vendor_src::collegelocator_father';

END;
