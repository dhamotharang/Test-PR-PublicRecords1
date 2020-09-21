IMPORT TopBusiness_BIPV2, MDR, std, ut, _Validate;

trimUpper(STRING s) := 
  std.str.CleanSpaces(std.Str.ToUppercase(s));
	
asIndustryBase := Cortera.Files().Base.Executives.QA;//dataset('~thor::cortera::executives', cortera.Layout_Executives, thor);

EXPORT As_Industry() := FUNCTION

		Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

		Industry_Layout	MapIndustry (asIndustryBase L)	:=	TRANSFORM
			SELF.bdid 										:=	L.bdid;
			SELF.bdid_score								:=	L.bdid_score;
			SELF.source       						:=	MDR.sourcetools.src_Cortera;
			SELF.source_docid             :=  (STRING)L.persistent_record_id;
			SELF.source_rec_id  					:=	L.link_id;
			SELF.siccode                  := L.primary_sic;
			SELF.naics        						:= L.primary_naics;
			SELF.industry_description 		:=	trimUpper(STD.Str.FilterOut(L.sic_desc, '"'));
			SELF.business_description 		:=	trimUpper(L.naics_desc);
			SELF.dt_first_seen						:=	IF(_Validate.date.fIsValid((STRING)L.dt_first_seen), L.dt_first_seen, 0);
			SELF.dt_last_seen							:=	IF(_Validate.date.fIsValid((STRING)L.dt_last_seen), L.dt_last_seen, 0);
			SELF.dt_vendor_first_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_first_reported), L.dt_vendor_first_reported, 0);
			SELF.dt_vendor_last_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_last_reported), L.dt_vendor_last_reported, 0);
			SELF.record_type              :=  L.rec_type;
			SELF.record_date							:=	L.processdate;
			SELF 													:=	L;
			SELF 													:=	[];
		END;

		Industry := PROJECT(asIndustryBase(name_sequence=1),MapIndustry(LEFT));

Industry_sort := SORT(Industry(siccode <> '' OR naics <> '' OR industry_description <> '' OR business_description <> '')
	,bdid 										
	,bdid_score								
	,source       						
	,source_docid  						
	,source_rec_id            
	,siccode       						
	,naics        						
	,industry_description 		
	,business_description 		
	,dt_first_seen						
	,dt_last_seen							
	,dt_vendor_first_reported	
	,dt_vendor_last_reported	
	,record_type							
	,record_date							
	,UltID										
  ,OrgID										
  ,SELEID										
  ,ProxID										
  ,POWID										
  ,EmpID										
  ,DotID										
  ,UltScore									
  ,OrgScore									
  ,SELEScore								
  ,ProxScore								
  ,POWScore									
  ,EmpScore									
  ,DotScore									
  ,UltWeight								
  ,OrgWeight								
  ,SELEWeight								
  ,ProxWeight								
  ,POWWeight								
  ,EmpWeight								
  ,DotWeight										
	,LOCAL);

Industry_dedup := DEDUP(Industry_sort
	,bdid 										
	,bdid_score								
	,source       						
	,source_docid  						
	,source_rec_id            
	,siccode       						
	,naics        						
	,industry_description 		
	,business_description 		
	,dt_first_seen						
	,dt_last_seen							
	,dt_vendor_first_reported	
	,dt_vendor_last_reported	
	,record_type							
	,record_date							
	,UltID										
  ,OrgID										
  ,SELEID										
  ,ProxID										
  ,POWID										
  ,EmpID										
  ,DotID										
  ,UltScore									
  ,OrgScore									
  ,SELEScore								
  ,ProxScore								
  ,POWScore									
  ,EmpScore									
  ,DotScore									
  ,UltWeight								
  ,OrgWeight								
  ,SELEWeight								
  ,ProxWeight								
  ,POWWeight								
  ,EmpWeight								
  ,DotWeight								
	,LOCAL): persist('~thor_data400::persist::cortera::As_Industry', REFRESH(TRUE), SINGLE);
	
RETURN Industry_dedup;

END;