IMPORT TopBusiness_BIPV2, MDR, ut;

Base := Spoke.files().base.QA;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapIndustry(Base L) := TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_Spoke;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	0;
	SELF.siccode       						:=	'';
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	'';
	SELF.business_description 		:=	stringlib.StringToUpperCase(L.rawfields.Company_Business_Description);
	SELF.dt_first_seen						:=	(UNSIGNED4)L.dt_first_seen;
	SELF.dt_last_seen							:=	(UNSIGNED4)L.dt_last_seen;
	SELF.dt_vendor_first_reported	:=	(UNSIGNED4)L.dt_vendor_first_reported;
	SELF.dt_vendor_last_reported	:=	(UNSIGNED4)L.dt_vendor_last_reported;
	SELF.record_type							:=	'';
	SELF.record_date							:=	(UNSIGNED4)L.clean_dates.Validation_Date;
	SELF 													:=	L; 
	SELF 													:=	[];
END;

spoke_as_industry := PROJECT(Base,MapIndustry(LEFT));

//output(count (spoke_as_industry),named('cnt_spoke_as_industry_not_ded'));

bad_business_desc := ['','(NULL)','%DESCRIPTION%','&#8221;FIRES'];

//*** fnction to identify the bad business description values
GoodBusDesc(string pBus_desc) := function
	return if(length(stringlib.StringFilter(pBus_desc,'ABCEDFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')) > 0 and
						trim(pBus_desc) not in bad_business_desc, true, false);
end;

spoke_as_industry_srt := sort(spoke_as_industry((GoodBusDesc(business_description) or trim(siccode) <> '' or trim(naics) <> '' or trim(industry_description) <> '') and 
																								(ultid <> 0 or orgid <> 0 or seleid <> 0 or proxid <> 0 or powid <> 0 or empid <> 0 or dotid <> 0 or bdid <> 0)),
															record, except dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported, record_date,
															ultscore, orgscore, selescore, proxscore, powscore, empscore, dotscore,
															ultweight, orgweight, seleweight, proxweight, powweight, empweight, dotweight);

recordof(spoke_as_industry_srt) rollupTrf(spoke_as_industry_srt l, spoke_as_industry_srt r) := transform
	self.dt_first_seen 						:= ut.EarliestDate(l.dt_first_seen, r.dt_first_seen);
	self.dt_last_seen 						:= max(l.dt_last_seen, r.dt_last_seen);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
	self.dt_vendor_last_reported 	:= max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
	self.record_date 							:= max(l.record_date, r.record_date);
	self 													:= l;
end;

spoke_as_industry_rollup := rollup(spoke_as_industry_srt, rollupTrf(left, right), 
																	 except dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported, record_date,
																	 ultscore, orgscore, selescore, proxscore, powscore, empscore, dotscore,
																	 ultweight, orgweight, seleweight, proxweight, powweight, empweight, dotweight);
		
EXPORT As_Industry := spoke_as_industry_rollup;