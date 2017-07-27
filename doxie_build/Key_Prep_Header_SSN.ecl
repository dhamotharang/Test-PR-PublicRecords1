import header;

t := header.Prepped_For_Keys;

ssn_rec := record
  string1 s1 := t.ssn[1];
  string1 s2 := t.ssn[2];
  string1 s3 := t.ssn[3];
  string1 s4 := t.ssn[4];
  string1 s5 := t.ssn[5];
  string1 s6 := t.ssn[6];
  string1 s7 := t.ssn[7];
  string1 s8 := t.ssn[8];
  string1 s9 := t.ssn[9];
  t.dph_lname;
  t.pfname;
  t.did;
  end;

ssn_recs := dedup(sort(table(t((integer)ssn<>0),ssn_rec),record),record);

export Key_Prep_Header_SSN := INDEX(ssn_recs, {ssn_recs}, '~thor_data400::key::header.ssn.did' + thorlib.wuid());