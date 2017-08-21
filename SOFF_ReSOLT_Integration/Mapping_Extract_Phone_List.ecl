/*
**********************************************************************************
Created by    Comments
Vani 		    This attribute 
            1)Extract phone no from header 
						2)Joing with Gong to get additional phone number
							
***********************************************************************************
*/	

  import address,Business_header,ut,yellowpages,gong,cellphone,Risk_Indicators;
  Temp_Layout_Phone_List := RECORD
	Layout_Phone_list and NOT [phonetype];
  End;
  
  Temp_Layout_Address_list := RECORD 
    Layout_Address_list;
    Files_used.layout_Header_file.phone;
  end;
  
  Temp_Layout_Phone_List  Change_to_Phone_Layout(Temp_Layout_Address_list L) := TRANSFORM
	
	SELF.dt_last_seen := '';
	SELF.listingtype  := '';
    SELF := L; 
  end;
 
  Addr_Phone_List   := PROJECT(Mapping_address_preprocess(phone <> ''), Change_to_Phone_Layout(LEFT),LOCAL) ;
  
  //D_Address_list := DISTRIBUTE(Mapping_Dedup_Address,HASH(did,prim_range,predir,prim_name,addr_suffix,postdir,zip));	
  //D_Gong_File := DISTRIBUTE(File_generated_Gong_slim_subset,HASH(did,prim_range,predir,prim_name,suffix,postdir,z5));
  D_Address_list    := Mapping_Dedup_Address;	
  D_Gong_File       := File_generated_Gong_slim_subset;
  D_phonesplus_File := File_generated_Phonesplus_slim_subset;
	
  Temp_Layout_Phone_List Join_Addr_gong(Temp_Layout_Address_list L, Layout_Gong_slim R) := TRANSFORM
    
		SELF.phone       := R.phone10;
		SELF.listingtype := trim(R.listing_type_res+R.listing_type_bus+R.listing_type_gov,all);
		SELf             := R;
		SELF             := L;		
  end;	
	
  Gong_Phone_list  	 := JOIN(D_Address_list, D_Gong_File, 
	                         LEFT.did = RIGHT.did                            and
							 LEFT.persistent_key = RIGHT.persistent_key      and 
							 LEFT.relative_flag = RIGHT.relative_flag        and
                             trim(LEFT.prim_range)  = trim(RIGHT.prim_range) and
							 trim(LEFT.predir)      = trim(RIGHT.predir)     and
							 trim(LEFT.prim_name)   = trim(RIGHT.prim_name)  and 
							 trim(LEFT.addr_suffix) = trim(RIGHT.suffix)     and
							 trim(LEFT.postdir)     = trim(RIGHT.postdir)    and 
							 //ut.NNEQ(LEFT.unit_desig,RIGHT.unit_desig)    and (Not required per Jill)
							 //ut.NNEQ(LEFT.sec_range,RIGHT.sec_range)      and (Not required per Jill)
							 trim(LEFT.zip)         = trim(RIGHT.z5) ,
							 Join_Addr_gong(LEFT,RIGHT),RIGHT OUTER, LOCAL);	
														 
														 
  Temp_Layout_Phone_List Join_Addr_PhonesPlus(Temp_Layout_Address_list L, Layout_Phonesplus_slim R) := TRANSFORM
    
		SELF.phone        := R.cellphone;
		SELF.dt_last_seen := (string)R.DateLastSeen;
		SELF.listingtype  := trim(R.Listingtype);
		SELf := R;
		SELF := L;		
  end;		
	
  PhonePlus_list  	 := JOIN(D_Address_list, D_phonesplus_File, 
	                           LEFT.did = RIGHT.did             			   and 
							   LEFT.persistent_key = RIGHT.persistent_key      and 
							   LEFT.relative_flag = RIGHT.relative_flag        and
	                           trim(LEFT.prim_range)  = trim(RIGHT.prim_range) and
				 			   trim(LEFT.predir)      = trim(RIGHT.predir)      and
							   trim(LEFT.prim_name)   = trim(RIGHT.prim_name)   and 
							   trim(LEFT.addr_suffix) = trim(RIGHT.addr_suffix) and
							   trim(LEFT.postdir)     = trim(RIGHT.postdir)     and 
							   //ut.NNEQ(LEFT.unit_desig,RIGHT.unit_desig)    and (Not required per Jill)
							   //ut.NNEQ(LEFT.sec_range,RIGHT.sec_range)      and (Not required per Jill)
							   trim(LEFT.zip)         = trim(RIGHT.zip5) ,
							   Join_Addr_PhonesPlus(LEFT,RIGHT),RIGHT OUTER, LOCAL);		

  Full_phone_list    := Gong_Phone_list + Addr_Phone_List +PhonePlus_list;
  S_phone_List       := SORT(Full_phone_list, persistent_key,did,relative_flag,address_key,phone,dt_last_seen,LOCAL) ;
  S_phone_List_dedup := DEDUP(S_phone_List, persistent_key,did,relative_flag,address_key,phone,RIGHT,LOCAL);// : persist ('persist::IMAP::phone_list');
	
  //yellowpages.NPA_PhoneType(S_phone_List_dedup, Phone, phonetype, outfile);
  
  export Mapping_Extract_Phone_List := S_phone_List_dedup ;//: persist ('persist::IMAP::phone_list');
  //export Mapping_Extract_Phone_List := S_phone_List_dedup : persist ('persist::IMAP::phone_list');