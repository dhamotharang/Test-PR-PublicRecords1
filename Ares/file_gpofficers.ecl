import std;

Relationship_ds := Files.ds_relationship;

//find Accuity Location ID
recordof(Relationship_ds.details.employment.positions) xform(recordof(Relationship_ds.details.employment.positions) r ) := transform
	self:=r;
end;

//get the positions
positions :=  normalize(Relationship_ds,left.details.employment.positions,xform(right));

//get the office id from the href field under office
officers_office_id_layout := Record
	string officeId := '';
END;

officers_office_id_layout office_xform(positions L) := TRANSFORM
//TODO what will happen if there is a null or more than one office?
	self.officeId := if(L.office[1].href != '', std.str.splitwords(L.office[1].href,'/')[3], '');
END;

//get the all the office id for each positions
officers_office_ids := project(positions, office_xform(LEFT));

Accuity_Location_ID_layout:= RECORD
//TODO maybe add an attribute here that points to the relationshiop id????
	STRING Accuity_Location_ID;
END;

Accuity_Location_ID_layout office_location_xform (recordof(Ares.Files.ds_office) R) := TRANSFORM
	SELF.Accuity_Location_ID := R.tfpuid;
END;

Accuity_Location_IDs := join(officers_office_ids, Ares.Files.ds_office, right.tfpuid !='' AND LEFT.officeId = right.id, office_location_xform(right));
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Find Department_Function
Department_layout :=RECORD
	STRING departmen_type := '';
	STRING job_Title := '';
END;

Department_layout department_xform(positions L) := TRANSFORM
	SELF.departmen_type := L.department.types.types[1].department_types_type;
	SELF.job_Title := L.jobTitle
END;

//TODO why there are blanks in output and what coudl be causing them.
Department_Function := project(positions, department_xform(LEFT));
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Find 	Officer Name
parties_layout := recordof(Relationship_ds.parties);
recordof(Relationship_ds.parties.party) parties_xform(recordof(Relationship_ds.parties.party) r ) := transform
	self:=r;
end;


parties :=  normalize(Relationship_ds,left.parties.party, parties_xform(right));

//filter by employee type
parties_type_employee_list := parties(partyType='employee');

parties_type_employee_layout := RECORD
	STRING party_type := '';
	STRING entity_reference := '';
END;

parties_type_employee_layout parties_type_xfrom(parties_type_employee_list L) := TRANSFORM
	SELF.party_type := L.partyType;
	SELF.entity_reference := if(L.entityReference[1].href != '', std.str.splitwords(L.entityReference[1].href,'/')[3], '');
END;

employee_id_list := project(parties_type_employee_list, parties_type_xfrom(LEFT));

officer_name_layout := RECORD
	STRING given_name := '';
	STRING surname := '';
END;

officer_name_layout officer_name_xform (recordof(Ares.Files.ds_person) L) := TRANSFORM
	SELF.given_name := L.summary.names[1].givenName;
	SELF.surname := L.summary.names[1].surname_value;
END;

//Accuity_Location_IDs := join(officers_office_ids, Ares.Files.ds_office, right.tfpuid !='' AND LEFT.officeId = right.id, office_location_xform(right));
Officer_Name := join(employee_id_list, Ares.Files.ds_person, LEFT.entity_reference = right.id, officer_name_xform(right));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Accuity_Location_IDs
//EXPORT file_gpofficers := Accuity_Location_IDs;

//Department_Function
//EXPORT file_gpofficers := Department_Function;

/////////////////////////////////////////////
//Officer_Name
//EXPORT file_gpofficers := parties_type_employee_list;
//EXPORT file_gpofficers := employee_id_list;
EXPORT file_gpofficers := Officer_Name;


