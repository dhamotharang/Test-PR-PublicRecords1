IMPORT Business_HeaderV2, TopBusiness_BIPV2, MDR, ut, _Validate;

Base := InfoUSA.File_Deadco_Base_AID;

Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

Industry_Layout	MapIndustry (Base L, INTEGER C)	:=	TRANSFORM,
SKIP((C = 2 AND L.secondary_sic_1 = '' AND L.secondary_sic_desc1 = '') OR
     (C = 3 AND L.secondary_sic_2 = '' AND L.secondary_sic_desc2 = '') OR
     (C = 4 AND L.secondary_sic_3 = '' AND L.secondary_sic_desc3 = '') OR
     (C = 5 AND L.secondary_sic_4 = '' AND L.secondary_sic_desc4 = ''))
	SELF.bdid 										:= L.bdid;
	SELF.bdid_score								:= 0;
	SELF.source       						:= MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES;
	SELF.source_docid  						:= L.vendor_id;
	SELF.siccode       						:= CHOOSE(C, L.primary_sic, L.secondary_sic_1, L.secondary_sic_2, L.secondary_sic_3, L.secondary_sic_4);
	SELF.naics        						:= '';
  SELF.industry_description			:= CHOOSE(C, L.sic_desc, L.secondary_sic_desc1, L.secondary_sic_desc2, L.secondary_sic_desc3, L.secondary_sic_desc4);
  SELF.business_description 		:= '';
	SELF.dt_first_seen						:= IF(_Validate.Date.fIsValid(L.dt_first_seen), (UNSIGNED4)L.dt_first_seen, 0);
	SELF.dt_last_seen							:= IF(_Validate.Date.fIsValid(L.dt_last_seen), (UNSIGNED4)L.dt_last_seen, 0);
	SELF.dt_vendor_first_reported	:= IF(_Validate.Date.fIsValid(L.dt_vendor_first_reported), (UNSIGNED4)L.dt_vendor_first_reported, 0);
	SELF.dt_vendor_last_reported	:= IF(_Validate.Date.fIsValid(L.dt_vendor_last_reported), (UNSIGNED4)L.dt_vendor_last_reported, 0);
	SELF.record_type							:= '';
	SELF.record_date							:= IF(_Validate.Date.fIsValid(L.process_date), (UNSIGNED4)L.process_date, 0);
	SELF 													:= L; 
	SELF 													:= [];
END;

Industry := NORMALIZE(Base,5,MapIndustry(LEFT,COUNTER));

Industry_dedup := DEDUP(SORT(Industry(siccode <> '' OR industry_description <> ''),RECORD),RECORD);
		
EXPORT DEADCO_As_Industry := Industry_dedup;