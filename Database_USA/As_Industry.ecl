IMPORT Database_USA, TopBusiness_BIPV2, MDR, ut, _Validate; 

Base := Database_USA.Files().base.qa;

Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

Industry_Layout	MapIndustry (Base L, INTEGER C)	:=	TRANSFORM,
SKIP((C = 2 AND L.SIC02 in ['',L.Primary_SIC] AND L.NAICS02 in ['',L.NAICS01]) OR
     (C = 3 AND L.SIC03 in ['',L.Primary_SIC,L.SIC02] AND L.NAICS03 in ['',L.NAICS01,L.NAICS02]) OR
     (C = 4 AND L.SIC04 in ['',L.Primary_SIC,L.SIC02,L.SIC03] AND L.NAICS04 in ['',L.NAICS01,L.NAICS02,L.NAICS03]) OR
     (C = 5 AND L.SIC05 in ['',L.Primary_SIC,L.SIC02,L.SIC03,L.SIC04] AND L.NAICS05 in ['',L.NAICS01,L.NAICS02,L.NAICS03,L.NAICS04]) OR 
		 (C = 6 AND L.SIC06 in ['',L.Primary_SIC,L.SIC02,L.SIC03,L.SIC04,L.SIC05] AND L.NAICS06 in ['',L.NAICS01,L.NAICS02,L.NAICS03,L.NAICS04,L.NAICS05])
		 )	
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
	SELF.source       						:=	mdr.sourcetools.src_Database_USA;
	SELF.source_docid  						:=	trim(l.DBUSA_Business_ID) + trim(l.DBUSA_Executive_ID);
	SELF.source_rec_id            :=  L.record_sid;
	temp_sic_code                 :=  CHOOSE(C, L.Primary_SIC, L.SIC02, L.SIC03, L.SIC04, L.SIC05, L.SIC06);
	SELF.siccode						      :=  If(ut.fn_SIC_functions.fn_validate_SICCode(temp_sic_code[1..4]) = 1,ut.CleanSpacesAndUpper(temp_sic_code[1..4]),'');
	SELF.industry_description 		:=	CHOOSE(C, L.Primary_SIC_Desc, L.SIC02_Desc, L.SIC03_Desc, L.SIC04_Desc, L.SIC05_Desc, L.SIC06_Desc);
	temp_naics_code    						:=	CHOOSE(C, L.NAICS01, L.NAICS02, L.NAICS03, L.NAICS04, L.NAICS05, L.NAICS06);
  SELF.naics            				:=  If(ut.fn_NAICS_functions.fn_validate_NAICSCode(temp_naics_code) = 1,ut.CleanSpacesAndUpper(temp_naics_code),'');
	SELF.business_description 		:=	CHOOSE(C, L.NAICS01_Desc, L.NAICS02_Desc, L.NAICS03_Desc, L.NAICS04_Desc, L.NAICS05_Desc, L.NAICS06_Desc);
  SELF 													:=	L;
	SELF 													:=	[];
END;

Industry := NORMALIZE(Base,5,MapIndustry(LEFT,COUNTER));

Industry_dedup := DEDUP(SORT(Industry(siccode <> '' or industry_description <> ''),RECORD),RECORD)
                  : persist(Database_USA.persist_names().root + '::As_Industry', REFRESH(TRUE), SINGLE);
		
EXPORT As_Industry := Industry_dedup;