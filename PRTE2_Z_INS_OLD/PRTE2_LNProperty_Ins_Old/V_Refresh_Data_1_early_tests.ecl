/*
Just some early research via this script
*/

// Phase 1 take our addresses and use addr_search.fid key to gather ln_fares_id's for our addresses.

IMPORT ut,PRTE2_LNProperty,LN_PropertyV2_Services,PRTE2_Common,PRTE2_X_Ins_PropertyScramble;

// DSXRef := PRTE2_X_Ins_PropertyScramble.Files.XRef_Enhanced_SF_DS;
DSXRef := PRTE2_X_Ins_PropertyScramble.Files.XRef_Enhanced_CNT_SF_DS;
LNPExpanded := PRTE2_LNProperty.Files.Alpha_Audit_SF_DS(source_code <> 'OO');
LNPBase := PRTE2_LNProperty.Files.LNP_Scramble_SF_DS;

EnhancedBatchIn_Layout := RECORD
		PRTE2_LNProperty.Layouts.batch_in;
		PRTE2_X_Ins_PropertyScramble.Layouts.Temp_Clean_Addr;
		PRTE2_X_Ins_PropertyScramble.Layouts.Mapped_Clean_Addr;
END;

// ---------- First add a cleaned address to the batch_in to enable a good JOIN with XREF
EnhancedBatchIn_Layout xFormInitial(LNPBase L, LNPExpanded R) := TRANSFORM
	SELF.tmp_prim_range := R.person_addr.prim_range;
	SELF.tmp_predir := R.person_addr.predir;
	SELF.tmp_prim_name := R.person_addr.prim_name;
	SELF.tmp_addr_suffix := R.person_addr.addr_suffix;
	SELF.tmp_postdir := R.person_addr.postdir;
	SELF.tmp_unit_desig := R.person_addr.unit_desig;
	SELF.tmp_sec_range := R.person_addr.sec_range;
	SELF.tmp_p_city_name := R.person_addr.v_city_name;
	SELF.tmp_v_city_name := R.person_addr.v_city_name;
	SELF.tmp_st := R.person_addr.st;
	SELF.tmp_zip5 := R.person_addr.zip5;
	SELF.tmp_zip4 := R.person_addr.zip4;
	SELF := L;
	SELF := [];
END;
Enhanced_BatchIn1 := JOIN(LNPBase,LNPExpanded,
													LEFT.ln_fares_id = RIGHT.ln_fares_id
													,xFormInitial(LEFT,RIGHT)
													,LEFT outer
													);
OUTPUT(Enhanced_BatchIn1);	

// ---------- Next JOIN with the XREF Counter to get the mapped clean address
EnhancedBatchIn_Layout xFormBase2(Enhanced_BatchIn1 L, DSXRef R) := TRANSFORM
		SELF.tmp_prim_range := R.map_prim_range;
		SELF.tmp_predir := R.map_predir;
		SELF.tmp_prim_name := R.map_prim_name;
		SELF.tmp_addr_suffix := R.map_addr_suffix;
		SELF.tmp_postdir := R.map_postdir;
		SELF.tmp_unit_desig := R.map_unit_desig;
		SELF.tmp_sec_range := R.map_sec_range;
		SELF.tmp_p_city_name := R.map_v_city_name;
		SELF.tmp_v_city_name := R.map_v_city_name;
		SELF.tmp_st := R.map_st;
		SELF.tmp_zip5 := R.map_zip5;
		SELF.tmp_zip4 := R.map_zip4;
		SELF.tmp_Clean_streetaddr1 := R.map_Clean_streetaddr1;
		SELF.tmp_Clean_CityStZip := R.map_Clean_CityStZip;
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
		SELF := L;
END;
Enhanced_BatchIn2 := JOIN(Enhanced_BatchIn1, DSXRef,
											LEFT.tmp_prim_name = RIGHT.map_prim_name
											and LEFT.tmp_prim_range = RIGHT.map_prim_range
											and LEFT.tmp_zip5 = RIGHT.map_zip5
											and LEFT.tmp_predir = RIGHT.map_predir
											and LEFT.tmp_postdir = RIGHT.map_postdir
											and LEFT.tmp_sec_range = RIGHT.map_sec_range
											,xFormBase2(LEFT,RIGHT)
											,LEFT outer
											);
OUTPUT(Enhanced_BatchIn2);		// This contains LN+XREF Mapped address
											
EnhancedBatchIn_Layout fixTmpCleans(Enhanced_BatchIn2 L, LNPExpanded R) := TRANSFORM
	SELF.tmp_prim_range := R.person_addr.prim_range;
	SELF.tmp_predir := R.person_addr.predir;
	SELF.tmp_prim_name := R.person_addr.prim_name;
	SELF.tmp_addr_suffix := R.person_addr.addr_suffix;
	SELF.tmp_postdir := R.person_addr.postdir;
	SELF.tmp_unit_desig := R.person_addr.unit_desig;
	SELF.tmp_sec_range := R.person_addr.sec_range;
	SELF.tmp_p_city_name := R.person_addr.v_city_name;
	SELF.tmp_v_city_name := R.person_addr.v_city_name;
	SELF.tmp_st := R.person_addr.st;
	SELF.tmp_zip5 := R.person_addr.zip5;
	SELF.tmp_zip4 := R.person_addr.zip4;
	SELF := L;
	SELF := [];
END;
Enhanced_BatchIn3 := JOIN(Enhanced_BatchIn2,LNPExpanded,
													LEFT.ln_fares_id = RIGHT.ln_fares_id
													,fixTmpCleans(LEFT,RIGHT)
													,LEFT outer
													);
OUTPUT(Enhanced_BatchIn3);	


OUTPUT(COUNT(LNPBase));
OUTPUT(COUNT(LNPExpanded));
OUTPUT(COUNT(Enhanced_BatchIn1));
OUTPUT(COUNT(Enhanced_BatchIn2));
Enhanced_BatchIn := DEDUP(SORT(Enhanced_BatchIn2,ln_fares_id),ln_fares_id);
OUTPUT(COUNT(Enhanced_BatchIn));
