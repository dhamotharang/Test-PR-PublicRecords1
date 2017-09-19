import did_add,fair_isaac,didville,ut,header_slimsort,watchdog, Business_Header, Business_Header_SS,OSHAIR, Census_Data, lib_stringlib, address, mdr, BIPV2, _validate;

export Clean_OSHAIR_data (string filedate, string process_date) := function

/*	
		Abbreviations of relevance:
		IMIS    - Integrated Management Information System
		DRVD    - Derived file
		b       - Means blank (empty field)
		DCA     - Debt Collection Agency, under contract of OSHA
		FTA     - Failure to Abate
		FAT/CAT - Fatality and/or Catastrophe - definition of catastrophe:
												Federal OSHA: 5 or more hospitalized injuries
												State   OSHA: Definitions vary
		ID      - Identification, usually not purely numeric
		MIS     - Old Management Information System, national office only
		NR/Nr   - Number
		SIC     - Standard Industrial Classification
		NAICS   - North American Industrial Classification System
		SOL     - OSHA SOLicitor, or, Office of an OSHA Solicitor
		State   - Usually identifies that group of approximately twenty-seven (27) states
				  that have their own OSH Haz_Sub plan approved Federal OSHA under authority
				  of the OSHA Act, paragraph 18(b)
		VIO     - Violation - Note that initially violations are alleged.  After certain procedures
				  have been completed, the alleged status is removed.
*/

layout_cleaned := record
  unsigned4 dt_first_seen						 := 0;
	unsigned4 dt_last_seen						 := 0;
	unsigned4 dt_vendor_first_reported := 0;
	unsigned4 dt_vendor_last_reported	 := 0;
  bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
	unsigned8 source_rec_id := 0; //Added for BIP project	
	string2 source := '';
  OSHAIR.layout_OSHAIR_inspection_clean;
end; 

