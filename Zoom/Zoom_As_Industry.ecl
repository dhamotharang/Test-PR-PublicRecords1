IMPORT TopBusiness_BIPV2, MDR, ut, _Validate;

Base := ZOOM.Files().Base.QA;

trimUpper(STRING s) := FUNCTION
 RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
END;				

Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

Industry_Layout	MapIndustry (Base L, INTEGER C)	:=	TRANSFORM,
SKIP(C = 2 AND L.rawfields.sic2 = '')
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_ZOOM;
	SELF.source_docid  						:=	L.rawfields.zoomid;
	SELF.siccode       						:=	CHOOSE(C, L.rawfields.sic1, L.rawfields.sic2);
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	trimUpper(L.rawfields.industry_label);
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	IF(_Validate.date.fIsValid((STRING)L.dt_first_seen), L.dt_first_seen, 0);
	SELF.dt_last_seen							:=	IF(_Validate.date.fIsValid((STRING)L.dt_last_seen), L.dt_last_seen, 0);
	SELF.dt_vendor_first_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_first_reported), L.dt_vendor_first_reported, 0);
	SELF.dt_vendor_last_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_last_reported), L.dt_vendor_last_reported, 0);
	SELF.record_type							:=	L.record_type;
	SELF.record_date							:=	IF(_Validate.date.fIsValid((STRING)L.clean_dates.last_updated_date), L.clean_dates.last_updated_date, 0);
	SELF 													:=	[];
END;

Industry := NORMALIZE(Base,2,MapIndustry(LEFT,COUNTER));

Industry_dedup := DEDUP(SORT(Industry(siccode <> '' OR industry_description <> ''),RECORD),RECORD);
		
EXPORT Zoom_As_Industry := Industry_dedup;