Import GlobalWatchLists_Preprocess, STD, lib_StringLib, ut, Address;

EXPORT ProcessEUTerroristList := FUNCTION
	
	ClnName(string InName) := FUNCTION
	string CleanName	:= STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(InName,'amnist a','amnistÃ­a')
                                                                                                        ,'Ferm n','FermÃ­n')
                                                                                         ,'Iv n','IvÃ¡n')
                                                                        ,'NARV EZ','NARVÃEZ')
                                                           ,'GO I','GOÃ‘I')
                                            ,'Jes s','JesÃºs')
                             ,'I igo','IÃ±igo')
              ,'R mi','RÃ¨mi');
	RETURN CleanName;
	END;

	//EU Terrorist Persons File
	HdrData	:= '(^Loading |^Orignal |^Number |^Author |^Writing |^Minrow=0 |Extract Date)(.*)';
	ds_person	:= GlobalWatchLists_Preprocess.Files.dsEUterroristListPerson(~REGEXFIND(HdrData,Sflag) and trim(Line,all) <> '');
	
	lRawParsed	:= RECORD
		GlobalWatchLists_Preprocess.Layouts.rEUterroristListPerson - Line;
		string350 orig_raw_name;
	END;
	
	//Clean names
	lRawParsed xfrmName(ds_person dInput) := TRANSFORM
	self.FullName		:= ClnName(dInput.FullName);
	self.FirstName	:= ClnName(dInput.FirstName);
	self.LastName		:= ClnName(dInput.LastName);
	self.AKA				:= REGEXREPLACE('$',ClnName(dInput.AKA),'|');
	self.orig_raw_name := TRIM(self.FullName,left,right)+IF(length(self.AKA) > 1,'; '+TRIM(self.AKA,left,right),'');
	self := dInput;
	END;

	ClnPersonRec	:= project(ds_person,xfrmName(left));
	
	//Normalize AKA names
	lParseAKA	:= RECORD
		recordof (ClnPersonRec);
		integer WordCount;
	END;

	lParseAKA	GetAKACount(ClnPersonRec L) := TRANSFORM
		self.WordCount	:= STD.Str.FindCount(L.AKA,'|');
		self := L;
	END;

	CountAKA	:= project(ClnPersonRec, GetAKACount(left));

	lParseAKA - WordCount ParseAKA(CountAKA L, integer C) := TRANSFORM
		TempAKA		:= IF(L.WordCount = 1,StringLib.StringFindReplace(L.AKA,'|',''),L.AKA);
		self.AKA	:= CHOOSE(C,IF(L.WordCount = 1,TempAKA,TempAKA[1..STD.Str.Find(TempAKA, '|',1) - 1]),
													TempAKA[STD.Str.Find(TempAKA, '|',1)+ 1..STD.Str.Find(TempAKA, '|',2) - 1],
													TempAKA[STD.Str.Find(TempAKA, '|',2)+ 1..STD.Str.Find(TempAKA, '|',3) - 1],
													TempAKA[STD.Str.Find(TempAKA, '|',3)+ 1..STD.Str.Find(TempAKA, '|',4) - 1],
													TempAKA[STD.Str.Find(TempAKA, '|',4)+ 1..STD.Str.Find(TempAKA, '|',5) - 1],
													TempAKA[STD.Str.Find(TempAKA, '|',5)+ 1..STD.Str.Find(TempAKA, '|',6) - 1],
													TempAKA[STD.Str.Find(TempAKA, '|',6)+ 1..STD.Str.Find(TempAKA, '|',7) - 1],
													TempAKA[STD.Str.Find(TempAKA, '|',7)+ 1..STD.Str.Find(TempAKA, '|',8) - 1],
													TempAKA[STD.Str.Find(TempAKA, '|',8)+ 1..STD.Str.Find(TempAKA, '|',9) - 1],
													TempAKA[STD.Str.Find(TempAKA, '|',9)+ 1..STD.Str.Find(TempAKA, '|',10) - 1],
													TempAKA[STD.Str.Find(TempAKA, '|',10)..-1]
										);
		self.orig_raw_name := REGEXREPLACE('\\|$',TRIM(L.orig_raw_name,left,right),'');
		self := L;
	END;

	nAKAnames	:= normalize(CountAKA,left.WordCount,ParseAKA(left,counter));

	//Transform into common layout
	GlobalWatchLists_Preprocess.rOutLayout xfrmPerson(nAKAnames L, integer C)	:= TRANSFORM
		self.pty_key				:= 'EUI'+L.Individual_ID;
		self.source					:= 'European Union Designated Terrorist Individuals';
		TempFullName				:= ut.CleanSpacesAndUpper(trim(L.LastName,left,right)+', '+trim(L.FirstName,left,right));
		self.orig_pty_name	:= CHOOSE(C,IF(TempFullName = 'JOMA, IN CHARGE OF THE COMMUNIST PARTY OF THE PHILIPPINES INCLUDING NPA','JOMA', TempFullName),
																		ut.CleanSpacesAndUpper(L.AKA));
		self.name_type			:= CHOOSE(C,'',IF(L.AKA <> '','AKA',''));
		self.remarks_1			:= IF(L.Date_of_Birth <> '','DATE OF BIRTH: '+trim(L.Date_of_birth,all),'');
		self.remarks_2			:= IF(L.Alt_DoB_1 <> '' and L.Alt_DoB_2 <> '','ALTERNATE DATE/S OF BIRTH: '+trim(L.Alt_DoB_1,all)+', '+trim(L.Alt_DoB_2,all),
														IF(L.Alt_DoB_1 <> '' and L.Alt_DoB_2 = '','ALTERNATE DATE/S OF BIRTH: '+trim(L.Alt_DoB_1,all), ''));
		self.remarks_3			:= IF(L.Born_In <> '', 'BORN IN: '+ut.CleanSpacesAndUpper(L.Born_In),'');
		self.remarks_4			:= IF(L.Citizenship <> '', 'CITIZENSHIP: '+ut.CleanSpacesAndUpper(L.Citizenship),'');
		self.remarks_5			:= IF(L.ETA_Membership <> '' , 'MEMBERSHIP: ETA '+ut.CleanSpacesAndUpper(L.ETA_Membership),
														IF(L.Other_Membership <> '', 'MEMBERSHIP: '+ut.CleanSpacesAndUpper(L.Other_Membership),''));
		self.remarks_6			:= IF(L.ID_Card <> '', 'IDENTITY CARD: '+ut.CleanSpacesAndUpper(L.ID_Card),'');
		self.remarks_7			:= IF(L.Passport <> '', 'PASSPORT: '+ut.CleanSpacesAndUpper(L.Passport),'');
		self.remarks_8			:= IF(L.Sflag <> '','SUBJECT OF ARTICLE 4 OF COMMON POSITION 2001/931/CFSP ONLY.','');
		self.remarks_9			:=  IF(REGEXFIND('Joma, in charge of the Communist Party of the Philippines including NPA',L.FullName),
															'COMMENT: '+ut.CleanSpacesAndUpper(L.FullName), '');
		self.cname_clean		:= '';
		self.pname_clean		:= IF(STD.Str.Find(self.orig_pty_name,',',1) > 0,
															Address.CleanPersonLFM73(self.orig_pty_name), Address.CleanPersonFML73(self.orig_pty_name));
		self.date_first_seen 	:= GlobalWatchLists_Preprocess.Versions.EUTerrorist_Version;
		self.date_last_seen 	:= GlobalWatchLists_Preprocess.Versions.EUTerrorist_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.EUTerrorist_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.EUTerrorist_Version;
		self.orig_entity_id 	:= STD.Str.Filter(L.Individual_ID,'1234567890');
		self.orig_first_name 	:= CHOOSE(C,ut.CleanSpacesAndUpper(L.LastName),self.pname_clean[6..25]);
		self.orig_last_name 	:= CHOOSE(C,ut.CleanSpacesAndUpper(L.FirstName),self.pname_clean[46..65]);
		self.orig_aka_type 		:= CHOOSE(C,'',IF(L.AKA <> '','AKA',''));
		self.orig_giv_designator := 'I';
		self.orig_remarks 		:= CHOOSE(C,IF(REGEXFIND('Joma, in charge of the Communist Party of the Philippines including NPA',L.FullName)
																		,ut.CleanSpacesAndUpper(L.FullName),'')
																	,'');
		self.orig_passport_details 	:= ut.CleanSpacesAndUpper(L.Passport);
		self.orig_ni_number_details := ut.CleanSpacesAndUpper(L.ID_Card);
		self.orig_id_type_1 	:= IF(L.Passport <> '', 'PASSPORT', IF(L.ID_Card <> '','ID CARD',''));
		self.orig_id_type_2 	:= IF(L.Passport <> '' AND L.ID_Card <> '','ID CARD', '');
		self.orig_id_number_1 := IF(L.Passport <> '', L.Passport, IF(L.ID_Card <> '',L.ID_Card,''));
		self.orig_id_number_2 := IF(L.Passport <> '' AND L.ID_Card <> '',L.ID_Card, '');
		self.orig_id_country_1 := ut.CleanSpacesAndUpper(IF(REGEXFIND('\\(',L.Passport),REGEXFIND('\\([A-Z]+\\)',L.Passport,1),
																								IF(REGEXFIND('\\(',L.ID_Card),REGEXFIND('\\([A-Z]+\\)',L.ID_Card,1),' ')));
		self.orig_id_country_2 := ut.CleanSpacesAndUpper(IF(L.Passport <> '' AND REGEXFIND('\\(',L.ID_Card),
																								REGEXFIND('\\([A-Z]+\\)',L.ID_Card,1),' '));
		self.orig_citizenship_1 := ut.CleanSpacesAndUpper(L.Citizenship);
		TempDOB									:= IF(STD.Str.Find(L.date_of_birth,'-',1) > 0, STD.Str.FindReplace(L.date_of_birth,'-','/'),L.date_of_birth);
		ClnDOB									:= IF(length(trim(L.date_of_birth,all)) = 4, L.date_of_birth, GlobalWatchLists_Preprocess.fSlashedDMYtoYMD(TempDOB));
		self.orig_dob_1 				:= IF(REGEXFIND('00000000',ClnDOB),'',REGEXREPLACE('^00',ClnDOB,'19'));
		TempAltDOB1							:= IF(STD.Str.Find(L.alt_dob_1,'-',1) > 0, STD.Str.FindReplace(L.alt_dob_1,'-','/'),L.alt_dob_1);
		ClnAltDOB1							:= IF(length(trim(L.alt_dob_1,all)) = 4, L.alt_dob_1, GlobalWatchLists_Preprocess.fSlashedDMYtoYMD(TempAltDOB1));
		self.orig_dob_2 				:= IF(REGEXFIND('00000000',ClnAltDOB1),'',REGEXREPLACE('^00',ClnAltDOB1,'19'));
		TempAltDOB2							:= IF(STD.Str.Find(L.alt_dob_2,'-',1) > 0, STD.Str.FindReplace(L.alt_dob_2,'-','/'),L.alt_dob_2);
		ClnAltDOB2							:= IF(length(trim(L.alt_dob_2,all)) = 4, L.alt_dob_2, GlobalWatchLists_Preprocess.fSlashedDMYtoYMD(TempAltDOB2));
		self.orig_dob_3 				:= IF(REGEXFIND('00000000',ClnAltDOB2),'',REGEXREPLACE('^00',ClnAltDOB2,'19'));
		self.orig_pob_1 				:= ut.CleanSpacesAndUpper(IF(STD.Str.Find(L.Born_in,';',1) > 0, REGEXFIND('(.*);(.*)',L.Born_in,1),L.Born_in));
		self.orig_pob_2					:= ut.CleanSpacesAndUpper(IF(STD.Str.Find(L.Born_in,';',1) > 0, REGEXFIND('(.*);(.*)',L.Born_in,2),''));
		self.orig_country_of_birth_1 := ut.CleanSpacesAndUpper(IF(REGEXFIND('\\(', L.Born_in), REGEXFIND('\\([A-Z]+\\)', L.Born_In, 1), ''));
		self.orig_primary_pob_flag_1 := If(L.Born_In <> '', 'Y','');
		self.orig_membership_1 := ut.CleanSpacesAndUpper(IF(L.ETA_Membership <> '' and STD.Str.Find(L.ETA_Membership, ' - Member of',1) = 0,'ETA '+L.ETA_Membership,
																								IF(STD.Str.Find(L.ETA_Membership, ' - Member of',1) > 0, REGEXREPLACE(' - Member of(.*)',L.ETA_Membership,''), 
																									IF(L.Other_Membership <> '', L.Other_Membership,''))));
		self.orig_membership_2 := ut.CleanSpacesAndUpper(IF(L.ETA_Membership <> '' and STD.Str.Find(L.ETA_Membership, ' - Member of',1) = 0, L.Other_Membership, 
																								IF(STD.Str.Find(L.ETA_Membership, ' - Member of',1) > 0, REGEXFIND(' - Member of(.*)',L.ETA_Membership,1),'')));
		self.orig_membership_3 := ut.CleanSpacesAndUpper(IF(STD.Str.Find(L.ETA_Membership, ' - Member of',1) > 0, L.Other_Membership,''));
		self.orig_subj_to_common_pos_2001_931_cfsp_flag := IF(STD.Str.Find(L.Sflag,'*',1) > 0,'Y','N');
		self.orig_raw_name := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.orig_raw_name,'|',';'));
		self := [];
	END;

	pEUPeopleCommon	:= normalize(nAKAnames,2,xfrmPerson(left,counter))(orig_pty_name <> '');
	dEUPeopleCommon	:= dedup(sort(pEUPeopleCommon,pty_key,orig_pty_name),record);

	//EU Terrorist Group File
	ds_group	:= GlobalWatchLists_Preprocess.Files.dsEUterroristListGroup;

	//Clean names
	GlobalWatchLists_Preprocess.Layouts.rEUterroristListGroup - Unparsed_Data ClnNames(ds_group L) := TRANSFORM
		self.GroupName := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.GroupName,'amnist a','amnistÃ­a'));
		self.Unparsed_Names := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.Unparsed_Names,'amnist a','amnistÃ­a'));
		self := L;
	END;

	ClnGroupRec	:= project(ds_group, ClnNames(left));

	//Normalize AKA names, parse Misc data
	lParseName	:= RECORD
		Recordof(ClnGroupRec);
		string AKA_Name;
		string	Miscellaneous;
		integer WordCount;
		string orig_raw_name;
	END;

	lParseName	GetCount(ClnGroupRec L) := TRANSFORM
		self.WordCount	:= STD.Str.FindCount(L.Unparsed_Names,'A.K.A.');
		self.Miscellaneous	:= IF(REGEXFIND('THE FOLL|LINKED TO |MINUS',L.Unparsed_Names),REGEXFIND('(THE FOLL|LINKED TO|MINUS)(.*)',L.Unparsed_Names,1),'');
		self.orig_raw_name := L.Unparsed_Names;
		self := L;
		self := [];
	END;

	CountGrpAKA	:= project(ClnGroupRec, GetCount(left));

	lParseName - WordCount ParseGrpAKA(CountGrpAKA L, integer C) := TRANSFORM
		self.Record_Num	:= IF(REGEXFIND('^[A-Z]',L.Record_Num),'',L.Record_Num);
		TempName			:= IF(L.WordCount > 1, REGEXREPLACE(' , \\(A.K.A',REGEXREPLACE(' \\)$',L.Unparsed_Names,','),'\\(A.K.A'),L.Unparsed_Names);
		ParseAKA			:= CHOOSE(C,IF(L.WordCount = 1,REGEXFIND('(A.K.A)(.*)',L.Unparsed_Names,0),
																IF(L.WordCount > 1,TempName[STD.Str.Find(TempName, 'A.K.A',1)..STD.Str.Find(TempName, ',',1) - 1],'')),
															TempName[STD.Str.Find(TempName, 'A.K.A',2)..STD.Str.Find(TempName, ',',2) - 1],
															TempName[STD.Str.Find(TempName, 'A.K.A',3)..STD.Str.Find(TempName, ',',3) - 1],
															TempName[STD.Str.Find(TempName, 'A.K.A',4)..STD.Str.Find(TempName, ',',4) - 1],
															TempName[STD.Str.Find(TempName, 'A.K.A',5)..STD.Str.Find(TempName, ',',5) - 1],
															TempName[STD.Str.Find(TempName, 'A.K.A',6)..STD.Str.Find(TempName, ',',6) - 1],
															TempName[STD.Str.Find(TempName, 'A.K.A',7)..STD.Str.Find(TempName, ',',7) - 1],
															TempName[STD.Str.Find(TempName, 'A.K.A',8)..STD.Str.Find(TempName, ',',8) - 1]);
		self.AKA_name	:= TRIM(STD.Str.FindReplace(STD.Str.FindReplace(REGEXREPLACE('\\*|A.K.A.|"|INCLUDING|;',ParseAKA,''),', IN', ' IS IN'),', AND ', ', '),left,right);
		self := L;
	END;

