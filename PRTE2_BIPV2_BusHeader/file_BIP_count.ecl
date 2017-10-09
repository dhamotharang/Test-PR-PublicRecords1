IMPORT ADDRESS_ATTRIBUTES, UT;

//DATA DECLARATIONS
ds := DISTRIBUTE(PRTE2_BIPV2_BusHeader.file_BIP_base, HASH(POWID));

//MAP BIP ATTRIBUTES
Address_Attributes.Layouts.BIP_COUNT addBizCnt(ds l) := TRANSFORM
		SELF.zip 					:= l.zip;
		SELF.prim_range 	:= l.prim_range;
		SELF.prim_name 		:= l.prim_name;
		SELF.addr_suffix 	:= l.addr_suffix;
		SELF.predir 			:= l.predir;
		SELF.postdir 			:= l.postdir;
		SELF.unit_desig 	:= l.unit_desig;
		SELF.sec_range 		:= l.sec_range;
		SELF.city 				:= l.city;
		SELF.st 					:= l.st;
		SELF.zip4 				:= l.zip4;
		SELF.geo_blk 			:= l.geo_blk;
		SELF.geolink 			:= l.geolink;
		SELF.streetlink 	:= l.streetlink;
		SELF.county 			:= l.county;
		SELF.msa 					:= l.msa;
		SELF.geo_lat 			:= l.geo_lat;
		SELF.geo_long 		:= l.geo_long;
		
		SELF.biz_cnt	 						:= l.biz_cnt;
		SELF.naics_risk_high_cnt 	:= l.naics_risk_high;
		SELF.naics_risk_med_cnt	 	:= l.naics_risk_med;
		SELF.naics_risk_low_cnt	 	:= l.naics_risk_low;
		SELF.inc_st_tight_cnt	 		:= l.inc_st_tight;
		SELF.inc_st_loose_cnt	 		:= l.inc_st_loose;
		SELF.hifca_cnt	 					:= l.hifca;
		SELF.nis_cnt	 						:= l.nis;
		SELF.cr_rpr_cnt	 					:= l.cr_rpr;
		SELF.bank_cnt	 						:= l.bank;
		SELF.llc_cnt	 						:= l.llc;
		SELF.trust_cnt	 					:= l.trust;
		SELF.holding_co_cnt	 			:= l.holding_co;
		SELF.corp_cnt	 						:= l.corp;
		SELF.no_fein_cnt	 				:= l.no_fein;
		SELF.hr_sic_cnt	 					:= l.hr_sic;
		SELF.lgl_sic_cnt	 				:= l.lgl_sic;
		SELF.storage_cnt	 				:= l.storage;
		SELF.priv_post_cnt	 			:= l.priv_post;
		
		SELF.addr_type	 		 := l.addr_type;
		SELF.biz_use_cnt 		 := l.biz_use;
		SELF.dnd_cnt 				 := l.dnd;
		SELF.vacant_cnt			 := l.vacant;
		SELF.rural_cnt 			 := l.rural;
		SELF.owgm_cnt 			 := l.owgm;
		SELF.drop_cnt			 	 := l.drop;
		SELF.deliverable_cnt := l.deliverable;
		SELF.undel_sec_cnt	 := l.undel_sec;
		SELF := [];
END;
base_counts := PROJECT(ds, addBizCnt(LEFT),LOCAL);

