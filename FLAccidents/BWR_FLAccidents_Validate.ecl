EXPORT BWR_FLAccidents_Validate := 

#workunit('name','FL Accidents Validation');

flc1_v4_in := dataset('~thor_data400::sprayed::flcrash1'
									,FLAccidents.Layout_FLCrash1_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));
									
flc2_v4_in := dataset('~thor_data400::sprayed::flcrash2v'
									,FLAccidents.Layout_FLCrash2v_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));
									
flc3v_v4_in := dataset('~thor_data400::sprayed::flcrash3v'
											,FLAccidents.Layout_FLCrash3, csv(Heading(1),separator(','),terminator(['\n','\r\n'])))(accident_nbr <> 'report_number');

flc4_v4_in := dataset('~thor_data400::sprayed::flcrash4'
							,FLAccidents.Layout_FLCrash4_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));							

flc5_v2_in := dataset('~thor_data400::sprayed::flcrash5'
						,FLAccidents.Layout_FLCrash5_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));
						
flc6_v2_in := dataset('~thor_data400::sprayed::flcrash6'
						,FLAccidents.Layout_FLCrash6_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])))(accident_nbr <> 'report_number');

flc7_v2_in := dataset('~thor_data400::sprayed::flcrash7'
						,FLAccidents.Layout_FLCrash7_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));
						
flc8_v3_in := dataset('~thor_data400::sprayed::flcrash8',
                                  FLAccidents.Layout_FLCrash8_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])))(accident_nbr <> 'report_number');

flc9_v4_in := dataset('~thor_data400::sprayed::flcrash9'
						,FLAccidents.Layout_FLCrash9_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));

Output(flc1_v4_in,named('FLCRASH_1'));
Output(flc2_v4_in,named('FLCRASH_2'));
Output(flc3v_v4_in,named('FLCRASH_3'));
Output(flc4_v4_in,named('FLCRASH_4'));
Output(flc5_v2_in,named('FLCRASH_5'));
Output(flc6_v2_in,named('FLCRASH_6'));
Output(flc7_v2_in,named('FLCRASH_7'));
Output(flc8_v3_in,named('FLCRASH_8'));
Output(flc9_v4_in,named('FLCRASH_9'));
