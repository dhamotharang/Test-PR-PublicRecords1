IMPORT ADDRESS_ATTRIBUTES, doxie, LN_PROPERTYV2, UT;

//Business Header SEC RANGE Counts
Address_Attributes.Layouts.BIP_RISK getBIPCounts(PRTE2_BIPV2_BusHeader.file_BIP_base l, PRTE2_BIPV2_BusHeader.file_BIP_count r) := TRANSFORM
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
	SELF.cnp_name		 := l.cnp_name;
	SELF.cnp_fein		 := l.cnp_fein;
	SELF.cnp_phone	 := l.cnp_phone;
	SELF.cnp_status  := l.cnp_status;
	SELF.powid 			 := l.powid;
	SELF.company_org_structure_derived := l.company_org_structure_derived;
	SELF := r;
	SELF := l;
	SELF := [];
END;
BIP_Count := JOIN(PRTE2_BIPV2_BusHeader.file_BIP_base, PRTE2_BIPV2_BusHeader.file_BIP_count,
		LEFT.zip 				 = RIGHT.zip AND
		LEFT.prim_range  = RIGHT.prim_range AND 
		LEFT.prim_name 	 = RIGHT.prim_name AND 
		LEFT.addr_suffix = RIGHT.addr_suffix AND 
		LEFT.predir 		 = RIGHT.predir AND
		LEFT.postdir	 	 = RIGHT.postdir AND
		LEFT.sec_range 	 = RIGHT.sec_range,  
		getBIPCounts(LEFT, RIGHT),LEFT OUTER,KEEP(1),HASH);
		
//Rollup Business Header PRIM RANGE Counts
d_sec_count := DISTRIBUTE(PRTE2_BIPV2_BusHeader.file_BIP_count, HASH32(zip,prim_range,prim_name,addr_suffix,predir,postdir));
Address_Attributes.Layouts.BIP_COUNT rollBizPrim( Address_Attributes.Layouts.BIP_COUNT l, Address_Attributes.Layouts.BIP_COUNT r ) := TRANSFORM
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
	SELF.HIFCA_cnt			 			:= l.HIFCA_cnt + r.HIFCA_cnt;
	SELF.BANK_cnt			 	 			:= l.BANK_cnt + r.BANK_cnt;  
	SELF.llc_cnt		 					:= l.llc_cnt + r.llc_cnt;
	SELF.trust_cnt		 				:= l.trust_cnt + r.trust_cnt;
	SELF.holding_co_cnt				:= l.holding_co_cnt + r.holding_co_cnt;
	SELF.corp_cnt		 					:= l.corp_cnt + r.corp_cnt;
	SELF.no_fein_cnt		 			:= l.no_fein_cnt + r.no_fein_cnt;
	SELF.HR_SIC_cnt		   			:= l.HR_SIC_cnt + r.HR_SIC_cnt;
	SELF.LGL_SIC_cnt 		 			:= l.LGL_SIC_cnt + r.LGL_SIC_cnt;	
	SELF.BIZ_CNT 							:= IF(l.undel_sec_cnt = 0 AND r.undel_sec_cnt = 0, l.BIZ_CNT + r.BIZ_CNT, l.BIZ_CNT);
	SELF.biz_use_cnt 		 			:= l.biz_use_cnt + r.biz_use_cnt;
	SELF.vacant_cnt			 			:= l.vacant_cnt + r.vacant_cnt;
	SELF.dnd_cnt 			 	 			:= l.dnd_cnt + r.dnd_cnt;	
  SELF.drop_cnt 			 			:= l.drop_cnt + r.drop_cnt;	
	SELF.NIS_cnt			 	 			:= l.NIS_cnt + r.NIS_cnt; 
	SELF.CR_RPR_cnt			 			:= l.CR_RPR_cnt + r.CR_RPR_cnt; 
	SELF.priv_post_cnt	 			:= l.priv_post_cnt + r.priv_post_cnt; 
	SELF.storage_cnt  	 			:= l.storage_cnt + r.storage_cnt; 
	SELF.deliverable_cnt 			:= l.deliverable_cnt + r.deliverable_cnt;
	SELF.undel_sec_cnt 	 			:= l.undel_sec_cnt + r.undel_sec_cnt;
	SELF.biz_at_undel_sec_cnt := IF(l.undel_sec_cnt = 0, r.BIZ_CNT, + l.biz_at_undel_sec_cnt + r.BIZ_CNT);
	SELF := l;
