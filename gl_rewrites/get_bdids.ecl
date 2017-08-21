import doxie;
export get_BDIDs(
	gl_rewrites.business_interfaces.i__get_bdids in_parms) :=
		function
			bdids := gl_rewrites.get_bdids_plus(in_parms);
			return project(bdids,doxie.layout_ref_bdid);
		end;
		