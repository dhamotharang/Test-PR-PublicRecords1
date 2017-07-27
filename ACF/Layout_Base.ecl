import BIPV2,Business_header;
export Layout_Base := Record
     string73   Orig_name       :='';
		 string70 	orig_Address	:='';
		 string30 	orig_city       :='';
		 string2  	orig_State      :='';
		 string15 	orig_zip        :='';
		 Business_header.Layout_Business_Contact_full;
		 BIPV2.IDlayouts.l_xlink_ids; //Added for BIPV2 project
	  END;