IMPORT DNB_DMI, TopBusiness_BIPV2, MDR, ut, _Validate, data_services, BIPV2;

Base := DNB_DMI.Files().base.companies.qa;

Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

Industry_Layout	MapIndustry(Base L, INTEGER C)	:=	TRANSFORM,
SKIP(  
     (C = 2 AND L.rawfields.sic1a = '' AND L.rawfields.sic1adesc = '') OR
		 (C = 3 AND L.rawfields.sic1b = '' AND L.rawfields.sic1bdesc = '') OR
     (C = 4 AND L.rawfields.sic1c = '' AND L.rawfields.sic1cdesc = '') OR
     (C = 5 AND L.rawfields.sic1d = '' AND L.rawfields.sic1ddesc = '') OR
		 
		 (C = 6 AND L.rawfields.sic2 = '' AND L.rawfields.sic2desc = '') OR
     (C = 7 AND L.rawfields.sic2a = '' AND L.rawfields.sic2adesc = '') OR
     (C = 8 AND L.rawfields.sic2b = '' AND L.rawfields.sic2bdesc = '') OR
     (C = 9 AND L.rawfields.sic2c = '' AND L.rawfields.sic2cdesc = '') OR		 
     (C = 10 AND L.rawfields.sic2d = '' AND L.rawfields.sic2ddesc = '') OR 
		 
		 (C = 11 AND L.rawfields.sic3 = '' AND L.rawfields.sic3desc = '') OR
     (C = 12 AND L.rawfields.sic3a = '' AND L.rawfields.sic3adesc = '') OR
     (C = 13 AND L.rawfields.sic3b = '' AND L.rawfields.sic3bdesc = '') OR
     (C = 14 AND L.rawfields.sic3c = '' AND L.rawfields.sic3cdesc = '') OR		 
     (C = 15 AND L.rawfields.sic3d = '' AND L.rawfields.sic3ddesc = '') OR 
		 
		 (C = 16 AND L.rawfields.sic4 = '' AND L.rawfields.sic4desc = '') OR
     (C = 17 AND L.rawfields.sic4a = '' AND L.rawfields.sic4adesc = '') OR
     (C = 18 AND L.rawfields.sic4b = '' AND L.rawfields.sic4bdesc = '') OR
     (C = 19 AND L.rawfields.sic4c = '' AND L.rawfields.sic4cdesc = '') OR 		 
     (C = 20 AND L.rawfields.sic4d = '' AND L.rawfields.sic4ddesc = '') OR 
		 
		 (C = 21 AND L.rawfields.sic5 = '' AND L.rawfields.sic5desc = '') OR
     (C = 22 AND L.rawfields.sic5a = '' AND L.rawfields.sic5adesc = '') OR
     (C = 23 AND L.rawfields.sic5b = '' AND L.rawfields.sic5bdesc = '') OR
     (C = 24 AND L.rawfields.sic5c = '' AND L.rawfields.sic5cdesc = '') OR 	 
     (C = 25 AND L.rawfields.sic5d = '' AND L.rawfields.sic5ddesc = '') OR
		 
		 (C = 26 AND L.rawfields.sic6 = '' AND L.rawfields.sic6desc = '') OR
     (C = 27 AND L.rawfields.sic6a = '' AND L.rawfields.sic6adesc = '') OR
     (C = 28 AND L.rawfields.sic6b = '' AND L.rawfields.sic6bdesc = '') OR
     (C = 29 AND L.rawfields.sic6c = '' AND L.rawfields.sic6cdesc = '') OR 
     (C = 30 AND L.rawfields.sic6d = '' AND L.rawfields.sic6ddesc = '') 
		 )
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	L.bdid_score; 
	SELF.source       						:=	MDR.sourcetools.src_Dunn_Bradstreet;
	SELF.source_docid  						:=	L.rawfields.duns_number;
	SELF.source_rec_id            :=  L.rid;
	SELF.siccode                  := CHOOSE(C, 
	                                         L.rawfields.sic1, L.rawfields.sic1a, L.rawfields.sic1b, L.rawfields.sic1c, L.rawfields.sic1d, 
	                                         L.rawfields.sic2, L.rawfields.sic2a, L.rawfields.sic2b, L.rawfields.sic2c, L.rawfields.sic2d, 
	                                         L.rawfields.sic3, L.rawfields.sic3a, L.rawfields.sic3b, L.rawfields.sic3c, L.rawfields.sic3d, 
	                                         L.rawfields.sic4, L.rawfields.sic4a, L.rawfields.sic4b, L.rawfields.sic4c, L.rawfields.sic4d, 
	                                         L.rawfields.sic5, L.rawfields.sic5a, L.rawfields.sic5b, L.rawfields.sic5c, L.rawfields.sic5d, 
	                                         L.rawfields.sic6, L.rawfields.sic6a, L.rawfields.sic6b, L.rawfields.sic6c, L.rawfields.sic6d
																					 );
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	CHOOSE(C, 
	                                         L.rawfields.sic1desc, L.rawfields.sic1adesc, L.rawfields.sic1bdesc, L.rawfields.sic1cdesc, L.rawfields.sic1ddesc, 
	                                         L.rawfields.sic2desc, L.rawfields.sic2adesc, L.rawfields.sic2bdesc, L.rawfields.sic2cdesc, L.rawfields.sic2ddesc, 
	                                         L.rawfields.sic3desc, L.rawfields.sic3adesc, L.rawfields.sic3bdesc, L.rawfields.sic3cdesc, L.rawfields.sic3ddesc, 
	                                         L.rawfields.sic4desc, L.rawfields.sic4adesc, L.rawfields.sic4bdesc, L.rawfields.sic4cdesc, L.rawfields.sic4ddesc, 
	                                         L.rawfields.sic5desc, L.rawfields.sic5adesc, L.rawfields.sic5bdesc, L.rawfields.sic5cdesc, L.rawfields.sic5ddesc, 
	                                         L.rawfields.sic6desc, L.rawfields.sic6adesc, L.rawfields.sic6bdesc, L.rawfields.sic6cdesc, L.rawfields.sic6ddesc
	                                         );
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	IF(_Validate.date.fIsValid((STRING)L.date_first_seen), L.date_first_seen, 0);
	SELF.dt_last_seen							:=	IF(_Validate.date.fIsValid((STRING)L.date_last_seen), L.date_last_seen, 0);
	SELF.dt_vendor_first_reported	:=	IF(_Validate.date.fIsValid((STRING)L.date_vendor_first_reported), L.date_vendor_first_reported, 0);
	SELF.dt_vendor_last_reported	:=	IF(_Validate.date.fIsValid((STRING)L.date_vendor_last_reported), L.date_vendor_last_reported, 0);
	SELF.record_type							:=	(STRING)L.record_type; 
	SELF.record_date							:=	L.date_last_seen; 
	SELF.UltID										:=	L.UltID;
  SELF.OrgID										:=	L.OrgID;
  SELF.SELEID										:=	L.SELEID;
  SELF.ProxID										:=	L.ProxID;
  SELF.POWID										:=	L.POWID;
  SELF.EmpID										:=	L.EmpID;
  SELF.DotID										:=	L.DotID;
  SELF.UltScore									:=	L.UltScore;
  SELF.OrgScore									:=	L.OrgScore;
  SELF.SELEScore								:=	L.SELEScore;
  SELF.ProxScore								:=	L.ProxScore;
  SELF.POWScore									:=	L.POWScore;
  SELF.EmpScore									:=	L.EmpScore;
  SELF.DotScore									:=	L.DotScore;
  SELF.UltWeight								:=	L.UltWeight;
  SELF.OrgWeight								:=	L.OrgWeight;
  SELF.SELEWeight								:=	L.SELEWeight;
  SELF.ProxWeight								:=	L.ProxWeight;
  SELF.POWWeight								:=	L.POWWeight;
  SELF.EmpWeight								:=	L.EmpWeight;
  SELF.DotWeight								:=	L.DotWeight;
  SELF 													:=	L;
	SELF 													:=	[];
END;

Industry := NORMALIZE(Base,30,MapIndustry(LEFT,COUNTER));

Industry_dedup := DEDUP(SORT(Industry(siccode <> '' OR industry_description <> ''),RECORD),RECORD);
	
EXPORT As_Industry := Industry_dedup;