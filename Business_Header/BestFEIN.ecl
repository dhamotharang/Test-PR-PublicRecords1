// Same in logic to Header.MAC_Best_SSN, except for
// the field names & types being used.  It'd be easy to have
// that macro take a flag indicating business vs. person header,
// but it would also be ugly.

export BestFEIN(dataset(business_header.Layout_Business_Header_Base) bh) := FUNCTION

bh_fein := bh(fein != 0);
bh_d_bdid := DISTRIBUTE(bh_fein, HASH(bdid));

layout_fein_ct := RECORD
	bh_d_bdid.bdid;
	bh_d_bdid.fein;
	UNSIGNED2 fein_ct := COUNT(GROUP);
END;

fein_stat := TABLE(bh_d_bdid, layout_fein_ct, bdid, fein, LOCAL);
fein_g_stat := GROUP(SORT(fein_stat, bdid, LOCAL), bdid, LOCAL);

// Sort by FEIN count.
fein_s_stat := SORT(fein_g_stat, -fein_ct, -fein);

// Keep the most frequent FEIN, since there are so few that we have.
bh_bestfein := GROUP(DEDUP(fein_s_stat, TRUE)) : persist('BH::BestFEIN');

/*
// Keep only 2 most frequent FEIN's per DID.
fein_d_stat := DEDUP(fein_s_stat, TRUE, KEEP 2);

// Do a self join in order to keep only a single BDID/FEIN combination
// If there's only one FEIN, keep it.  If there are multiple FEIN's,
// keep the most frequent one, provided it's at least two times
// more frequent than the next.
layout_bh_bestfein := RECORD
	UNSIGNED6 bdid;
	UNSIGNED4 fein;
END;

layout_bh_bestfein JoinFein(fein_d_stat l) := TRANSFORM
	SELF := l;
END;

bh_bestfein := JOIN(fein_d_stat, fein_d_stat, 
						LEFT.bdid = RIGHT.bdid AND
						LEFT.fein != RIGHT.fein AND
						LEFT.fein_ct < 2 * RIGHT.fein_ct,
						JoinFein(LEFT), LEFT ONLY, LOCAL);
*/

return bh_bestfein;
end;