import header,did_add,ut;

#workunit('name','DID To Death');

dm_in := dataset('~thor_data400::base::death_master_plus',header.Layout_Death_Master_Plus,thor);

layout_dm_did_score := record
	header.Layout_Death_Master;
	string8 dob;
	unsigned6 did := 0;
    unsigned1 did_score := 0;
end;

layout_dm_did_score add_fields(dm_in l) := transform
	self.dob := l.dob8[5..8] + l.dob8[1..4];
	self := l;
end;

dm_with_did := project(dm_in,add_fields(left));

matchset := ['S','D','Z'];

did_add.MAC_Match_Flex(dm_with_did,matchset,ssn,dob,fname,mname,lname,name_suffix,
			foo,foo,foo,zip_lastres,state,foo,did,layout_dm_did_score,true,did_score,75,outf)

layout_dm_did := record
  string8    filedate := outf.filedate;
  string1    rec_type := outf.rec_type;
  string1    rec_type_orig := outf.rec_type_orig;
  string9    ssn := outf.ssn;
  string20   lname := outf.lname;
  string4    name_suffix := outf.name_suffix;
  string15   fname := outf.fname;
  string15   mname := outf.mname;
  string1    VorP_code := outf.VorP_code;
  string8    dod8 := outf.dod8;
  string8    dob8 := outf.dob8;
  string2    st_country_code := outf.st_country_code;
  string5    zip_lastres := outf.zip_lastres;
  string5    zip_lastpayment := outf.zip_lastpayment;
  string2	 state := outf.state;
  string3	 fipscounty := outf.fipscounty;
  string12   did := (string) intformat(outf.did, 12, 1);
  string2	 crlf := outf.crlf;
end;

dm_with_did_table := table(outf,layout_dm_did);

export Death_Master_With_DID :=
		output(dm_with_did_table,,'~thor_data400::out::death_master_with_did_' + ut.GetDate,overwrite);
