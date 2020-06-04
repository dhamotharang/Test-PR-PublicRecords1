import AutoKeyB2,PAW, header_services, Autokey, ut; 

export Proc_Build_Autokey(

	 string													pversion 
	,dataset(LAYOUT.Employment_Out) pBase			= PAW.File_base_CleanAddr_Keybuild

) :=
FUNCTION

	emp_all_full_out_suppress := paw.Prep_Build.applyEmploymentSup(pBase);

	File_To_Process_To_Key := paw.Prep_Build.applyEmploymentInj(emp_all_full_out_suppress);
	
	b := file_SearchAutokey(File_To_Process_To_Key);
 
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
						COMPANY_name,
						companY_fein,
						company_phone,
						Bus_addr.prim_name,Bus_addr.prim_range,Bus_addr.st,Bus_addr.p_city_name,Bus_addr.zip5,Bus_addr.sec_range,
						bdid,
						keynames(pversion).root.template,
						keynames(pversion).root.Logical,
						outaction,false,
						[],true,'PAW',
						true,,,contact_id,true) 
						

	retval :=
	sequential(
		 outaction
	);
	 
	return retval;

end;