layout_cleaned trfInspectionMapped(Layouts_input.Inspection L) := TRANSFORM

  string182 cleanaddress := 
				Address.CleanAddress182(l.Site_Address, l.site_city + ', ' + l.Site_State + ' ' + INTFORMAT((INTEGER)l.Site_Zip,5,1));
	self.dt_first_seen 											:=  (unsigned4)process_date;
	self.dt_last_seen  											:=  (unsigned4)process_date;
	self.dt_vendor_first_reported 					:=  (unsigned4)process_date;
	self.dt_vendor_last_reported 						:=  (unsigned4)process_date;
	self.activity_number										:=	(integer)l.activity_nr;
	self.region_code												:=	l.reporting_id[1..2];
	self.area_code													:=	l.reporting_id[3..5];
	self.office_code												:=	l.reporting_id[6..7];	
	self.fed_state_flag											:=	l.state_flag;
	self.inspected_site_name								:=	ut.CleanSpacesAndUpper(l.estab_name);
	self.inspected_site_street							:=	ut.CleanSpacesAndUpper(l.site_address);
	self.inspected_site_state								:=	ut.CleanSpacesAndUpper(l.site_state);
	self.inspected_site_zip									:=	(integer)l.site_zip;
	self.host_establishment_key							:=	if (ut.CleanSpacesAndUpper(l.host_est_key) != 'HOST_EST_KEY_VALU', l.host_est_key, '');
	self.advance_notice_flag								:=	l.adv_notice;
	self.Inspected_Site_City_Name     			:= 	ut.CleanSpacesAndUpper(l.site_city);	
	self.inspection_opening_date						:=	if (_validate.date.fIsValid(StringLib.StringFindReplace(l.open_date,'-','')), 
																											(integer)StringLib.StringFindReplace(l.open_date,'-',''), 
																											0
																									);
	self.inspection_close_Date							:=	if (_validate.date.fIsValid(StringLib.StringFindReplace(l.close_conf_date,'-','')), 
																											(integer)StringLib.StringFindReplace(l.close_conf_date,'-',''), 
																											0
																									);
	self.close_case_date										:=	if (_validate.date.fIsValid(StringLib.StringFindReplace(l.close_case_date,'-','')), 
																											(integer)StringLib.StringFindReplace(l.close_case_date,'-',''), 
																											0
																									);
	self.Safety_Health_Flag									:=	l.safety_hlth;
	self.inspection_type										:=	l.insp_type;
	self.inspection_scope										:=	l.insp_scope;
	self.number_in_establishment						:=	(integer)l.nr_in_estab;
	// self.union_flag													:=	l.union_status;
	self.why_no_inspection_code							:=	l.why_no_insp;
	self.safety_pg_manufacturing_insp_flag	:=	l.safety_manuf;
	self.safety_pg_construction_insp_flag		:=	l.safety_const;
	self.safety_pg_maritime_insp_flag				:=	l.safety_marit;
	self.health_pg_manufacturing_insp_flag	:=	l.health_manuf;
	self.health_pg_construction_insp_flag		:=	l.health_const;
	self.health_pg_maritime_insp_flag				:=	l.health_marit;
	self.migrant_farm_insp_flag							:=	l.migrant;
	self.source                       			:= 	mdr.sourceTools.src_OSHAIR;													 
	self.Own_Type_Desc                			:= 	OSHAIR.lookup_OSHAIR_Mini.Owner_Type_lookup(L.Owner_Type);
	self.Insp_Type_Desc               			:= 	OSHAIR.lookup_OSHAIR_Mini.Inspection_Type_lookup(L.Insp_Type);
	self.Insp_Scope_Desc              			:= 	OSHAIR.lookup_OSHAIR_Mini.Inspection_Scope_lookup(L.Insp_Scope);
	self.cname                        			:= 	ut.CleanSpacesAndUpper(l.estab_name);
	self.SIC_Code                     			:= 	(integer)l.SIC_Code;
  self.prim_range                   			:= 	cleanaddress[1..10];
	self.predir 	                   				:= 	cleanaddress[11..12];
	self.prim_name 	  	              			:= 	cleanaddress[13..40];
	self.addr_suffix  	              			:= 	cleanaddress[41..44];
	self.postdir 	    	              			:= 	cleanaddress[45..46];
	self.unit_desig   	              			:= 	cleanaddress[47..56];
	self.sec_range 	  	              			:= 	cleanaddress[57..64];
	self.p_city_name  	              			:= 	cleanaddress[65..89];
	self.v_city_name  	              			:= 	cleanaddress[90..114];
	self.st 	     		                			:= 	cleanaddress[115..116];
	self.zip5 		           	        			:= 	cleanaddress[117..121];
	self.zip4 		    	              			:= 	cleanaddress[122..125];
	self.cart      		    	          			:= 	cleanaddress[126..129];
	self.cr_sort_sz        	          			:= 	cleanaddress[130];
	self.lot 		           	          			:= 	cleanaddress[131..134];
	self.lot_order 	  	              			:= 	cleanaddress[135];
	self.dpbc      		    	          			:= 	cleanaddress[136..137];
	self.chk_digit      	  	        			:= 	cleanaddress[138];
	self.addr_rec_type  	            			:= 	cleanaddress[139..140];
	self.fips_state                   			:= 	cleanaddress[141..142];
	self.fips_county                  			:= 	cleanaddress[143..145];
	self.geo_lat 	    	              			:= 	cleanaddress[146..155];
	self.geo_long 	  	              			:= 	cleanaddress[156..166];
	self.cbsa 		      	            			:= 	cleanaddress[167..170];
	self.geo_blk   	  	              			:= 	cleanaddress[171..177];
	self.geo_match 	  	              			:= 	cleanaddress[178];
	self.err_stat 	  	              			:= 	cleanaddress[179..182];
	self.source_rec_id                			:= 	HASH64(l.activity_nr + l.estab_name + l.site_address + l.SIC_CODE + l.Site_Zip);
	self.owner_code													:=	(integer)l.owner_code;
	self                              			:= 	l;
	self																		:= 	[];
end;

