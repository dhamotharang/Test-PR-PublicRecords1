import std;

file_office_flat_ds := file_office_flat;
department_ds:=ares.files.ds_department;
layout_tel := RECORDOF(department_ds.locations.telecom)or RECORDOF(file_office_flat_ds.locations.telecom);

layout_office := RECORD
	STRING office_tfpuid;
	STRING office_department; 
	STRING office_Contact_Type;
	STRING office_Contact_Information;
END;

STRING convertToCodes(STRING type_) := FUNCTION
		STRING code:=ares.files.ds_lookup(fid ='TELECOM_TYPE').lookupbody(id = type_)[1].id;
	RETURN code;
END;

layout_department_id := RECORD(recordof(ares.files.ds_department))
	STRING parsed_office_id;
	STRING office_tfpuid :='';
  STRING office_department := '';
  STRING office_Contact_Type := '';
  STRING office_Contact_Information :='';
	DATASET(layout_tel) office_telecom := DATASET([],layout_tel);
	DATASET(layout_tel) department_telecom := DATASET([],layout_tel);
END;

layout_department_id deparment_xform(RECORDOF(department_ds) L) := TRANSFORM
	SELF.parsed_office_id := IF(L.summary.office.link_href != '', std.str.splitwords(L.summary.office.link_href,'/')[3], '');
	SELF := L;
END;

//get all the departments
departments_with_office_ids := project(department_ds ,deparment_xform(LEFT));

output(departments_with_office_ids, NAMED('departments_with_office_ids'));

layout_department_id office_department_xform (RECORDOF(file_office_flat_ds) L, RECORDOF(departments_with_office_ids) R):= TRANSFORM
	SELF.parsed_office_id := L.id;
	SELF.office_tfpuid := L.tfpuid;
  //NOTE: intentionally added a space to value MAIN, A.A
  SELF.office_Contact_Type := convertToCodes(L.locations.telecom[1].type);
  SELF.office_Contact_Information := std.str.FilterOut(L.locations.telecom[1].value,'+');   
	
	//SELF.office_telecom := project(L.locations.telecom,TRANSFORM(layout_tel, SELF := LEFT, SELF := []));
	//SELF.office_telecom := IF(L.locations[1].primary ='true',project(L.locations.telecom,TRANSFORM(layout_tel, SELF := LEFT, SELF := [])));
   SELF.office_telecom := project(L.locations(primary='true').telecom,TRANSFORM(layout_tel, SELF := LEFT, SELF := []));	
	
	
	//SELF.department_telecom := project(R.locations.telecom,TRANSFORM(layout_tel, SELF := LEFT, SELF := []));
	//SELF.department_telecom :=IF(R.locations[1].primary = 'true', project(R.locations.telecom,TRANSFORM(layout_tel, SELF := LEFT, SELF := [])));
	//SELF.department_telecom :=IF(R.locations(primary='true'), project(R.locations.telecom,TRANSFORM(layout_tel, SELF := LEFT, SELF := [])));
	SELF.department_telecom :=project(R.locations(primary='true').telecom,TRANSFORM(layout_tel, SELF := LEFT, SELF := []));
	SELF := R;
END;

//join departments and office
office_with_dpt_ds := join(file_office_flat_ds,departments_with_office_ids, LEFT.id = RIGHT.parsed_office_id, office_department_xform(LEFT,RIGHT));
output(office_with_dpt_ds, NAMED('office_with_dpt_ds'));
output(office_with_dpt_ds(parsed_office_id='00009619-ee94-4dd5-8747-08b4d27137b0'));

STRING findDepartmentCode(STRING _type) := FUNCTION
	  STRING code := ares.files.ds_lookup(fid ='DEPARTMENT_TYPE').lookupbody(id = _type)[1].tfpid;
		RETURN code;
END;

//get a list of all the departments.
department_list := sort(Ares.Files.ds_lookup(fid ='DEPARTMENT_TYPE').lookupBody(tfpid != ''), tfpid); 

layout_department_id with_codes_xform(RECORDOF(office_with_dpt_ds) L, department_list R) := TRANSFORM
	SELF.office_department := if(R.tfpid='', 'MAIN', R.tfpid);
  SELF := L;
END;

