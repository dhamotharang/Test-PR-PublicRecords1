import std;

file_office_flat_ds := file_office_flat;
department_ds:=ares.files.ds_department;
layout_tel := RECORDOF(department_ds.locations.telecom)or RECORDOF(file_office_flat_ds.locations.telecom);

layout_office := RECORD
	STRING office_tfpuid;
	STRING office_department; 
END;

layout_department_id := RECORD(recordof(ares.files.ds_department))
	STRING parsed_office_id;
	STRING office_tfpuid :='';
  STRING office_department := '';
 	DATASET(layout_tel) office_telecom := DATASET([],layout_tel);
	DATASET(layout_tel) department_telecom := DATASET([],layout_tel);
END;

layout_department_id deparment_xform(RECORDOF(department_ds) L) := TRANSFORM
	SELF.parsed_office_id := IF(L.summary.office.link_href != '', std.str.splitwords(L.summary.office.link_href,'/')[3], '');
	SELF := L;
END;

//get all the departments
departments_with_office_ids := project(department_ds ,deparment_xform(LEFT));

layout_department_id office_department_xform (RECORDOF(file_office_flat_ds) L, RECORDOF(departments_with_office_ids) R):= TRANSFORM
	SELF.parsed_office_id := L.id;
	SELF.office_tfpuid := L.tfpuid;
  SELF.office_telecom := project(L.locations(primary='true').telecom,TRANSFORM(layout_tel, SELF := LEFT, SELF := []));	
	SELF.department_telecom :=project(R.locations(primary='true').telecom,TRANSFORM(layout_tel, SELF := LEFT, SELF := []));
	SELF := R;
END;

//join departments and office
office_with_dpt_ds := join(file_office_flat_ds,departments_with_office_ids, LEFT.id = RIGHT.parsed_office_id, office_department_xform(LEFT,RIGHT));

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

STRING convertToCodes(STRING type_) := FUNCTION
		STRING code := ares.files.ds_lookup(fid ='TELECOM_TYPE').lookupbody(id = type_)[1].id;
		STRING result := IF(std.str.EqualIgnoreCase(code,'telephone'),'tel',code);
	RETURN result;
END;

layout_w_telecom telecoms_xform(layout_tel L, STRING id, STRING dptCode, STRING tfpuid):= TRANSFORM
	SELF.office_id := id;
	SELF.dpt_code := dptCode;
	SELF.office_tfpuid := tfpuid;
	SELF.type := convertToCodes(L.type);
	SELF.value := MAP(L.phonecountrycode = '1' => L.phonecountrycode + '-' + L.phoneareacode + '-' + L.phonenumber[1..3] + '-' + L.phonenumber[4..7],
										L.phonecountrycode != '' => L.phonecountrycode + '-' + L.phoneareacode + '-' + L.phonenumber,
										L.value);
	SELF := L;
END;

department_telecoms_normed := normalize(office_with_dept_codes_ds,LEFT.department_telecom, telecoms_xform(RIGHT, LEFT.parsed_office_id, LEFT.office_department, LEFT.office_tfpuid));
//NOTE: for all offices use Main.
office_telecoms_normed := normalize(office_with_dept_codes_ds,LEFT.office_telecom, telecoms_xform(RIGHT, LEFT.parsed_office_id, 'MAIN', LEFT.office_tfpuid));

result := department_telecoms_normed + office_telecoms_normed;
sorted_result := SORT(result,RECORD);
deduped_result := DEDUP (sorted_result,RECORD);

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

final	:= PROJECT(deduped_result,final_xform(LEFT));

EXPORT file_gpcontacts := final;





