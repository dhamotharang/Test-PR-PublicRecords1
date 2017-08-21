  import ut;
	
	
  D_Vehicle_party_List := File_Generated_vehicle_party_slim;
	//D_Vehicle_party_List := dataset('~thor400_88_staging::persist::Imap::Vehicle_Party_Slim',SOFF_ReSOLT_Integration.Layout_Vehicle_Party_slim,flat);
	
	Layout_vehicle_list_temp := record
	Layout_Vehicle_list;
	Files_used.Layout_vehicle_party.Iteration_Key;
	end;
	
	Layout_vehicle_list_temp Project_veh(Layout_Vehicle_Party_slim L) := TRANSFORM
    
	  SELF.vina_vin := '';
    SELF.VINA_Model_Year := '';
    SELF.VINA_Make_Desc :='';
    SELF.VINA_Model_Desc:= '';
    SELF.VINA_Series_Desc := '';
	  //SELF:=R;
		SELF.address_key :=0;
	  SELF:=L;
	
  end;	
	
	J_Vehicle_reg_list:= PROJECT(D_Vehicle_party_List,Project_veh(LEFT),LOCAL ) ;
	
D_vehicle_main_file := distribute(Files_used.vehicle_main_file, hash(vehicle_key,iteration_key));
D_Vehicle_reg_list  := distribute(J_Vehicle_reg_list, hash(vehicle_key,iteration_key));

  Layout_vehicle_list_temp Join_Party_main(Layout_vehicle_list_temp L, Files_used.Layout_vehicle_main R) := TRANSFORM
    SELF.vina_vin        := IF (R.vina_vin         <> '', R.vina_vin, R.orig_vin);
    SELF.VINA_Model_Year := IF (R.VINA_Model_Year  <> '', R.VINA_Model_Year , R.orig_Year);
    SELF.VINA_Make_Desc  := IF (R.VINA_Make_Desc   <> '', R.VINA_Make_Desc  , R.orig_Make_Desc);
    SELF.VINA_Model_Desc := IF (R.VINA_Model_Desc  <> '', R.VINA_Model_Desc , R.orig_Model_Desc);
    SELF.VINA_Series_Desc:= IF (R.VINA_Series_Desc <> '', R.VINA_Series_Desc, R.orig_Series_Desc);
	//SELF:=R;
	SELF:=L;

  end;	
	
	J_Vehicle_list  	    := JOIN(D_Vehicle_reg_list, D_vehicle_main_file, 
	                              trim(LEFT.vehicle_key) = trim(RIGHT.vehicle_key) and
																trim(LEFT.iteration_key) = trim(RIGHT.iteration_key),								                
								                Join_Party_main(LEFT,RIGHT),LEFT OUTER,LOCAL);		
										
	//JS_Vehicle_list       := SORT(J_Vehicle_list,RECORD,LOCAL);
	//JS_vehicle_list_dedup := DEDUP(JS_Vehicle_list,RECORD,LOCAL);
	DJ_vehicle_list  := distribute(J_Vehicle_list, hash(Persistent_key));
  JS_Vehicle_list  := sort(DJ_vehicle_list,Persistent_key,did,seisint_primary_key,Relative_flag,vehicle_key,vina_vin,VINA_Model_Year,VINA_Make_Desc,VINA_Model_Desc,
                    VINA_Series_Desc,fname,mname,lname,name_suffix,prim_range,predir,prim_name,addr_suffix, postdir,unit_desig,sec_range,v_city_name, 
										st,zip,geo_match,Reg_License_Plate,Reg_Latest_Effective_Date,Reg_Latest_Expiration_Date,Reg_License_State,local);
  JS_vehicle_list_dedup:= dedup(JS_Vehicle_list,Persistent_key,did,seisint_primary_key,Relative_flag,vehicle_key,vina_vin,VINA_Model_Year,VINA_Make_Desc,VINA_Model_Desc,
                    VINA_Series_Desc,fname,mname,lname,name_suffix,prim_range,predir,prim_name,addr_suffix, postdir,unit_desig,sec_range,v_city_name, 
										st,zip,geo_match,
										ut.NNEQ(left.Reg_License_Plate , right.Reg_License_Plate ),right,local)		;

	D_address := distribute(Mapping_Extract_Address_List, hash(Persistent_key,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip));
  D_vehicle := distribute(JS_vehicle_list_dedup,hash(Persistent_key,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip));


Layout_Vehicle_list GetvehiclesinSOffender_address(D_address L, D_vehicle R) := transform
SELF.address_key  := L.address_key;
SELF := R;

end;

vehicle_with_address_key := join(D_address(relative_flag =0 ) , D_vehicle , 
                        left.Persistent_key = right.Persistent_key and
                        left.prim_range = right. prim_range and
												left.predir = right.predir and
												left.prim_name = right.prim_name and
												left.addr_suffix = right.addr_suffix and
												left.postdir = right.postdir and
												left.unit_desig = right.unit_desig and
												left.sec_range = right.sec_range and
												left.v_city_name = right.v_city_name and 
												left.st  = right.st and
											  left.zip =	right.zip		,GetvehiclesinSOffender_address(left,right),right outer, local) ;
																
export Mapping_Extract_Vehicle_list := vehicle_with_address_key : persist ('persist::imap::vehicle_list');