//add the department codes to each office record.
office_with_dept_codes_ds:= JOIN(office_with_dpt_ds,department_list, LEFT.summary.types[1].type = RIGHT.id, with_codes_xform(LEFT,RIGHT));

OUTPUT(office_with_dept_codes_ds, NAMED('office_with_dept_codes_ds'));
OUTPUT(office_with_dept_codes_ds(parsed_office_id='00009619-ee94-4dd5-8747-08b4d27137b0'), NAMED('office_with_dept_codes_ds_count'));

layout_w_telecom := RECORD
  STRING office_id;
	STRING dpt_code;
	STRING office_tfpuid;
	STRING phoneCountryCode;
	STRING phoneAreaCode;
	STRING phoneNumber;
	STRING value;
	STRING type;
end;

layout_w_telecom telecoms_xform(layout_tel L, STRING id, STRING dptCode, STRING tfpuid):= TRANSFORM
	SELF.office_id := id;
	SELF.dpt_code := dptCode;
	SELF.office_tfpuid := tfpuid;
	SELF := L;
END;

department_telecoms_normed := normalize(office_with_dept_codes_ds,LEFT.department_telecom, telecoms_xform(RIGHT, LEFT.parsed_office_id, LEFT.office_department, LEFT.office_tfpuid));
office_telecoms_normed := normalize(office_with_dept_codes_ds,LEFT.office_telecom, telecoms_xform(RIGHT, LEFT.parsed_office_id, LEFT.office_department, LEFT.office_tfpuid));

OUTPUT(department_telecoms_normed, NAMED('department_telecoms_normed'));
output(department_telecoms_normed(office_id='00009619-ee94-4dd5-8747-08b4d27137b0'));

OUTPUT(office_telecoms_normed, NAMED('office_telecoms_normed'));
output(office_telecoms_normed(office_id='00009619-ee94-4dd5-8747-08b4d27137b0'));

result := department_telecoms_normed + office_telecoms_normed;
sorted_result := SORT(result,RECORD);
deduped_result := DEDUP (sorted_result,RECORD);
									
OUTPUT(SORT(result,office_id), NAMED('final_result'));
output(SORT(result(office_id='00009619-ee94-4dd5-8747-08b4d27137b0'), phonenumber, dpt_code));

OUTPUT(deduped_result, NAMED('deduped_result'));
output(SORT(deduped_result(office_id='00009619-ee94-4dd5-8747-08b4d27137b0'),dpt_code, phonenumber ), NAMED('deduped_output'));

layout_contacts := RECORD
	STRING Update_Flag;
	STRING Primary_Key;
	STRING Accuity_Location_ID;
	STRING Department := '';
	STRING Contact_Type;
	STRING Contact_Information;
	STRING Filler;
END;

layout_contacts final_xform(result L) := Transform
	SELF.Update_Flag := 'A';
	SELF.Primary_Key := '';
	SELF.Accuity_Location_ID := L.office_tfpuid;
	SELF.Department := L.dpt_code;
	SELF.Contact_Type := L.type;
	SELF.Contact_Information := L.value;
	SELF.Filler :='';
End;

final	:= PROJECT(result,final_xform(LEFT));

//EXPORT file_gpcontacts := file_office_flat_ds;
//EXPORT file_gpcontacts :=department_ds;
//EXPORT file_gpcontacts := departments_with_office_ids;
//EXPORT file_gpcontacts := office_ds;
//EXPORT file_gpcontacts := department_list;
//output(count(office_with_dept_codes_ds(tfpid='50196020'));
//EXPORT file_gpcontacts := office_with_dept_codes_ds;
//EXPORT file_gpcontacts :=telecoms_normed;
//EXPORT file_gpcontacts :=ds;

//EXPORT file_gpcontacts :=locations;
//EXPORT file_gpcontacts :=result;
//EXPORT file_gpcontacts :=deduped_result;

//EXPORT file_gpcontacts := combinedResults;
//EXPORT file_gpcontacts := combinedResults_deduped;

//EXPORT file_gpcontacts := office_result;
//EXPORT file_gpcontacts := final(Accuity_Location_ID='50196020');
//output(sort(final(Accuity_Location_ID='50196020'),department));
EXPORT file_gpcontacts := final;





