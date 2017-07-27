IMPORT TopBusiness_BIPV2, MDR, _Validate;

Base := InfoUSA.File_ABIUS_Company_Base_AID;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout	MapIndustry (Base L, INTEGER C)	:=	TRANSFORM,
SKIP((C = 2 AND L.secondary_sic_1 = '') OR
     (C = 3 AND L.secondary_sic_2 = '') OR
     (C = 4 AND L.secondary_sic_3 = '') OR
     (C = 5 AND L.secondary_sic_4 = ''))
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_INFOUSA_ABIUS_USABIZ;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	'';
	SELF.siccode       						:=	CHOOSE(C, L.primary_sic, L.secondary_sic_1, L.secondary_sic_2,
					                                    L.secondary_sic_3, L.secondary_sic_4);
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	'';
 	// NOTE (from DW): the base file industry_desc field doesn't really have industry info in it. 
	// It contains other non-industry related information about the company.
	// However Tim Bernhard decided he did not want that data output on either the 
	// layout_industry or in the business_description field on the layout_abstract.
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	IF(_Validate.Date.fIsValid(L.date_added + '00'), 
                                       ((UNSIGNED4)L.date_added) * 100, 0);
	SELF.dt_last_seen							:=	IF(_Validate.Date.fIsValid(L.date_added + '00'), 
                                       ((UNSIGNED4)L.date_added) * 100, 0);
	SELF.dt_vendor_first_reported	:=	IF(_Validate.Date.fIsValid(L.date_added + '00'), 
                                       ((UNSIGNED4)L.date_added) * 100,
                                       IF(_validate.date.fIsValid(L.production_date),
                                          (UNSIGNED4)L.production_date, 0));
	SELF.dt_vendor_last_reported	:=	IF(_validate.date.fIsValid(L.production_date),
                                       (UNSIGNED4)L.production_date, 0);
	SELF.record_type							:=	'';
	SELF.record_date							:=	IF(_validate.date.fIsValid(L.process_date),
                                       (UNSIGNED4)L.process_date, 0);
	SELF 													:=	L; 
	SELF 													:=	[];
END;
		
EXPORT ABIUS_Company_As_Industry := DEDUP(SORT(NORMALIZE(Base,5,MapIndustry(LEFT,COUNTER)), RECORD));

