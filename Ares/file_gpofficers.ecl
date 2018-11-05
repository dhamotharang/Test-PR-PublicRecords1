import std;

Relationship_ds := Files.ds_relationship;

layout_position := RECORD(recordof(Relationship_ds.details.employment.positions))
	string relationship_id := '';
END;
//find Accuity Location ID
layout_position xform(recordof(Relationship_ds.details.employment.positions) r, string id) := transform
	self.relationship_id := id;
	self:=r;
end;

//get the positions
positions :=  normalize(Relationship_ds,left.details.employment.positions,xform(right, left.id));

//get the office id from the href field under office
officers_office_id_layout := Record(layout_position)
	string officeId := '';
END;

officers_office_id_layout office_xform(positions L) := TRANSFORM
	self.officeId := if(L.office[1].href != '', std.str.splitwords(L.office[1].href,'/')[3], '');
	self := L;
END;

//get the all the office id for each positions
officers_office_ids := project(positions, office_xform(LEFT));

Accuity_Location_ID_layout:= RECORD(recordof(officers_office_ids))
	STRING Accuity_Location_ID;
END;
//TODO: use file officd flat
Accuity_Location_ID_layout office_location_xform (officers_office_ids L, recordof(Ares.Files.ds_office) R) := TRANSFORM
//missing fileds	
	SELF.Accuity_Location_ID := R.tfpuid;
	SELF:=L;
END;
//TODO use flat file for office.
Accuity_Location_IDs := join(officers_office_ids, Ares.Files.ds_office, LEFT.officeId = right.id, office_location_xform(left, right));

with_department_layout := RECORD
	Accuity_Location_IDs.positionCategory;
	Accuity_Location_IDs.relationship_id;
	Accuity_Location_IDs.officeid;
	Accuity_Location_IDs.accuity_location_id;
	STRING departmen_type := '';
	STRING job_Title := '';
END;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
with_department_layout department_xform(Accuity_Location_IDs L) := TRANSFORM
	SELF.departmen_type := L.department.types.types[1].department_types_type;
	SELF.job_Title := L.jobTitle;
	SELF := L;
END;

Department_Function := project(Accuity_Location_IDs, department_xform(LEFT));
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Find 	Officer Name
layout_party := RECORD(recordof(Relationship_ds.parties.party))
	string relationship_id := '';
END;

//parties_layout := recordof(Relationship_ds.parties);
// recordof(Relationship_ds.parties.party) parties_xform(recordof(Relationship_ds.parties.party) r ) := transform
	// self:=r;
// end;
layout_party parties_xform(recordof(Relationship_ds.parties.party) r, string id) := transform
	self.relationship_id := id;
	self:=r;
end;

//parties :=  normalize(Relationship_ds,left.parties.party, parties_xform(right, left.id));
parties :=  normalize(Relationship_ds,left.parties.party, parties_xform(right, left.id));


//filter by employee type
parties_type_employee_list := parties(partyType='employee');

parties_type_employee_layout := RECORD
	STRING party_type := '';
	STRING entity_reference := '';
	STRING relationship_id := '';
END;

parties_type_employee_layout parties_type_xfrom(parties_type_employee_list L) := TRANSFORM
	SELF.party_type := L.partyType;
	SELF.entity_reference := if(L.entityReference[1].href != '', std.str.splitwords(L.entityReference[1].href,'/')[3], '');
	SELF.relationship_id := L.relationship_id;
END;

//good up to here
employee_id_list := project(parties_type_employee_list, parties_type_xfrom(LEFT));

officer_name_layout := RECORD
	STRING given_name := '';
	STRING surname := '';
	STRING relationship_id :='';
END;

officer_name_layout officer_name_xform (employee_id_list L,recordof(Ares.Files.ds_person) R) := TRANSFORM
	SELF.given_name := R.summary.names[1].givenName;
	SELF.surname := R.summary.names[1].surname_value;
	SELF.relationship_id := L.relationship_id;
END;

//Accuity_Location_IDs := join(officers_office_ids, Ares.Files.ds_office, right.tfpuid !='' AND LEFT.officeId = right.id, office_location_xform(right));
Officer_Name := join(employee_id_list, Ares.Files.ds_person, LEFT.entity_reference = right.id, officer_name_xform(left,right));

// officer_name_layout officer_name_xform (recordof(Ares.Files.ds_person) L) := TRANSFORM
	// SELF.given_name := L.summary.names[1].givenName;
	// SELF.surname := L.summary.names[1].surname_value;
	// SELF.relationship_id := L.relationship_id;
// END;

//NOTE: this was ommented out already Accuity_Location_IDs := join(officers_office_ids, Ares.Files.ds_office, right.tfpuid !='' AND LEFT.officeId = right.id, office_location_xform(right));
// Officer_Name := join(employee_id_list, Ares.Files.ds_person, LEFT.entity_reference = right.id, officer_name_xform(right));
/////////////////////////////////////////////////////////////////////////////////////////////////////////
layout_gpofficers := RECORD
	STRING Update_Flag;
	STRING Primary_Key;
	STRING Accuity_Location_ID;
		//TODO translate deparmtnes
	STRING Department := '';
	STRING Officer_Name;
END;



layout_gpofficers final_xform(Officer_Name L, Department_Function R ) := Transform
	SELF.Update_Flag := 'A';
	SELF.Primary_Key := '';
	SELF.Accuity_Location_ID := R.Accuity_Location_ID;
	// SELF.Department;
	SELF.Officer_Name:=L.given_name + ' ' + L.surname;
End;

final := join(Officer_Name, Department_Function, LEFT.relationship_id = right.relationship_id, final_xform(left,right));



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Accuity_Location_IDs
//EXPORT file_gpofficers := Accuity_Location_IDs;

//Department_Function
//EXPORT file_gpofficers := Department_Function;

/////////////////////////////////////////////
//Officer_Name
//EXPORT file_gpofficers := parties_type_employee_list;
//EXPORT file_gpofficers := employee_id_list;
//EXPORT file_gpofficers := Officer_Name;

EXPORT file_gpofficers := final;


