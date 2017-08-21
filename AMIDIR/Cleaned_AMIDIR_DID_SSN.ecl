import did_add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville;

//#stored('did_add_force','thor'); // remove or set to 'roxi' to put recs through roxi

infile := AMIDIR.Updated_AMIDIR;

outrec := record
	unsigned6 did := 0;
	//unsigned1 did_score_field := 0;
	AMIDIR.Layout_AMIDIR_Common;
end;

matchset :=['A','P','G','Z'];

did_Add.MAC_Match_Flex(infile, matchset,
	 '', Physician_DOB_yyyymmdd, Physician_Name_Clean_fname, Physician_Name_Clean_mname, Physician_Name_Clean_lname, Physician_Name_Clean_name_suffix, 
	 Business_Address_Clean_prim_range, Business_Address_Clean_prim_name, Business_Address_Clean_sec_range, Business_Address_Clean_zip, Business_Address_Clean_st, Business_Phone,
	 did,   			
	 outrec, 
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped 
	 outfile)

dataset_with_did := outfile;

AMIDIR_ssn_rec := record
	string9	ssn :='';
	outrec;
end;

AMIDIR_ssn_rec default_ssn(dataset_with_did l) := transform
	self.ssn := '';
	self := l;
end;

AMIDIR_ssn := project(dataset_with_did, default_ssn(left));

did_add.MAC_Add_SSN_By_DID(AMIDIR_ssn, did, ssn, AMIDIR_ssn_out)

//output(count(AMIDIR_ssn_out(trim(ssn,left,right)<>'')));

dataset_with_did_ssn := AMIDIR_ssn_out;

Layout_outf := record
		string12 did;
		//string3  did_score;
		string9  ssn;
		AMIDIR.Layout_AMIDIR_Common;
end;

Layout_outf trf(dataset_with_did_ssn l) := Transform
	self.did := if(trim((string) l.did)!='',intformat(l.did, 12, 1),'');
	//self.did_score	:= (string3)L.did_score_field;
	self := l;
end;
	
outf := Project(dataset_with_did_ssn,trf(left));
 
//outf : persist('~thor_data400::persist::Cleaned_AMIDIR_after_did_ssn','thor_dell400_2');

export Cleaned_AMIDIR_DID_SSN := outf : persist('~thor_data400::persist::Cleaned_AMIDIR_after_did_ssn');