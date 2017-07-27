import corp2, RiskWise, business_header, iesp;

// Given a dataset containing business ids (bdid),
// return a dataset containing the legal name and status of the businesses.


EXPORT BusinessStanding_Function(DATASET(SNA.BusinessRecord_Layout) companies) := FUNCTION

	indata := dedup(sort(companies, bdid));

	SNA.BusinessRecord_Layout get_corpkeys(SNA.BusinessRecord_Layout L, corp2.key_Corp_bdid R) := TRANSFORM
		self.corp_key := R.corp_key;
		self := L;
	END;

	corpkeys := join(indata, corp2.key_Corp_bdid,
										left.bdid != 0 and 
										keyed(left.bdid = right.bdid),
										get_corpkeys(LEFT,RIGHT), atmost(250));

	corpkey_layout := recordof(corp2.Key_Corp_Corpkey);
	corpkey_layout justCorpKeys(corpkeys L, corpkey_layout R) := TRANSFORM
		self := R;
	END;
	
	corprecs := join(corpkeys,
										corp2.key_corp_corpkey,
										left.corp_key!='' and 
										keyed(Left.corp_key = right.corp_key) and (left.bdid = right.bdid),
										justCorpKeys(LEFT, RIGHT), 
										ATMOST(keyed(Left.corp_key = right.corp_key),RiskWise.max_atmost),  
										keep(100));
					
	corp_sort := dedup(sort(corprecs, bdid, if (business_header.is_ActiveCorp(record_type, corp_status_cd, corp_status_desc),0,1), if (corp_status_desc != '', 0, 1)), bdid);

	companies check_standing(companies L, corp_sort R) := transform
		// default to good standing status on left outer part of join....
			self.Standing := if (r.bdid = 0, 'U', if (business_header.is_ActiveCorp(r.record_type, R.corp_status_cd, R.corp_status_desc), 'A',
								if (stringlib.stringfind(R.corp_status_desc, 'INACTIVE', 1) != 0, 'I',
								if (stringlib.stringfind(R.corp_status_desc, 'DISSOLVED', 1) != 0, 'D','U'))));
			self := L;
	end;
		
	wstanding := join(companies, corp_sort,
										(integer)left.bdid=right.bdid,
										check_standing(LEFT,RIGHT), 
										left outer);
					 

	return wstanding;

END;