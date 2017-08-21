#workunit('name','AMEX Process3a Final Results RelIds');
#option ('hthorMemoryLimit', 1000);
   infile_name := '~gwhitaker::out::AMEX_job1_process2_output';
// infile_name := '~gwhitaker::out::AMEX_job2_process2_output';
// infile_name := '~gwhitaker::out::AMEX_job3_process2_output';
   
	 outfile_name := '~gwhitaker::out::AMEX_job1_process3_finaloutputDIDs';
// outfile_name := '~gwhitaker::out::AMEX_job2_process3_finaloutputDIDs';
// outfile_name := '~gwhitaker::out::AMEX_job3_process3_finaloutputDIDs';

layout_input2 := amex.layouts.outputProc2;
inRecs := dataset (infile_name, layout_input2, thor);
// create additional file for customer linking that contains 1 row per relative did
AMEX.layouts.outputFinalDIDs NormIt(inRecs L, INTEGER C) := TRANSFORM
  SELF.account := L.account;
  SELF.did := intformat(L.did,12,1);
	reldid2use := CHOOSE(C, L.rels.Relative_key1, 
												 L.rels.Relative_key2, 
												 L.rels.Relative_key3, 
												 L.rels.Relative_key4, 
												 L.rels.Relative_key5, 
												 L.rels.Relative_key6, 
												 L.rels.Relative_key7, 
												 L.rels.Relative_key8, 
												 L.rels.Relative_key9, 
												 L.rels.Relative_key10);
  SELF.reldid := if ((integer)reldid2use > 0, reldid2use, skip); 
END;
relRecs := NORMALIZE(inRecs,10,NormIt(LEFT,COUNTER));

OUTPUT (relRecs, , outfile_name, CSV(QUOTE('"')), overwrite);