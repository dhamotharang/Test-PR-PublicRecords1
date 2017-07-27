IMPORT TopBusiness_BIPV2, MDR;

Base := govdata.File_OR_Workers_Comp_BDID;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapIndustry(Base L) := TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.SourceTools.src_OR_Worker_Comp;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	'';
	SELF.siccode       						:=	L.standard_industrial_class_code;
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	L.business_description;
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	(UNSIGNED4)L.date_first_seen;
	SELF.dt_last_seen							:=	(UNSIGNED4)L.date_last_seen;
	SELF.dt_vendor_first_reported	:=	(UNSIGNED4)L.date_first_seen;
	SELF.dt_vendor_last_reported	:=	(UNSIGNED4)L.date_last_seen;
	SELF.record_type							:=	'';
	SELF.record_date							:=	(UNSIGNED4)L.date_last_seen;
	SELF 													:=	L; 
	SELF 													:=	[];
END;
		
EXPORT OR_Workers_As_Industry := PROJECT(Base,MapIndustry(LEFT));
