Import Race;


TestFileL := record
	Equifax.File_SpanishCleanTest;
	integer4	total_weight := 0;
	integer4	fname_weight := 0;
	integer4	lname_weight := 0;
	integer4	seq_num := 0;
end;

TestFileLong := TABLE(Equifax.File_SpanishCleanTest, TestFileL);

TestFileL AddSeqNum(TestFileLong l, TestFileLong r) := TRANSFORM
	self.seq_num := l.seq_num + 1;
	self := r;
end;

// Add the Sequence Number
TestFileSeq := ITERATE(TestFileLong, AddSeqNum(LEFT,RIGHT));

fname_weightfile := race.File_Spanish_First_Names;
lname_weightfile := race.File_Spanish_Last_Names;

// Score the Record
race.MAC_Weight_NameOut(TestFileSeq, lname, fname, mname,
						  total_weight,fname_weight,lname_weight,
					      fname_weightfile,lname_weightfile,
						  TestFileL,ScoreFile)


output(ScoreFile);
output(ScoreFile,,'VNTEMP::SpanishTest_Score');



