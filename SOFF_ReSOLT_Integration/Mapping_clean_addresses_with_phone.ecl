/*
**********************************************************************************
Created by    Comments
Vani 		    This attribute 
            1)Join the address and phone list. 
						2)clean the addresses to extract geocode
						3)dedup after clean since the addresses from various sources 
							
***********************************************************************************
*/	

import Address, Business_header;
  
temp_Layout_Address_list := RECORD 
  Layout_Address_list;
  Files_used.layout_Header_file.phone;

end;

  temp_Layout_AddrPhone_list := record 
	Layout_Address_list ;
	Layout_Phone_List and not [persistent_key,seisint_primary_key,DID,relative_flag,address_key,dt_last_seen];
	string8  phone_dt_last_seen;
  end; 
	
  temp_Layout_Address_list  Extract_geomatch_Layout(temp_Layout_Address_list L) := TRANSFORM

  street := trim(trim(trim(trim(trim(trim(
                         IF (L.prim_range <> '',    trim(L.prim_range),'')+
		                 IF (L.predir     <> '',' '+trim(L.predir),''),LEFT)+
					     IF (L.prim_name  <> '',' '+trim(L.prim_name),''),LEFT)+
					     IF (L.addr_suffix<> '',' '+trim(L.addr_suffix),''),LEFT)+
					     IF (L.postdir    <> '',' '+trim(L.postdir),''),LEFT,RIGHT)+
					     IF (L.unit_desig <> '',' '+trim(L.unit_desig),''),LEFT)+
					     IF (L.sec_range  <> '',' '+trim(L.sec_range),''),LEFT); 
										 
  self.Prim_address := trim(trim(trim(IF (L.prim_range <> '',    trim(L.prim_range),'')+
		                              IF (L.predir     <> '',' '+trim(L.predir),''),LEFT)+
					                  IF (L.prim_name  <> '',' '+trim(L.prim_name),''),LEFT)+
					                  IF (L.addr_suffix<> '',' '+trim(L.addr_suffix),''),LEFT);
										 
  self.sec_address := trim(trim(IF (L.postdir    <> '',' '+trim(L.postdir),'')+
					            IF (L.unit_desig <> '',' '+trim(L.unit_desig),''),LEFT)+
					            IF (L.sec_range  <> '',' '+trim(L.sec_range),''),LEFT); 
	
  string182 tempAddressReturn := stringlib.StringToUpperCase(
										if(street <> '' or
										   L.v_city_name <> '' or
										   L.st <> '' or
										   L.zip <> '',
										   Address.CleanAddress182(
										   trim(street,left,right),
										   trim(trim(L.v_city_name,left,right) + ', ' +
										   trim(L.st) + ' ' +
										   trim(L.zip,left,right),left,right)),''));
											 
	self.prim_range   := tempAddressReturn[1..10];
	self.predir 	    := tempAddressReturn[11..12];
	self.prim_name 		:= tempAddressReturn[13..40];
	self.addr_suffix  := tempAddressReturn[41..44];
	self.postdir 		  := tempAddressReturn[45..46];
	self.unit_desig 	:= tempAddressReturn[47..56];
	self.sec_range 		:= tempAddressReturn[57..64];
	self.v_city_name	:= tempAddressReturn[90..114];
	self.st 			    := tempAddressReturn[115..116];
	self.zip 			    := tempAddressReturn[117..121];
	self.geo_match 		:= tempAddressReturn[178];
	SELF              := L; 
  end; 
  
  D_phone_list_withaddkey     := distribute(Mapping_extract_phone_list(address_key<>0),HASH(did));	
	
	phone_no_key                := Mapping_extract_phone_list(address_key =0);
	Address_List_withgeomatch   := PROJECT(Mapping_Dedup_Address, Extract_geomatch_Layout(LEFT),LOCAL) ;  															
  D_Address_List_withgeomatch := distribute(Address_List_withgeomatch,HASH(did));
	
  //output(count(phone_no_key),named('phone_no_key'));
	//output(count(D_phone_list_withaddkey),named('D_phone_list_withaddkey'));
	//output(count(D_Address_List_withgeomatch),named('D_Address_List_withgeomatch'));
  
  temp_Layout_AddrPhone_list Join_Addr_phone(D_Address_List_withgeomatch L, D_phone_list_withaddkey R) := TRANSFORM
	
        SELF.address_key      := IF (L.address_key =0,0 ,HASH32(
		                             if (L.prim_range  <> '', trim(L.prim_range),'*0^'),'@#$%',
		                             if (L.predir      <> '', trim(L.predir),'*0^'),'@#$%',
																 if (L.prim_name   <> '', trim(L.prim_name),'*0^'),'@#$%',
																 if (L.addr_suffix <> '', trim(L.addr_suffix),'*0^'),'@#$%',
		                             if (L.postdir     <> '', trim(L.postdir),'*0^'),'@#$%',
																 if (L.unit_desig  <> '', trim(L.unit_desig),'*0^'),'@#$%',
																 if (L.sec_range   <> '', trim(L.sec_range),'*0^'),'@#$%',
																 if (L.v_city_name <> '', trim(L.v_city_name),'*0^'),'@#$%',
																 if (L.st          <> '', trim(L.st),'*0^'),'@#$%',
																 if (L.zip         <> '', trim(L.zip ),'*0^')));
																 
        SELF.dt_last_seen       := L.dt_last_seen;
			  SELF.phone_dt_last_seen := R.dt_last_seen;
		    SELF.phonetype          := '';
		    SELF.persistent_key     := L.persistent_key ;	                           
		    SELF.DID                := L.DID;
		    SELF.seisint_primary_key:= L.seisint_primary_key;
				SELF.relative_flag      := L.relative_flag;
				SELF.phone              := R.phone;
				SELF.listingtype        := R.listingtype;
        //SELF    								:= R;										 
				SELF    								:= L;
		
  end;	
  	
	//Distribute and Local did not work in the following join so removed Local	
  Address_Phone_list   := JOIN(D_Address_List_withgeomatch, D_phone_list_withaddkey, 
	                             LEFT.did             = RIGHT.did  and 
							                 trim(LEFT.persistent_key) = trim(RIGHT.persistent_key) and 
							                 LEFT.address_key     = RIGHT.address_key and 
								               LEFT.relative_flag   = RIGHT.relative_flag,
							                 Join_Addr_phone(LEFT,RIGHT),LEFT OUTER,LOCAL);	 

  temp_Layout_AddrPhone_list Proj_phone_only_records( phone_no_key L) := TRANSFORM
	      SELF.phone_dt_last_seen := L.dt_last_seen; 
				self.prim_address    	:= '';
				self.sec_address    	:= '';
				self.confirmedcurrent := 0;
				self.prim_range     	:= '';
				self.predir 	    		:= '';
				self.prim_name 				:= '';
				self.addr_suffix    	:= '';
				self.postdir 					:= '';
				self.unit_desig 			:= '';
				self.sec_range 				:= '';
				self.v_city_name			:= '';
				self.st 							:= '';
				self.zip 							:= '';
				self.geo_match 				:= '';
				SELF.dt_last_seen     := 0;
				self.phonetype        := '';
        SELF    							:= L;										 
		
  end;																 
	address_phoneonly_list := PROJECT(phone_no_key,Proj_phone_only_records(LEFT));

	//output(count(Address_Phone_list),named('Address_Phone_list'));
	//output(count(address_phoneonly_list),named('address_phoneonly_list'));
  export Mapping_clean_addresses_with_phone := Address_Phone_list +address_phoneonly_list; // : persist('persist::imap::AddressPhoneList');