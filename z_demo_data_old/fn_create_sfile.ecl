
export fn_create_sfile(string fn, string ver) := function

	copy_dali	 := _control.prod_thor_dali;
	copy_prename := '~thor_200::base::demo_data_';
	dest_prename := '~thor::base::demo_data_';
	dest_group	 := demo_data._control.dest_group;

	destsfile := demo_data._control.dest_prename + fn + ver;

	csf := fileservices.createsuperfile(destsfile);
							
	retval := 	csf;					

	return retval;
	
	
end;