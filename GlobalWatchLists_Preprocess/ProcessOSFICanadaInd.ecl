IMPORT std, address, ut, GlobalWatchLists_preprocess;

EXPORT ProcessOSFICanadaInd := FUNCTION

	OSFIIndWOheader := GlobalWatchLists_preprocess.Files.dsOSFICanadaInd(	TRIM(row_data, left, right) <> u'' and
   																						regexfind(u'[a-z,A-Z,0-9]', row_data) = true and
   																						STD.Uni.Find(row_data, u'Consolidated List of Names subject', 1) = 0 and
   																						STD.Uni.Find(row_data, u'PART A  - INDIVIDUALS', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Names added to the list', 1) = 0 and
																							STD.Uni.Find(row_data, u'Last Name', 1) = 0 and
   																						STD.Uni.Find(row_data, u'This consolidated list has a number ', 1) = 0 and
   																						STD.Uni.Find(row_data, u'http://www.osfi.gc.ca', 1) = 0 and
																							STD.Uni.Find(row_data, u'Features of this list which are', 1) = 0 and
   																						STD.Uni.Find(row_data, u'numbering each person', 1) =0 and
																							STD.Uni.Find(row_data, u'removing honorifics', 1) =0 and
																							STD.Uni.Find(row_data, u'removing the column', 1) =0 and
																							STD.Uni.Find(row_data, u'having separate columns', 1) =0 and
																							STD.Uni.Find(row_data, u'and other cultures, such as Chinese', 1) =0 and
																							STD.Uni.Find(row_data, u'sometimes when individuals deal', 1) =0 and
																							STD.Uni.Find(row_data, u'searches we have recommended', 1) =0 and
																							STD.Uni.Find(row_data, u'Similarly, as many of the names', 1) =0 and
																							STD.Uni.Find(row_data, u'grounds for suspicion do not rely', 1) =0 and
																							STD.Uni.Find(row_data, u'where an alternate spelling appears', 1) =0 and
																							STD.Uni.Find(row_data, u'ID number reflects each individual', 1) = 0 and
																							STD.Uni.Find(row_data, u'Date of Birth is listed in order of', 1) = 0 and
																							STD.Uni.Find(row_data, u'Basis includes only a date', 1) = 0 and
																							STD.Uni.Find(row_data, u'is included on the UN list', 1) = 0 and
																							STD.Uni.Find(row_data, u'DISCLAIMER: This list has been prepared', 1) = 0 and
																							STD.Uni.Find(row_data, u'Acts as passed by Parliament', 1) = 0 and
																							STD.Uni.Find(row_data, u'of the Privy Council and published', 1) = 0 and
																							STD.Uni.Find(row_data, u'Links to the United Nations Act', 1) = 0 and
																							STD.Uni.Find(row_data, u'This file is also available in a .txt format', 1) = 0 and
																							STD.Uni.Find(row_data, u'One name aliases are not included in the', 1) = 0 and
																							STD.Uni.Find(row_data, u'For purposes of', 1) = 0 and
																							STD.Uni.Find(row_data, u'"Hadji", Haji", and "Maulavi"', 1) = 0 and
																							STD.Uni.Find(row_data, u'The Basis includes dates when the name or related identifying information ', 1) = 0);
		
		GlobalWatchLists_preprocess.Layouts.rOSFICanada RemoveDoubleQuote(GlobalWatchLists_preprocess.Layouts.rOSFICanada L) := TRANSFORM
			self.row_data := STD.Uni.FindReplace(L.row_data, u'"', u'');
		END;
		
		GlobalWatchLists_preprocess.IntermediaryLayoutOSFICanada.tempLayoutInd SplitData(GlobalWatchLists_preprocess.Layouts.rOSFICanada L) := TRANSFORM
			self.ID								:= (string)L.row_data[1..STD.Uni.Find(L.row_data, u'\t',1) - 1];
			self.LastName					:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',1) + 1..STD.Uni.Find(L.row_data, u'\t',2) - 1];
			self.First_Name				:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',2) + 1..STD.Uni.Find(L.row_data, u'\t',3) - 1];
			self.SecondName				:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',3) + 1..STD.Uni.Find(L.row_data, u'\t',4) - 1];
			self.ThirdName				:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',4) + 1..STD.Uni.Find(L.row_data, u'\t',5) - 1];
			self.FourthName				:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',5) + 1..STD.Uni.Find(L.row_data, u'\t',6) - 1];
			self.POB							:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',6) + 1..STD.Uni.Find(L.row_data, u'\t',7) - 1];
			self.ALTPOB						:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',7) + 1..STD.Uni.Find(L.row_data, u'\t',8) - 1];
			self.DOB4							:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',8) + 1..STD.Uni.Find(L.row_data, u'\t',9) - 1];
			self.ALTDOB1					:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',9) + 1..STD.Uni.Find(L.row_data, u'\t',10) - 1];
			self.ALTDOB2					:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',10) + 1..STD.Uni.Find(L.row_data, u'\t',11) - 1];
			self.ALTDOB3					:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',11) + 1..STD.Uni.Find(L.row_data, u'\t',12) - 1];
			self.Nationality			:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',12) + 1..STD.Uni.Find(L.row_data, u'\t',13) - 1];
			self.ALTNAtionality1	:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',13) + 1..STD.Uni.Find(L.row_data, u'\t',14) - 1]	;
			self.ALTNationality2	:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',14) + 1..STD.Uni.Find(L.row_data, u'\t',15) - 1];
			self.OtherInfo				:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',15) + 1..STD.Uni.Find(L.row_data, u'\t',16) - 1];
			self.basis5						:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',16) + 1..];
			self.orig_raw_name		:= STD.Str.FindReplace(TRIM(self.LastName, left, right)
															+ if(TRIM(self.First_Name, left, right) <> '' or TRIM(self.SecondName, left, right) <> '' or TRIM(self.ThirdName, left, right) <> '' or TRIM(self.FourthName, left, right) <> '', ',', '')
															+ ' ' + TRIM(self.First_Name, left, right)
															+ ' ' + TRIM(self.SecondName, left, right)
															+ ' ' + TRIM(self.ThirdName, left, right)
															+ ' ' + TRIM(self.FourthName, left, right)
														,'  ', ' ');
		END;
	
	dsOSFIInd 				:= PROJECT(PROJECT(OSFIIndWOheader, RemoveDoubleQuote(left)), SplitData(left));
	dsOSFIFilteredInd := dsOSFIInd(ID 									 <> 'ID #3' and 
												(TRIM(ID, left, right) 				 <> '' 			or 
												 TRIM(LastName, left, right) 	 <> '' 			or
												 TRIM(First_Name, left, right) <> '' 			or
												 TRIM(SecondName, left, right) <> '' 			or 
												 TRIM(ThirdName, left, right)  <> '' 			or 
												 TRIM(FourthName, left, right) <> ''));
	
	GlobalWatchLists_preprocess.IntermediaryLayoutOSFICanada.BaseLayoutIndWithVendUpd Redefine(GlobalWatchLists_preprocess.IntermediaryLayoutOSFICanada.tempLayoutInd L) := TRANSFORM
		self.POB 						:= if(length(TRIM(L.POB, left, right)) > 80
															,STD.Str.FindReplace(L.POB, 'Soviet Socialist Republic', 'SSR')[1..80]
															,TRIM(L.POB, left, right));
		self.lstd_entity 		:= STD.Str.FindReplace(TRIM(L.LastName, left, right)
															+ if(TRIM(L.First_Name, left, right) <> '' or TRIM(L.SecondName, left, right) <> '' or TRIM(L.ThirdName, left, right) <> '' or TRIM(L.FourthName, left, right) <> '', ',', '')
															+ ' ' + TRIM(L.First_Name, left, right)
															+ ' ' + TRIM(L.SecondName, left, right)
															+ ' ' + TRIM(L.ThirdName, left, right)
															+ ' ' + TRIM(L.FourthName, left, right)
														,'  ', ' ');
		self.last_vend_upd 	:= GlobalWatchLists_preprocess.Versions.OSFI_Ind_Version;//'';//$OSFI_CANADA_INDIVIDUALS_DATE;
		self.basis5 				:= STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(TRIM(L.basis5[1..200], left, right),', ',','),' (','('),') ',')'),'; ',';');
		self.ALTDOB1 				:= L.ALTDOB1[1..25];
		self.ALTDOB2 				:= STD.Str.FindReplace(STD.Str.FindReplace(TRIM(L.ALTDOB2, left, right), '(from false passport)', ''), 'Between', '');
		self.ALTPOB 				:= L.ALTPOB[1..80];
		self.SecondName 		:= L.SecondName[1..30];
		self.LastName  			:= L.LastName[1..35];
		self.orig_raw_name	:= ut.CleanSpacesAndUpper(L.orig_raw_name);
		self 								:= L;
	END;
	
	GlobalWatchLists_preprocess.IntermediaryLayoutOSFICanada.BaseLayoutIndWithCleanName Redefine1(GlobalWatchLists_preprocess.IntermediaryLayoutOSFICanada.BaseLayoutIndWithVendUpd L) := TRANSFORM
		v_clean_name								:= Address.CleanPersonLFM73(L.lstd_entity);
		self.clean_name.name 		  	:= v_clean_name;
		self.clean_name.name_prefix := v_clean_name[1..5];
		self.clean_name.name_first 	:= v_clean_name[6..25];
		self.clean_name.name_middle := v_clean_name[26..45];
		self.clean_name.name_last 	:= v_clean_name[46..65];
		self.clean_name.name_suffix := v_clean_name[66..70];
		self.clean_name.name_score 	:= v_clean_name[71..73];
		
		self.POB 					:= TRIM(L.POB, left, right);
		self.ALTPOB 			:= TRIM(L.ALTPOB, left, right);
		self.DOB4 				:= if(length(L.DOB4) = 10
														,GlobalWatchLists_preprocess.fSlashedDMYtoSlashedMDY(TRIM(L.DOB4, left, right))
														,TRIM(L.DOB4, left, right));
		self.ALTDOB1 			:= if(length(L.ALTDOB1) = 10
														,GlobalWatchLists_preprocess.fSlashedDMYtoSlashedMDY(TRIM(L.ALTDOB1, left, right))
														,TRIM(L.ALTDOB1, left, right));
		self.ALTDOB2 			:= if(length(L.ALTDOB2) = 10
														,GlobalWatchLists_preprocess.fSlashedDMYtoSlashedMDY(TRIM(L.ALTDOB2, left, right))
														,TRIM(L.ALTDOB2));
		self.ALTDOB3 			:= if(length(L.ALTDOB3) = 10
														,GlobalWatchLists_preprocess.fSlashedDMYtoSlashedMDY(TRIM(L.ALTDOB3, left, right))
														,TRIM(L.ALTDOB3, left, right));
		self.Nationality 	:= TRIM(L.Nationality, left, right);
		self.OtherInfo 		:= TRIM(L.OtherInfo, left, right);
		self.basis5 			:= TRIM(L.basis5, left, right);
		self.orig_raw_name	:= L.orig_raw_name;
		self := L;
	END;
	
	dsCleanInput	:= PROJECT(PROJECT(dsOSFIInd, Redefine(left)), Redefine1(left));
	
	
	GlobalWatchLists_preprocess.rOutLayout  ReformatToCommonlayout(GlobalWatchLists_preprocess.IntermediaryLayoutOSFICanada.BaseLayoutIndWithCleanName L) := TRANSFORM
		v_dobs 				:= TRIM(L.DOB4, left, right)
											 + if(TRIM(L.ALTDOB1, left, right) <> '', '; ' + TRIM(L.ALTDOB1, left, right), '')
											 + if(TRIM(L.ALTDOB2, left, right) <> '', '; ' + TRIM(L.ALTDOB2, left, right), '')
											 + if(TRIM(L.ALTDOB3, left, right) <> '', '; ' + TRIM(L.ALTDOB3, left, right), '');
    v_pobs 				:= TRIM(L.POB, left, right) + if(TRIM(L.ALTPOB, left, right) <> '', '; ' + TRIM(L.ALTPOB, left, right), '');
		v_nationality := TRIM(L.Nationality, left, right)
											 + if(TRIM(L.ALTNAtionality1, left, right) <> '', '; ' + TRIM(L.ALTNAtionality1, left, right), '')
											 + if(TRIM(L.ALTNationality2, left, right) <> '', '; ' + TRIM(L.ALTNationality2, left, right), '');
		v_clean_name 	:= L.clean_name.name;
		v_dob_1 			:= if(STD.Str.Find(L.DOB4,'approximately 1977/1978', 1) > 0
											,'1977'
											,if(STD.Str.Find(STD.Str.ToUpperCase(L.DOB4), ' AND ', 1) = 0 
													and STD.Str.Find(STD.Str.ToUpperCase(L.DOB4), '-', 1) = 0
												,TRIM(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.ToUpperCase(L.DOB4)
																																					,'BETWEEN', '')
																																				,'ABOUT', '')
																																			,'APPROXIMATELY', '')
																																		,'CIRCA', ''), left, right)
												,if(STD.Str.Find(STD.Str.ToUpperCase(L.DOB4), ' AND ', 1) > 0
													,STD.Str.FindReplace(TRIM(STD.Str.ToUpperCase(L.DOB4), left, right), 'BETWEEN ', '')[1..STD.Str.Find(STD.Str.FindReplace(STD.Str.ToUpperCase(L.DOB4)
                                                                                                                  ,'BETWEEN ', '')
																																																								,' AND ', 1)-1]
													,L.DOB4[1..STD.Str.Find(L.DOB4,'-', 1)-1])));
		v_dob_2 			:= if(STD.Str.Find(L.DOB4, 'approximately 1977/1978', 1) > 0
											,'1978'
											,if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB1), ' AND ', 1) = 0
													and STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB1), '-', 1) = 0
												,TRIM(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.ToUpperCase(L.ALTDOB1)
																																					,'BETWEEN', '')
																																				,'ABOUT', '')
																																			,'APPROXIMATELY', '')
																																		,'CIRCA', ''), left, right)
												,if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB1), ' AND ', 1) > 0
													,STD.Str.FindReplace(TRIM(STD.Str.ToUpperCase(L.ALTDOB1), left, right), 'BETWEEN ', '')[1..STD.Str.Find(STD.Str.FindReplace(STD.Str.ToUpperCase(L.ALTDOB1)
																																																									,'BETWEEN ', '')
																																																								,' AND ', 1)-1]
													,L.ALTDOB1[1..STD.Str.Find(L.ALTDOB1, '-', 1)-1])));
		v_dob_3 			:= if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB2), ' AND ', 1) = 0
												and STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB2), '-', 1) = 0
											,TRIM(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.ToUpperCase(L.ALTDOB2)
																																					,'BETWEEN', '')
																																				,'ABOUT', '')
																																			,'APPROXIMATELY', '')
																																		,'CIRCA', ''), left, right)
											,if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB2), ' AND ', 1) > 0
												,STD.Str.FindReplace(TRIM(STD.Str.ToUpperCase(L.ALTDOB2), left, right), 'BETWEEN ', '')[1..STD.Str.Find(STD.Str.FindReplace(STD.Str.ToUpperCase(L.ALTDOB2)
																																																								,'BETWEEN ', '')
																																																							,' AND ', 1)-1]
												,L.ALTDOB2[1..STD.Str.Find(L.ALTDOB2, '-', 1)-1]));
		v_dob_4 			:= if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB3), ' AND ', 1) = 0
												and STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB3), '-', 1) = 0
											,TRIM(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.ToUpperCase(L.ALTDOB3)
																																					,'BETWEEN', '')
																																				,'ABOUT', '')
																																			,'APPROXIMATELY', '')
																																		,'CIRCA', ''), left, right)
											,if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB3), ' AND ', 1) > 0
												,STD.Str.FindReplace(TRIM(STD.Str.ToUpperCase(L.ALTDOB3), left, right), 'BETWEEN ', '')[1..STD.Str.Find(STD.Str.FindReplace(STD.Str.ToUpperCase(L.ALTDOB3)
																																																								,'BETWEEN ', '')
																																																							,' AND ', 1)-1]
												,L.ALTDOB3[1..STD.Str.Find(L.ALTDOB3, '-', 1)-1]));
		v_dob_5 			:= if(STD.Str.Find(STD.Str.ToUpperCase(L.DOB4), ' AND ', 1) > 0
											,L.DOB4[STD.Str.Find(STD.Str.ToUpperCase(L.DOB4), ' AND ', 1)+5..20+STD.Str.Find(STD.Str.ToUpperCase(L.DOB4), ' AND ', 1)+5-1]
											,if(STD.Str.Find(STD.Str.ToUpperCase(L.DOB4), '-', 1) > 0
												,L.DOB4[STD.Str.Find(STD.Str.ToUpperCase(L.DOB4), '-', 1)+1..20+STD.Str.Find(STD.Str.ToUpperCase(L.DOB4), '-', 1)+1-1]
												,''));
		v_dob_6 			:= if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB1), ' AND ', 1) > 0
											,L.ALTDOB1[STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB1), ' AND ', 1)+5..20+STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB1), ' AND ', 1)+5-1]
											,if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB1), '-', 1) > 0
												,L.ALTDOB1[STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB1), '-', 1)+1..20+STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB1), '-', 1)+1-1]
												,''));
		v_dob_7 			:= if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB2), ' AND ', 1) > 0
											,L.ALTDOB2[STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB2), ' AND ', 1)+5..20+STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB2), ' AND ', 1)+5-1]
											,if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB2), '-', 1) > 0
												,L.ALTDOB2[STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB2), '-', 1)+1..20+STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB2), '-', 1)+1-1]
												,''));
		v_dob_8 			:= if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB3), ' AND ', 1) > 0
											,L.ALTDOB3[STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB3), ' AND ', 1)+5..20+STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB3), ' AND ', 1)+5-1]
											,if(STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB3), '-', 1) > 0
												,L.ALTDOB3[STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB3), '-', 1)+1..20+STD.Str.Find(STD.Str.ToUpperCase(L.ALTDOB3), '-', 1)+1-1]
												,''));

		self.pty_key 					:= 'OCI' + TRIM(L.ID[1..STD.Uni.Find(L.ID, '.', 1)-1], left, right);
		self.source 					:= 'OSFI - Canada Individuals';
		self.orig_pty_name 		:= STD.Str.ToUpperCase(trim(REGEXREPLACE('^,',L.lstd_entity,''), left, right));
		self.orig_vessel_name := '';
		self.name_type 				:= if(STD.Str.Find(L.ID,'.00',1) > 0, '', 'AKA');
		self.addr_1 					:= '';
		self.addr_2 					:= '';
		self.addr_3 					:= '';
		self.remarks_1 				:= STD.Str.ToUpperCase(if(v_dobs <> '', 'DOB(s): ' + TRIM(v_dobs, left, right), ''));
		self.remarks_2 				:= STD.Str.ToUpperCase(if(v_pobs <> '', 'POB(s): ' + TRIM(v_pobs, left, right), ' '));
		self.remarks_3 				:= STD.Str.ToUpperCase(if(v_nationality <> '', 'Nationality(s): ' + TRIM(v_nationality, left, right), ' '));
		self.remarks_4 				:= STD.Str.ToUpperCase(if(L.basis5 <> '', 'Basis : ' + TRIM(L.basis5, left, right), ''));
		self.remarks_5 				:= STD.Str.ToUpperCase(if(L.OtherInfo <> '' and STD.Uni.Find(L.OtherInfo, 'SSN ', 1) = 0
																,TRIM('NI Number: ' + TRIM(L.OtherInfo, left, right), left, right)[1..1050]
																,if(L.OtherInfo <> '' and STD.Uni.Find(L.OtherInfo, 'SSN ', 1)  > 0
																	,TRIM('NI Number: ' +
																		regexreplace('....%%%%',
																			regexreplace('SSN ...-..-....', TRIM(L.OtherInfo, left, right), '&%%%%')
																			,'xxxx'), left, right)[1..1050]
																	,'')));
		self.cname_clean 			:= '';
		self.pname_clean 			:= v_clean_name;
		self.addr_clean 			:= '';
		self.date_first_seen 	:= GlobalWatchLists_Preprocess.Versions.OSFI_Ind_Version;
		self.date_last_seen 	:= GlobalWatchLists_Preprocess.Versions.OSFI_Ind_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.OSFI_Ind_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.OSFI_Ind_Version;
		self.orig_entity_id 	:= L.ID;
		self.orig_first_name 	:= STD.Str.ToUpperCase(TRIM(TRIM(L.First_Name, left, right)
														 + ' ' + TRIM(L.SecondName, left, right)
														 + ' ' + TRIM(L.ThirdName, left, right)
														 + ' ' + TRIM(L.FourthName, left, right), left, right));
		self.orig_last_name 	:= STD.Str.ToUpperCase(TRIM(L.LastName, left, right));
		self.orig_aka_id 			:= '';
		self.orig_aka_type 		:= if(STD.Str.Find(L.ID,'.00',1) > 0, '', 'AKA');
		self.orig_aka_category 		:= '';
		self.orig_giv_designator 	:= 'I';
		self.orig_address_id 			:= '';
		self.orig_remarks 				:= STD.Str.ToUpperCase(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(TRIM(L.OtherInfo, left, right), ', ', ','), ': ', ':'), '; ', ';'),' (','('),') ',')'))[1..1000];
		self.orig_nationality_1 	:= STD.Str.ToUpperCase(TRIM(L.Nationality, left, right));
		self.orig_nationality_2 	:= STD.Str.ToUpperCase(TRIM(L.ALTNAtionality1, left, right));
		self.orig_nationality_3 	:= STD.Str.ToUpperCase(TRIM(L.ALTNationality2, left, right));
		self.orig_dob_1 					:= IF(length(trim(v_dob_1)) = 4,v_dob_1,
																		IF(trim(v_dob_1,left,right) <> '',GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(v_dob_1),''));
		self.orig_dob_2 					:= IF(length(trim(v_dob_2)) = 4,v_dob_2,
																		IF(trim(v_dob_2,left,right) <> '',GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(v_dob_2),''));
		self.orig_dob_3 					:= IF(length(trim(v_dob_3)) = 4,v_dob_3,
																		IF(trim(v_dob_3,left,right) <> '',GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(v_dob_3),''));
		self.orig_dob_4 					:= IF(length(trim(v_dob_4)) = 4,v_dob_4,
																		IF(trim(v_dob_4,left,right) <> '',GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(v_dob_4),''));
		self.orig_dob_5 					:= IF(length(trim(v_dob_5)) = 4,v_dob_5,
																		IF(trim(v_dob_5,left,right) <> '',GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(v_dob_5),''));
		self.orig_dob_6 					:= IF(length(trim(v_dob_6)) = 4,v_dob_6,
																		IF(trim(v_dob_6,left,right) <> '',GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(v_dob_6),''));
		self.orig_dob_7 					:= IF(length(trim(v_dob_7)) = 4,v_dob_7,
																		IF(trim(v_dob_7,left,right) <> '',GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(v_dob_7),''));
		self.orig_dob_8 					:= IF(length(trim(v_dob_8)) = 4,v_dob_8,
																		IF(trim(v_dob_8,left,right) <> '',GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(v_dob_8),''));
		self.orig_pob_1 					:= STD.Str.ToUpperCase(TRIM(L.POB, left, right));
		self.orig_pob_2 					:= STD.Str.ToUpperCase(TRIM(L.ALTPOB, left, right));
		self.orig_membership_1 		:= if(STD.Uni.Find(L.OtherInfo, 'Taliban', 1) > 0, 'TALIBAN', '');
		self.orig_grounds 				:= STD.Str.ToUpperCase(if(L.basis5 <> '', 'Basis:' + STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(TRIM(L.basis5, left, right),', ',','),' (','('),') ',')'),'; ',';'), ''));
		self.orig_raw_name	:= L.orig_raw_name;
		self := [];
	END;
	
	dCommonOut	:= PROJECT(dsCleanInput, ReformatToCommonlayout(left));
	
	return dCommonOut(orig_pty_name <> '');
	
END;