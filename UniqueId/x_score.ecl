import STD, Address;


/*
      SELF.prim_range  := sCleanAddress[ 1..  10];
      SELF.predir      := sCleanAddress[ 11.. 12];
      SELF.prim_name   := sCleanAddress[ 13.. 40];
      SELF.addr_suffix := sCleanAddress[ 41.. 44];
      SELF.postdir     := sCleanAddress[ 45.. 46];
      SELF.unit_desig  := sCleanAddress[ 47.. 56];
      SELF.sec_range   := sCleanAddress[ 57.. 64];
      SELF.p_city_name := sCleanAddress[ 65.. 89];
      SELF.v_city_name := sCleanAddress[ 90..114];
      SELF.st          := sCleanAddress[115..116];
      SELF.zip         := sCleanAddress[117..121];
      SELF.zip4        := sCleanAddress[122..125];
      SELF.err_stat    := sCleanAddress[179..182];
*/
string CleanAddress(string s) := FUNCTION
	string fs := IF(std.str.Find(s, '§', 1)=0,'|','§');		// field separator
	words := std.str.splitwords(s,fs,true);	// undocumented last parameter allows null entries
	sCleanAddress:=address.cleanaddress182(
					TRIM(Std.Str.touppercase(words[2] + ' ' + words[3])),
					Std.Str.touppercase(words[4])+' '+Std.Str.touppercase(words[5])+' '+words[6]);
	mainAddress := //IF(sCleanAddress[179] = 'S',
				sCleanAddress[1..46] + ' ' + sCleanAddress[65.. 89] + ' ' + sCleanAddress[115..116] + ' ' + sCleanAddress[117..121];
				//s);
	return IF(TRIM(mainAddress,ALL)='',s,std.str.CleanSpaces(mainAddress));
END;

boolean CompareAddresses(unicode addr1, unicode addr2) := 
		MAP(
			Std.uni.ToUpperCase(addr1) = Std.uni.ToUpperCase(addr2) => true,
			CleanAddress(Std.str.ToUpperCase((string) addr1)) = CleanAddress(Std.str.ToUpperCase((string) addr2)) => true,
			false);

boolean CompareNames(string name1, string name2) := MAP(
	name1 = name2 => true,
	std.str.EditDistance((string)name1, (string)name2) < 2 => true,
	std.str.EditDistance(TRIM(std.str.FindReplace((string)name1,'DBA','')),
												TRIM(std.str.FindReplace((string)name2,'DBA',''))) < 2 => true,
	false); 


boolean CompareAKA(unicode name1, unicode name2) := FUNCTION
	string fs1 := IF(std.uni.Find(name1, U'§', 1)=0,'|','§');		// field separator
	string fs2 := IF(std.uni.Find(name2, U'§', 1)=0,'|','§');		// field separator
	words1 := std.str.splitwords((string)name1,fs1,true);
	words2 := std.str.splitwords((string)name2,fs2,true);
	// just compare full names for now
	return CompareNames(Std.str.ToUpperCase(words1[7]),Std.str.ToUpperCase(words2[7]));
END;

boolean equals(unicode s1, unicode s2) := IF(s1='' OR s2='',false,s1=s2);

EXPORT rScore x_score(UniqueId.Layout_Flat prev, UniqueId.Layout_Flat new) := TRANSFORM
		self.newkey := new.primarykey;
		self.prevkey := prev.primarykey;
		self.Entity_Unique_ID := prev.Entity_Unique_ID;
		self.WatchListName := prev.WatchListName;
		self.score :=
				IF(Std.Uni.ToUpperCase(prev.full_name)=Std.Uni.ToUpperCase(new.full_name),1,0)
				+ IF(CompareAKA(prev.akas, new.akas), 1, 0)
				+ IF(prev.listed_date=new.listed_date, 1, 0)
				+ IF(CompareAddresses(prev.addresses, new.addresses), 1, 0)
				+ IF(equals(prev.infos,new.infos), 1, 0)
				+ IF(equals(prev.ids,new.ids), 1, 0)
				+ IF(equals(prev.phones,new.phones), 1, 0)
				+ IF(equals(prev.comments,new.comments), 1, 0);
		self.flags :=
				IF(Std.Uni.ToUpperCase(prev.full_name)=Std.Uni.ToUpperCase(new.full_name),'N','')
				+ IF(CompareAKA(prev.akas,new.akas), 'K', '')
				+ IF(CompareAddresses(prev.addresses, new.addresses), 'A', '')
				+ IF(equals(prev.infos,new.infos), 'I', '')
				+ IF(equals(prev.ids,new.ids), 'D', '')
				+ IF(equals(prev.phones,new.phones), 'P', '')
				+ IF(equals(prev.comments, new.comments), 'C', '')
				+ IF(prev.listed_date=new.listed_date, 'L', '')
				;
END;