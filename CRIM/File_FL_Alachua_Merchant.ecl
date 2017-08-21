import ut;
export File_FL_Alachua_Merchant := DATASET('~'+ut.foreign_prod+'thor_data400::in::crim_court::fl_alachua_merchant', 
                                         //'~thor_data400::in::crim_court::fl_alachua_merchant' use this for prod.
                                         Layout_FL_Alachua_Merchant,
																				 FLAT);
