IMPORT doxie, business_header, ut;
doxie_cbrs.mac_Selection_Declare()

EXPORT contact_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION
r := doxie_cbrs.contact_records_prs(bdids);
s := SORT(r, level, /*company_name,*/ lowest_title_rank, lname, fname, -did);

//add seq num to match sort elsewhere
seqrec := RECORD
  s;
  UNSIGNED2 seq := 0;
END;

p := PROJECT(s, seqrec);
ut.MAC_Sequence_Records(p,seq,pseq)

RETURN CHOOSEN(pseq, Max_AssociatedPeople_val);
END;
