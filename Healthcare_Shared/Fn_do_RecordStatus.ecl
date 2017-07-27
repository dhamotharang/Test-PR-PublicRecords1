Import Healthcare_Shared,ut;
EXPORT Fn_do_RecordStatus  := MODULE
	Export getRecordStatusInfo(Healthcare_Shared.Layouts.CombinedHeaderResults inRow, Dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function
			
			// This function will have to look at the death flags and the license flags and look at the rows to see if we are getting records from ret file codes.
			// statusDeceased    := D / statusReportedHighDeceased := U / statusReportedDeceased := U1 (Reversed Scoring - U1 is weaker score vs U)
			// statusHighRetired := R  Function will never return 'R', only R1,R2,R4(weakest score)
			// status Active => A/N needs to get fixed in Provider point (N used by ENC for backward compatibility).

			isCPXrefDeath := inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_CP_HARVTIN > 0;
			isClaimsXrefDeath := inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_CLAIMS > 0;
			isNPIXrefDeath := inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_NPITINXREF > 0;
			isOtherXrefTinDeath := inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_OTHERSOURCES > 0;
			isObitsDeath := inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_OBITS > 0;

			dsNpiByDeactDate := sort(inRow.Npis(npi_deact_date not in ['','0000-00-00']),-npi_deact_date);
			dsStLicenses := inRow.Statelicenses(LicenseNumber <> '' and sources[1].filecode[1..3] = 'LIC');
			dsAddresses:= inRow.Addresses(st <> '');
			
			//If User defined the state in search then match on ui state code, otherwise use the billing address state code if entered.
			boolean isUserInputPracStateDefined := if (length(trim(inRow.userinput.st,left,right)) <> 2, false,true);
			string2 matchStateCode := if (isUserInputPracStateDefined,inRow.userinput.st,'');
			string2 cookedState := if(matchStateCode = '' and NOT isUserInputPracStateDefined,trim(inRow.userinput.bill_st,left,right),matchStateCode);
			IsInputStateDefined := length(cookedState) = 2;
			boolean isUserInputDeaDefined := length(trim(inRow.userinput.dea,left,right))=9;
			
			//If User defined the state in search then match on ui state code, otherwise assign the practice address state code
			//If the assigned state code (user input or from practice address) is blank , use the billing address state code.
			//This is how it should work if Dea is entered.  I believe Enclarity is currently not checking grace period , just filecode RET and FRET.
			filecode_dea_retired:=[healthcare_shared.SourceTools.src_DEA_RET,
										  healthcare_shared.SourceTools.src_DEA_FRET];
			filecode_dea_active:=[healthcare_shared.SourceTools.src_DEA,
										  healthcare_shared.SourceTools.src_DEA_COMP];				
			
			
			boolean isDeactivatedDea := if(isUserInputDeaDefined,EXISTS(inRow.DEAs(dea_st <> '' and dea_st = cookedstate and IsInputStateDefined
																				and (integer) healthcare_shared.functions.cleanOnlyNumbers(dea_num_deact_date) > 0 
																				and Healthcare_shared.functions.isExpiredWithGrace((string)healthcare_shared.functions.cleanOnlyNumbers(dea_num_deact_date),cfg[1].DeaGraceDays,'D'))),
																				EXISTS(inRow.Deas.sources(filecode in filecode_dea_retired))) ;
			
			// boolean isDeactivatedDea := exists(inRow.deas.sources(filecode in [Healthcare_Shared.SourceTools.src_DEA_RET,Healthcare_Shared.SourceTools.src_DEA_FRET]));
			
			//This is how it should work if Dea is entered.  I believe Enclarity is currently not checking grace period , just filecode DEA and DEA_COMP.
			boolean isActiveDea := if(isUserInputDeaDefined,EXISTS(inRow.DEAs(dea_st <> '' and dea_st = cookedstate and IsInputStateDefined
																				and (integer) healthcare_shared.functions.cleanOnlyNumbers(dea_num_exp) > 0 
																				and Healthcare_shared.functions.isExpiredWithGrace((string)healthcare_shared.functions.cleanOnlyNumbers(dea_num_exp),cfg[1].DeaGraceDays,'D'))),
																			  EXISTS(inRow.Deas.sources(filecode in filecode_dea_active)));
			
			// If we have an Active license with termination date of blank or in the future after 
			// current date then keep the Active status record.
			todayis:=ut.GetDate;
			
			boolean isActiveLicense := exists(dsStLicenses(LicenseStatus = 'A' and LicenseState = cookedstate and IsInputStateDefined));																
			boolean isSuspendedLicense := exists(dsStLicenses(LicenseStatus = 'S'));
			
			boolean isLicenseDeath := exists(dsStLicenses(LicenseStatus = 'D'));  // when you are dead , state code does not matter.
			boolean isRetired:= if (exists(dsStLicenses(LicenseStatus = 'R' and LicenseState = cookedstate )) and IsInputStateDefined,true,false);
			setR := isRetired;						
			
			// match on state since we are looking KIR records due to non matching address keys (not needed anymore)
			// boolean isINACTKIR  := exists(inRow.RecordsRaw(kil_code[1..3] = 'KIR')) and IsInputStateDefined and exists(inRow.RecordsRaw(prac1.state = cookedstate));
			boolean isINACTKIR  := exists(inRow.RecordsRaw(kil_code[1..3] = 'KIR' and prac1.state = cookedstate)) and IsInputStateDefined;
			
			// When you are dead you are dead - it does not matter what state code you are dead in!
			boolean isINACTKID  := exists(inRow.MiscInfo(kil_code[1..3] = 'KID')); //Also if subsrc is INACT_VSF then deathsources in [512,4096] or DEATHSRC_CALLPVKID,DEATHSRC_CALLFAXVKID
			isLicenseDeathMatchedState := inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_LICENSEDSTATE > 0;	//256
			isPhoneVerified := inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_CALLPVKID > 0;									//512
			isCPDeath := inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_CPDFLAG > 0;													//1024
			isFaxVerified := inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_CALLFAXVKID > 0;									//4096
			
			filecode_npi_retired:=[healthcare_shared.SourceTools.src_NPI_RET,
										  healthcare_shared.SourceTools.src_NPI_FRET];
			filecode_npi_active:=[healthcare_shared.SourceTools.src_NPI_IDV,
										  healthcare_shared.SourceTools.src_FKA_NPI,healthcare_shared.SourceTools.src_NPI_FAC];						
			
						
			// Future , we should check grace period when NPI is entered.
			// boolean isDeactivatedNPI := EXISTS(inRow.NPIs(npi_deact_date not in ['','0000-00-00']  
																							// and (integer) healthcare_shared.functions.cleanOnlyNumbers(npi_deact_date) > 0 
																							// and Healthcare_shared.functions.isExpiredWithGrace((string)healthcare_shared.functions.cleanOnlyNumbers(npi_deact_date),cfg[1].npiGraceDays,'D')));
			
			// Future, we should check grace period when NPI is entered.
			// boolean isActiveNPI := EXISTS(inRow.NPIs(npi_deact_date in ['','0000-00-00']  
																							// or (integer) healthcare_shared.functions.cleanOnlyNumbers(npi_deact_date) > 0 
																							// and NOT Healthcare_shared.functions.isExpiredWithGrace((string)healthcare_shared.functions.cleanOnlyNumbers(npi_deact_date),cfg[1].npiGraceDays,'D')));
			// NPI for deactivated and active in  Deceased() just looks at filecode 
			
			boolean isDeactivatedNPI := EXISTS(inRow.NPIs.sources(filecode in filecode_npi_retired));																				
			boolean isActiveNPI := EXISTS(inRow.NPIs.sources(filecode in filecode_npi_active));
			
			
			isDMF_TinSsnDid := inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_DID > 0 or
												 inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_TIN > 0 or
												 inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_SSN > 0;
			isDMF_SSn	:= inRow.DODs[1].deathsources & Healthcare_Shared.Constants.DEATHSRC_SSN > 0;	
			
			boolean isUnconfirmedDeceased1 := isObitsDeath or isCPDeath;
			boolean isUnconfirmedDeceased2 := isDMF_TinSsnDid or isCPXrefDeath or isClaimsXrefDeath or isNPIXrefDeath or isOtherXrefTinDeath;
			boolean isUnconfirmedDeceased3 := isLicenseDeath or isLicenseDeathMatchedState or isPhoneVerified or isFaxVerified;
			// boolean isUnconfirmedDeceased4 := isDeactivatedNPI;  I believe it should be turned on.
			boolean isUnconfirmedDeceased4 := false;
			boolean isUnconfirmedDeceased  := isUnconfirmedDeceased1 or isUnconfirmedDeceased2 or isUnconfirmedDeceased3 or isUnconfirmedDeceased4;
			
			boolean isDeathIndChecked := exists(inRow.Dods(death_ind = true));	
			
			// Get Best DOD date - code from Functions - Use death_child layout
			ApplyFilter := inRow.Dods(dod <> '' and dod<> '00000000' and death_ind = true);
			BEST_DOD_DATE := sort(Dedup(sort(ApplyFilter,if(dod[5..8]='0101',2,1)),dod),-dod);
			DODDate := (integer) Healthcare_Shared.Functions.cleanOnlyNumbers (BEST_DOD_DATE[1].dod);
						
			// Get Best INACT (inact_date) Is last_update_date the inact_date?
			ApplyInactFilter:=inRow.Miscinfo(kil_code[1..3] in ['KIR', 'KID']);
			DSBEST_KIR_DATE:=sort(Dedup(sort(ApplyInactFilter,if(last_update_date<> '',2,1)),last_update_date),-last_update_date);
			BEST_INACT_DATE:=if(isINACTKIR,(integer)Healthcare_Shared.Functions.cleanOnlyNumbers(DSBEST_KIR_DATE[1].last_update_date),0);
						 
			// Get Best Active PV Date- Have to use Addresses to insure the same address state as userinput.st
			// Also , do not use Best PV Date if not in grace period for Phone Verified 
			// LastPhoneVerifiedGraceDay := (integer) ut.date_math(todayis, -ProviderPoint_Healthcare_Shared.Constants.CFG_PHONEVERIFIED_GRACE_DAYS);
			// Only consider the Act PhoneFax Addresses that match the input state !
			getPVActiveRecs := project(inRow.Addresses(st <> '' and st = cookedstate),transform(Healthcare_Shared.Layouts.layout_addressinfo,
																									keepRow:=exists(left.sources(filecode in Healthcare_Shared.SourceTools.set_Act_PhoneFax_ENC));
																									self.acctno:=if(keepRow,left.acctno,skip);self:=left;));
																									
			// getPVActiveRecs := project(inRow.Addresses,transform(Healthcare_Shared.Layouts.layout_addressinfo,
																									// keepRow:=exists(left.sources(filecode in Healthcare_Shared.SourceTools.set_Act_PhoneFax_ENC));
																									// self.acctno:=if(keepRow,left.acctno,skip);self:=left;));
			
			DSBEST_ACTPVDATE:=sort(getPVActiveRecs,-last_update_date);
			FOUND_BEST_ACTPVDATE := (integer) Healthcare_Shared.Functions.cleanOnlyNumbers(DSBEST_ACTPVDATE[1].last_update_date);
			BEST_ACTPVDATE := if(FOUND_BEST_ACTPVDATE < (integer)todayis,FOUND_BEST_ACTPVDATE,0); // guarding against bad future PVdate? can actpvdate be in future?

			getPVActiveAddress_set:= getPVActiveRecs(PracAddress_st&Healthcare_Shared.Constants.inactive<=0 and 
																		(PracAddress_st&Healthcare_Shared.Constants.address_phoneVerified>0 or 
																		 PracAddress_st&Healthcare_Shared.Constants.address_verifiedSecureFax>0));
						
			// No Active Phone Verified allowed where there is an INACT D  or INACT record with the enact_date >  ActivePhoneFaxVerified Date and PVDate must be defined of course.
			boolean trumpisActivePhoneFaxVerified := if(BEST_ACTPVDATE = 0 or isINACTKID or (BEST_INACT_DATE >= BEST_ACTPVDATE), true, false);	
			// Compare the last_update_date from the Phone Fax Verified records to the DODDATE.
			boolean isPVDateBeyondDOD:=if(BEST_ACTPVDATE > DODDATE, true, false);
			//set isActivePhoneFaxVerified only when no trumping of ActivePhoneFaxVerified present and no Death Date and there is a good PV Date.
		  boolean isActivePhoneFaxVerified := if(trumpisActivePhoneFaxVerified or DODDate > 0 or  BEST_ACTPVDATE <= 0
																							or isPVDateBeyondDOD ,false,true); 
			
			// Get Best Retired Date  , Special Cases found in C++ code
			// If there is an Active Phone Verified Record for same Address of course , beyond the retired date,
			// then activate a new flag, DoNotSetR and use it to ignore setting any Retired Status.
		  DSRetired:=sort(dsStLicenses(LicenseStatus = 'R' and LicenseState = cookedstate),-Termination_Date);
			BEST_RETIRED_DATE:=if(isRetired, (integer)Healthcare_Shared.Functions.cleanOnlyNumbers(DSRetired[1].Termination_Date), 0);
			boolean DoNotSetR := if(( BEST_RETIRED_DATE > HealthCare_Shared.Constants.DOB_MINVALUE_CHECK and BEST_RETIRED_DATE < BEST_ACTPVDATE) or (isActiveLicense), true, false);  //trump retired in 1 state ,probably A in other.			
			
			// Take out checking for a stale fax PracAddressFlags.verifiedSecureFaxStale (8 days old) during testing (seems short)
			// As in C++ code , a verified fax or phone from any source with lastupdate > dod forces to ignore Retired flags.
			// I think that should be only from Active sources only.   PracAddressFlags are not set, will they ever be?.
			
			
			// Status Flag Decision MAPs
			
			// From Byron .. it makes sense to call it PotentialR1R2 when there is no active license , but the data did not support
			// it , too many false positives.  The states licenses status is not trustable at a high level - active Phone Fax verified is.
			// boolean isPotentialR1R2 := if( NOT isActiveLicense or (isINACTKIR and (NOT isActivePhoneFaxVerified OR ((integer)BEST_INACT_DATE >= BEST_ACTPVDATE))),true,false);
			// boolean isPotentialR1R2 := if( (isDeactivatedNPI and not isActiveNPI) or isINACTKIR and (NOT isActivePhoneFaxVerified OR ((integer)BEST_INACT_DATE >= BEST_ACTPVDATE)),true,false);
			boolean isPotentialR1R2 := if(isINACTKIR and (NOT isActivePhoneFaxVerified OR ((integer)BEST_INACT_DATE >= BEST_ACTPVDATE)),true,false);
			isActivePhoneFaxVerifiedFinal := if(isPotentialR1R2, false, isActivePhoneFaxVerified);
			AddR4ustat :=  setR and NOT DoNotSetR and NOT isActivePhoneFaxVerifiedFinal;			
			// DeceasedFlag = RP (with R2+R1 provider_ustat added - ie it was an R2 before it was changed to R1)
			// and there is no way to get a U without getting promoted from U1
			// Suggestion - add to R1 close .. "and NOT isActiveNPI" for RP and R1
			isNameMatchStrong := inRow.Dods[1].matchStrength >= Healthcare_Shared.Constants.NameScoreStrength.Strong;		
			DeceasedFlag := MAP(isDeathIndChecked and isDMF_SSn and isNameMatchStrong => 'D',
													(isUnconfirmedDeceased and isDeathIndChecked) and	((isDeactivatedDEA and NOT isActiveLicense) or isDeactivatedNPI)
													and NOT isActivePhoneFaxVerifiedFinal => 'U',
													isUnconfirmedDeceased and isDeathIndChecked => 'U1',
													(isRetired or isPotentialR1R2)  and (isDeactivatedNPI or (NOT isActiveLicense and NOT isSuspendedLicense )) and (isDeactivatedDEA AND NOT isActiveDea) and AddR4ustat and isInputStateDefined => 'R1R2R4',
													(isRetired or isPotentialR1R2)  and (isDeactivatedNPI or (NOT isActiveLicense and NOT isSuspendedLicense)) and (isDeactivatedDEA AND NOT isActiveDea) and isInputStateDefined => 'R1R2',
													(isRetired or isPotentialR1R2)  and (isDeactivatedNPI or (NOT isActiveLicense and NOT isSuspendedLicense)) and AddR4ustat and isInputStateDefined => 'R1R4',
													(isRetired or isPotentialR1R2)  and (isDeactivatedNPI or (NOT isActiveLicense and NOT isSuspendedLicense)) and isInputStateDefined => 'R1',
													(isRetired or isPotentialR1R2)  and isDeactivatedDEA and NOT isActiveDEA and AddR4ustat and isInputStateDefined => 'R2R4',
													(isRetired or isPotentialR1R2)  and isDeactivatedDEA and NOT isActiveDEA and isInputStateDefined => 'R2',
													 AddR4ustat and isInputStateDefined => 'R4', // R4(aka R) is back for it's ustat value.
													'N');
																									 
			// output(inRow,Named('StatusInfo_inRow'), overwrite);
			// output(isCPXrefDeath,Named('StatusInfo_isCPXrefDeath'), overwrite);
			// output(isClaimsXrefDeath,Named('StatusInfo_isClaimsXrefDeath'), overwrite);
			// output(isNPIXrefDeath,Named('StatusInfo_isNPIXrefDeath'), overwrite);
			// output(isOtherXrefTinDeath,Named('StatusInfo_isOtherXrefTinDeath'), overwrite);
			// output(isObitsDeath,Named('StatusInfo_isObitsDeath'), overwrite);
			// output(cookedState,named('cookedState'),overwrite);
			// output(todayis,named('todayis'),overwrite);
			// output(AddR4ustat,named('AddR4ustat'),overwrite);
			// output(isActivePhoneFaxVerifiedFinal,named('isActivePhoneFaxVerifiedFinal'),overwrite);
			// output(isSuspendedLicense,named('isSuspendedLicense'),overwrite);
			// output(isLicenseDeath,Named('StatusInfo_isLicenseDeath'), overwrite);
			// output(isPotentialR1R2,named('isPotentialR1R2'),overwrite);
			// output(isRetired,Named('StatusInfo_isRetired'), overwrite);
			// output(dsStLicenses,Named('StatusInfo_dsStLicenses'), overwrite);
			// output(isActiveLicense,Named('StatusInfo_isActiveLicense'), overwrite);
			// output(isINACTKID,Named('StatusInfo_isINACTKID'), overwrite);
			// output(isINACTKIR,Named('StatusInfo_isINACTKIR'), overwrite);
			// output(inRow.userinput.match_input.prac1.addr_key,Named('StatusInfo_userinput_addr_key'),overwrite);
			// output(inRow.userinput.match_input.prac1.addr_key,Named('StatusInfo_userinput_addr_key'),overwrite);
			// output(dsAllprac1_addr_key,Named('StatusInfo_dsAllprac1_addr_key'), extend);
			// output(isLicenseDeathMatchedState,Named('StatusInfo_isLicenseDeathMatchedState'), overwrite);
			// output(isPhoneVerified,Named('StatusInfo_isPhoneVerified'), overwrite);
			// output(isCPDeath,Named('StatusInfo_isCPDeath'), overwrite);
			// output(isFaxVerified,Named('StatusInfo_isFaxVerified'), overwrite);
			// output(isUnconfirmedDeceased1,Named('StatusInfo_isUnconfirmedDeceased1'), overwrite);
			// output(isUnconfirmedDeceased2,Named('StatusInfo_isUnconfirmedDeceased2'), overwrite);
			// output(isUnconfirmedDeceased3,Named('StatusInfo_isUnconfirmedDeceased3'), overwrite);
			// output(isUnconfirmedDeceased3,Named('StatusInfo_isUnconfirmedDeceased3'), overwrite);
			// output(isUnconfirmedDeceased4,Named('StatusInfo_isUnconfirmedDeceased4'), overwrite);
			// output(isUnconfirmedDeceased,Named('StatusInfo_isUnconfirmedDeceased'), overwrite);
			// output(isDeactivatedDea,Named('StatusInfo_isDeactivatedDea'), overwrite);
			// output(isActiveDea,Named('StatusInfo_isActiveDea'), overwrite);
			// output(isDeactivatedNPI,Named('StatusInfo_isDeactivatedNPI'), overwrite);
			// output(isInputStateDefined,Named('StatusInfo_isInputStateDefined'),overwrite);
			// output(isDeathIndChecked,Named('StatusInfo_isDeathIndChecked'), overwrite);
			// output(isDMF_TinSsnDid,Named('StatusInfo_isDMF_TinSsnDid'), overwrite);
			// output(ApplyFilter,named('StatusInfo_applyFilter_Dods'), extend);
			// output(DODDate, named('StatusInfo_DODDate'), overwrite);
			// output(getPVActiveRecs,named('StatusInfo_getPVActiveRecs'),extend);
			// output(getPVActiveAddress_set,named('StatusInfo_getPVActiveAddress_set'),extend);
			// output(isActivePhoneFaxVerified,named('StatusInfo_isActivePhoneFaxVerified'), overwrite);
			// output(isActivePhoneFaxVerifiedFinal,named('StatusInfo_isActivePhoneFaxVerifiedFinal'), overwrite);
			// output(isPVDateBeyondDOD,named('StatusInfo_isPVDateBeyondDOD'), overwrite);
			// output(inRow.Dods[1].matchStrength, named('matchStrength'), overwrite);
			// output(inRow.Dods, named('Dods'), extend);
			// output(inRow.Deas, named('StatusInfo_Deas'), extend);
			// output (BEST_INACT_DATE, named('BEST_INACT_DATE'), overwrite);
			// output (BEST_RETIRED_DATE, named('BEST_RETIRED_DATE'), overwrite);
			// output (BEST_ACTPVDATE, named('BEST_ACTPVDATE'), overwrite);
			// output (dsAddresses, named('StatusInfo_dsAddresses'), extend);
			// output (FOUND_BEST_ACTPVDATE, named('FOUND_BEST_ACTPVDATE'), overwrite);
			// output (BEST_RETIRED_DATE, named('BEST_RETIRED_DATE'), overwrite);
			// output (DoNotSetR, named('DoNotSetR'), overwrite);
			// output (SetR, named('SetR'), overwrite);
			// output (trumpisActivePhoneFaxVerified, named('trumpisActivePhoneFaxVerified'), overwrite);
			// output (isActivePhoneFaxVerified, named('isActivePhoneFaxVerified'), overwrite);
			// output (DeceasedFlag, named('DeceasedFlag'), overwrite);
			return DeceasedFlag;
	end;
End;