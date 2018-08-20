import AutokeyB2_batch, hygenics_crim, CriminalRecords_BatchService;
export Functions := MODULE
 
	//get acctno by auto keys which don't have any results or too many result back
  EXPORT get_ak_nr(DATASET(AutokeyB2_batch.Layouts.rec_output_IDs_batch) ak_nr) := FUNCTION
				
		CriminalRecords_BatchService.Layouts.batch_out xfm_ak_recs(recordof(ak_nr) L , DATASET(recordof(ak_nr)) R) :=TRANSFORM
				cur := if (count(R)>1,R(search_status=AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES)
														 ,R(search_status =AutokeyB2_batch.Constants.FAILED_NO_MATCHES));
														 
				SELF.too_many_flag:= if(cur[1].search_Status
													 =AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES
													 ,'Y',if(cur[1].search_Status
																	 =AutokeyB2_batch.Constants.FAILED_NO_MATCHES
																	 ,'N',''));
				SELF := cur[1];
				SELF.too_many_code:= (string3) cur[1].search_status;
				SELF := [];
		END;
		ak_r := ak_nr(search_status=0);
		ak_nr1 := JOIN(ak_nr(Search_Status>0),ak_r
									 ,LEFT.acctno = RIGHT.acctno
									 , LEFT ONLY);

									 
		ak_nr_out := ROLLUP(GROUP(SORT(ak_nr1,acctno),acctno),group,xfm_ak_recs(LEFT,rows(LEFT)));
		RETURN ak_nr_out;
	END;
 
  EXPORT Bitmap_all_includes (CriminalRecords_BatchService.IParam.batch_params configData) := FUNCTION
 
   // Examine each of the 44 Include* input option and set on it's corresponding offense_category bit value
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
  unsigned8 bit_warrantfugitive := if(configData.IncludeWarrantFugitive,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Warrant_Fugitive),0);
  unsigned8 bit_obstructresist := if(configData.IncludeObstructResist,hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Obstruct_Resist),0);

  // Once all Include***s are checked & bit_***s are set, do a bitwise "OR" on all the individual 
	// values to create a bitmap representing all of the requested ones.
  unsigned8 bitmap_all := bit_arson        | bit_assaultagg   | bit_assaultother  | 
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
                                   bit_weaponlaw    | bit_other        | bit_cannotclassify|
                                   bit_warrantfugitive | bit_obstructresist;
																	 
  RETURN bitmap_all;
 END;
 
END;