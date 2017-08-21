import AutoKeyB2,FBNV2; 

export Proc_Build_Autokeys(
	string filedate, 
	dataset(Layouts.business) Business_base_2,
	dataset(Layouts.contact) contact_base_2
	) :=
FUNCTION
 
b := FBNV2.file_SearchAutokey(business_base_2, Contact_base_2): independent;

bdedup:=dedup(b,All);

AutoKeyB2.MAC_Build (bdedup,
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
					constants.ak_keyname,
					constants.ak_logical(filedate),
					bld_auto_keys,false,
					[],true,'BC',
					true,,,zero) 
					

AutoKeyB2.MAC_AcceptSK_to_QA(Constants.ak_keyname, mymove)

retval := sequential(bld_auto_keys,mymove);

return retval;

end;