IMPORT ut,PRTE2_X_Ins_PropertyScramble,RoxieKeyBuild;

fileVersion := ut.GetDate+'';
DSXRef := SORT(PRTE2_X_Ins_PropertyScramble.Files.XRef_Enhanced_SF_DS,recnum);
LayoutNew := PRTE2_X_Ins_PropertyScramble.Layouts.Layout_Enhanced_with_Counters;

LayoutNew xfToLayoutNew(DSXRef L, DSXRef R) := TRANSFORM
		SELF.XRecnum := R.RECNUM;
		SELF.map_prim_range := R.prim_range;
		SELF.map_predir := R.predir;
		SELF.map_prim_name := R.prim_name;
		SELF.map_addr_suffix := R.addr_suffix;
		SELF.map_postdir := R.postdir;
		SELF.map_unit_desig := R.unit_desig;
		SELF.map_sec_range := R.sec_range;
		SELF.map_p_city_name := R.p_city_name;
		SELF.map_v_city_name := R.v_city_name;
		SELF.map_st := R.st;
		SELF.map_zip5 := R.zip5;
		SELF.map_zip4 := R.zip4;
		SELF.map_Clean_streetaddr1 := R.Clean_streetaddr1;
		SELF.map_Clean_CityStZip := R.Clean_CityStZip;
		SELF  := L;
		SELF  := [];
END;

new := JOIN(DSXRef,DSXRef,
					// LEFT.street = RIGHT.mapped_street
					// AND LEFT.apt = RIGHT.mapped_apt
					// AND LEFT.city = RIGHT.mapped_city
					// AND LEFT.state = RIGHT.mapped_state
					// AND LEFT.zip[1..5] = RIGHT.mapped_zip[1..5],
					LEFT.mapped_street = RIGHT.street
					AND LEFT.mapped_apt = RIGHT.apt
					AND LEFT.mapped_city = RIGHT.city
					AND LEFT.mapped_state = RIGHT.state
					AND LEFT.mapped_zip[1..5] = RIGHT.zip[1..5],
					xfToLayoutNew(LEFT,RIGHT),
					LEFT OUTER,LOOKUP);
					
NewXRefX := SORT(new,recnum);					


RoxieKeyBuild.Mac_SF_BuildProcess_V2(NewXRefX,
   																		 PRTE2_X_Ins_PropertyScramble.Files.BASE_PREFIX_NAME_ENXRef, 
   																		 PRTE2_X_Ins_PropertyScramble.Files.ENHANCED_COUNTERS_NAME,
   																		 fileVersion, buildMergedHdr, 3,
   																		 false,true);

SEQUENTIAL(buildMergedHdr);
