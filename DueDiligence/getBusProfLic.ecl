IMPORT BIPv2, prof_licenseV2, riskwise, ut, risk_indicators, Prof_License_Mari, STD;



EXPORT getBusProfLic(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
											BOOLEAN includeReportData) := FUNCTION
											
											
	//grab the executives
	execs := DueDiligence.Common.getExecs(indata);
	
	//call individual routine to get prof licenses for the exec individuals
	profLic := DueDiligence.getIndProfLic(execs, includeReportData);
	
	//join execs with licene data to update licenses for the execs
	joinExecLic := JOIN(execs, profLic,
											LEFT.seq = RIGHT.seq AND
											LEFT.ultID = RIGHT.ultID AND
											LEFT.orgID = RIGHT.orgID AND
											LEFT.seleID = RIGHT.seleID AND
											LEFT.party.did = RIGHT.did,
											TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
																SELF.party.licenses := RIGHT.party.licenses;
																SELF.party.numOfLicenses := COUNT(RIGHT.party.licenses);
																SELF := LEFT;),
											LEFT OUTER);

	//add updated execs back to the inquired business
	addExecsWithLicenses := DueDiligence.Common.ReplaceExecs(indata, joinExecLic);										
																
	//roll the licenses to see if an exec under an inquired business had an active/inactive category				
	rollLic := ROLLUP(profLic, 
										LEFT.seq = RIGHT.seq AND
										LEFT.ultID = RIGHT.ultID AND
										LEFT.orgID = RIGHT.orgID AND
										LEFT.seleID = RIGHT.seleID,
										TRANSFORM({RECORDOF(LEFT)},
															SELF.activeLA := LEFT.activeLA OR RIGHT.activeLA;
															SELF.activeFRE := LEFT.activeFRE OR RIGHT.activeFRE;
															SELF.activeMed := LEFT.activeMed OR RIGHT.activeMed;
															SELF.activeBP := LEFT.activeBP OR RIGHT.activeBP;
															SELF.inactiveLA := LEFT.inactiveLA OR RIGHT.inactiveLA;
															SELF.inactiveFRE := LEFT.inactiveFRE OR RIGHT.inactiveFRE;
															SELF.inactiveMed := LEFT.inactiveMed OR RIGHT.inactiveMed;
															SELF.inactiveBP := LEFT.inactiveBP OR RIGHT.inactiveBP;
															SELF := LEFT;));
	
	//add any license categories to the inquired business
	addExecLic := JOIN(addExecsWithLicenses, rollLic,
											LEFT.seq = RIGHT.seq AND
											LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
											LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
											LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
											TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																SELF.atleastOneActiveLawAcctExec := RIGHT.activeLA;
																SELF.atleastOneActiveFinRealEstateExec := RIGHT.activeFRE;
																SELF.atleastOneActiveMedicalExec := RIGHT.activeMed;
																SELF.atleastOneActiveBlastPilotExec := RIGHT.activeBP;
																SELF.atleastOneInactiveLawAcctExec := RIGHT.inactiveLA;
																SELF.atleastOneInactiveFinRealEstateExec := RIGHT.inactiveFRE;
																SELF.atleastOneInactiveMedicalExec := RIGHT.inactiveMed;
																SELF.atleastOneInactiveBlastPilotExec := RIGHT.inactiveBP;	
																SELF := LEFT;),
											LEFT OUTER);
											




	// OUTPUT(execs, NAMED('execs'));
	// OUTPUT(profLic, NAMED('profLic'));
	// OUTPUT(joinExecLic, NAMED('joinExecLic'));
	
	// OUTPUT(addExecsWithLicenses, NAMED('addExecsWithLicenses'));
	// OUTPUT(rollLic, NAMED('rollLic'));
	// OUTPUT(addExecLic, NAMED('addExecLic'));
	
	
	RETURN addExecLic;											
											
END;											