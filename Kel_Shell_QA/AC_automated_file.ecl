﻿EXPORT AC_automated_file(logical_file_name, unique_field, inut_file_records, Tag, Lay_para, Category_par) := FUNCTIONMACRO  


IMPORT STD;

projected_input_file:= project(inut_file_records,transform(recordof(inut_file_records),
                       self.P_InpArchDt:=left.P_InpArchDt[1..8];
											 self.P_InpClnArchDt:=left.P_InpClnArchDt[1..8];
                       // self.BusInputArchiveDateClean:=left.BusInputArchiveDateClean[1..8];
											 self:=left;
                       ));
	 
	 // get logical file layout and convert into set
	 // get_lay:=STD.File.GetLogicalFileAttribute(logical_file_name,'ECL');
   // regex_replace:= regexreplace('[{RECORD ; END}]',get_lay,' ');
   // filtered_lay2:=regex_replace;
   // filtered_lay:=STD.STr.SplitWords(trim(filtered_lay2,left,right),' '); 
	 // test_par:= regexreplace('[{RECORD ; END}]', regexreplace('\n', get_lay, ''),' ');
	 	 
Acceptance_Criteria_Module_lay:=RECORD
	string	sno;
	string	category;
	string	Jira;
	string	case_Type;
	string	def_vals;
	string	Raw_Acceptance_Criteria;
	string	Acceptance_Criteria;
END;
   
//acceptance_criteria_rules_file:= Kel_Shell_QA.acceptance_criteria_rules_file;

rules_append_lay:={string category;string	Jira;string	case_Type;string	def_vals; string Raw_Acceptance_Criteria;string Acceptance_Criteria; recordof(projected_input_file)};
		
Category_append_ds:= project(projected_input_file,transform({string category; recordof(projected_input_file)},self.category:=(string)Category_par;self:=left;));
 
rules_appended_file:=join(Distribute(Category_append_ds,random()),
													//acceptance_criteria_rules_file,
													Kel_Shell_QA.acceptance_criteria_rules_file,
													trim(left.category,left,right)=trim(right.category,left,right),
													transform(rules_append_lay,
															 self.category:=trim(left.category,left,right);
															 self.Jira:=trim(right.Jira,left,right);
															 self.case_Type:=trim(right.case_Type,left,right);
															 self.def_vals:=trim(right.def_vals,left,right);
															 self.Raw_Acceptance_Criteria:=trim(right.Raw_Acceptance_Criteria,left,right);
															 self.Acceptance_Criteria:=trim(right.Acceptance_Criteria,left,right);
															 self:=left;
															 // self:=right;
															 ),left outer,lookup,many):persist('kel_shell::persist::Acceptance_Criteria_results_rules_appended_file'+'_'+Tag+'_'+Category_par);												
														
lay := record
	recordof(Acceptance_Criteria_Module_lay);
	string Result;
end;	
      
