import std, address, bo_address, ut;

EXPORT ProcessUnverified := FUNCTION

	//Add key sequence and parse citation and citation_date
	l_AddSeq	:= RECORD
		string6 	ent_key;
		GlobalWatchLists_Preprocess.Layouts.rUnverified;
	END;
	
	l_AddSeq AssignSeq(GlobalWatchLists_Preprocess.Layouts.rUnverified L, INTEGER Ctr) := TRANSFORM
		self.ent_key	:= 'UVE' + INTFORMAT(Ctr, 3, 1);
		self := L;
		self := [];
	END;
	
	AddSeq	:= project(GlobalWatchLists_Preprocess.Files.dsUnverified, AssignSeq(left,counter));
	
	PATTERN ws				:=	PATTERN('[ ;,.]');
	PATTERN Alpha			:=	PATTERN('[A-Za-z]');
	PATTERN Word			:=	Alpha+;
	PATTERN Number		:=	PATTERN('[0-9]');
	PATTERN Numbers 	:=	Number+;
	PATTERN Comma			:=	[','];
	PATTERN Slash			:=	['/'];
	PATTERN	Month			:=	['JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER'];
	PATTERN	FR				:=	['FR'];
	PATTERN	Citation	:=	Number Number ws FR ws Numbers;
	PATTERN	Date1			:=	Month ws Numbers Comma ws Numbers;
	PATTERN Date2			:=	Numbers Slash Numbers Slash Numbers;
	PATTERN Dates			:=	(Date1|Date2);
	RULE		CitationDate	:=	Citation ws+ Dates ws*;

	l_parse	:=	RECORD
		AddSeq;
		STRING	citation	:=	MATCHTEXT(Citation);
		STRING	pub_date	:=	MATCHTEXT(Dates);
	END;

	pCitation := PARSE(AddSeq, federal_citation_pub_date, CitationDate, l_parse, BEST, MANY, NOCASE);
	
	//Denormalize to get multiple citations/pub_dates on a single record
	tempRec	:= RECORD
		l_AddSeq;
		string35 	Federal_Citation_1;
		string35 	Federal_Citation_2;
		string35 	Federal_Citation_3;
		string35 	Federal_Citation_4;
		string20	publication_date1; //Month Day, YYYY
		string20	publication_date2;
		string20	publication_date3;
		string20	publication_date4;
	END;
	
	pNormBase	:= project(pCitation, transform(tempRec, self := left; self := []));
	
	tempRec DeNormRec(pNormBase L, pCitation R, integer C) := TRANSFORM
		self.federal_citation_1	:= IF(C = 1,R.citation,L.federal_citation_1);
		self.publication_date1	:= IF(C = 1,R.pub_date,L.publication_date1);
		self.federal_citation_2	:= IF(C = 2,R.citation,L.federal_citation_2);
		self.publication_date2	:= IF(C = 2,R.pub_date,L.publication_date2);
		self.federal_citation_3	:= IF(C = 3,R.citation,L.federal_citation_3);
		self.publication_date3	:= IF(C = 3,R.pub_date,L.publication_date3);
		self.federal_citation_4	:= IF(C = 4,R.citation,L.federal_citation_4);
		self.publication_date4	:= IF(C = 4,R.pub_date,L.publication_date4);
		self := L;
	END;
	
	deNormPubDate	:= DEDUP(DENORMALIZE(pNormBase, pCitation,
																		LEFT.ent_key = RIGHT.ent_key and
																		LEFT.federal_citation_pub_date = RIGHT.federal_citation_pub_date,
																		DeNormRec(LEFT,RIGHT,COUNTER)),ALL);
																		
	FixMonth(string date)	:= FUNCTION
	  TempDate				:= REGEXREPLACE('(-)+$',STD.Str.FindReplace(STD.Str.FindReplace(date,',',''),' ','-'),'');
		string newMonth	:= MAP(REGEXFIND('January',TempDate,NOCASE) => REGEXREPLACE('January',TempDate,'01',NOCASE),
																	REGEXFIND('February',TempDate,NOCASE) => REGEXREPLACE('February',TempDate,'02',NOCASE),
																	REGEXFIND('March',TempDate,NOCASE) => REGEXREPLACE('March',TempDate,'03',NOCASE),
																	REGEXFIND('April',TempDate,NOCASE) => REGEXREPLACE('April',TempDate,'04',NOCASE),
																	REGEXFIND('May',TempDate,NOCASE) => REGEXREPLACE('May',TempDate,'05',NOCASE),
																	REGEXFIND('June',TempDate,NOCASE) => REGEXREPLACE('June',TempDate,'06',NOCASE),
																	REGEXFIND('July',TempDate,NOCASE) => REGEXREPLACE('July',TempDate,'07',NOCASE),
																	REGEXFIND('August',TempDate,NOCASE) => REGEXREPLACE('August',TempDate,'08',NOCASE),
																	REGEXFIND('September',TempDate,NOCASE) => REGEXREPLACE('September',TempDate,'09',NOCASE),
																	REGEXFIND('October',TempDate,NOCASE) => REGEXREPLACE('October',TempDate,'10',NOCASE),
																	REGEXFIND('November',TempDate,NOCASE) => REGEXREPLACE('November',TempDate,'11',NOCASE),
																	REGEXFIND('December',TempDate,NOCASE) => REGEXREPLACE('December',TempDate,'12',NOCASE),
																	TempDate);
		RETURN newMonth;
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutUnverified.BaseLayout AssginValues(tempRec L) := TRANSFORM
		self.ent_key 			:= L.ent_key;
		self.source 			:= 'US Bureau of Industry and Security Unverified Entity List';
		self.lst_vend_upd := GlobalWatchLists_Preprocess.Versions.Unverified_Version;
		
		ClnEntity					:= IF(STD.Str.Find(L.lstd_entity_address, ', Inc.',1) > 0
													,STD.Str.FindReplace(L.lstd_entity_address, ', Inc.',' Inc.')
													,IF(STD.Str.Find(L.lstd_entity_address, ', Ltd.',1) > 0
														,STD.Str.FindReplace(L.lstd_entity_address, ', Ltd.',' Ltd.'),L.lstd_entity_address));
		integer TempCount	:= STD.Str.CountWords(ClnEntity,'a.k.a. ');
		self.lstd_entity 	:= ut.CleanSpacesAndUpper(ClnEntity[1..STD.Str.Find(ClnEntity,',',1) - 1]);
		self.lstd_aka1	 	:= IF(TempCount > 1,ut.CleanSpacesAndUpper(ClnEntity[STD.Str.Find(ClnEntity,'a.k.a. ',1)..STD.Str.Find(ClnEntity,',',2)-1]),'');
		self.lstd_aka2	 	:= IF(TempCount > 2,ut.CleanSpacesAndUpper(ClnEntity[STD.Str.Find(ClnEntity,'a.k.a. ',2)..STD.Str.Find(ClnEntity,',',3)-1]),'');
		self.lstd_aka3	 	:= IF(TempCount > 3,ut.CleanSpacesAndUpper(ClnEntity[STD.Str.Find(ClnEntity,'a.k.a. ',3)..STD.Str.Find(ClnEntity,',',4)-1]),'');
		self.lstd_aka4	 	:= IF(TempCount > 4,ut.CleanSpacesAndUpper(ClnEntity[STD.Str.Find(ClnEntity,'a.k.a. ',4)..STD.Str.Find(ClnEntity,',',5)-1]),'');
		self.country 			:= ut.CleanSpacesAndUpper(L.country);
		TempAddr1						:= IF(STD.Str.FindCount(ClnEntity,';') > 0 and TempCount > 1
														 ,ClnEntity[STD.Str.Find(ClnEntity,',',TempCount)+1..STD.Str.Find(ClnEntity,';',1) - 1]
														,IF(STD.Str.FindCount(ClnEntity,';') > 0 and TempCount = 1
															,ClnEntity[STD.Str.Find(ClnEntity,',',1)+1..STD.Str.Find(ClnEntity,';',1) - 1]
															,ClnEntity[STD.Str.Find(ClnEntity,',',1)+1..]));
		self.full_address1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND(trim(self.lstd_aka1),TempAddr1,NOCASE),REGEXREPLACE(trim(self.lstd_aka1),TempAddr1,'',NOCASE),TempAddr1));
		TempAddr2						:= IF(STD.Str.FindCount(ClnEntity,';') > 1 
														 ,ClnEntity[STD.Str.Find(ClnEntity,';',1)+1..STD.Str.Find(ClnEntity,';',2)-1]
														 ,IF(STD.Str.FindCount(ClnEntity,';') = 1
															,ClnEntity[STD.Str.Find(ClnEntity,';',1)+1..],''));
		self.full_address2	:= ut.CleanSpacesAndUpper(REGEXREPLACE('and |and, ',TempAddr2,'',NOCASE));
		TempAddr3						:= IF(STD.Str.FindCount(ClnEntity,';') > 2 
														 ,ClnEntity[STD.Str.Find(ClnEntity,';',2)+1..STD.Str.Find(ClnEntity,';',3)-1]
														 ,IF(STD.Str.FindCount(ClnEntity,';') = 2
															,ClnEntity[STD.Str.Find(ClnEntity,';',2)+1..],''));
		self.full_address3	:= ut.CleanSpacesAndUpper(REGEXREPLACE('and |and, ',TempAddr3,'',NOCASE));
		TempAddr4						:= IF(STD.Str.FindCount(ClnEntity,';') > 3 
														 ,ClnEntity[STD.Str.Find(ClnEntity,';',3)+1..STD.Str.Find(ClnEntity,';',4)-1]
														 ,IF(STD.Str.FindCount(ClnEntity,';') = 3
															,ClnEntity[STD.Str.Find(ClnEntity,';',3)+1..],''));
		self.full_address4	:= ut.CleanSpacesAndUpper(REGEXREPLACE('and |and, ',TempAddr4,'',NOCASE));
		TempAddr5						:= IF(STD.Str.FindCount(ClnEntity,';') > 4 
														 ,ClnEntity[STD.Str.Find(ClnEntity,';',4)+1..STD.Str.Find(ClnEntity,';',5)-1]
														 ,IF(STD.Str.FindCount(ClnEntity,';') = 4
															,ClnEntity[STD.Str.Find(ClnEntity,';',4)+1..],''));
		self.full_address5	:= ut.CleanSpacesAndUpper(REGEXREPLACE('and |and, ',TempAddr5,'',NOCASE));
		self.federal_citation_1	:= ut.CleanSpacesAndUpper(L.federal_citation_1); 
		self.federal_citation_2	:= ut.CleanSpacesAndUpper(L.federal_citation_2);
		self.federal_citation_3	:= ut.CleanSpacesAndUpper(L.federal_citation_3);
		self.federal_citation_4	:= ut.CleanSpacesAndUpper(L.federal_citation_4);
		TempDate1								:= FixMonth(L.publication_date1);
		self.publication_date1	:= ut.ConvertDate(TempDate1, '%m-%d-%Y', '%Y%m%d');
		TempDate2								:= FixMonth(L.publication_date2);
		self.publication_date2	:= ut.ConvertDate(TempDate2, '%m-%d-%Y', '%Y%m%d');
		TempDate3								:= FixMonth(L.publication_date3);
		self.publication_date3	:= ut.ConvertDate(TempDate3, '%m-%d-%Y', '%Y%m%d');
		TempDate4								:= FixMonth(L.publication_date4);
		self.publication_date4	:= ut.ConvertDate(TempDate4, '%m-%d-%Y', '%Y%m%d');
		self.orig_raw_name			:= ut.CleanSpacesAndUpper(ClnEntity[1..STD.Str.Find(ClnEntity,',',1) - 1]);
		self := [];
	end;

	pUnverified	:= PROJECT(deNormPubDate, AssginValues(left));

	//Normalize Address
	GlobalWatchLists_Preprocess.IntermediaryLayoutUnverified.Base_norm NormAddr(GlobalWatchLists_Preprocess.IntermediaryLayoutUnverified.BaseLayout L, INTEGER C) := TRANSFORM
		self.full_address := CHOOSE(C, L.full_address1, L.full_address2, L.full_address3, L.full_address4);
		self := L;
	END;
	
	nBaseAddr := NORMALIZE(pUnverified,IF(left.full_address4 <> '',4,
																			IF(left.full_address3 <> '',3,
																				IF(left.full_address2 <> '',2,1))), NormAddr(left,counter));
	

		GlobalWatchLists_Preprocess.rOutLayout us_bis_uv(GlobalWatchLists_Preprocess.IntermediaryLayoutUnverified.Base_norm L, INTEGER C) := TRANSFORM
		addr_clean := bo_address.CleanAddress182(' ', L.full_address + ' ' + ' ' + ' ' + ' ');
		self.pty_key 					:= L.ent_key;
		self.orig_pty_name 		:= trim(REGEXREPLACE('(A.K.A.)',CHOOSE(C,L.lstd_entity,L.lstd_aka1,L.lstd_aka2,L.lstd_aka3,L.lstd_aka4),''),left,right);
		self.source 					:= L.source;
		self.orig_vessel_name := '';
		self.name_type 				:= CHOOSE(C,'','AKA','AKA','AKA','AKA');
		self.cname_clean 			:= trim(REGEXREPLACE('(A.K.A.)',CHOOSE(C,L.lstd_entity,L.lstd_aka1,L.lstd_aka2,L.lstd_aka3,L.lstd_aka4),''),left,right);
		self.pname_clean 			:= '';
		self.addr_1 					:= trim(REGEXREPLACE('^,',L.full_address,''),left,right);
		self.country 					:= L.country;
		self.addr_2 					:= '';
		self.addr_clean 			:= if(addr_clean[179..180] <> 'E5' 
																and addr_clean[179..182] <> 'E213'
																and addr_clean[179..182] <> 'E101'
															,addr_clean
															,'');
		self.date_first_seen 	:= L.lst_vend_upd;
		self.date_last_seen 	:= L.lst_vend_upd;
		self.date_vendor_first_reported := L.lst_vend_upd;
		self.date_vendor_last_reported 	:= L.lst_vend_upd;
		self.orig_aka_id 								:= '';
		self.orig_aka_type 							:= CHOOSE(C,'','AKA','AKA','AKA','AKA');
		self.orig_aka_category 					:= '';
		self.orig_giv_designator 				:= 'G';
		self.orig_address_id 						:= '';
		self.orig_address_line_1 				:= TRIM(L.full_address, left, right);
		self.orig_address_country 			:= L.country;
		self.orig_federal_register_citation_1 := L.federal_citation_1;
		self.orig_federal_register_citation_2 := L.federal_citation_2;
		self.orig_federal_register_citation_3 := L.federal_citation_3;
		self.orig_federal_register_citation_4 := L.federal_citation_4;
		self.orig_federal_register_citation_date_1 := L.publication_date1;
		self.orig_federal_register_citation_date_2 := L.publication_date2;
		self.orig_federal_register_citation_date_3 := L.publication_date3;
		self.orig_federal_register_citation_date_4 := L.publication_date4;
		self.orig_raw_name			:= L.orig_raw_name;
	END;
	
	ds_UnverifiedCommon	:= NORMALIZE(nBaseAddr,4, us_bis_uv(left,counter));
	
	return ds_UnverifiedCommon(orig_pty_name <> '');
END;