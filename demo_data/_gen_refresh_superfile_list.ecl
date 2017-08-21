
layout_name := record
string name;
end;

prod_sf_list := project(fileservices.logicalfilelist(,false,true),{layout_name});

export _gen_refresh_superfile_list := prod_sf_list; // output(prod_sf_list,,'hthor::temp::prod_sf_list_for_demo_20100801rvh',overwrite);

// csf(sf) := macro
	// if(~fileservices.SuperFileExists(sf),fileservices.createsuperfile(sf),output('skipped'));
// endmacro;
// csf('~x');

