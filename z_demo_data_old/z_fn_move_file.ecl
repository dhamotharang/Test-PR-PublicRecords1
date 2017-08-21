
export fn_move_file(string fn, string ver) := function

	copy_dali	 := _control.prod_thor_dali;
	copy_prename := '~thor_200::base::demo_data_';
	dest_prename := '~thor::base::demo_data_';
	dest_group	 := demo_data._control.dest_group;

	copylfile := demo_data._control.copy_prename + fn + ver;
	destlfile := demo_data._control.dest_prename + fn + ver;
	destsfile := demo_data._control.dest_prename + fn + '_prodcopy';

	csf := fileservices.clearsuperfile(destsfile);
	clf := fileservices.copy(copylfile,dest_group,destlfile,copy_dali,,,,true,true);
	asf := fileservices.addsuperfile(destsfile,destlfile);
							
	retval := 	sequential(csf,clf,asf);					

	return retval;
	
	
end;