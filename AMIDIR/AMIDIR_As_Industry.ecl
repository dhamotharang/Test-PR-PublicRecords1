IMPORT TopBusiness_BIPV2, MDR;

Base := AMIDIR.File_AMIDIR_DID_SSN_BDID;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapIndustry(Base L) := TRANSFORM
	SELF.bdid 										:=	(UNSIGNED6)L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_AMIDIR;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	'';
	SELF.siccode       						:=	L.SIC;
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	'';
	SELF.business_description 		:=	L.Business_Type;
	SELF.dt_first_seen						:=	(UNSIGNED4)L.Date_First_Seen;
	SELF.dt_last_seen							:=	(UNSIGNED4)L.Date_Last_Seen;
	SELF.dt_vendor_first_reported	:=	(UNSIGNED4)L.Date_Vendor_First_Reported;
	SELF.dt_vendor_last_reported	:=	(UNSIGNED4)L.Date_Vendor_Last_Reported;
	SELF.record_type							:=	'';
	SELF.record_date							:=	(UNSIGNED4)L.Process_Date;
	SELF 													:=	L; 
	SELF 													:=	[];
END;
		
EXPORT AMIDIR_As_Industry := PROJECT(Base,MapIndustry(LEFT));