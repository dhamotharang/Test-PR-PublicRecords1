	D_Vehicle_registration       := DISTRIBUTE(Files_Used.vehicle_party_file,HASH(append_did));


  Layout_Vehicle_Party_slim Join_DID_VehicleFile (Layout_UNQ_PK_DID_Plus_Relatives L , Files_Used.Layout_vehicle_party R) := TRANSFORM
  //Layout_Vehicle_Party_slim Change_Layout (Files_Used.Layout_vehicle_party L) := TRANSFORM
    
		SELF.fname 				:= R.Append_Clean_Name.fname;
    SELF.mname 				:= R.Append_Clean_Name.mname;
    SELF.lname 				:= R.Append_Clean_Name.lname;
    SELF.name_suffix 	:= R.Append_Clean_Name.name_suffix;
		SELF.prim_range   := R.Append_Clean_Address.prim_range;	
		SELF.predir 		  := R.Append_Clean_Address.predir;																								
		SELF.prim_name 	  := R.Append_Clean_Address.prim_name;
		SELF.addr_suffix  := R.Append_Clean_Address.addr_suffix; 																							
		SELF.postdir		  := R.Append_Clean_Address.postdir;																								
		SELF.unit_desig   := R.Append_Clean_Address.unit_desig;																								
		SELF.sec_range    := R.Append_Clean_Address.sec_range;																								
		SELF.v_city_name  := R.Append_Clean_Address.v_city_name; 																							
		SELF.st					  := R.Append_Clean_Address.st;			
		SELF.zip				  := R.Append_Clean_Address.zip5;		
		SELF.geo_match    := R.Append_Clean_Address.geo_match;
		SELF	:=	R;
    SELF	:=	L;

  end;		
	
 J_Vehicle_Party_slim := JOIN( File_Generated_UNQ_PK_DID_Plus_Relatives,D_Vehicle_registration, 
                               LEFT.did = RIGHT.Append_DID ,
							                 Join_DID_VehicleFile(LEFT,RIGHT),LOCAL);

 S_Vehicle_party_slim := sort(J_Vehicle_Party_slim,persistent_key,did,relative_flag,vehicle_key,iteration_key,
                                prim_range,predir,predir,prim_name,prim_name,addr_suffix,postdir,v_city_name, 																							
																st,zip,orig_name_type,LOCAL); 

Layout_Vehicle_Party_slim Pick_ttl_WhenRegNotFound(Layout_Vehicle_Party_slim L,Layout_Vehicle_Party_slim R) := TRANSFORM

 SELF := R; //keeping the R rec would make it KEEP(1),RIGHT

END;

Rolledup_vehicle_slim := ROLLUP(S_Vehicle_party_slim,
                                LEFT.persistent_key = RIGHT.persistent_key and 
																LEFT.did = RIGHT.did and 
																LEFT.relative_flag = RIGHT.relative_flag and 
                                LEFT.vehicle_key = RIGHT.vehicle_key and
																LEFT.iteration_key = RIGHT.iteration_key and
																LEFT.prim_range   = RIGHT.prim_range and	
																LEFT.predir 		  = RIGHT.predir and																								
																LEFT.prim_name 	  = RIGHT.prim_name and
																LEFT.addr_suffix  = RIGHT.addr_suffix and 																							
																LEFT.postdir		  = RIGHT.postdir and																								
																LEFT.v_city_name  = RIGHT.v_city_name and 																							
																LEFT.st					  = RIGHT.st and			
																LEFT.zip				  = RIGHT.zip and		
																LEFT.orig_name_type = '1' and RIGHT.orig_name_type ='4',
																Pick_ttl_WhenRegNotFound(LEFT,RIGHT),LOCAL);								 
																
 //J_Vehicle_Party_slim   := PROJECT( Files_Used.vehicle_party_file,Change_Layout(LEFT));                             
 //D_Vehicle_party_slim   := Distribute(J_Vehicle_Party_slim, HASH(append_did));
	
export File_Generated_vehicle_party_slim := Rolledup_vehicle_slim : persist ('persist::Imap::Vehicle_Party_Slim');

