   #workunit('name','AMEX Process 2a - norm relatives');
#option ('hthorMemoryLimit', 1000);
// chunk := '_0_1mill';
// chunk := '_1_2mill';
// chunk := '_2_3mill';
chunk := '_3_4mill';

ds_in1 := dataset ('~dvstemp::out::AMEX_job1_process2_output_0_1mill', AMEX.layouts.outputProc2, thor);
ds_in2 := dataset ('~dvstemp::out::AMEX_job1_process2_output_1_2mill', AMEX.layouts.outputProc2, thor);
ds_in3 := dataset ('~dvstemp::out::AMEX_job1_process2_output_2_3mill', AMEX.layouts.outputProc2, thor);
ds_in4 := dataset ('~dvstemp::out::AMEX_job1_process2_output_3_4mill', AMEX.layouts.outputProc2, thor);

ds_in := distribute(ungroup(ds_in1 + ds_in2 + ds_in3 + ds_in4), random());
output(ds_in);

//pull out relative dids to run thru process 1
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
	self.historydateyyyymm := 200912;											 
  SELF := [];												 
END;

outRecs := NORMALIZE(ds_in,10,NormIt(LEFT,COUNTER));
output(outrecs, named('relatives_normalized'));
OUTPUT(outRecs, , '~dvstemp::out::AMEX_relDIDs', CSV(QUOTE('"')));  //hang on to account number and reldid for joining later

ds_dist := DISTRIBUTE (outRecs, hash(did));
ds_sort := SORT(ds_dist, did, local);
ds_dedup := DEDUP(ds_sort, did, local);
output(count(ds_dedup), named('count_unique_relative_dids'));
output(ds_dedup, named('unique_relative_dids'));

amex.layouts.inputProc1 get_best(ds_dedup L, watchdog.Key_Watchdog_GLB R) := transform
	self.seq := l.did;
	self.FirstName := R.fname;
	self.LastName := R.lname;
	self.StreetAddress  := Risk_Indicators.MOD_AddressClean.street_address('',R.prim_Range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range);
	self.City	:= R.city_name;
	self.State	:= R.st;
	self.Zip	:= R.zip;
	self.SSN	:= R.ssn;
	self.DateOfBirth	:= (string)R.dob;
	self.HomePhone	:= R.phone;
	self := L;
end;

unique_relatives_with_best_pii := join(ds_dedup, watchdog.Key_Watchdog_GLB,
									(integer)left.did != 0 and keyed((integer)left.did = right.did),
										get_best(LEFT,RIGHT), left outer);
output(unique_relatives_with_best_pii, named('unique_relatives_with_best_pii'));
OUTPUT(unique_relatives_with_best_pii, , '~dvstemp::out::AMEX_unique_relDIDs_with_best_pii', CSV(QUOTE('"')));  



// to chunk up the relatives file for processing through the bocashell:

// rel := dataset('~dvstemp::out::amex_unique_reldids_with_best_pii', amex.layouts.inputProc1, csv(quote('"')));

// output(choosen(rel, 1000000, 1),, '~dvstemp::in::AMEX_rel_input_0_1mill', csv(quote('"')));
// output(choosen(rel, 1000000, 1000001),, '~dvstemp::in::AMEX_rel_input_1_2mill', csv(quote('"')));
// output(choosen(rel, 1000000, 2000001),, '~dvstemp::in::AMEX_rel_input_2_3mill', csv(quote('"')));
// output(choosen(rel, 1000000, 3000001),, '~dvstemp::in::AMEX_rel_input_3_4mill', csv(quote('"')));
// output(choosen(rel, 1000000, 4000001),, '~dvstemp::in::AMEX_rel_input_4_5mill', csv(quote('"')));
// output(choosen(rel, 1000000, 5000001),, '~dvstemp::in::AMEX_rel_input_5_6mill', csv(quote('"')));
// output(choosen(rel, 1000000, 6000001),, '~dvstemp::in::AMEX_rel_input_6_7mill', csv(quote('"')));
// output(choosen(rel, 1000000, 7000001),, '~dvstemp::in::AMEX_rel_input_7_8mill', csv(quote('"')));
// output(choosen(rel, 1000000, 8000001),, '~dvstemp::in::AMEX_rel_input_8_9mill', csv(quote('"')));
// output(choosen(rel, 1000000, 9000001),, '~dvstemp::in::AMEX_rel_input_9_10mill', csv(quote('"')));
// output(choosen(rel, 1000000, 10000001),, '~dvstemp::in::AMEX_rel_input_10_11mill', csv(quote('"')));

// output(choosen(rel, 1000000, 11000001),, '~dvstemp::in::AMEX_rel_input_11_12mill', csv(quote('"')));
// output(choosen(rel, 1000000, 12000001),, '~dvstemp::in::AMEX_rel_input_12_13mill', csv(quote('"')));
// output(choosen(rel, 1000000, 13000001),, '~dvstemp::in::AMEX_rel_input_13_14mill', csv(quote('"')));
// output(choosen(rel, 1000000, 14000001),, '~dvstemp::in::AMEX_rel_input_14_15mill', csv(quote('"')));
// output(choosen(rel, 1000000, 15000001),, '~dvstemp::in::AMEX_rel_input_15_16mill', csv(quote('"')));
// output(choosen(rel, 1000000, 16000001),, '~dvstemp::in::AMEX_rel_input_16_17mill', csv(quote('"')));
// output(choosen(rel, 1000000, 17000001),, '~dvstemp::in::AMEX_rel_input_17_18mill', csv(quote('"')));
// output(choosen(rel, 1000000, 18000001),, '~dvstemp::in::AMEX_rel_input_18_19mill', csv(quote('"')));
// output(choosen(rel, 1000000, 19000001),, '~dvstemp::in::AMEX_rel_input_19_20mill', csv(quote('"')));
// output(choosen(rel, 1000000, 20000001),, '~dvstemp::in::AMEX_rel_input_20_21mill', csv(quote('"')));
// output(choosen(rel, 1000000, 21000001),, '~dvstemp::in::AMEX_rel_input_21_22mill', csv(quote('"')));
