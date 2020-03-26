import GlobalWatchLists_Preprocess, STD, lib_StringLib, ut;

EXPORT ProcessDeniedEntity := FUNCTION
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedEntity.tempLayout ParseIndividualCitiations(GlobalWatchLists_Preprocess.Layouts.rDeniedEntity L) := TRANSFORM
		v_fed_cit_count := if(TRIM(L.Federal_Register_Citation, left, right) <> ''
															,length(STD.Str.Filter(L.Federal_Register_Citation, ';')) + 1
															,0);
		string10 padding := ';;;;;;;;;;';
		tmp_Federal_Register_Citation 				:= TRIM(TRIM(STD.Str.FindReplace(L.Federal_Register_Citation, '"', ''), left, right) + if(10 - v_fed_cit_count > 0, padding[1..10 - v_fed_cit_count], ''), left, right);
		
		self.Federal_Register_Citation_Parsed := tmp_Federal_Register_Citation;
		set of string words := STD.STr.SplitWords(tmp_Federal_Register_Citation, ';');
		self.Federal_Register_Citation_1			:= TRIM(words[1], left, right);
		self.Federal_Register_Citation_2			:= TRIM(words[2], left, right);
		self.Federal_Register_Citation_3			:= TRIM(words[3], left, right);
		self.Federal_Register_Citation_4			:= TRIM(words[4], left, right);
		self.Federal_Register_Citation_5			:= TRIM(words[5], left, right);
		self.Federal_Register_Citation_6			:= TRIM(words[6], left, right);
		self.Federal_Register_Citation_7			:= TRIM(words[7], left, right);
		self.Federal_Register_Citation_8			:= TRIM(words[8], left, right);
		self.Federal_Register_Citation_9			:= TRIM(words[9], left, right);
		self.Federal_Register_Citation_10			:= TRIM(words[10], left, right);
		self := L;
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedEntity.tempLayout1 RemoveDoubleQuoteANDaddEntKey(GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedEntity.tempLayout L, INTEGER Ctr) := TRANSFORM
		self.Ent_Key 										:= 'DEL' + INTFORMAT(Ctr, 4, 1);
		self.Country 										:= regexreplace('\"$', regexreplace('^\"', L.Country, ''), '');
		self.Entities 									:= regexreplace('\"$', regexreplace('^\"', L.Entities[1..350], ''), '');
		self.License_Requirement 				:= regexreplace('\"$', regexreplace('^\"', L.License_Requirement, ''), '');
		self.License_Review_Policy 			:= regexreplace('\"$', regexreplace('^\"', L.License_Review_Policy, ''), '');
		self.Federal_Register_Citation 	:= STD.Str.FindReplace(L.Federal_Register_Citation, '\"', '');
		self.num 												:= if(TRIM(L.Entities, left, right) <> ''
																				,length(STD.Str.Filter(L.Entities, '~'))+1
																				,0);
		self := L;
	END;
	
	DeniedEntity := PROJECT(PROJECT(GlobalWatchLists_Preprocess.Files.dsDeniedEntity, ParseIndividualCitiations(left)), RemoveDoubleQuoteANDaddEntKey(left, counter));
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedEntity.tempLayout2 NormEntity(GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedEntity.tempLayout1 L, INTEGER C) := TRANSFORM
		string150 new_orig_entities := STD.Str.SplitWords(L.Entities, '~')[C];
		self.Entity									:= new_orig_entities;
		self.orig_raw_name					:= if(STD.Str.Find(L.Entities, '>', 1)  <> 0,
																			trim(L.Entities[1..STD.Str.Find(L.Entities, '>', 1) - 1],left,right),
																			trim(L.Entities,left,right));
		self 												:= L;
	END;

	NormalizedEntity := NORMALIZE(DeniedEntity, LEFT.num, NormEntity(LEFT,COUNTER));	
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedEntity.tempLayout3 SeparateBusinesses(GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedEntity.tempLayout2 L) := TRANSFORM
		self.Entity  		:= if(STD.Str.Find(L.Entity, '>', 1)  <> 0
											,TRIM(REGEXREPLACE('^(aka |a.k.a.|a.k.a|f.k.a.)',trim(L.Entity[1..STD.Str.Find(L.Entity, '>', 1) - 1],left,right),'',NOCASE), left, right)
											,TRIM(REGEXREPLACE('^(aka |a.k.a.|a.k.a|f.k.a.)',trim(L.Entity,left,right), '',NOCASE)));
		self.name_type 	:= if(REGEXFIND('(aka |a.k.a.|a.k.a|f.k.a.)',trim(L.Entity,left,right), NOCASE)
										 	,'AKA'
											,'');
		self.Address 		:= if(STD.Str.Find(L.Entity, '>', 1) <> 0
											,TRIM(
													 STD.Str.FindReplace(
														STD.Str.FindReplace(
														 STD.Str.FindReplace(
															STD.Str.FindReplace(
															 STD.Str.FindReplace(L.Entity[STD.Str.Find(L.Entity, '>', 1)+1..length(L.Entity)],
																							'Avenue', 'Ave'),
																							', ', ','),
																							'P.O.', 'PO'),
																							'; and ', ';'),
																							'; ', ';')
														,left, right)[1..150]
											,'');

		self.orig_raw_name	:= ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.orig_raw_name,'~','; ')); //Replace AKA seperator to try and standardize in all sources
		self 						:= L;
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedEntity.tempLayout4 CleanEntitytextANDaddComment(GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedEntity.tempLayout3 L) := TRANSFORM
		temp_comment 	:= if('' = L.Ent_Key
											,if(STD.Str.Find(L.Entity, '^The following |^the following ', 1) <> 0
												,TRIM(regexreplace('^The following |the following ', L.Entity, ''), left, right)
												,'')
											,if(STD.Str.Find(L.Entity, '^The following ', 1) <> 0
												,TRIM(regexreplace('^The following ', L.Entity, ''), left, right)
												,''));

		self.Entity 	:= STD.Str.FindReplace(STD.Str.ToUpperCase(regexreplace('^The following subordinates of |^The following |^the following subordinate entities|^and ', L.Entity, '')[1])
                            + regexreplace('^The following subordinates of |^The following |^the following subordinate entities|^and ', L.Entity, '')[2..151]
											, ' )', ')');
		self.Comments := STD.Str.ToUpperCase(STD.Str.FindReplace(STD.Str.FindReplace(temp_comment, 'entities', 'entity'), 'subordinates', 'subordinate')[1])
              + STD.Str.FindReplace(STD.Str.FindReplace(temp_comment, 'entities', 'entity'), 'subordinates', 'subordinate')[2.. length(STD.Str.FindReplace(STD.Str.FindReplace(temp_comment, 'entities', 'entity'), 'subordinates', 'subordinate'))-1 + 2 - 1];
		self := L;
	END;
	
	tCleanNameAddr	:= PROJECT(PROJECT(NormalizedEntity, SeparateBusinesses(left))(TRIM(Entity, left, right) <> ''), CleanEntitytextANDaddComment(left));
	
		fmtsin := [
		// '%m/%d/%Y',
		'%m/%d/%y'
	];
	fmtout := '%Y%m%d';
	
	GlobalWatchLists_Preprocess.rOutLayout ReformatToCommonlayout(GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedEntity.tempLayout4 L, integer C) := TRANSFORM
		//let integer(2) tmp_federal_register_citations =string_length(string_filter(L.Federal_Register_Citation,";"))+1;

		self.pty_key 						:= L.Ent_Key;
		self.source 						:= 'US Bureau of Industry and Security - Denied Entity List';
		clnName									:= REGEXREPLACE('A.K.A.|A.K.A|F.K.A.',ut.CleanSpacesAndUpper(REGEXREPLACE('^,|^-|^\\((A.K.A|F.K.A)',TRIM(L.Entity,left,right),'',NOCASE)),'AKA');
		RmvAKA									:= IF(REGEXFIND('\\(AKA [A-Z]+\\)',clnName),REGEXREPLACE('\\)$',REGEXREPLACE('\\(AKA [A-Z]+\\)',clnName,''),''),
																	IF(REGEXFIND('AKA(.*)$',clnName),REGEXREPLACE('AKA(.*)$',clnName,''),clnName));
		AKAName									:= IF(REGEXFIND('\\(AKA [A-Z]+\\)',clnName),clnName[STD.Str.Find(clnName,'AKA',1)+3..STD.Str.Find(clnName,')',1)-1],
																	IF(REGEXFIND('AKA(.*)$',clnName),clnName[STD.Str.Find(clnName,'AKA',1)+3..],''));
		self.orig_pty_name 			:= STD.Str.CleanSpaces(REGEXREPLACE('^,|;$|,$| \\($',CHOOSE(C,RmvAKA,AKAName),''));
		self.orig_vessel_name 	:= '';
		self.country 						:= ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.Country,'Syr Ia','Syria'));
		self.name_type 					:= choose(C,L.name_type,'AKA');
		integer WordCount				:= STD.Str.FindCount(L.Address, '>');
		self.addr_1 						:= ut.CleanSpacesAndUpper(IF(WordCount >= 1,L.Address[1..STD.Str.Find(L.Address, '>', 1)-1],L.Address));
		self.addr_2							:= ut.CleanSpacesAndUpper(IF(WordCount = 1,L.Address[STD.Str.Find(L.Address, '>', 1)+1..length(L.Address)],
																									IF(WordCount > 1,L.Address[STD.Str.Find(L.Address, '>', 1)+1..STD.Str.Find(L.Address, '>', 2)-1],'')));
		self.addr_3							:= ut.CleanSpacesAndUpper(IF(WordCount >= 2,L.Address[STD.Str.Find(L.Address, '>', 2)+1..length(L.Address)],''));
		self.remarks_1 					:= if(TRIM(L.Country, left, right) <> ''
																,'COUNTRY: ' + self.country
																,'');
		self.remarks_2 					:= if(TRIM(L.License_Requirement, left, right) <> ''
																,'LICENCE REQUIREMENT: ' + ut.CleanSpacesAndUpper(L.License_Requirement)
																,'');
		self.remarks_3 					:= if(TRIM(L.License_Review_Policy, left, right) <> ''
																,'LICENSE REVIEW POLICY: ' + ut.CleanSpacesAndUpper(L.License_Review_Policy)
																,'');
		self.remarks_4 					:= if(TRIM(L.Federal_Register_Citation, left, right) <> ''
																,'FEDERAL REGISTER CITATION: ' + ut.CleanSpacesAndUpper(L.Federal_Register_Citation)
																,'');
		self.remarks_5 					:= if(TRIM(L.Comments, left, right) <> ''
																,'SUBORDINATE STATUS: ' + ut.CleanSpacesAndUpper(L.Comments)
																,'');
		self.cname_clean 				:= self.orig_pty_name;
		self.pname_clean 				:= '';
		self.addr_clean 				:= '';
		self.date_first_seen 		:= GlobalWatchlists_Preprocess.Versions.DeniedEntity_Version;
		self.date_last_seen 		:= GlobalWatchlists_Preprocess.Versions.DeniedEntity_Version;
		self.date_vendor_first_reported := GlobalWatchlists_Preprocess.Versions.DeniedEntity_Version;
		self.date_vendor_last_reported 	:= GlobalWatchlists_Preprocess.Versions.DeniedEntity_Version;
		self.orig_aka_id			 		:= '';
		self.orig_aka_type 				:= ut.CleanSpacesAndUpper(L.name_type);
		self.orig_aka_category 		:= '';
		self.orig_giv_designator 	:= 'G';
		self.orig_address_id 			:= '';
		self.orig_address_line_1 	:= self.addr_1;
		self.orig_address_line_2 	:= self.addr_2;
		self.orig_address_line_3 	:= self.addr_3;
		self.orig_federal_register_citation_1 := ut.CleanSpacesAndUpper(L.Federal_Register_Citation_1
																[1..STD.Str.Find(L.Federal_Register_Citation_1, '/', 1)-3]);
		self.orig_federal_register_citation_2 := ut.CleanSpacesAndUpper(L.Federal_Register_Citation_2
																[1..STD.Str.Find(L.Federal_Register_Citation_2, '/', 1)-3]);
		self.orig_federal_register_citation_3 := ut.CleanSpacesAndUpper(L.Federal_Register_Citation_3
																[1..STD.Str.Find(L.Federal_Register_Citation_3, '/', 1)-3]);
		self.orig_federal_register_citation_4 := ut.CleanSpacesAndUpper(L.Federal_Register_Citation_4
																[1..STD.Str.Find(L.Federal_Register_Citation_4, '/', 1)-3]);
		self.orig_federal_register_citation_5 :=ut.CleanSpacesAndUpper(L.Federal_Register_Citation_5
																[1..STD.Str.Find(L.Federal_Register_Citation_5, '/', 1)-3]);
		self.orig_federal_register_citation_6 := ut.CleanSpacesAndUpper(L.Federal_Register_Citation_6
																[1..STD.Str.Find(L.Federal_Register_Citation_6, '/', 1)-3]);
		self.orig_federal_register_citation_7 := ut.CleanSpacesAndUpper(L.Federal_Register_Citation_7
																[1..STD.Str.Find(L.Federal_Register_Citation_7, '/', 1)-3]);
		self.orig_federal_register_citation_8 := ut.CleanSpacesAndUpper(L.Federal_Register_Citation_8
																[1..STD.Str.Find(L.Federal_Register_Citation_8, '/', 1)-3]);
		self.orig_federal_register_citation_9 := ut.CleanSpacesAndUpper(L.Federal_Register_Citation_9
																[1..STD.Str.Find(L.Federal_Register_Citation_9, '/', 1)-3]);
		self.orig_federal_register_citation_10 := ut.CleanSpacesAndUpper(L.Federal_Register_Citation_10
																[1..STD.Str.Find(L.Federal_Register_Citation_10, '/', 1)-3]);
		TempCitationDate1						:= REGEXREPLACE('\\.',TRIM(L.Federal_Register_Citation_1
																[STD.Str.Find(L.Federal_Register_Citation_1, '/', 1)-2..20 + STD.Str.Find(L.Federal_Register_Citation_1, '/', 1)-2-1],left,right),'');
		self.orig_federal_register_citation_date_1 := IF(length(trim(TempCitationDate1)) = 4, TempCitationDate1,
																										IF(trim(TempCitationDate1,left,right) <> '', GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(TempCitationDate1),''));
		TempCitationDate2						:= REGEXREPLACE('\\.',TRIM(L.Federal_Register_Citation_2
																[STD.Str.Find(L.Federal_Register_Citation_2, '/', 1)-2..20 + STD.Str.Find(L.Federal_Register_Citation_2, '/', 1)-2-1],left,right),'');
		self.orig_federal_register_citation_date_2 := IF(length(trim(TempCitationDate2)) = 4, TempCitationDate2,
																										IF(trim(TempCitationDate2,left,right) <> '', GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(TempCitationDate2),''));
		TempCitationDate3						:= REGEXREPLACE('\\.',TRIM(L.Federal_Register_Citation_3
																[STD.Str.Find(L.Federal_Register_Citation_3, '/', 1)-2..20 + STD.Str.Find(L.Federal_Register_Citation_3, '/', 1)-2-1],left,right),'');
		self.orig_federal_register_citation_date_3 := IF(length(trim(TempCitationDate3)) = 4, TempCitationDate3,
																										IF(trim(TempCitationDate3,left,right) <> '', GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(TempCitationDate3),''));
		TempCitationDate4						:= REGEXREPLACE('\\.',TRIM(L.Federal_Register_Citation_4
																[STD.Str.Find(L.Federal_Register_Citation_4, '/', 1)-2..20 + STD.Str.Find(L.Federal_Register_Citation_4, '/', 1)-2-1],left,right),'');
		self.orig_federal_register_citation_date_4 := IF(length(trim(TempCitationDate4)) = 4, TempCitationDate4,
																										IF(trim(TempCitationDate4,left,right) <> '', GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(TempCitationDate4),''));
		TempCitationDate5						:= REGEXREPLACE('\\.',TRIM(L.Federal_Register_Citation_5
																[STD.Str.Find(L.Federal_Register_Citation_5, '/', 1)-2..20 + STD.Str.Find(L.Federal_Register_Citation_5, '/', 1)-2-1],left,right),'');
		self.orig_federal_register_citation_date_5 := IF(length(trim(TempCitationDate5)) = 4, TempCitationDate5,
																										IF(trim(TempCitationDate5,left,right) <> '', GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(TempCitationDate5),''));
		TempCitationDate6						:= REGEXREPLACE('\\.',TRIM(L.Federal_Register_Citation_6
																[STD.Str.Find(L.Federal_Register_Citation_6, '/', 1)-2..20 + STD.Str.Find(L.Federal_Register_Citation_6, '/', 1)-2-1],left,right),'');
		self.orig_federal_register_citation_date_6 := IF(length(trim(TempCitationDate6)) = 4, TempCitationDate6,
																										IF(trim(TempCitationDate6,left,right) <> '', GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(TempCitationDate6),''));
		TempCitationDate7						:= REGEXREPLACE('\\.',TRIM(L.Federal_Register_Citation_7
																[STD.Str.Find(L.Federal_Register_Citation_7, '/', 1)-2..20 + STD.Str.Find(L.Federal_Register_Citation_7, '/', 1)-2-1],left,right),'');
		self.orig_federal_register_citation_date_7 := IF(length(trim(TempCitationDate7)) = 4, TempCitationDate7,
																										IF(trim(TempCitationDate7,left,right) <> '', GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(TempCitationDate7),'')); 
		TempCitationDate8						:= REGEXREPLACE('\\.',TRIM(L.Federal_Register_Citation_8
																[STD.Str.Find(L.Federal_Register_Citation_8, '/', 1)-2..20 + STD.Str.Find(L.Federal_Register_Citation_8, '/', 1)-2-1],left,right),'');
		self.orig_federal_register_citation_date_8 := IF(length(trim(TempCitationDate8)) = 4, TempCitationDate8,
																										IF(trim(TempCitationDate8,left,right) <> '', GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(TempCitationDate8),''));
		TempCitationDate9						:= REGEXREPLACE('\\.',TRIM(L.Federal_Register_Citation_9
																[STD.Str.Find(L.Federal_Register_Citation_9, '/', 1)-2..20 + STD.Str.Find(L.Federal_Register_Citation_9, '/', 1)-2-1],left,right),'');
		self.orig_federal_register_citation_date_9 := IF(length(trim(TempCitationDate9)) = 4, TempCitationDate9,
																										IF(trim(TempCitationDate9,left,right) <> '', GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(TempCitationDate9),''));
		TempCitationDate10					:= REGEXREPLACE('\\.',TRIM(L.Federal_Register_Citation_10
																[STD.Str.Find(L.Federal_Register_Citation_10, '/', 1)-2..20 + STD.Str.Find(L.Federal_Register_Citation_10, '/', 1)-2-1],left,right),'');
		self.orig_federal_register_citation_date_10 := IF(length(trim(TempCitationDate10)) = 4, TempCitationDate10,
																										IF(trim(TempCitationDate10,left,right) <> '', GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(TempCitationDate10),''));
		self.license_requirement 										:= ut.CleanSpacesAndUpper(L.License_Requirement);
		self.license_review_policy 									:= ut.CleanSpacesAndUpper(L.License_Review_Policy);
		self.orig_subordinate_status 								:= if(TRIM(L.Comments, left, right) <> '', ut.CleanSpacesAndUpper(L.Comments[1..100]), '');
		self.orig_raw_name		:= L.orig_raw_name;
	END;
	
	final_out := NORMALIZE(tCleanNameAddr, 2, ReformatToCommonlayout(left,counter));
	
	return final_out(orig_pty_name <> '');
	
END;