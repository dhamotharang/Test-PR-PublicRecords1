import crim;

export layout_arrests_seq := record, maxlength(200000)
	unsigned2	seq;
	crim.Layout_crim_arrest_main;
	varstring arresting_agency_id_1_mapped;
	varstring arresting_agency_id_2_mapped;
	varstring arresting_agency_id_3_mapped;
	varstring arresting_agency_id_4_mapped;
	varstring arresting_agency_id_5_mapped;
	varstring arresting_agency_id_6_mapped;
	varstring arresting_agency_id_7_mapped;
	varstring arresting_agency_id_8_mapped;
	varstring arresting_agency_id_9_mapped;
	dataset(crim.Layout_crim_arrest_charge) charges;
end;


