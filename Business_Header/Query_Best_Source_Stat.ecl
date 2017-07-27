IMPORT ut;

bst := Business_Header.BestJoined;
best_d := DISTRIBUTE(bst, HASH(bdid));

bh := Business_Header.File_Business_Header;
bh_d := DISTRIBUTE(bh, HASH(bdid));

// count of bdid's per source.
bh_src := DEDUP(bh_d ,bdid, source, ALL, LOCAL);
layout_all_stat := RECORD
	STRING2 source := bh_src.source;
	UNSIGNED4   ct := COUNT(GROUP);
END;

all_stat := TABLE(bh_src, layout_all_stat, source, FEW);

layout_match := RECORD
	UNSIGNED6  bdid;
	STRING2    source;
END;

layout_match Match(bh_d l) := TRANSFORM
	SELF := l;
END;

// produces a count of bdid's where the best COMPANY NAME is from
// a particular source.
best_name := JOIN(bh_d, best_d,
		LEFT.bdid = RIGHT.bdid AND
		LEFT.company_name = RIGHT.company_name,
		Match(LEFT), LOCAL);

best_name_ded := DEDUP(best_name, bdid, source, ALL, LOCAL);

layout_name_source_stat := RECORD
	STRING2 source := best_name_ded.source;
	UNSIGNED4   ct := COUNT(GROUP);
END;

name_stat_raw := TABLE(best_name_ded, layout_name_source_stat, source, FEW);

layout_name_stat := RECORD
	STRING2 source;
	REAL    pct_name;
END;

layout_name_stat PercentsName(all_stat l, name_stat_raw r) := TRANSFORM
	SELF.source := l.source;
	SELF.pct_name	:= r.ct / l.ct * 100;
END;

name_stat := JOIN(all_stat, name_stat_raw,
			LEFT.source = RIGHT.source, PercentsName(LEFT, RIGHT));

// produces a count of bdid's where the best ADDRESS is from
// a particular source.
best_addr := JOIN(bh_d, best_d,
		LEFT.bdid = RIGHT.bdid AND
		LEFT.company_name = RIGHT.company_name AND
		LEFT.prim_range = RIGHT.prim_range AND
		LEFT.predir = RIGHT.predir AND
		LEFT.prim_name = RIGHT.prim_name AND
		LEFT.addr_suffix = RIGHT.addr_suffix AND
		LEFT.postdir = RIGHT.postdir AND
		LEFT.unit_desig = RIGHT.unit_desig AND
		LEFT.sec_range = RIGHT.sec_range AND
		LEFT.city = RIGHT.city AND
		LEFT.state = RIGHT.state AND
		LEFT.zip = RIGHT.zip AND
		LEFT.zip4 = RIGHT.zip4,
		Match(LEFT), LOCAL);

best_addr_ded := DEDUP(best_addr, bdid, source, ALL, LOCAL);

layout_addr_source_stat := RECORD
	STRING2 source := best_addr_ded.source;
	UNSIGNED4   ct := COUNT(GROUP);
END;

addr_stat_raw := TABLE(best_addr_ded, layout_addr_source_stat, source, FEW);

layout_addr_stat := RECORD
	STRING2 source;
	REAL    pct_addr;
END;

layout_addr_stat PercentsAddr(all_stat l, addr_stat_raw r) := TRANSFORM
	SELF.source := l.source;
	SELF.pct_addr	:= r.ct / l.ct * 100;
END;

addr_stat := JOIN(all_stat, addr_stat_raw,
			LEFT.source = RIGHT.source, PercentsAddr(LEFT, RIGHT));


// produces a count of bdid's where the best PHONE is from
// a particular source.
best_phone := JOIN(
		bh_d,
		best_d(ut.IsFlagSet(best_flags, Business_Header.BestFlag_Phone)),
		LEFT.bdid = RIGHT.bdid AND
		LEFT.phone = RIGHT.phone,
		Match(LEFT), LOCAL);

best_phone_ded := DEDUP(best_phone, bdid, source, ALL, LOCAL);

layout_phone_source_stat := RECORD
	STRING2 source := best_phone_ded.source;
	UNSIGNED4   ct := COUNT(GROUP);
END;

phone_stat_raw := TABLE(best_phone_ded, layout_phone_source_stat, source, FEW);

layout_phone_stat := RECORD
	STRING2 source;
	REAL    pct_phone;
END;

layout_phone_stat PercentsPhone(all_stat l, phone_stat_raw r) := TRANSFORM
	SELF.source := l.source;
	SELF.pct_phone	:= r.ct / l.ct * 100;
END;

phone_stat := JOIN(all_stat, phone_stat_raw,
			LEFT.source = RIGHT.source, PercentsPhone(LEFT, RIGHT));

// produces a count of bdid's where the best FEIN is from
// a particular source.
best_fein := JOIN(
		bh_d,
		best_d(ut.IsFlagSet(best_flags, Business_Header.BestFlag_FEIN)),
		LEFT.bdid = RIGHT.bdid AND
		LEFT.fein = RIGHT.fein,
		Match(LEFT), LOCAL);

best_fein_ded := DEDUP(best_fein, bdid, source, ALL, LOCAL);

layout_fein_source_stat := RECORD
	STRING2 source := best_fein_ded.source;
	UNSIGNED4   ct := COUNT(GROUP);
END;

fein_stat_raw := TABLE(best_fein_ded, layout_fein_source_stat, source, FEW);

layout_fein_stat := RECORD
	STRING2 source;
	REAL    pct_fein;
END;

layout_fein_stat PercentsFein(all_stat l, fein_stat_raw r) := TRANSFORM
	SELF.source := l.source;
	SELF.pct_fein	:= r.ct / l.ct * 100;
END;

fein_stat := JOIN(all_stat, fein_stat_raw,
			LEFT.source = RIGHT.source, PercentsFein(LEFT, RIGHT));


// Join all stats on source
res_n_a := JOIN(name_stat, addr_stat,
				LEFT.source = RIGHT.source, LEFT OUTER);

res_n_a_p := JOIN(res_n_a, phone_stat,
				LEFT.source = RIGHT.source, LEFT OUTER);

res_n_a_p_f := JOIN(res_n_a_p, fein_stat,
				LEFT.source = RIGHT.source, LEFT OUTER);

OUTPUT(res_n_a_p_f);