
export BestPhone(

	dataset(business_header.Layout_Business_Header_Base) bh = Files().Base.Business_Headers.Built

) := FUNCTION

bh_phone := bh(phone <> 0);
bh_d_bdid := DISTRIBUTE(bh_phone, HASH(bdid));

layout_ph_sort := RECORD
	bh_d_bdid.bdid;
	bh_d_bdid.phone;
	bh_d_bdid.phone_score;
	bh_d_bdid.source;
	bh_d_bdid.dt_last_seen;
	INTEGER1 has_area_code;
END;

layout_ph_sort CheckAreaCode(bh_d_bdid l) := TRANSFORM
	SELF.has_area_code := IF(l.phone > 9999999, 1, 0);
	SELF := l;
END;

bh_slim := PROJECT(bh_d_bdid, CheckAreaCode(LEFT));

// $TODO: This logic is stolen from Gong.Gong_As_Business_Header,
// it should be common.
STRING10 sf(INTEGER ph) := INTFORMAT(ph, 10, 1);
INTEGER ph_score(INTEGER ph) := 2 * (
						IF(sf(ph)[9..10] = '00', 500, 0) +
						IF(sf(ph)[8..10] = '000', 500, 0) +
						IF(sf(ph)[1..3] IN ['800','811','822','833','844','855','866','877','888'], 250, 0));

// Add a phone score to non-gong records.  If there are gong records,
// they will be preferred since they also include a sequence number
// in their score.
bh_needscore := bh_slim(source not in ['GB','GG']);

layout_ph_sort AddPhoneScore(bh_needscore l) := TRANSFORM
	SELF.phone_score := ph_score(l.phone);
	SELF := l;
END;

bh_scored := PROJECT(bh_needscore, AddPhoneScore(LEFT))
				+ bh_slim(~(source not in ['GB','GG']));

// Redistribute the concatenated set, just in case...
bh_d_scored := DISTRIBUTE(bh_scored, HASH(bdid));

bh_g_bdid := GROUP(SORT(bh_d_scored, bdid, LOCAL), bdid);

// Always prefer phones with areacodes, even if not the most recent.
bh_d_phscore_date := DEDUP(
				SORT(bh_g_bdid, -has_area_code, -dt_last_seen, -phone_score, -phone),
				bdid);

layout_bh_bestphone := RECORD
	bh_d_phscore_date.bdid;
	bh_d_phscore_date.phone;
END;

bh_bp := TABLE(GROUP(bh_d_phscore_date), layout_bh_bestphone);
return bh_bp;
end;