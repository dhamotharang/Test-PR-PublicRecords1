import business_header_ss, data_services;

bh_base := Business_Header.File_Business_Header_Base_for_keybuild;

export Key_Business_Header_RCID := INDEX(bh_base, 
		  {rcid, bdid}, 
		 data_services.data_location.prefix() + 'thor_data400::key::business_header.rcid_' + business_header_ss.key_version);