Import Address, Person, race;


TestFileL := record
	Equifax.File_SpanishTest;
	string40	fname := '';
	string40	mname := '';
	string40	lname := '';
	string10	prefix := '';
	string10	suffix := '';
	string1		gender := '';
	string1		error := '';
	string10 	prim_range :='';
	string2     predir :='';
	string28 	prim_name :='';
	string4 	addr_suffix :='';
	string2 	postdir :='';
	string10 	unit_desig :='';
	string8 	sec_range :='';
	string25 	p_city_name :='';
	string2 	st :='';
	string5 	zip :='';
	string4 	zip4 :='';
	string3 	country := '';	
	string4 	err_stat :='';
	integer4 	int_err_stat := 0;
	integer4	total_weight := 0;
	integer4	fname_weight := 0;
	integer4	lname_weight := 0;
	integer4	seq_num := 0;
end;

TestFileLong := TABLE(Equifax.File_SpanishTest, TestFileL);

TestFileL AddSeqNum(TestFileLong l, TestFileLong r) := TRANSFORM
	self.seq_num := l.seq_num + 1;
	self := r;
end;

// Add the Sequence Number
TestFileSeq := ITERATE(TestFileLong, AddSeqNum(LEFT,RIGHT));

// Clean the incoming Address
address.MAC_Parse_Address(TestFileSeq,address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,
							   p_city_name,st,zip,zip4,country,int_err_stat,AddressCleaned)

// Clean the incoming Name
Person.MAC_Parse_Name(AddressCleaned,name,fname,mname,lname,prefix,suffix,gender,error,NAC_file)

fname_weightfile := race.File_Spanish_First_Names;
lname_weightfile := race.File_Spanish_Last_Names;

// Score the Record
race.MAC_Weight_NameOut(NAC_file, lname, fname, mname,
						  total_weight,fname_weight,lname_weight,
					      fname_weightfile,lname_weightfile,
						  TestFileL,ScoreFile)


// output(AddressCleaned);	// Looked Fine, so I don't need it anymore
output(NAC_file);			// Looked Fine, so I don't need it anymore
output(ScoreFile);
//output(ScoreFile,,'VNTEMP::SpanishTest_Score');