//ROLLUP COUNTS TO SEC RANGE
d_biz_count := DISTRIBUTE(base_counts, HASH64(zip,prim_range,prim_name,addr_suffix,predir,postdir,sec_range));
Address_Attributes.Layouts.BIP_COUNT rollBiz( Address_Attributes.Layouts.BIP_COUNT l, Address_Attributes.Layouts.BIP_COUNT r ) := TRANSFORM
	SELF.zip 					:= l.zip;
	SELF.prim_range 	:= l.prim_range;
	SELF.prim_name 		:= l.prim_name;
	SELF.addr_suffix 	:= l.addr_suffix;
	SELF.predir 			:= l.predir;
	SELF.postdir 			:= l.postdir;
	SELF.unit_desig 	:= l.unit_desig;
	SELF.sec_range 		:= l.sec_range;
	SELF.city 				:= l.city;
	SELF.st 					:= l.st;
	SELF.zip4 				:= l.zip4;
	SELF.geo_blk 			:= l.geo_blk;
	SELF.geolink 			:= l.geolink;
	SELF.streetlink 	:= l.streetlink;
	SELF.county 			:= l.county;
	SELF.msa 					:= l.msa;
	SELF.geo_lat 			:= l.geo_lat;
	SELF.geo_long 		:= l.geo_long;

	SELF.naics_risk_high_cnt	:= l.naics_risk_high_cnt + r.naics_risk_high_cnt;
	SELF.naics_risk_med_cnt		:= l.naics_risk_med_cnt + r.naics_risk_med_cnt;
	SELF.naics_risk_low_cnt		:= l.naics_risk_low_cnt + r.naics_risk_low_cnt;
	SELF.inc_st_tight_cnt			:= l.inc_st_tight_cnt + r.inc_st_tight_cnt;
	SELF.inc_st_loose_cnt			:= l.inc_st_loose_cnt + r.inc_st_loose_cnt;
	SELF.llc_cnt		 					:= l.llc_cnt + r.llc_cnt;
	SELF.trust_cnt		 				:= l.trust_cnt + r.trust_cnt;
	SELF.holding_co_cnt				:= l.holding_co_cnt + r.holding_co_cnt;
	SELF.corp_cnt	 					  := l.corp_cnt + r.corp_cnt;
	SELF.no_fein_cnt		 			:= l.no_fein_cnt + r.no_fein_cnt;
	SELF.BIZ_CNT		 		 			:= l.BIZ_CNT + r.BIZ_CNT; 
	SELF.HIFCA_cnt			 			:= l.HIFCA_cnt + r.HIFCA_cnt; 
	SELF.NIS_cnt			 	 			:= l.NIS_cnt + r.NIS_cnt; 
	SELF.CR_RPR_cnt			 			:= l.CR_RPR_cnt + r.CR_RPR_cnt; 
	SELF.BANK_cnt			 	 			:= l.BANK_cnt + r.BANK_cnt; 
	SELF.priv_post_cnt	 			:= l.priv_post_cnt + r.priv_post_cnt; 
	SELF.storage_cnt  	 			:= l.storage_cnt + r.storage_cnt; 
	SELF.HR_SIC_cnt		   			:= l.HR_SIC_cnt + r.HR_SIC_cnt;
	SELF.LGL_SIC_cnt 		 			:= l.LGL_SIC_cnt + r.LGL_SIC_cnt;
	SELF.biz_use_cnt 		 			:= l.biz_use_cnt + r.biz_use_cnt;
	SELF.dnd_cnt 			 	 			:= l.dnd_cnt + r.dnd_cnt;
	SELF.vacant_cnt			 			:= l.vacant_cnt + r.vacant_cnt;
	SELF.rural_cnt 			 			:= l.rural_cnt + r.rural_cnt;
  SELF.owgm_cnt 			 			:= l.owgm_cnt + r.owgm_cnt;
  SELF.drop_cnt 			 			:= l.drop_cnt + r.drop_cnt;
	SELF.deliverable_cnt 			:= l.deliverable_cnt + r.deliverable_cnt;
	SELF.undel_sec_cnt	 			:= IF(r.undel_sec_cnt = 1 AND (l.undel_sec_cnt = 0 OR l.undel_sec_cnt = 1), 1, l.undel_sec_cnt);
	
	SELF := l;
END;
		
final := ROLLUP(SORT(d_biz_count, zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range, LOCAL), 
		LEFT.zip 				 = RIGHT.zip AND
		LEFT.prim_range  = RIGHT.prim_range AND 
		LEFT.prim_name 	 = RIGHT.prim_name AND 
		LEFT.addr_suffix = RIGHT.addr_suffix AND 
		LEFT.predir 		 = RIGHT.predir AND
		LEFT.postdir	 	 = RIGHT.postdir AND
		LEFT.sec_range 	 = RIGHT.sec_range, 
	rollBiz(LEFT,RIGHT), LOCAL);
	
EXPORT file_BIP_count := final;