import crim;

export layout_judicials_seq := record, maxlength(200000)
	unsigned2	seq;
	crim.Layout_Crim_Judicial_main;
	varstring judicial_agency_id_mapped;
	dataset(crim.Layout_crim_judicial_charge) charges;
end;

