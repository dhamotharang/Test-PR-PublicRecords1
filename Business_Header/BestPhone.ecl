import mdr;

export BestPhone(

	dataset(business_header.Layout_Business_Header_Base) bh = Files().Base.Business_Headers.Built
	,boolean pNon_DandB_phone = false

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
		INTEGER1 dset_group := 1;
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
	bh_needscore := bh_slim(					
			not(		MDR.sourceTools.SourceIsGong_Business		(source)
					or 	MDR.sourceTools.SourceIsGong_Government	(source)
				 )
	);

	layout_ph_sort AddPhoneScore(bh_needscore l) := TRANSFORM
		SELF.phone_score := ph_score(l.phone);
		SELF := l;
	END;

	bh_scored := PROJECT(bh_needscore, AddPhoneScore(LEFT))
					+ bh_slim(		MDR.sourceTools.SourceIsGong_Business		(source)
										or 	MDR.sourceTools.SourceIsGong_Government	(source)
					);

	// Redistribute the concatenated set, just in case...
	bh_d_scored := DISTRIBUTE(bh_scored, HASH(bdid));

	bh_g_bdid := GROUP(SORT(bh_d_scored, bdid, LOCAL), bdid);
  	
	// Always prefer phones with areacodes, even if not the most recent.
	best_phone_all := UNGROUP(DEDUP(
					SORT(bh_g_bdid, -has_area_code, -dt_last_seen, -phone_score, -phone),
					bdid));
				
  // Set the all group dset group to 2, so that it during the merge if dups exist between the all 
	// and non d&b, the non D&b records will be first in the record set.
	best_phone_all_grp := PROJECT(best_phone_all,TRANSFORM(layout_ph_sort,SELF.dset_group := 2, SELF := LEFT));
			
	best_phone_nonDandB := DEDUP(
					SORT(bh_g_bdid(source <> MDR.sourceTools.src_Dunn_Bradstreet), -has_area_code, -dt_last_seen, -phone_score, -phone),
					bdid);
	best_phone_merge := UNGROUP(DEDUP(MERGE(best_phone_nonDandB,best_phone_all_grp,SORTED(bdid,dset_group)),bdid));
		
	/* This transformation is used to select the 2nd best phone for a bdid pair. If the "best" phone  
	is from a D&B record, use the second best phone. Reason being is
	that we are not legally allowed to display the phone number from a D&B source, so if a phone number exists
	from another source we will use that one instead.
	*/
	bh_d_phscore_date := IF (pNon_DandB_phone,best_phone_merge,best_phone_all);
	
	layout_bh_bestphone := RECORD
		bh_d_phscore_date.bdid;
		bh_d_phscore_date.phone;
		string2 phone_source;
	END;
  
	bh_bp := GROUP(project(bh_d_phscore_date,TRANSFORM(layout_bh_bestphone,SELF.phone_source := LEFT.source, SELF := LEFT)));
	
	return bh_bp;

end;