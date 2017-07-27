IMPORT TopBusiness_BIPV2, MDR;

Base := govdata.File_IRS_NonProfit_Base_AID;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapIndustry(Base L) := TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_IRS_Non_Profit;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	'';
	SELF.siccode       						:=	'';
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	Explosion_Table.GetIndustryDesc_IRS990(L.subsection_code, L.classification_code,
                                                                           L.activity_codes, L.national_taxonomy_exempt);
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	IF((INTEGER)L.ruling_date > 190000, ((INTEGER)L.ruling_date) * 100, 
					                             IF((INTEGER)L.tax_period > 190000, ((INTEGER)L.tax_period) * 100,
						                              (INTEGER)L.process_date));
	SELF.dt_last_seen							:=	(UNSIGNED)L.process_date;
	SELF.dt_vendor_first_reported	:=	SELF.dt_first_seen;
	SELF.dt_vendor_last_reported	:=	(UNSIGNED)L.process_date;
	SELF.record_type							:=	'';
	SELF.record_date							:=	(UNSIGNED)L.process_date;
	SELF 													:=	L; 
	SELF 													:=	[];
END;
		
EXPORT IRS_Non_Profit_As_Industry := PROJECT(Base,MapIndustry(LEFT));