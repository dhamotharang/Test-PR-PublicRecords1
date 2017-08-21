IMPORT GlobalWatchLists_Preprocess, STD, lib_StringLib, ut;

EXPORT ProcessStateDeptTerroristExclusion := FUNCTION

	HdrData	:= '(^Loading |^Orignal |^Number |^Author |^Writing |^Minrow=0 |Extract Date)(.*)';
	ds_StateDeptTerrorist	:= GlobalWatchLists_Preprocess.Files.dsStDeptTerroristExcl(~REGEXFIND(HdrData,Organization) and trim(Organization,all) <> '');

	//Add sequence
	l_WithSeq	:= RECORD
		string	sequence_num;
		recordof(ds_StateDeptTerrorist);
	END;

	l_WithSeq AddSeq(ds_StateDeptTerrorist L, integer Ctr) := TRANSFORM
		self.sequence_num	:= INTFORMAT(Ctr, 3, 1);
		self := L;
	END;
	
	pAddSeqNum	:= project(ds_StateDeptTerrorist, AddSeq(left,counter));

	//Normalize AKA names
	lParseName	:= RECORD
		Recordof(pAddSeqNum);
		integer WordCount;
		string orig_raw_name;
	END;

	lParseName	GetCount(pAddSeqNum L) := TRANSFORM
		self.AKA				:= STD.Str.FindReplace(IF(REGEXFIND('a.k.a. (.*), |f.k.a. (.*), ',L.AKA), REGEXREPLACE(', a.k.|,a.k.',L.AKA,'; a.k.'),L.AKA),'"','');
		self.WordCount	:= IF(L.AKA <> '',STD.Str.FindCount(self.AKA,';')+1,0);
		self.orig_raw_name	:= STD.Str.FindReplace(REGEXREPLACE(';$',ut.CleanSpacesAndUpper(trim(L.organization,left,right)+'; '+self.AKA),''),'"','');
		self := L;
		self := [];
	END;

	CountGrpAKA	:= project(pAddSeqNum, GetCount(left));

	lParseName - WordCount ParseGrpAKA(CountGrpAKA L, integer C) := TRANSFORM
			TempName	:= ut.CleanSpacesAndUpper(IF(L.WordCount > 1, REGEXREPLACE('$',L.AKA,';'),L.AKA));
			ParseAKA	:= CHOOSE(C,IF(L.WordCount <= 1,TempName,
															IF(L.WordCount > 1,TempName[1..STD.Str.Find(TempName, ';',1) - 1],'')),
														TempName[STD.Str.Find(TempName, ';',1)..STD.Str.Find(TempName, ';',2) - 1],
														TempName[STD.Str.Find(TempName, ';',2)..STD.Str.Find(TempName, ';',3) - 1],
														TempName[STD.Str.Find(TempName, ';',3)..STD.Str.Find(TempName, ';',4) - 1],
														TempName[STD.Str.Find(TempName, ';',4)..STD.Str.Find(TempName, ';',5) - 1],
														TempName[STD.Str.Find(TempName, ';',5)..STD.Str.Find(TempName, ';',6) - 1],
														TempName[STD.Str.Find(TempName, ';',6)..STD.Str.Find(TempName, ';',7) - 1],
														TempName[STD.Str.Find(TempName, ';',7)..STD.Str.Find(TempName, ';',8) - 1],
														TempName[STD.Str.Find(TempName, ';',8)..STD.Str.Find(TempName, ';',9) - 1],
														TempName[STD.Str.Find(TempName, ';',9)..STD.Str.Find(TempName, ';',10) - 1],
														TempName[STD.Str.Find(TempName, ';',10)..STD.Str.Find(TempName, ';',11) - 1],
														TempName[STD.Str.Find(TempName, ';',11)..STD.Str.Find(TempName, ';',12) - 1],
														TempName[STD.Str.Find(TempName, ';',12)..STD.Str.Find(TempName, ';',13) - 1],
														TempName[STD.Str.Find(TempName, ';',13)..STD.Str.Find(TempName, ';',14) - 1],
														TempName[STD.Str.Find(TempName, ';',14)..STD.Str.Find(TempName, ';',15) - 1],
														TempName[STD.Str.Find(TempName, ';',15)..STD.Str.Find(TempName, ';',16) - 1],
														TempName[STD.Str.Find(TempName, ';',16)..STD.Str.Find(TempName, ';',17) - 1],
														TempName[STD.Str.Find(TempName, ';',17)..STD.Str.Find(TempName, ';',18) - 1],
														TempName[STD.Str.Find(TempName, ';',18)..STD.Str.Find(TempName, ';',19) - 1],
														TempName[STD.Str.Find(TempName, ';',19)..STD.Str.Find(TempName, ';',20) - 1]);
			self.AKA	:= TRIM(STD.Str.FindReplace(ParseAKA,';',''),left,right);
			self := L;
		END;

		nGrpAKA	:= normalize(CountGrpAKA,IF(left.WordCount = 0,1,left.WordCount),ParseGrpAKA(left,counter));

	//Transform into common layout
	GlobalWatchLists_Preprocess.rOutLayout xfrmCommon(nGrpAKA L, integer C)	:= TRANSFORM
		self.pty_key				:= 'SDTE'+L.sequence_num;
		self.source					:= 'State Department Terrorist Exclusions';
		ClnOrg							:= ut.CleanSpacesAndUpper(STD.Str.FilterOut(REGEXREPLACE('\\((.*)\\)',L.organization,''),'"'));
		ClnAKA							:= TRIM(REGEXREPLACE('A.K.A.|F.K.A.',L.AKA,''),left,right);
		self.orig_pty_name	:= CHOOSE(C, ClnOrg,	ClnAKA);
		self.name_type			:= CHOOSE(C,'PRIMARY',IF(L.AKA <> '' and REGEXFIND('F.K.A',L.AKA),'FKA',
																								IF(L.AKA <> '' and ~REGEXFIND('F.K.A',L.AKA),'AKA','')));
		self.remarks_1			:= IF(STD.Str.Find(L.organization,'Pakistan and Afghanistan offices -- Kuwait office not designated',1) > 0,
															'Pakistan and Afghanistan offices -- Kuwait office not designated','');
		self.cname_clean		:= CHOOSE(C, ClnOrg,	ClnAKA);
		self.date_first_seen 						:= GlobalWatchLists_Preprocess.Versions.StateDeptExcl_Version;
		self.date_last_seen 						:= GlobalWatchLists_Preprocess.Versions.StateDeptExcl_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.StateDeptExcl_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.StateDeptExcl_Version;
		self.orig_aka_type 	:= CHOOSE(C,'',IF(L.AKA <> '',self.name_type,''));
		self.orig_giv_designator := 'G';
		self.orig_remarks := ut.CleanSpacesAndUpper(IF(STD.Str.Find(L.organization,'Pakistan and Afghanistan offices -- Kuwait office not designated',1) > 0,
																													'Pakistan and Afghanistan offices -- Kuwait office not designated',''));
		self.orig_raw_name	:= L.orig_raw_name;
		self := [];
	END;
	
	pStTerroristCommon	:= normalize(nGrpAKA,2,xfrmCommon(left,counter))(orig_pty_name <> '');
	dStTerroristCommon	:= dedup(sort(pStTerroristCommon,pty_key,orig_pty_name),all);
	
	RETURN	dStTerroristCommon;

END;