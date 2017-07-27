IMPORT TopBusiness_BIPV2, MDR;

Base_Member := BBB2.Files().Base.Member.QA;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapMIndustry(Base_Member L) := TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_BBB_Member;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	'';
	SELF.siccode       						:=	'';
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	L.member_category;
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	(UNSIGNED)L.date_first_seen;
	SELF.dt_last_seen							:=	(UNSIGNED)L.date_last_seen;
	SELF.dt_vendor_first_reported	:=	(UNSIGNED)L.dt_vendor_first_reported;
	SELF.dt_vendor_last_reported	:=	(UNSIGNED)L.dt_vendor_last_reported;
	SELF.record_type							:=	L.record_type;
	SELF.record_date							:=	(UNSIGNED)L.report_date;
	SELF 													:=	L; 
	SELF 													:=	[];
END;

Industry_Member := PROJECT(Base_Member,MapMIndustry(LEFT));

Base_NonMember := bbb2.Files().Base.NonMember.QA;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapNMIndustry(Base_NonMember L) := TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_BBB_Non_Member;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	'';
	SELF.siccode       						:=	'';
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	L.non_member_category;
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	(UNSIGNED)L.date_first_seen;
	SELF.dt_last_seen							:=	(UNSIGNED)L.date_last_seen;
	SELF.dt_vendor_first_reported	:=	(UNSIGNED)L.dt_vendor_first_reported;
	SELF.dt_vendor_last_reported	:=	(UNSIGNED)L.dt_vendor_last_reported;
	SELF.record_type							:=	L.record_type;
	SELF.record_date							:=	(UNSIGNED)L.report_date;
	SELF 													:=	L; 
	SELF 													:=	[];
END;

Industry_NonMember := PROJECT(Base_NonMember,MapNMIndustry(LEFT));
		
EXPORT BBB_As_Industry := Industry_Member + Industry_NonMember;