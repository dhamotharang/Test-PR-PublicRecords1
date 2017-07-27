import doxie, business_header, ut;
doxie_cbrs.mac_Selection_Declare()

export contact_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION
r := doxie_cbrs.contact_records_prs(bdids);
s := sort(r, level, /*company_name,*/ lowest_title_rank, lname, fname, -did);

//add seq num to match sort elsewhere
seqrec := record
	s;
	unsigned2 seq := 0;
end;

p := project(s, seqrec);
ut.MAC_Sequence_Records(p,seq,pseq)

return choosen(pseq, Max_AssociatedPeople_val);
END;