END;
	
prim_roll := ROLLUP(SORT(d_sec_count, zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range, LOCAL), 
		LEFT.zip 				 = RIGHT.zip AND
		LEFT.prim_range  = RIGHT.prim_range AND 
		LEFT.prim_name 	 = RIGHT.prim_name AND 
		LEFT.addr_suffix = RIGHT.addr_suffix AND 
		LEFT.predir 		 = RIGHT.predir AND
		LEFT.postdir 		 = RIGHT.postdir,
	rollBizPrim(LEFT, RIGHT), LOCAL);


//Business Header PRIM RANGE Counts
Address_Attributes.Layouts.BIP_RISK getPRIMCounts(BIP_Count l, prim_roll r) := TRANSFORM
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

	SELF.prim_naics_risk_high_cnt := r.naics_risk_high_cnt;
	SELF.prim_naics_risk_med_cnt := r.naics_risk_med_cnt;
	SELF.prim_naics_risk_low_cnt := r.naics_risk_low_cnt;
	SELF.prim_inc_st_tight_cnt := r.inc_st_tight_cnt;
	SELF.prim_inc_st_loose_cnt := r.inc_st_loose_cnt;
	SELF.prim_HIFCA_cnt := r.HIFCA_cnt;
	SELF.prim_BANK_cnt := r.BANK_cnt;
	SELF.prim_llc_cnt := r.llc_cnt;
	SELF.prim_trust_cnt := r.trust_cnt;
	SELF.prim_holding_co_cnt := r.holding_co_cnt;
	SELF.prim_corp_cnt := r.corp_cnt;
	SELF.prim_no_fein_cnt := r.no_fein_cnt;
	SELF.prim_HR_SIC_cnt := r.HR_SIC_cnt;
	SELF.prim_LGL_SIC_cnt := r.LGL_SIC_cnt;
	SELF.prim_BIZ_CNT := r.BIZ_CNT;
	SELF.prim_biz_use_cnt := r.biz_use_cnt;
	SELF.prim_vacant_cnt := r.vacant_cnt;
	SELF.prim_dnd_cnt := r.dnd_cnt;
	SELF.prim_drop_cnt := r.drop_cnt; 
	SELF.prim_NIS_cnt := r.NIS_cnt;
	SELF.prim_CR_RPR_cnt := r.CR_RPR_cnt;
	SELF.prim_priv_post_cnt := r.priv_post_cnt;
	SELF.prim_storage_cnt := r.storage_cnt;
	SELF.prim_deliverable_cnt := r.deliverable_cnt;
	SELF.prim_undel_sec_cnt := r.undel_sec_cnt;
	SELF.prim_biz_at_undel_sec_cnt := r.biz_at_undel_sec_cnt;
	SELF := l;
END;
BIP_Prim_Count := JOIN(BIP_Count, prim_roll,
		LEFT.zip 				 = RIGHT.zip AND
		LEFT.prim_range  = RIGHT.prim_range AND 
		LEFT.prim_name 	 = RIGHT.prim_name AND 
		LEFT.addr_suffix = RIGHT.addr_suffix AND 
		LEFT.predir 		 = RIGHT.predir AND
		LEFT.postdir	 	 = RIGHT.postdir,  
		getPRIMCounts(LEFT, RIGHT),LEFT OUTER,KEEP(1),HASH);
		

