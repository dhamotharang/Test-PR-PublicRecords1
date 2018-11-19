import std;

file_office_flat_ds := file_office_flat;

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

department_ds:=ares.files.ds_department;

layout_department_id := RECORD(recordof(ares.files.ds_department))
	STRING parsed_office_id;
END;

layout_department_id deparment_xform(RECORDOF(department_ds) L) := TRANSFORM
	SELF.parsed_office_id := IF(L.summary.office.link_href != '', std.str.splitwords(L.summary.office.link_href,'/')[3], '');
	SELF := L;
END;

//get all the departments
departments_with_office_ids := project(department_ds ,deparment_xform(LEFT));

layout_department_id office_department_xform (RECORDOF(file_office_flat_ds) L, RECORDOF(departments_with_office_ids) R):= TRANSFORM
	SELF.parsed_office_id := L.id;
	SELF := R;
END;

//join departments and office
office_ds := join(file_office_flat_ds,departments_with_office_ids, LEFT.id = RIGHT.parsed_office_id, office_department_xform(LEFT,RIGHT));

STRING findDepartmentCode(STRING _type) := FUNCTION
	  STRING code := ares.files.ds_lookup(fid ='DEPARTMENT_TYPE').lookupbody(id = _type)[1].tfpid;
		RETURN code;
END;

department_list := sort(Ares.Files.ds_lookup(fid ='DEPARTMENT_TYPE').lookupBody(tfpid != ''), tfpid); 

codes_layout := RECORD(RECORDOF(office_ds))
	STRING dept_code := '';
END;

codes_layout with_codes_xform(RECORDOF(office_ds) L, department_list R) := TRANSFORM
	SELF.dept_code := R.tfpid;
	SELF := L;
END;

office_with_dept_codes_ds:= JOIN(office_ds,department_list, LEFT.summary.types[1].type = RIGHT.id, with_codes_xform(LEFT,RIGHT));

layout_office office_xform_ (file_office_flat_ds L, office_with_dept_codes_ds R) := TRANSFORM
	SELF.office_tfpuid := L.tfpuid;
	//NOTE: intentionally added a space to value MAIN, A.A
	SELF.office_department := IF(L.tfpid != '',R.dept_code, 'MAIN '); 
	SELF.office_Contact_Type := convertToCodes(L.locations.telecom[1].type);
	SELF.office_Contact_Information := std.str.FilterOut(L.locations.telecom[1].value,'+');												
	SELF:= L;
END;

office_result :=  join(file_office_flat_ds,office_with_dept_codes_ds, LEFT.id = RIGHT.parsed_office_id,office_xform_(LEFT,RIGHT));

layout_contacts := RECORD
	STRING Update_Flag;
	STRING Primary_Key;
	STRING Accuity_Location_ID;
	STRING Department := '';
	STRING Contact_Type;
	STRING Contact_Information;
	STRING Filler;
END;

layout_contacts final_xform(office_result L) := Transform
	SELF.Update_Flag := 'A';
	SELF.Primary_Key := '';
	SELF.Accuity_Location_ID := L.office_tfpuid;
	SELF.Department := L.office_department;
	SELF.Contact_Type := L.office_Contact_Type;
	SELF.Contact_Information := L.office_Contact_Information;
	SELF.Filler :='';
End;

final	:= PROJECT(office_result,final_xform(LEFT));

EXPORT file_gpcontacts := final;

