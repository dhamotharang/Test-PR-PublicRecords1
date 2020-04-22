import did_add, Header_Slimsort;

infile := American_student_list.Updated_american_student;

outrec := record
	unsigned6 did_temp := 0;
	American_student_list.layout_american_student_base;
end;
//add src
src_rec := record
header_slimsort.Layout_Source;
outrec;
end;

DID_Add.Mac_Set_Source_Code(infile, src_rec, 'SL', infile_src)

matchset :=['A','D','P','G','Z'];

did_Add.MAC_Match_Flex(infile_src, matchset,
	 '', DOB_FORMATTED, fname, mname, lname, name_suffix,
	 prim_range, prim_name, sec_range, z5, st, TELEPHONE,
	 did_temp,
	 src_rec,
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped
	 outfile,true,src);

dataset_with_did := outfile;

American_student_ssn_rec := record
	outrec;
end;


American_student_ssn_rec default_ssn(dataset_with_did l) := transform
	self.ssn := '';
	self := l;
end;

American_student_ssn := project(dataset_with_did, default_ssn(left));

did_add.MAC_Add_SSN_By_DID(American_student_ssn, did_temp, ssn, American_student_ssn_out)

dataset_with_did_ssn := American_student_ssn_out;

Layout_outf := record
	American_student_list.layout_american_student_base;
end;

Layout_outf trf(dataset_with_did_ssn l) := Transform
	self.did := l.did_temp;
	self := l;
end;

outf := Project(dataset_with_did_ssn,trf(left));

export Cleaned_american_student_DID := outf;
