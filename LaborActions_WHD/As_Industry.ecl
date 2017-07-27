IMPORT TopBusiness_BIPV2, MDR, ut;

Base := LaborActions_WHD.Files().base.QA();

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapIndustry(Base L) := TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_LaborActions_WHD;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	'';
	SELF.siccode       						:=	'';
	SELF.naics        						:=	L.naicscode;
	SELF.industry_description 		:=	'';
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	(UNSIGNED4)L.date_firstseen;
	SELF.dt_last_seen							:=	(UNSIGNED4)L.date_lastseen;
	SELF.dt_vendor_first_reported	:=	(UNSIGNED4)L.dateadded;
	SELF.dt_vendor_last_reported	:=	(UNSIGNED4)L.dateupdated;
	SELF.record_type							:=	'';
	SELF.record_date							:=	(UNSIGNED4)L.dateupdated;
	SELF 													:=	L; 
	SELF 													:=	[];
END;

Industry := PROJECT(Base,MapIndustry(LEFT));

// Rollup
TopBusiness_BIPV2.Layouts.rec_industry_combined_layout RollupLA(TopBusiness_BIPV2.Layouts.rec_industry_combined_layout L,
                                                                 TopBusiness_BIPV2.Layouts.rec_industry_combined_layout R) := TRANSFORM
	  SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				                                ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	  SELF.dt_last_seen                := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
	  SELF.dt_vendor_first_reported    := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	  SELF.dt_vendor_last_reported     := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	  SELF := l;
	END;
Industry_dist := DISTRIBUTE(Industry, bdid);
Industry_sort := SORT(Industry_dist, bdid, naics, -dt_vendor_last_reported, LOCAL);
Industry_rollup := ROLLUP(Industry_sort,
							           LEFT.bdid = RIGHT.bdid AND
							           LEFT.naics = RIGHT.naics,
						             RollupLA(LEFT, RIGHT),
							           LOCAL);
		
		
EXPORT As_Industry := Industry_rollup;
