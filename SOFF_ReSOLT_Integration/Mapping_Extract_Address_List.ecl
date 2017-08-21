/*
**********************************************************************************
Created by    Comments
Vani 		    This attribute 
            1)Dedup and clean the addresses to extract geocode
							
***********************************************************************************
*/	

import address,Business_header;
  
  temp_Layout_AddrPhone_list := record 
	Layout_Address_list ;
	Layout_Phone_List and not [persistent_key,seisint_primary_key,DID,relative_flag,address_key,dt_last_seen];
	string8  phone_dt_last_seen;
  end; 
	
					 
  S_Address_Phone_list := Mapping_clean_addresses_with_phone(address_key <> 0); 	 
  
  Layout_address_list Extract_address(temp_Layout_AddrPhone_list L) := TRANSFORM 
  
  	 SELF := L;
  
  end;
  
  Address_list         := PROJECT(S_Address_Phone_list,Extract_address(LEFT));
  S_Address_list       := SORT(Address_list, persistent_key, did, relative_flag, address_key, confirmedcurrent, dt_last_seen) ; 	     
  S_Address_list_dedup := DEDUP(S_Address_list,persistent_key,did,relative_flag, address_key,RIGHT);
  
export Mapping_Extract_Address_List := S_Address_list_dedup : Persist ('persist::IMAP::Address_List');
