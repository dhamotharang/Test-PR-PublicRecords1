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

layouts_input.cleaned_inspection trfinspectionmapped(layouts_input.inspection l) := transform

  //Jira--DF-20163:Excluding numerals & "-" from estab_names !!  
	//Pass1: Eliminating WA (plus digits) preceding the business name ex:WA317940156 - HOLADAY PARKS IN
	//Pass2: Eliminating 5 digits or more preceding the business name  //95497 - D - E CONSTRUCTION INC
	Pass1   								 								:=  regexreplace('^WA[0-9]{5,}\\x20+\\x2D+\\x20',ut.CleanSpacesAndUpper(l.estab_name),'');
	Pass2   															  :=  regexreplace('^[0-9]{5,}\\x20+\\x2D+\\x20',Pass1,'');
	self.dt_first_seen 											:=  (unsigned4)process_date;
	self.dt_last_seen  											:=  (unsigned4)process_date;
	self.dt_vendor_first_reported 					:=  (unsigned4)process_date;
	self.dt_vendor_last_reported 						:=  (unsigned4)process_date;
	self.activity_number										:=	(integer)l.activity_nr;
	self.region_code												:=	l.reporting_id[1..2];
	self.area_code													:=	l.reporting_id[3..5];
	self.office_code												:=	l.reporting_id[6..7];	
	self.fed_state_flag											:=	l.state_flag;
	//(Eliminating any number lower than 5 digits not part of this fix -per Rosemary that we will be eliminating too many legitimate business names if we correct fewer than 5 digits!!!)
  //making sure digits** preceding name are not less than 5 digits & also making sure all those are only numeric numbers !!
	self.Inspected_Site_Name								:=  Pass2;
	self.inspected_site_street							:=	ut.CleanSpacesAndUpper(l.site_address);
	self.inspected_site_state								:=	ut.CleanSpacesAndUpper(l.site_state);
	self.inspected_site_zip									:=	(integer)l.site_zip;
	self.host_establishment_key							:=	if (ut.CleanSpacesAndUpper(l.host_est_key) != 'HOST_EST_KEY_VALU', l.host_est_key, '');
	self.advance_notice_flag								:=	l.adv_notice;
	self.Inspected_Site_City_Name     			:= 	ut.CleanSpacesAndUpper(l.site_city);	
	self.inspection_opening_date						:=	if (_validate.date.fIsValid(StringLib.StringFindReplace(l.open_date,'-','')), 
																									(integer)StringLib.StringFindReplace(l.open_date,'-',''),0);
	self.inspection_close_Date							:=	if (_validate.date.fIsValid(StringLib.StringFindReplace(l.close_conf_date,'-','')), 
																									(integer)StringLib.StringFindReplace(l.close_conf_date,'-',''), 0);
	self.close_case_date										:=	if (_validate.date.fIsValid(StringLib.StringFindReplace(l.close_case_date,'-','')), 
																									(integer)StringLib.StringFindReplace(l.close_case_date,'-',''), 0);
	self.Safety_Health_Flag									:=	l.safety_hlth;
	self.inspection_type										:=	l.insp_type;
	self.inspection_scope										:=	l.insp_scope;
	self.number_in_establishment						:=	(integer)l.nr_in_estab;
	// self.union_flag											:=	l.union_status;
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
	self.cname                        			:= 	Pass2;
	self.SIC_Code                     			:= 	(integer)l.SIC_Code;
	self.source_rec_id                			:= 	HASH64(l.activity_nr + l.estab_name + l.site_address + l.SIC_CODE + l.Site_Zip);
	self.owner_code													:=	(integer)l.owner_code;
	self                              			:=  l;
	self																		:=  [];

end;

inspection_mapped	:=	project(oshair.files().input.Inspection.using, trfinspectionmapped(left));
basewithsource		:=	project(oshair.files().base.Inspection.qa,
															transform(layouts_input.cleaned_inspection,
																				self.source 		:= mdr.sourcetools.src_oshair;
																				self.bdid				:= 0;
																				self.bdid_score	:= 0;
																				self 						:= left;
																				self						:=[];)
															);

inspectionall			 :=	inspection_mapped + basewithsource;
dstandardize_addr  := standardize_addr.fall(inspectionall);
dAppendIds				 := Append_Ids.fAll(dstandardize_addr);
rollup_data 			 := oshair.rollup_base(dAppendIds, filedate, process_date);	

return rollup_data;	
				  
end;




				
			