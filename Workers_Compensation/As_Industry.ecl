IMPORT TopBusiness_BIPV2, MDR, ut, _Validate;

Base := Workers_Compensation.Files().base.QA();

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapIndustry(Base L) := TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_Workers_Compensation;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	L.source_rec_id;
	SELF.siccode       						:=	'';
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	'';
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	IF(_Validate.date.fIsValid((STRING)L.Date_FirstSeen),
																			 (UNSIGNED4)L.Date_FirstSeen, 0);
	SELF.dt_last_seen							:=	IF(_Validate.date.fIsValid((STRING)L.Date_LastSeen),
																			 (UNSIGNED4)L.Date_LastSeen, 0);
	SELF.dt_vendor_first_reported	:=	SELF.dt_first_seen;
	SELF.dt_vendor_last_reported	:=	SELF.dt_last_seen;
	SELF.record_type							:=	'';
	SELF.record_date							:=	IF(_Validate.date.fIsValid((STRING)L.effective_date),
																			 (UNSIGNED4)L.effective_date, 0);
	SELF 													:=	L; 
	SELF 													:=	[];
END;

Industry := PROJECT(Base,MapIndustry(LEFT));

// Rollup
TopBusiness_BIPV2.Layouts.rec_industry_combined_layout RollupLA(TopBusiness_BIPV2.Layouts.rec_industry_combined_layout L,
                                                                TopBusiness_BIPV2.Layouts.rec_industry_combined_layout R) := TRANSFORM
	  SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				                                ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	  SELF.dt_last_seen                := Max(L.dt_last_seen,R.dt_last_seen);
	  SELF.dt_vendor_first_reported    := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	  SELF.dt_vendor_last_reported     := Max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	  SELF := l;
	END;
Industry_dist   := DISTRIBUTE(Industry, bdid);
Industry_sort   := SORT(Industry_dist, bdid, -dt_last_seen, LOCAL);
Industry_rollup := ROLLUP(Industry_sort,
													LEFT.bdid = RIGHT.bdid,
													RollupLA(LEFT, RIGHT),
													LOCAL);
		
EXPORT As_Industry := Industry_rollup;