IMPORT DueDiligence, BIPv2, iesp, STD;

EXPORT reportIndProfLicense(DATASET(DueDiligence.layouts.Indv_Internal) inData) 
                                                                                := FUNCTION

//grab the licenses and place them in a temp results set called profLicenses.
  profLicenses := NORMALIZE(inData, LEFT.individual.licenses, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, UNSIGNED4 mostRecentDate, 
                                                                                                                                       UNSIGNED4 secondRecentDate, 
                                                                                                                                       STRING lastName, 
                                                                                                                                       DATASET(iesp.duediligenceshared.t_DDRProfessionalLicenses) lics},
                                                                          /*  grab all the license information from the RIGHT and start populating the professional license section of the report  */  
                                                                          SELF.lics := PROJECT(LEFT, TRANSFORM(iesp.duediligenceshared.t_DDRProfessionalLicenses,
                                                                                                                SELF.IssuingAgency := RIGHT.licenseCategory;
                                                                                                                SELF.License := RIGHT.licenseType;
                                                                                                                SELF.IssueDate := iesp.ECL2ESP.toDate(RIGHT.issueDate);
                                                                                                                SELF.ExpirationDate := iesp.ECL2ESP.toDate(RIGHT.expirationDate);
                                                                                                                SELF.Status := IF(RIGHT.isactive, 'ACTIVE', 'INACTIVE');
                                                                                                                SELF.LawAccounting := RIGHT.lawacct;
                                                                                                                SELF.FinanceRealEstate := RIGHT.realEstate;
                                                                                                                SELF.MedicalDoctor := RIGHT.medical;
                                                                                                                SELF.PilotMarinePilotHarborPilotExplosives := RIGHT.blastPilot;
                                                                                                                SELF := [];));
                                                                          SELF.mostRecentDate := RIGHT.expirationDate;
                                                                          SELF.secondRecentDate := RIGHT.issueDate;
                                                                          SELF.lastName := LEFT.individual.lastName;
                                                                          SELF.did := LEFT.individual.did;
                                                                          SELF := LEFT;
                                                                          SELF := [];));
 
	cleanProfLicDate := DueDiligence.Common.CleanDatasetDateFields(profLicenses, 'mostRecentDate, secondRecentDate');                                                                        
                                                                          
  limitedLics := GROUP(SORT(cleanProfLicDate, seq, did, -mostRecentDate -secondRecentDate, lastName), seq, did);
  workingLics := DueDiligence.Common.GetMaxRecords(limitedLics, iesp.constants.DDRAttributesConst.MaxLicenses);   
  
  rollIndLics := ROLLUP(SORT(workingLics, seq, did),
                        LEFT.seq = RIGHT.seq AND
                        LEFT.did = RIGHT.did,
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF.lics := LEFT.lics + RIGHT.lics;
                                  SELF := LEFT));
  
  addLics := JOIN(inData, rollIndLics,
                  LEFT.seq = RIGHT.seq AND
                  LEFT.inquiredDID = RIGHT.did,
                  TRANSFORM(RECORDOF(LEFT),
                            /*  populate the professional license data within the professional network section of the person attributes  of the person report  */
                            SELF.personReport.PersonAttributeDetails.ProfessionalNetwork.ProfessionalLicenses := RIGHT.lics;
                            SELF := LEFT;),
                  LEFT OUTER,
                  ATMOST(1));
                  
                  
  // OUTPUT(inData, NAMED('inData'));
  // OUTPUT(profLicenses, NAMED('profLicenses'));
  // OUTPUT(limitedLics, NAMED('limitedLics'));
  // OUTPUT(workingLics, NAMED('workingLics'));
  // OUTPUT(rollIndLics, NAMED('rollIndLics'));
  // OUTPUT(addLics, NAMED('addLics'));
  
  
   
  RETURN addLics;                                  
END;                                  
  