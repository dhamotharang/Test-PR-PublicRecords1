IMPORT TopBusiness_BIPV2, MDR, _Validate, ut;

Base := YellowPages.files().base.qa;

trimUpper(STRING s) := FUNCTION
	RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
END;				

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout	MapIndustry (Base L, INTEGER C)	:=	TRANSFORM,
SKIP((C = 2 AND L.sic2 = '') OR
     (C = 3 AND L.sic3 = '') OR
     (C = 4 AND L.sic4 = ''))
	SELF.bdid 										:= L.bdid;
	SELF.bdid_score								:= 0;
	SELF.source       						:= MDR.sourceTools.src_Yellow_Pages;
	SELF.source_docid  						:= '';
	SELF.siccode       						:= CHOOSE(C, L.sic_code, L.sic2, L.sic3, L.sic4);
	SELF.naics        						:= L.naics_code;
  SELF.industry_description			:= YellowPages.IndustryClass_Explosion_Table(L.indstryclass);
  SELF.business_description 		:= '';
	SELF.dt_first_seen						:= 0;
	SELF.dt_last_seen							:= IF(_Validate.Date.fIsValid(L.pub_date), (UNSIGNED4)L.pub_date, 0);
	SELF.dt_vendor_first_reported	:= 0;
	SELF.dt_vendor_last_reported	:= IF(_Validate.Date.fIsValid(L.pub_date), (UNSIGNED4)L.pub_date, 0);
	SELF.record_type							:= '';
	SELF.record_date							:= IF(_Validate.Date.fIsValid(L.pub_date), (UNSIGNED4)L.pub_date, 0);
	SELF 													:= L; 
	SELF 													:= [];
END;

Industry := NORMALIZE(Base,4,MapIndustry(LEFT,COUNTER));

Industry_dedup := DEDUP(SORT(Industry(siccode <> '' OR naics <> '' OR industry_description <> ''),RECORD),RECORD);

EXPORT YellowPages_As_Industry := Industry_dedup;				