nGrpAKA	:= normalize(CountGrpAKA,If(left.WordCount = 0, 1,left.WordCount),ParseGrpAKA(left,counter));
																	
	//Transform into common layout
	GlobalWatchLists_Preprocess.rOutLayout xfrmGroup(nGrpAKA L, integer C)	:= TRANSFORM
		self.pty_key				:= 'EUG'+L.Record_Num;
		self.source					:= 'European Union Designated Terrorist Groups';
		tempPtyName					:= CHOOSE(C,L.GroupName, L.AKA_name);
		self.orig_pty_name	:= STD.Str.CleanSpaces(REGEXREPLACE('\\(|\\)|INCLUDING|^AND ',tempPtyName,''));
		self.name_type			:= CHOOSE(C,'PRIMARY','AKA');
		self.remarks_1			:= IF(L.Sflag <> '','SUBJECT OF ARTICLE 4 OF COMMON POSITION 2001/931/CFSP ONLY.','');
		self.remarks_2			:= IF(L.Miscellaneous <> '','COMMENT: '+STD.Str.FindReplace(L.Miscellaneous,'- ',''),'');
		self.cname_clean		:= self.orig_pty_name;
		self.pname_clean		:= '';
		self.date_first_seen 	:= GlobalWatchLists_Preprocess.Versions.EUTerrorist_Version;
		self.date_last_seen 	:= GlobalWatchLists_Preprocess.Versions.EUTerrorist_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.EUTerrorist_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.EUTerrorist_Version;
		self.orig_entity_id		:= STD.Str.Filter(L.Record_num,'1234567890');
		self.orig_aka_type		:= CHOOSE(C,'','AKA');
		self.orig_giv_designator := 'G';
		self.orig_remarks			:= STD.Str.FindReplace(L.Miscellaneous,'- ','');
		self.orig_subj_to_common_pos_2001_931_cfsp_flag := IF(STD.Str.Find(L.Sflag,'*',1) > 0,'Y','N');
		self.orig_raw_name := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.orig_raw_name,'|',';'));
		self := [];
	END;

	pEUGroupCommon	:= normalize(nGrpAKA,2,xfrmGroup(left,counter))(orig_pty_name <> '');
	dEUGroupCommon	:= dedup(sort(pEUGroupCommon,pty_key,orig_pty_name),all);

	//Combine both common files
	fEUTerroristAll	:= dEUPeopleCommon+dEUGroupCommon;

RETURN	fEUTerroristAll;

END;
