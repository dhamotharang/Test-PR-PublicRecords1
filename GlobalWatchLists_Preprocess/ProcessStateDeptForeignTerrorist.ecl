IMPORT GlobalWatchLists_Preprocess, STD, lib_StringLib, ut;

EXPORT ProcessStateDeptForeignTerrorist := FUNCTION

	HdrData	:= '(^Loading |^Orignal |^Number |^Author |^Writing |^Minrow=0 |Extract Date)(.*)';
	ds_StateDeptTerrorist	:= GlobalWatchLists_Preprocess.Files.dsStDeptTerrorist(~REGEXFIND(HdrData,Organization) and trim(Organization,all) <> '');

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
		self.AKA				:= STD.Str.FindReplace(IF(REGEXFIND('\\)',L.AKA), STD.Str.FindReplace(L.AKA,')',';'),L.AKA),'(','');
		self.WordCount	:= IF(L.AKA <> '',STD.Str.FindCount(self.AKA,';'),0);
		self.orig_raw_name	:= REGEXREPLACE(';$',ut.CleanSpacesAndUpper(trim(L.organization,left,right)+'; '+self.AKA),'');
		self := L;
		self := [];
	END;

	CountGrpAKA	:= project(pAddSeqNum, GetCount(left));

	lParseName - WordCount ParseGrpAKA(CountGrpAKA L, integer C) := TRANSFORM
			ParseAKA	:= CHOOSE(C,IF(L.WordCount <= 1,L.AKA,
															IF(L.WordCount > 1,L.AKA[1..STD.Str.Find(L.AKA, ';',1) - 1],'')),
														L.AKA[STD.Str.Find(L.AKA, ';',1)..STD.Str.Find(L.AKA, ';',2) - 1],
														L.AKA[STD.Str.Find(L.AKA, ';',2)..STD.Str.Find(L.AKA, ';',3) - 1]);
			self.AKA	:= TRIM(STD.Str.FindReplace(ParseAKA,';',''),left,right);
			self := L;
		END;

		nGrpAKA	:= normalize(CountGrpAKA,MAP(left.WordCount = 3 => 3,
																				left.WordCount = 2 => 2,1),ParseGrpAKA(left,counter));

	//Transform into common layout
	GlobalWatchLists_Preprocess.rOutLayout xfrmCommon(nGrpAKA L, integer C)	:= TRANSFORM
		self.pty_key				:= 'SDFTO'+L.sequence_num;
		self.source					:= 'State Department Foreign Terrorist Organizations';
		ClnOrg							:= ut.CleanSpacesAndUpper(L.organization);
		ClnAKA							:= ut.CleanSpacesAndUpper(REGEXREPLACE('formally',L.AKA,''));
		self.orig_pty_name	:= CHOOSE(C, ClnOrg, ClnAKA);
		self.name_type			:= CHOOSE(C,'PRIMARY',IF(L.AKA <> '' and REGEXFIND('formally',L.AKA),'FKA',
																								IF(L.AKA <> '','AKA','')));
		self.remarks_1			:= '';
		self.cname_clean		:= CHOOSE(C, ClnOrg,	ClnAKA);
		self.date_first_seen 						:= GlobalWatchLists_Preprocess.Versions.StateDeptForeign_Version;
		self.date_last_seen 						:= GlobalWatchLists_Preprocess.Versions.StateDeptForeign_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.StateDeptForeign_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.StateDeptForeign_Version;
		self.orig_aka_type 	:= CHOOSE(C,'',IF(L.AKA <> '',self.name_type,''));
		self.orig_giv_designator := 'G';
		self.orig_raw_name	:= L.orig_raw_name;
		self := [];
	END;
	
	pStTerroristCommon	:= normalize(nGrpAKA,2,xfrmCommon(left,counter))(orig_pty_name <> '');
	dStTerroristCommon	:= dedup(sort(pStTerroristCommon,pty_key,orig_pty_name),record);
	
	RETURN	dStTerroristCommon;

END;