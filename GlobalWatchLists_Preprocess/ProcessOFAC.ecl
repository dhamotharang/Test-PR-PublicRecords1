import STD, address,bo_Address, aid, ut;

ProcessPrimaryRecords := FUNCTION	
	IntermediaryLayoutOFAC.rPrimary ReformatPrimary(Layouts.rOFACPrimary L) := TRANSFORM
			self.orig_sdn_id 			:= L.SDN_ID;
			self.orig_first_name 	:= L.First_Name;
			self.orig_last_name 	:= L.Last_Name;
			self.orig_title 			:= if(TRIM(L.Title, LEFT, RIGHT) = 'Vice Senior General; Vice-Chairman of the State Peace and Development Council; Deputy Commander-in-Chief, Myanmar Defense Services (Tatmadaw); Commander-in-Chief, Myanmar Army'
																		,STD.Str.FindReplace(L.Title, 'Vice Senior General; Vice-Chairman of the State Peace and Development Council; Deputy Commander-in-Chief, Myanmar Defense Services (Tatmadaw); Commander-in-Chief, Myanmar Army', 'Vice Sr. General; Vice-Chairman of the St. Peace & Dev. Council; Dpty Cmdr-in-Chief, Myanmar Defense Services (Tatmadaw); Cmdr-in-Chief, Myanmar Army')
																		,if(TRIM(L.Title, LEFT, RIGHT) = 'Brigadier General, Commanding Officer of the Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps; Deputy Commander of the Ramazan Headquarters; Chief of Staff of the Iraq Crisis Staff'
																			,STD.Str.FindReplace(L.Title, 'Brigadier General, Commanding Officer of the Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps; Deputy Commander of the Ramazan Headquarters; Chief of Staff of the Iraq Crisis Staff', 'Brigadier Gen,Cmdg Officer of Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps;Dpty Cmdr of Ramazan HQ;Chief of Staff of Iraq Crisis')
																			,if(TRIM(L.Title, LEFT, RIGHT) = 'Brigadier General and Commander of the IRGC Basij Resistance Force; President of the Organization of the Basij of the Oppressed; Chief of the Mobilization of the Oppressed Organization'
																				,STD.Str.FindReplace(L.Title, 'Brigadier General and Commander of the IRGC Basij Resistance Force; President of the Organization of the Basij of the Oppressed; Chief of the Mobilization of the Oppressed Organization', 'Brigadier Gen and Cmdr of IRGC Basij Resistance Force;Pres.of Org of the Basij of the Oppressed; Chief of the Mobilization of the Oppressed Org.')
																				,if(TRIM(L.Title, LEFT, RIGHT) = 'Secretary of the General People\'s Committee for Finance and Planning; Secretary of the General People\'s Committee for Planning and Finance; Finance Minister'
																					,STD.Str.FindReplace(L.Title, 'Secretary of the General People\'s Committee for Finance and Planning; Secretary of the General People\'s Committee for Planning and Finance; Finance Minister', 'Sec. of the Gen. People\'s Committee for Finance and Planning;Sec. of the Gen. People\'s Committee for Planning and Finance;Finance Minister')
																					,if(TRIM(L.Title, LEFT, RIGHT) = 'Chairman & Director, Naftiran Intertade Co. (NICO) Sarl; Chairman & Director, Naft Iran Intertade Company Ltd.; Director, Hong Kong Intertrade Company; Chairman & Director, Petro Suisse Intertrade Compay'
																						,STD.Str.FindReplace(L.Title, 'Chairman & Director, Naftiran Intertade Co. (NICO) Sarl; Chairman & Director, Naft Iran Intertade Company Ltd.; Director, Hong Kong Intertrade Company; Chairman & Director, Petro Suisse Intertrade Compay', 'Chmn & Dir, Naftiran Intertade Co. ; Chmn & Dir, Naft Iran Intertade Co Ltd.; Dir, Hong Kong Intertrade Co; Chmn & Dir, Petro Suisse Intertrade Co')
																						,if(TRIM(L.Title, LEFT, RIGHT) = 'Security Deputy of Supreme Leader; Member of the Leader\'s Planning Chamber; Head of Security of Supreme Leader\'s Office; Deputy Chief of Staff of the Supreme Leader\'s Office'
																							,STD.Str.FindReplace(L.Title, 'Security Deputy of Supreme Leader; Member of the Leader\'s Planning Chamber; Head of Security of Supreme Leader\'s Office; Deputy Chief of Staff of the Supreme Leader\'s Office', 'Sec Dep of Supreme Leader; Mbr of the Ldr\'s Planning Chamber; Head of Sec of Supreme Ldr\'s Office;Dep C of S of the Supreme Ldr\'s Office')
																							,if(TRIM(L.Title, LEFT, RIGHT) = 'Chairman & Director, Naftiran Intertrade Co. (NICO) Sarl; Chairman & Director, Naft Iran Intertrade Company Ltd.; Director, Hong Kong Intertrade Company; Chairman of the Board of Directors, Iranian Oil Company (U.K.) Limited'
																								,STD.Str.FindReplace(L.Title, 'Chairman & Director, Naftiran Intertrade Co. (NICO) Sarl; Chairman & Director, Naft Iran Intertrade Company Ltd.; Director, Hong Kong Intertrade Company; Chairman of the Board of Directors, Iranian Oil Company (U.K.) Limited', 'Chmn & Dir,Naftiran Intertrade Co. (NICO) Sarl;Chmn & Dir, Naft Iran Intertrade Co.;Dir ,Hong Kong Intertrade Co.;Chmn of the Board of Dirs, Iranian Oil Co.')
																								,TRIM(L.Title, LEFT, RIGHT)[1..150])))))));
			self.orig_aka_id 					:= L.AKA_ID;
			self.orig_aka_type 				:= STD.Str.ToUpperCase(L.AKA_Type);
			self.orig_aka_category 		:= STD.Str.ToUpperCase(L.AKA_Category);
			self.orig_giv_designator 	:= if(L.GIV_Designator = 'Entity'
																			,'G'
																			,if(L.GIV_Designator = 'Individual'
																				,'I'
																				,if(L.GIV_Designator = 'Vessel'
																					,'V'
																					,if(L.GIV_Designator = 'Aircraft', 'A', ''))));
			self.orig_entity_type 		:= STD.Str.ToUpperCase(L.GIV_Designator);
			self.orig_remarks 				:= L.Remarks[1..1000][1..STD.Str.Find(L.Remarks[1..1000], ';', STD.Str.FindCount(L.Remarks[1..1000],';'))];
			self.orig_call_sign 			:= STD.Str.ToUpperCase(L.Call_Sign);
			self.orig_vessel_type 		:= STD.Str.ToUpperCase(L.Vessel_Type);
			self.orig_tonnage 				:= L.Tonnage;
			self.orig_gross_registered_tonnage 	:= L.Gross_Registered_Tonnage;
			self.orig_vessel_flag 							:= STD.Str.ToUpperCase(L.Vessel_Flag);
			self.orig_vessel_owner 							:= STD.Str.ToUpperCase(L.Vessel_Owner);
			self.orig_raw_name				:= IF(L.Vessel_owner <> '',ut.CleanSpacesAndUpper(L.Vessel_Owner),ut.CleanSpacesAndUpper(L.First_Name+' '+L.Last_Name));
	END;
	
	PrimaryRecs := PROJECT(sort(Files.dsOFACPrimary, SDN_ID, AKA_ID, Last_Name, First_Name), ReformatPrimary(LEFT));
	
	IntermediaryLayoutOFAC.rPrimary ReformatAkas1(IntermediaryLayoutOFAC.rPrimary L) := TRANSFORM			
			self.orig_last_name := if(STD.Str.Find(L.orig_last_name, '(SEGUNDO)', 1) > 0
																	,STD.Str.FilterOut(STD.Str.FilterOut(L.orig_last_name, '('), ')')
																	,if(STD.Str.Find(L.orig_last_name, '(or PEZMAR)', 1) > 0
																		,STD.Str.FindReplace(L.orig_last_name, '(or PEZMAR) ', '')
																		,if(STD.Str.Find(L.orig_last_name, '(PRIVATE)', 1) > 0
																			,STD.Str.FindReplace(L.orig_last_name, '(PRIVATE) ', '')
																			,if(STD.Str.Find(L.orig_last_name, '(or MARISCOS)', 1) > 0
																				,STD.Str.FindReplace(L.orig_last_name, '(or MARISCOS) ', '')
																				,if(STD.Str.Find(L.orig_last_name, 'SHAHIDS (MARTYRS)', 1) > 0
																					,STD.Str.FindReplace(L.orig_last_name, 'SHAHIDS (MARTYRS)', 'MARTYRS')
																					,if(STD.Str.Find(L.orig_last_name, '(PEOPLE\'S', 1) > 0
																						,TRIM(STD.Str.FilterOut(L.orig_last_name[STD.Str.Find(L.orig_last_name, '(PEOPLE\'S', 1)+1..150 + STD.Str.Find(L.orig_last_name, '(PEOPLE\'S', 1)+1-1], ')'), LEFT, RIGHT)
																						,if(STD.Str.Find(L.orig_last_name, '(COMMUNIST', 1) > 0
																							,TRIM(STD.Str.FilterOut(L.orig_last_name[STD.Str.Find(L.orig_last_name, '(COMMUNIST', 1)+1..150 + STD.Str.Find(L.orig_last_name, '(COMMUNIST', 1)+1-1], ')'), LEFT, RIGHT)
																							,if(STD.Str.Find(L.orig_last_name, '(a.k.a.', 1) > 0 or STD.Str.Find(L.orig_last_name, '(n.k.a.', 1) > 0 or STD.Str.Find(L.orig_last_name, '(f.k.a.', 1) > 0
																								,TRIM(STD.Str.FilterOut(L.orig_last_name[STD.Str.Find(L.orig_last_name, '(', 1)+8..50 + STD.Str.Find(L.orig_last_name, '(', 1)+8-1], ')'), LEFT, RIGHT)
																								,if(regexfind('\\([A-Z .\'-]+\\)', L.orig_last_name) = true
																										,TRIM(regexfind('\\([A-Z .\'-]+\\)', L.orig_last_name,0), LEFT, RIGHT)
																										,'')))))))));
																			
			self.orig_aka_type := if(STD.Str.Find(L.orig_last_name, 'n.k.a.', 1) > 0
																,'N.K.A.'
																,if(STD.Str.Find(L.orig_last_name, 'f.k.a.', 1) > 0
																	,'F.K.A.'
																	,'A.K.A.'));
			self := L;
	END;
	
	IntermediaryLayoutOFAC.rPrimary ReformatAkas2(IntermediaryLayoutOFAC.rPrimary L) := TRANSFORM
			self.orig_last_name := if(STD.Str.Find(L.orig_last_name, '(or MARISCOS)', 1) > 0
																,STD.Str.FindReplace(L.orig_last_name, 'MARISCO (or MARISCOS) ', 'MARISCOS ')
																,if(STD.Str.Find(L.orig_last_name, '(or PEZMAR)', 1) > 0
																	,STD.Str.FindReplace(L.orig_last_name, 'PESMAR (or PEZMAR) ', 'PEZMAR ')
																	,if(STD.Str.Find(L.orig_last_name, '(PRIVATE)') > 0
																		,STD.Str.FindReplace(L.orig_last_name, '(PRIVATE) ', '')
																		,'')));
			self.orig_aka_type 	:= if(TRIM(L.orig_aka_type, LEFT, RIGHT) <> ''
																,L.orig_aka_type
																,'A.K.A.');
			self := L;
	END;
	
	rgxLastname := '(\\(USA\\)|\\(PTY.\\)|\\(PVT\\)|\\(MAOIST\\)|\\(PHARMACEUTICAL AND CHEMICAL DIVISION\\)|\\(of Iran\\)|\\(SUDAN\\)|\\(CPN \\(M\\)\\)|\\(Republika Srpska\\)|\\(DALIAN)';
	FilteredPrimaryRecs := PrimaryRecs(REGEXFIND(rgxLastname, orig_last_name) = false and regexfind('[\\(]', orig_last_name));
	
	Primary := sort(PROJECT(FilteredPrimaryRecs, ReformatAkas1(LEFT)) + PROJECT(FilteredPrimaryRecs, ReformatAkas2(LEFT)) + PrimaryRecs, orig_sdn_id, orig_last_name, orig_first_name);
	
	return Primary(trim(orig_first_name+orig_last_name) <> '');	
END;


ProcessProgramRecords := FUNCTION
	IntermediaryLayoutOFAC.rProgram makeRecord(Layouts.rOFACProgram l) := TRANSFORM
		SELF.orig_sdn_id 	:= l.SDN_ID;
		SELF.PrgChild 		:= DATASET([{ l.program}], IntermediaryLayoutOFAC.rProgramChild);
	END;
	
	InRec := PROJECT(sort(Files.dsOFACProgram, SDN_ID, Program), makeRecord(LEFT));

	IntermediaryLayoutOFAC.rProgram makeChildren(IntermediaryLayoutOFAC.rProgram l, IntermediaryLayoutOFAC.rProgram r) := TRANSFORM
		SELF.orig_sdn_id 	:= l.orig_sdn_id;
		SELF.PrgChild 		:= l.PrgChild + ROW({r.PrgChild[1].orig_program},
																			IntermediaryLayoutOFAC.rProgramChild);
	END;

	//return ROLLUP(sort(InRec, orig_sdn_id), orig_sdn_id, makeChildren(LEFT, RIGHT));
	return ROLLUP(InRec, orig_sdn_id, makeChildren(LEFT, RIGHT));
END;

