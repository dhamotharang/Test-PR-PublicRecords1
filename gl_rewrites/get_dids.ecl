import doxie;
export Get_Dids(
	gl_rewrites.person_interfaces.i__get_dids in_parms) :=
		function
			return project(gl_rewrites.get_dids_hhid(in_parms),doxie.layout_references);
		end;
		