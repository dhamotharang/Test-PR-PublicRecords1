import AutoKeyB2,ln_propertyv2; 

export proc_build_autokeys_fcra(string filedate) := function

ak_dataset := Constants_fcra.ak_dataset;
ak_keyname := Constants_fcra.ak_keyname;
ak_logical := Constants_fcra.ak_logical(filedate);
ak_skipSet := Constants_fcra.ak_skipSet;
ak_typeStr := Constants_fcra.ak_typeStr;

AutoKeyB2.MAC_Build (ak_dataset,
					person_name.fname,person_name.mname,person_name.lname,
					app_SSN,
					zero,
					phone,
					person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					lookups,
					DID,
					cname,
					app_tax_id,
					bphone,
					company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
					bdid,
					ak_keyname,
					ak_logical,
					outaction,false,
					ak_skipSet,true,ak_typeStr,
					true,,,zero) 

AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove)

retval := sequential(outaction,mymove);

 
return retval;

end;
