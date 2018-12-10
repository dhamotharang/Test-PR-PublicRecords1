import std;

Relationship_ds := Files.ds_relationship;
person_ds := Ares.Files.ds_person;

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

Accuity_Location_ID_layout office_location_xform (officers_office_ids L, recordof(Ares.Files.ds_office) R) := TRANSFORM
	SELF.Accuity_Location_ID := R.tfpuid;
	SELF:=L;
END;

Accuity_Location_IDs := join(officers_office_ids, Ares.Files.ds_office, LEFT.officeId = right.id, office_location_xform(left, right));

with_department_layout := RECORD
	Accuity_Location_IDs.positionCategory;
	Accuity_Location_IDs.relationship_id;
	Accuity_Location_IDs.officeid;
	Accuity_Location_IDs.accuity_location_id;
	STRING department_type := '';
	STRING job_Title := '';
END;

with_department_layout department_xform(Accuity_Location_IDs L) := TRANSFORM
	SELF.department_type := L.department.types.types[1].department_types_type;
	SELF.job_Title := L.jobTitle;
	SELF := L;
END;

Department_Function := project(Accuity_Location_IDs, department_xform(LEFT));
//output(Department_Function,NAMED('Department_Function'));

with_codes_layout := RECORD
	Accuity_Location_IDs.positionCategory;
	Accuity_Location_IDs.relationship_id;
	Accuity_Location_IDs.officeid;
	Accuity_Location_IDs.accuity_location_id;
	STRING department_type := '';
	STRING job_Title := '';
	STRING descpriton;
	STRING code;
END;
//job titles.
department_list := sort(Ares.Files.ds_lookup(fid ='JOB_TITLE_TYPE').lookupBody(tfpid != ''), tfpid); 

//department type.
department_type_list := SORT(Ares.Files.ds_lookup(fid='DEPARTMENT_TYPE').lookupBody(tfpid != ''),tfpid);

//job title and department type.
combined_dept_list := sort((department_list + department_type_list),tfpid);
//output(combined_dept_list,NAMED('combined_dept_list'));



//account for the dept value whether dept job title or type is empty.
asigned_dpt_id_layout := RECORD(RECORDOF(Department_Function))
	STRING asigned_dpt_id;
END;

asigned_dpt_id_layout assigned_xform (Department_Function L):= TRANSFORM
	SELF.asigned_dpt_id := MAP(L.department_type !='' AND L.job_title != '' =>L.department_type,
  													 L.department_type !='' AND L.job_title = '' =>L.department_type,
														 L.job_title);
	SELF := L;
END;

assigned_dpt_codes  := PROJECT(Department_Function,assigned_xform(LEFT));

with_codes_layout department_codes_xform (Department_Function L, combined_dept_list R):= TRANSFORM
		SELF.descpriton :=R.tfpdescription;
		SELF.code :=R.tfpid;
		SELF := L;
END;

with_department_codes := join(assigned_dpt_codes, combined_dept_list, LEFT.asigned_dpt_id =RIGHT.id, department_codes_xform(LEFT,RIGHT));
// output(with_department_codes,NAMED('with_department_codes'));
 output(with_department_codes(Accuity_Location_ID='10000200'),NAMED('department_by_id_10000200'));
// output(with_department_codes(Accuity_Location_ID='10000011'),NAMED('department_by_id_10000011'));



sorted_with_department_codes := SORT(with_department_codes,relationship_id);
// output(sorted_with_department_codes,NAMED('sorted_with_department_codes'));
// output(sorted_with_department_codes(Accuity_Location_ID='96692845'),NAMED('sorted_department_by_id_96692845'));
// output(sorted_with_department_codes(Accuity_Location_ID='10000011'),NAMED('sorted_department_by_id_10000011'));

//deduped_with_department_codes := DEDUP(sorted_with_department_codes,LEFT.relationship_id = RIGHT.relationship_id);
deduped_with_department_codes := DEDUP(sorted_with_department_codes,RECORD);
// output(deduped_with_department_codes,NAMED('deduped_with_department_codes'));
// output(deduped_with_department_codes(Accuity_Location_ID='96692845'),NAMED('department_dedup_by_id_96692845'));
// output(deduped_with_department_codes(Accuity_Location_ID='10000011'),NAMED('department_dedup_by_id_10000011'));


//Find 	Officer's Name
layout_party := RECORD(recordof(Relationship_ds.parties.party))
	string relationship_id := '';
END;

layout_party parties_xform(recordof(Relationship_ds.parties.party) r, string id) := transform
	self.relationship_id := id;
	self:=r;
end;

parties :=  normalize(Relationship_ds,left.parties.party, parties_xform(right, left.id));
output(parties,NAMED('parties'));


//filter by employee type
parties_type_employee_list := parties(partyType='employee');
output(parties_type_employee_list,NAMED('only_employees'));

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

employee_id_list := project(parties_type_employee_list, parties_type_xfrom(LEFT));
output(employee_id_list,NAMED('employee_id_list'));

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
output(person_ds,NAMED('person_list'));
output(person_ds(relatedEntities.relation_link.href != ''),NAMED('person_list_ds'));

layout_entities_parsed := RECORD(recordof(Ares.Files.ds_person))
	STRING href_parsed;
END;

layout_entities_parsed peron_xform(person_ds L) := TRANSFORM
	//TODO parse the href from relatedEntities;
	//SELF.entity_reference := if(L.entityReference[1].href != '', std.str.splitwords(L.entityReference[1].href,'/')[3], '');
	SELF.href_parsed := L.relatedEntities.relation_link[1].href;
	SELF := L;
END;

person_with_entities_ds := project(person_ds,peron_xform(LEFT)); 
output(person_with_entities_ds,NAMED('person_with_entities_ds'));
output(person_with_entities_ds(href_parsed!=''),NAMED('person_with_entities_parsed'));


//TODO: join on entity_reference not on id
Officer_Name := join(employee_id_list, person_ds, LEFT.entity_reference = right.id, officer_name_xform(left,right));
sorted_Officer_Name := SORT(Officer_Name,relationship_id);
deduped_Officer_Name := DEDUP(sorted_Officer_Name,LEFT.relationship_id = RIGHT.relationship_id);

RECORDOF(layout_gpoff) final_xform(Officer_Name L, with_codes_layout R ) := Transform
	SELF.UpdateFlag := 'A';
	SELF.PrimaryKey := '';
	SELF.Accuity_Location_ID := R.Accuity_Location_ID;
	SELF.Department := R.code;
	SELF.OfficerName := L.given_name + ' ' + L.surname;
End;

final	:= join(deduped_Officer_Name, deduped_with_department_codes, LEFT.relationship_id = right.relationship_id, final_xform(left,right));

// output(sort(final,department),NAMED('final_by_dpt'));
// output(final(Accuity_Location_ID = '10000011'),NAMED('final_by_id_10000011'));
// output(final(OfficerName= 'Kim Gassaway'),NAMED('final_by_name'));
EXPORT file_gpofficers := final;


