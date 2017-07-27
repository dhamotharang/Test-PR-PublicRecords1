IMPORT TopBusiness_BIPV2, MDR;

Base := Spoke.files().base.QA;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapIndustry(Base L) := TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_Spoke;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	'';
	SELF.siccode       						:=	'';
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	'';
	SELF.business_description 		:=	stringlib.StringToUpperCase(L.rawfields.Company_Business_Description);
	SELF.dt_first_seen						:=	(UNSIGNED4)L.dt_first_seen;
	SELF.dt_last_seen							:=	(UNSIGNED4)L.dt_last_seen;
	SELF.dt_vendor_first_reported	:=	(UNSIGNED4)L.dt_vendor_first_reported;
	SELF.dt_vendor_last_reported	:=	(UNSIGNED4)L.dt_vendor_last_reported;
	SELF.record_type							:=	'';
	SELF.record_date							:=	(UNSIGNED4)L.clean_dates.Validation_Date;
	SELF 													:=	L; 
	SELF 													:=	[];
END;
		
EXPORT As_Industry := PROJECT(Base,MapIndustry(LEFT));