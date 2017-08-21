import AutoKeyB2; 

export Proc_Build_autokey  (string filedate,string source) := function

B:= if(source='DEADCO',file_deadco_SearchAutokey,File_ABuIS_SearchAutokey);



AutoKeyB2.MAC_Build (b,
					person_name.fname,person_name.mname,person_name.lname,
					ssn,
					zero,
					phone,
					person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,
					DID,
					company_name,
					zero,
					phone,
					company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
					bdid,
					Constant(filedate,source).ak_keyname,
					Constant(filedate,source).ak_logical,
					outaction,false,
					[],true,'BC',
					true,,,zero) 
AutoKeyB2.MAC_AcceptSK_to_QA('~thor_data400::key::INFOUSA::'+source+'::autokey::', mymove)

retval := sequential(outaction,mymove);

 
return retval;

end;