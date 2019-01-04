import insuranceHeader_hhid, InsuranceHeader_PostProcess, idops, orbit, _Control;

export proc_hhid(string iter) := module
		#workunit('name','Prod HHID Build');
		

		// Salt Iteration
		shared hhid_ds 						:= insuranceHeader_hhid.HHID_Table_Final;
		shared new_hhid_file				:= insuranceHeader_hhid.files.household_file + iter; 		
		// Generate new household file
		shared opFile 						:= output(hhid_ds, , new_hhid_file, overwrite,compressed);		
		
		// Update super file
		shared updateSuperFile  		:= insuranceHeader_hhid.files.updateHHIDSuperFiles(new_hhid_file);
						
		// stats
		statsLayout := record
			STRING40 stat_name;
			STRING30 stat_value;
		END;
		
		hhids := InsuranceHeader_HHID.files.household_ds;  // current base file
		hhids_father := InsuranceHeader_HHID.files.household_father_ds;  // previous built version
		//hhids_father := distribute(dataset([], InsuranceHeader_HHID.layout_hhid),hash(did));
		buildDate := max(hhids ,last_current);						// last update build
		
		newhhids := hhids(last_current=buildDate and first_current=buildDate);	// new hhid records	
		updates := hhids(last_current=buildDate and last_current <> first_current); // new update records
		no_updates := hhids(last_current <> buildDate);   // no update records

		/*
			Create the stats related to dids for HHID file 
			TOTAL DID = the total number of unique DIDs in the current HHID build.
			TOTAL DID ADDED = the total number of new DIDs in the current HHID build 
			TOTAL DID UPDATED = the total number of DIDs that have new HHID number. (people that moved)
			TOTAL DID NOT UPDATED = the total number of DID that have the same valid HHID.
			TOTAL DID REMAINING = the total number of DID that HHID did not have dates updated, maybe 
				because no best address was identified in the build.  Usually history.
		*/
		statsLayout createDidStats() := FUNCTION
			// find stats for dids				
			hhid_did_D := distribute(hhids, hash(did));
			hhid_father_did_D := distribute(hhids_father, hash(did));		
				
			// did stats
			dids_count := count(dedup(sort(hhid_did_D, did, local), did, local));		
		
			// dids_added = dids that are new in the current build.
			dids_added := join(hhid_did_D, hhid_father_did_D, left.did = right.did, left only, local);
			dids_added_count := count(dedup(sort(dids_added, did, local), did, local));
			
			// dids_updated = dids that moved addresses, so they are in the father key
			dids_updated := join(hhid_did_D, hhid_father_did_D, 
											left.did = right.did, local)  
											(last_current=buildDate and first_current=buildDate);	

			dids_updated_count := count(dedup(sort(dids_updated, did, local), did, local));					
		
			// dids_not_updated = did that still have the same address.
			dids_not_updated := join(hhid_did_D, hhid_father_did_D, 
											left.did = right.did, local) (last_current=buildDate and last_current <> first_current);
											
			did_not_updated_count := count(dedup(sort(dids_not_updated, did, local), did, local));
		
			currentDids:= distribute(dids_added + dids_updated + dids_not_updated, hash(did));
			historicalDids := join(hhid_did_D, currentDids, left.did = right.did, left only, local);
			hist_did_count := count(dedup(sort(historicalDids, did, local), did, local));
		
			statsDs := DATASET([	{'TOTAL DID ' , dids_count},
													{'TOTAL DID ADDED', dids_added_count},  // dids with new hhhids
													{'TOTAL DID UPDATED', dids_updated_count},  // dids with updated hhids
													{'TOTAL DID NOT UPDATED', did_not_updated_count}, // dids with no updated hhids													
													{'TOTAL DID REMAINING', hist_did_count}], statsLayout);
													
			RETURN statsDs;
		END;
			
		/*
			TOTAL HHID = total number of unique HHID
			TOTAL HHID ADDED = total number of unique HHID created
			TOTAL HHID UPDATED = total number of unique HHID records with last_current data updated.
			TOTAL HHID NOT UPDATED = total number of unique HHID where no new address or last_current date was updated.
			TOTAL HHID DELETED = total number of unique HHID in previous file not in the current file
			TOTAL HHID FOR SINGLETON DIDS = total number unique HHID that belongs to singleton clusters. 
		*/
		statsLayout createHHIDStats() := FUNCTION			
			// hhid stats
			hhid_count := count(dedup(sort(hhids, hhid), hhid));			
			hhid_added_count := count(dedup(sort(newhhids, hhid), hhid));			
			hhid_updated_count := count(dedup(sort(updates, hhid), hhid));
		
			updates_hhid_D := distribute(updates, hash(hhid));
			no_updates_hhid_D := distribute(no_updates, hash(hhid));			
			no_updates_hhid1_D := distribute(join(no_updates_hhid_D, updates_hhid_D, 
													left.hhid = right.hhid, 
													left only, local), hash(hhid));
													
			newhhids_D := distribute(newhhids, hash(hhid));		
			no_updates_hhid1 := join(no_updates_hhid1_D, newhhids_D, 
																	left.hhid = right.hhid, 
																	left only, local);		
			hhid_not_updated_count := count(dedup(sort(no_updates_hhid1, hhid, local), hhid, local)) ;
				
			// deleted hhid.
			hhids_father_hhid_D := distribute(hhids_father, hash(hhid));			
			hhids_current_D := distribute(hhids, hash(hhid));
			hhid_deleted := join(hhids_father_hhid_D, hhids_current_D, left.hhid = right.hhid, left only, local);
			hhid_deleted_count := count(dedup(sort(hhid_deleted, hhid, local), hhid, local));
			
			// HHID for singleton dids		
			singleton_dids := distribute(InsuranceHeader_PostProcess.corecheck(cnt=1), hash(did));
			hhid_singleton := join(hhids, singleton_dids, left.did = right.did, local);		
			hhid_singleton_count := count(dedup(sort(hhid_singleton, hhid, local), hhid, local));
		
			statsDs := DATASET([{'TOTAL HHID' , hhid_count},
													{'TOTAL HHID ADDED' , hhid_added_count},
													{'TOTAL HHID UPDATED', hhid_updated_count}, 
													{'TOTAL HHID NOT UPDATED', hhid_not_updated_count},
													{'TOTAL HHID DELETED', hhid_deleted_count},
													{'TOTAL HHID FOR SINGLETON DIDS', hhid_singleton_count}], statsLayout);
		
			RETURN statsDs;
			
		END;
		
		/*
			TOTAL HHIDINDIV = total number of unique HHIDINDIV
			TOTAL HHIDINDIV ADDED = total number of unique HHIDINDIV created
			TOTAL HHIDINDIV UPDATED = total number of updated HHIDINDIV, includes new hhids, updated hhids and new dids.
			TOTAL HHIDINDIV NOT UPDATED = total number of HHIDINVI with no updates at all.
			TOTAL HHIDINDIV DELETED = total number of unique HHIDINDIV in the previous build not in the current.
		*/
		statsLayout createHHIDINDIVStats() := FUNCTION
			// hhid_indiv stats
			hhidindiv_count := count(dedup(sort(hhids, hhid_indiv), hhid_indiv));			
			hhid_hhidindiv_D := distribute(hhids, hash(hhid_indiv));
			hhid_father_hhidindiv_D := distribute(hhids_father, hash(hhid_indiv));
			hhidindiv_added := join(hhid_hhidindiv_D, hhid_father_hhidindiv_D, 
															left.hhid_indiv = right.hhid_indiv, 
															left only, local);
			hhidindiv_added_count := count(dedup(sort(hhidindiv_added, hhid_indiv, local), hhid_indiv, local));
			
			newhhids_hhidindiv_D := distribute(newhhids, hash(hhid_indiv));		
			updates_noupdates_hhidindiv := join(hhid_hhidindiv_D, hhidindiv_added, left.hhid_indiv = right.hhid_indiv, left only, local);
			updates_hhidindiv := updates_noupdates_hhidindiv(last_current=buildDate);
			noUpdates_hhidindiv := join(updates_noupdates_hhidindiv(last_current<>buildDate), updates_hhidindiv, 
				 left.hhid_indiv = right.hhid_indiv, left only, local);

			hhidindiv_updated_count := count(dedup(sort(updates_hhidindiv, hhid_indiv, local), hhid_indiv, local));
			
			hhidindiv_not_updated_count := 	count(dedup(sort(noUpdates_hhidindiv, hhid_indiv, local), hhid_indiv, local));
		  
			hhidindiv_deleted := join(hhid_father_hhidindiv_D, hhid_hhidindiv_D, 
															left.hhid_indiv = right.hhid_indiv, 
															left only, local);
			hhidindiv_deleted_count := count(dedup(sort(hhidindiv_deleted, hhid_indiv, local), hhid_indiv, local));
			
			statsDs := DATASET([{'TOTAL HHIDINDIV', hhidindiv_count},
													{'TOTAL HHIDINDIV ADDED', hhidindiv_added_count},
													{'TOTAL HHIDINDIV UPDATED', hhidindiv_updated_count},
													{'TOTAL HHIDINDIV NOT UPDATED', hhidindiv_not_updated_count},
													{'TOTAL HHIDINDIV DELETED', hhidindiv_deleted_count}
													], statsLayout);
			RETURN statsDs;
		END;
		
		/*
			TOTAL CORE DID WITH UPDATED HHID = total of unique dids with updated HHID
			TOTAL CORE DID WITH UPDATED HHID SFH = total of unique dids with updated HHID in single family home
			TOTAL CORE DID WITH UPDATED HHID HRB = total of unique dids with updated HHID highrise building
     */
		statsLayout createCoreDIDStats() := FUNCTION
			// HHID for core dids
			HhidConstant := InsuranceHeader_HHID.Constant;
			core_dids := distribute(InsuranceHeader_PostProcess.corecheck(ind=HhidConstant.CORE_DID_INDICATOR), hash(did));		
			hhid_core_dids_updated := dedup(sort(join(updates, core_dids, left.did = right.did, local), did, local), did, local);
			hhid_core_dids_updated_count := count(hhid_core_dids_updated);
		
			hhid_single_family_count:= count(hhid_core_dids_updated(addrType=HhidConstant.SINGLE_FAMILY_HOME));
		
			hhid_highrise_blg_count := count(hhid_core_dids_updated(addrType=HhidConstant.HIGH_RISE_BUILDING));
		
			statsDs := DATASET([{'TOTAL CORE DID WITH UPDATED HHID', hhid_core_dids_updated_count},
													{'TOTAL CORE DID WITH UPDATED HHID SFH', hhid_single_family_count},
													{'TOTAL CORE DID WITH UPDATED HHID HRB', hhid_highrise_blg_count}													
													], statsLayout);
			RETURN statsDs ;
		END;
		
		separatorDS := DATASET([	{'', ''} ], statsLayout);
		shared stats := output( createDIDStats() + separatorDS + 
										createCoreDIDStats() + separatorDS + 
										createHHIDStats() + separatorDS + 
										createHHIDINDIVStats(), NAMED('HHID_STATS'));
		
		shared keys := InsuranceHeader_HHID.household_keys.build_keys;
		shared builddate := thorlib.wuid()[2..9];
		shared update_idops		:= idops.UpdateBuildVersion('HHIDKeys',trim(buildDate,left,right),mod_email.emailList,,'N');
		shared update_orbit    	:= orbit.CreateBuild('HHID Build','HHID Build',buildDate,'Production NonFCRA',orbit.GetToken());
				
		export run_hhid := sequential(opFile, updateSuperFile, keys, stats, update_iDops)
																			: SUCCESS(mod_email.SendSuccessEmail(,'InsuranceHeader', , 'HouseHold')), 
																			     FAILURE(mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'HouseHold'));
		
		export run := if(_Control.ThisEnvironment.Name = 'Prod',
													sequential(run_hhid, 
															if (update_orbit[1].retcode = 'Success', 
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,																		
																		'Alpharetta InsuranceHeader HouseHold OrbitI Create Build:'+buildDate+':SUCCESS',
																		'OrbitI Create build successful: ' + buildDate),
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList ,																		
																		'Alpharetta InsuranceHeader HouseHold OrbitI Create Build:'+buildDate+':FAILED',
																		'OrbitI Create build failed. Reason: ' + update_orbit[1].retdesc )
															)
													 ),
									sequential(output('Not a prod environment'))
									);
		
		
		//export run := sequential(opFile, updateSuperFile, keys, stats);
		//export run1 := sequential( stats);
		
end;