InspectionMapped	:=	project(oshair.files().input.Inspection.sprayed, trfInspectionMapped(left));

BaseWithSource		:=	project(OSHAIR.file_out_inspection_cleaned_both,
													TRANSFORM(layout_cleaned,
																		self.source := mdr.sourceTools.src_OSHAIR;
																		self.bdid	:= 0;
																		self.BDID_score	:= 0;
																		self := left;));

InspectionAll			:=	InspectionMapped + BaseWithSource;

BDID_Matchset 		:= 	['A'];

Business_Header_SS.MAC_Add_BDID_Flex(InspectionAll       		  // Input Dataset
                                     ,BDID_Matchset           // BDID Matchset
                                     ,cname                   // company_name
                                     ,prim_range              // prim_range
																		 ,prim_name               // prim_name
																		 ,zip5                    // zip5
                                     ,sec_range               // sec_range
																		 ,st                      // state
                                     ,''                      // phone
																		 ,fein_append             // fein
                                     ,bdid                    // bdid
																		 ,layout_cleaned          // Output Layout
                                     ,TRUE                    // output layout has bdid score field?
																		 ,BDID_Score              // bdid_score
                                     ,OSHAIR_bdid_match       // Output Dataset   
	                                   ,												// deafult threscold
	                                   ,											  // use prod version of superfiles
                                     ,												// default is to hit prod from dataland, and on prod hit prod.		
	                                   ,BIPV2.xlink_version_set // Create BIP Keys only
	                                   ,           					   	// Url
	                                   ,								        // Email
	                                   ,p_city_name			    		// City
	                                   ,              		      // fname
                                     ,              	      	// mname
	                                   ,              	        // lname
  																	 ,                        // contact_ssn
																		 ,source								  // source - MDR.sourceTools
																		 ,source_rec_id           // source_record_id
																		 ,FALSE                   // src_matching_is_priority
                                     );

																		 
Business_Header_SS.MAC_Add_FEIN_By_BDID(OSHAIR_bdid_match
																				,BDID
																				,FEIN_append
																				,OSHAIR_out_add_fein);
 
OSHAIR_out_add_fein2 := distribute(PROJECT(OSHAIR_out_add_fein,OSHAIR.layout_OSHAIR_inspection_clean_BIP),hash32(Activity_Number));

OSHAIR.layout_OSHAIR_inspection_clean_BIP RollupInspection(OSHAIR.layout_OSHAIR_inspection_clean_BIP l, OSHAIR.layout_OSHAIR_inspection_clean_BIP r) := transform
  self.dt_first_seen  := ut.EarliestDate(l.dt_first_seen ,r.dt_first_seen	);  
	self.dt_last_seen 	:= ut.LatestDate  (l.dt_last_seen	 ,r.dt_last_seen	);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);	
  self.dt_vendor_last_reported 	:= ut.LatestDate	(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
	self := l;
end;

srtOSHAIR	:=	sort(OSHAIR_out_add_fein2,activity_number,source_rec_id, record, 
												except dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported,
													BDID_score, DotScore, DotWeight, EmpScore, EmpWeight,	POWScore, POWWeight, ProxScore, 
													ProxWeight, SeleScore, SeleWeight, OrgScore, OrgWeight, UltScore, UltWeight, local);

InspectionRollup := rollup(srtOSHAIR, RollupInspection(left, right), record 
												,except dt_first_seen, dt_last_seen, 
															  dt_vendor_first_reported, dt_vendor_last_reported,
															  BDID_score, DotScore, DotWeight, EmpScore, EmpWeight,	
															  POWScore, POWWeight, ProxScore, ProxWeight, SeleScore,
															  SeleWeight, OrgScore, OrgWeight, UltScore, UltWeight
												,local);

/* Generate the other OSHA base files */
OSHAIR.normalize_child_datasets(filedate, process_date);

return output(InspectionRollup,,'~thor_data400::base::oshair::' + filedate + '::inspection',compressed, overwrite);
						  
end;





				
			