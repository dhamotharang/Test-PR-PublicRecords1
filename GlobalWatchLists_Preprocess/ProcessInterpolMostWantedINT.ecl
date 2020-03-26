import std, address, bo_address, ut;

EXPORT ProcessInterpolMostWantedINT := FUNCTION

	IntermediaryLayoutInterpolMostwantedINT.TempLayout ReformatINTRedNotice1(Layouts.rInterpolMostWantedINT L) := TRANSFORM
	
		integer2 v_first_last_stop := if(STD.Str.Find(L.Original_Primary_Name, '(', 1) > 0
																		and STD.Str.Find(L.Original_Primary_Name, 'ALIAS', 1) = 0
																		and regexfind('[0-9]', L.Original_Primary_Name) = false
																			,STD.Str.Find(TRIM(L.Original_Primary_Name, left, right)[1..STD.Str.Find(TRIM(L.Original_Primary_Name, left, right), ' ', STD.Str.FindCount(TRIM(L.Original_Primary_Name, left, right), ' '))-1]
																				,' ', STD.Str.FindCount(TRIM(L.Original_Primary_Name, left, right)[1..STD.Str.Find(TRIM(L.Original_Primary_Name, left, right), ' ', STD.Str.FindCount(TRIM(L.Original_Primary_Name, left, right), ' '))-1], ' '))
																			,0);

		v_serial_no 							:= regexfind('(^[0]*)(\\d+)', regexfind('\\d+', regexreplace('^92', L.Serial_Number, ''), 0), 2);
		
		self.last_update_date 		:= Versions.IMW_INT_Version;
		self.pty_key 							:= TRIM(L.Application_Code, left, right) + TRIM(v_serial_no, left, right);
		self.Interpol_ID 					:= TRIM(L.Application_Code, left, right) + TRIM(L.Serial_Number, left, right);
		self.source 							:= 'Interpol Most Wanted - Red Notice';
		self.FamilyName 					:= if(TRIM(L.Cleaned_Last_Name, left, right) <> ''
																	,TRIM(L.Cleaned_Last_Name, left, right)
																	,if(v_first_last_stop > 0
																		,L.Original_Primary_Name[v_first_last_stop + 1..50 + v_first_last_stop + 1 -1]
																		,''));
		self.Forename 						:= if(TRIM(L.Cleaned_First_Name, left, right) <> ''
																	,TRIM(L.Cleaned_First_Name, left, right)
																	,if(v_first_last_stop > 0
																		,L.Original_Primary_Name[1..v_first_last_stop - 1]
																		,''));
		self.Original_Primary_Name := if(STD.Str.Find(STD.Str.ToUpperCase(TRIM(L.Original_Primary_Name, left, right)), '(ALIAS', 1) > 0
																		,TRIM(STD.Str.ToUpperCase(TRIM(L.Original_Primary_Name, left, right))[1..STD.Str.Find(STD.Str.ToUpperCase(TRIM(L.Original_Primary_Name, left, right)), '(ALIAS', 1)-1])
																		,STD.Str.ToUpperCase(STD.Str.CleanSpaces(REGEXREPLACE('\\*|\\?',L.Original_Primary_Name,' '))));
		self.Name_Type 						:= '';
		self.Original_Country 		:= STD.Str.ToUpperCase(TRIM(L.Original_Country_01, left, right));
		self.Original_Languages 	:= if(TRIM(L.Original_Language_01, left, right) <> ''
																	or	TRIM(L.Original_Language_02, left, right) <> ''
																	or 	TRIM(L.Original_Language_03, left, right) <> ''
																	or	TRIM(L.Original_Language_04, left, right) <> ''
																	or 	TRIM(L.Original_Language_05, left, right) <> ''
																	or	TRIM(L.Original_Language_06, left, right) <> ''
																	or	TRIM(L.Original_Language_07, left, right) <> ''
																	or 	TRIM(L.Original_Language_08, left, right) <> ''
																	or	TRIM(L.Original_Language_09, left, right) <> ''
																	or 	TRIM(L.Original_Language_10, left, right) <> ''
																		,if(TRIM(L.Original_Language_01, left, right) <> '', TRIM(L.Original_Language_01), '')
																			 + if(TRIM(L.Original_Language_02, left, right) <> '', ', ' + TRIM(L.Original_Language_02), '')
																			 + if(TRIM(L.Original_Language_03, left, right) <> '', ', ' + TRIM(L.Original_Language_03), '')
																			 + if(TRIM(L.Original_Language_04, left, right) <> '', ', ' + TRIM(L.Original_Language_04), '')
																			 + if(TRIM(L.Original_Language_05, left, right) <> '', ', ' + TRIM(L.Original_Language_05), '')
																			 + if(TRIM(L.Original_Language_06, left, right) <> '', ', ' + TRIM(L.Original_Language_06), '')
																			 + if(TRIM(L.Original_Language_07, left, right) <> '', ', ' + TRIM(L.Original_Language_07), '')
																			 + if(TRIM(L.Original_Language_08, left, right) <> '', ', ' + TRIM(L.Original_Language_08), '')
																			 + if(TRIM(L.Original_Language_09, left, right) <> '', ', ' + TRIM(L.Original_Language_09), '')
																			 + if(TRIM(L.Original_Language_10, left, right) <> '', ', ' + TRIM(L.Original_Language_10), '')
																		,'');
		fmtsin := [   '%Y/%m/%d'   ];

          fmtout := '%Y%m%d';

		self.Original_DOB 				:=  if(TRIM(L.Original_DOB_01, left, right) = '00000000' ,            '', 
		                                                                          STD.Date.ConvertDateFormatMultiple(TRIM(L.Original_DOB_01, left, right),fmtsin,fmtout) 
										                  );
																			
	     self.Original_Crimes                := if (  STD.Str.Find ( TRIM(L.Original_Crimes, left, right),'\\n' ) <> 0  , 
			                                                                           STD.Str.FilterOut ( TRIM(L.Original_Crimes, left, right),'\\n'), 
																	TRIM(L.Original_Crimes, left, right) 
													  );
															
		self.Original_POBs 				:= if(TRIM(L.Original_POB_01, left, right) <> ''
																	or	TRIM(L.Original_POB_02, left, right) <> ''
																	or	TRIM(L.Original_POB_03, left, right) <> ''
																	or	TRIM(L.Original_POB_04, left, right) <> ''
																	or	TRIM(L.Original_POB_05, left, right) <> ''
																	or	TRIM(L.Original_POB_06, left, right) <> ''
																	or	TRIM(L.Original_POB_07, left, right) <> ''
																	or	TRIM(L.Original_POB_08, left, right) <> ''
																	or	TRIM(L.Original_POB_09, left, right) <> ''
																	or	TRIM(L.Original_POB_10, left, right) <> ''
																		,if(TRIM(L.Original_POB_01, left, right) <> '', TRIM(L.Original_POB_01, left, right), '')
																			 + if(TRIM(L.Original_POB_02, left, right) <> '', ', ' + TRIM(L.Original_POB_02, left, right), '')
																			 + if(TRIM(L.Original_POB_03, left, right) <> '', ', ' + TRIM(L.Original_POB_03, left, right), '')
																			 + if(TRIM(L.Original_POB_04, left, right) <> '', ', ' + TRIM(L.Original_POB_04, left, right), '')
																			 + if(TRIM(L.Original_POB_05, left, right) <> '', ', ' + TRIM(L.Original_POB_05, left, right), '')
																			 + if(TRIM(L.Original_POB_06, left, right) <> '', ', ' + TRIM(L.Original_POB_06, left, right), '')
																			 + if(TRIM(L.Original_POB_07, left, right) <> '', ', ' + TRIM(L.Original_POB_07, left, right), '')
																			 + if(TRIM(L.Original_POB_08, left, right) <> '', ', ' + TRIM(L.Original_POB_08, left, right), '')
																			 + if(TRIM(L.Original_POB_09, left, right) <> '', ', ' + TRIM(L.Original_POB_09, left, right), '')
																			 + if(TRIM(L.Original_POB_10, left, right) <> '', ', ' + TRIM(L.Original_POB_10, left, right), '')
															,'');
		self.Original_Linked_With := if(TRIM(L.Original_Linked_With_01, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_02, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_03, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_04, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_05, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_06, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_07, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_08, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_09, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_10, left, right) <> ''
																		,if(TRIM(L.Original_Linked_With_01, left, right) <> '', TRIM(L.Original_Linked_With_01, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_02, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_02, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_03, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_03, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_04, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_04, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_05, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_05, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_06, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_06, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_07, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_07, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_08, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_08, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_09, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_09, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_10, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_10, left, right), '')
																		,'');
		self.Original_Nationality_01 := L.Original_Country_01;
		self.Original_Nationality_02 := L.Original_Country_02;
		self.Original_Nationality_03 := L.Original_Country_03;
		self.Original_Nationality_04 := L.Original_Country_04;
		self.Original_Nationality_05 := L.Original_Country_05;
		self.Original_Nationality_06 := L.Original_Country_06;
		self.Original_Nationality_07 := L.Original_Country_07;
		self.Original_Nationality_08 := L.Original_Country_08;
		self.Original_Nationality_09 := L.Original_Country_09;
		self.Original_Nationality_10 := L.Original_Country_10;
		self.orig_raw_name					:= ut.CleanSpacesAndUpper(L.Original_Primary_Name);
		self := L;
	END;
	
	//IntermediaryLayoutInterpolMostwantedINT.TempLayout 
	IntermediaryLayoutInterpolMostwanted.TempLayout3 ReformatINTRedNotice2(Layouts.rInterpolMostWantedINT L) := TRANSFORM
	
		v_serial_no 							:= regexfind('(^[0]*)(\\d+)', regexfind('\\d+', regexreplace('^92', L.Serial_Number, ''), 0), 2);
		
		self.last_update_date 		:= Versions.IMW_INT_Version;
		self.pty_key 							:= TRIM(L.Application_Code, left, right) + TRIM(v_serial_no, left, right);
		self.Interpol_ID 					:= TRIM(L.Application_Code, left, right) + TRIM(L.Serial_Number, left, right);
		self.source 							:= 'Interpol Most Wanted - Red Notice';
		self.FamilyName 					:= STD.Str.FindReplace(TRIM(L.Original_Primary_Name[STD.Str.Find(L.Original_Primary_Name, '(ALIAS', 1)+6..50+STD.Str.Find(L.Original_Primary_Name, '(ALIAS', 1)+6-1]), ')', '');																
		self.Forename 						:= L.Original_Primary_Name[1..STD.Str.Find(L.Original_Primary_Name, ' ', 1)];																		
		self.Original_Primary_Name := if(STD.Str.Find(L.Original_Primary_Name, '(ALIAS', 1) > 0
																			,L.Original_Primary_Name[1..STD.Str.Find(L.Original_Primary_Name, ' ', 1)]
																				+ STD.Str.FindReplace(TRIM(L.Original_Primary_Name[STD.Str.Find(L.Original_Primary_Name, '(ALIAS', 1)+6..50+STD.Str.Find(L.Original_Primary_Name, '(ALIAS', 1)+6-1]), ')', '')
																			,'');
		self.Name_Type 						:= 'AKA';
		self.Original_Country 		:= STD.Str.ToUpperCase(TRIM(L.Original_Country_01, left, right));
		self.Original_Languages 	:= if(TRIM(L.Original_Language_01, left, right) <> ''
																	or	TRIM(L.Original_Language_02, left, right) <> ''
																	or 	TRIM(L.Original_Language_03, left, right) <> ''
																	or	TRIM(L.Original_Language_04, left, right) <> ''
																	or 	TRIM(L.Original_Language_05, left, right) <> ''
																	or	TRIM(L.Original_Language_06, left, right) <> ''
																	or	TRIM(L.Original_Language_07, left, right) <> ''
																	or 	TRIM(L.Original_Language_08, left, right) <> ''
																	or	TRIM(L.Original_Language_09, left, right) <> ''
																	or 	TRIM(L.Original_Language_10, left, right) <> ''
																		,if(TRIM(L.Original_Language_01, left, right) <> '', TRIM(L.Original_Language_01), '')
																			 + if(TRIM(L.Original_Language_02, left, right) <> '', ', ' + TRIM(L.Original_Language_02), '')
																			 + if(TRIM(L.Original_Language_03, left, right) <> '', ', ' + TRIM(L.Original_Language_03), '')
																			 + if(TRIM(L.Original_Language_04, left, right) <> '', ', ' + TRIM(L.Original_Language_04), '')
																			 + if(TRIM(L.Original_Language_05, left, right) <> '', ', ' + TRIM(L.Original_Language_05), '')
																			 + if(TRIM(L.Original_Language_06, left, right) <> '', ', ' + TRIM(L.Original_Language_06), '')
																			 + if(TRIM(L.Original_Language_07, left, right) <> '', ', ' + TRIM(L.Original_Language_07), '')
																			 + if(TRIM(L.Original_Language_08, left, right) <> '', ', ' + TRIM(L.Original_Language_08), '')
																			 + if(TRIM(L.Original_Language_09, left, right) <> '', ', ' + TRIM(L.Original_Language_09), '')
																			 + if(TRIM(L.Original_Language_10, left, right) <> '', ', ' + TRIM(L.Original_Language_10), '')
																		,'');
		self.Original_DOB 				:= TRIM(L.Original_DOB_01, left, right);
		self.Original_POBs 				:= if(TRIM(L.Original_POB_01, left, right) <> ''
																	or	TRIM(L.Original_POB_02, left, right) <> ''
																	or	TRIM(L.Original_POB_03, left, right) <> ''
																	or	TRIM(L.Original_POB_04, left, right) <> ''
																	or	TRIM(L.Original_POB_05, left, right) <> ''
																	or	TRIM(L.Original_POB_06, left, right) <> ''
																	or	TRIM(L.Original_POB_07, left, right) <> ''
																	or	TRIM(L.Original_POB_08, left, right) <> ''
																	or	TRIM(L.Original_POB_09, left, right) <> ''
																	or	TRIM(L.Original_POB_10, left, right) <> ''
																		,if(TRIM(L.Original_POB_01, left, right) <> '', TRIM(L.Original_POB_01, left, right), '')
																			 + if(TRIM(L.Original_POB_02, left, right) <> '', ', ' + TRIM(L.Original_POB_02, left, right), '')
																			 + if(TRIM(L.Original_POB_03, left, right) <> '', ', ' + TRIM(L.Original_POB_03, left, right), '')
																			 + if(TRIM(L.Original_POB_04, left, right) <> '', ', ' + TRIM(L.Original_POB_04, left, right), '')
																			 + if(TRIM(L.Original_POB_05, left, right) <> '', ', ' + TRIM(L.Original_POB_05, left, right), '')
																			 + if(TRIM(L.Original_POB_06, left, right) <> '', ', ' + TRIM(L.Original_POB_06, left, right), '')
																			 + if(TRIM(L.Original_POB_07, left, right) <> '', ', ' + TRIM(L.Original_POB_07, left, right), '')
																			 + if(TRIM(L.Original_POB_08, left, right) <> '', ', ' + TRIM(L.Original_POB_08, left, right), '')
																			 + if(TRIM(L.Original_POB_09, left, right) <> '', ', ' + TRIM(L.Original_POB_09, left, right), '')
																			 + if(TRIM(L.Original_POB_10, left, right) <> '', ', ' + TRIM(L.Original_POB_10, left, right), '')
															,'');
		self.Original_Linked_With := if(TRIM(L.Original_Linked_With_01, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_02, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_03, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_04, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_05, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_06, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_07, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_08, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_09, left, right) <> ''
																	or	TRIM(L.Original_Linked_With_10, left, right) <> ''
																		,if(TRIM(L.Original_Linked_With_01, left, right) <> '', TRIM(L.Original_Linked_With_01, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_02, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_02, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_03, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_03, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_04, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_04, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_05, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_05, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_06, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_06, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_07, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_07, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_08, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_08, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_09, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_09, left, right), '')
																			 + if(TRIM(L.Original_Linked_With_10, left, right) <> '', ', ' + TRIM(L.Original_Linked_With_10, left, right), '')
																		,'');
		self.Original_Nationality_01 := L.Original_Country_01;
		self.Original_Nationality_02 := L.Original_Country_02;
		self.Original_Nationality_03 := L.Original_Country_03;
		self.Original_Nationality_04 := L.Original_Country_04;
		self.Original_Nationality_05 := L.Original_Country_05;
		self.Original_Nationality_06 := L.Original_Country_06;
		self.Original_Nationality_07 := L.Original_Country_07;
		self.Original_Nationality_08 := L.Original_Country_08;
		self.Original_Nationality_09 := L.Original_Country_09;
		self.Original_Nationality_10 := L.Original_Country_10;
		self.orig_raw_name					:= ut.CleanSpacesAndUpper(L.Original_Primary_Name);
		self := L;
	END;
	
	IMV_INTrecs := PROJECT(Files.dsInterpolMostWantedINT, ReformatINTRedNotice1(left)) + PROJECT(Files.dsInterpolMostWantedINT, ReformatINTRedNotice2(left));
	return IMV_INTrecs(TRIM(Original_Primary_Name, left, right) <> ''); 

END;