import doxie;

EXPORT Key_Business_Header_BDID := 
	INDEX(File_Business_Header_Plus, 
		  {bdid, __filepos }, 
		 '~thor_data400::key::business_header.bdid_' + doxie.Version_SuperKey);