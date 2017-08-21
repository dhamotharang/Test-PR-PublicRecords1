export File_Consumer_Base := DATASET('~thor_data400::in::eval_desc::20081006::consumer_email_data',
                                     Layout_Consumer_Base,
									 CSV(SEPARATOR([',']),
                                         TERMINATOR(['\n']),
										 QUOTE  (['"'])
										 )
									 );