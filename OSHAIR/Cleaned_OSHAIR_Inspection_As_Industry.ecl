IMPORT TopBusiness_BIPV2, MDR, _Validate;

Base := OSHAIR.file_out_inspection_cleaned_both;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout	MapIndustry (Base L, INTEGER C)	:=	TRANSFORM,
SKIP(C = 2 AND L.naics_secondary_code = '000000')
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	L.bdid_score;
	SELF.source       						:=	MDR.sourceTools.src_OSHAIR;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	L.source_rec_id;
	SELF.siccode       						:=	(STRING)L.sic_code;
	SELF.naics        						:=	CHOOSE(C,IF(L.naics_code='000000','',L.naics_code),L.naics_secondary_code);
	SELF.industry_description 		:=	'';
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	IF(_Validate.Date.fIsValid((STRING)L.last_activity_date),L.last_activity_date,0);
	SELF.dt_last_seen							:=	IF(_Validate.Date.fIsValid((STRING)L.last_activity_date),L.last_activity_date,0);
	SELF.dt_vendor_first_reported	:=	0;
	SELF.dt_vendor_last_reported	:=	0;
	SELF.record_type							:=	'';
	SELF.record_date							:=	IF(_Validate.Date.fIsValid((STRING)L.last_activity_date),L.last_activity_date,0);
	SELF 													:=	L; 
	SELF 													:=	[];
END;
		
EXPORT Cleaned_OSHAIR_Inspection_As_Industry := NORMALIZE(Base,2,MapIndustry(LEFT,COUNTER));