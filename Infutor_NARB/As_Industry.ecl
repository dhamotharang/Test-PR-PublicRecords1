IMPORT Infutor_NARB, TopBusiness_BIPV2, MDR, ut, _Validate; 

Base := Infutor_NARB.Files(,true).base.qa;

Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

Industry_Layout	MapIndustry (Base L, INTEGER C)	:=	TRANSFORM,
SKIP((C = 2 AND L.sic2[1..4] in ['',L.sic1[1..4] ])                           OR
     (C = 3 AND L.sic3[1..4] in ['',L.sic1[1..4],L.sic2[1..4] ])              OR
     (C = 4 AND L.sic4[1..4] in ['',L.sic1[1..4],L.sic2[1..4],L.sic3[1..4] ]) OR
     (C = 5 AND L.sic5[1..4] in ['',L.sic1[1..4],L.sic2[1..4],L.sic3[1..4],L.sic4[1..4] ]))
	
  SELF.bdid 										:=	0;
	SELF.bdid_score								:=	0;
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
	SELF.dt_first_seen						:=	IF(_Validate.date.fIsValid((STRING)L.dt_first_seen), L.dt_first_seen, 0);
	SELF.dt_last_seen							:=	IF(_Validate.date.fIsValid((STRING)L.dt_last_seen), L.dt_last_seen, 0);
	SELF.dt_vendor_first_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_first_reported), L.dt_vendor_first_reported, 0);
	SELF.dt_vendor_last_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_last_reported), L.dt_vendor_last_reported, 0);
	SELF.record_type							:=	L.record_type;
	SELF.record_date							:=	L.process_date;
	SELF.source       						:=	mdr.sourcetools.src_infutor_narb;
	SELF.source_docid  						:=	trim(L.pid) + trim(L.record_id);
	SELF.source_rec_id            :=  L.rcid;
	SELF.siccode       						:=	CHOOSE(C, L.sic1[1..4], L.sic2[1..4], L.sic3[1..4], L.sic4[1..4], L.sic5[1..4]);
	SELF.industry_description 		:=	CHOOSE(C, L.heading1, L.heading2, L.heading3, L.heading4, L.heading5);
	SELF.naics        						:=	'';
	SELF.business_description 		:=	'';
  SELF 													:=	L;
	SELF 													:=	[];
END;

Industry := NORMALIZE(Base,5,MapIndustry(LEFT,COUNTER));

Industry_dedup := DEDUP(SORT(Industry(siccode <> '' or industry_description <> ''),RECORD),RECORD);
		
EXPORT As_Industry := Industry_dedup;