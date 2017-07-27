import ut, doxie_cbrs;

export fn_best_records_prs(
  dataset(doxie_cbrs.layout_supergroup) thegroupids,
	boolean in_use_supergroup
) :=
function
	bes := doxie_cbrs.fn_best_records(thegroupids,in_use_supergroup);
	
	outrec := record
	  doxie_cbrs.layout_best_records_prs;
		unsigned6 group_id;
	end;
	ut.MAC_Slim_Back(bes, outrec, wla)
	
	return wla;
end;