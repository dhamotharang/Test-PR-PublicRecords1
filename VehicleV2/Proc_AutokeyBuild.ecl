import AutoKeyB2, VehicleV2; 

export Proc_AutokeyBuild(string filedate) := function

d2 := VehicleV2.file_SearchAutokey_party;

skip_set := vehiclev2.Constant.autokey_skip_set;

AutoKeyB2.MAC_Build (d2,person_name.fname,person_name.mname,person_name.lname,
						Append_ssn,
						zero,
						zero,
						person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookup_bit,
						Append_DID,
						Append_Clean_CName,
						Append_FEIN,
						zero,
						company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
						Append_BDID,
						VehicleV2.constant.str_AutokeyName,
						VehicleV2.constant.str_AutokeyLogicalName(filedate),
						outaction,false,
						skip_set,true,'BC',
						true,,,zero); 


AutoKeyB2.MAC_AcceptSK_to_QA(VehicleV2.constant.Str_autokeyName,mymove)
r := sequential(outaction,mymove);
 
return r;

end;
