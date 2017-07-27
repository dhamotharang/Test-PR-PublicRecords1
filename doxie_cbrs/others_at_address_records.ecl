import business_header,doxie,ut;
doxie_cbrs.mac_Selection_Declare()

export others_at_address_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

bestrecs := doxie_cbrs.best_rest(bdids)(isOAA);

//slim it down and drop some dups
outrec := record
	bestrecs.bdid;
	bestrecs.company_name;
	bestrecs.phone;
	bestrecs.dt_last_seen;
	boolean hasBBB := false;
	boolean hasBBB_NM := false;
	string120 BBB_http_link := '';
end;

slm := table(bestrecs, outrec);
doxie_cbrs.mac_hasBBB(slm, slmb, bdids)
srt := sort(slmb, company_name, -phone, bdid);
ddp := dedup(srt, company_name, phone, bdid);

return ddp;
END;