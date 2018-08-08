IMPORT TopBusiness_BIPV2, MDR, ut, _Validate;

Base := Equifax_Business_Data.Files().base.qa;

Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

Industry_Layout	MapIndustry (Base L, INTEGER C)	:=	TRANSFORM,
SKIP((C = 2 AND L.efx_secsic1 = '') OR
     (C = 3 AND L.efx_secsic2 = '') OR
     (C = 4 AND L.efx_secsic3 = '') OR
     (C = 5 AND L.efx_secsic4 = ''))
	SELF.bdid 										:=	0;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourcetools.src_Equifax_Business_Data;
	SELF.source_docid  						:=	L.efx_id;
	SELF.source_rec_id            :=  L.rcid;
	SELF.siccode       						:=	CHOOSE(C, L.efx_primsic, L.efx_secsic1, L.efx_secsic2, L.efx_secsic3, L.efx_secsic4);
	SELF.naics        						:=	CHOOSE(C, L.efx_primnaicscode, L.efx_secnaics1, L.efx_secnaics2, L.efx_secnaics3, L.efx_secnaics4);
	SELF.industry_description 		:=	L.efx_primsicdesc;
	SELF.business_description 		:=	L.efx_primnaicsdesc;
	SELF.dt_first_seen						:=	IF(_Validate.date.fIsValid((STRING)L.dt_first_seen), L.dt_first_seen, 0);
	SELF.dt_last_seen							:=	IF(_Validate.date.fIsValid((STRING)L.dt_last_seen), L.dt_last_seen, 0);
	SELF.dt_vendor_first_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_first_reported), L.dt_vendor_first_reported, 0);
	SELF.dt_vendor_last_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_last_reported), L.dt_vendor_last_reported, 0);
	SELF.record_type							:=	L.record_type;
	SELF.record_date							:=	L.process_date;
  SELF 													:=	L;
	SELF 													:=	[];
END;

Industry := NORMALIZE(Base,5,MapIndustry(LEFT,COUNTER));

Industry_dedup := DEDUP(SORT(Industry(siccode <> '' OR naics <> '' OR industry_description <> '' OR business_description <> ''),RECORD),RECORD);
		
EXPORT As_Industry := Industry_dedup;