lay makeFatRecord(rules_appended_file L) := TRANSFORM
									self.sno:=(string)L.#expand(unique_id);
									Months_between_python_func4_op:= Kel_Shell_QA.Months_between_python_func4(
																									ROW(L, Base_Lay),
																									trim(STD.Str.ToLowerCase(L.Acceptance_Criteria),left,right),
																									(string)L.def_vals,Lay_para);
																									
									Months_between_python_func3_op:= Kel_Shell_QA.Months_between_python_func3(
																									ROW(L, Base_Lay),
																									trim(STD.Str.ToLowerCase(L.Acceptance_Criteria),left,right),
																									(string)L.def_vals,Lay_para);
									Years_between_python_func_op:= Kel_Shell_QA.Years_between_python_func(
																									ROW(L, Base_Lay),
																									trim(STD.Str.ToLowerCase(L.Acceptance_Criteria),left,right),
																									(string)L.def_vals,Lay_para);
																									
									python_func_custom_KS6701_op:= Kel_Shell_QA.python_func_custom_KS6701(
																									ROW(L, Base_Lay),
																									trim(STD.Str.ToLowerCase(L.Acceptance_Criteria),left,right),
																									(string)L.def_vals,Lay_para);
																									
									self.Result:=MAP(
									
																	 //*********** Custom test casesKS6701 **************
																	 STD.Str.Find(L.Raw_Acceptance_Criteria,'MONTHSBETWEEN')>=1 and 
									                 STD.Str.Find(L.case_Type,'custom_ks6701_AC09')>=1 =>
					IF(python_func_custom_KS6701_op not in['PASS','FAIL','NA'],
								IF(abs(Std.Date.MonthsBetween((integer)std.date.today(),
															 (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 1) )) <6
															  and (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 2) = -99998,
															 'PASS',IF(abs(Std.Date.MonthsBetween((integer)std.date.today(),
															 (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 1) )) >=6
															  and (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 2) != -99998,
															 'PASS','FAIL')),python_func_custom_KS6701_op),
															 
															     STD.Str.Find(L.Raw_Acceptance_Criteria,'YEARSBETWEEN')>=1 and 
									                 STD.Str.Find(L.case_Type,'custom_ks6701_AC10')>=1 =>
					IF(python_func_custom_KS6701_op not in['PASS','FAIL','NA'],
								IF(abs(Std.Date.YearsBetween((integer)std.date.today(),
															 (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 1) )) <1
															 and (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 2) = -99998,
															 'PASS',IF(abs(Std.Date.YearsBetween((integer)std.date.today(),
															 (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 1) )) >=1
															 and (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 2) != -99998,
															 'PASS','FAIL')),python_func_custom_KS6701_op),

																	 STD.Str.Find(L.Raw_Acceptance_Criteria,'YEARSBETWEEN')>=1 and 
									                 STD.Str.Find(L.case_Type,'custom_ks6701_AC11')>=1 => 
					IF(python_func_custom_KS6701_op not in['PASS','FAIL','NA'],
								IF(
										abs(Std.Date.YearsBetween((integer)std.date.today(),(integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 1) )) <2
										and (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 2) = -99998,'PASS',IF(
										abs(Std.Date.YearsBetween((integer)std.date.today(),(integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 1) )) >=2
										and (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(python_func_custom_KS6701_op,left,right), 2) != -99998,'PASS','FAIL'
										)),python_func_custom_KS6701_op),
									
									
																	 STD.Str.Find(L.Raw_Acceptance_Criteria,'MIN(')>=1 and 
									                 STD.Str.Find(L.case_Type,'custom')>=1 =>
																														 Kel_Shell_QA.Months_between_python_func2(
																																					ROW(L, Base_Lay),
																																					trim(STD.Str.ToLowerCase(L.Acceptance_Criteria),left,right),
																																					(string)L.def_vals,Lay_para),
																								
									                 STD.Str.Find(L.Raw_Acceptance_Criteria,'of months between')>=1 and 
									                 STD.Str.Find(L.case_Type,'custom')>=1 =>Kel_Shell_QA.Months_between_python_func(
																																								ROW(L, Base_Lay),
																																								trim(STD.Str.ToLowerCase(L.Acceptance_Criteria),left,right),
																																								(string)L.def_vals,Lay_para),
																							
														STD.Str.Find(L.Raw_Acceptance_Criteria,'and the last item in')>=1 and 
									                 STD.Str.Find(L.case_Type,'custom')>=1 =>
					IF(Months_between_python_func4_op not in['PASS','FAIL','NA'],
								IF((integer)REGEXFIND('^(.*),(.*),(.*)$', trim(Months_between_python_func4_op,left,right), 3)=
								 abs(Std.Date.MonthsBetween((integer)REGEXFIND('^(.*),(.*),(.*)$', trim(Months_between_python_func4_op,left,right), 1),
															 (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(Months_between_python_func4_op,left,right), 2))),
															 'PASS','FAIL'),Months_between_python_func4_op),
									
																	 STD.Str.Find(L.Raw_Acceptance_Criteria,'and the first item in')>=1 and 
									                 STD.Str.Find(L.case_Type,'custom')>=1 =>
					IF(Months_between_python_func3_op not in['PASS','FAIL','NA'],
								IF((integer)REGEXFIND('^(.*),(.*),(.*)$', trim(Months_between_python_func3_op,left,right), 3)=
								 abs(Std.Date.MonthsBetween((integer)REGEXFIND('^(.*),(.*),(.*)$', trim(Months_between_python_func3_op,left,right), 1),
															 (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(Months_between_python_func3_op,left,right), 2))),
															 'PASS','FAIL'),Months_between_python_func3_op),
									
									STD.Str.Find(L.Raw_Acceptance_Criteria,'YEARSBETWEEN')>=1 and 
									                 STD.Str.Find(L.case_Type,'custom')>=1 =>
					IF(Years_between_python_func_op not in['PASS','FAIL','NA'],
								IF((integer)REGEXFIND('^(.*),(.*),(.*)$', trim(Years_between_python_func_op,left,right), 1)=
								 abs(Std.Date.YearsBetween((integer)REGEXFIND('^(.*),(.*),(.*)$', trim(Years_between_python_func_op,left,right), 2),
															 (integer)REGEXFIND('^(.*),(.*),(.*)$', trim(Years_between_python_func_op,left,right), 3))),
															 'PASS','FAIL'),Years_between_python_func_op),
															 
															  Kel_Shell_QA.test(
																								ROW(L, Base_Lay),
																								trim(STD.Str.ToLowerCase(L.Acceptance_Criteria),left,right),
																								(string)L.def_vals,Lay_para)

																	// Kel_Shell_QA.Python_range_func(filtered_lay,
																							// ROW(L, Base_Lay),
																							// trim(STD.Str.ToLowerCase(L.Acceptance_Criteria),left,right),
																							// (string)L.def_vals)
																			);
																	
							self:=L;
							self:=[];
							END;
							
							
