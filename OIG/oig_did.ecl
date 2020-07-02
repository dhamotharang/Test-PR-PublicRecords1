import  did_add;

matchset :=['A','D'];

in_file  :=OIG.oig_bdid;

did_Add.MAC_Match_Flex(in_file, matchset,
											 '',dob, fname, mname, lname, name_suffix,
											 prim_range,prim_name,sec_range,zip,st,'',
											 did,
											 OIG.Layouts.KeyBuild,
											 false, did_score_field,	//these should default to zero in definition
											 75,	  //dids with a score below here will be dropped
											 dataset_with_did );

OIG.Layouts.KeyBuild default_ssn(OIG.Layouts.KeyBuild l) := transform
	self.ssn := '';
	self 		 := l;
end;

OIG_ssn    := project( dataset_with_did , default_ssn(left));

did_add.MAC_Add_SSN_By_DID(OIG_ssn, did, ssn, OIG_ssn_out);

export oig_did  := OIG_ssn_out:persist(OIG.Cluster +'OIG::Did');