//Property Attributes
//PROP_base := PULL(LN_PropertyV2.Key_Prop_Address_V4);
PROP_base := PULL(index(LN_PropertyV2.Key_Prop_Address_V4, '~prte::key::ln_propertyv2::' + doxie.Version_SuperKey + '::addr.full_v4'));
Address_Attributes.Layouts.BIP_RISK addProperty(BIP_Prim_Count l, PROP_base r) := transform
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
	
	SELF.occupant_owned := r.occupant_owned;
	SELF.building_area 	:= r.building_area;
	SELF.ID_to_sqft_ratio := if(r.building_area <> 0, r.building_area / l.biz_cnt, 0);
	SELF.prop_sfd := if(r.building_area > 0, Address_Attributes.functions.getSFD(r.standardized_land_use_code), FALSE);
	SELF := l;
end;

with_Prop := JOIN(BIP_Prim_Count, PROP_base,
	LEFT.prim_range  = RIGHT.prim_range AND
	LEFT.prim_name   = RIGHT.prim_name AND
	LEFT.sec_range   = RIGHT.sec_range AND
	LEFT.zip 				 = RIGHT.zip AND
	LEFT.addr_suffix = RIGHT.suffix AND
	LEFT.predir 		 = RIGHT.predir AND
	LEFT.postdir 		 = RIGHT.postdir,
	addProperty(LEFT, RIGHT),LEFT OUTER,KEEP(1),HASH);


//DNB business and address aggregates
Address_Attributes.Layouts.BIP_RISK joinDNBFlags(with_Prop l, PRTE2_BIPV2_BusHeader.file_BIP_dnb r) := TRANSFORM
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

	self.dnb_business_cnt 			:= r.business_cnt;
	self.dnb_active_duns_cnt 		:= r.active_duns_cnt;
	self.dnb_mailAID_ne_rawAID 	:= r.mailAID_ne_rawAID;
	self.dnb_employee_cnt 			:= r.employee_cnt;
	self.dnb_employee_tot_cnt 	:= r.employee_tot_cnt;
	self.dnb_employee_cnt_lt3 	:= r.employee_cnt_lt3;
	self.dnb_small_biz_cnt 			:= r.small_biz_cnt;
	self.dnb_public_co_cnt 			:= r.public_co_cnt;
	self.dnb_foreign_own_cnt 		:= r.foreign_own_cnt;
	self.dnb_holding_co_cnt 		:= r.holding_co_cnt;
	self.dnb_owns_cnt 					:= r.owns_cnt;
	self.dnb_rents_cnt 					:= r.rents_cnt;
	self.dnb_zero_sales_cnt 		:= r.zero_sales_cnt;

	self.industry_group 							:= r.industry_group;
	self.year_started 								:= r.year_started;
	self.date_of_incorporation 				:= r.date_of_incorporation;
	self.state_of_incorporation_abbr	:= r.state_of_incorporation_abbr;
	self.annual_sales_volume 					:= r.annual_sales_volume;
	self.annual_sales_code 						:= r.annual_sales_code;
	self.employees_here 							:= r.employees_here;
	self.employees_total 							:= r.employees_total;
	self.owns_rents 									:= r.owns_rents;
	self.small_business_indicator 		:= r.small_business_indicator;
	self.cottage_indicator 						:= r.cottage_indicator;
	self.foreign_owned 								:= r.foreign_owned;
	self.public_indicator 						:= r.public_indicator;
	self.manufacturing_here_indicator	:= r.manufacturing_here_indicator;
	self.parent_company_name 					:= r.parent_company_name;
	self.ultimate_company_name 				:= r.ultimate_company_name;
	self.ultimate_indicator 					:= r.ultimate_indicator;																																							
	self.active_duns_number 					:= r.active_duns_number;

	SELF := l;
END;

