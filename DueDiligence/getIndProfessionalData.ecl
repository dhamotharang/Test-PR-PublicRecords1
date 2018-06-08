IMPORT DueDiligence;

  EXPORT getIndProfessionalData(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION


    //Need to convert the inquuired individual into a dataset BEFORE calling the getIndProfLic 
   indivRelatedPartyDS := DueDiligence.CommonIndividual.CreateRelatedPartyDataset(inData);  
   
    //get the professional licenses
   indProfLicenseData := DueDiligence.getIndProfLic(indivRelatedPartyDS);
   
   
   //reformat the license data into the related party - that is pass the DATASET of licenses created by the getIndProfLic 
	joinIndLic := JOIN(inData, indProfLicenseData,
											LEFT.seq         = RIGHT.seq AND
											LEFT.inquiredDID = RIGHT.did,
											TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
                                SELF.did          := RIGHT.did;
                                SELF.party.DID    := RIGHT.did;
																SELF.party.licenses := RIGHT.party.licenses;
																SELF.party.numOfLicenses := COUNT(RIGHT.party.licenses);
																SELF := LEFT; 
                                SELF := [];), //**leave the rest blank - This result set will contain only professional license information.   
											LEFT OUTER);            //***keep at least one record from the LEFT
   
    //roll the licenses to see if an the inquired individual had an active/inactive category				
	 rollLic := ROLLUP(indProfLicenseData, 
										LEFT.seq = RIGHT.seq AND
										LEFT.did = RIGHT.did,
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
  
  //add any license categories to the inquired individual
	addLicenseCat := JOIN(inData, rollLic,
											LEFT.seq         = RIGHT.seq AND
											LEFT.inquiredDID = RIGHT.did,	
											TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																SELF.atleastOneActiveLawAcct := RIGHT.activeLA;
																SELF.atleastOneActiveFinRealEstate := RIGHT.activeFRE;
																SELF.atleastOneActiveMedical := RIGHT.activeMed;
																SELF.atleastOneActiveBlastPilot := RIGHT.activeBP;
																SELF.atleastOneInactiveLawAcct := RIGHT.inactiveLA;
																SELF.atleastOneInactiveFinRealEstate := RIGHT.inactiveFRE;
																SELF.atleastOneInactiveMedical := RIGHT.inactiveMed;
																SELF.atleastOneInactiveBlastPilot := RIGHT.inactiveBP;	
																SELF := LEFT;),
											LEFT OUTER);
											
  //add the list of licenses to the final results before returning.  
	addProfessionalLicenses := JOIN(addLicenseCat, joinIndLic,
											LEFT.seq         = RIGHT.seq AND
											LEFT.inquiredDID = RIGHT.party.did,	
											TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																SELF.individual.licenses := RIGHT.party.licenses;
                                SELF.individual.numoflicenses  := RIGHT.party.numoflicenses;
																SELF := LEFT;),
											LEFT OUTER);                  //***do not drop any records from the LEFT.   Only some individuals have professional licenses (from the RIGHT).
											
   
   
  //OUTPUT(inData, NAMED('inData'));
  //OUTPUT(indivRelatedPartyDS, NAMED('indivRelatedPartyDS'));
  //OUTPUT(indProfLicenseData, NAMED('indProfLicenseData'));
  //OUTPUT(joinIndLic, NAMED('joinIndLic'));
  //OUTPUT(rollLic, NAMED('rollLic'));
  //OUTPUT(addLicenseCat, NAMED('addLicenseCat'));
  //OUTPUT(addProfessionalLicenses, NAMED('addProfessionalLicenses'));
  
  RETURN addProfessionalLicenses;

END;
   