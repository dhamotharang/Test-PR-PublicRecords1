// for the applicant files, put them all back together in 1 file and sort them by account number
d1 := dataset('~dvstemp::out::amex_finaloutput_may17_0_1mill', amex.layouts.outputFinal, csv(quote('"')) );
d2 := dataset('~dvstemp::out::amex_finaloutput_may17_1_2mill', amex.layouts.outputFinal, csv(quote('"')) );
d3 := dataset('~dvstemp::out::amex_finaloutput_may17_2_3mill', amex.layouts.outputFinal, csv(quote('"')) );
d4 := dataset('~dvstemp::out::amex_finaloutput_may17_3_4mill', amex.layouts.outputFinal, csv(quote('"')) );
d := sort(ungroup(d1 + d2 + d3 + d4), account);

f1 := dataset('~dvstemp::out::amex_finaloutput_may17_0_1mill_fcra', amex.layouts.outputFinal, csv(quote('"')) );
f2 := dataset('~dvstemp::out::amex_finaloutput_may17_1_2mill_fcra', amex.layouts.outputFinal, csv(quote('"')) );
f3 := dataset('~dvstemp::out::amex_finaloutput_may17_2_3mill_fcra', amex.layouts.outputFinal, csv(quote('"')) );
f4 := dataset('~dvstemp::out::amex_finaloutput_may17_3_4mill_fcra', amex.layouts.outputFinal, csv(quote('"')) );
f := sort(ungroup(f1 + f2 + f3 + f4), account);

output(d,,'~dvstemp::out::amex_young_prospects_nonfcra_may17', csv(quote('"'), heading(single)) );
output(f,,'~dvstemp::out::amex_young_prospects_fcra_may17', csv(quote('"'), heading(single)) );


// output(choosen(d,100000),,'~dvstemp::out::amex_young_prospects_nonfcra_100ksample', csv(quote('"'), heading(single)) );
// output(choosen(d,100000),,'~dvstemp::out::amex_young_prospects_fcra_100ksample', csv(quote('"'), heading(single)) );


/*

// add the account numbers back to the relatives file, and get back to the 22 million relatives instead of the 21 million deduped relatives
d := dataset('~dvstemp::out::AMEX_relDIDs', AMEX.layouts.inputProc1, CSV(QUOTE('"')));
d2 := dataset('~dvstemp::out::AMEX_relatives_finaloutput_deduped_may17', AMEX.layouts.outputfinal, CSV(QUOTE('"')));
output(d);
output(d2);


j := join(distribute(d, hash(did)), 
					distribute(d2, hash(account)), left.did=right.account, 
					transform(AMEX.layouts.outputfinal, 
										self.account := left.seq,
										self := right), local);
output(j((unsigned)account in [1, 10, 100]));
output(j,,'~dvstemp::out::AMEX_relatives_final_output_may17', CSV(heading(single), QUOTE('"')));

*/
