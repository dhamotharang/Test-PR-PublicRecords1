/*
**********************************************************************************
Created by    Comments
Vani 		  This attribute 
          1)Extracts the unique addresses from header file
		      2)Extract the current address from Best File
					3)Extract addresses from Vehicle Party
					4)Added clean address fron gong and phonesplus
					5)Include the SOR addresses
							
***********************************************************************************
*/	

import address,Business_header;

temp_Layout_Address_list := RECORD 
  Layout_Address_list;
  Files_used.layout_Header_file.phone;

end;
 temp_Layout_Address_list  Change_to_Addr_Layout(Layout_Header_Subset L) := TRANSFORM
    SELF.Prim_address     := '';       
	  SELF.Sec_address      := '';
	  SELF.addr_suffix      := L.suffix;
	  SELF.v_city_name      := L.city_name;
	  SELF.geo_match        := '';
	  SELF.ConfirmedCurrent := 0;
	  SELF.address_key      := HASH32(if(L.prim_range <> '', trim(L.prim_range),'*0^'),'@#$%',
		                              if(L.predir     <> '', trim(L.predir),'*0^'),'@#$%',
									  if(L.prim_name  <> '', trim(L.prim_name),'*0^'),'@#$%',
									  if(L.suffix     <> '', trim(L.suffix),'*0^'),'@#$%',
		                              if(L.postdir    <> '', trim(L.postdir),'*0^'),'@#$%',
									  if(L.unit_desig <> '', trim(L.unit_desig),'*0^'),'@#$%',
									  if(L.sec_range  <> '', trim(L.sec_range),'*0^'),'@#$%',
									  if(L.city_name  <> '', trim(L.city_name),'*0^'),'@#$%',
 									  if(L.st         <> '', trim(L.st),'*0^'),'@#$%',
									  if(L.zip        <> '', trim(L.zip ),'*0^'));
												
	  SELF := L; 
 end;
 
  Address_List   := PROJECT(File_generated_Header_subset(prim_name[1..4] <> 'DOD:'), Change_to_Addr_Layout(LEFT),LOCAL) ;

 
  temp_Layout_Address_list	 Join_KeyFile_Header(Layout_UNQ_PK_DID_Plus_Relatives L, Files_used.watchdog_Layout_best R) := TRANSFORM
      SELF.Prim_address := '';       
	  SELF.Sec_address  := '';
	  SELF.addr_suffix  := R.suffix;
	  SELF.v_city_name  := R.city_name;
	  SELF.geo_match    := '';
	  SELF.ConfirmedCurrent := 1;
	  SELF.address_key  := HASH32(      if(R.prim_range <> '', trim(R.prim_range),'*0^'),'@#$%',
		                                if(R.predir     <> '', trim(R.predir),'*0^')    ,'@#$%',
										if(R.prim_name  <> '', trim(R.prim_name),'*0^') ,'@#$%',
										if(R.suffix     <> '', trim(R.suffix),'*0^')    ,'@#$%', 
		                                if(R.postdir    <> '', trim(R.postdir),'*0^')   ,'@#$%',
										if(R.unit_desig <> '', trim(R.unit_desig),'*0^'),'@#$%',
										if(R.sec_range  <> '', trim(R.sec_range),'*0^') ,'@#$%',
										if(R.city_name  <> '', trim(R.city_name),'*0^') ,'@#$%',
										if(R.st         <> '', trim(R.st),'*0^')        ,'@#$%' ,
										if(R.zip        <> '', trim(R.zip ),'*0^'));
		
		//HASH32(trim(R.prim_range), trim(R.predir), trim(R.prim_name), trim(R.suffix), 
	  //                          trim(R.postdir),trim(R.unit_desig), trim(R.sec_range), trim(R.city_name),trim(R.st),trim(R.zip ));
	  SELF.dt_last_seen := R.addr_dt_last_seen;
    SELF:= L;
	  SELF:= R;
  end;
	
  Best_Address_List 	:= JOIN(File_Generated_UNQ_PK_DID_Plus_Relatives,File_Generated_FileBest_Subset , 
	                            LEFT.did = RIGHT.did ,
								Join_KeyFile_Header(LEFT,RIGHT), LOCAL);
								

	//Layout_Address_list	 Join_KeyFile_Veh_party (Layout_UNQ_PK_DID_Plus_Relatives L, Layout_Vehicle_Party_slim R) := TRANSFORM
	temp_Layout_Address_list	 Proj_KeyFile_Veh_party ( Layout_Vehicle_Party_slim R) := TRANSFORM
      SELF.Prim_address := '';       
	  SELF.Sec_address  := '';
	  SELF.geo_match    := '';
	  SELF.ConfirmedCurrent := 0;
	  SELF.address_key  :=     HASH32(if(R.prim_range <> '', trim(R.prim_range),'*0^') ,'@#$%', 
		                              if(R.predir     <> '', trim(R.predir),'*0^')     ,'@#$%', 
									  if(R.prim_name  <> '', trim(R.prim_name),'*0^') ,'@#$%', 
									  if(R.addr_suffix<> '', trim(R.addr_suffix),'*0^'),'@#$%', 
		                              if(R.postdir    <> '', trim(R.postdir),'*0^')    ,'@#$%',
									  if(R.unit_desig <> '', trim(R.unit_desig),'*0^') ,'@#$%', 
									  if(R.sec_range  <> '', trim(R.sec_range),'*0^')  ,'@#$%', 
									  if(R.v_city_name<> '', trim(R.v_city_name),'*0^'),'@#$%',
									  if(R.st         <> '', trim(R.st),'*0^')         ,'@#$%',
									  if(R.zip        <> '', trim(R.zip ),'*0^'));
		
		//HASH32(trim(R.prim_range), trim(R.predir), trim(R.prim_name), trim(R.addr_suffix), 
	  //                          trim(R.postdir),trim(R.unit_desig), trim(R.sec_range), trim(R.v_city_name),trim(R.st),trim(R.zip ));
	  SELF.dt_last_seen := 0;
	  SELF.phone        := '';
    //SELF   := L;
	  SELF   := R;
  end;
	
  // Vehicle_Address_List 	:= JOIN(File_Generated_UNQ_PK_DID_Plus_Relatives,File_Generated_vehicle_party_slim , 
	                            // LEFT.did = RIGHT.ppend_did ,
								              // Join_KeyFile_Veh_party(LEFT,RIGHT), LOCAL);			
															
	Vehicle_Address_List  := project(File_Generated_vehicle_party_slim,Proj_KeyFile_Veh_party(LEFT),LOCAL );
		
		
  D_SOR_file := DISTRIBUTE(File_In_SexOffender_Main(did <> 0) ,HASH(did));
  
  temp_Layout_Address_list	 Join_KeyFile_SOR(Layout_UNQ_PK_DID_Plus_Relatives L, Layout_SexOffender_Main R) := TRANSFORM
      SELF.Prim_address := '';       
	  SELF.Sec_address  := '';
	  SELF.geo_match    := '';
	  SELF.ConfirmedCurrent := 0;
	  SELF.zip              := R.zip5;
	  SELF.phone            := '';
	  SELF.address_key      := HASH32(if(R.prim_range <> '', trim(R.prim_range),'*0^') ,'@#$%', 
		                              if(R.predir     <> '', trim(R.predir),'*0^')     ,'@#$%', 
									  if(R.prim_name  <> '', trim(R.prim_name), '*0^') ,'@#$%', 
									  if(R.addr_suffix<> '', trim(R.addr_suffix),'*0^'),'@#$%', 
		                              if(R.postdir    <> '', trim(R.postdir),'*0^')    ,'@#$%', 
									  if(R.unit_desig <> '', trim(R.unit_desig),'*0^') ,'@#$%', 
									  if(R.sec_range  <> '', trim(R.sec_range),'*0^')  ,'@#$%', 
									  if(R.v_city_name<> '', trim(R.v_city_name),'*0^'),'@#$%', 
									  if(R.st         <> '', trim(R.st),'*0^')         ,'@#$%', 
									  if(R.zip5       <> '', trim(R.zip5 ),'*0^'));
		
		//HASH32(trim(R.prim_range), trim(R.predir), trim(R.prim_name), trim(R.addr_suffix), 
	  //                                trim(R.postdir),trim(R.unit_desig), trim(R.sec_range), trim(R.v_city_name),trim(R.st),trim(R.zip5 ));
	  SELF.dt_last_seen     := (integer)R.addr_dt_last_seen;
      SELF:= L;
	  SELF:= R;
  end;
	
  SOR_Address_List 	:= JOIN(File_Generated_UNQ_PK_DID_Plus_Relatives,D_SOR_file, 
	                        LEFT.did = RIGHT.did ,
							Join_KeyFile_SOR(LEFT,RIGHT), LOCAL);																						
																
																
  temp_Layout_Address_list	 change_Gong_layout( Layout_Gong_slim L) := TRANSFORM
      SELF.Prim_address := '';       
	  SELF.Sec_address  := '';
	  SELF.addr_suffix  := L.suffix;
	  SELF.v_city_name  := L.v_city_name;
	  SELF.geo_match    := '';
	  SELF.ConfirmedCurrent := 0;
	  SELF.address_key  := HASH32(if(L.prim_range     <> '', trim(L.prim_range),'*0^'),'@#$%',
		                          if(L.predir         <> '', trim(L.predir),'*0^')    ,'@#$%',
								  if(L.prim_name      <> '', trim(L.prim_name),'*0^') ,'@#$%',
								  if(L.suffix         <> '', trim(L.suffix),'*0^')    ,'@#$%', 
		                          if(L.postdir        <> '', trim(L.postdir),'*0^')   ,'@#$%',
								  if(L.unit_desig     <> '', trim(L.unit_desig),'*0^'),'@#$%',
								  if(L.sec_range      <> '', trim(L.sec_range),'*0^') ,'@#$%',
								  if(L.v_city_name    <> '', trim(L.v_city_name),'*0^') ,'@#$%',
								  if(L.st             <> '', trim(L.st),'*0^')        ,'@#$%',
								  if(L.z5             <> '', trim(L.z5 ),'*0^'));
		
		//HASH32(trim(L.prim_range), trim(L.predir), trim(L.prim_name), trim(L.suffix), 
	  //                          trim(L.postdir),trim(L.unit_desig), trim(L.sec_range), trim(L.city_name),trim(L.st),trim(L.zip ));
	  SELF.dt_last_seen := 0;
	  SELF.zip 			:= L.Z5;
	  SELF.phone        := '';
	  SELF:= L;
  end;
	
  Gong_Address_List 	:= PROJECT (File_generated_Gong_slim_subset(z4 <> '') , change_Gong_layout(LEFT), LOCAL);
								
  temp_Layout_Address_list	 Join_KeyFile_Phoneplus(Layout_UNQ_PK_DID_Plus_Relatives L, Layout_Phonesplus_Slim R) := TRANSFORM
      SELF.Prim_address     := '';       
	  SELF.Sec_address      := '';
	  SELF.addr_suffix      := R.addr_suffix;
	  SELF.v_city_name      := R.v_city_name;
	  SELF.geo_match        := '';
	  SELF.ConfirmedCurrent := 0;
	  SELF.address_key      := HASH32(  if(R.prim_range <> '', trim(R.prim_range),'*0^'),'@#$%',
		                                if(R.predir     <> '', trim(R.predir),'*0^')    ,'@#$%',
										if(R.prim_name  <> '', trim(R.prim_name),'*0^') ,'@#$%',
										if(R.addr_suffix<> '', trim(R.addr_suffix),'*0^')    ,'@#$%', 
		                                if(R.postdir    <> '', trim(R.postdir),'*0^')   ,'@#$%',
										if(R.unit_desig <> '', trim(R.unit_desig),'*0^'),'@#$%',
										if(R.sec_range  <> '', trim(R.sec_range),'*0^') ,'@#$%',
										if(R.v_city_name<> '', trim(R.v_city_name),'*0^') ,'@#$%',
										if(R.state      <> '', trim(R.state),'*0^')        ,'@#$%',
										if(R.zip5       <> '', trim(R.zip5 ),'*0^'));
		
		//HASH32(trim(R.prim_range), trim(R.predir), trim(R.prim_name), trim(R.suffix), 
	  //                          trim(R.postdir),trim(R.unit_desig), trim(R.sec_range), trim(R.city_name),trim(R.st),trim(R.zip ));
	  SELF.dt_last_seen := 0;
	  SELF.st           := R.state;
	  SELF.zip 			:= R.Zip5;
	  SELF.phone        := '';
      SELF:= L;
	  SELF:= R;
  end;
	
  Phplus_Address_List 	:= JOIN(File_Generated_UNQ_PK_DID_Plus_Relatives,File_Generated_Phonesplus_slim_subset(zip4 <> '') , 
	                            LEFT.did = RIGHT.did ,
								Join_KeyFile_Phoneplus(LEFT,RIGHT), LOCAL);
															
  Combined_Address_list := Address_List+Best_Address_List+Vehicle_Address_List+SOR_Address_List+
	                       Gong_Address_list+Phplus_Address_List;  
																		
																	
export Mapping_address_preprocess := Combined_Address_list : Persist ('persist::IMAP::Temp_Address_List');