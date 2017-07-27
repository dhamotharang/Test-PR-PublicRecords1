IMPORT TopBusiness_BIPV2, MDR;

Base := Calbus.File_Calbus_Base;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapIndustry(Base L) := TRANSFORM
	SELF.bdid 										:=	(UNSIGNED) L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_CA_Sales_Tax;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	'';
	SELF.siccode       						:=	'';
	SELF.naics        						:=	L.naics_code;
	SELF.industry_description 		:=	L.industry_code_desc;
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	(UNSIGNED)L.dt_first_seen;
	SELF.dt_last_seen							:=	(UNSIGNED)L.dt_last_seen;
	SELF.dt_vendor_first_reported	:=	(UNSIGNED)L.dt_first_seen;
	SELF.dt_vendor_last_reported	:=	(UNSIGNED)L.dt_last_seen;
	SELF.record_type							:=	'';
	SELF.record_date							:=	(UNSIGNED)L.process_date;
	SELF 													:=	L; 
	SELF 													:=	[];
END;
		
EXPORT Calbus_As_Industry := PROJECT(Base,MapIndustry(LEFT));