with_DNB := JOIN(with_Prop, PRTE2_BIPV2_BusHeader.file_BIP_dnb,		
		LEFT.zip 				 = RIGHT.zip AND
		LEFT.prim_range  = RIGHT.prim_range AND 
		LEFT.prim_name 	 = RIGHT.prim_name AND 
		LEFT.addr_suffix = RIGHT.addr_suffix AND 
		LEFT.predir 		 = RIGHT.predir AND
		LEFT.postdir 		 = RIGHT.postdir AND
		LEFT.sec_range 	 = RIGHT.sec_range, 
	joinDNBFlags(LEFT,RIGHT),LEFT OUTER,KEEP(1),HASH);



//Header LexID Aggregation
Address_Attributes.Layouts.BIP_RISK addVelocity(with_DNB l, PRTE2_BIPV2_BusHeader.file_address_velocity r) := TRANSFORM
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
	SELF := r;
	SELF := l;
END;

w_velocity := JOIN(with_DNB, PRTE2_BIPV2_BusHeader.file_address_velocity,
	LEFT.zip 					= RIGHT.zip AND
	LEFT.prim_range 	= RIGHT.prim_range AND
	LEFT.prim_name 		= RIGHT.prim_name AND
	LEFT.addr_suffix 	= RIGHT.suffix AND
	LEFT.predir 			= RIGHT.predir AND
	LEFT.postdir 		  = RIGHT.postdir AND
	LEFT.sec_range 	  = RIGHT.sec_range,
	addVelocity(LEFT, RIGHT),LEFT OUTER,KEEP(1),HASH);



