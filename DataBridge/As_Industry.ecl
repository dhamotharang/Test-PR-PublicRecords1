IMPORT DataBridge, TopBusiness_BIPV2, MDR, ut, _Validate;

Base := DataBridge.Files().base.qa;

Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

Industry_Layout	MapIndustry (Base L, INTEGER C)	:=	TRANSFORM,
SKIP((C = 1 AND (L.SIC8_1 = '' OR L.SIC8_Desc_1[1..2] = '**')) OR 
     (C = 2 AND (L.SIC8_2 = '' OR L.SIC8_Desc_2[1..2] = '**')) OR
     (C = 3 AND (L.SIC8_3 = '' OR L.SIC8_Desc_3[1..2] = '**')) OR
     (C = 4 AND (L.SIC8_4 = '' OR L.SIC8_Desc_4[1..2] = '**')))

	SELF.source       						:=	MDR.sourcetools.src_DataBridge;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id            :=  L.record_sid;
	SELF.siccode       						:=	CHOOSE(C, L.SIC8_1, L.SIC8_2, L.SIC8_3, L.SIC8_4);
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	CHOOSE(C, L.SIC8_Desc_1, L.SIC8_Desc_2, L.SIC8_Desc_3, L.SIC8_Desc_4);
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	IF(_Validate.date.fIsValid((STRING)L.dt_first_seen), L.dt_first_seen, 0);
	SELF.dt_last_seen							:=	IF(_Validate.date.fIsValid((STRING)L.dt_last_seen), L.dt_last_seen, 0);
	SELF.dt_vendor_first_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_first_reported), L.dt_vendor_first_reported, 0);
	SELF.dt_vendor_last_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_last_reported), L.dt_vendor_last_reported, 0);
	SELF.record_type							:=	L.record_type;
	SELF.record_date							:=	L.process_date;
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

Industry := NORMALIZE(Base,4,MapIndustry(LEFT,COUNTER));

Industry_dedup := DEDUP(SORT(Industry(siccode <> '' OR industry_description <> ''),RECORD),RECORD);
		
EXPORT As_Industry := Industry_dedup;