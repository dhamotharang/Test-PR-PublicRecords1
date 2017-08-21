IMPORT TopBusiness_BIPV2, MDR, ut, _Validate;

Base := Frandx.Files().base.qa;

trimUpper(STRING s) := FUNCTION
 RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
END;				

Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

Industry_Layout	MapIndustry (Base L)	:=	TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourcetools.src_Frandx;
	SELF.source_docid  						:=	L.record_id;
	SELF.siccode       						:=	L.sic_code;
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	IF(trimUpper(L.industry) = 'QSR' , 'QUICK SERVICE RESTAURANT', trimUpper(L.industry));
	SELF.business_description 		:=	trimUpper(L.sector);
	SELF.dt_first_seen						:=	IF(_Validate.date.fIsValid((STRING)L.dt_first_seen), L.dt_first_seen, 0);
	SELF.dt_last_seen							:=	IF(_Validate.date.fIsValid((STRING)L.dt_last_seen), L.dt_last_seen, 0);
	SELF.dt_vendor_first_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_first_reported), L.dt_vendor_first_reported, 0);
	SELF.dt_vendor_last_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_last_reported), L.dt_vendor_last_reported, 0);
	SELF.record_type							:=	L.record_type;
	SELF.record_date							:=	0;
  SELF 													:=	L;
	SELF 													:=	[];
END;

Industry := PROJECT(Base,MapIndustry(LEFT));

Industry_dedup := DEDUP(SORT(Industry(siccode <> '' OR industry_description <> '' OR business_description <> ''),RECORD),RECORD);
		
EXPORT As_Industry := Industry_dedup;