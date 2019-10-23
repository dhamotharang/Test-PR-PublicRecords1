import AutoKeyB2; 

export Proc_Build_autokey_deadco_ccpa  (string filedate,string source) := function

B:= file_deadco_SearchAutokey;

skip_set := ['S','F'];

AutoKeyB2.MAC_Build (b,
					name.fname, name.mname, name.lname,
					zero,
					zero,
					phone,
					addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,
					fdid,
					//personal above.  business below
					company_name,
					zero,
					phone,
          addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
					bdid,
					Constant(filedate,source).ak_keyname,
					Constant(filedate,source).ak_logical,
					outaction, false, //diffing
					skip_set, true, 'BC', // use fakes
					true,,,zero); //useOnlyRecordIDs

AutoKeyB2.MAC_AcceptSK_to_QA('~thor_data400::key::INFOUSA::'+source+'::@version@::autokey::', mymove)

retval := sequential(outaction,mymove);

 
return retval;

end;