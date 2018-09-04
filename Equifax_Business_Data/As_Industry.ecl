IMPORT Equifax_Business_Data, TopBusiness_BIPV2, MDR, ut, _Validate;

Base := Equifax_Business_Data.Files().base.qa;

Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

Industry_Layout	MapIndustry (Base L, INTEGER C)	:=	TRANSFORM,
SKIP((C = 2 AND L.efx_secsic1 = '' AND L.efx_secnaics1 = '') OR
     (C = 3 AND L.efx_secsic2 = ''AND L.efx_secnaics2 = '') OR
     (C = 4 AND L.efx_secsic3 = ''AND L.efx_secnaics3 = '') OR
     (C = 5 AND L.efx_secsic4 = ''AND L.efx_secnaics4 = ''))
	SELF.bdid 										:=	0;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourcetools.src_Equifax_Business_Data;
	SELF.source_docid  						:=	L.efx_id;
	SELF.source_rec_id            :=  L.rcid;
	SELF.siccode       						:=	CHOOSE(C, L.efx_primsic, L.efx_secsic1, L.efx_secsic2, L.efx_secsic3, L.efx_secsic4);
	SELF.naics        						:=	CHOOSE(C, L.efx_primnaicscode, L.efx_secnaics1, L.efx_secnaics2, L.efx_secnaics3, L.efx_secnaics4);
	SELF.industry_description 		:=	CHOOSE(C, L.efx_primsicdesc, L.efx_secsicdesc1, L.efx_secsicdesc2, L.efx_secsicdesc3, L.efx_secsicdesc4);
	SELF.business_description 		:=	CHOOSE(C, L.efx_primnaicsdesc, L.efx_secnaicsdesc1, L.efx_secnaicsdesc2, L.efx_secnaicsdesc3, L.efx_secnaicsdesc4);
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

Industry := NORMALIZE(Base,5,MapIndustry(LEFT,COUNTER));

Industry_dedup := DEDUP(SORT(Industry(siccode <> '' OR naics <> '' OR industry_description <> '' OR business_description <> ''),RECORD),RECORD);
		
EXPORT As_Industry := Industry_dedup;