//Final classification
d_velocity := DISTRIBUTE(w_velocity,HASH(POWID));
Address_Attributes.Layouts.BIP_RISK classFinal(d_velocity l) := TRANSFORM
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
	
	calc_remailer := MAP(l.storage > 0									=> TRUE,
										   l.undel_sec > 5 								=> TRUE,
										   l.drop_cnt > 0									=> TRUE,
										   l.biz_cnt_at_undel_sec > 5			=> TRUE, FALSE);
	rsn_remailer  := MAP(l.storage > 0									=> 'STOR',
										   l.undel_sec > 5 								=> 'UDSC',
										   l.drop_cnt > 0									=> 'DROP',
										   l.biz_cnt_at_undel_sec > 5			=> 'UDBZ', 'NONE');	

	//NIS requires a legal entity to be present at the non-residential location AND the registered businesses over 1000											 
	calc_NIS := MAP(((l.LGL_SIC > 0 OR l.nis > 0) AND (l.addr_type IN ['', '0'] AND NOT l.prop_sfd)) 													=> TRUE,
									((l.LGL_SIC > 0 OR l.nis > 0) AND l.biz_cnt > 500 AND (l.building_area <> 0 AND l.ID_to_sqft_ratio < 50)) => TRUE, FALSE);	
	rsn_NIS  := MAP(((l.LGL_SIC > 0 OR l.nis > 0) AND (l.addr_type IN ['', '0'] AND NOT l.prop_sfd)) 													=> 'BLDG',
									((l.LGL_SIC > 0 OR l.nis > 0) AND l.biz_cnt > 500 AND (l.building_area <> 0 AND l.ID_to_sqft_ratio < 50)) => 'BZCT', 'NONE');
									
	//A NIS at an SFD : ADVO <> SFD or LN Prod <> SFD AND sqft < 50 per bdid (median is 250 sqft)
	calc_shelf := MAP(((l.addr_type  = '1' OR  l.prop_sfd) AND l.building_area <> 0 AND l.ID_to_sqft_ratio < 50 AND l.drop = 1) => TRUE,  		
										((l.addr_type  = '1' OR  l.prop_sfd) AND calc_nis)  											 	=> TRUE, //second rule of calc_NIS
										((l.addr_type  = '1' OR  l.prop_sfd) AND l.biz_cnt > 20 AND l.drop = 1)  		=> TRUE,
										((l.addr_type  = '1' OR  l.prop_sfd) AND l.undel_sec > 3 AND l.drop = 1) 		=> TRUE,
											l.undel_sec >= 10 AND l.drop = 1 																			 		=> TRUE, FALSE);	 
	rsn_shelf  := MAP(((l.addr_type  = '1' OR  l.prop_sfd) AND l.building_area <> 0 AND l.ID_to_sqft_ratio < 50 AND l.drop = 1) => 'RTIO',  		
										((l.addr_type  = '1' OR  l.prop_sfd) AND calc_nis)  											 	=> 'NIS', //second rule of calc_NIS
										((l.addr_type  = '1' OR  l.prop_sfd) AND l.biz_cnt > 20 AND l.drop = 1)  		=> 'BZDR',
										((l.addr_type  = '1' OR  l.prop_sfd) AND l.undel_sec > 3 AND l.drop = 1) 		=> 'USDR',
											l.undel_sec >= 10 AND l.drop = 1 																			 		=> 'UDSR', 'NONE');	
											
	//Not public, few employees, no manufacturing, high seleID density at an address with no NIC present,
	//not a bank (they can serve as a NIC) 
	calc_shell := IF (l.NIS_cnt = 0 AND 
										l.manufacturing_here_indicator <> 'Y' AND 
										l.public_indicator <> 'Y' AND 
										l.bank = 0 AND
										// l.holding_co_cnt < 3 AND 
										(l.dnb_employee_cnt_lt3 < 3 AND l.dnb_employee_cnt_lt3 > 0) AND
										// (l.dnb_zero_sales_cnt < 3 AND l.dnb_zero_sales_cnt > 0) AND
										// (INTEGER)l.employees_here > 3 AND
										(l.biz_cnt > 500 AND l.ID_to_sqft_ratio < 50 AND l.building_area <> 0),TRUE, FALSE);
																			
	//Finish indicators
	SELF.potential_remail := calc_remailer;
	SELF.remail_reason 		:= rsn_remailer;
	SELF.potential_shelf	:= calc_shelf;
	SELF.shelf_reason			:= rsn_shelf;
	SELF.potential_NIS 		:= calc_NIS;
	SELF.nis_reason 			:= rsn_NIS;
	SELF.potential_shell	:= calc_shell;
	
	//Shell score
	not_bank := IF(l.bank = 0, 1, 0);
	fein := IF(l.no_fein = 0, 1, 0);
	not_public := IF(l.public_indicator <> 'Y', 1, 0);
	is_public  := IF(l.public_indicator =  'Y', 1, 0);
	is_nis := IF(calc_nis, 1, 0);
	is_shelf := IF(calc_shelf, 1, 0);
	is_remailer := IF(calc_remailer, 1, 0);
	manufact := IF(l.manufacturing_here_indicator = 'Y', 1, 0);

	naics_score := IF(l.naics_risk_high > 0 OR l.hr_sic > 0, 1, 0);
	
	high_risk 			 := l.undel_sec + l.nis + l.inc_st_loose + l.hifca + naics_score + not_bank + not_public + is_nis + is_remailer + l.storage + l.priv_post;
	low_risk 				 := l.bank + is_public + manufact + fein + l.inc_st_tight; 
	SELF.shell_score := MAP(high_risk - low_risk =-1 => 1,
													high_risk - low_risk = 0 => 1,
													high_risk - low_risk = 1 => 2,
													high_risk - low_risk = 2 => 3,
													high_risk - low_risk = 3 => 4,
													high_risk - low_risk = 4 => 5,
													high_risk - low_risk = 5 => 6,
													high_risk - low_risk = 6 => 7,
													high_risk - low_risk = 7 => 8,
													9);
	SELF := l;
END;

final := PROJECT(d_velocity, classFinal(LEFT),LOCAL);


EXPORT file_BIP_risk := final;