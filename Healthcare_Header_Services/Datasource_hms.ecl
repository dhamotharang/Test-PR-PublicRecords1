import Org_Mast,HMS_STLIC,hms_kop_trgt_harv; 
 EXPORT Datasource_hms := Module

//srcIndividualHeader
Export get_hms_Indiv (dataset(healthcare_header_services.Layouts.searchKeyResults_plus_input) input,dataset(healthcare_header_services.Layouts.common_runtime_config) cfg):= function
			 noHits := input;
			 rawdataIndividualbyVendorid:= join(nohits(vendorid<>''), HMS_STLIC.keys(,true).stlicrollup_sourcerid_key.qa,
																								keyed(left.vendorid = (string)right.source_rid), 
																													transform(healthcare_header_services.Layouts.hms_Indivbase_with_input,
																													self.l_providerid := left.lnpid;
																													self.vendorid:=(string)right.ln_key;
  																												self.glb_ok := left.glb_ok;
																													self.dppa_ok := left.dppa_ok;
																													self.rawdata.status:=right.mapped_status;
																													self.rawdata.license_class_type:=right.mapped_class;
																													self.rawData:=right;
																													self:=left;self:=[]),keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			 rawdataIndividualbyVendoridSorted:=dedup(sort(rawdataIndividualbyVendorid,record),record);
       																									
       audits:=join(rawdataIndividualbyVendoridSorted,	hms_kop_trgt_harv.keys(,true).koptrgtharv_lnpid_key.qa,
			                         keyed(left.lnpid = right.lnpid)and left.rawdata.license_number=right.stlic_number and left.rawdata.mapped_class=right.stlic_type, 
															 transform(healthcare_header_services.Layouts.hms_Indivbase_with_input,
																													self.l_providerid := left.lnpid;
																													self.vendorid:=left.vendorid;
  																												self.glb_ok := left.glb_ok;
																													self.dppa_ok := left.dppa_ok;
																													self.rawData.clean_issue_date:=if((string)LEFT.rawdata.clean_issue_date >(string)right.clean_stlic_issue_date,(string)left.rawData.clean_issue_date,(string)right.clean_stlic_issue_date);
																													self.rawData.clean_expiration_date:=if((STRING)left.rawdata.clean_expiration_date > (STRING)right.clean_stlic_exp_date ,(STRING)left.rawdata.clean_expiration_date,(STRING)right.clean_stlic_exp_date);
																									        self.rawdata.prim_range:=left.rawdata.prim_range;				
																									        self.rawdata.prim_name:=left.rawdata.prim_name;				
																									        self.rawdata.addr_suffix:=left.rawdata.addr_suffix;				
																									        self.rawdata.postdir:=left.rawdata.postdir;				
																									        self.rawdata.unit_desig:=left.rawdata.unit_desig;				
																									        self.rawdata.sec_range:=left.rawdata.sec_range;				
																									       	self.rawData:=left;
																													self:=left;self:=[]),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
 			
			
			NoAudits:=join(rawdataIndividualbyVendoridSorted, audits,left.lnpid = right.lnpid 
		                 and left.rawdata.license_number=right.rawdata.license_number and 
										 left.rawdata.mapped_class=right.rawdata.mapped_class, 
                     transform(left),left only);

												 
			baseRecs := project(audits+NoAudits,Transforms.build_hms_Indivbase(left));
			hms_providers_final_sorted := sort(baseRecs, acctno, LNPID, Src, statelicenses[1].LicenseNumber,statelicenses[1].LicenseState,-statelicenses[1].Termination_Date);
			hms_providers_final_grouped := group(hms_providers_final_sorted, acctno, LNPID, Src,statelicenses[1].LicenseNumber,statelicenses[1].LicenseState);
			hms_providers_rolled := rollup(hms_providers_final_grouped, group, Transforms.doHmsIndivRecordSrcIdRollup(left,rows(left)));
			
			
			return hms_providers_rolled;
end;
Export get_hms_Facility (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
			 noHits := input;
			 rawdataFacilitybyVendorid := join(noHits(vendorid<>''),  Org_Mast.Keys(,true).Facilities_LNFID.qa,
																					keyed(left.lnpid = right.lnfid),
																								transform(Layouts.hms_base_with_input,
																													self.l_providerid := left.lnpid;
																													self.vendorid:=(string)right.lnfid;
  																												self.glb_ok := left.glb_ok;
																													self.dppa_ok := left.dppa_ok;
																													self.rawData:=right;
																													self:=left;self:=[]),keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
      rawdataFacilitybyVendoridSorted:=dedup(sort(rawdataFacilitybyVendorid,record),record);
			baseRecs := project(rawdataFacilitybyVendoridSorted,Transforms.build_hms_facility_base(left));
			hms_providers_final_sorted := sort(baseRecs, acctno, LNPID, Src);
			hms_providers_final_grouped := group(hms_providers_final_sorted, acctno, LNPID, Src);
			hms_providers_rolled := rollup(hms_providers_final_grouped, group, Transforms.doHmsRecordSrcIdRollup(left,rows(left)));
     // output(hms_providers_rolled,named('get_hms_Facility'),overwrite);     	
			return hms_providers_rolled;
end;
Export get_hms_entity (dataset(Layouts.searchKeyResults_plus_input) input1,dataset(Layouts.common_runtime_config) cfg):= function
			recsIndiv := input1(srcIndividualHeader=true);
			recsFacility := input1(srcBusinessHeader=true);
			indivRecs := get_hms_Indiv(recsIndiv,cfg);
			facRecs := get_hms_Facility(recsFacility,cfg);
			// output(input1,named('gethmsentityinput'),Extend);
			// output(recsIndiv,named('recsIndiv'),Extend);
			// output(recsFacility,named('recsFacility'),Extend);
			// output(indivRecs,named('indivRecs'),Extend);
			// output(facRecs,named('facRecs'),Extend);
     	return indivRecs+facRecs;
	end;
end;