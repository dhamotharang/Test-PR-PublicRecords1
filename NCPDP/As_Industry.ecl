IMPORT TopBusiness_BIPV2, MDR;

Base := NCPDP.Files().keybuild_base.QA();

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapIndustry(Base L) := TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_NCPDP;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	0;
	SELF.siccode       						:=	'';
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	L.primarydispensingtypedesc;
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	(UNSIGNED4)L.dt_first_seen;
	SELF.dt_last_seen							:=	(UNSIGNED4)L.dt_last_seen;
	SELF.dt_vendor_first_reported	:=	0;
	SELF.dt_vendor_last_reported	:=	0;
	SELF.record_type							:=	'';
	SELF.record_date							:=	(UNSIGNED4)L.dt_last_seen;
	SELF 													:=	L; 
	SELF 													:=	[];
END;
		
EXPORT As_Industry := PROJECT(Base,MapIndustry(LEFT));
