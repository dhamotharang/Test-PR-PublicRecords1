IMPORT Autokey_batch, doxie, hygenics_crim, FCRA, FFD, Suppress, ut;

export BatchRecords (CriminalRecords_BatchService.IParam.batch_params configData,
										 dataset(CriminalRecords_BatchService.Layouts.batch_in) ds_batch_in,
										 boolean isFCRA = false,
										 DATASET (FFD.Layouts.PersonContextBatch) in_pc_recs = DATASET ([],FFD.Layouts.PersonContextBatch),
										 boolean SkipPersonContextCall = false) := FUNCTION
	
	ds_batch_in_common 	:= project(ds_batch_in, Autokey_batch.Layouts.rec_inBatchMaster);		
	boolean is_cnsmr := configData.IndustryClass = ut.IndustryClass.Knowx_IC; 		

  // Examine each of the 42 Include* input option and set on it's corresponding offense_category bit value
  unsigned8 bit_arson          := if(configData.IncludeArson,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Arson),0);
  unsigned8 bit_assaultagg     := if(configData.IncludeAssaultAgg,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Assault_aggr),0);
  unsigned8 bit_assaultother   := if(configData.IncludeAssaultOther,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Assault_other),0);
  unsigned8 bit_badchecks      := if(configData.IncludeBadChecks,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_BadChecks),0);
  unsigned8 bit_bribery        := if(configData.IncludeBribery,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Bribery),0);
  unsigned8 bit_burglarycomm   := if(configData.IncludeBurglaryComm,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Burglary_BreakAndEnter_comm),0);
  unsigned8 bit_burglaryres    := if(configData.IncludeBurglaryRes,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Burglary_BreakAndEnter_res),0);
  unsigned8 bit_burglaryveh    := if(configData.IncludeBurglaryVeh,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Burglary_BreakAndEnter_veh),0);
  unsigned8 bit_computer       := if(configData.IncludeComputer,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Computer_Crimes),0);
  unsigned8 bit_counterfeit    := if(configData.IncludeCounterfeit,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Counterfeiting_Forgery),0);
  unsigned8 bit_curloivag      := if(configData.IncludeCurLoiVag,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_CurfewLoiteringVagrancyVio),0);
  unsigned8 bit_vandalism      := if(configData.IncludeVandalism,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Destruction_Damage_Vandalism),0);
  unsigned8 bit_disorderly     := if(configData.IncludeDisorderly,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_DisorderlyConduct),0);
  unsigned8 bit_dui            := if(configData.IncludeDUI,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_DrivingUndertheInfluence),0);
  unsigned8 bit_drug           := if(configData.IncludeDrug,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Drug_Narcotic),0);
  unsigned8 bit_drunk          := if(configData.IncludeDrunk,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Drunkenness),0);
  unsigned8 bit_familyoff      := if(configData.IncludeFamilyOff,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_FamilyOffenses),0);
  unsigned8 bit_fraud          := if(configData.IncludeFraud,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Fraud),0);
  unsigned8 bit_gambling       := if(configData.IncludeGambling,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Gambling),0);
  unsigned8 bit_homicide       := if(configData.IncludeHomicide,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Homicide),0);
  unsigned8 bit_humantraff     := if(configData.IncludeHumanTraff,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Human_Trafficking),0);
  unsigned8 bit_idtheft        := if(configData.IncludeIdTheft,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Identity_Theft),0);
  unsigned8 bit_kidnapping     := if(configData.IncludeKidnapping,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Kidnapping_Abduction),0);
  unsigned8 bit_liquorlaw      := if(configData.IncludeLiquorLaw,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_LiquorLawViolations),0);
  unsigned8 bit_mvtheft        := if(configData.IncludeMVTheft,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Motor_Vehicle_Theft),0);
  unsigned8 bit_peepingtom     := if(configData.IncludePeepingTom,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_PeepingTom),0);
  unsigned8 bit_pornography    := if(configData.IncludePornography,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Pornography),0);
  unsigned8 bit_prostitution   := if(configData.IncludeProstitution,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Prostitution),0);
  unsigned8 bit_restrianing    := if(configData.IncludeRestraining,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Restraining_Order_Violations),0);
  unsigned8 bit_robberycomm    := if(configData.IncludeRobberyComm,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Robbery_comm),0);
  unsigned8 bit_robberyres     := if(configData.IncludeRobberyRes,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Robbery_res),0);
  unsigned8 bit_soforce        := if(configData.IncludeSOForce,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_SexOffensesForcible),0);
  unsigned8 bit_sononforce     := if(configData.IncludeSONonForce,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_SexOffensesNon_forcible),0);
  unsigned8 bit_shoplift       := if(configData.IncludeShoplift,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Shoplifting),0);
  unsigned8 bit_stolenprop     := if(configData.IncludeStolenProp,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Stolen_Property_Offenses_Fence),0);
  unsigned8 bit_terrorist      := if(configData.IncludeTerrorist,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Terrorist_Threats),0);
  unsigned8 bit_theft          := if(configData.IncludeTheft,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Theft),0);
  unsigned8 bit_traffic        := if(configData.IncludeTraffic,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Traffic),0);
  unsigned8 bit_trespass       := if(configData.IncludeTrespass,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_TrespassofRealProperty),0);
  unsigned8 bit_weaponlaw      := if(configData.IncludeWeaponLaw,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Weapon_Law_Violations),0);
  unsigned8 bit_other          := if(configData.IncludeOther,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Other),0);
  unsigned8 bit_cannotclassify := if(configData.IncludeCannotClassify,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Unclassified),0);

  // Once all Include***s are checked & bit_***s are set, do a bitwise "OR" on all the individual 
	// values to create a bitmap representing all of the requested ones.
  unsigned8 bitmap_all_includes := bit_arson        | bit_assaultagg   | bit_assaultother  | 
                                   bit_badchecks    | bit_bribery      | bit_burglarycomm  |
                                   bit_burglaryres  | bit_burglaryveh  | bit_computer      | 
																	 bit_counterfeit  | bit_curloivag    | bit_vandalism     | 
																	 bit_disorderly   | bit_dui          | bit_drug          | 
																	 bit_drunk        | bit_familyoff    | bit_fraud         | 
																	 bit_gambling     | bit_homicide     | bit_humantraff    | 
                                   bit_idtheft      | bit_kidnapping   | bit_liquorlaw     | 
                                   bit_mvtheft      | bit_peepingtom   | bit_pornography   | 
                                   bit_prostitution | bit_restrianing  | bit_robberycomm   | 
                                   bit_robberyres   | bit_soforce      | bit_sononforce    | 
                                   bit_shoplift     | bit_stolenprop   | bit_terrorist     | 
                                   bit_theft        | bit_traffic      | bit_trespass      | 
                                   bit_weaponlaw    | bit_other        | bit_cannotclassify;

	// flagfiles for FCRA
	ds_best  := project(ds_batch_in(did <> 0),transform(doxie.layout_best,self.did:=left.did, self:=[])); //using input to create dataset for getting the flag file (overrides). For FCRA we only use DID to get overrides.
	ds_flags := if(isFCRA, FCRA.GetFlagFile (ds_best)); //this is for more than one person
	
	// FCRA FFD  	
	boolean do_skipPersonContextCall :=  ~isFCRA or SkipPersonContextCall;
	
	dids := project(ds_batch_in(did <> 0),FFD.Layouts.DidBatch); 	
				
	pc_recs :=  if(do_skipPersonContextCall, in_pc_recs(datagroup in FFD.Constants.DataGroupSet.Criminal), 
	                       FFD.FetchPersonContext(dids, configData.gateways, FFD.Constants.DataGroupSet.Criminal));
	
	slim_pc_recs := FFD.SlimPersonContext(pc_recs);
	
	// 1. Search via AutoKey	
	fromAK := CriminalRecords_BatchService.BatchIds.Ids.AutokeyIds(ds_batch_in_common);
		
	// 2. Search via DID and DID Lookup
	notFoundAccts := JOIN(ds_batch_in_common, fromAK(too_many_code = '0'), LEFT.acctno = RIGHT.acctno, TRANSFORM(LEFT), LEFT ONLY);	
	fromDID := CriminalRecords_BatchService.BatchIds.Ids.IdsByDID(if(isFCRA, ds_batch_in_common, notFoundAccts), isFCRA, ds_flags);
	
	// 3. Search via DocNum
	fromDocNum := CriminalRecords_BatchService.BatchIds.Ids.IdsByDocNum(ds_batch_in);
	
	acctNos := if(isFCRA, fromDID, fromAK (too_many_code = '0')
																+ fromDID 
																+ fromDocNum (too_many_code = '0'));
	acctNos_final := DEDUP(SORT(acctNos,
															acctno,did,offender_key),
												 acctno,did,offender_key);
	
	/* =================== GET CRIMINAL RECORDS ==================== */
	offender := CriminalRecords_BatchService.Raw.getOffenderRecords(acctNos_final, isFCRA, is_cnsmr, ds_flags, slim_pc_recs, configData.FFDOptionsMask);
	offender_ids := DEDUP(SORT(PROJECT(offender, transform(CriminalRecords_BatchService.Layouts.lookup_id, self := left)), acctno, did, offender_key), acctno, did, offender_key);
	offenses := CriminalRecords_BatchService.Raw.getOffenseRecords(offender_ids, isFCRA, ds_flags, slim_pc_recs, configData.FFDOptionsMask);
	court_offenses := CriminalRecords_BatchService.Raw.getCourtOffenseRecords(offender_ids, isFCRA, ds_flags, slim_pc_recs, configData.FFDOptionsMask);
	punishments := CriminalRecords_BatchService.Raw.getPunishmentRecords(offender_ids, isFCRA, ds_flags, slim_pc_recs, configData.FFDOptionsMask);
	//combine offender, offenses, court_offenses and punishments
	crim_recs_t := offender + offenses + court_offenses + punishments;

	//Add SequenceNumber 
	CriminalRecords_BatchService.Layouts.batch_int sequenceIt 
									(CriminalRecords_BatchService.Layouts.batch_int L , integer C):=  transform
										self.SequenceNumber :=  C;
										self.StatementsAndDisputes := project(L.StatementsAndDisputes,
																														transform(FFD.Layouts.ConsumerStatementBatch,
																														self.SequenceNumber := C, self := left));
										self :=  L;
									 end;
															
	sequenced_int := project(crim_recs_t,sequenceIt(left,counter));
	
	
	
	//rollup into final layout
	CriminalRecords_BatchService.Layouts.batch_out_pre xformOutput(CriminalRecords_BatchService.Layouts.batch_int L, DATASET(CriminalRecords_BatchService.Layouts.batch_int) R) := TRANSFORM
		  off_recs 	:= R(output_type = 'F');
			p_recs 		:= R(output_type = 'P');
			F := PROJECT(off_recs,CriminalRecords_BatchService.Layouts.offenses);
			P := PROJECT(p_recs,CriminalRecords_BatchService.Layouts.Punishment);
			
			SELF.StatementsAndDisputes := off_recs[1].StatementsAndDisputes + 
																		p_recs[1].StatementsAndDisputes + 
																		L.StatementsAndDisputes;
			SELF.sDID := (string) L.did;
			SELF := F[1];
			SELF := P[1];
			SELF := L;			
	END;	
	
	crim_grp  := GROUP(SORT(sequenced_int,acctno,did,offender_key),acctno,did,offender_key);
	crim_roll := ROLLUP(crim_grp,group,xformOutput(LEFT,ROWS(LEFT)));
	crim_nr 	:= dedup(sort((fromAK + fromDocNum) (too_many_code <> '0'), record), record);
	crim_recs := crim_roll +
							 if(~isFCRA, project(crim_nr, transform(CriminalRecords_BatchService.Layouts.batch_out_pre, self := left, self := [])));
							 
	// ssn prunning									 
	doxie.MAC_PruneOldSSNs(crim_recs, out_pruned, ssn, did, isFCRA);
  Suppress.MAC_Suppress(out_pruned,pruned_did,configData.ApplicationType,Suppress.Constants.LinkTypes.DID,did);
  Suppress.MAC_Suppress(pruned_did,results_np,configData.ApplicationType,Suppress.Constants.LinkTypes.SSN,ssn);
	
	results_all := TOPN(GROUP(SORT(results_np, acctno, pty_typ), acctno), configData.MaxResults, acctno, -process_date);

  // Start of 06/13/2017 offense categories filtering enhancement?
	results_out_raw := PROJECT(results_all, CriminalRecords_BatchService.Layouts.batch_out);

  // If any individual offense categories were requested, filter output to only include the records
	// that contain any of the requested offense categories.
  results_out := if(not configdata.IncludeAtLeast1Offense,
	                  // if no individual offense category was requested, return all records
                    results_out_raw, 
                    // else do a bitwise "AND" of all the requested Include***s bitmap against 
										// each of the 6 occurrences of offense_category_* (bitmap) on each record.
					          // If any resulting values are not = to zero, that rec will be returned.
	                  results_out_raw(bitmap_all_includes & offense_category_1 != 0 or 
                                    bitmap_all_includes & offense_category_2 != 0 or 
                                    bitmap_all_includes & offense_category_3 != 0 or 
                                    bitmap_all_includes & offense_category_4 != 0 or 
                                    bitmap_all_includes & offense_category_5 != 0 or 
                                    bitmap_all_includes & offense_category_6 != 0));
  // end of 06/13/2017 offense categories enhancement
	
	consumer_statements := NORMALIZE(UNGROUP(results_all), LEFT.StatementsAndDisputes, 
		TRANSFORM (FFD.Layouts.ConsumerStatementBatch, 
			SELF.Acctno := left.Acctno,
			SELF.SequenceNumber := left.SequenceNumber,
			SELF := RIGHT));

	// append the actual contents of each consumer statement
	consumer_statements_prep := IF(isFCRA, FFD.prepareConsumerStatementsBatch(consumer_statements, pc_recs, configData.FFDOptionsMask));
	
	// store both records and statements under a single record structure
	FFD.MAC.PrepareResultRecordBatch(results_out, record_out, consumer_statements_prep, CriminalRecords_BatchService.Layouts.batch_out);	


  // Uncomment as needed for debugging
	//OUTPUT(configdata.IncludeArson,           named('IncArson')); 
	//OUTPUT(configdata.IncludeAssaultAgg,      named('IncAssAgg')); 
  //OUTPUT(configdata.IncludeAssaultOther,    named('IncAssOth')); 
  //OUTPUT(configdata.IncludeDrug,            named('IncDrug')); 
  //OUTPUT(configdata.IncludeHomicide,        named('IncHom')); 
  //OUTPUT(configdata.IncludeTraffic,         named('IncTraf')); 
  //OUTPUT(configdata.IncludeAtLeast1Offense, named('br_IncAL1Off'));
	//OUTPUT(bitmap_all_includes,               named('br_bitmap_all_incs'));
  //OUTPUT(results_out_raw,                   named('br_results_out_raw')); 
  //OUTPUT(results_out,                       named('br_results_out')); 

	return record_out;	
	
END;