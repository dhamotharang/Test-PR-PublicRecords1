IMPORT DueDiligence, iesp, liensv2, riskwise;

EXPORT reportBusLienDebtorCreditor( 
                                    DATASET(DueDiligence.LayoutsInternal.layout_liens_judgments_categorized) UnreleasedLiens,
											              boolean DebugMode = FALSE
                                   ) := FUNCTION

  // ------                                                                    ------
  // ------  Liens in this list should have already been short listed prior to ------
  // ------  calling this FUNCTION                                             ------
  // ------                                                                    ------
  EmptyDSN         := DATASET([],iesp.duediligenceshared.t_DDRCreditorDebtor);  
  
  // ------                                                                   ------
  // ------ Pick up DEBTOR/CREDITOR information regarding this lien           ------
  // ------                                                                   ------  
  liensPartyCREDITORDEBTOR := JOIN (UnreleasedLiens, liensv2.key_liens_party_id, 
                                    keyed(left.tmsid=right.tmsid) AND 
                                   (unsigned3)(RIGHT.date_first_seen[1..6]) < left.HistoryDate AND 
                                   (unsigned)RIGHT.date_first_seen <> 0 AND	                                                // date first seen was blank on some records
                                    right.name_type IN DueDiligence.Constants.PARTY_SET,                                    // ***Pick up DEBTOR AND CREDITOR records only         
                                    TRANSFORM(DueDiligence.LayoutsInternalReport.BusLiensDebtorsCreditorsFlatLayout,
                                               SELF.seq      := LEFT.seq,       //*** This is the sequence number of the Inquired Business (or the Parent)
                                               SELF.ultid    := LEFT.ultid,
                                               SELF.orgid    := LEFT.orgid,
                                               SELF.seleid   := LEFT.seleid,
                                               SELF.did                    := LEFT.did, 
                                               self.tmsid                   := if(RIGHT.tmsid = DueDiligence.Constants.EMPTY, DueDiligence.Constants.EMPTY, LEFT.tmsid),	
                                               self.rmsid                   := RIGHT.rmsid,
                                               self.party_date_last_seen    := RIGHT.date_vendor_last_reported,           
                                               self.party_date_first_seen   := RIGHT.date_first_seen,
                                               self.NameType                := RIGHT.name_type,
                                               self.TaxID                   := RIGHT.tax_id;
                                               SELF.Name.FULL               := RIGHT.cname;                 //*** For the CREDITOR type records are Businesses or Institutions
                                               SELF.Name.First              := RIGHT.fname;                 //*** Expecting this information for DEBTOR type records          
                                               SELF.Name.Middle             := RIGHT.mname;
                                               SELF.Name.Last               := RIGHT.lname;
                                               SELF.Name.Suffix             := RIGHT.name_suffix; 
                                               SELF.Address.StreetAddress1  := RIGHT.orig_address1;
                                               SELF.Address.StreetAddress2  := RIGHT.orig_address2;
                                               SELF.Address.City            := RIGHT.orig_city;
                                               SELF.Address.State           := RIGHT.orig_state;
                                               SELF.Address.Zip5            := RIGHT.orig_zip5;
                                               SELF.Address.Zip4            := RIGHT.orig_zip4; 
                                               SELF.Address.StreetNumber    := RIGHT.prim_range;
                                               SELF.Address.StreetName      := RIGHT.prim_name;
                                               SELF.Address.UnitDesignation := RIGHT.unit_desig;
                                               SELF.Address.UnitNumber      := RIGHT.sec_range;
                                               SELF.Address.County          := RIGHT.county;                //***This is the 5 digit county - convert to county name
                                               SELF.Address.PostalCode      := RIGHT.zip + RIGHT.zip4;
                                               SELF                         := LEFT;
                                               SELF                         := []),      /*   END the INLINE TRANSFORM   */  
                                    LEFT OUTER,                                                       //***Keep all the lien records even if there are no Debtors found
                                    ATMOST(keyed(left.tmsid=right.tmsid), riskwise.max_atmost));
 
 
  SortLiensParty  := SORT(liensPartyCREDITORDEBTOR, seq, ultid, orgid, seleid, did, tmsid, rmsid, -date_last_seen); 
  
  DedupLiensWithParty := ROLLUP(SortLiensParty,
                                LEFT.seq    = RIGHT.seq     AND  
                                LEFT.ultID  = RIGHT.ultID   AND  
                                LEFT.orgID  = RIGHT.orgID   AND  
                                LEFT.seleID = RIGHT.seleID  AND 
                                LEFT.did                  = RIGHT.did                   AND
                                LEFT.tmsid                = RIGHT.tmsid                 AND  
                                LEFT.rmsid                = RIGHT.rmsid                 AND
                                LEFT.NameType             = RIGHT.NameType,
                                TRANSFORM(RECORDOF (LEFT),
                                           SELF.Name.First   := IF(LEFT.Name.First = DueDiligence.Constants.EMPTY, RIGHT.Name.First, LEFT.Name.First);
                                           SELF.Name.Middle  := IF(LEFT.Name.Middle = DueDiligence.Constants.EMPTY, RIGHT.Name.Middle, LEFT.Name.Middle);
                                           SELF.Name.Last    := IF(LEFT.Name.Last  = DueDiligence.Constants.EMPTY, RIGHT.Name.Last,  LEFT.Name.Last);
                                           SELF.TaxId        := IF(LEFT.TaxId = DueDiligence.Constants.EMPTY, RIGHT.TaxId, LEFT.TaxId);
                                           SELF.Name.Full    := IF(LEFT.Name.Full  = DueDiligence.Constants.EMPTY, RIGHT.Name.Full, LEFT.Name.Full);  
                                           SELF              := LEFT));  
 
  // ------                                                                       ------
  // ------ populate the Liens Section  with the list of Debtors and Creditors    ------
	// ------                                                                       ------
	DueDiligence.LayoutsInternalReport.ReportingofLiensDebtorChildDatasetLayout  FormatTheListOfPartiesForThisLien(DedupLiensWithParty le, Integer CreditorCount) := TRANSFORM,
                                                                                            SKIP(CreditorCount > iesp.constants.DDRAttributesConst.MaxCreditors)
        SELF.seq          := le.seq,                     //*** This is the sequence number of the Inquired Business (or the Parent)
				SELF.ultid        := le.ultid,
				SELF.orgid        := le.orgid,
				SELF.seleid       := le.seleid,
        SELF.did          := le.did,  
        SELF.proxid       := 0;
        SELF.powid        := 0;
        SELF.tmsid        := le.tmsid;  
        SELF.HistoryDate  := le.HistoryDate;
        SELF.FilingType          := le.filing_type_desc;  
        SELF.FilingAmount        := (integer)le.amount;
        SELF.FilingDate.Year     := (unsigned4)le.orig_filing_date[1..4];     //** YYYY
		    SELF.FilingDate.Month    := (unsigned2)le.orig_filing_date[5..6];     //** MM
			  SELF.FilingDate.Day      := (unsigned2)le.orig_filing_date[7..8];     //** DD
        SELF.FilingNumber        := le.filing_number;
        SELF.FilingJurisdiction  := le.filing_jurisdiction;   
        SELF.ReleaseDate.Year    := (unsigned4)le.release_date[1..4];        //** YYYY
		    SELF.ReleaseDate.Month   := (unsigned2)le.release_date[5..6];        //** MM
			  SELF.ReleaseDate.Day     := (unsigned2)le.release_date[7..8];        //** DD
        SELF.Eviction            := IF(le.eviction = DueDiligence.Constants.YES, true, false); 
        SELF.Agency              := le.agency;
        SELF.AgencyCounty        := le.agency_county;  
        SELF.AgencyState         := le.agency_state;
        SELF.NameType            := le.NameType;
    
        /*  Produce a temporary recordset for this row */  
        TEMP_RECORDSET           := PROJECT(le, TRANSFORM(iesp.duediligenceshared.t_DDRCreditorDebtor,
                                                          SELF.Name.First               := LEFT.Name.First;
                                                          SELF.TaxID                    := LEFT.TaxID;
                                                          SELF                          := LEFT;));
       
       TEMP_DATASET               := DATASET([TEMP_RECORDSET],iesp.duediligenceshared.t_DDRCreditorDebtor);
       
       /*  Debtors and Creditors in this layout are DATASETS - so populate with DATASETS not ROWS */
       /*  If this row is a Creditor than don't poplulate the Debtor  */  
       SELF.Debtors               := IF(le.NameType = DueDiligence.Constants.CREDITOR, EMPTYDSN, TEMP_DATASET);
       /*  If this row is a Debtor than don't populate the Creditor   */  
       SELF.Creditors             := IF(le.NameType = DueDiligence.Constants.DEBTOR, EMPTYDSN, TEMP_DATASET);                                                                                                               
	END;  
	
  PartiesChildDataset  :=   PROJECT(DedupLiensWithParty, FormatTheListOfPartiesForThisLien(LEFT, COUNTER));   //***Using this input dataset  
			  
         
  //perform the SORT/ROLLUP to the Business LINKID(Parent) and the TMISD(Children) 
  sortPartiesChildDataset := SORT(PartiesChildDataset, seq, ultid, orgid, seleid, did, tmsid);
 
  RollupPartiesChildDataset := ROLLUP(sortPartiesChildDataset,
                                      #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                      LEFT.did   = RIGHT.did AND
                                      LEFT.tmsid = RIGHT.tmsid, 
                                      TRANSFORM(RECORDOF (LEFT),
                                                // move the entire DATASET of DEBTORS and CREDITORS(these are GrandChildren in the final structure)  ** //
                                                /*  our NameType will be '' after the initial row  for this key */   
                                                CurrentCreditors := IF(LEFT.NameType IN [DueDiligence.Constants.EMPTY, DueDiligence.Constants.CREDITOR], LEFT.Creditors, EmptyDSN);
                                                CurrentDebtors   := IF(LEFT.NameType IN [DueDiligence.Constants.EMPTY, DueDiligence.Constants.DEBTOR], LEFT.Debtors, EmptyDSN);
                                                NextCreditors    := IF(RIGHT.NameType = DueDiligence.Constants.CREDITOR, RIGHT.Creditors, EmptyDSN);
                                                NextDebtors      := IF(RIGHT.NameType = DueDiligence.Constants.DEBTOR, RIGHT.Debtors, EmptyDSN);
                                                
                                                SELF.Creditors  := CurrentCreditors + NextCreditors;
                                                SELF.Debtors    := CurrentDebtors   + NextDebtors,
                                                SELF.NameType   := DueDiligence.Constants.EMPTY;   
                                                /* If there are only row for this TMSID it would be carried forward from the LEFT.  */  
                                                SELF                       := LEFT));                                                                                      
 
 
  SectionWithLiensAndDebtorCreditor  := PROJECT(RollupPartiesChildDataset,
                                                //*  Create a dataset of LIENACTIVITY for this Business LINKID  OR DID (Parent)   //
                                                TRANSFORM({DATASET(iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions) LIENACTIVITY, UNSIGNED4 seq, UNSIGNED6 ultID, UNSIGNED6 orgID, UNSIGNED6 seleID,
                                                                                                                               UNSIGNED6 did, UNSIGNED4 HistoryDate, STRING50 tmsid},
                                                          SELF.LIENACTIVITY  := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions,
                                                                                          /* Notice the DataSet of DEBTORS and CREDITORS below are already DATASETs */ 
                                                                                          SELF.Debtors         := LEFT.Debtors,  
                                                                                          SELF.Creditors       := LEFT.Creditors,
                                                                                          /* Now move the Details of the Lien Information from the LEFT*/
                                                                                          SELF                 := LEFT)]),
                                                          /* continue to populate the LINK IDs */  
                                                          SELF                        := LEFT;
                                                          SELF                        := []));  
	
  
  
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
	IF(DebugMode,     OUTPUT(CHOOSEN(UnreleasedLiens, 100),        NAMED('UnreleasedLiens')));
  IF(DebugMode,     OUTPUT(CHOOSEN(liensPartyCREDITORDEBTOR, 100), NAMED('liensPartyCREDITORDEBTOR')));
  IF(DebugMode,     OUTPUT(CHOOSEN(SortLiensParty, 100),         NAMED('SortLiensParty')));
  IF(DebugMode,     OUTPUT(CHOOSEN(DedupLiensWithParty, 100),    NAMED('DedupLiensWithParty')));
  IF(DebugMode,     OUTPUT(CHOOSEN(PartiesChildDataset, 100),    NAMED('PartiesChildDataset')));
  IF(DebugMode,     OUTPUT(CHOOSEN(sortPartiesChildDataset, 100), NAMED('sortPartiesChildDataset')));
  IF(DebugMode,     OUTPUT(CHOOSEN(RollupPartiesChildDataset, 100), NAMED('RollupPartiesChildDataset')));
  IF(DebugMode,     OUTPUT(CHOOSEN(SectionWithLiensAndDebtorCreditor, 100), NAMED('SectionWithLiensAndDebtorCreditor')));
    
	/*  Return this section of the report to the calling module */   
	Return SectionWithLiensAndDebtorCreditor;
		
	END;   
  