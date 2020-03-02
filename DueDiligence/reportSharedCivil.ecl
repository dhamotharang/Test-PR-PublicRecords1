IMPORT Address, BIPv2, DueDiligence, iesp;


EXPORT reportSharedCivil(DATASET(DueDiligence.LayoutsInternalReport.SharedCivilEvents) inData) := FUNCTION
    
    
    mac_CreditorDebtor(inCreditorDebtor) := FUNCTIONMACRO
                                                            
        RETURN PROJECT(inCreditorDebtor, TRANSFORM(iesp.duediligenceshared.t_DDRCreditorDebtor,
                                                   SELF.name := iesp.ECL2ESP.SetName(LEFT.firstName, LEFT.middleName, LEFT.lastName, LEFT.suffix, DueDiligence.Constants.EMPTY, LEFT.fullName);
                                                   
                                                   streetAddress1 := Address.Addr1FromComponents(LEFT.prim_range,
                                                                                                  LEFT.predir,
                                                                                                  LEFT.prim_name,
                                                                                                  LEFT.addr_suffix,
                                                                                                  LEFT.postdir,
                                                                                                  LEFT.unit_desig,
                                                                                                  LEFT.sec_range);
                                                   
                                                   SELF.address := iesp.ECL2ESP.SetAddress(LEFT.prim_name, LEFT.prim_range, LEFT.predir,
                                                                                            LEFT.postdir, LEFT.addr_suffix, LEFT.unit_desig,
                                                                                            LEFT.sec_range, LEFT.city, LEFT.state, LEFT.zip5,
                                                                                            LEFT.zip4, LEFT.countyName, DueDiligence.Constants.EMPTY, streetAddress1);
                                                   
                                                   SELF.taxID := LEFT.taxID;
                                                   SELF := [];));
    ENDMACRO;
                                                        
                                                        
                                                        
                                                        
                                                        

    //limit data that esp can contain
    limitedLJE := DueDiligence.Common.GetMaxRecords(inData, iesp.constants.DDRAttributesConst.MaxLienJudgementsEvictions);
    
    convertLJEParties := PROJECT(limitedLJE, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions) lje},
                                                        SELF.seq := LEFT.seq;
                                                        SELF.ultID := LEFT.ultID;
                                                        SELF.orgID := LEFT.orgID;
                                                        SELF.seleID := LEFT.seleID;
                                                        SELF.did := LEFT.did;
                                                        
                                                        SELF.lje := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions,
                                                                                        SELF.filingType := LEFT.filingTypeDesc;
                                                                                        SELF.filingAmount := (INTEGER8)LEFT.filingAmount;
                                                                                        SELF.filingDate := iesp.ECL2ESP.toDate(LEFT.filingDate);
                                                                                        SELF.filingNumber := LEFT.filingNumber;
                                                                                        SELF.filingJurisdiction := LEFT.filingJurisdiction;
                                                                                        
                                                                                        SELF.releaseDate := iesp.ECL2ESP.toDate(LEFT.releaseDate);
                                                                                        SELF.eviction := LEFT.eviction = DueDiligence.Constants.YES;
                                                                                        
                                                                                        SELF.agency := LEFT.agency;
                                                                                        SELF.agencyState := LEFT.agencyState;
                                                                                        SELF.agencyCounty := LEFT.agencyCounty;
                                               
                                                                                        SELF.debtors := CHOOSEN(mac_CreditorDebtor(LEFT.debtors), iesp.constants.DDRAttributesConst.MaxDebtors);
                                                                                        SELF.creditors := CHOOSEN(mac_CreditorDebtor(LEFT.creditors), iesp.constants.DDRAttributesConst.MaxCreditors);
                                                                                        
                                                                                        SELF := [];)]);
                                                        SELF := [];));
                                                        
                                                        
    //roll the data to the person/business level
    sortLJEData := SORT(convertLJEParties, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
    
    rollLJEData := ROLLUP(sortLJEData,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.ultID = RIGHT.ultID AND
                          LEFT.orgID = RIGHT.orgID AND
                          LEFT.seleID = RIGHT.seleID AND
                          LEFT.did = RIGHT.did,
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.lje := LEFT.lje + RIGHT.lje;
                                    
                                    SELF := LEFT;));
    
    
    
    

  
    // OUTPUT(limitedLJE, NAMED('limitedLJE'));
    // OUTPUT(convertLJEParties, NAMED('convertLJEParties'));
    // OUTPUT(sortLJEData, NAMED('sortLJEData'));
    // OUTPUT(rollLJEData, NAMED('rollLJEData'));
  
  
  
  RETURN rollLJEData;
END;