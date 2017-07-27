import AutoKeyB2,standard,TAXPro; 

export Proc_Build_Autokey(string filedate	) 
	 :=FUNCTION
	 
rec := record
	
	Layout.taxpro_standard_base.company    	;
	Layout.taxpro_standard_base.tmsid 		;
	Layout.taxpro_standard_base.ssn			;
	Layout.taxpro_standard_base.did			;
	Layout.taxpro_standard_base.bdid		;
	standard.Name name;
	Standard.L_Address.detailed addr;
	unsigned1 zero 					:= 0;
end;

rec Trans(Layout.taxpro_standard_base pInput)
    
 := transform
	
	self 							:= pInput;

END;

b := project(File_Base,Trans(left));  

AutoKeyB2.MAC_Build (b,
					name.fname,name.mname,name.lname,
					ssn,
					zero,
					zero,
					addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,
					DID,
					company,
					zero,
					zero,
					addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
					bdid,
					Constants(filedate).ak_keyname,
					Constants(filedate).ak_logical,
					outaction,
          false, //diffing
					Constants('').ak_skip_set,true,Constants('').ak_typeStr, //skip, use fake ids, typestr
					true,,,zero) //useOnlyRecordIDs

AutoKeyB2.MAC_AcceptSK_to_QA(Constants(filedate).ak_keyname, mymove)

retval := sequential(outaction,mymove);

 
return retval;


end;