EXPORT Files_Index := module

IMPORT DOXIE;
#option('multiplePersistInstances',FALSE);

Base := Score_Logs.Files_Base.File(stringlib.stringtouppercase(product) in Score_logs.set_product or trim(customer_id,left,right) = '4'); 

export File_TransactionID := JOIN(Base, Score_Logs.Files_Base.Transaction_IDs, LEFT.transaction_id = RIGHT.transaction_id, 
												TRANSFORM({Score_Logs.Layouts.Base_Transaction_Key_Layout}, 
																	 SELF.product_code := RIGHT.product_code;
																	 SELF.login_id := RIGHT.login_id;
																	 SELF.billing_code := RIGHT.billing_code;
																	 SELF.customer_id := RIGHT.customer_id;
																	 SELF.product := trim(stringlib.StringFindReplace(stringlib.StringFindReplace(left.product, 'Request',''), 'Reques', ''),left,right);
																	 SELF.inputxml := stringlib.stringcleanspaces(LEFT.inputxml);
																	 SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml);
																	 SELF := LEFT), LEFT OUTER, LOCAL)
											           ((StringLib.StringToUpperCase(product) <> 'RISKVIEWREPORT'  and length(inputxml) + length(outputxml) <= 32600) or
																	  (StringLib.StringToUpperCase(product) =  'RISKVIEWREPORT'  and length(inputxml) + length(outputxml) <= 21884)
																	 or StringLib.StringToUpperCase(product) = 'SMALLBUSINESSBIPCOMBINEDREPORT')
                                   : persist('~thor_data400::persist::acclogs_scoring'); // filter out records too long for index
																												
shared File_nonFCRA_Intermediate := JOIN(Score_Logs.Files_Base.Intermediate(product_code in ['1','2'] and source != 'F'), Score_Logs.Files_Base.Transaction_IDs, 
												LEFT.transaction_id = RIGHT.transaction_id, 
												TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout_full, 
																//	 SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[1..18000]);
																	 SELF := LEFT;
																	 SELF := RIGHT), 
												LEFT OUTER, LOCAL): persist('~thor_data400::persist::acclogs_scoring::nonFCRA::xml_intermediatept');
																					
export File_nonFCRA_Intermediate1 := project(File_nonFCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[1..18000]),SELF := LEFT));

export File_nonFCRA_Intermediate2 := project(File_nonFCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[18001..36000]),SELF := LEFT));

export File_nonFCRA_Intermediate3 := project(File_nonFCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[36001..54000]),SELF := LEFT));
																		 
export File_nonFCRA_Intermediate4 := project(File_nonFCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[54001..72000]),SELF := LEFT));
																		 
export File_nonFCRA_Intermediate5 := project(File_nonFCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[72001..90000]),SELF := LEFT));

export File_nonFCRA_Intermediate6 := project(File_nonFCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[90001..108000]),SELF := LEFT));
																		 
export File_nonFCRA_Intermediate7 := project(File_nonFCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[108001..126000]),SELF := LEFT));
																		 
export File_nonFCRA_Intermediate8 := project(File_nonFCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[126001..144000]),SELF := LEFT));
																		 
export File_nonFCRA_Intermediate9 := project(File_nonFCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[144001..162000]),SELF := LEFT));
																		 
shared File_FCRA_Intermediate := JOIN(Score_Logs.Files_Base.Intermediate(product_code in ['1','2'] and source = 'F' and transaction_id not in set(Score_Logs.File_TransactionID_Removals,transaction_id)), Score_Logs.Files_Base.Transaction_IDs, 
												LEFT.transaction_id = RIGHT.transaction_id, 
												TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout_full, 
																//	 SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[1..18000]);
																	 SELF := LEFT;
																	 SELF := RIGHT), 
												LEFT OUTER, LOCAL): persist('~thor_data400::persist::acclogs_scoring::FCRA::xml_intermediatept');
																							
export File_FCRA_Intermediate1 := project(File_FCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[1..18000]),SELF := LEFT));

export File_FCRA_Intermediate2 := project(File_FCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[18001..36000]),SELF := LEFT));

export File_FCRA_Intermediate3 := project(File_FCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[36001..54000]),SELF := LEFT));
																		 
export File_FCRA_Intermediate4 := project(File_FCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[54001..72000]),SELF := LEFT));
																		 
export File_FCRA_Intermediate5 := project(File_FCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[72001..90000]),SELF := LEFT));

export File_FCRA_Intermediate6 := project(File_FCRA_Intermediate,TRANSFORM(score_logs.Layouts.Base_Intermediate_Key_Layout, 
																     SELF.outputxml := stringlib.stringcleanspaces(LEFT.outputxml[90001..108000]),SELF := LEFT));
																		 
end;
	

																		