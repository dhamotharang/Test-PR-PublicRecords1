IMPORT TopBusiness_BIPV2, MDR, _Validate, ut;

Base := Diversity_Certification.Files().base.qa();

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout	MapIndustry (Base L, INTEGER C)	:=	TRANSFORM,
SKIP((C = 2 AND L.siccode2 = '' AND L.naicscode2 = '' ) OR
     (C = 3 AND L.siccode3 = '' AND L.naicscode3 = '' ) OR
     (C = 4 AND L.siccode4 = '' AND L.naicscode4 = '' ) OR
     (C = 5 AND L.siccode5 = '' AND L.naicscode5 = '' ))
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_Diversity_Cert;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	0;
	SELF.siccode       						:=	CHOOSE(C, L.siccode1, L.siccode2, L.siccode3, L.siccode4, L.siccode5);
	SELF.naics        						:=	CHOOSE(C, L.naicscode1, L.naicscode2, L.naicscode3, L.naicscode4, L.naicscode5);
	SELF.industry_description 		:=	L.businesstype1;
	SELF.business_description 		:=	L.businessdescription;
	SELF.dt_first_seen						:=	IF(_Validate.Date.fIsValid(L.dt_first_seen), (UNSIGNED4)L.dt_first_seen, 0);
	SELF.dt_last_seen							:=	IF(_Validate.Date.fIsValid(L.dt_last_seen), (UNSIGNED4)L.dt_last_seen, 0);
	SELF.dt_vendor_first_reported	:=	IF(_Validate.Date.fIsValid(L.dt_vendor_first_reported),
                                       (UNSIGNED4)L.dt_vendor_first_reported, 0);
	SELF.dt_vendor_last_reported	:=	IF(_validate.date.fIsValid(L.dt_vendor_last_reported),
                                       (UNSIGNED4)L.dt_vendor_last_reported, 0);
	SELF.record_type							:=	'';
	SELF.record_date							:=	IF(_validate.date.fIsValid(L.dateupdated), (UNSIGNED4)L.dateupdated, 0);
	SELF 													:=	L; 
	SELF 													:=	[];
END;

Industry := NORMALIZE(Base,5,MapIndustry(LEFT,COUNTER));

// Rollup
TopBusiness_BIPV2.Layouts.rec_industry_combined_layout RollupDC(TopBusiness_BIPV2.Layouts.rec_industry_combined_layout L,
                                                                 TopBusiness_BIPV2.Layouts.rec_industry_combined_layout R) := TRANSFORM
	  SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				                                ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	  SELF.dt_last_seen                := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
	  SELF.dt_vendor_first_reported    := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	  SELF.dt_vendor_last_reported     := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	  SELF := l;
	END;
Industry_dist := DISTRIBUTE(Industry, bdid);
Industry_sort := SORT(Industry_dist, bdid, siccode, naics, industry_description, business_description, 
                      -dt_vendor_last_reported, LOCAL);
Industry_rollup := ROLLUP(Industry_sort,
							           LEFT.bdid = RIGHT.bdid AND
							           LEFT.siccode = RIGHT.siccode AND
							           LEFT.naics = RIGHT.naics AND
							           LEFT.industry_description = RIGHT.industry_description AND
							           LEFT.business_description = RIGHT.business_description,
						             RollupDC(LEFT, RIGHT),
							           LOCAL);

EXPORT As_Industry := Industry_rollup;				