ProcessAddressRecords := FUNCTION
	IntermediaryLayoutOFAC.rAddress ReformatAddress(Layouts.rOFACAddress L) := TRANSFORM
		self.orig_sdn_id 									:= TRIM(L.SDN_ID, LEFT, RIGHT);
		self.orig_address_id 							:= TRIM(L.Address_ID, LEFT, RIGHT);
		self.orig_address_line_1 					:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Address_Line_1,'-',' '), LEFT, RIGHT));
		self.orig_address_line_2 					:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Address_Line_2,'-',' '), LEFT, RIGHT));
		self.orig_address_line_3 					:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Address_Line_3,'-',' '), LEFT, RIGHT));
		self.orig_address_city 						:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Address_City,'-',' '), LEFT, RIGHT));
		self.orig_address_state_province 	:= STD.Str.ToUpperCase(TRIM(REGEXREPLACE('(, )+', STD.Str.FindReplace(L.Address_State,'-',' '), ',')))[1..25];
		self.orig_address_postal_code 		:= TRIM(STD.Str.FindReplace(L.Address_Postal_Code,'-',' '))[1..20];
		self.orig_address_country 				:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Address_Country,'-',' '), LEFT, RIGHT));
	END;
	
	return PROJECT(sort(Files.dsOFACAddress, SDN_ID, Address_ID, Address_Line_1, Address_Line_2, Address_Line_3, Address_City, Address_State, Address_Postal_Code, Address_Country), ReformatAddress(LEFT));
END;

ProcessIDRecords := FUNCTION
	IntermediaryLayoutOFAC.rID makeRecord(Layouts.rOFACID l) := TRANSFORM
		self.orig_sdn_id 	:= l.SDN_ID;
		self.IDChild	 		:= DATASET([{ l.id_id, l.id_type, l.id_number, l.id_country, l.id_issue_date, l.id_expiration_date}], IntermediaryLayoutOFAC.rIDChild);
	END;
	
	InRec := PROJECT(sort(Files.dsOFACID, SDN_ID, ID_ID, ID_Type, ID_Number), makeRecord(LEFT));

	IntermediaryLayoutOFAC.rID makeChildren(IntermediaryLayoutOFAC.rID l, IntermediaryLayoutOFAC.rID r) := TRANSFORM
		self.orig_sdn_id 	:= l.orig_sdn_id;
		self.IDChild 			:= l.IDChild + ROW({r.IDChild[1].orig_id_id, r.IDChild[1].orig_id_type, r.IDChild[1].orig_id_number, r.IDChild[1].orig_id_country, r.IDChild[1].orig_id_issue_date, r.IDChild[1].orig_id_expiration_date},
																			IntermediaryLayoutOFAC.rIDChild);
	END;

	//return ROLLUP(sort(InRec, orig_sdn_id), orig_sdn_id, makeChildren(LEFT, RIGHT));
	
	return ROLLUP(InRec, orig_sdn_id, makeChildren(LEFT, RIGHT));
	
END;

ProcessNationalityRecords := FUNCTION
	IntermediaryLayoutOFAC.rNationality makeRecord(Layouts.rOFACNationality l) := TRANSFORM
		self.orig_sdn_id 			:= l.SDN_ID;
		self.NationalityChild	:= DATASET([{ l.nationality_id, l.nationality, if(l.primary_nationality_flag = 'true', 'Y', 'N')}], IntermediaryLayoutOFAC.rNationalityChild);
	END;
	
	InRec := PROJECT(sort(Files.dsOFACNationality, SDN_ID, Nationality_ID, Nationality), makeRecord(LEFT));

	IntermediaryLayoutOFAC.rNationality makeChildren(IntermediaryLayoutOFAC.rNationality l, IntermediaryLayoutOFAC.rNationality r) := TRANSFORM
		self.orig_sdn_id 			:= l.orig_sdn_id;
		self.NationalityChild := l.NationalityChild + ROW({r.NationalityChild[1].orig_nationality_id, r.NationalityChild[1].orig_nationality, r.NationalityChild[1].orig_primary_nationality_flag},
																			IntermediaryLayoutOFAC.rNationalityChild);
	END;

	//return ROLLUP(sort(InRec, orig_sdn_id), orig_sdn_id, makeChildren(LEFT, RIGHT));
	return ROLLUP(InRec, orig_sdn_id, makeChildren(LEFT, RIGHT));
END;


ProcessCitizenshipRecords := FUNCTION
	IntermediaryLayoutOFAC.rCitizenship makeRecord(Layouts.rOFACCitizenship l) := TRANSFORM
		self.orig_sdn_id 	:= l.SDN_ID;
		self.CitizenshipChild	 		:= DATASET([{ l.Citizenship_ID, l.Citizenship, if(l.primary_Citizenship_flag = 'true', 'Y', 'N')}], IntermediaryLayoutOFAC.rCitizenshipChild);
	END;
	
	InRec := PROJECT(sort(Files.dsOFACCitizenship, SDN_ID, Citizenship_ID, Citizenship), makeRecord(LEFT));

	IntermediaryLayoutOFAC.rCitizenship makeChildren(IntermediaryLayoutOFAC.rCitizenship l, IntermediaryLayoutOFAC.rCitizenship r) := TRANSFORM
		self.orig_sdn_id 			:= l.orig_sdn_id;
		self.CitizenshipChild := l.CitizenshipChild + ROW({r.CitizenshipChild[1].orig_Citizenship_ID, r.CitizenshipChild[1].orig_Citizenship, r.CitizenshipChild[1].orig_primary_Citizenship_flag},
																			IntermediaryLayoutOFAC.rCitizenshipChild);
	END;

	//return ROLLUP(sort(InRec, orig_sdn_id), orig_sdn_id, makeChildren(LEFT, RIGHT));
	return ROLLUP(InRec, orig_sdn_id, makeChildren(LEFT, RIGHT));
END;

ProcessDOBRecords := FUNCTION
	IntermediaryLayoutOFAC.rDOB makeRecord(Layouts.rOFACDOB l) := TRANSFORM
		self.orig_sdn_id 	:= l.SDN_ID;
		self.DOBChild	 		:= DATASET([{ l.Date_of_Birth_ID, l.Date_of_Birth, if(l.Primary_Date_of_Birth_Flag = 'true', 'Y', 'N')}], IntermediaryLayoutOFAC.rDOBChild);
	END;
	
	InRec := PROJECT(sort(Files.dsOFACDOB, SDN_ID, Date_of_Birth_ID, Date_of_Birth), makeRecord(LEFT));

	IntermediaryLayoutOFAC.rDOB makeChildren(IntermediaryLayoutOFAC.rDOB l, IntermediaryLayoutOFAC.rDOB r) := TRANSFORM
		self.orig_sdn_id 	:= l.orig_sdn_id;
		self.DOBChild 		:= l.DOBChild + ROW({r.DOBChild[1].orig_dob_ID, r.DOBChild[1].orig_dob, r.DOBChild[1].orig_Primary_DOB_Flag},
																			IntermediaryLayoutOFAC.rDOBChild);
	END;

	//return ROLLUP(sort(InRec, orig_sdn_id), orig_sdn_id, makeChildren(LEFT, RIGHT));
	return ROLLUP(InRec, orig_sdn_id, makeChildren(LEFT, RIGHT));
END;

ProcessPOBRecords := FUNCTION
	IntermediaryLayoutOFAC.rPOB makeRecord(Layouts.rOFACPOB l) := TRANSFORM
		self.orig_sdn_id 	:= l.SDN_ID;
		self.POBChild	 		:= DATASET([{ l.Place_of_Birth_ID, l.Place_of_Birth, if(l.Primary_Place_of_Birth_Flag = 'true', 'Y', 'N')}], IntermediaryLayoutOFAC.rPOBChild);
	END;
	
	InRec := PROJECT(sort(Files.dsOFACPOB, SDN_ID, Place_of_Birth_ID, Place_of_Birth), makeRecord(LEFT));

	IntermediaryLayoutOFAC.rPOB makeChildren(IntermediaryLayoutOFAC.rPOB l, IntermediaryLayoutOFAC.rPOB r) := TRANSFORM
		self.orig_sdn_id 	:= l.orig_sdn_id;
		self.POBChild 		:= l.POBChild + ROW({r.POBChild[1].orig_pob_ID, r.POBChild[1].orig_pob, r.POBChild[1].orig_Primary_POB_Flag},
																			IntermediaryLayoutOFAC.rPOBChild);
	END;

	//return ROLLUP(sort(InRec, orig_sdn_id), orig_sdn_id, makeChildren(LEFT, RIGHT));
	return ROLLUP(InRec, orig_sdn_id, makeChildren(LEFT, RIGHT));
END;

