import doxie,doxie_cbrs,suppress,watercraft,ut, fcra,FFD;

EXPORT WatercraftV2_raw := MODULE

	//*******
	//******* Only join bdids to the master file because all bdids should be there
	//*******
	shared outrec := watercraftV2_services.Layouts.search_watercraftkey;
	
	export get_watercraftkeys_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids) := function
	  key := watercraft.Key_watercraft_Bdid;

		res := join(dedup(sort(in_bdids,bdid),bdid),key,
		            keyed(left.bdid = right.L_bdid),
								transform(outrec,
													self := right),
								keep(ut.limits.WATERCRAFT_PER_BDID), limit(0));

		ded := dedup(sort(res,watercraft_key,sequence_key,state_origin),watercraft_key,sequence_key,state_origin);
		return ded;
	end;


	export get_watercraftkeys_from_dids(dataset(doxie.layout_references) in_dids, 
																		 boolean IsFCRA = false) :=function
		key := watercraft.key_watercraft_did (IsFCRA);
		res := join(dedup(sort(in_dids,did),did),key,
		            keyed(left.did = right.l_did),
								transform(outrec,
													self.subject_did := right.l_did,
													self := right),
								keep(ut.limits.WATERCRAFT_PER_DID), limit(0));
		ded :=dedup(sort(res,watercraft_key,sequence_key,state_origin),watercraft_key,sequence_key,state_origin);
		return ded;
	end;

	export get_watercraftkeys_from_hullnum(dataset(WatercraftV2_services.Layouts.search_hullnum) in_hullnum) :=function
		key :=watercraft.key_watercraft_hullnum;
		res :=join(in_hullnum,key,
							keyed(left.hull_num =right.hull_number), 
							transform(outrec,
												self:=right),
							keep(ut.limits.WATERCRAFT_PER_HULL), limit(0));
		return (dedup(sort(res,watercraft_key,sequence_key,state_origin),watercraft_key,sequence_key,state_origin));
	end;

	export get_watercraftkeys_from_offnum(dataset(WatercraftV2_services.Layouts.search_offnum) in_offnum) :=function
		key :=watercraft.key_watercraft_offnum;
		res :=join(in_offnum,key,
							keyed(left.off_num =right.official_number), 
							transform(outrec,
												self:=right),
							keep(ut.limits.WATERCRAFT_PER_OFFNUM), limit(0));
		return (dedup(sort(res,watercraft_key,sequence_key,state_origin),watercraft_key,sequence_key,state_origin));
	end;


	export get_watercraftkeys_from_vesselname(dataset(WatercraftV2_services.layouts.search_vesselname) in_vesselname) :=function
		key :=watercraft.key_watercraft_vslnam;
		res :=join(in_vesselname,key,
							keyed(left.vessel_name =right.vessel_name[1..length(trim(left.vessel_name))]), 
							transform(outrec,
												self:=right),
							keep(ut.limits.WATERCRAFT_PER_NAME), limit(0));
		return (dedup(sort(res,watercraft_key,sequence_key,state_origin),watercraft_key,sequence_key,state_origin));
	end;

		
  EXPORT report_view := MODULE
	

		export by_watercraftkey (dataset(outrec) in_watercraftkeys,
														string in_ssn_mask_type = '', 
														boolean isReport = false, 
														boolean IsFCRA = false,	
														dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
														boolean include_non_regulated_sources = false,
														dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
														integer8 inFFDOptionsMask = 0):= function
														
		  return project(watercraftV2_services.get_watercraft(in_watercraftkeys,in_ssn_mask_type,IsFCRA, 
																														flagfile, include_non_regulated_sources,
																														slim_pc_recs, inFFDOptionsMask).report(isReport),
										 watercraftV2_Services.layouts.report_out);
		end;
		
		
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
									string in_ssn_mask_type = '',
									boolean include_non_regulated_sources = false
									) := function
			watercraft_keys := get_watercraftkeys_from_bdids(in_bdids);
		  return by_watercraftkey(watercraft_keys,in_ssn_mask_type,,,,include_non_regulated_sources);
		end;

		export by_did (dataset(doxie.layout_references) in_dids,
										string in_ssn_mask_type = '', 
										boolean isReport = false, 
										boolean IsFCRA = false,	
										dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
										unsigned1 non_subject_suppression = 1,
										boolean include_non_regulated_sources = false,
										dataset(FFD.Layouts.PersonContextBatchSlim ) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
										integer8 inFFDOptionsMask = 0
										) := function
										
      keyes := get_watercraftkeys_from_dids(in_dids,IsFCRA);
			recs := by_watercraftkey(keyes,in_ssn_mask_type,isReport,IsFCRA, flagfile,include_non_regulated_sources,slim_pc_recs,inFFDOptionsMask);
			
			//Handle non-subject found records
			WatercraftV2_Services.Layouts.report_out xformNonSubject(watercraftV2_Services.layouts.report_out L) := transform
				non_bus_owners := L.owners(company_name = '' or did <> '');
				bus_owners := L.owners(~(company_name = '' or did <> ''));
				owners_supp := project(join(non_bus_owners, in_dids, 
																		(integer)left.did = right.did, 
																		transform(left), keep(1)) + bus_owners,
															 transform(WatercraftV2_Services.Layouts.owner_report_rec,
																				 self.orig_name := '', 
																				 self := left)); //only keep the subjects that have a DID in incoming in_dids or are a company
				
				owners_returnNameOnly := join(L.owners, in_dids, 
																			(integer)left.did = right.did, 
																			transform(WatercraftV2_Services.Layouts.owner_report_rec,
																				self.fname := left.fname, 
																				self.mname := left.mname, 
																				self.lname := left.lname, 
																				self.name_suffix := left.name_suffix, 
																				self := []),LEFT ONLY);
																				
        owners_restricted := project(owners_returnNameOnly,
																	transform(WatercraftV2_Services.Layouts.owner_report_rec,
																						self.lname := FCRA.Constants.FCRA_Restricted,
																						self := []));
				
				self.owners := map(non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => owners_supp + owners_restricted, 
													 non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnNameOnly => owners_supp + owners_returnNameOnly, 
													 non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank => owners_supp,
													 isFCRA => owners_restricted, //if we have isFCRA and we didn't specify 2 or 3 let's do an override of co-owners. 
													 //The goal here is not to force the isFCRA = true to enter a non_subject_suppression... 
													 //if we want to allow non_subject_suppression = 1 with isFCRA = true then this will need to be changed
													 L.owners);
				self := L;
			end;
			filter := project(recs, xformNonSubject(left));
										 
			res := if(isFCRA or non_subject_suppression <> Suppress.Constants.NonSubjectSuppression.doNothing, filter, recs);									 

			return res;
		end;
		
	END;

END;