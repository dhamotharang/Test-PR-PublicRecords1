export DCA_records_trimmed(dataset(doxie_cbrs.layout_references) bdids) := 
MODULE

doxie_cbrs.mac_Selection_Declare()

// ut.mac_slim_back(bdid_dataset,doxie_cbrs.layout_references,wla);

dca_recs := doxie_cbrs.fn_DCA_records_dayton(bdids,false,1)(Include_ParentCompany_val and Include_DCA_val);

ultimate_parent := choosen(sort(dca_recs,level,sub),1);

dcar_slim := RECORD
	dca_recs.level;
	dca_recs.name;
	dca_recs.prim_range;
	dca_recs.predir;
	dca_recs.prim_name;
	dca_recs.addr_suffix;
	dca_recs.postdir;
	dca_recs.sec_range;
	dca_recs.unit_desig;
	string25 	city;
	string2 	state;
	string5 	zip;
	dca_recs.zip4;
	dca_recs.Province;
	dca_recs.Country;
	dca_recs.Phone;
	dca_recs.bus_desc;
END;

dcar_slim dca_slimmed(dca_recs L) := TRANSFORM
	SELF.prim_name := if(L.prim_range = '' and L.predir = '' and 
						 L.prim_name = '' and L.addr_suffix = '' and 
						 L.postdir = '' and L.sec_range = '' and L.unit_desig = '',
						 L.street, L.prim_name);
	SELF := L;
END;

shared dca_slim := project(ultimate_parent,dca_slimmed(LEFT));

doxie_cbrs.mac_Selection_Declare()

export records := choosen(dca_slim,Max_DCA_val);
export records_count := count(dca_slim);

END;