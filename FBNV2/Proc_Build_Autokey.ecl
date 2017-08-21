import AutoKeyB2,FBNV2; 

export Proc_Build_Autokey(
	string filedate, 
	dataset(Layout_common.business) Business_base,
	dataset(Layout_common.contact) contact_base
	) :=
FUNCTION
 

b := file_SearchAutokey(business_base, Contact_base): independent;

AutoKeyB2.MAC_Build (b,
					person_name.fname,person_name.mname,person_name.lname,
					ssn,
					zero,
					Contact_phone,
					person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,
					DID,
					Bus_name,
					Orig_fein,
					Bus_phone_num,
					Bus_addr.prim_name,Bus_addr.prim_range,Bus_addr.st,Bus_addr.v_city_name,Bus_addr.zip5,Bus_addr.sec_range,
					bdid,
					Constant(filedate).ak_keyname,
					Constant(filedate).ak_logical,
					outaction,false,
					[],true,'BC',
					true,,,zero) 
					

AutoKeyB2.MAC_AcceptSK_to_QA(Constant(filedate).ak_keyname, mymove)

retval := sequential(outaction,mymove);

 
return retval;

end;