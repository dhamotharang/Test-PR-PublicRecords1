Import AutoStandardI,deathv2_Services,Death_Master,doxie,mprd;
EXPORT Functions_Death  := MODULE
	shared gm := AutoStandardI.GlobalModule();
	Export rollupDeath(dataset(Healthcare_Shared.Layouts.layout_death) recs) := Function
	  deathrecs := project(recs,transform(Healthcare_Shared.Layouts.layout_death,
													self:=left;));
		uniquerecs := dedup(sort(deathrecs((integer)dod>=0),deathsources,-dod),deathsources);
		
		p := project(uniquerecs,transform(Healthcare_Shared.Layouts.layout_death,
																	self.DeathSources:=sum(uniquerecs,DeathSources);
																	self:=left;));
		returnVal := sort(p((integer)dod>=0),-dod);
		// output(recs, Named('rollupdeathRecs'), extend);
		// output(uniquerecs, Named('uniquerecs'), extend);
		// output(p, Named('rollupDeath_p'), extend);
		// output(returnVal, Named('rollupDeath_p_afterdedupsort'), extend);
		return returnVal;
	end;
	Export doCheckDeath(dataset(Healthcare_Shared.Layouts.layout_death) input, dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) inputRecs, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := Function
			uiSSNExists := inputRecs[1].userinput.ssn <> '';
			
			deathparams := DeathV2_Services.IParam.GetDeathRestrictions(gm);
			glb_ok := deathparams.isValidGlb();
			
			// Get DID match to DMF did - Keeping Match Only if the user entered an SSN (Maybe turned on in the future)
			byDids := dedup(NORMALIZE(inputRecs,LEFT.dids,transform(Healthcare_Shared.Layouts.layout_death,self.acctno := left.acctno;self.internalid:=left.internalid;self.did:=right.did;self.group_key:=left.vendorid;
																															self.ui_fname := left.userinput.name_first;self.ui_mname := left.userinput.name_middle;self.ui_lname:=left.userinput.name_last;self.ui_dob:=left.userinput.dob;self.ui_ssn:=left.userinput.ssn;self.ui_npi:=left.userinput.npi;			
																															self:=[])),record,hash,all);
			
			deathRecsByDID := dedup(join(byDids(did<>0),doxie.Key_Death_MasterV2_ssa_Did,
									keyed(left.did = right.l_did)
									and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
									transform(Healthcare_Shared.Layouts.layout_death,
									// Check if there is a user supplied dob  match by dob using userinput dob.
																	matchbyDOB := left.dob <> '' and left.dob[1..6]=right.dob8[1..6];
																	matchbySSN := left.ui_SSN = right.ssn;
																	keepRecord := map(matchbyDOB or matchbySSN => true,
																		 left.DOB <> '' and not matchbyDOB => false,
																		 left.ui_SSN <> '' and not matchbySSN => false,
																		 true);
																	self.acctno:=if(keepRecord and uiSSNExists,left.acctno,skip);
																			self.death_ind:=true;self.dod:=right.dod8;self.DeathSources:=Healthcare_Shared.Constants.DEATHSRC_DID; //1
																			self.src_fname := right.fname;
																			self.src_mname := right.mname;
																			self.src_lname := right.lname;
																			self:=left;self:=right;),
									keep(1), limit(0)), hash,all);
			//Get User Input SSN match to DMF ssn
			
			
			
			deathRecs := dedup(join(input(ui_SSN<>''),Death_Master.key_ssn_ssa(false),
												keyed(left.ui_SSN = right.ssn)
												and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
												transform(Healthcare_Shared.Layouts.layout_death, 
																	self.death_ind:=true;self.dod:=right.dod8;self.dob:=right.dob8;self.DeathSources:=Healthcare_Shared.Constants.DEATHSRC_SSN; //1
																	self.src_fname := right.fname;
																	self.src_mname := right.mname;
																	self.src_lname := right.lname;
																	self:=left;self:=right;),
												keep(1), limit(0)),hash,all);
			
			
			//Get User Input TIN match to DMF ssn 
			deathRecsByTin := dedup(join(input(ui_TaxID<>''),Death_Master.key_ssn_ssa(false),
												keyed(left.ui_TaxID = right.ssn)
												and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
												transform(Healthcare_Shared.Layouts.layout_death, 
																	self.death_ind:=true;self.dod:=right.dod8;self.dob:=right.dob8;self.DeathSources:=Healthcare_Shared.Constants.DEATHSRC_TIN;  //2
																	self.src_fname := right.fname;
																	self.src_mname := right.mname;
																	self.src_lname := right.lname;
																	self:=left;self:=right;),
												keep(1), limit(0)),hash,all);
			
			// Get Choicepoint Tins (may have three Harvested TINS per record matching group_key 
		  cpData := join(input(group_key<>''),mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).basc_cp_group_key.QA,
													left.group_key = right.group_key and right.isTest = cfg[1].UseQATestRecs, TRANSFORM(Healthcare_Shared.Layouts.layout_harvestCPdeath,
													self.acctno:=left.acctno;
													self.internalid := left.internalid;
													self.group_key := left.group_key;
													self := right;self:=left;),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
											
      cpHarvestTin1 := project(cpData(tin1<>''),TRANSFORM(Healthcare_Shared.Layouts.layout_death, 
													self.acctno:=if(left.tin1<>'',left.acctno,skip);
													self.internalid:=left.internalid;
													self.group_key:=left.group_key;
													self.ui_TaxID:=trim(left.tin1);
													self.src_fname:=left.first_name;
													self.src_mname:=left.middle_name;
													self.src_lname:=left.last_name;
													SELF:=LEFT));

      
      cpHarvestTin2 := project(cpData(tin2<>''),TRANSFORM(Healthcare_Shared.Layouts.layout_death,
													self.acctno:=if(left.tin2<>'',left.acctno,skip);
													self.internalid:=left.internalid;
													self.group_key:=left.group_key;
													self.ui_TaxID:=trim(left.tin2);
													self.src_fname:=left.first_name;
													self.src_mname:=left.middle_name;
													self.src_lname:=left.last_name;
													SELF:=LEFT));
      
      cpHarvestTin3 := project(cpData(tin3<>''),TRANSFORM(Healthcare_Shared.Layouts.layout_death,
													self.acctno:=if(left.tin3<>'',left.acctno,skip);
													self.internalid:=left.internalid;
													self.group_key:=left.group_key;
													self.ui_TaxID:=trim(left.tin3);
													self.src_fname:=left.first_name;
													self.src_mname:=left.middle_name;
													self.src_lname:=left.last_name;
													SELF:=LEFT));
      
      cpHarvestTins := dedup(cpHarvestTin1+cpHarvestTin2+cpHarvestTin3,record,hash,all);
		  
			// ChoicePoint Harvested Tin match to DMF ssn
		  cpHarvestTinDMF := join(cpHarvestTins(ui_TaxID<>''),Death_Master.key_ssn_ssa(false),
												keyed(left.ui_TaxID = right.ssn)
												and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
												transform(Healthcare_Shared.Layouts.layout_death, 
																	self.death_ind:=true;self.dod:=right.dod8;self.dob:=right.dob8;self.DeathSources:=Healthcare_Shared.Constants.DEATHSRC_CP_HARVTIN; //4
																	self.src_fname := right.fname;
																	self.src_mname := right.mname;
																	self.src_lname := right.lname;
																	self.ui_fname  := left.ui_fname;
																	self.ui_mname  := left.ui_mname;
																	self.ui_lname  := left.ui_lname;
																	self:=left;self:=right;),
												keep(1), limit(0));
			
			//Get Claims Tin									
			ClaimsHarvestTin := join(input(group_key<>''),mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).basc_claims_group_key.QA,
													left.group_key = right.group_key and right.isTest = cfg[1].UseQATestRecs, TRANSFORM(Healthcare_Shared.Layouts.layout_death, 
																	self.acctno:=if(right.tin1<>'',left.acctno,skip);
																	self.internalid:=left.internalid;
																	self.group_key:=left.group_key;
																	self.ui_TaxID:=right.tin1;
																	SELF := RIGHT;self:=left;),
													keep(1), limit(0));
			ClaimsHarvestTins := dedup(ClaimsHarvestTin,record,hash,all);
			
			//Claims Tins match to DMF ssn
			ClaimsHarvestTinsDMF := join(ClaimsHarvestTins(ui_TaxID<>''),Death_Master.key_ssn_ssa(false),
													keyed(left.ui_TaxID = right.ssn)
													and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
													transform(Healthcare_Shared.Layouts.layout_death, 
																		self.death_ind:=true;self.dod:=right.dod8;self.dob:=right.dob8;self.DeathSources:=Healthcare_Shared.Constants.DEATHSRC_CLAIMS; //8
																		self.src_fname := right.fname;
																		self.src_mname := right.mname;
																		self.src_lname := right.lname;
																		self.ui_fname  := left.ui_fname;
																		self.ui_mname  := left.ui_mname;
																		self.ui_lname  := left.ui_lname;
																		self:=left;self:=right;),
													keep(1), limit(0));
			
			getDerivedNPIs := dedup(NORMALIZE(inputRecs, LEFT.NPIs(npi <> '') , TRANSFORM(Healthcare_Shared.Layouts.layout_death,																														self.internalid:=left.internalid;
																																		self.group_key:=left.vendorid;
																																		self.dod:='';
																																		self.dob:='';
																																		self.src_fname := left.Names[1].FirstName;
																																		self.src_mname := left.Names[1].MiddleName;
																																		self.src_lname := left.Names[1].LastName;
																																		self.ui_fname	 := left.userinput.name_first;
																																		self.ui_mname	 := left.userinput.name_middle;
																																		self.ui_lname	 := left.userinput.name_last;
																																		self.ui_NPI    := right.npi;
																																		self:=left;)),hash,all);
			
			//Get bill_npi (save in ui_NPI and ui_TaxID) from npi_tin_xref_bill_npi base file joining on bill_tin.																															
			getDerivedNPITins := dedup(join(getDerivedNPIs,mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).npi_tin_xref_bill_npi_key.QA,left.ui_NPI=right.bill_npi and right.isTest = cfg[1].UseQATestRecs,
																												transform(Healthcare_Shared.Layouts.layout_death,
																														self.ui_TaxID := right.bill_tin;
																														self:=left;),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)),hash,all);
			
			deathRecsByDerivedNPITin := dedup(join(getDerivedNPITins(ui_TaxID<>''),Death_Master.key_ssn_ssa(false),
												keyed(left.ui_TaxID = right.ssn)
												and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
												transform(Healthcare_Shared.Layouts.layout_death, 
																	self.death_ind:=true;self.dod:=right.dod8;self.dob:=right.dob8;self.DeathSources:=Healthcare_Shared.Constants.DEATHSRC_NPITINXREF; //16
																	self.src_fname := right.fname;
																	self.src_mname := right.mname;
																	self.src_lname := right.lname;
																	self.ui_fname  := left.ui_fname;
																	self.ui_mname  := left.ui_mname;
																	self.ui_lname  := left.ui_lname;
																	self:=left;self:=right;),
												keep(1), limit(0)),hash,all);
										
			// Other sources are most likely SKA_LOPS (phone verified active) and ACI_IDV (state saction reinstated indiv matched
			// to Enclarity @Credentials database -  If found in SKA_LOPS or ACI_IDV , then the individual is active.
			// Just grab all SSN(s) in collection and try to match DMF will now be others (may take away subSrc filter)
			
			getOthersDeathSSN:=dedup(NORMALIZE(inputRecs(subSrc IN Healthcare_Shared.SourceTools.set_OtherSourcesDeath),LEFT.SSNs, TRANSFORM(Healthcare_Shared.Layouts.layout_death,
											self.acctno    := left.acctno;
											self.internalid     := left.internalid;
											self.src_fname := left.MatchScore.allNames[1].FirstName;
											self.src_mname := left.MatchScore.allNames[1].MiddleName;
											self.src_lname := left.MatchScore.allNames[1].LastName;
											self.ui_fname  := left.userinput.name_first;
											self.ui_mname  := left.userinput.name_middle;
											self.ui_lname  := left.userinput.name_last;
											self.ui_dob    := left.userinput.dob;self.ui_ssn:=left.userinput.ssn;self.ui_npi:=left.userinput.npi;
											self.group_key := left.vendorid;
											self.death_ind := true;
											self.DeathSources:= Healthcare_Shared.Constants.DEATHSRC_CLIENTDATA;  // 20148 Design for ENC using 2048 for client data - now an ssn match to DMF.
																																														// Match on SSN to DMF is convered by deathsource = 1 above and this would be redundant.
											self.matchThreshold := 1;
											self :=left;)),hash,all); 
									
			getOthersDeathTIN:=dedup(NORMALIZE(inputRecs(subSrc IN Healthcare_Shared.SourceTools.set_OtherSourcesDeath),LEFT.TaxIds, TRANSFORM(Healthcare_Shared.Layouts.layout_death,
											self.acctno := left.acctno;
											self.internalid:=left.internalid;
											self.src_fname := left.MatchScore.allNames[1].FirstName;
											self.src_mname := left.MatchScore.allNames[1].MiddleName;
											self.src_lname := left.MatchScore.allNames[1].LastName;
											self.ui_fname  := left.userinput.name_first;
											self.ui_mname  := left.userinput.name_middle;
											self.ui_lname  := left.userinput.name_last;
											self.ui_dob    := left.userinput.dob;self.ui_ssn:=left.userinput.ssn;self.ui_npi:= left.userinput.npi;
											self.group_key:=left.vendorid;
											self.death_ind := true;
											self.DeathSources:= Healthcare_Shared.Constants.DEATHSRC_OTHERSOURCES;   // Design for ENC using 32 for Other Multiple Source - now a taxid match to DMF ssn.
																																					 // Taxid match to DMF is covered by deathsources = 2 above - this would be redundant.
											self.matchThreshold:=1;
											self :=left;)),hash,all); 
			
			getOthersDeath := getOthersDeathSSN+getOthersDeathTIN;
			
			getOthersDeathDMF := join(getOthersDeath(ui_ssn<>''),Death_Master.key_ssn_ssa(false),
												keyed(left.ui_ssn = right.ssn)
												and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
												transform(Healthcare_Shared.Layouts.layout_death, 
																	self.death_ind:=true;self.dod:=right.dod8;self.dob:=right.dob8;self.DeathSources:=Healthcare_Shared.Constants.DEATHSRC_OTHERSOURCES;  //32
																	self.src_fname := right.fname;
																	self.src_mname := right.mname;
																	self.src_lname := right.lname;
																	self.ui_fname  := left.ui_fname;
																	self.ui_mname  := left.ui_mname;
																	self.ui_lname  := left.ui_lname;
																	self:=left;self:=right;),
												keep(1), limit(0));
								
			deathCombined := sort(deathRecs+deathRecsByDID+deathRecsByTin+cpHarvestTinDMF+ClaimsHarvestTinsDMF+deathRecsByDerivedNPITin+getOthersDeathDMF,acctno,internalid,group_key,DeathSources);
			CheckDeath_combinedHits := project(deathCombined,
																transform(Healthcare_Shared.Layouts.layout_death,
																		lastname_words := stringlib.SplitWords(left.src_lname,' ',true);
																		
																		// As found in Results
																		nScoreLastName0 := Healthcare_Shared.Functions.NameScoreMatch(
																												,left.ui_fname,left.ui_mname,left.ui_lname,,,,
																												,left.src_fname,left.src_mname,left.src_lname,,,,);
																		// In Case Lastname = Middlename + single word Lastname										
																		nScoreLastName1 := Healthcare_Shared.Functions.NameScoreMatch(
																												,left.ui_fname,left.ui_mname,left.ui_lname,,,,
																												,left.src_fname,lastname_words[1],lastname_words[2],,,,);
																		// In Case Lastname = Middlename + two word last name - De Armas										
																		nScoreLastName2 := Healthcare_Shared.Functions.NameScoreMatch(
																												,left.ui_fname,left.ui_mname,left.ui_lname,,,,
																												,left.src_fname,lastname_words[1],lastname_words[2]+''+lastname_words[3],,,,);
																		// In Case Lastname = Middlename + three word last name - De La Torre										
																		nScoreLastName3 := Healthcare_Shared.Functions.NameScoreMatch(
																												,left.ui_fname,left.ui_mname,left.ui_lname,,,,
																												,left.src_fname,lastname_words[1],lastname_words[2]+''+lastname_words[3]+''+lastname_words[4],,,,);
																		 
																		DobUpScore 			:=	 left.dob <> '' and left.ui_DOB <> '' and
																												 left.dob[1..4]=left.ui_DOB[1..4];
																												 
																		// self.nScoreLastName0 := nScoreLastName0.NameScore;
																		// self.nScoreLastName1 := nScoreLastName1.NameScore;
																		// self.nScoreLastName2 := nScoreLastName2.NameScore;
																		// self.nScoreLastName3 := nScoreLastName3.NameScore;
																		
																		MaxMatchThreshold := max(nScoreLastName0.NameScore,nScoreLastName1.NameScore,nScoreLastName2.NameScore,nScoreLastName3.NameScore);
																		self.matchThreshold := if (DobUpScore,MaxMatchThreshold + HealthCare_Shared.Constants.DOB_MATCH_UPSCORE,MaxMatchThreshold);
																		
																		matchStrength0 := Healthcare_Shared.Functions.GetNameStrength(nScoreLastName0.NameExtendedMatchInfo);														 
																		matchStrength1 := Healthcare_Shared.Functions.GetNameStrength(nScoreLastName1.NameExtendedMatchInfo);	
																		matchStrength2 := Healthcare_Shared.Functions.GetNameStrength(nScoreLastName2.NameExtendedMatchInfo);	
																		matchStrength3 := Healthcare_Shared.Functions.GetNameStrength(nScoreLastName3.NameExtendedMatchInfo);
																		
																		// self.matchStrength0 := matchStrength0;
																		// self.matchStrength1 := matchStrength1;
																		// self.matchStrength2 := matchStrength2;
																		// self.matchStrength3 := matchStrength3;
																		
																		self.matchStrength := max(matchStrength0,matchStrength1,matchStrength2,matchStrength3);												 
																		self:=left;));


			//Throwout bad records not beyond a weak match score
			
			CheckDeath_OkNames := CheckDeath_combinedHits(matchThreshold > Healthcare_Shared.Constants.NAME_SCORE_WEAK_MATCH_THRESHOLD or
													matchStrength > Healthcare_Shared.Constants.NameScoreStrength.Weak );
			CheckDeath_Final := dedup(sort(CheckDeath_OkNames,acctno,internalid,DeathSources,-matchStrength,-matchThreshold),acctno,internalid,DeathSources);								
		// output(byDids,named('CheckDeath_byDids'), extend);
		// output(deathRecsByDID,named('CheckDeath_deathRecsByDID_DMF1'), extend);																													 
		// output(input,named('input'), extend);																													 
		// output(inputRecs,named('CheckDeath_inputRecs'), extend);																													 
			
		// output(deathRecsByTin,named('CheckDeath_deathRecsByTin_DMF3'), extend);	
		// output(cpdata,named('cpdata'), extend);	
		// output(cpHarvestTin1,named('cpHarvestTin1'), extend);																													 
		// output(cpHarvestTin2,named('cpHarvestTin2'), extend);																													 
		// output(cpHarvestTin3,named('cpHarvestTin3'), extend);																													 
		// output(cpHarvestTins,named('cpHarvestTins'), extend);																													 
		// output(cpHarvestTinDMF,named('CheckDeath_cpHarvestTin_DMF4'), extend);																													 
		// output(ClaimsHarvestTins,named('ClaimsHarvestTins'), extend);																													 
		// output(ClaimsHarvestTinsDMF,named('CheckDeath_ClaimsHarvestTins_DMF5'), extend);
		// output(getDerivedNPIs,named('CheckDeath_getDerivedNPIs'),extend);
		// output(getDerivedNPITins,named('getDerivedNPITins_DMF6'), extend);																													 
		// output(deathRecsByDerivedNPITin,named('CheckDeath_deathRecsByDerivedNPITin_DMF7'),extend);
		// output(getOthersDeathSSN,named('CheckDeath_getOthersDeathSSN_DMF8'),extend);
		// output(getOthersDeathTIN,named('CheckDeath_getOthersDeathTIN_DMF9'),extend);
		// output(getOthersDeathDMF,named('CheckDeath_getOthersDeathDMF'),extend);
		// output(deathCombined,named('CheckDeath_deathCombined'),extend);
		// output(count_NPIS,named('CheckDeath_count_NPIS'),overwrite);
		// output(deathRecs,named('CheckDeath_deathRecs_bySSN_DMF2'), extend);
		// output(CheckDeath_combinedHits,named('CheckDeath_combinedHits_DMF10'),extend);
		// output(CheckDeath_final,named('CheckDeath_final'),extend);
		return CheckDeath_final;
	end;
	
	Export appendDeath (dataset(Healthcare_Shared.Layouts.layout_death) inputDOD, 
											dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) inputRecs,
											dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function
		
		// The hits from doCheckDeath() were namedMatchScore and filtered since their sources could be from a bad
		// did append or a tin that is part of a group practice ,etc .  Hits in AppendDeath() below are strongly trusted
		// data sources on the match is upon a group collection (e.g. Licenses) already part of the group InputRecs or a strong match
		// based on group_key (e.g. OBITS),therefore matchThreshold and matchStrength are defaulted to strong values of 99 and 4 respectively.
		
		getDeath := doCheckDeath(inputDOD,inputRecs,cfg);
		//Determine ChoicePoint with DeathFlag = Y
		cpDeath := dedup(Project(inputRecs.RecordsRaw(filecode[1..8] = 'CHOICEPT' and death_flag='Y'),
												TRANSFORM(Healthcare_Shared.Layouts.layout_death, 
																self.acctno:=left.acctno;
																self.internalid:=left.internalid;
																self.src_fname := left.first_name;
																self.src_mname := left.middle_name;
																self.src_lname := left.last_name;
																self.ui_fname := inputRecs(acctno=left.acctno)[1].userinput.name_first;  // Carry over the ui 
																self.ui_mname := inputRecs(acctno=left.acctno)[1].userinput.name_middle;
																self.ui_lname := inputRecs(acctno=left.acctno)[1].userinput.name_last;
																self.group_key:=left.group_key;
																self.death_ind:=true;
																self.DeathSources := Healthcare_Shared.Constants.DEATHSRC_CPDFLAG; //1024
																self.dod:=Healthcare_Shared.Functions.cleanOnlyNumbers(left.date_of_death);
																self.matchThreshold:=99;//Foced matchThreshold and matchStrength based on confidence of group collection or match key.
																self.matchStrength:=4;
																SELF := left)),record,hash,all);
												
		//Determine License with LicenseStatus = D (128) WITHOUT checking if in state.
		LicDeath := dedup(Project(inputRecs.RecordsRaw(lic1.lic_status='D' or lic2.lic_status='D' or lic3.lic_status='D' or lic4.lic_status='D' or lic5.lic_status='D' or
																		 lic6.lic_status='D' or lic7.lic_status='D' or lic8.lic_status='D' or lic9.lic_status='D' or lic10.lic_status='D' or
																		 lic11.lic_status='D' or lic12.lic_status='D' or lic13.lic_status='D' or lic14.lic_status='D' or lic15.lic_status='D'),
												TRANSFORM(Healthcare_Shared.Layouts.layout_death, 
														self.acctno:=left.acctno;
														self.internalid:=left.internalid;
														self.src_fname := left.first_name;
														self.src_mname := left.middle_name;
														self.src_lname := left.last_name;
														self.ui_fname := inputRecs(acctno=left.acctno)[1].userinput.name_first;  // Carry over the ui 
														self.ui_mname := inputRecs(acctno=left.acctno)[1].userinput.name_middle;
														self.ui_lname := inputRecs(acctno=left.acctno)[1].userinput.name_last;
														self.group_key:=left.group_key;
														self.death_ind:=true;
														self.DeathSources := map(inputRecs(acctno=left.acctno)[1].userinput.st = left.lic1.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic2.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic3.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic4.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic5.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic6.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic7.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic8.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic9.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic10.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic11.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic12.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic13.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic14.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									inputRecs(acctno=left.acctno)[1].userinput.st = left.lic15.lic_state => Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE+Healthcare_Shared.Constants.DEATHSRC_LICENSED,   // Add 256 and 128
																									Healthcare_Shared.Constants.DEATHSRC_LICENSED);// Add 128
														self.matchThreshold:=99;//Foced matchThreshold and matchStrength based on confidence of group collection or match key.
														self.matchStrength:=4;
														SELF := left)),record,hash,all);  // Changing to DeathSources Dedup (only add 128 once)
			
		//Get Obits  (Obituaries file)
		deathRecsByObits := dedup(join(inputDOD(group_key<>''),mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).basc_deceased_group_key.QA,
												left.group_key = right.group_key and right.isTest = cfg[1].UseQATestRecs,
												transform(Healthcare_Shared.Layouts.layout_death, 
																	self.death_ind:=true;self.dob:=Healthcare_Shared.Functions.cleanOnlyNumbers(right.birthdate);
																	self.dod:= if(Healthcare_Shared.Functions.cleanOnlyNumbers(right.date_of_death) NOT in ['','00000000'],Healthcare_Shared.Functions.cleanOnlyNumbers(right.date_of_death),
																								Healthcare_Shared.Functions.cleanOnlyNumbers(right.incomplete_date_of_death));
																	self.DeathSources:=Healthcare_Shared.Constants.DEATHSRC_OBITS;
																	self.src_fname := right.first_name;
																	self.src_mname := right.middle_name; 
																	self.src_lname := right.last_name;
																	// self.ui_fname := right.userinput.name_first;  // Carry over the ui 
																	// self.ui_mname := right.userinput.name_middle;
																	// self.ui_lname := right.userinput.name_last;
																	self.matchThreshold:=99;//Foced matchThreshold and matchStrength based on confidence of group collection or match key.
																	self.matchStrength:=4;
																	self:=left;self:=right;),
												keep(1), limit(0)),hash,all);
		
		//Determine Deceased from Phone and Fax Verified Records
		// normalize on addresses  - and look at miscinfo collection and compare to DEATHSRC .. 
		
		CallVerifiedDeath:=dedup(NORMALIZE(inputRecs,LEFT.Sources, 
		        TRANSFORM(Healthcare_Shared.Layouts.layout_death,
										 keepRec := right.subsrc in Healthcare_Shared.SourceTools.set_PhoneFaxVerified_INACT;
                     self.acctno := if(keepRec,left.acctno,skip);
                     self.internalid:=left.internalid; 
										 self.src_fname := left.Names[1].FirstName;
										 self.src_mname := left.Names[1].Middlename;
										 self.src_lname := left.Names[1].LastName;
										 self.ui_fname := left.userinput.name_first;  // Carry over the ui 
										 self.ui_mname := left.userinput.name_middle;
										 self.ui_lname := left.userinput.name_last;
										 self.group_key:=left.vendorid;
                     self.death_ind:=true;
                     self.DeathSources:= map(trim(right.subsrc,right,left) in Healthcare_Shared.SourceTools.set_FaxVerified_INACT and trim(left.MiscInfo[1].kil_code,right,left) = 'KID' =>Healthcare_Shared.Constants.DEATHSRC_CALLFAXVKID,
                                             trim(right.subsrc,right,left) in Healthcare_Shared.SourceTools.set_PhoneVerified_INACT and trim(left.MiscInfo[1].kil_code,right,left) = 'KID' => Healthcare_Shared.Constants.DEATHSRC_CALLPVKID,
																						 0);
										 self.matchThreshold:=99;//Foced matchThreshold and matchStrength based on confidence of group collection or match key.
										 self.matchStrength:=4;
                     SELF := RIGHT)),hash,all);
						
		// AppendDeath_combinedHits := dedup(sort(getDeath+cpDeath+LicDeath+deathRecsByObits+CallVerifiedDeath,acctno,internalid,group_key,deathSources),acctno,internalid,group_key,deathSources);
		AppendDeath_combinedHits := dedup(sort(getDeath+cpDeath+LicDeath+deathRecsByObits+CallVerifiedDeath,acctno,internalid,group_key,deathSources),acctno,deathSources,hash,all);  //we only want 1 death per source in case of group_key overlinking
		
		//Project final collection to apply matchthreshold name matching and remove bad entries....then Rollup
		
		Healthcare_Shared.Layouts.layout_death doRollup(Healthcare_Shared.Layouts.layout_death l, dataset(Healthcare_Shared.Layouts.layout_death) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.internalid := l.internalid;
			self.group_key := l.group_key;
			self.isroyalty := if(exists(r(isroyalty=false)),false,true);
			self.death_ind := exists(r(death_ind=true));
			self.dod := r((integer)dod>0)[1].dod;
			self.dob := r((integer)dob>0)[1].dob;
			self.did := r((integer)did>0)[1].did;
			self.matchstrength := max(r((integer)dod>0),matchstrength);
			self.matchthreshold := max(r((integer)dod>0),matchthreshold);
			self.DeathSources := sum(r,DeathSources);
			self:= l;
		END;
		
		// Append Records to CombinedHeaderResults (with Dods as compiled) for this collection of keys.
		dod_sort := sort(AppendDeath_combinedHits,acctno,internalid,group_key,deathsources);
		dod_group := group(dod_sort,acctno,internalid);
		dod_records_rollup := rollup(dod_group,group,doRollup(left,rows(left)));
		
		Healthcare_Shared.Layouts.layout_child_death doFinalRollup(Healthcare_Shared.Layouts.layout_death l, dataset(Healthcare_Shared.Layouts.layout_death) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.internalid := l.internalid;
			self.childinfo := r;
		END;

		dod_final_group := group(dod_records_rollup,acctno,internalid);
		dod_final_rollup := rollup(dod_final_group,group,doFinalRollup(left,rows(left)));

		results := join(inputRecs,dod_final_rollup, left.acctno=right.acctno and left.internalid=right.internalid,
																		transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
																							self.dods := right.childinfo;
																							self := left), left outer,
																							keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
																							
		// output(inputDOD,named('AppendDeath_inputDOD'),extend);
		// output(inputRecs,named('AppendDeath_inputRecs'),extend);																					
		// output(cpDeath,named('AppendDeath_cpDeath'), extend);		
		// output(LicDeath,named('AppendDeath_LicDeath'),extend);
		// output(StateLicDeath,named('AppendDeath_StateLicDeath'),extend);																					
		// output(deathRecsByObits,named('AppendDeath_deathRecsByObits'),extend);																					
		// output(CallVerifiedDeath,named('AppendDeath_CallVerifiedDeath'), extend);																					
		// output(AppendDeath_combinedHits,named('AppendDeath_CombinedHits'),extend);																					
		// output(dod_sort, named ('AppendDeath_dod_sort'), extend);
		// output(dod_group, named ('AppendDeath_dod_group'), extend);
		// output(dod_final_rollup, named ('AppendDeath_dod_final_rollup'), extend);																					
		// output(results,named('AppendDeath_results'), extend);																			
		return results;
	end;		
End;