AC_result:=PROJECT(rules_appended_file, makeFatRecord(LEFT)):persist('kel_shell::persist::Acceptance_Criteria_results_AC_result'+'_'+Tag+'_'+Category_par);

#uniquename(report_lay)
    %report_lay% :=record
		AC_result.category;
		AC_result.Jira;
		AC_result.case_Type;
		AC_result.def_vals;
		AC_result.Raw_Acceptance_Criteria;
		AC_result.Acceptance_Criteria;
	  AC_result.Result;
	  INTEGER Result_Cnt:=COUNT(GROUP);
	  DECIMAL10_2 Result_Perc:=(COUNT(GROUP)/COUNT(inut_file_records))*100;
	end;

AC_result_distribute    := distribute(AC_result,hash32(Category,Jira,case_Type,def_vals,Raw_Acceptance_Criteria,Acceptance_Criteria,Result));

#uniquename(report)
%report% :=	table(AC_result_distribute,%report_lay%,Category,Jira,case_Type,def_vals,Raw_Acceptance_Criteria,Acceptance_Criteria,Result,local);	
 							 

op := sort(project(%report%,transform({%report_lay%; integer Crictical_flag;},
                                        self.Crictical_flag:= if(left.Result ='FAIL' and left.Result_Perc>=10,1,0);
																				self:=left;
																				)),-Crictical_flag);
																					
op2:=join(dedup(sort(AC_result,Raw_Acceptance_Criteria,result),Raw_Acceptance_Criteria,result,KEEP 5),
          rules_appended_file,
						left.Category=right.Category and
						left.Acceptance_Criteria=right.Acceptance_Criteria and
						left.Raw_Acceptance_Criteria=right.Raw_Acceptance_Criteria and
						(string)left.sno=(string)right.#expand(unique_id),
          transform({recordof(rules_appended_file);string result;},self.result:=left.result;self:=right;),left outer);
			
final_report:=output(choosen(op,all),,'~kel_shell::out::Acceptance_Criteria_results_'+ tag + Category_par, CSV(heading(single), quote('"')), overwrite);

final_report_excel := Kel_Shell_QA.Email_Report(logical_file_name, '~kel_shell::out::Acceptance_Criteria_results_'+ tag + Category_par, ' Acceptance Criteria Report ' , 'AC_Report ' + Category_par, Tag  );

final_report_summary:=output(distribute(op2,random()),,'~kel_shell::out::Acceptance_Criteria_results_Summary_'+ tag + Category_par, CSV(heading(single), quote('"')), overwrite, EXPIRE(15));

final_report_summary_excel := Kel_Shell_QA.Email_Report(logical_file_name, '~kel_shell::out::Acceptance_Criteria_results_Summary_'+ tag + Category_par , ' Acceptance Criteria Report Summary ' , 'AC_Summary_Report ' + Category_par, Tag  );

seq:=sequential(final_report, final_report_summary, final_report_excel, final_report_summary_excel);

RETURN seq;
	 
ENDMACRO;
