import gong, doxie, data_services;

Legacy_Layout := PROJECT(File_History_Full_Prepped_for_Keys, Layout_history);

export key_history_npa_nxx_line :=  
       index(Legacy_Layout(length(TRIM(phone10))=10),
             {string3 npa := phone10[1..3],
		    string3 nxx := phone10[4..6],
		    string4 line := phone10[7..10],
		    boolean current_flag := if(current_record_flag='Y',true,false),
		    boolean business_flag := if(listing_type_bus='B',true,false)},
             {Legacy_Layout},
		   data_services.data_location.prefix() + 'thor_data400::key::gong_history_npa_nxx_line_' + doxie.Version_SuperKey);