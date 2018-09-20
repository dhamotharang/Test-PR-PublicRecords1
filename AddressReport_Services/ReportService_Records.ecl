IMPORT census_data,location_services,AddressReport_Services,doxie_cbrs,ut, suppress,
			 DriversV2_Services,VehicleV2_Services,Doxie_Raw,LiensV2_Services,header,Gong,
			 BankruptcyV2_Services,doxie, iesp, AutoStandardI,Address,LN_PropertyV2_Services,
			 BIPV2, hunting_fishing_services, STD, VehicleV2, D2C;

EXPORT ReportService_Records (AddressReport_Services.input._addressreport param,
															boolean IsFCRA = false):=function

	//*************************************//
	// Getting Data from Services - Start  //
	//*************************************//
	AI					:=AutoStandardI.InterfaceTranslator;
	clean_addr	:=ai.clean_address.val (project (param, AI.clean_address.params));
	split_addr	:=Address.CleanFields(clean_addr);
	isCNSMR := param.IndustryClass = D2C.Constants.CNSMR;

	AddressReport_Services.Layouts.slim_address into_srch() := transform
		self.prim_range 	:= split_addr.prim_range;
		self.predir     	:= split_addr.predir;
		self.prim_name	 	:= split_addr.prim_name;
		self.suffix 	 		:= split_addr.addr_suffix;
		self.postdir 	 		:= split_addr.postdir;
		self.sec_range  	:= split_addr.sec_range;
		self.p_city_name 	:= split_addr.p_city_name;
		self.v_city_name 	:= split_addr.v_city_name;
		self.st 		 			:= split_addr.st;
		self.zip		 			:= split_addr.zip;
		self.zip4					:= split_addr.zip4;
		self.unit_desig		:= split_addr.unit_desig;
		self							:=[];
	end;

	srchrec 	:= dataset([into_srch()]);
	res_input	:=project(srchrec,AddressReport_Services.layouts.in_address);
	nbr_input	:=project(srchrec,transform(doxie.layout_nbr_targets,self:=left,self:=[]));		
	gong_input:=project(srchrec,transform(doxie.layout_AppendGongByAddr_input,self:=left,self:=[]));		
	bus_input	:=project(srchrec,transform(Doxie_Raw.Layout_address_input,Self.city_name:=left.p_city_Name,self:=left));

	//**************************************

	res_key:=doxie.Key_Header_Address;

	typeof(res_key) get_Res(srchrec l, res_key R) :=TRANSFORM
		SELF := R;
	END;

	Res_final_all := JOIN(srchrec,res_key,
												keyed(left.prim_name = right.prim_name) and
												keyed(left.zip = right.zip) and
												keyed(left.prim_range = right.prim_range),
												get_Res(LEFT,RIGHT),LIMIT(0));

	BOOLEAN missingSecRng := split_addr.rec_type IN ['H','HD'] AND split_addr.sec_range = '';
	recs 									:= IF(missingSecRng AND COUNT(Res_final_all)>AddressReport_Services.constants.MaxResidents,
															DEDUP(SORT(Res_final_all(sec_range!=''),
																				 prim_name,zip,prim_range,sec_range,-dt_last_seen,-dt_first_seen),
																		prim_name,zip,prim_range,sec_range),
															Res_final_all(sec_range=split_addr.sec_range));

	IF(COUNT(dedup(sort(recs,DID),DID))>MAX(AddressReport_Services.constants.MaxResidents,AddressReport_Services.constants.MaxProperties),FAIL(203,doxie.ErrorCodes(203)));
	headerRecs 								:= project(recs, TRANSFORM(header.Layout_Header,self:=left,self:=[]));			 

  //Some values are not provided in the input module; until that, has to make this call:
  mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
    EXPORT unsigned1 glb := param.glbPurpose;
    EXPORT unsigned1 dppa := param.dppapurpose;
    EXPORT string DataPermissionMask := param.DataPermissionMask;
    EXPORT string DataRestrictionMask := param.DataRestrictionMask;
    EXPORT boolean ln_branded := param.lnbranded;
    EXPORT boolean probation_override := param.probationoverride;
    EXPORT string5 industry_class := param.industryclass;
    EXPORT string32 application_type := param.applicationType;
    EXPORT boolean no_scrub := param.no_scrub;
    EXPORT unsigned3 date_threshold := param.dateval;
    EXPORT string ssn_mask := param.ssn_mask;
  END;

  glb_ok :=  mod_access.isValidGLB ();
  dppa_ok := mod_access.isValidDPPA ();

	Header.MAC_GlbClean_Header(headerRecs,Res_final, , , mod_access);
	Res_recs_dedup		:= dedup(sort(Res_final,did, -dt_last_seen),did);
	dids							:= project(Res_recs_dedup,doxie.layout_references);

	//***************************************

	Residents_all := doxie.best_records(dids, IsFCRA, , , true, , includeDOD:=true, modAccess := mod_access);

  Residents_Filtered := doxie.functions.MAC_FilterOutMinors (Residents_all, , dob, mod_access.show_minors);

	Suppress.MAC_Suppress(Residents_Filtered,Residents_Filt_did,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did);
	Suppress.MAC_Suppress(Residents_Filt_did,Residents_Filt_did_ssn,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,ssn);

	Residents				:= Residents_Filt_did_ssn;//Residents_Filtered;
	Residents_final	:= choosen(sort(Residents,-addr_dt_last_seen),AddressReport_Services.constants.MaxResidents);
	Res_cur_raw			:= AddressReport_Services.split_Residents(Residents_final,res_input,param).CurrentResidents;
	Res_cur0				:= Res_cur_raw.residents;
	Res_prior				:= AddressReport_Services.split_Residents(Residents_final,res_input,param).priorResidents;
	cur_dids				:= project(Res_cur0, doxie.layout_references);
	lj_IDs 					:= liensv2_services.Autokey_ids(,true,false,false, false);
	LiensJudgments	:= LiensV2_Services.liens_raw.report_view.by_tmsid(project(lj_IDs,liensv2_services.layout_tmsid),mod_access.ssn_mask,,,,,mod_access.application_type);
	veh_ids_for_addr := VehicleV2_Services.autokey_ids(false,true,true);
	vehicles 				:= if(~isCNSMR, VehicleV2_Services.Vehicle_raw.get_vehicle_crs_report_by_Veh_key(veh_ids_for_addr));
																
	bk_ids 					:= BankruptcyV2_Services.bankruptcy_ids(dataset([],doxie.layout_references),
																													dataset([],doxie_cbrs.layout_references),
																													dataset([],bankruptcyv2_services.layout_tmsid_ext),
																													dataset([],BIPV2.IDlayouts.l_xlink_ids),,
																													0);
	Bankruptcies_all:= Doxie_Raw.bk_legacy_raw(,,bk_ids,,mod_access.ssn_mask,'D');
																
	dl_in_seq				:= DriversV2_Services.autokey_ids(,true,true);
	dl_IDs1					:= project(dl_in_seq,DriversV2_Services.layouts.seq);
	dl_IDs2					:= DriversV2_Services.DLRaw.get_seq_from_dids(cur_dids);
	dl_IDs					:= if(param.locationReport, dl_IDs2, dl_IDs1);
	dlsr_filtered		:= DriversV2_Services.fn_getDL_report(dl_IDs);

	Res_cur_loc			:= AddressReport_Services.Functions.fAddDriverInfo(Res_cur0, dlsr_filtered);
	Res_cur					:= if(param.locationReport, Res_cur_loc, Res_cur0);

	Prop_ids				:= LN_PropertyV2_Services.autokey_ids(,true,true);
	Property 				:= LN_PropertyV2_Services.resultFmt.widest_view.get_by_fid(Prop_ids);

	// Below added on 03/30/2011 for criminal records, sex offenders, bookings, hunting and fire arm licences
	Crims_filtered  := if(param.include_CriminalRecords,AddressReport_Services.functions.fCrimes());
	sexOffender_filtered					:= if(param.include_SexualOffenses,AddressReport_Services.functions.fSexOffendors());	
	Hunting_Filtered							:= if(param.include_HuntingFishingLicenses,AddressReport_Services.functions.fHuntingAndFishing());
	formatedFilteredWeaponRecords	:= if(param.include_WeaponPermits ,AddressReport_Services.functions.fWeaponsPermits());
	// end 03/30/2011 maintenance 

	//Remove Invalid address records from Bankruptcies
	AddressReport_Services.Mac_address_Filter(Bankruptcies_all,
																						debtor_records.Addresses[1].prim_name,
																						debtor_records.Addresses[1].prim_range,
																						debtor_records.Addresses[1].predir,
																						debtor_records.Addresses[1].postdir,
																						debtor_records.Addresses[1].suffix,
																						debtor_records.Addresses[1].sec_range,
																						debtor_records.Addresses[1].p_city_name,
																						debtor_records.Addresses[1].st,
																						debtor_records.Addresses[1].z5,
																						res_input,
																						Bankruptcies_filter
																						);
	Bankruptcies				:=Bankruptcies_filter;
											
	Neighbors_recs_all	:=doxie.nbr_records(nbr_input,
																					'C',
																					1,
																					if(param.LocationReport, AddressReport_Services.constants.NPA, AddressReport_Services.constants.MaxNeighbors),
																					if(param.LocationReport, AddressReport_Services.constants.Neighbors_Per_NA, AddressReport_Services.constants.MaxNeighbors),
																					if(param.LocationReport, AddressReport_Services.constants.NeighborRecency, AddressReport_Services.constants.MaxNeighbors),
																					'',
																					mod_access.glb,
																					mod_access.dppa,
																					false,
																					true,
																					glb_ok,
																					dppa_ok,
																					mod_access.ssn_mask,
																					true,
																					true,
																					AddressReport_Services.constants.MaxProximity,
																					false);  // there is no subject in this report

	ut.PermissionTools.GLB.mac_FilterOutMinors(Neighbors_recs_all,Neighbors_recs_fil,,,dob)
	Neighbors_recs :=Neighbors_recs_fil;
	Neighbors_filtered:=AddressReport_Services.transform_neighbors(Neighbors_recs,,, param);
	
	//************************************* //
	//Location Report Project Data Retrieval
	
	//Neighbors
	nbr_dids 				:= project(Neighbors_recs, doxie.layout_references);
	nbr_best				:= doxie.best_records(nbr_dids, IsFCRA, , , true,checkRNA:=true, includeDOD:=true, modAccess := mod_access)(dod = '');
	
	//Current Residents and Neighbor dids
	all_dids				:= cur_dids & nbr_dids;

	//Possible Owners
	own_recs				:= AddressReport_Services.Functions.fPossibleOwners(res_input, param);

	//Vehicles - Residents and Neighbors and Report Address
	//
	//Get Vehicle info based on DIDs (residents) as well as based on Address the report is on.
	veh_ids_for_curdids := VehicleV2_Services.Vehicle_raw.get_vehicle_keys_from_dids(cur_dids);

  // Sort/dedup the current resident dids & report addresss vehicle ids to remove exact duplicates.
	veh_ids_for_resaddr_dd := dedup(sort(veh_ids_for_curdids + veh_ids_for_addr,
	                                     vehicle_key, iteration_key, sequence_key),
	                                vehicle_key, iteration_key, sequence_key);
	
	// Determine which res/addr vehicle ids are still associated with the resident or report address, 
	// even it the latest registration has expired, but only within last 5 years.
	//
	// First sort/dedup to use only unique vehicle_key values
	veh_ids_ra_vk_deduped := dedup(sort(veh_ids_for_resaddr_dd, vehicle_key),vehicle_key);

  // Join res/addr unique vehicle_key values to the vehicle party key to get all the party recs 
  veh_ra_partyrecs := join(veh_ids_ra_vk_deduped, VehicleV2.Key_Vehicle_Party_Key,
													    keyed(left.vehicle_key = right.vehicle_key) and 
															// v--- Only use non-Infutor records since the Infutor ones might
															//   be the highest iteration_key, but not the most recent data
															//   (A known Infutor data issue discussed with Cathy Tio in data fab 
															//   on 05/31/16 and JIRA DF-16655 was created).
															not MDR.sourceTools.SourceIsInfutor_Veh(right.source_code),
													 transform(right),
													 inner,
													 limit(ut.limits.DEFAULT, skip));

  // Then sort/dedup to only keep the record with the most recent iteration_key & sequence_key
	// values for each vehicle_key.  
	veh_ra_pr_dd := dedup(sort(veh_ra_partyrecs,
	                           vehicle_key, -iteration_key, -sequence_key, 
														 orig_name_type),  //owners before registrants and lienholders, not that it should matter
	                      vehicle_key);

  // Join the previously deduped res & addr vehicle ids to the most recent party key info to
	// see if the vehicle ids still belong to the resident/addr
	// (i.e. all 3 ***_key values match the most recent ones)
  veh_ids_for_resaddr_stillowned := join(veh_ids_for_resaddr_dd, veh_ra_pr_dd,
																	         left.vehicle_key   = right.vehicle_key   and
																	         left.iteration_key = right.iteration_key and
																	         left.sequence_key  = right.sequence_key, 
																         transform(right),
																         inner);

  // Now join the previously deduped res  addr vehicle ids to the ones that are still owned 
	// to identify the ones that should be used.
  veh_ids_for_resaddr_touse := join(veh_ids_for_resaddr_dd, veh_ids_for_resaddr_stillowned,
																		   left.vehicle_key   = right.vehicle_key, 
																    transform(left),
																    inner);

  // Calculate the date 5 years back from today
  unsigned4 current_date := STD.Date.Today(); // current/run date in unsigned4 yyyymmdd format
  string8 FiveYearsBack  := (string8) (current_date - 50000); // subtract 5 from yyyy portion
		
  // Get report formatted recs for the res/addr vehicle ids to be used
  vehicle_recs_resaddr_vehraw := if(~isCNSMR, VehicleV2_Services.Vehicle_raw.get_vehicle_crs_report_by_Veh_key(
															    									veh_ids_for_resaddr_touse));

  // Filter to only keep recs out of Vehicle_raw that are "current" or 
	// ones where the registration latest expiration date is within the last 5 years.
  vehicle_recs_resaddr_vehraw_kept := vehicle_recs_resaddr_vehraw
															        (is_current or
																	     (registrants[1].Reg_Latest_Expiration_Date != '' and
																        registrants[1].Reg_Latest_Expiration_Date > FiveYearsBack)
																	    );

 	//Get report formatted rec out of vehicle_raw for the neighbor DIDs.
	veh_ids_for_nbrdids     := VehicleV2_Services.Vehicle_raw.get_vehicle_keys_from_dids(nbr_dids);
  vehicle_recs_nbr_vehraw := if(~isCNSMR, VehicleV2_Services.Vehicle_raw.get_vehicle_crs_report_by_Veh_key(
																								veh_ids_for_nbrdids)
																								(is_current)); //filter for only "current" ones

  // Combine resident/rpt addr vehicle_raw recs kept with neighbor vehicle_raw recs
	vehicle_recs    := vehicle_recs_resaddr_vehraw_kept + vehicle_recs_nbr_vehraw;

  // Hunting and Fishing Licenses - Residents and Neighbors and Report Address
	//
	// Get HF rids for the residents & neighbors (all dids)
	hf_rids_for_dids := hunting_fishing_services.Raw.byDids(
	                       project(all_dids,hunting_fishing_services.layouts.search_did),IsFCRA);

	// Get HF rids (using autokeys) for the report address
	mod_hf_akparams := module(project(param,hunting_fishing_services.AutoKey_IDs.params,opt))
	   //set params used by hunting_fishing_services.AutoKey_IDs.val, but with different defaults
		 export boolean workHard   := false;
		 export boolean noFail     := true;
		 export boolean isdeepDive := false;
  end;
  hf_rids_for_addr := hunting_fishing_services.AutoKey_IDs.val(mod_hf_akparams);

	//Get HF "raw" info based on all of the Rids
  hf_raw_info := hunting_fishing_services.Raw.byRids(hf_rids_for_dids + hf_rids_for_addr,
	                                                   IsFCRA);

  // Sort/dedup to only keep the most recent license info for each did
	hf_raw_info_deduped := dedup(sort(hf_raw_info, did_out, source_state, license_type_mapped, 
	                                  -datelicense, -HomeState), // prefer non-blanks over blank fields
                               did_out, source_state, license_type_mapped);  // some raw data HomeState fields had invalid data, so don't dedupe on it

	mod_hf_srparams := module(project(param, hunting_fishing_services.Search_Records.params,opt))
  end;
	// Use HF function that does penalty, suppression, ssn masking, formatting into iesp layout, etc.
	hf_recs := hunting_fishing_services.Search_Records.formatandFilterRawRecords(hf_raw_info_deduped, 
						                                                                   mod_hf_srparams, 
																																							 IsFCRA);

	//Criminals - Residents and Neighbors
	crim_recs				:= AddressReport_Services.functions.fCrimesRecords(all_dids);
	res_crim_recs		:= join(cur_dids, crim_recs, left.did = (unsigned)right.UniqueId, transform(right));
	nbr_crim_recs		:= join(nbr_dids, crim_recs, left.did = (unsigned)right.UniqueId, transform(right));

	//Sex Offenders - Residents and Neighbors
	so_recs 				:= AddressReport_Services.functions.fSexOffenderRecords(all_dids, mod_access.application_type);
	res_so_recs			:= join(cur_dids, so_recs, left.did = (unsigned)right.UniqueId, transform(iesp.sexualoffender.t_OffenderRecord, self := right)); // layout transformed- FFD FCRA
	nbr_so_recs			:= join(nbr_dids, so_recs, left.did = (unsigned)right.UniqueId, transform(right));

	//Concealed Weapons - Residents and Neighbors
	cw_recs 				:= AddressReport_Services.functions.fWeaponsPermitsRecords(all_dids);
	res_cw_recs			:= join(cur_dids, cw_recs, left.did = (unsigned)right.UniqueId, transform(right));
	nbr_cw_recs			:= join(nbr_dids, cw_recs, left.did = (unsigned)right.UniqueId, transform(right));

	//Relatives and Associates
	ra_recs 				:= doxie.relative_dids(cur_dids);
	ra_dids					:= dedup(sort(project(ra_recs, transform(doxie.layout_references, self.did := left.person2)), did), did);
	ra_best					:= doxie.best_records(ra_dids, IsFCRA, , , true, checkRNA:=true, includeDOD:=true, modAccess := mod_access)(dod = '');

	relr						:= join(ra_recs(isRelative), ra_best, left.person2 = right.did, transform(AddressReport_Services.Layouts.rel_asst_layout, self := left, self := right));
	assr						:= join(ra_recs(~isRelative), ra_best, left.person2 = right.did, transform(AddressReport_Services.Layouts.rel_asst_layout, self := left, self := right));
		
	//************************************* //
	// Getting Data from Services - End     //
	//************************************* //

	//************************************* //
	// Filter records based on address      //
	//************************************* //

	Property_filtered_addr := Property(parties(party_type = 'P')[1].prim_range=split_addr.prim_range,
																		 parties(party_type = 'P')[1].prim_name=split_addr.prim_name,
																		 parties(party_type = 'P')[1].st=split_addr.st
																			);

	Property_filtered				:=AddressReport_Services.fn_filter_property(Property_filtered_addr);

	//*********************************************
	Bankruptcies_filtered		:=iesp.transform_bankruptcy(Bankruptcies);
	vehicles_filtered				:=vehicles;							
	LiensJudgments_filtered	:=LiensJudgments;
	Phones									:=doxie.fn_AppendGongByAddr(gong_input);
	phones_Filtered					:=project(dedup(phones(not(publish_code = 'N' or omit_phone = 'Y')),phone),
																		transform (AddressReport_Services.layouts.phone_out_layout, Self.name_first := Left.fname;
																							 Self.name_last := Left.lname; Self := Left));
	
	//Old business header
	business_recs_old				:=dedup(project(Location_Services.business_records(bus_input),transform(
																					AddressReport_Services.layouts.layout_Business_out,
																					self.zip:=(string) left.zip,
																					self.zip4:=(string) left.zip4,
																					self:=left, self := [])),all);
																						
	//Remove Invalid address records from business
	AddressReport_Services.Mac_address_Filter(business_recs_old,
																						prim_name,
																						prim_range,
																						predir,
																						postdir,
																						addr_suffix,
																						sec_range,
																						city,
																						state,
																						zip,
																						res_input,
																						business_recs_out_old
																						);	
	
	business_recs_all_old	:=dedup(sort(business_recs_out_old,bdid),bdid);
	
	key_gong_bus			:=Gong.Key_History_BDID;
	rec_bus	:=record
		AddressReport_Services.layouts.layout_Business_out;
		boolean gong_flag;
	end;

	rec_bus flag_bus_old(business_recs_all_old l,key_gong_bus r):=TRANSFORM
		self.gong_flag:=if(trim(r.phone10)<>'',true,false);
		self.phone:=if(trim(r.phone10)<>'',(unsigned)r.phone10,l.phone);
		self:=l;
	END;

	business_recs_gong_old:=join(business_recs_all_old,key_gong_bus,
											keyed(LEFT.bdid=right.bdid) and right.current_record_flag='Y',
											flag_bus_old(LEFT,RIGHT),limit(ut.limits.DEFAULT),keep(1),left outer);
	
	//New Business header
	business_recs_new				:= Location_Services.GetByBusinessIDs(bus_input).linkIdsBestOut;
			
	//Remove Invalid address records from business
	AddressReport_Services.Mac_address_Filter(business_recs_new,
																						prim_name,
																						prim_range,
																						predir,
																						postdir,
																						addr_suffix,
																						sec_range,
																						city,
																						state,
																						zip,
																						res_input,
																						business_recs_out_new
																						);	
																						
	// business_recs_all_new	:=dedup(sort(business_recs_out,bdid),bdid);
	//no need to dedup, new business header records are already unique by BIP ids
	gong_in := project(business_recs_out_new, BIPV2.IDlayouts.l_xlink_ids);
	gong_out := Gong.key_History_LinkIDs.kfetch(gong_in, param.BusinessReportFetchLevel);
	
	rec_bus flag_bus_new(business_recs_out_new l,gong_out r):=TRANSFORM
		self.gong_flag	:=if(trim(r.phone10)<>'',true,false);
		self.phone			:=if(trim(r.phone10)<>'',(unsigned)r.phone10,(unsigned)l.company_phone);
		self.fein				:=(unsigned)l.company_fein;
		self						:=l;
		self.group_id		:=0;
	END;
	business_recs_gong_new:=join(business_recs_out_new,gong_out,
		BIPV2.IDmacros.mac_JoinLinkids(param.BusinessReportFetchLevel) and right.current_record_flag='Y',
		flag_bus_new(LEFT,RIGHT),keep(1),left outer);
	
	//Decide which business records to use based on useNewBusinessHeader boolean flag
	business_recs			:= if(param.useNewBusinessHeader, business_recs_gong_new, business_recs_gong_old);

	// Get Census info
	census_data 	:= census_data.Key_Smart_Jury
										(stusab = split_addr.st and
										 county = split_addr.county[3..5] and
										 tract 	= split_addr.geo_blk[1..6] and
										 blkgrp = split_addr.geo_blk[7]);		
	//************************** Final records **************************************

	census_final								:= AddressReport_Services.Functions.ProjectCensus(census_data[1]);
	Vehicle_Final 							:= iesp.transform_vehicles(choosen(vehicles_filtered,AddressReport_Services.Constants.MaxVehicles));
	Neighbors_Final 						:= choosen(Neighbors_filtered,AddressReport_Services.Constants.MaxNeighbors);
	dlsr_final 									:= choosen(dlsr_filtered,AddressReport_Services.constants.MaxDLs);
	// it'll be a slicing projection from "wide_tmp" layout to "wide"
	dlsr_present  							:= AddressReport_Services.Functions.ProjectDL(dlsr_final(history=''));
	dlsr_prior    							:= AddressReport_Services.Functions.ProjectDL(dlsr_final(history<>''));
	LJ_final	    							:= AddressReport_Services.Functions.ProjectLiens(choosen(LiensJudgments_filtered,AddressReport_Services.constants.MaxLiens));
	prop_tmp	    							:= choosen(sort(Property_filtered,-current_record),AddressReport_Services.constants.MaxProperties);
	prop_present  							:=AddressReport_Services.Functions.ProjectProp(prop_tmp(current_record='Y'));
	prop_prior    							:=AddressReport_Services.Functions.ProjectProp(prop_tmp(current_record<>'Y'));

	Bankruptcies_final 					:= choosen(Bankruptcies_filtered,AddressReport_Services.constants.MaxBankruptcies);
	Phones_Res_Raw							:= phones_Filtered(business_flag=false);
	Phones_Bus_Raw							:= phones_Filtered(business_flag=true);

	phones_Bus									:= AddressReport_Services.Functions.ProjectPhones(choosen(Phones_Bus_Raw,AddressReport_Services.constants.MaxPhonesBus));
	phones_Res									:= AddressReport_Services.Functions.ProjectPhones(choosen(Phones_Res_Raw,AddressReport_Services.constants.MaxPhonesRes));
	phones_All									:= phones_Bus+phones_Res;

	Business_Final							:= choosen(sort(business_recs,gong_flag,company_name),AddressReport_Services.constants.MaxBusiness);
	Business_prior							:= AddressReport_Services.Functions.ProjectBusiness(project(Business_Final(gong_flag=false),AddressReport_Services.layouts.layout_Business_out));
	Business_present						:= AddressReport_Services.Functions.ProjectBusiness(project(Business_Final(gong_flag=true),AddressReport_Services.layouts.layout_Business_out));
	Business_all								:= AddressReport_Services.Functions.ProjectBusiness(project(sort(Business_Final, -dt_last_seen), AddressReport_services.Layouts.layout_Business_out));

	Residents_cur								:= AddressReport_Services.Functions.ProjectPresentResidents(choosen(Res_cur,AddressReport_Services.constants.MaxResidents), param.LocationReport);
	Residents_prior							:= AddressReport_Services.Functions.ProjectPriorResidents(choosen(Res_prior,AddressReport_Services.constants.MaxResidents));
	relatives										:= AddressReport_Services.Functions.projectRelativeAssociate(relr);
	associates									:= AddressReport_Services.Functions.projectRelativeAssociate(assr);
	possible_owners							:= AddressReport_Services.Functions.projectPossibleOwner(own_recs);

	possible_vehicles1					:= AddressReport_Services.Functions.projectVehicles(vehicle_recs, row(res_input[1],AddressReport_Services.layouts.in_address));
	// Join possible_vehicles0 recs to the dataset of current residents to set ResidentUniqueId field
  possible_vehicles2          := join(possible_vehicles1,Res_cur0,
 																      left.registrant_did = right.did  
																      OR
																      (left.AssociatedToReportAddress          and
																       left.RegistrantName.First = right.fname and
																       left.RegistrantName.Last  = right.lname
																      ),
														          transform(iesp.addressreport.t_AddrReportPossibleVehicles,
														          // when join condition met, set resident did
														          self.ResidentUniqueId := if(right.did !=0, 
															                                    intformat(right.did,12,1),'');
															        self := left),
	                                    LEFT OUTER, ALL); // keep left ds rec even if no match to right
 	// Sort to put into resident/rptaddr/neighbors(street name, number, etc.) order???
  possible_vehicles           := sort(possible_vehicles2,
 	                                    //vehicles for residents/rpt addr first
	                                    if(ResidentUniqueId !='',0,1), // so non-blank dids sort to the top 
																			-AssociatedToReportAddress, // descending so recs with "true" sort to the top
																			// then vehicles for neighbors in order by street name, number, etc.
																			RegistrantAddress.StreetName, RegistrantAddress.StreetPreDirection,
																			RegistrantAddress.StreetNumber, RegistrantAddress.StreetPostDirection,
																			RegistrantAddress.UnitNumber,
																			RegistrantName.Last, RegistrantName.First, 
																			RegistrantName.Middle, RegistrantName.Suffix,
																			-YearMake, Make, Model);

	possible_hf1    		        := AddressReport_Services.Functions.projectHuntFish(hf_recs, row(res_input[1],AddressReport_Services.layouts.in_address));
	// Join possible_hf0 recs to the dataset of current residents dids to set ResidentUniqueId field
	possible_hf2                := join(possible_hf1,cur_dids,
	                                      left.licensee_did = right.did,
														          transform(iesp.addressreport.t_AddrReportPossibleHuntingFishing,
														          // when join condition met, set resident did
														          self.ResidentUniqueId := if(right.did !=0, 
															                                    intformat(right.did,12,1),'');
															        self := left),
	                                    LEFT OUTER); // keep left ds rec even if no match to right
 	// Sort to put into resident/rptaddr/neighbors(street name, number, etc.) order
  possible_hf                := sort(possible_hf2,
 	                                    //hf lics for residents/rpt addr first
	                                    if(ResidentUniqueId !='',0,1), // so non-blank dids sort to the top 
																			-AssociatedToReportAddress, // descending so recs with "true" sort to the top
																			// then hf lics for neighbors in order by street name, number, etc.
																			Address.StreetName, Address.StreetPreDirection,
																			Address.StreetNumber, Address.StreetPostDirection,
																			Address.UnitNumber,
																			Name.Last, Name.First, Name.Middle, Name.Suffix,
																			HomeState, LicenseState, LicenseType, 
																			-IssueDate.Year, -IssueDate.Month, -IssueDate.Day);

	possible_other_occupants		:= AddressReport_Services.Functions.projectOtherOccupants(Neighbors_filtered.NeighborAddresses);
	possible_crim								:= AddressReport_Services.Functions.projectCrim(nbr_crim_recs);
	possible_so									:= AddressReport_Services.Functions.projectSexOffenders(nbr_so_recs);

	boolean Display_Prop_msg								:= if(param.Include_Properties and count(Property_filtered)>AddressReport_Services.Constants.MaxProperties,true,false);
	boolean Display_Leins_msg								:= if(param.Include_LiensJudgments and count(LiensJudgments_filtered)>AddressReport_Services.Constants.MaxLiens,true,false);
	boolean Display_Neighbors_msg 					:= if(param.Include_Neighbors and count(Neighbors_recs)>AddressReport_Services.Constants.MaxNeighbors,true,false);
	boolean Display_Business_msg 						:= if(param.Include_Businesses and count(business_recs)>AddressReport_Services.Constants.MaxBusiness,true,false);
	boolean Display_Residents_msg 					:= if(count(residents)>AddressReport_Services.Constants.MaxResidents,true,false);
	boolean Display_CriminalRecords_msg 		:= if(param.include_CriminalRecords and count(Crims_filtered)>AddressReport_Services.Constants.MaxCriminalRecords,true,false);
	boolean Display_SexOffensesRecords_msg	:= if(param.include_SexualOffenses and count(sexOffender_filtered)>AddressReport_Services.Constants.MaxSexualOffenses,true,false);
	boolean Display_HuntFishRecords_msg 		:= if(param.include_HuntingFishingLicenses and count(Hunting_Filtered)>AddressReport_Services.Constants.MaxHuntingandFishing,true,false);
	boolean Display_WeaponRecords_msg 			:= if(param.include_WeaponPermits and count(formatedFilteredWeaponRecords)>AddressReport_Services.Constants.MaxWeaponPermits,true,false);


	ph_blank 			:= dataset([],iesp.share.t_PhoneInfo);
	Select_phones	:= MAP(param.Include_BusinessPhones and param.Include_ResidentialPhones =>phones_All,
											 param.Include_BusinessPhones =>phones_Bus,
											 param.Include_ResidentialPhones =>phones_Res,
											 ph_blank);

	//**************************************************************** //
	////////////////// Main Transform //////////////////////////////////
	//**************************************************************** //	

	AddressReport_Services.Layouts.iesp_out_plus_royalties_layout Format_Final():=transform
		self.ReportResponse._Header														:=iesp.ECL2ESP.GetHeaderRow();
		self.ReportResponse.Residents.Remark									:=if(Display_Residents_msg,AddressReport_Services.constants.msg(AddressReport_Services.constants.MaxResidents,'Residents'),'');
		self.ReportResponse.Residents.present									:= Residents_cur;
		self.ReportResponse.Residents.Prior										:= Residents_prior;
		self.ReportResponse.CensusData												:=if(param.Include_CensusData, 		GLOBAL(census_final));
		self.ReportResponse.VehiclesX.Present									:=if(param.Include_MotorVehicles, 	GLOBAL(vehicle_final(historyflag='CURRENT')));
		self.ReportResponse.VehiclesX.Prior										:=if(param.Include_MotorVehicles, 	GLOBAL(vehicle_final(historyflag='HISTORICAL')));
		self.ReportResponse.PhonesX.Business									:=if(param.Include_BusinessPhones,						GLOBAL(phones_Bus));
		self.ReportResponse.PhonesX.Residential								:=if(param.Include_ResidentialPhones,						GLOBAL(phones_res));
		self.ReportResponse.DriverLicenses.Present2						:=if(param.Include_DriversLicenses, GLOBAL(dlsr_present));
		self.ReportResponse.DriverLicenses.Prior2							:=if(param.Include_DriversLicenses, GLOBAL(dlsr_prior));
		self.ReportResponse.Properties.Remark 								:=if(Display_Prop_msg,AddressReport_Services.constants.msg(AddressReport_Services.constants.MaxProperties,'Properties'),'');
		self.ReportResponse.Properties.present								:=if(param.Include_Properties, 								GLOBAL(prop_present));
		self.ReportResponse.Properties.prior									:=if(param.Include_Properties, 								GLOBAL(prop_prior));
		self.ReportResponse.Neighbors.Remark									:=if(Display_Neighbors_msg,AddressReport_Services.constants.msg(AddressReport_Services.constants.MaxNeighbors,'Neighbors'),'');
		self.ReportResponse.Neighbors.Neighbors2							:=if(param.include_Neighbors, 					GLOBAL(Neighbors_Final));
		self.ReportResponse.Businesses.Remark									:=if(Display_Business_msg,AddressReport_Services.constants.msg(AddressReport_Services.constants.MaxBusiness,'Businesses'),'');
		self.ReportResponse.Businesses.present								:=if(param.Include_Businesses,						GLOBAL(Business_present));
		self.ReportResponse.Businesses.prior									:=if(param.Include_Businesses,						GLOBAL(Business_prior));
		self.ReportResponse.LiensJudgments.remark							:=if(Display_Leins_msg,AddressReport_Services.constants.msg(AddressReport_Services.constants.MaxLiens,'LiensAndJudgments'),'');
		self.ReportResponse.LiensJudgments.LiensJudgments 		:=if(param.include_LiensJudgments, 							GLOBAL(LJ_final));
		self.ReportResponse.Vehicles													:=if(param.Include_MotorVehicles,CHOOSEN(GLOBAL(Vehicle_Final),iesp.constants.AR.MaxVehicles));
		self.ReportResponse.Phones														:=CHOOSEN(GLOBAL(Select_phones),iesp.constants.AR.MaxPhones);
		self.ReportResponse.Bankruptcies											:=if(param.include_bankruptcy,CHOOSEN(GLOBAL(Bankruptcies_final),iesp.constants.AR.MaxBankruptcies));
		self.ReportResponse.Address														:=iesp.ECL2ESP.SetAddress (
																														split_addr.prim_name, split_addr.prim_range, split_addr.predir, split_addr.postdir,
																														split_addr.addr_suffix, split_addr.unit_desig, split_addr.sec_range,
																														split_addr.v_city_name, split_addr.st, split_addr.zip, split_addr.zip4, '');
		//maintenance 03/30/2011													
		self.ReportResponse.CriminalRecords.remark         		:=if(Display_CriminalRecords_msg,AddressReport_Services.constants.msg(AddressReport_Services.Constants.MaxCriminalRecords,'CriminalRecords'),'');
		self.ReportResponse.CriminalRecords.CriminalRecords 	:=if(param.include_CriminalRecords, 	GLOBAL(choosen(Crims_filtered,AddressReport_Services.Constants.MaxCriminalRecords)));
		self.ReportResponse.SexualOffenses.remark           	:=if(Display_SexOffensesRecords_msg,AddressReport_Services.constants.msg(AddressReport_Services.Constants.MaxSexualOffenses,'SexualOffenses'),'');
		self.ReportResponse.SexualOffenses.SexualOffenses	 		:=if(param.include_SexualOffenses, 	GLOBAL(choosen(sexOffender_filtered,AddressReport_Services.Constants.MaxSexualOffenses)));
		self.ReportResponse.HuntingFishings.remark          	:=if(Display_HuntFishRecords_msg,AddressReport_Services.constants.msg(AddressReport_Services.Constants.MaxHuntingandFishing,'HuntingAndFishings'),''); 	
		self.ReportResponse.HuntingFishings.HuntingFishings 	:=if(param.include_HuntingFishingLicenses, 	GLOBAL(choosen(Hunting_Filtered,AddressReport_Services.Constants.MaxHuntingandFishing)));
		self.ReportResponse.ConcealedWeapons.remark         	:=if(Display_WeaponRecords_msg,AddressReport_Services.constants.msg(AddressReport_Services.Constants.MaxWeaponPermits,'ConcealedWeapons'),''); 	
		self.ReportResponse.ConcealedWeapons.ConcealedWeapons	:=if(param.include_WeaponPermits, 	GLOBAL(choosen(formatedFilteredWeaponRecords,AddressReport_Services.Constants.MaxWeaponPermits)));
		//end maintance 03/30/2011
		self:=[];
	end;
	addressReport 	:= dataset([Format_Final()]);
	
	AddressReport_Services.Layouts.iesp_out_plus_royalties_layout Format_LocationFinal():=transform
		self.ReportResponse._Header																		:=iesp.ECL2ESP.GetHeaderRow();
		self.ReportResponse.Residents.present													:= Residents_cur;
		self.ReportResponse.CriminalRecords.CriminalRecords						:= if(param.locationReport, GLOBAL(choosen(res_crim_recs, AddressReport_Services.Constants.MaxCriminalRecords)));
		self.ReportResponse.SexualOffenses.SexualOffenses	 						:= if(param.locationReport, GLOBAL(choosen(res_so_recs,AddressReport_Services.Constants.MaxSexualOffenses)));
		self.ReportResponse.ConcealedWeapons.ConcealedWeapons					:= if(param.locationReport, GLOBAL(choosen(res_cw_recs,AddressReport_Services.Constants.MaxWeaponPermits)));
		self.ReportResponse.Relatives																	:= if(param.locationReport,	GLOBAL(choosen(relatives, AddressReport_Services.Constants.MaxRelatives)));
		self.ReportResponse.Associates																:= if(param.locationReport,	GLOBAL(choosen(associates, AddressReport_Services.Constants.MaxAssociates)));
		self.ReportResponse.PossibleNeighbors.PossibleOwners					:= if(param.locationReport, GLOBAL(choosen(possible_owners, AddressReport_Services.Constants.MaxOwners)));
		self.ReportResponse.PossibleNeighbors.PossibleVehicles				:= if(param.locationReport, GLOBAL(choosen(possible_vehicles, AddressReport_Services.Constants.MaxVehicles)));
		self.ReportResponse.PossibleNeighbors.PossibleOccupants				:= if(param.locationReport, GLOBAL(choosen(possible_other_occupants, AddressReport_Services.Constants.MaxNeighbors)));
		self.ReportResponse.PossibleNeighbors.PossibleBusinesses			:= if(param.locationReport, GLOBAL(choosen(Business_all, AddressReport_Services.Constants.MaxBusiness)));
		self.ReportResponse.PossibleNeighbors.PossibleCriminalRecords	:= if(param.locationReport, GLOBAL(choosen(possible_crim, AddressReport_Services.Constants.MaxCriminalRecords)));
		self.ReportResponse.PossibleNeighbors.PossibleSexualOffenses	:= if(param.locationReport, GLOBAL(choosen(possible_so, AddressReport_Services.Constants.MaxSexualOffenses)));
		self.ReportResponse.PossibleNeighbors.PossibleConcealedWeapons:= if(param.locationReport, GLOBAL(choosen(nbr_cw_recs, AddressReport_Services.Constants.MaxWeaponPermits)));
		self.ReportResponse.PossibleNeighbors.PossibleHuntingsFishings:= if(param.locationReport, GLOBAL(choosen(possible_hf, AddressReport_Services.Constants.MaxHuntingandFishing)));
		self.Royalties																								:= if(param.locationReport, Res_cur_raw.Royalties);
		self := [];
	end;

	locationReport 	:= dataset([Format_LocationFinal()]);
	
	finalReport			:= if(param.locationReport, locationReport, addressReport);

	ds_invalid_addr:= srchrec((p_city_name='NOCITYNAME' or p_city_name='') or
						(prim_name='' and prim_range='') or
						zip='');
	boolean invalid_addr:= if(exists(ds_invalid_addr),true,false);
	AddressReport_Services.Layouts.iesp_out_plus_royalties_layout blank_fmt():=transform
		self.ReportResponse._Header 	:=iesp.ECL2ESP.GetHeaderRow();
		self:=[];
	end;
	ds_blank:=dataset([blank_fmt()]);
	
	individual := if(invalid_addr,ds_blank,finalReport);
	
  // Uncomment as needed for debugging	
	//output(Res_cur0,                         named('Res_cur0'));
	//output(cur_dids,                         named('cur_dids'));
	//output(nbr_dids,                         named('nbr_dids'));
  //output(veh_ids_for_addr,                 named('veh_ids_for_addr'));
	//output(veh_ids_for_curdids,              named('veh_ids_for_curdids'));
	//output(veh_ids_for_resaddr_dd,           named('veh_ids_for_resaddr_dd'));
	//output(veh_ids_ra_vk_deduped,            named('veh_ids_ra_vk_deduped'));
  //output(veh_ra_partyrecs,                 named('veh_ra_partyrecs'));
	//output(veh_ra_pr_dd,                     named('veh_ra_pr_dd'));
  //output(veh_ids_for_resaddr_stillowned,   named('veh_ids_for_resaddr_stillowned'));
  //output(veh_ids_for_resaddr_touse,        named('veh_ids_for_resaddr_touse'));
  //output(current_date,                     named('current_date'));
  //output(FiveYearsBack,                    named('FiveYearsBack'));
  //output(vehicle_recs_resaddr_vehraw,      named('vehicle_recs_resaddr_vehraw'));
  //output(vehicle_recs_resaddr_vehraw_kept, named('vehicle_recs_resaddr_vehraw_kept'));
 	//output(veh_ids_for_nbrdids,              named('veh_ids_for_nbrdids'));
  //output(vehicle_recs_nbr_vehraw,          named('vehicle_recs_nbr_vehraw'));
  //output(vehicle_recs,                     named('vehicle_recs'));
  //output(hf_rids_for_dids,                 named('hf_rids_for_dids'));
  //output(hf_rids_for_addr,                 named('hf_rids_for_addr'));
  //output(hf_raw_info,                      named('hf_raw_info'));
	//output(hf_raw_info_deduped,              named('hf_raw_info_deduped'));
	//output(hf_recs,                          named('hf_recs'));

  //output(Residents_cur,                  named('residents_cur'));	
	//output(possible_vehicles1,             named('possible_vehicles1'));
	//output(possible_vehicles2,             named('possible_vehicles2'));
	//output(possible_vehicles,              named('possible_vehicles'));
	//output(possible_hflics1,               named('possible_hflics1'));
	//output(possible_hflics2,               named('possible_hflics2'));
	//output(possible_hflics,                named('possible_hflics'));

	return individual;
end;
