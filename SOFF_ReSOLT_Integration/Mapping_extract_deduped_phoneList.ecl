/*
**********************************************************************************
Created by    Comments
Vani 		    This attribute 
            1)Extract and dedups the phone list after the address cleaning
							
***********************************************************************************
*/	


import address,Business_header,ut,yellowpages,gong,cellphone,Risk_Indicators;

  temp_Layout_AddrPhone_list := record
	Layout_Address_list ;
	Layout_Phone_List and not [persistent_key,seisint_primary_key,DID,relative_flag,address_key,dt_last_seen];
	string8  phone_dt_last_seen;
  end; 
	
	Temp_layout_phone_list := record ,maxlength(4096)
	  Layout_Phone_List and not [phonetype];
	end;
  
  S_Address_Phone_list := Mapping_clean_addresses_with_phone; 	 
  
  Temp_layout_phone_list Extract_phone(temp_Layout_AddrPhone_list L) := TRANSFORM 
     SELF.dt_last_seen := L.phone_dt_last_seen;
  	 SELF := L;
  
  end;
  
  Phone_list         := PROJECT(S_Address_Phone_list(phone<> ''),Extract_phone(LEFT));
  S_Phone_list       := SORT(Phone_list, persistent_key, did, relative_flag, address_key, phone , dt_last_seen) ; 	     
  S_Phone_list_dedup := DEDUP(S_Phone_list,persistent_key,did,relative_flag, address_key, phone,RIGHT);
  yellowpages.NPA_PhoneType(S_phone_List_dedup, Phone, phonetype, outfile);
export Mapping_extract_deduped_phoneList := outfile;// :persist('persist::imap::phone_List');