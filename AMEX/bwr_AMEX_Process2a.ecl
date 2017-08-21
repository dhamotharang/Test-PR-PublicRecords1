   #workunit('name','AMEX Process 2a TEST');
#option ('hthorMemoryLimit', 1000);
	 infile_name := '~gwhitaker::out::AMEX_job1_process2_output'; //+ thorlib.wuid();	// this will output your work unit number in your filename
// outfile_name1 := '~gwhitaker::out::AMEX_job2_process2_output'; //+ thorlib.wuid();	// this will output your work unit number in your filename
// outfile_name1 := '~gwhitaker::out::AMEX_job3_process2_output'; //+ thorlib.wuid();	// this will output your work unit number in your filename
   outfile_name := '~gwhitaker::out::AMEX_job1_process2_relDIDs'; //+ thorlib.wuid();	// this will output your work unit number in your filename
// outfile_name2 := '~gwhitaker::out::AMEX_job2_process2_relDIDs'; //+ thorlib.wuid();	// this will output your work unit number in your filename
// outfile_name2 := '~gwhitaker::out::AMEX_job3_process2_relDIDs'; //+ thorlib.wuid();	// this will output your work unit number in your filename
   // pull out relative dids to run thru process 1
	 layout_input := AMEX.layouts.outputProc2;        //subject DIDs from Process1
   ds_in := dataset (infile_name, layout_input, thor);
	 
AMEX.layouts.inputProc1 NormIt(ds_in L, INTEGER C) := TRANSFORM
  SELF.seq := (string)L.account;
	reldid := CHOOSE(C, L.rels.Relative_key1, 
												 L.rels.Relative_key2, 
												 L.rels.Relative_key3, 
												 L.rels.Relative_key4, 
												 L.rels.Relative_key5, 
												 L.rels.Relative_key6, 
												 L.rels.Relative_key7, 
												 L.rels.Relative_key8, 
												 L.rels.Relative_key9, 
												 L.rels.Relative_key10);
  SELF.did := if ((integer)reldid > 0 ,reldid,skip);
												 
  SELF := [];												 
END;

outRecs := NORMALIZE(ds_in,10,NormIt(LEFT,COUNTER));

OUTPUT(outRecs, , outfile_name, CSV(QUOTE('"')), overwrite);  //csv file for input into Process4 and then Process1