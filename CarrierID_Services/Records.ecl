import FLAccidents_Ecrash,codes,ut,AutoStandardI,iesp,AutoKeyI,lib_stringlib,doxie,autoheaderi,nid,Accident_Services;

export Records(IParam.searchrecords in_mod) := function

  tempmod := module(project(in_mod,CarrierID_Services.IParam.searchrecords,opt));
			export addr :='';
			export dob  :=0;
  end;
	
	//i added the IF condition so that ECL testing would be more consistent
	//with product requirements.  specifically that a full address is required
	//on input for a subject search.  without the IF deep dive is returning
	//DIDs on a name/city/state search (which isn't valid).
  deep_dids := if(in_mod.addr<>'' or in_mod.ssn<>'' or in_mod.dob>0,dedup(project(limit(doxie.get_dids(,true),100,skip),transform(doxie.layout_references,self.did:=left.did)),did,all));
	
	by_accnbr   := project(limit(FLAccidents_Ecrash.key_EcrashV2_accnbrV1(keyed(l_accnbr=in_mod.accidentnumber)),constants.max_recs_on_join,skip),   transform({layouts.r_accnbr},self.accnbr:= left.l_accnbr,    self:=left));
	by_vin      := project(limit(FLAccidents_Ecrash.Key_EcrashV2_vin(keyed(l_vin=in_mod.vin)),constants.max_recs_on_join,skip),                    transform({layouts.r_accnbr},self.accnbr:= left.accident_nbr,self:=left));
	by_did      := project(limit(FLAccidents_Ecrash.Key_EcrashV2_did(keyed(l_did=(unsigned6)in_mod.did)),constants.max_recs_on_join,skip),         transform({layouts.r_accnbr},self.accnbr:= left.accident_nbr,self:=left));
	by_deep_did := join(deep_dids,FLAccidents_Ecrash.Key_EcrashV2_did,keyed(left.did=right.l_did),   transform({layouts.r_accnbr},self.accnbr:=right.accident_nbr,self.found_by_deep_dive:=true,self.did:=(string)right.l_did,self:=right),limit(constants.max_recs_on_join,skip));	
	by_auto1    := autokey_ids(project(in_mod,IParam.autokey_search));
	by_auto2    := autokey_ids(project(tempmod,IParam.autokey_search),true);
	unique_to_auto2 := join(by_auto2,by_auto1,left.accnbr=right.accnbr,left only);
	
	concat_search_types := dedup(map(in_mod.vin<>''                 => by_vin,
	                                 in_mod.did<>''                 => by_did,
														       in_mod.accidentnumber<>''      => by_accnbr,
														       by_deep_did
																	+by_auto1
																	+unique_to_auto2
														      )
                          ,record,all);
		
	get_recs_all := join(concat_search_types,FLAccidents_Ecrash.key_EcrashV2_accnbrV1,left.accnbr=right.l_accnbr,transform(recordof(carrierid_services.layouts.r_payload_with_penalty),self.found_by_deep_dive:=if(left.did=(string)(integer)right.did,left.found_by_deep_dive,false),self := right),limit(constants.max_recs_on_join,skip));
	get_recs     := get_recs_all((report_code = 'EA' and work_type_id in ['2', '3']) or (report_code = 'FA'));

	UNSIGNED bDOL := IF(in_mod.DateOfLoss!='',Accident_Services.Constants.DOL,0);
	UNSIGNED bNAME := IF((in_mod.FirstName!='' AND in_mod.LastName!='') OR in_mod.unparsedFullName!='' OR in_mod.companyname!='',Accident_Services.Constants.NAME,0);
	UNSIGNED bADDR := IF(in_mod.city!='' AND in_mod.state!='',Accident_Services.Constants.ADDR,0);
	UNSIGNED bVIN := IF(in_mod.VIN!='',Accident_Services.Constants.VIN,0);
	UNSIGNED bDLNBR := IF(in_mod.DriverLicenseNumber!='',Accident_Services.Constants.DLNBR,0);
	UNSIGNED bINPUT := bDOL + bNAME + bADDR + bVIN + bDLNBR;

	restrictionsRpt := Accident_Services.StateRestrictionsFunctions.getRestrictions(constants.applicationType);
	allowableStates := SET(restrictionsRpt(Allowed='Y'),accidentState);

	carrierid_services.layouts.r_payload_with_penalty filterKeyedData(carrierid_services.layouts.r_payload_with_penalty L) := TRANSFORM
		RequiredInputs := restrictionsRpt(accidentState=L.vehicle_incident_st).RequiredInputs;
		BOOLEAN hasRequiredInput := Accident_Services.StateRestrictionsFunctions.hasRequiredInput(RequiredInputs,bINPUT);
		BOOLEAN dolReq := (bDOL!=0) and hasRequiredInput;
		BOOLEAN dolInRange := ut.daysapart(in_mod.DateOfLoss,L.accident_date)<=30;
		BOOLEAN isRestrictedState := L.vehicle_incident_st NOT IN allowableStates;
		BOOLEAN requirementIsMet := (dolReq AND dolInRange) OR hasRequiredInput;
		BOOLEAN isKeyedData := L.report_code IN constants.natl_keyed_set;
		SELF.l_accnbr := IF(isRestrictedState AND ~requirementIsMet AND isKeyedData,SKIP,L.l_accnbr);
		SELF := L;
	END;

	filteredRecs := PROJECT(get_recs,filterKeyedData(LEFT));

	recs_plus_pen := project(filteredRecs,transform(layouts.r_payload_with_penalty,
			tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				export allow_wildcard  := false;											
				export did_field       := left.did;
				export fname_field     := left.fname;
				export mname_field     := left.mname;
				export lname_field     := left.lname;
				export pname_field     := left.prim_name;
				export predir_field    := left.predir;
				export prange_field    := left.prim_range;
				export postdir_field   := left.postdir;
				export suffix_field    := left.addr_suffix;
				export sec_range_field := left.sec_range;
				export city_field      := left.v_city_name;
				export state_field     := left.st;
				export zip_field       := left.zip;
				export county_field    := '';
				export dob_field       := left.dob;
				export ssn_field       := '';
				export phone_field     := '';
				export dod_field       := '';
				export city2_field     := '';				
			end;
 	  tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
	    self.penalt    := tempPenaltIndv;
			self           := left)
			);

  //penalty filter is removing records we want returned in a phonetics match
	apply_penalty_filter := dedup(sort(recs_plus_pen/*(penalt<2)*/,penalt,l_accnbr,-accident_date),record);
  recs_after_penalty   := join(filteredRecs,apply_penalty_filter,left.l_accnbr=right.l_accnbr and left.fname=right.fname and left.lname=right.lname and left.found_by_deep_dive=right.found_by_deep_dive,transform(layouts.r_payload_with_penalty,self.penalt:=right.penalt,self:=left));	
	apply_dedup          := dedup(sort(recs_after_penalty,penalt,fname,lname,l_accnbr,vin,record_type,report_code,-found_by_deep_dive),fname,lname,l_accnbr,vin,record_type,report_code);
	apply_choose         := choosen(apply_dedup,constants.max_recs_to_process);									 
	
	//pet data team not all records will have other_vin_indicator field populated
	//only those raw records having 2 VIN's (as in the case of a truck hauling a trailer) will have this field populated
	//ex: truck VIN: other_vin_indicator=1 trailer VIN: other_vin_indicator=2
  primary_vins           := apply_choose(other_vin_indicator<>'2');  
	secondary_vins         := apply_choose(other_vin_indicator ='2');
	
  string  ucase_lname   := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
	string  ucase_fname   := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
	string  pfirst_fname  := nid.preferredfirstnew(ucase_fname);
  boolean input_has_ln  := ucase_lname      <>'';
	boolean input_has_fn  := ucase_fname      <>'';
	boolean input_has_vin := in_mod.vin       <>'';
	boolean input_has_dol := in_mod.dateofloss<>'';
	boolean input_has_an  := in_mod.accidentnumber<>'';
	
	boolean dl_mask_value := in_mod.DLMask;
	
	layouts.r_response map_detail(layouts.r_payload_with_penalty le, layouts.r_payload_with_penalty ri) := transform
    			   
						 string v_datasource := functions.translate_source(le.report_code);
									
				     boolean subject_is_owner     := le.record_type='VEHICLE OWNER';
					   boolean subject_is_driver    := trim(le.record_type) in ['DRIVER','VEHICLE DRIVER'];
					   boolean subject_is_passenger := le.record_type='PASSENGER';
					
						 boolean vins_equal                  := input_has_vin       and in_mod.vin=le.vin;
						 boolean dols_equal                  := input_has_dol       and in_mod.dateofloss=le.accident_date;
						 boolean dols_close                  := input_has_dol       and ut.daysapart(in_mod.dateofloss,le.accident_date)<=30;
						 boolean ln_equal                    := input_has_ln        and ucase_lname=stringlib.stringtouppercase(le.lname);
             boolean ln_close                    := input_has_ln        and ln_equal=false and ucase_lname[1..2]=stringlib.stringtouppercase(le.lname)[1..2];						 
						 boolean fn_equal                    := input_has_fn        and pfirst_fname=nid.preferredfirstnew(le.fname);
						 boolean no_input_dol_but_src_is_inq := input_has_dol=false and v_datasource=carrierid_services.constants.str_natlaccinq;
						 boolean an_equal                    := input_has_an        and in_mod.accidentnumber=le.l_accnbr;
						 
						 row_masked := functions.maskDL(le, dl_mask_value);
						 
					   self.driver            := if(subject_is_driver,functions.setsubject(row_masked, is_driver := true),row([],iesp.carrierid.t_CarrierIDSubject));
					   self.owner             := if(subject_is_owner, functions.setsubject(row_masked),row([],iesp.carrierid.t_CarrierIDSubject));
						 self.passengers        := if(subject_is_passenger,functions.setsubject(row_masked, is_passenger_or_otherparty := true),row([],iesp.carrierid.t_CarrierIDSubject));
						 self.otherparties      := if(le.record_type<>'' and subject_is_owner=false and subject_is_driver=false and subject_is_passenger=false,functions.setsubject(row_masked, is_passenger_or_otherparty := true),row([],iesp.carrierid.t_CarrierIDSubject));
					   self.vehicle.vin       := le.vin;
						 self.vehicle.policy.number         := le.policy_num;
						 self.vehicle.policy.effectivedate  := iesp.ECL2ESP.toDatestring8(le.policy_effective_date);
						 self.vehicle.policy.expirationdate := iesp.ECL2ESP.toDatestring8(le.policy_expiration_date);
						 self.vehicle.carrier         := if(le.Insurance_Company_Standardized <> '', le.Insurance_Company_Standardized, le.carrier_name);
						 self.vehicle.year            := if(le.vehicle_year<>'',le.vehicle_year,le.model_year);
						 self.vehicle.make            := if(le.make_description<>'',le.make_description,le.vehicle_make);
						 self.vehicle.model           := le.model_description;
             self.vehicle.othervin        := ri.vin;
						 self.vehicle.otheryear       := if(ri.vehicle_year<>'',ri.vehicle_year,ri.model_year);
						 self.vehicle.othermake       := if(ri.make_description<>'',ri.make_description,ri.vehicle_make);
						 self.vehicle.othermodel      := ri.model_description;
	
						 self.incident.accidentnumber := le.orig_accnbr;
					   self.incident.dateofloss     := iesp.ECL2ESP.toDatestring8(le.accident_date);
					   self.incident.losstype := le.report_code_desc;
					   self.incident.city     := le.vehicle_incident_city;
						 self.incident.state    := if(le.vehicle_incident_st<>'',le.vehicle_incident_st,le.jurisdiction_state);

						 //if at any point we want to sort based on a dl number match
						 self.dl_st_hit                 := if(in_mod.driverlicensenumber=le.driver_license_nbr,
						                                    if(in_mod.driverlicensestate=le.dlnbr_st,1,
																								if(ut.nneq(in_mod.driverlicensestate,le.dlnbr_st),2,
																								3)),
																							 4);
             self.datasource        := v_datasource;
						 self.is_natl_inq       := v_datasource=carrierid_services.constants.str_natlaccinq;
						 self.hit_type          := if(self.incident.state in allowableStates,
						                            map(
						                             ((fn_equal and ln_equal) or vins_equal) and dols_equal => '1',
																				 an_equal                                               => '1',
																				 fn_equal   and (ln_equal or ln_close)                  => '2',
																				 vins_equal                                             => '2',
																				'3'),
																			 if(self.incident.state not in allowableStates,
																			  map(
																			 	 ((fn_equal and ln_equal) or vins_equal) and dols_equal                   => '1',
																				 an_equal   and dols_equal                                                => '1',
						                             fn_equal   and ln_equal  and (no_input_dol_but_src_is_inq or dols_close) => '2',
																				 fn_equal   and ln_close  and (no_input_dol_but_src_is_inq or dols_equal) => '2',																			  
																			   vins_equal and               (no_input_dol_but_src_is_inq or dols_close) => '2',
																				 an_equal   and               (no_input_dol_but_src_is_inq or dols_close) => '2',
																				'3'),
																				'3'));
						 self.incident.isdirecthit := self.hit_type='1';
						 //self.reportcode := le.report_code;
						 
						 self.found_by_deep_dive := le.found_by_deep_dive;
						 self.nneq_linkid        := ut.nneq_int(le.did,in_mod.did);
						 self.nneq_dl            := ut.nneq(le.driver_license_nbr,in_mod.driverlicensenumber);
						 self.nneq_dob           := ut.nneq(le.dob[1..4],(string)if(in_mod.dob=0,'',((STRING)in_mod.dob)[1..4]));
						 self.penalt             := le.penalt;
						 
						 //while we differentiate national accident keyed vs inquiry records in the data
	           //here the assumption is that we can merge the two for creating a single record
						 //rollup occurs below
						 self.tmp_src             :=if(self.datasource=carrierid_services.constants.str_natlaccinq,carrierid_services.constants.str_natlacc,self.datasource);
						 self.vehicle_incident_id := le.vehicle_incident_id;
						 self.l_accnbr            := le.l_accnbr;
						 
	end;

	mapped_to_output := join(primary_vins,secondary_vins,left.l_accnbr=right.l_accnbr and left.vehicle_unit_number=right.vehicle_unit_number,map_detail(left,right),left outer);
	
	//blank'ing here is easier than accounting for them in the dedup
	//while other fields are also not carried thru to the app (incl data_source and link_id),
	//i do notice they're being referenced for testing
	layouts.r_response blank_fields_not_in_app(mapped_to_output le) := transform
    self.driver.name.middle                 :='';
		self.driver.address.streetnumber        :='';
		self.driver.address.streetpredirection  :='';
		self.driver.address.streetname          :='';
		self.driver.address.streetsuffix        :='';
		self.driver.address.streetpostdirection :='';
		self.driver.address.unitdesignation     :='';
		self.driver.address.unitnumber          :='';
		self.driver.address.streetaddress1      :='';
		self.driver.address.streetaddress2      :='';
		self.driver.address.city                :='';
		self.driver.address.state               :='';
		self.driver.address.zip5                :='';
		self.driver.address.zip4                :='';
		self.driver.address.county              :='';
		self.driver.address.postalcode          :='';
		self.driver.address.statecityzip        :='';

    self.owner.name.middle                 :='';
		self.owner.address.streetnumber        :='';
		self.owner.address.streetpredirection  :='';
		self.owner.address.streetname          :='';
		self.owner.address.streetsuffix        :='';
		self.owner.address.streetpostdirection :='';
		self.owner.address.unitdesignation     :='';
		self.owner.address.unitnumber          :='';
		self.owner.address.streetaddress1      :='';
		self.owner.address.streetaddress2      :='';
		self.owner.address.city                :='';
		self.owner.address.state               :='';
		self.owner.address.zip5                :='';
		self.owner.address.zip4                :='';
		self.owner.address.county              :='';
		self.owner.address.postalcode          :='';
		self.owner.address.statecityzip        :='';

		self := le;
	end;
	
	fields_blanked := project(mapped_to_output,blank_fields_not_in_app(left));
	
	remove_no_hits          := fields_blanked(hit_type<>'3');
	remove_disagreements    := remove_no_hits(found_by_deep_dive=true or ~(nneq_dl=false or nneq_dob=false or nneq_linkid=false));

  //not all states dppa regulate accidents data - this is intended to account for that  	
	input_dppa := in_mod.DPPAPurpose;
	
	apply_dppa_restrictions := remove_disagreements((ut.PermissionTools.dppa.state_ok(incident.state,input_dppa)
		                         and
														 remove_disagreements.incident.state in carrierid_services.constants.dppa_states)
														 or
														 remove_disagreements.incident.state not in carrierid_services.constants.dppa_states);
	
	recs_result   := dedup(sort(apply_dppa_restrictions,-incident.isdirecthit,-incident.dateofloss,incident.accidentnumber,-incident.state,vehicle.vin,-driver.did,-driver.name.first,-owner.did,-owner.name.first),except datasource,is_natl_inq,driver.did,owner.did);
				
	layouts.r_response rollup_within_accident_vin(layouts.r_response le, layouts.r_response ri) := transform
   
	 //difficult to avoid due to the blank elements that could affect the sort results coming into the rollup   
   self.datasource :=  if(le.datasource=ri.datasource,le.datasource	                      
											,if((le.datasource=carrierid_services.constants.str_natlacc and ri.datasource=carrierid_services.constants.str_natlaccinq) or (le.datasource=carrierid_services.constants.str_natlaccinq and ri.datasource=carrierid_services.constants.str_natlacc),carrierid_services.constants.str_both_sources
											,le.datasource));
												 
	 self.vehicle.vin        := if(le.vehicle.vin       <>'',le.vehicle.vin,       ri.vehicle.vin);
	 self.vehicle.year       := if(le.vehicle.year      <>'',le.vehicle.year,      ri.vehicle.year);
	 self.vehicle.make       := if(le.vehicle.make      <>'',le.vehicle.make,      ri.vehicle.make);
	 self.vehicle.model      := if(le.vehicle.model     <>'',le.vehicle.model,     ri.vehicle.model);
   self.vehicle.othervin   := if(le.vehicle.othervin  <>'',le.vehicle.othervin,  ri.vehicle.othervin);
	 self.vehicle.otheryear  := if(le.vehicle.otheryear <>'',le.vehicle.otheryear, ri.vehicle.otheryear);
	 self.vehicle.othermake  := if(le.vehicle.othermake <>'',le.vehicle.othermake, ri.vehicle.othermake);
	 self.vehicle.othermodel := if(le.vehicle.othermodel<>'',le.vehicle.othermodel,ri.vehicle.othermodel);
	 self.vehicle.carrier    := if(le.vehicle.carrier   <>'',le.vehicle.carrier,   ri.vehicle.carrier);
	 
	 self.vehicle.policy.number               := if(le.vehicle.policy.number              <>'',le.vehicle.policy.number,              ri.vehicle.policy.number);
	 self.vehicle.policy.effectivedate.year   := if(le.vehicle.policy.effectivedate.year   > 0,le.vehicle.policy.effectivedate.year,  ri.vehicle.policy.effectivedate.year);
	 self.vehicle.policy.effectivedate.month  := if(le.vehicle.policy.effectivedate.month  > 0,le.vehicle.policy.effectivedate.month, ri.vehicle.policy.effectivedate.month);
	 self.vehicle.policy.effectivedate.day    := if(le.vehicle.policy.effectivedate.day    > 0,le.vehicle.policy.effectivedate.day,   ri.vehicle.policy.effectivedate.day);
	 self.vehicle.policy.expirationdate.year  := if(le.vehicle.policy.expirationdate.year  > 0,le.vehicle.policy.expirationdate.year, ri.vehicle.policy.expirationdate.year);
	 self.vehicle.policy.expirationdate.month := if(le.vehicle.policy.expirationdate.month > 0,le.vehicle.policy.expirationdate.month,ri.vehicle.policy.expirationdate.month);
	 self.vehicle.policy.expirationdate.day   := if(le.vehicle.policy.expirationdate.day   > 0,le.vehicle.policy.expirationdate.day,  ri.vehicle.policy.expirationdate.day);

   self.driver.did                 := if((integer)le.driver.did        > 0,le.driver.did,                ri.driver.did);
	 self.driver.bdid                := if((integer)le.driver.bdid       > 0,le.driver.bdid,               ri.driver.bdid);
	 self.driver.name.full           := if(le.driver.name.full          <>'',le.driver.name.full,          ri.driver.name.full);
	 self.driver.name.first          := if(le.driver.name.first         <>'',le.driver.name.first,         ri.driver.name.first);
	 self.driver.name.middle         := if(le.driver.name.middle        <>'',le.driver.name.middle,        ri.driver.name.middle);
	 self.driver.name.last           := if(le.driver.name.last          <>'',le.driver.name.last,          ri.driver.name.last);
	 self.driver.name.suffix         := if(le.driver.name.suffix        <>'',le.driver.name.suffix,        ri.driver.name.suffix);
	 self.driver.ssn                 := if(le.driver.ssn                <>'',le.driver.ssn,                ri.driver.ssn);
	 self.driver.dob.year            := if(le.driver.dob.year            > 0,le.driver.dob.year,           ri.driver.dob.year);
	 self.driver.dob.month           := if(le.driver.dob.month           > 0,le.driver.dob.month,          ri.driver.dob.month);
	 self.driver.dob.day             := if(le.driver.dob.day             > 0,le.driver.dob.day,            ri.driver.dob.day);
	 self.driver.driverlicensenumber := if(le.driver.driverlicensenumber<>'',le.driver.driverlicensenumber,ri.driver.driverlicensenumber);
	 self.driver.driverlicensestate  := if(le.driver.driverlicensestate <>'',le.driver.driverlicensestate, ri.driver.driverlicensestate);
	 self.driver.partytype           := if(le.driver.partytype          <>'',le.driver.partytype,          ri.driver.partytype);

   self.owner.did                 := if((integer)le.owner.did         > 0,le.owner.did,                ri.owner.did);
	 self.owner.bdid                := if((integer)le.owner.bdid        > 0,le.owner.bdid,               ri.owner.bdid);
	 self.owner.name.full           := if(le.owner.name.full           <>'',le.owner.name.full,          ri.owner.name.full);
	 self.owner.name.first          := if(le.owner.name.first          <>'',le.owner.name.first,         ri.owner.name.first);
	 self.owner.name.middle         := if(le.owner.name.middle         <>'',le.owner.name.middle,        ri.owner.name.middle);
	 self.owner.name.last           := if(le.owner.name.last           <>'',le.owner.name.last,          ri.owner.name.last);
	 self.owner.name.suffix         := if(le.owner.name.suffix         <>'',le.owner.name.suffix,        ri.owner.name.suffix);
	 self.owner.ssn                 := if(le.owner.ssn                 <>'',le.owner.ssn,                ri.owner.ssn);
	 self.owner.dob.year            := if(le.owner.dob.year             > 0,le.owner.dob.year,           ri.owner.dob.year);
	 self.owner.dob.month           := if(le.owner.dob.month            > 0,le.owner.dob.month,          ri.owner.dob.month);
	 self.owner.dob.day             := if(le.owner.dob.day              > 0,le.owner.dob.day,            ri.owner.dob.day);
	 self.owner.driverlicensenumber := if(le.owner.driverlicensenumber <>'',le.owner.driverlicensenumber,ri.owner.driverlicensenumber);
	 self.owner.driverlicensestate  := if(le.owner.driverlicensestate  <>'',le.owner.driverlicensestate, ri.owner.driverlicensestate);
	 self.owner.partytype           := if(le.owner.partytype           <>'',le.owner.partytype,          ri.owner.partytype);
	 
	 self.passengers                := if(count(le.passengers)>1,le.passengers,ri.passengers);
	 self.otherparties              := if(count(le.otherparties)>1,le.otherparties,ri.otherparties);
	
	 self.penalt := if(le.penalt<=ri.penalt,le.penalt,ri.penalt);
	 
	 self := le;

	end;
	
	recs_result_srtd := sort(recs_result,tmp_src,incident.accidentnumber,vehicle_incident_id,incident.state,vehicle.vin,driver.name.first);
	roll_recs := rollup(recs_result_srtd,
	                  left.tmp_src                =right.tmp_src
								and left.incident.accidentnumber=right.incident.accidentnumber
								and left.vehicle_incident_id    =right.vehicle_incident_id
								and left.incident.state         =right.incident.state
								and (
								     (left.vehicle.vin          =right.vehicle.vin and left.vehicle.vin<>'') 
								      or
										 (left.driver.name.first=right.driver.name.first and left.driver.name.last=right.driver.name.last and left.driver.name.first<>'')
										)
								,rollup_within_accident_vin(left,right)
								);

  recs_with_carrier      := roll_recs(vehicle.carrier<>'');
	recs_with_carrier_srtd := sort(recs_with_carrier,-incident.isdirecthit,penalt,-incident.dateofloss);
  apply_limit            := choosen(recs_with_carrier_srtd,carrierid_services.constants.max_recs_to_return);
								 
	//output(by_deep_did,named('by_deep_did'),all);
	//output(by_auto1,named('by_auto1'),all);
	//output(unique_to_auto2,named('unique_to_auto2'),all);
	//output(concat_search_types,named('concat_search_types'),all);
	//output(get_recs,named('get_recs'),all);
	//output(filteredRecs,named('filteredRecs'),all);
	//output(recs_plus_pen,named('recs_plus_pen'),all);
	//output(recs_after_penalty,named('recs_after_penalty'),all);
	//output(apply_choose,named('apply_choose'),all);
	//output(mapped_to_output,named('mapped_to_output'),all);
	//output(fields_blanked,named('fields_blanked'),all);
	//output(recs_result,named('recs_result'),all);
	//output(roll_recs,named('roll_recs'),all);
	//output(recs_with_carrier_srtd,named('recs_with_carrier'),all);
	
	return apply_limit;
   
end;