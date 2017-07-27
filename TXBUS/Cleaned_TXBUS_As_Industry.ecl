IMPORT TopBusiness_BIPV2, MDR;

Base := TXBUS.File_Txbus_Base;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapIndustry(Base L) := TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_IRS_Non_Profit;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	'';
	SELF.siccode       						:=	'';
	SELF.naics        						:=	L.outlet_naics_code;
	SELF.industry_description 		:=	'';
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	(UNSIGNED4)L.dt_first_seen;
	SELF.dt_last_seen							:=	(UNSIGNED4)L.dt_last_seen;
	SELF.dt_vendor_first_reported	:=	(UNSIGNED4)L.process_date;
	SELF.dt_vendor_last_reported	:=	(UNSIGNED4)L.process_date;
	SELF.record_type							:=	'';
	SELF.record_date							:=	(UNSIGNED4)L.process_date;
	SELF 													:=	L; 
	SELF 													:=	[];
END;
		
EXPORT Cleaned_TXBUS_As_Industry := PROJECT(Base,MapIndustry(LEFT));