EXPORT ProcessOFAC := FUNCTION	
	dsOFAC := JOIN(JOIN(JOIN(JOIN(JOIN(JOIN(JOIN(ProcessPrimaryRecords(orig_last_name <> ''), ProcessProgramRecords, left.orig_sdn_id = right.orig_sdn_id, LEFT OUTER)
								,ProcessAddressRecords, left.orig_sdn_id = right.orig_sdn_id, LEFT OUTER)
								,ProcessIDRecords, left.orig_sdn_id = right.orig_sdn_id, LEFT OUTER)
								,ProcessNationalityRecords, left.orig_sdn_id = right.orig_sdn_id, LEFT OUTER)
								,ProcessCitizenshipRecords, left.orig_sdn_id = right.orig_sdn_id, LEFT OUTER)
								,ProcessDOBRecords, left.orig_sdn_id = right.orig_sdn_id, LEFT OUTER)
								,ProcessPOBRecords, left.orig_sdn_id = right.orig_sdn_id, LEFT OUTER);
	
	rOutLayout ReformatToCommonlayout(dsOFAC L) := TRANSFORM
		self.pty_key 					:= 'OFAC' + TRIM(L.orig_sdn_id, LEFT, RIGHT);
		self.source 					:= 'Office of Foreign Asset Control';
		ClnLastName						:= IF(REGEXFIND('^\\(',L.orig_last_name),STD.Str.FindReplace(STD.Str.FindReplace(L.orig_last_name,'(',''),')','')
																,L.orig_last_name);
		self.orig_pty_name 		:= if(L.orig_giv_designator = 'G' or L.orig_giv_designator = 'I'
																,STD.Str.ToUpperCase(TRIM(ClnLastName, LEFT, RIGHT)) 
																	+ if(TRIM(L.orig_first_name, LEFT, RIGHT) <> '', ', ', '')
																	+ STD.Str.ToUpperCase(TRIM(L.orig_first_name, LEFT, RIGHT))
																,'');
		self.orig_vessel_name := if(L.orig_giv_designator = 'V' or L.orig_giv_designator = 'A'
																,STD.Str.ToUpperCase(ClnLastName)
																,'');
		self.country 					:= STD.Str.ToUpperCase(TRIM(L.orig_address_country, LEFT, RIGHT));
		self.name_type 				:= if(TRIM(L.orig_aka_category) <> ''
															,STD.Str.ToUpperCase(TRIM(L.orig_aka_category)) + ' '
															,'')	+
															if(TRIM(STD.Str.ToUpperCase(L.orig_aka_type)) = 'A.K.A.'
																,'AKA'
																,if(TRIM(STD.Str.ToUpperCase(L.orig_aka_type)) = 'N.K.A.'
																	,'NKA'
																	,if(TRIM(STD.Str.ToUpperCase(L.orig_aka_type)) = 'F.K.A.'
																		,'FKA'
																		,'')));
		self.addr_1 := STD.Str.ToUpperCase(L.orig_address_line_1);
		self.addr_2 := STD.Str.ToUpperCase(TRIM(L.orig_address_line_2 + ' ' + L.orig_address_line_3, LEFT, RIGHT));
 		self.addr_3 := TRIM(if(TRIM(L.orig_address_city, LEFT, RIGHT) <> ''
														,' ' + STD.Str.ToUpperCase(TRIM(L.orig_address_city, LEFT, RIGHT))
														,'') +
													if(TRIM(L.orig_address_state_province) <> ''
														,' ' + STD.Str.ToUpperCase(TRIM(L.orig_address_state_province, LEFT, RIGHT))
														,'') +
													if(TRIM(L.orig_address_postal_code) <> ''
														,' ' + TRIM(L.orig_address_postal_code, LEFT, RIGHT)
														,'') +
													if(TRIM(L.orig_address_country) <> ''
														,' ' + STD.Str.ToUpperCase(TRIM(L.orig_address_country, LEFT, RIGHT))
														,''), LEFT, RIGHT);
		self.remarks_1 := STD.Str.ToUpperCase('PROGRAM/S: '  + TRIM(L.PrgChild[1].orig_program, left, right) + ' - ' + TRIM(CodetoSanctionNames(TRIM(L.PrgChild[1].orig_program, left, right)), left, right)
             + if(TRIM(L.PrgChild[2].orig_program, left, right) <> '', ', ' + TRIM(L.PrgChild[2].orig_program, left, right) + ' - ' + TRIM(CodetoSanctionNames(TRIM(L.PrgChild[2].orig_program, left, right)), left, right), '')
             + if(TRIM(L.PrgChild[3].orig_program, left, right) <> '', ', ' + TRIM(L.PrgChild[3].orig_program, left, right) + ' - ' + TRIM(CodetoSanctionNames(TRIM(L.PrgChild[3].orig_program, left, right)), left, right), '')
             + if(TRIM(L.PrgChild[4].orig_program, left, right) <> '', ', ' + TRIM(L.PrgChild[4].orig_program, left, right) + ' - ' + TRIM(CodetoSanctionNames(TRIM(L.PrgChild[4].orig_program, left, right)), left, right), '')
             + if(TRIM(L.PrgChild[5].orig_program, left, right) <> '', ', ' + TRIM(L.PrgChild[5].orig_program, left, right) + ' - ' + TRIM(CodetoSanctionNames(TRIM(L.PrgChild[5].orig_program, left, right)), left, right), '')
             + if(TRIM(L.PrgChild[6].orig_program, left, right) <> '', ', ' + TRIM(L.PrgChild[6].orig_program, left, right) + ' - ' + TRIM(CodetoSanctionNames(TRIM(L.PrgChild[6].orig_program, left, right)), left, right), '')
             + if(TRIM(L.PrgChild[7].orig_program, left, right) <> '', ', ' + TRIM(L.PrgChild[7].orig_program, left, right) + ' - ' + TRIM(CodetoSanctionNames(TRIM(L.PrgChild[7].orig_program, left, right)), left, right), '')
             + if(TRIM(L.PrgChild[8].orig_program, left, right) <> '', ', ' + TRIM(L.PrgChild[8].orig_program, left, right) + ' - ' + TRIM(CodetoSanctionNames(TRIM(L.PrgChild[8].orig_program, left, right)), left, right), '')
             + if(TRIM(L.PrgChild[9].orig_program, left, right) <> '', ', ' + TRIM(L.PrgChild[9].orig_program, left, right) + ' - ' + TRIM(CodetoSanctionNames(TRIM(L.PrgChild[9].orig_program, left, right)), left, right), '')
             + if(TRIM(L.PrgChild[10].orig_program, left, right) <> '', ', ' + TRIM(L.PrgChild[10].orig_program, left, right) + ' - ' + TRIM(CodetoSanctionNames(TRIM(L.PrgChild[10].orig_program, left, right)), left, right), ''));
		self.remarks_2 := STD.Str.ToUpperCase(if(TRIM(L.orig_title, LEFT, RIGHT) <> '', 'Title: ' + L.orig_title, ''));
		self.remarks_3 := STD.Str.ToUpperCase(if(TRIM(L.orig_call_sign, LEFT, RIGHT) <> '', 'Call Sign: ' + L.orig_call_sign, ''));
		self.remarks_4 := STD.Str.ToUpperCase(if(TRIM(L.orig_vessel_type, LEFT, RIGHT) <> '', 'Vessel Type: ' + L.orig_vessel_type, ''));
		self.remarks_5 := STD.Str.ToUpperCase(if(TRIM(L.orig_tonnage, LEFT, RIGHT) <> '', 'Tonnage: ' + L.orig_tonnage, ''));
		self.remarks_6 := STD.Str.ToUpperCase(if(TRIM(L.orig_gross_registered_tonnage, LEFT, RIGHT) <> '', 'Gross Registered Tonnage: ' + L.orig_gross_registered_tonnage, ''));
		self.remarks_7 := STD.Str.ToUpperCase(if(TRIM(L.orig_vessel_flag, LEFT, RIGHT) <> '', 'Vessel Flag: ' + L.orig_vessel_flag, ''));
		self.remarks_8 := STD.Str.ToUpperCase(if(TRIM(L.orig_vessel_owner, LEFT, RIGHT) <> '', 'Vessel Owner: ' + L.orig_vessel_owner, ''));
		
		string30 temp_id_0 := if(TRIM(L.IDChild[1].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[1].orig_id_number, left, right), 'xxxx'), L.IDChild[1].orig_id_number);
		string30 temp_id_1 := if(TRIM(L.IDChild[2].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[2].orig_id_number, left, right), 'xxxx'), L.IDChild[2].orig_id_number);
		string30 temp_id_2 := if(TRIM(L.IDChild[3].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[3].orig_id_number, left, right), 'xxxx'), L.IDChild[3].orig_id_number);
		string30 temp_id_3 := if(TRIM(L.IDChild[4].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[4].orig_id_number, left, right), 'xxxx'), L.IDChild[4].orig_id_number);
		string30 temp_id_4 := if(TRIM(L.IDChild[5].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[5].orig_id_number, left, right), 'xxxx'), L.IDChild[5].orig_id_number);
		string30 temp_id_5 := if(TRIM(L.IDChild[6].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[6].orig_id_number, left, right), 'xxxx'), L.IDChild[6].orig_id_number);
		string30 temp_id_6 := if(TRIM(L.IDChild[7].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[7].orig_id_number, left, right), 'xxxx'), L.IDChild[7].orig_id_number);
		string30 temp_id_7 := if(TRIM(L.IDChild[8].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[8].orig_id_number, left, right), 'xxxx'), L.IDChild[8].orig_id_number);
		string30 temp_id_8 := if(TRIM(L.IDChild[9].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[9].orig_id_number, left, right), 'xxxx'), L.IDChild[9].orig_id_number);
		string30 temp_id_9 := if(TRIM(L.IDChild[10].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[10].orig_id_number, left, right), 'xxxx'), L.IDChild[10].orig_id_number);
		string30 temp_id_10 := if(TRIM(L.IDChild[11].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[11].orig_id_number, left, right), 'xxxx'), L.IDChild[11].orig_id_number);
		string30 temp_id_11 := if(TRIM(L.IDChild[12].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[12].orig_id_number, left, right), 'xxxx'), L.IDChild[12].orig_id_number);
		string30 temp_id_12 := if(TRIM(L.IDChild[13].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[13].orig_id_number, left, right), 'xxxx'), L.IDChild[13].orig_id_number);
		string30 temp_id_13 := if(TRIM(L.IDChild[14].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[14].orig_id_number, left, right), 'xxxx'), L.IDChild[14].orig_id_number);
		string30 temp_id_14 := if(TRIM(L.IDChild[15].orig_id_type, left, right) = 'SSN', REGEXREPLACE('....$', TRIM(L.IDChild[15].orig_id_number, left, right), 'xxxx'), L.IDChild[15].orig_id_number);

		self.remarks_9 := STD.Str.ToUpperCase(REGEXREPLACE('^; ', STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(
								( if(TRIM(STD.Str.FindReplace(L.orig_remarks,'-',' ')) <> '', 'Remarks: ' + STD.Str.FindReplace(L.orig_remarks,'-',' ') + '; ', '')
								+ if(TRIM(temp_id_0, left, right) <> '', 'IDs: ' + TRIM(L.IDChild[1].orig_id_type, left, right) + ' ' + TRIM(temp_id_0, left, right) + ' ' + if(TRIM(L.IDChild[1].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[1].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[1].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[1].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[1].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[1].orig_id_expiration_date, left, right), ''), '')
								+ if(TRIM(temp_id_1, left, right) <> '', ', ' + TRIM(L.IDChild[2].orig_id_type, left, right) + ' ' + TRIM(temp_id_1, left, right) + ' ' + if(TRIM(L.IDChild[2].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[2].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[2].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[2].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[2].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[2].orig_id_expiration_date, left, right), ''), '')
								+ if(TRIM(temp_id_2, left, right) <> '', ', ' + TRIM(L.IDChild[3].orig_id_type, left, right) + ' ' + TRIM(temp_id_2, left, right) + ' ' + if(TRIM(L.IDChild[3].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[3].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[3].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[3].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[3].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[3].orig_id_expiration_date, left, right), ''), '')
								+ if(TRIM(temp_id_3, left, right) <> '', ', ' + TRIM(L.IDChild[4].orig_id_type, left, right) + ' ' + TRIM(temp_id_3, left, right) + ' ' + if(TRIM(L.IDChild[4].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[4].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[4].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[4].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[4].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[4].orig_id_expiration_date, left, right), ''), '')
								+ if(TRIM(temp_id_4, left, right) <> '', ', ' + TRIM(L.IDChild[5].orig_id_type, left, right) + ' ' + TRIM(temp_id_4, left, right) + ' ' + if(TRIM(L.IDChild[5].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[5].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[5].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[5].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[5].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[5].orig_id_expiration_date, left, right), ''), '')
								+ if(TRIM(temp_id_5, left, right) <> '', ', ' + TRIM(L.IDChild[6].orig_id_type, left, right) + ' ' + TRIM(temp_id_5, left, right) + ' ' + if(TRIM(L.IDChild[6].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[6].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[6].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[6].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[6].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[6].orig_id_expiration_date, left, right), ''), '')
								+ if(TRIM(temp_id_6, left, right) <> '', ', ' + TRIM(L.IDChild[7].orig_id_type, left, right) + ' ' + TRIM(temp_id_6, left, right) + ' ' + if(TRIM(L.IDChild[7].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[7].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[7].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[7].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[7].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[7].orig_id_expiration_date, left, right), ''), '')
								+ if(TRIM(temp_id_7, left, right) <> '', ', ' + TRIM(L.IDChild[8].orig_id_type, left, right) + ' ' + TRIM(temp_id_7, left, right) + ' ' + if(TRIM(L.IDChild[8].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[8].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[8].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[8].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[8].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[8].orig_id_expiration_date, left, right), ''), '')
								+ if(TRIM(temp_id_8, left, right) <> '', ', ' + TRIM(L.IDChild[9].orig_id_type, left, right) + ' ' + TRIM(temp_id_8, left, right) + ' ' + if(TRIM(L.IDChild[9].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[9].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[9].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[9].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[9].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[9].orig_id_expiration_date, left, right), ''), '')
								+ if(TRIM(temp_id_9, left, right) <> '', ', ' + TRIM(L.IDChild[10].orig_id_type, left, right) + ' ' + TRIM(temp_id_9, left, right) + ' ' + if(TRIM(L.IDChild[10].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[10].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[10].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[10].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[10].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[10].orig_id_expiration_date, left, right), ''), '')
								)
								+ ( if(TRIM(temp_id_10, left, right) <> '', ', ' + TRIM(L.IDChild[11].orig_id_type, left, right) + ' ' + TRIM(temp_id_10, left, right) + ' ' + if(TRIM(L.IDChild[11].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[11].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[11].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[11].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[11].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[11].orig_id_expiration_date, left, right), ''), '')
                + if(TRIM(temp_id_11, left, right) <> '', ', ' + TRIM(L.IDChild[12].orig_id_type, left, right) + ' ' + TRIM(temp_id_11, left, right) + ' ' + if(TRIM(L.IDChild[12].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[12].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[12].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[12].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[12].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[12].orig_id_expiration_date, left, right), ''), '')
                + if(TRIM(temp_id_12, left, right) <> '', ', ' + TRIM(L.IDChild[13].orig_id_type, left, right) + ' ' + TRIM(temp_id_12, left, right) + ' ' + if(TRIM(L.IDChild[13].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[13].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[13].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[13].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[13].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[13].orig_id_expiration_date, left, right), ''), '')
                + if(TRIM(temp_id_13, left, right) <> '', ', ' + TRIM(L.IDChild[14].orig_id_type, left, right) + ' ' + TRIM(temp_id_13, left, right) + ' ' + if(TRIM(L.IDChild[14].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[14].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[14].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[14].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[14].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[14].orig_id_expiration_date, left, right), ''), '')
                + if(TRIM(temp_id_14, left, right) <> '', ', ' + TRIM(L.IDChild[15].orig_id_type, left, right) + ' ' + TRIM(temp_id_14, left, right) + ' ' + if(TRIM(L.IDChild[15].orig_id_country, left, right) <> '', '(' + TRIM(L.IDChild[15].orig_id_country, left, right) + ') ', '') + if(TRIM(L.IDChild[15].orig_id_issue_date, left, right) <> '', 'Issue Dt: ' + TRIM(L.IDChild[15].orig_id_issue_date, left, right), '') + ' ' + if(TRIM(L.IDChild[15].orig_id_expiration_date, left, right) <> '', 'Exp. Dt: ' + TRIM(L.IDChild[15].orig_id_expiration_date, left, right) + '; ', '; '), '; ')
                )
								+ ( if(TRIM(L.NationalityChild[1].orig_nationality, left, right) <> '', 'Nationalities: ' + if(L.NationalityChild[1].orig_primary_nationality_flag = 'N', 'alt. ', '') + TRIM(L.NationalityChild[1].orig_nationality, left, right), '')
                + if(TRIM(L.NationalityChild[2].orig_nationality, left, right) <> '', ', ' + if(L.NationalityChild[2].orig_primary_nationality_flag = 'N', 'alt. ', '') + TRIM(L.NationalityChild[2].orig_nationality, left, right), '')
                + if(TRIM(L.NationalityChild[3].orig_nationality, left, right) <> '', ', ' + if(L.NationalityChild[3].orig_primary_nationality_flag = 'N', 'alt. ', '') + TRIM(L.NationalityChild[3].orig_nationality, left, right), '')
                + if(TRIM(L.NationalityChild[4].orig_nationality, left, right) <> '', ', ' + if(L.NationalityChild[4].orig_primary_nationality_flag = 'N', 'alt. ', '') + TRIM(L.NationalityChild[4].orig_nationality, left, right), '')
                + if(TRIM(L.NationalityChild[5].orig_nationality, left, right) <> '', ', ' + if(L.NationalityChild[5].orig_primary_nationality_flag = 'N', 'alt. ', '') + TRIM(L.NationalityChild[5].orig_nationality, left, right), '')
                + if(TRIM(L.NationalityChild[6].orig_nationality, left, right) <> '', ', ' + if(L.NationalityChild[6].orig_primary_nationality_flag = 'N', 'alt. ', '') + TRIM(L.NationalityChild[6].orig_nationality, left, right), '')
                + if(TRIM(L.NationalityChild[7].orig_nationality, left, right) <> '', ', ' + if(L.NationalityChild[7].orig_primary_nationality_flag = 'N', 'alt. ', '') + TRIM(L.NationalityChild[7].orig_nationality, left, right), '')
                + if(TRIM(L.NationalityChild[8].orig_nationality, left, right) <> '', ', ' + if(L.NationalityChild[8].orig_primary_nationality_flag = 'N', 'alt. ', '') + TRIM(L.NationalityChild[8].orig_nationality, left, right), '')
                + if(TRIM(L.NationalityChild[9].orig_nationality, left, right) <> '', ', ' + if(L.NationalityChild[9].orig_primary_nationality_flag = 'N', 'alt. ', '') + TRIM(L.NationalityChild[9].orig_nationality, left, right), '')
                + if(TRIM(L.NationalityChild[10].orig_nationality, left, right) <> '', ', ' + if(L.NationalityChild[10].orig_primary_nationality_flag = 'N', 'alt. ', '') + TRIM(L.NationalityChild[10].orig_nationality, left, right) + if(TRIM(L.NationalityChild[1].orig_nationality, left, right) <> '', '; ', ''), if(TRIM(L.NationalityChild[1].orig_nationality, left, right) <> '', '; ', ''))
                )
								+	( if(TRIM(L.CitizenshipChild[1].orig_citizenship, left, right) <> '', 'Citizenships: ' + if(L.CitizenshipChild[1].orig_primary_citizenship_flag = 'N', 'alt. ', '') + TRIM(L.CitizenshipChild[1].orig_citizenship, left, right), '')
                + if(TRIM(L.CitizenshipChild[2].orig_citizenship, left, right) <> '', ', ' + if(L.CitizenshipChild[2].orig_primary_citizenship_flag = 'N', 'alt. ', '') + TRIM(L.CitizenshipChild[2].orig_citizenship, left, right), '')
                + if(TRIM(L.CitizenshipChild[3].orig_citizenship, left, right) <> '', ', ' + if(L.CitizenshipChild[3].orig_primary_citizenship_flag = 'N', 'alt. ', '') + TRIM(L.CitizenshipChild[3].orig_citizenship, left, right), '')
                + if(TRIM(L.CitizenshipChild[4].orig_citizenship, left, right) <> '', ', ' + if(L.CitizenshipChild[4].orig_primary_citizenship_flag = 'N', 'alt. ', '') + TRIM(L.CitizenshipChild[4].orig_citizenship, left, right), '')
                + if(TRIM(L.CitizenshipChild[5].orig_citizenship, left, right) <> '', ', ' + if(L.CitizenshipChild[5].orig_primary_citizenship_flag = 'N', 'alt. ', '') + TRIM(L.CitizenshipChild[5].orig_citizenship, left, right), '')
                + if(TRIM(L.CitizenshipChild[6].orig_citizenship, left, right) <> '', ', ' + if(L.CitizenshipChild[6].orig_primary_citizenship_flag = 'N', 'alt. ', '') + TRIM(L.CitizenshipChild[6].orig_citizenship, left, right), '')
                + if(TRIM(L.CitizenshipChild[7].orig_citizenship, left, right) <> '', ', ' + if(L.CitizenshipChild[7].orig_primary_citizenship_flag = 'N', 'alt. ', '') + TRIM(L.CitizenshipChild[7].orig_citizenship, left, right), '')
                + if(TRIM(L.CitizenshipChild[8].orig_citizenship, left, right) <> '', ', ' + if(L.CitizenshipChild[8].orig_primary_citizenship_flag = 'N', 'alt. ', '') + TRIM(L.CitizenshipChild[8].orig_citizenship, left, right), '')
                + if(TRIM(L.CitizenshipChild[9].orig_citizenship, left, right) <> '', ', ' + if(L.CitizenshipChild[9].orig_primary_citizenship_flag = 'N', 'alt. ', '') + TRIM(L.CitizenshipChild[9].orig_citizenship, left, right), '')
                + if(TRIM(L.CitizenshipChild[10].orig_citizenship, left, right) <> '', ', ' + if(L.CitizenshipChild[10].orig_primary_citizenship_flag = 'N', 'alt. ', '') + TRIM(L.CitizenshipChild[10].orig_citizenship, left, right) + if(TRIM(L.CitizenshipChild[1].orig_citizenship, left, right) <> '', '; ', ''), if(TRIM(L.CitizenshipChild[1].orig_citizenship, left, right) <> '', '; ', ''))
								)
								+ ( if(TRIM(L.DOBChild[1].orig_dob, left, right) <> '', if(L.DOBChild[1].orig_primary_dob_flag = 'N', 'alt. DOB ', 'DOB ') + TRIM(L.DOBChild[1].orig_dob, left, right), '')
                + if(TRIM(L.DOBChild[2].orig_dob, left, right) <> '', '; ' + if(L.DOBChild[2].orig_primary_dob_flag = 'N', 'alt. DOB ', 'DOB ') + TRIM(L.DOBChild[2].orig_dob, left, right), '')
                + if(TRIM(L.DOBChild[3].orig_dob, left, right) <> '', '; ' + if(L.DOBChild[3].orig_primary_dob_flag = 'N', 'alt. DOB ', 'DOB ') + TRIM(L.DOBChild[3].orig_dob, left, right), '')
                + if(TRIM(L.DOBChild[4].orig_dob, left, right) <> '', '; ' + if(L.DOBChild[4].orig_primary_dob_flag = 'N', 'alt. DOB ', 'DOB ') + TRIM(L.DOBChild[4].orig_dob, left, right), '')
                + if(TRIM(L.DOBChild[5].orig_dob, left, right) <> '', '; ' + if(L.DOBChild[5].orig_primary_dob_flag = 'N', 'alt. DOB ', 'DOB ') + TRIM(L.DOBChild[5].orig_dob, left, right), '')
                + if(TRIM(L.DOBChild[6].orig_dob, left, right) <> '', '; ' + if(L.DOBChild[6].orig_primary_dob_flag = 'N', 'alt. DOB ', 'DOB ') + TRIM(L.DOBChild[6].orig_dob, left, right), '')
                + if(TRIM(L.DOBChild[7].orig_dob, left, right) <> '', '; ' + if(L.DOBChild[7].orig_primary_dob_flag = 'N', 'alt. DOB ', 'DOB ') + TRIM(L.DOBChild[7].orig_dob, left, right), '')
                + if(TRIM(L.DOBChild[8].orig_dob, left, right) <> '', '; ' + if(L.DOBChild[8].orig_primary_dob_flag = 'N', 'alt. DOB ', 'DOB ') + TRIM(L.DOBChild[8].orig_dob, left, right), '')
                + if(TRIM(L.DOBChild[9].orig_dob, left, right) <> '', '; ' + if(L.DOBChild[9].orig_primary_dob_flag = 'N', 'alt. DOB ', 'DOB ') + TRIM(L.DOBChild[9].orig_dob, left, right), '')
                + if(TRIM(L.DOBChild[10].orig_dob, left, right) <> '', '; ' + if(L.DOBChild[10].orig_primary_dob_flag = 'N', 'alt. DOB ', 'DOB ') + TRIM(L.DOBChild[10].orig_dob, left, right) + if(TRIM(L.DOBChild[1].orig_dob, left, right) <> '', '; ', ''), if(TRIM(L.DOBChild[1].orig_dob, left, right) <> '', '; ', ''))
								)
								+	( if(TRIM(L.POBChild[1].orig_pob, left, right) <> '', if(L.POBChild[1].orig_primary_pob_flag = 'N', 'alt. POB ', 'POB ') + TRIM(L.POBChild[1].orig_pob, left, right), '')
                +	if(TRIM(L.POBChild[2].orig_pob, left, right) <> '', '; ' + if(L.POBChild[2].orig_primary_pob_flag = 'N', 'alt. POB ', 'POB ') + TRIM(L.POBChild[2].orig_pob, left, right), '')
                +	if(TRIM(L.POBChild[3].orig_pob, left, right) <> '', '; ' + if(L.POBChild[3].orig_primary_pob_flag = 'N', 'alt. POB ', 'POB ') + TRIM(L.POBChild[3].orig_pob, left, right), '')
                +	if(TRIM(L.POBChild[4].orig_pob, left, right) <> '', '; ' + if(L.POBChild[4].orig_primary_pob_flag = 'N', 'alt. POB ', 'POB ') + TRIM(L.POBChild[4].orig_pob, left, right), '')
                +	if(TRIM(L.POBChild[5].orig_pob, left, right) <> '', '; ' + if(L.POBChild[5].orig_primary_pob_flag = 'N', 'alt. POB ', 'POB ') + TRIM(L.POBChild[5].orig_pob, left, right), '')
                +	if(TRIM(L.POBChild[6].orig_pob, left, right) <> '', '; ' + if(L.POBChild[6].orig_primary_pob_flag = 'N', 'alt. POB ', 'POB ') + TRIM(L.POBChild[6].orig_pob, left, right), '')
                +	if(TRIM(L.POBChild[7].orig_pob, left, right) <> '', '; ' + if(L.POBChild[7].orig_primary_pob_flag = 'N', 'alt. POB ', 'POB ') + TRIM(L.POBChild[7].orig_pob, left, right), '')
                +	if(TRIM(L.POBChild[8].orig_pob, left, right) <> '', '; ' + if(L.POBChild[8].orig_primary_pob_flag = 'N', 'alt. POB ', 'POB ') + TRIM(L.POBChild[8].orig_pob, left, right), '')
                +	if(TRIM(L.POBChild[9].orig_pob, left, right) <> '', '; ' + if(L.POBChild[9].orig_primary_pob_flag = 'N', 'alt. POB ', 'POB ') + TRIM(L.POBChild[9].orig_pob, left, right), '')
                +	if(TRIM(L.POBChild[10].orig_pob, left, right) <> '', '; ' + if(L.POBChild[10].orig_primary_pob_flag = 'N', 'alt. POB ', 'POB ') + TRIM(L.POBChild[10].orig_pob, left, right) + if(TRIM(L.POBChild[1].orig_pob, left, right) <> '', '; ', ''), if(TRIM(L.POBChild[1].orig_pob, left, right) <> '', '; ', ''))
                )
								,'  ', ' '), ' ;', ';'), ' ,', ','), ''))[1..1049];
		self.cname_clean := if(L.orig_giv_designator = 'G', STD.Str.ToUpperCase(L.orig_last_name), '');
		self.pname_clean := if(L.orig_giv_designator = 'I' and TRIM(L.orig_first_name) <> ''
														,Address.CleanPersonLFM73(TRIM(L.orig_last_name) + ', ' + TRIM(L.orig_first_name))
														,if(L.orig_giv_designator = 'I' and TRIM(L.orig_first_name) = '' and STD.Str.Find(L.orig_last_name, ',', 1) = 0
															,Address.CleanPersonFML73(TRIM(L.orig_last_name))
															,if(L.orig_giv_designator = 'I' and TRIM(L.orig_first_name) = '' and STD.Str.Find(L.orig_last_name, ',', 1) > 0
																,Address.CleanPersonLFM73(TRIM(L.orig_last_name))
																,'')));
																
		string line1 			:= TRIM(L.orig_address_line_1, left, right) + ' ' + TRIM(L.orig_address_line_2, left, right) + ' ' + TRIM(L.orig_address_line_3, left, right);
		string line2 			:= TRIM(L.orig_address_city, left, right) + ' ' + TRIM(L.orig_address_state_province, left, right) + ' ' + TRIM(L.orig_address_postal_code, left, right) + ' ' + TRIM(L.orig_address_country, left, right);
		
		clean_adr := bo_address.CleanAddress182(line1, line2);
		string178 empty_tmp := ' ';
		self.addr_clean 			:= if(clean_adr[179..180] <> 'E5' 
																and clean_adr[179..182] <> 'E213'
																and clean_adr[179..182] <> 'E101'
															,clean_adr
															,'');
 		//self.addr_clean 								:= clean_adr;//L.clean_address;//if(error_code_found, Address.CleanAddress182(line1, line2);
		self.date_first_seen 	:= GlobalWatchLists_Preprocess.Versions.OFAC_Version;
		self.date_last_seen 	:= GlobalWatchLists_Preprocess.Versions.OFAC_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.OFAC_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.OFAC_Version;
		self.orig_first_name 						:= if(L.orig_giv_designator = 'I', STD.Str.ToUpperCase(L.orig_first_name), '');
		self.orig_last_name 						:= if(L.orig_giv_designator = 'I', STD.Str.ToUpperCase(L.orig_last_name), '');
		self.orig_title_1 							:= STD.Str.ToUpperCase(L.orig_title);
		self.orig_sanctions_program_1 	:= STD.Str.ToUpperCase(L.PrgChild[1].orig_program);
		self.orig_sanctions_program_2 	:= STD.Str.ToUpperCase(L.PrgChild[2].orig_program);
		self.orig_sanctions_program_3 	:= STD.Str.ToUpperCase(L.PrgChild[3].orig_program);
		self.orig_sanctions_program_4 	:= STD.Str.ToUpperCase(L.PrgChild[4].orig_program);
		self.orig_sanctions_program_5 	:= STD.Str.ToUpperCase(L.PrgChild[5].orig_program);
		self.orig_sanctions_program_6 	:= STD.Str.ToUpperCase(L.PrgChild[6].orig_program);
		self.orig_sanctions_program_7 	:= STD.Str.ToUpperCase(L.PrgChild[7].orig_program);
		self.orig_sanctions_program_8 	:= STD.Str.ToUpperCase(L.PrgChild[8].orig_program);
		self.orig_sanctions_program_9 	:= STD.Str.ToUpperCase(L.PrgChild[9].orig_program);
		self.orig_sanctions_program_10 	:= STD.Str.ToUpperCase(L.PrgChild[10].orig_program);
		self.orig_id_id_1 							:= L.IDChild[1].orig_id_id;
		self.orig_id_id_2 							:= L.IDChild[2].orig_id_id;
		self.orig_id_id_3 							:= L.IDChild[3].orig_id_id;
		self.orig_id_id_4 							:= L.IDChild[4].orig_id_id;
		self.orig_id_id_5 							:= L.IDChild[5].orig_id_id;
		self.orig_id_id_6 							:= L.IDChild[6].orig_id_id;
		self.orig_id_id_7 							:= L.IDChild[7].orig_id_id;
		self.orig_id_id_8 							:= L.IDChild[8].orig_id_id;
		self.orig_id_id_9 							:= L.IDChild[9].orig_id_id;
		self.orig_id_id_10 							:= L.IDChild[10].orig_id_id;
		self.orig_id_type_1 						:= STD.Str.ToUpperCase(L.IDChild[1].orig_id_type);
		self.orig_id_type_2 						:= STD.Str.ToUpperCase(L.IDChild[2].orig_id_type);
		self.orig_id_type_3 						:= STD.Str.ToUpperCase(L.IDChild[3].orig_id_type);
		self.orig_id_type_4 						:= STD.Str.ToUpperCase(L.IDChild[4].orig_id_type);
		self.orig_id_type_5 						:= STD.Str.ToUpperCase(L.IDChild[5].orig_id_type);
		self.orig_id_type_6 						:= STD.Str.ToUpperCase(L.IDChild[6].orig_id_type);
		self.orig_id_type_7 						:= STD.Str.ToUpperCase(L.IDChild[7].orig_id_type);
		self.orig_id_type_8 						:= STD.Str.ToUpperCase(L.IDChild[8].orig_id_type);
		self.orig_id_type_9 						:= STD.Str.ToUpperCase(L.IDChild[9].orig_id_type);
		self.orig_id_type_10 						:= STD.Str.ToUpperCase(L.IDChild[10].orig_id_type);
		self.orig_id_number_1 					:= L.IDChild[1].orig_id_number;
		self.orig_id_number_2 					:= L.IDChild[2].orig_id_number;
		self.orig_id_number_3 					:= L.IDChild[3].orig_id_number;
		self.orig_id_number_4 					:= L.IDChild[4].orig_id_number;
		self.orig_id_number_5 					:= L.IDChild[5].orig_id_number;
		self.orig_id_number_6 					:= L.IDChild[6].orig_id_number;
		self.orig_id_number_7 					:= L.IDChild[7].orig_id_number;
		self.orig_id_number_8 					:= L.IDChild[8].orig_id_number;
		self.orig_id_number_9 					:= L.IDChild[9].orig_id_number;
		self.orig_id_number_10 					:= L.IDChild[10].orig_id_number;
		self.orig_id_country_1 					:= STD.Str.ToUpperCase(L.IDChild[1].orig_id_country);
		self.orig_id_country_2 					:= STD.Str.ToUpperCase(L.IDChild[2].orig_id_country);
		self.orig_id_country_3 					:= STD.Str.ToUpperCase(L.IDChild[3].orig_id_country);
		self.orig_id_country_4 					:= STD.Str.ToUpperCase(L.IDChild[4].orig_id_country);
		self.orig_id_country_5 					:= STD.Str.ToUpperCase(L.IDChild[5].orig_id_country);
		self.orig_id_country_6 					:= STD.Str.ToUpperCase(L.IDChild[6].orig_id_country);
		self.orig_id_country_7 					:= STD.Str.ToUpperCase(L.IDChild[7].orig_id_country);
		self.orig_id_country_8 					:= STD.Str.ToUpperCase(L.IDChild[8].orig_id_country);
		self.orig_id_country_9 					:= STD.Str.ToUpperCase(L.IDChild[9].orig_id_country);
		self.orig_id_country_10 				:= STD.Str.ToUpperCase(L.IDChild[10].orig_id_country);
		self.orig_id_issue_date_1 			:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[1].orig_id_issue_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_issue_date_2 			:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[2].orig_id_issue_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_issue_date_3 			:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[3].orig_id_issue_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_issue_date_4 			:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[4].orig_id_issue_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_issue_date_5 			:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[5].orig_id_issue_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_issue_date_6 			:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[6].orig_id_issue_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_issue_date_7 			:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[7].orig_id_issue_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_issue_date_8 			:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[8].orig_id_issue_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_issue_date_9 			:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[9].orig_id_issue_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_issue_date_10 			:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[10].orig_id_issue_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_expiration_date_1 	:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[1].orig_id_expiration_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_expiration_date_2 	:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[2].orig_id_expiration_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_expiration_date_3 	:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[3].orig_id_expiration_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_expiration_date_4 	:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[4].orig_id_expiration_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_expiration_date_5 	:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[5].orig_id_expiration_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_expiration_date_6 	:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[6].orig_id_expiration_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_expiration_date_7 	:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[7].orig_id_expiration_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_expiration_date_8 	:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[8].orig_id_expiration_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_expiration_date_9 	:= ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[9].orig_id_expiration_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_id_expiration_date_10 := ut.ConvertDate(STD.Str.FindReplace(
																														trim(L.IDChild[10].orig_id_expiration_date,left,right),' ','-')
																											, fmtin := '%d-%b-%Y', fmtout := '%Y%m%d');
		self.orig_nationality_id_1 			:= L.NationalityChild[1].orig_nationality_id;
		self.orig_nationality_id_2 			:= L.NationalityChild[2].orig_nationality_id;
		self.orig_nationality_id_3 			:= L.NationalityChild[3].orig_nationality_id;
		self.orig_nationality_id_4 			:= L.NationalityChild[4].orig_nationality_id;
		self.orig_nationality_id_5 			:= L.NationalityChild[5].orig_nationality_id;
		self.orig_nationality_id_6 			:= L.NationalityChild[6].orig_nationality_id;
		self.orig_nationality_id_7 			:= L.NationalityChild[7].orig_nationality_id;
		self.orig_nationality_id_8 			:= L.NationalityChild[8].orig_nationality_id;
		self.orig_nationality_id_9 			:= L.NationalityChild[9].orig_nationality_id;
		self.orig_nationality_id_10 		:= L.NationalityChild[10].orig_nationality_id;
		self.orig_nationality_1 				:= STD.Str.ToUpperCase(L.NationalityChild[1].orig_nationality);
		self.orig_nationality_2 				:= STD.Str.ToUpperCase(L.NationalityChild[2].orig_nationality);
		self.orig_nationality_3 				:= STD.Str.ToUpperCase(L.NationalityChild[3].orig_nationality);
		self.orig_nationality_4 				:= STD.Str.ToUpperCase(L.NationalityChild[4].orig_nationality);
		self.orig_nationality_5 				:= STD.Str.ToUpperCase(L.NationalityChild[5].orig_nationality);
		self.orig_nationality_6 				:= STD.Str.ToUpperCase(L.NationalityChild[6].orig_nationality);
		self.orig_nationality_7 				:= STD.Str.ToUpperCase(L.NationalityChild[7].orig_nationality);
		self.orig_nationality_8 				:= STD.Str.ToUpperCase(L.NationalityChild[8].orig_nationality);
		self.orig_nationality_9 				:= STD.Str.ToUpperCase(L.NationalityChild[9].orig_nationality);
		self.orig_nationality_10 				:= STD.Str.ToUpperCase(L.NationalityChild[10].orig_nationality);
		self.orig_primary_nationality_flag_1 	:= STD.Str.ToUpperCase(L.NationalityChild[1].orig_primary_nationality_flag);
		self.orig_primary_nationality_flag_2 	:= STD.Str.ToUpperCase(L.NationalityChild[2].orig_primary_nationality_flag);
		self.orig_primary_nationality_flag_3 	:= STD.Str.ToUpperCase(L.NationalityChild[3].orig_primary_nationality_flag);
		self.orig_primary_nationality_flag_4 	:= STD.Str.ToUpperCase(L.NationalityChild[4].orig_primary_nationality_flag);
		self.orig_primary_nationality_flag_5 	:= STD.Str.ToUpperCase(L.NationalityChild[5].orig_primary_nationality_flag);
		self.orig_primary_nationality_flag_6 	:= STD.Str.ToUpperCase(L.NationalityChild[6].orig_primary_nationality_flag);
		self.orig_primary_nationality_flag_7 	:= STD.Str.ToUpperCase(L.NationalityChild[7].orig_primary_nationality_flag);
		self.orig_primary_nationality_flag_8 	:= STD.Str.ToUpperCase(L.NationalityChild[8].orig_primary_nationality_flag);
		self.orig_primary_nationality_flag_9 	:= STD.Str.ToUpperCase(L.NationalityChild[9].orig_primary_nationality_flag);
		self.orig_primary_nationality_flag_10 := STD.Str.ToUpperCase(L.NationalityChild[10].orig_primary_nationality_flag);
		self.orig_citizenship_id_1 						:= L.CitizenshipChild[1].orig_citizenship_id;
		self.orig_citizenship_id_2 						:= L.CitizenshipChild[2].orig_citizenship_id;
		self.orig_citizenship_id_3 						:= L.CitizenshipChild[3].orig_citizenship_id;
		self.orig_citizenship_id_4 						:= L.CitizenshipChild[4].orig_citizenship_id;
		self.orig_citizenship_id_5 						:= L.CitizenshipChild[5].orig_citizenship_id;
		self.orig_citizenship_id_6 						:= L.CitizenshipChild[6].orig_citizenship_id;
		self.orig_citizenship_id_7 						:= L.CitizenshipChild[7].orig_citizenship_id;
		self.orig_citizenship_id_8 						:= L.CitizenshipChild[8].orig_citizenship_id;
		self.orig_citizenship_id_9 						:= L.CitizenshipChild[9].orig_citizenship_id;
		self.orig_citizenship_id_10 					:= L.CitizenshipChild[10].orig_citizenship_id;
		self.orig_citizenship_1 							:= STD.Str.ToUpperCase(L.CitizenshipChild[1].orig_citizenship);
		self.orig_citizenship_2 							:= STD.Str.ToUpperCase(L.CitizenshipChild[2].orig_citizenship);
		self.orig_citizenship_3 							:= STD.Str.ToUpperCase(L.CitizenshipChild[3].orig_citizenship);
		self.orig_citizenship_4 							:= STD.Str.ToUpperCase(L.CitizenshipChild[4].orig_citizenship);
		self.orig_citizenship_5 							:= STD.Str.ToUpperCase(L.CitizenshipChild[5].orig_citizenship);
		self.orig_citizenship_6 							:= STD.Str.ToUpperCase(L.CitizenshipChild[6].orig_citizenship);
		self.orig_citizenship_7 							:= STD.Str.ToUpperCase(L.CitizenshipChild[7].orig_citizenship);
		self.orig_citizenship_8 							:= STD.Str.ToUpperCase(L.CitizenshipChild[8].orig_citizenship);
		self.orig_citizenship_9 							:= STD.Str.ToUpperCase(L.CitizenshipChild[9].orig_citizenship);
		self.orig_citizenship_10 							:= STD.Str.ToUpperCase(L.CitizenshipChild[10].orig_citizenship);
		self.orig_primary_citizenship_flag_1 	:= STD.Str.ToUpperCase(L.CitizenshipChild[1].orig_primary_citizenship_flag);
		self.orig_primary_citizenship_flag_2 	:= STD.Str.ToUpperCase(L.CitizenshipChild[2].orig_primary_citizenship_flag);
		self.orig_primary_citizenship_flag_3 	:= STD.Str.ToUpperCase(L.CitizenshipChild[3].orig_primary_citizenship_flag);
		self.orig_primary_citizenship_flag_4 	:= STD.Str.ToUpperCase(L.CitizenshipChild[4].orig_primary_citizenship_flag);
		self.orig_primary_citizenship_flag_5 	:= STD.Str.ToUpperCase(L.CitizenshipChild[5].orig_primary_citizenship_flag);
		self.orig_primary_citizenship_flag_6 	:= STD.Str.ToUpperCase(L.CitizenshipChild[6].orig_primary_citizenship_flag);
		self.orig_primary_citizenship_flag_7 	:= STD.Str.ToUpperCase(L.CitizenshipChild[7].orig_primary_citizenship_flag);
		self.orig_primary_citizenship_flag_8 	:= STD.Str.ToUpperCase(L.CitizenshipChild[8].orig_primary_citizenship_flag);
		self.orig_primary_citizenship_flag_9 	:= STD.Str.ToUpperCase(L.CitizenshipChild[9].orig_primary_citizenship_flag);
		self.orig_primary_citizenship_flag_10 := STD.Str.ToUpperCase(L.CitizenshipChild[10].orig_primary_citizenship_flag);
		self.orig_dob_id_1 										:= L.DOBChild[1].orig_dob_id;
		self.orig_dob_id_2 										:= L.DOBChild[2].orig_dob_id;
		self.orig_dob_id_3 										:= L.DOBChild[3].orig_dob_id;
		self.orig_dob_id_4 										:= L.DOBChild[4].orig_dob_id;
		self.orig_dob_id_5 										:= L.DOBChild[5].orig_dob_id;
		self.orig_dob_id_6 										:= L.DOBChild[6].orig_dob_id;
		self.orig_dob_id_7 										:= L.DOBChild[7].orig_dob_id;
		self.orig_dob_id_8 										:= L.DOBChild[8].orig_dob_id;
		self.orig_dob_id_9 										:= L.DOBChild[9].orig_dob_id;
		self.orig_dob_id_10 									:= L.DOBChild[10].orig_dob_id;
		self.orig_dob_1 		:= REGEXREPLACE('^C\\. |^CIRCA ',
														REGEXREPLACE(' NOV | NOV\\. | NOVEMBER ',
															REGEXREPLACE(' OCT | OCT\\. | OCTOBER ',
																REGEXREPLACE(' SEP | SEP\\. | SEPT | SEPTEMBER ',
																	REGEXREPLACE(' AUG | AUG\\. | AUGUST ',
																		REGEXREPLACE(' JUL | JUL\\. | JULY ',
																			REGEXREPLACE(' JUN | JUN\\. | JUNE ',
																				REGEXREPLACE(' MAY ',
																					REGEXREPLACE(' APR | APR\\. | APRIL ',
																						REGEXREPLACE(' MAR | MAR\\. | MARCH ',
																							REGEXREPLACE(' FEB | FEB\\. | FEBRUARY ',
																								REGEXREPLACE(' JAN | JAN\\. | JANUARY ',
																									REGEXREPLACE(' DEC | DEC\\. | DECEMBER ', TRIM(STD.Str.ToUpperCase(L.DOBChild[1].orig_dob), left, right)
																										,'/12/')
																									,'/01/')
																								,'/02/')
																							,'/03/')
																						,'/04/')
																					,'/05/')
																				,'/06/')
																			,'/07/')
																		,'/08/')
																	,'/09/')
																,'/10/')
															,'/11/')
														,'');
		self.orig_dob_2 		:= REGEXREPLACE('^C\\. |^CIRCA ',
														REGEXREPLACE(' NOV | NOV\\. | NOVEMBER ',
															REGEXREPLACE(' OCT | OCT\\. | OCTOBER ',
																REGEXREPLACE(' SEP | SEP\\. | SEPT | SEPTEMBER ', 
																	REGEXREPLACE(' AUG | AUG\\. | AUGUST ',
																		REGEXREPLACE(' JUL | JUL\\. | JULY ',
																			REGEXREPLACE(' JUN | JUN\\. | JUNE ',
																				REGEXREPLACE(' MAY ',
																					REGEXREPLACE(' APR | APR\\. | APRIL ',
																						REGEXREPLACE(' MAR | MAR\\. | MARCH ',
																							REGEXREPLACE(' FEB | FEB\\. | FEBRUARY ',
																								REGEXREPLACE(' JAN | JAN\\. | JANUARY ',
																									REGEXREPLACE(' DEC | DEC\\. | DECEMBER ', TRIM(STD.Str.ToUpperCase(L.DOBChild[2].orig_dob), left, right)
																										,'/12/')
																									,'/01/')
																								,'/02/')
																							,'/03/')
																						,'/04/')
																					,'/05/')
																				,'/06/')
																			,'/07/')
																		,'/08/')
																	,'/09/')
                                ,'/10/')
															,'/11/')
														,'');
		self.orig_dob_3 		:= REGEXREPLACE('^C\\. |^CIRCA ',
														REGEXREPLACE(' NOV | NOV\\. | NOVEMBER ',
															REGEXREPLACE(' OCT | OCT\\. | OCTOBER ',
																REGEXREPLACE(' SEP | SEP\\. | SEPT | SEPTEMBER ',
																	REGEXREPLACE(' AUG | AUG\\. | AUGUST ',
																		REGEXREPLACE(' JUL | JUL\\. | JULY ',
																			REGEXREPLACE(' JUN | JUN\\. | JUNE ',
																				REGEXREPLACE(' MAY ',
																					REGEXREPLACE(' APR | APR\\. | APRIL ',
																						REGEXREPLACE(' MAR | MAR\\. | MARCH ',
																							REGEXREPLACE(' FEB | FEB\\. | FEBRUARY ',
																								REGEXREPLACE(' JAN | JAN\\. | JANUARY ',
																									REGEXREPLACE(' DEC | DEC\\. | DECEMBER ', TRIM(STD.Str.ToUpperCase(L.DOBChild[3].orig_dob), left, right)
																										,'/12/')
																									,'/01/')
																								,'/02/')
																							,'/03/')
																						,'/04/')
																					,'/05/')
																				,'/06/')
																			,'/07/')
																		,'/08/')
																	,'/09/')
																,'/10/')
															,'/11/')
														,'');
		self.orig_dob_4 		:= REGEXREPLACE('^C\\. |^CIRCA ',
														REGEXREPLACE(' NOV | NOV\\. | NOVEMBER ',
															REGEXREPLACE(' OCT | OCT\\. | OCTOBER ',
																REGEXREPLACE(' SEP | SEP\\. | SEPT | SEPTEMBER ',
																	REGEXREPLACE(' AUG | AUG\\. | AUGUST ',
																		REGEXREPLACE(' JUL | JUL\\. | JULY ',
																			REGEXREPLACE(' JUN | JUN\\. | JUNE ',
																				REGEXREPLACE(' MAY ',
																					REGEXREPLACE(' APR | APR\\. | APRIL ',
																						REGEXREPLACE(' MAR | MAR\\. | MARCH ',
																							REGEXREPLACE(' FEB | FEB\\. | FEBRUARY ',
																								REGEXREPLACE(' JAN | JAN\\. | JANUARY ',
																									REGEXREPLACE(' DEC | DEC\\. | DECEMBER ', TRIM(STD.Str.ToUpperCase(L.DOBChild[4].orig_dob), left, right)
																										,'/12/')
																									,'/01/')
																								,'/02/')
																							,'/03/')
																						,'/04/')
																					,'/05/')
																				,'/06/')
																			,'/07/')
																		,'/08/')
																	,'/09/')
																,'/10/')
															,'/11/')
														,'');
		self.orig_dob_5 		:= REGEXREPLACE('^C\\. |^CIRCA ',
														REGEXREPLACE(' NOV | NOV\\. | NOVEMBER ',
															REGEXREPLACE(' OCT | OCT\\. | OCTOBER ',
																REGEXREPLACE(' SEP | SEP\\. | SEPT | SEPTEMBER ',
																	REGEXREPLACE(' AUG | AUG\\. | AUGUST ',
																		REGEXREPLACE(' JUL | JUL\\. | JULY ',
																			REGEXREPLACE(' JUN | JUN\\. | JUNE ',
																				REGEXREPLACE(' MAY ',
																					REGEXREPLACE(' APR | APR\\. | APRIL ',
																						REGEXREPLACE(' MAR | MAR\\. | MARCH ',
																							REGEXREPLACE(' FEB | FEB\\. | FEBRUARY ',
																								REGEXREPLACE(' JAN | JAN\\. | JANUARY ',
																									REGEXREPLACE(' DEC | DEC\\. | DECEMBER ', TRIM(STD.Str.ToUpperCase(L.DOBChild[5].orig_dob), left, right)
																										,'/12/')
																									,'/01/')
																								,'/02/')
																							,'/03/')
																						,'/04/')
																					,'/05/')
																				,'/06/')
																			,'/07/')
																		,'/08/')
																	,'/09/')
																,'/10/')
															,'/11/')
														,'');
		self.orig_dob_6 		:= REGEXREPLACE('^C\\. |^CIRCA ',
														REGEXREPLACE(' NOV | NOV\\. | NOVEMBER ',
															REGEXREPLACE(' OCT | OCT\\. | OCTOBER ',
																REGEXREPLACE(' SEP | SEP\\. | SEPT | SEPTEMBER ',
																	REGEXREPLACE(' AUG | AUG\\. | AUGUST ',
																		REGEXREPLACE(' JUL | JUL\\. | JULY ',
																			REGEXREPLACE(' JUN | JUN\\. | JUNE ',
																				REGEXREPLACE(' MAY ',
																					REGEXREPLACE(' APR | APR\\. | APRIL ',
																						REGEXREPLACE(' MAR | MAR\\. | MARCH ',
																							REGEXREPLACE(' FEB | FEB\\. | FEBRUARY ',
																								REGEXREPLACE(' JAN | JAN\\. | JANUARY ',
																									REGEXREPLACE(' DEC | DEC\\. | DECEMBER ', TRIM(STD.Str.ToUpperCase(L.DOBChild[6].orig_dob), left, right)
																										,'/12/')
																									,'/01/')
																								,'/02/')
																							,'/03/')
																						,'/04/')
																					,'/05/')
																				,'/06/')
																			,'/07/')
																		,'/08/')
																	,'/09/')
																,'/10/')
															,'/11/')
														,'');
		self.orig_dob_7 		:= REGEXREPLACE('^C\\. |^CIRCA ',
														REGEXREPLACE(' NOV | NOV\\. | NOVEMBER ',
															REGEXREPLACE(' OCT | OCT\\. | OCTOBER ',
																REGEXREPLACE(' SEP | SEP\\. | SEPT | SEPTEMBER ',
																	REGEXREPLACE(' AUG | AUG\\. | AUGUST ',
																		REGEXREPLACE(' JUL | JUL\\. | JULY ',
																			REGEXREPLACE(' JUN | JUN\\. | JUNE ',
																				REGEXREPLACE(' MAY ',
																					REGEXREPLACE(' APR | APR\\. | APRIL ',
																						REGEXREPLACE(' MAR | MAR\\. | MARCH ',
																							REGEXREPLACE(' FEB | FEB\\. | FEBRUARY ',
																								REGEXREPLACE(' JAN | JAN\\. | JANUARY ',
																									REGEXREPLACE(' DEC | DEC\\. | DECEMBER ', TRIM(STD.Str.ToUpperCase(L.DOBChild[7].orig_dob), left, right)
																										,'/12/')
																									,'/01/')
																								,'/02/')
																							,'/03/')
																						,'/04/')
																					,'/05/')
																				,'/06/')
																			,'/07/')
																		,'/08/')
																	,'/09/')
																,'/10/')
															,'/11/')
														,'');
		self.orig_dob_8 		:= REGEXREPLACE('^C\\. |^CIRCA ',
														REGEXREPLACE(' NOV | NOV\\. | NOVEMBER ',
															REGEXREPLACE(' OCT | OCT\\. | OCTOBER ',
																REGEXREPLACE(' SEP | SEP\\. | SEPT | SEPTEMBER ',
																	REGEXREPLACE(' AUG | AUG\\. | AUGUST ',
																		REGEXREPLACE(' JUL | JUL\\. | JULY ',
																			REGEXREPLACE(' JUN | JUN\\. | JUNE ',
																				REGEXREPLACE(' MAY ',
																					REGEXREPLACE(' APR | APR\\. | APRIL ',
																						REGEXREPLACE(' MAR | MAR\\. | MARCH ',
																							REGEXREPLACE(' FEB | FEB\\. | FEBRUARY ',
																								REGEXREPLACE(' JAN | JAN\\. | JANUARY ',
																									REGEXREPLACE(' DEC | DEC\\. | DECEMBER ', TRIM(STD.Str.ToUpperCase(L.DOBChild[8].orig_dob), left, right)
																										,'/12/')
																									,'/01/')
																								,'/02/')
																							,'/03/')
																						,'/04/')
																					,'/05/')
																				,'/06/')
																			,'/07/')
																		,'/08/')
																	,'/09/')
																,'/10/')
															,'/11/')
														,'');
		self.orig_dob_9 		:= REGEXREPLACE('^C\\. |^CIRCA ',
														REGEXREPLACE(' NOV | NOV\\. | NOVEMBER ',
															REGEXREPLACE(' OCT | OCT\\. | OCTOBER ',
																REGEXREPLACE(' SEP | SEP\\. | SEPT | SEPTEMBER ',
																	REGEXREPLACE(' AUG | AUG\\. | AUGUST ',
																		REGEXREPLACE(' JUL | JUL\\. | JULY ',
																			REGEXREPLACE(' JUN | JUN\\. | JUNE ',
																				REGEXREPLACE(' MAY ',
																					REGEXREPLACE(' APR | APR\\. | APRIL ',
																						REGEXREPLACE(' MAR | MAR\\. | MARCH ',
																							REGEXREPLACE(' FEB | FEB\\. | FEBRUARY ',
																								REGEXREPLACE(' JAN | JAN\\. | JANUARY ',
																									REGEXREPLACE(' DEC | DEC\\. | DECEMBER ', TRIM(STD.Str.ToUpperCase(L.DOBChild[9].orig_dob), left, right)
																										,'/12/')
																									,'/01/')
																								,'/02/')
																							,'/03/')
																						,'/04/')
																					,'/05/')
																				,'/06/')
																			,'/07/')
																		,'/08/')
																	,'/09/')
																,'/10/')
															,'/11/')
														,'');
		self.orig_dob_10 		:= REGEXREPLACE('^C\\. |^CIRCA ',
														REGEXREPLACE(' NOV | NOV\\. | NOVEMBER ',
															REGEXREPLACE(' OCT | OCT\\. | OCTOBER ',
																REGEXREPLACE(' SEP | SEP\\. | SEPT | SEPTEMBER ',
																	REGEXREPLACE(' AUG | AUG\\. | AUGUST ',
																		REGEXREPLACE(' JUL | JUL\\. | JULY ',
																			REGEXREPLACE(' JUN | JUN\\. | JUNE ',
																				REGEXREPLACE(' MAY ',
																					REGEXREPLACE(' APR | APR\\. | APRIL ',
																						REGEXREPLACE(' MAR | MAR\\. | MARCH ',
																							REGEXREPLACE(' FEB | FEB\\. | FEBRUARY ',
																								REGEXREPLACE(' JAN | JAN\\. | JANUARY ',
																									REGEXREPLACE(' DEC | DEC\\. | DECEMBER ', TRIM(STD.Str.ToUpperCase(L.DOBChild[10].orig_dob), left, right)
																										,'/12/')
																									,'/01/')
																								,'/02/')
																							,'/03/')
																						,'/04/')
																					,'/05/')
																				,'/06/')
																			,'/07/')
																		,'/08/')
																	,'/09/')
																,'/10/')
															,'/11/')
														,'');
		self.orig_primary_dob_flag_1 	:= L.DOBChild[1].orig_primary_dob_flag;
		self.orig_primary_dob_flag_2 	:= L.DOBChild[2].orig_primary_dob_flag;
		self.orig_primary_dob_flag_3 	:= L.DOBChild[3].orig_primary_dob_flag;
		self.orig_primary_dob_flag_4 	:= L.DOBChild[4].orig_primary_dob_flag;
		self.orig_primary_dob_flag_5 	:= L.DOBChild[5].orig_primary_dob_flag;
		self.orig_primary_dob_flag_6 	:= L.DOBChild[6].orig_primary_dob_flag;
		self.orig_primary_dob_flag_7 	:= L.DOBChild[7].orig_primary_dob_flag;
		self.orig_primary_dob_flag_8 	:= L.DOBChild[8].orig_primary_dob_flag;
		self.orig_primary_dob_flag_9 	:= L.DOBChild[9].orig_primary_dob_flag;
		self.orig_primary_dob_flag_10 := L.DOBChild[10].orig_primary_dob_flag;
		self.orig_pob_id_1 						:= L.POBChild[1].orig_pob_id;
		self.orig_pob_id_2 						:= L.POBChild[2].orig_pob_id;
		self.orig_pob_id_3 						:= L.POBChild[3].orig_pob_id;
		self.orig_pob_id_4 						:= L.POBChild[4].orig_pob_id;
		self.orig_pob_id_5 						:= L.POBChild[5].orig_pob_id;
		self.orig_pob_id_6 						:= L.POBChild[6].orig_pob_id;
		self.orig_pob_id_7 						:= L.POBChild[7].orig_pob_id;
		self.orig_pob_id_8 						:= L.POBChild[8].orig_pob_id;
		self.orig_pob_id_9 						:= L.POBChild[9].orig_pob_id;
		self.orig_pob_id_10 					:= L.POBChild[10].orig_pob_id;
		self.orig_pob_1 							:= STD.Str.ToUpperCase(L.POBChild[1].orig_pob);
		self.orig_pob_2 							:= STD.Str.ToUpperCase(L.POBChild[2].orig_pob);
		self.orig_pob_3 							:= STD.Str.ToUpperCase(L.POBChild[3].orig_pob);
		self.orig_pob_4 							:= STD.Str.ToUpperCase(L.POBChild[4].orig_pob);
		self.orig_pob_5 							:= STD.Str.ToUpperCase(L.POBChild[5].orig_pob);
		self.orig_pob_6 							:= STD.Str.ToUpperCase(L.POBChild[6].orig_pob);
		self.orig_pob_7 							:= STD.Str.ToUpperCase(L.POBChild[7].orig_pob);
		self.orig_pob_8 							:= STD.Str.ToUpperCase(L.POBChild[8].orig_pob);
		self.orig_pob_9 							:= STD.Str.ToUpperCase(L.POBChild[9].orig_pob);
		self.orig_pob_10 							:= STD.Str.ToUpperCase(L.POBChild[10].orig_pob);
		self.orig_primary_pob_flag_1 	:= L.POBChild[1].orig_primary_pob_flag;
		self.orig_primary_pob_flag_2 	:=	L.POBChild[2].orig_primary_pob_flag;
		self.orig_primary_pob_flag_3 	:= L.POBChild[3].orig_primary_pob_flag;
		self.orig_primary_pob_flag_4 	:= L.POBChild[4].orig_primary_pob_flag;
		self.orig_primary_pob_flag_5 	:= L.POBChild[5].orig_primary_pob_flag;
		self.orig_primary_pob_flag_6 	:= L.POBChild[6].orig_primary_pob_flag;
		self.orig_primary_pob_flag_7 	:= L.POBChild[7].orig_primary_pob_flag;
		self.orig_primary_pob_flag_8 	:= L.POBChild[8].orig_primary_pob_flag;
		self.orig_primary_pob_flag_9 	:= L.POBChild[9].orig_primary_pob_flag;
		self.orig_primary_pob_flag_10 := L.POBChild[10].orig_primary_pob_flag;
		self.orig_raw_Name := L.orig_raw_name;
		self := L;
	END;
	
	OFACoutputRecs := PROJECT(dsOFAC, ReformatToCommonlayout(LEFT));
	
	
	rOutLayout CleanDOB(rOutLayout L) := TRANSFORM
		integer Slashcnt_dob_1 := STD.Str.FindCount(L.orig_dob_1, '/');
		self.orig_dob_1 := if(length(STD.Str.Filter(L.orig_dob_1, '/')) = 2 and length(TRIM(L.orig_dob_1, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_1, '/', Slashcnt_dob_1) = 4
													,fSlashedDMYtoYMD(L.orig_dob_1)
													,if(length(STD.Str.Filter(L.orig_dob_1, '/')) = 2 and length(TRIM(L.orig_dob_1, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_1, '/', Slashcnt_dob_1) = 2
														,fSlashedDMYtoYMD(L.orig_dob_1[1..length(TRIM(L.orig_dob_1, LEFT, RIGHT))-2] + '19' + TRIM(L.orig_dob_1, LEFT, RIGHT)[length(TRIM(L.orig_dob_1, LEFT, RIGHT))-1..2 + length(TRIM(L.orig_dob_1, LEFT, RIGHT))-1])
														,if(length(TRIM(L.orig_dob_1, LEFT, RIGHT)) > 4 and length(TRIM(L.orig_dob_1, LEFT, RIGHT)) < 9
															,STD.Str.FindReplace(
																STD.Str.FindReplace(
																	fSlashedDMYtoYMD(STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(TRIM(L.orig_dob_1, LEFT, RIGHT), 'JAN ', '01/01/')
																											,'FEB ', '01/02/')
																										,'MAR ', '01/03/')
																									,'APR ', '01/04/')
                                                ,'MAY ', '01/05/')
																							,'JUN ', '01/06/')
                                            ,'JUL ', '01/07/')
																					,'AUG ', '01/08/')
																				,'SEP ', '01/09/')
																			,'OCT ', '01/10/')
																		,'NOV ', '01/11/')
																	,'DEC ', '01/12/'))
                                ,'01$', '00')
															,'^00', '19')
														,if(length(TRIM(L.orig_dob_1, LEFT, RIGHT)) > 8
															,fSlashedMDYtoYMD(STD.Str.FindReplace(
																STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(TRIM(L.orig_dob_1, LEFT, RIGHT), 'JAN ', '01/')
																										,'FEB ', '02/')																										
																									,'MAR ', '03/')
																								,'APR ', '04/')
                                              ,'MAY ', '05/')
																						,'JUN ', '06/')
																					,'JUL ', '07/')
																				,'AUG ', '08/')
																			,'SEP ', '09/')
																		,'OCT ', '10/')
																	,'NOV ', '11/')
																,'DEC ', '12/')
															,' ', '/'))
													,L.orig_dob_1))));  /*Record 1*/
													
		integer Slashcnt_dob_2 := STD.Str.FindCount(L.orig_dob_2, '/');
		self.orig_dob_2 := if(length(STD.Str.Filter(L.orig_dob_2, '/')) = 2 and length(TRIM(L.orig_dob_2, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_2, '/', Slashcnt_dob_2) = 4
													,fSlashedDMYtoYMD(L.orig_dob_2)
													,if(length(STD.Str.Filter(L.orig_dob_2, '/')) = 2 and length(TRIM(L.orig_dob_2, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_2, '/', Slashcnt_dob_2) = 2
														,fSlashedDMYtoYMD(L.orig_dob_2[1..length(TRIM(L.orig_dob_2, LEFT, RIGHT))-2] + '19' + TRIM(L.orig_dob_2, LEFT, RIGHT)[length(TRIM(L.orig_dob_2, LEFT, RIGHT))-1..2 + length(TRIM(L.orig_dob_2, LEFT, RIGHT))-1-1])
														,if(length(TRIM(L.orig_dob_2, LEFT, RIGHT)) > 4 and length(TRIM(L.orig_dob_2, LEFT, RIGHT)) < 9
															,STD.Str.FindReplace(
																STD.Str.FindReplace(
																	fSlashedDMYtoYMD(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(TRIM(L.orig_dob_2, LEFT, RIGHT), 'JAN ', '01/01/')
																												,'FEB ', '01/02/')
																											,'MAR ', '01/03/')
																										,'APR ', '01/04/')
																									,'MAY ', '01/05/')
																								,'JUN ', '01/06/')
																							,'JUL ', '01/07/')
																						,'AUG ', '01/08/')
																					,'SEP ', '01/09/')
																				,'OCT ', '01/10/')
																			,'NOV ', '01/11/')
																		,'DEC ', '01/12/'))
                                  ,'01$', '00')
																,'^00', '19')
															,if(length(TRIM(L.orig_dob_2)) > 8
																,fSlashedMDYtoYMD(STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(TRIM(L.orig_dob_2, LEFT, RIGHT), 'JAN ', '01/')
																											,'FEB ', '02/')
																										,'MAR ', '03/')
																									,'APR ', '04/')
																								,'MAY ', '05/')
																							,'JUN ', '06/')
																						,'JUL ', '07/')
																					,'AUG ', '08/')
																				,'SEP ', '09/')
																			,'OCT ', '10/')
																		,'NOV ', '11/')
																	,'DEC ', '12/')
																,' ', '/'))
															,L.orig_dob_2))));  /*Record 2*/
		
		integer Slashcnt_dob_3 := STD.Str.FindCount(L.orig_dob_3, '/');
		self.orig_dob_3 := if(length(STD.Str.Filter(L.orig_dob_3, '/')) = 2 and length(TRIM(L.orig_dob_3, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_3, '/', Slashcnt_dob_3) = 4
													,fSlashedDMYtoYMD(L.orig_dob_3)
													,if(length(STD.Str.Filter(L.orig_dob_3, '/')) = 2 and length(TRIM(L.orig_dob_3, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_3, '/', Slashcnt_dob_3) = 2
														,fSlashedDMYtoYMD(L.orig_dob_3[1..length(TRIM(L.orig_dob_3, LEFT, RIGHT))-2] + '19' + TRIM(L.orig_dob_3, LEFT, RIGHT)[length(TRIM(L.orig_dob_3, LEFT, RIGHT))-1..2 + length(TRIM(L.orig_dob_3, LEFT, RIGHT))-1-1])
														,if(length(TRIM(L.orig_dob_3, LEFT, RIGHT)) > 4 and length(TRIM(L.orig_dob_3, LEFT, RIGHT)) < 9
															,STD.Str.FindReplace(
																STD.Str.FindReplace(
																	fSlashedDMYtoYMD(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(TRIM(L.orig_dob_3, LEFT, RIGHT), 'JAN ', '01/01/')
																												,'FEB ', '01/02/')
																											,'MAR ', '01/03/')
																										,'APR ', '01/04/')
																									,'MAY ', '01/05/')
																								,'JUN ', '01/06/')
																							,'JUL ', '01/07/')
																						,'AUG ', '01/08/')
																					,'SEP ', '01/09/')
																				,'OCT ', '01/10/')
																			,'NOV ', '01/11/')
																		,'DEC ', '01/12/'))
                                  ,'01$', '00')
																,'^00', '19')
															,if(length(TRIM(L.orig_dob_3)) > 8
																,fSlashedMDYtoYMD(STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(TRIM(L.orig_dob_3, LEFT, RIGHT), 'JAN ', '01/')
																											,'FEB ', '02/')
																										,'MAR ', '03/')
																									,'APR ', '04/')
																								,'MAY ', '05/')
																							,'JUN ', '06/')
																						,'JUL ', '07/')
																					,'AUG ', '08/')
																				,'SEP ', '09/')
																			,'OCT ', '10/')
																		,'NOV ', '11/')
																	,'DEC ', '12/')
																,' ', '/'))
															,L.orig_dob_3))));  /*Record 3*/
		
		integer Slashcnt_dob_4 := STD.Str.FindCount(L.orig_dob_4, '/');
		self.orig_dob_4 := if(length(STD.Str.Filter(L.orig_dob_4, '/')) = 2 and length(TRIM(L.orig_dob_4, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_4, '/', Slashcnt_dob_4) = 4
													,fSlashedDMYtoYMD(L.orig_dob_4)
													,if(length(STD.Str.Filter(L.orig_dob_4, '/')) = 2 and length(TRIM(L.orig_dob_4, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_4, '/', Slashcnt_dob_4) = 2
														,fSlashedDMYtoYMD(L.orig_dob_4[1..length(TRIM(L.orig_dob_4, LEFT, RIGHT))-2] + '19' + TRIM(L.orig_dob_4, LEFT, RIGHT)[length(TRIM(L.orig_dob_4, LEFT, RIGHT))-1..2 + length(TRIM(L.orig_dob_4, LEFT, RIGHT))-1-1])
														,if(length(TRIM(L.orig_dob_4, LEFT, RIGHT)) > 4 and length(TRIM(L.orig_dob_4, LEFT, RIGHT)) < 9
															,STD.Str.FindReplace(
																STD.Str.FindReplace(
																	fSlashedDMYtoYMD(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(TRIM(L.orig_dob_4, LEFT, RIGHT), 'JAN ', '01/01/')
																												,'FEB ', '01/02/')
																											,'MAR ', '01/03/')
																										,'APR ', '01/04/')
																									,'MAY ', '01/05/')
																								,'JUN ', '01/06/')
																							,'JUL ', '01/07/')
																						,'AUG ', '01/08/')
																					,'SEP ', '01/09/')
																				,'OCT ', '01/10/')
																			,'NOV ', '01/11/')
																		,'DEC ', '01/12/'))
                                  ,'01$', '00')
																,'^00', '19')
															,if(length(TRIM(L.orig_dob_4)) > 8
																,fSlashedMDYtoYMD(STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(TRIM(L.orig_dob_4, LEFT, RIGHT), 'JAN ', '01/')
																											,'FEB ', '02/')
																										,'MAR ', '03/')
																									,'APR ', '04/')
																								,'MAY ', '05/')
																							,'JUN ', '06/')
																						,'JUL ', '07/')
																					,'AUG ', '08/')
																				,'SEP ', '09/')
																			,'OCT ', '10/')
																		,'NOV ', '11/')
																	,'DEC ', '12/')
																,' ', '/'))
															,L.orig_dob_4))));  /*Record 4*/
		
		integer Slashcnt_dob_5 := STD.Str.FindCount(L.orig_dob_5, '/');
		self.orig_dob_5 := if(length(STD.Str.Filter(L.orig_dob_5, '/')) = 2 and length(TRIM(L.orig_dob_5, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_5, '/', Slashcnt_dob_5) = 4
													,fSlashedDMYtoYMD(L.orig_dob_5)
													,if(length(STD.Str.Filter(L.orig_dob_5, '/')) = 2 and length(TRIM(L.orig_dob_5, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_5, '/', Slashcnt_dob_5) = 2
														,fSlashedDMYtoYMD(L.orig_dob_5[1..length(TRIM(L.orig_dob_5, LEFT, RIGHT))-2] + '19' + TRIM(L.orig_dob_5, LEFT, RIGHT)[length(TRIM(L.orig_dob_5, LEFT, RIGHT))-1..2 + length(TRIM(L.orig_dob_5, LEFT, RIGHT))-1-1])
														,if(length(TRIM(L.orig_dob_5, LEFT, RIGHT)) > 4 and length(TRIM(L.orig_dob_5, LEFT, RIGHT)) < 9
															,STD.Str.FindReplace(
																STD.Str.FindReplace(
																	fSlashedDMYtoYMD(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(TRIM(L.orig_dob_5, LEFT, RIGHT), 'JAN ', '01/01/')
																												,'FEB ', '01/02/')
																											,'MAR ', '01/03/')
																										,'APR ', '01/04/')
																									,'MAY ', '01/05/')
																								,'JUN ', '01/06/')
																							,'JUL ', '01/07/')
																						,'AUG ', '01/08/')
																					,'SEP ', '01/09/')
																				,'OCT ', '01/10/')
																			,'NOV ', '01/11/')
																		,'DEC ', '01/12/'))
                                  ,'01$', '00')
																,'^00', '19')
															,if(length(TRIM(L.orig_dob_5)) > 8
																,fSlashedMDYtoYMD(STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(TRIM(L.orig_dob_5, LEFT, RIGHT), 'JAN ', '01/')
																											,'FEB ', '02/')
																										,'MAR ', '03/')
																									,'APR ', '04/')
																								,'MAY ', '05/')
																							,'JUN ', '06/')
																						,'JUL ', '07/')
																					,'AUG ', '08/')
																				,'SEP ', '09/')
																			,'OCT ', '10/')
																		,'NOV ', '11/')
																	,'DEC ', '12/')
																,' ', '/'))
															,L.orig_dob_5))));  /*Record 5*/
		integer Slashcnt_dob_6 := STD.Str.FindCount(L.orig_dob_6, '/');
		self.orig_dob_6 := if(length(STD.Str.Filter(L.orig_dob_6, '/')) = 2 and length(TRIM(L.orig_dob_6, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_6, '/', Slashcnt_dob_6) = 4
													,fSlashedDMYtoYMD(L.orig_dob_6)
													,if(length(STD.Str.Filter(L.orig_dob_6, '/')) = 2 and length(TRIM(L.orig_dob_6, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_6, '/', Slashcnt_dob_6) = 2
														,fSlashedDMYtoYMD(L.orig_dob_6[1..length(TRIM(L.orig_dob_6, LEFT, RIGHT))-2] + '19' + TRIM(L.orig_dob_6, LEFT, RIGHT)[length(TRIM(L.orig_dob_6, LEFT, RIGHT))-1..2 + length(TRIM(L.orig_dob_6, LEFT, RIGHT))-1-1])
														,if(length(TRIM(L.orig_dob_6, LEFT, RIGHT)) > 4 and length(TRIM(L.orig_dob_6, LEFT, RIGHT)) < 9
															,STD.Str.FindReplace(
																STD.Str.FindReplace(
																	fSlashedDMYtoYMD(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(TRIM(L.orig_dob_6, LEFT, RIGHT), 'JAN ', '01/01/')
																												,'FEB ', '01/02/')
																											,'MAR ', '01/03/')
																										,'APR ', '01/04/')
																									,'MAY ', '01/05/')
																								,'JUN ', '01/06/')
																							,'JUL ', '01/07/')
																						,'AUG ', '01/08/')
																					,'SEP ', '01/09/')
																				,'OCT ', '01/10/')
																			,'NOV ', '01/11/')
																		,'DEC ', '01/12/'))
                                  ,'01$', '00')
																,'^00', '19')
															,if(length(TRIM(L.orig_dob_6)) > 8
																,fSlashedMDYtoYMD(STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(TRIM(L.orig_dob_6, LEFT, RIGHT), 'JAN ', '01/')
																											,'FEB ', '02/')
																										,'MAR ', '03/')
																									,'APR ', '04/')
																								,'MAY ', '05/')
																							,'JUN ', '06/')
																						,'JUL ', '07/')
																					,'AUG ', '08/')
																				,'SEP ', '09/')
																			,'OCT ', '10/')
																		,'NOV ', '11/')
																	,'DEC ', '12/')
																,' ', '/'))
															,L.orig_dob_6))));  /*Record 6*/
		integer Slashcnt_dob_7 := STD.Str.FindCount(L.orig_dob_7, '/');
		self.orig_dob_7 := if(length(STD.Str.Filter(L.orig_dob_7, '/')) = 2 and length(TRIM(L.orig_dob_7, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_7, '/', Slashcnt_dob_7) = 4
													,fSlashedDMYtoYMD(L.orig_dob_7)
													,if(length(STD.Str.Filter(L.orig_dob_7, '/')) = 2 and length(TRIM(L.orig_dob_7, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_7, '/', Slashcnt_dob_7) = 2
														,fSlashedDMYtoYMD(L.orig_dob_7[1..length(TRIM(L.orig_dob_7, LEFT, RIGHT))-2] + '19' + TRIM(L.orig_dob_7, LEFT, RIGHT)[length(TRIM(L.orig_dob_7, LEFT, RIGHT))-1..2 + length(TRIM(L.orig_dob_7, LEFT, RIGHT))-1-1])
														,if(length(TRIM(L.orig_dob_7, LEFT, RIGHT)) > 4 and length(TRIM(L.orig_dob_7, LEFT, RIGHT)) < 9
															,STD.Str.FindReplace(
																STD.Str.FindReplace(
																	fSlashedDMYtoYMD(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(TRIM(L.orig_dob_7, LEFT, RIGHT), 'JAN ', '01/01/')
																												,'FEB ', '01/02/')
																											,'MAR ', '01/03/')
																										,'APR ', '01/04/')
																									,'MAY ', '01/05/')
																								,'JUN ', '01/06/')
																							,'JUL ', '01/07/')
																						,'AUG ', '01/08/')
																					,'SEP ', '01/09/')
																				,'OCT ', '01/10/')
																			,'NOV ', '01/11/')
																		,'DEC ', '01/12/'))
                                  ,'01$', '00')
																,'^00', '19')
															,if(length(TRIM(L.orig_dob_7)) > 8
																,fSlashedMDYtoYMD(STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(TRIM(L.orig_dob_7, LEFT, RIGHT), 'JAN ', '01/')
																											,'FEB ', '02/')
																										,'MAR ', '03/')
																									,'APR ', '04/')
																								,'MAY ', '05/')
																							,'JUN ', '06/')
																						,'JUL ', '07/')
																					,'AUG ', '08/')
																				,'SEP ', '09/')
																			,'OCT ', '10/')
																		,'NOV ', '11/')
																	,'DEC ', '12/')
																,' ', '/'))
															,L.orig_dob_7))));  /*Record 7*/
		
		integer Slashcnt_dob_8 := STD.Str.FindCount(L.orig_dob_8, '/');
		self.orig_dob_8 := if(length(STD.Str.Filter(L.orig_dob_8, '/')) = 2 and length(TRIM(L.orig_dob_8, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_8, '/', Slashcnt_dob_8) = 4
													,fSlashedDMYtoYMD(L.orig_dob_8)
													,if(length(STD.Str.Filter(L.orig_dob_8, '/')) = 2 and length(TRIM(L.orig_dob_8, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_8, '/', Slashcnt_dob_8) = 2
														,fSlashedDMYtoYMD(L.orig_dob_8[1..length(TRIM(L.orig_dob_8, LEFT, RIGHT))-2] + '19' + TRIM(L.orig_dob_8, LEFT, RIGHT)[length(TRIM(L.orig_dob_8, LEFT, RIGHT))-1..2 + length(TRIM(L.orig_dob_8, LEFT, RIGHT))-1-1])
														,if(length(TRIM(L.orig_dob_8, LEFT, RIGHT)) > 4 and length(TRIM(L.orig_dob_8, LEFT, RIGHT)) < 9
															,STD.Str.FindReplace(
																STD.Str.FindReplace(
																	fSlashedDMYtoYMD(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(TRIM(L.orig_dob_8, LEFT, RIGHT), 'JAN ', '01/01/')
																												,'FEB ', '01/02/')
																											,'MAR ', '01/03/')
																										,'APR ', '01/04/')
																									,'MAY ', '01/05/')
																								,'JUN ', '01/06/')
																							,'JUL ', '01/07/')
																						,'AUG ', '01/08/')
																					,'SEP ', '01/09/')
																				,'OCT ', '01/10/')
																			,'NOV ', '01/11/')
																		,'DEC ', '01/12/'))
                                  ,'01$', '00')
																,'^00', '19')
															,if(length(TRIM(L.orig_dob_8)) > 8
																,fSlashedMDYtoYMD(STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(TRIM(L.orig_dob_8, LEFT, RIGHT), 'JAN ', '01/')
																											,'FEB ', '02/')
																										,'MAR ', '03/')
																									,'APR ', '04/')
																								,'MAY ', '05/')
																							,'JUN ', '06/')
																						,'JUL ', '07/')
																					,'AUG ', '08/')
																				,'SEP ', '09/')
																			,'OCT ', '10/')
																		,'NOV ', '11/')
																	,'DEC ', '12/')
																,' ', '/'))
															,L.orig_dob_8))));  /*Record 8*/
		integer Slashcnt_dob_9 := STD.Str.FindCount(L.orig_dob_9, '/');
		self.orig_dob_9 := if(length(STD.Str.Filter(L.orig_dob_9, '/')) = 2 and length(TRIM(L.orig_dob_9, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_9, '/', Slashcnt_dob_9) = 4
													,fSlashedDMYtoYMD(L.orig_dob_9)
													,if(length(STD.Str.Filter(L.orig_dob_9, '/')) = 2 and length(TRIM(L.orig_dob_9, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_9, '/', Slashcnt_dob_9) = 2
														,fSlashedDMYtoYMD(L.orig_dob_9[1..length(TRIM(L.orig_dob_9, LEFT, RIGHT))-2] + '19' + TRIM(L.orig_dob_9, LEFT, RIGHT)[length(TRIM(L.orig_dob_9, LEFT, RIGHT))-1..2 + length(TRIM(L.orig_dob_9, LEFT, RIGHT))-1-1])
														,if(length(TRIM(L.orig_dob_9, LEFT, RIGHT)) > 4 and length(TRIM(L.orig_dob_9, LEFT, RIGHT)) < 9
															,STD.Str.FindReplace(
																STD.Str.FindReplace(
																	fSlashedDMYtoYMD(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(TRIM(L.orig_dob_9, LEFT, RIGHT), 'JAN ', '01/01/')
																												,'FEB ', '01/02/')
																											,'MAR ', '01/03/')
																										,'APR ', '01/04/')
																									,'MAY ', '01/05/')
																								,'JUN ', '01/06/')
																							,'JUL ', '01/07/')
																						,'AUG ', '01/08/')
																					,'SEP ', '01/09/')
																				,'OCT ', '01/10/')
																			,'NOV ', '01/11/')
																		,'DEC ', '01/12/'))
                                  ,'01$', '00')
																,'^00', '19')
															,if(length(TRIM(L.orig_dob_9)) > 8
																,fSlashedMDYtoYMD(STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(TRIM(L.orig_dob_9, LEFT, RIGHT), 'JAN ', '01/')
																											,'FEB ', '02/')
																										,'MAR ', '03/')
																									,'APR ', '04/')
																								,'MAY ', '05/')
																							,'JUN ', '06/')
																						,'JUL ', '07/')
																					,'AUG ', '08/')
																				,'SEP ', '09/')
																			,'OCT ', '10/')
																		,'NOV ', '11/')
																	,'DEC ', '12/')
																,' ', '/'))
															,L.orig_dob_9))));  /*Record 9*/		
		integer Slashcnt_dob_10 := STD.Str.FindCount(L.orig_dob_10, '/');
		self.orig_dob_10 := if(length(STD.Str.Filter(L.orig_dob_10, '/')) = 2 and length(TRIM(L.orig_dob_10, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_10, '/', Slashcnt_dob_10) = 4
													,fSlashedDMYtoYMD(L.orig_dob_10)
													,if(length(STD.Str.Filter(L.orig_dob_10, '/')) = 2 and length(TRIM(L.orig_dob_10, LEFT, RIGHT)) - STD.Str.Find(L.orig_dob_10, '/', Slashcnt_dob_10) = 2
														,fSlashedDMYtoYMD(L.orig_dob_10[1..length(TRIM(L.orig_dob_10, LEFT, RIGHT))-2] + '19' + TRIM(L.orig_dob_10, LEFT, RIGHT)[length(TRIM(L.orig_dob_10, LEFT, RIGHT))-1..2 + length(TRIM(L.orig_dob_10, LEFT, RIGHT))-1-1])
														,if(length(TRIM(L.orig_dob_10, LEFT, RIGHT)) > 4 and length(TRIM(L.orig_dob_10, LEFT, RIGHT)) < 9
															,STD.Str.FindReplace(
																STD.Str.FindReplace(
																	fSlashedDMYtoYMD(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(TRIM(L.orig_dob_10, LEFT, RIGHT), 'JAN ', '01/01/')
																												,'FEB ', '01/02/')
																											,'MAR ', '01/03/')
																										,'APR ', '01/04/')
																									,'MAY ', '01/05/')
																								,'JUN ', '01/06/')
																							,'JUL ', '01/07/')
																						,'AUG ', '01/08/')
																					,'SEP ', '01/09/')
																				,'OCT ', '01/10/')
																			,'NOV ', '01/11/')
																		,'DEC ', '01/12/'))
                                  ,'01$', '00')
																,'^00', '19')
															,if(length(TRIM(L.orig_dob_10)) > 8
																,fSlashedMDYtoYMD(STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(
																						STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(TRIM(L.orig_dob_10, LEFT, RIGHT), 'JAN ', '01/')
																											,'FEB ', '02/')
																										,'MAR ', '03/')
																									,'APR ', '04/')
																								,'MAY ', '05/')
																							,'JUN ', '06/')
																						,'JUL ', '07/')
																					,'AUG ', '08/')
																				,'SEP ', '09/')
																			,'OCT ', '10/')
																		,'NOV ', '11/')
																	,'DEC ', '12/')
																,' ', '/'))
															,L.orig_dob_10))));  /*Record 10*/		
		self := L;
	END;
	
	return PROJECT(OFACoutputRecs, CleanDOB(LEFT));
END;

//END;