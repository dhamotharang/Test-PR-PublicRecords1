//######################################################
//## This Key is no longer in FCRA_GongKeys 2/26/2020 ##
//######################################################
Import Data_Services, doxie, _Control;

Legacy_Layout := PROJECT(File_History_Full_Prepped_for_FCRA_Keys, Layout_history);

export key_FCRA_history_npa_nxx_line :=  
       index(Legacy_Layout(length(TRIM(phone10))=10),
             {string3 npa := phone10[1..3],
		    string3 nxx := phone10[4..6],
		    string4 line := phone10[7..10],
		    boolean current_flag := if(current_record_flag='Y',true,false),
		    boolean business_flag := if(listing_type_bus='B',true,false)},
             {Legacy_Layout},
	   Data_Services.Data_location.Prefix('Gong_History')+'thor_data400::key::gong_history::fcra::'+doxie.Version_SuperKey + '::npa_nxx_line'
	   );