export proflic_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

prp := doxie_cbrs.proflic_records(bdids);

rec := record
	prp.did;
	prp.date_first_seen;
	prp.date_last_seen;
	prp.profession_or_board;
	prp.orig_license_number;
	prp.license_number;
	prp.license_type;
	prp.status;
	prp.source_st;
	prp.issue_date;
	prp.expiration_date;
end;

return table(prp, rec);
END;