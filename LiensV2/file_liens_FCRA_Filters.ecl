IMPORT	LiensV2, LiensV2_SrcInfoRpt, LiensV2_preprocess;

// Create a set of filing types that match the Filing Descriptions we want to filter
VacateString          :=  '(VACATE)';
FIEString             :=  '(FILED IN ERROR)';
CivilDismissalString  :=  '(CIVIL DISMISSAL)';
sVacateSet            :=  SET(LiensV2_preprocess.Files_lkp.HGFiling_type(REGEXFIND(VacateString, filetype_desc)),filetype_cd);
sFIESet               :=  SET(LiensV2_preprocess.Files_lkp.HGFiling_type(REGEXFIND(FIEString, filetype_desc)),filetype_cd);
sCivilDismissalSet    :=  SET(LiensV2_preprocess.Files_lkp.HGFiling_type(REGEXFIND(CivilDismissalString, filetype_desc)),filetype_cd);

sFilingTypeSet        :=  sVacateSet+sFIESet+sCivilDismissalSet;

// Our File Suppressions Layout
rLiensSuppressions	:=	RECORD
	STRING50 tmsid;
	STRING50 rmsid;
  STRING45 CaseLinkID;
	STRING7  COURTID;
	STRING2  Filing_Type_ID;
	BOOLEAN  bDOPSSuppression				    :=	FALSE;
	BOOLEAN  bHoganSuppression			    :=	FALSE;
	BOOLEAN  bVacatedSuppression		    :=	FALSE;
	BOOLEAN  bMedicalSuppression		    :=	FALSE;
	BOOLEAN  bJurisdictionSuppression	  :=	FALSE;
	BOOLEAN  bFilteredByCaseLinkID   	  :=	FALSE;
	BOOLEAN  bFilteredByVacate       	  :=	FALSE;
	BOOLEAN  bFilteredByFIE          	  :=	FALSE;
	BOOLEAN  bFilteredByCivilDismissal  :=	FALSE;
	BOOLEAN  bFilteredByFilingTypeID 	  :=	FALSE;
END;


dLiensMain        :=	LiensV2.file_liens_main;
dLiensParty       :=	LiensV2.File_Liens_Party_BIPV2_with_Linkflags;


//	TMSIDs Suppressed by Customer (These should already be suppressed in the file attributes)
dDOPSSuppressionMain  :=	dLiensMain(tmsid	IN	Liensv2.Suppress_TMSID(TRUE));
dDOPSSuppressionParty :=	dLiensParty(tmsid	IN	Liensv2.Suppress_TMSID(TRUE));

dDOPSSuppression	:=	PROJECT(dDOPSSuppressionMain,
                        TRANSFORM(
                          rLiensSuppressions,
                          SELF.bDOPSSuppression :=	TRUE;
                          SELF.rmsid            :=  '';
                          SELF.CaseLinkID       :=  '';
                          SELF.COURTID          :=  '';
                          SELF                  :=	LEFT;
                        )
                      )+
                      PROJECT(dDOPSSuppressionParty,
                        TRANSFORM(
                          rLiensSuppressions,
                          SELF.bDOPSSuppression	:=  TRUE;
                          SELF.rmsid            :=  '';
                          SELF.COURTID          :=  '';
                          SELF.Filing_Type_ID   :=  '';
                          SELF.CaseLinkID       :=  '';
                          SELF                  :=  LEFT;
                        )
                      );

//	TMSIDs Suppressed by Source Type (Non-Hogan Records)
dHoganSuppressionMain		:=	dLiensMain(	tmsid[..2]	NOT IN	['HG']);
dHoganSuppressionParty	:=	dLiensParty(tmsid[..2]	NOT IN	['HG']);

dHoganSuppression	:=	PROJECT(dHoganSuppressionMain,
                        TRANSFORM(
                          rLiensSuppressions,
                          SELF.bHoganSuppression  :=  TRUE;
                          SELF.rmsid              :=  '';
                          SELF.COURTID            :=  '';
                          SELF.Filing_Type_ID     :=  '';
                          SELF.CaseLinkID         :=  '';
                          SELF                    :=  LEFT;
                        )
                      )+
                      PROJECT(dHoganSuppressionParty,
                        TRANSFORM(
                          rLiensSuppressions,
                          SELF.bHoganSuppression  :=  TRUE;
                          SELF.rmsid              :=  '';
                          SELF.COURTID            :=  '';
                          SELF.Filing_Type_ID     :=  '';
                          SELF.CaseLinkID         :=  '';
                          SELF                    :=  LEFT;
                        )
                      );

//	TMSIDs Suppressed by Filing Type
rmv_filing	:=	LiensV2.FCRAFilingTypeDescFilter;
dVacatedSuppressionMain	:=	dLiensMain(
                              REGEXFIND(rmv_filing, filing_type_desc)	OR 
                              REGEXFIND(rmv_filing, filing_status[1].filing_status_desc)	OR 
                              REGEXFIND(rmv_filing, orig_filing_type)
                            );

dVacatedSuppression	:=	PROJECT(dVacatedSuppressionMain,
                        TRANSFORM(
                         rLiensSuppressions,
                         SELF.bVacatedSuppression	:=  TRUE;
                          SELF.rmsid              :=  '';
                          SELF.COURTID            :=  '';
                          SELF.CaseLinkID         :=  '';
                         SELF                     :=  LEFT
                        )
                       );
                       
//	Set Medical Term Flag for Party records (orig_name contains a Medical Term in the field)
  /*  Add Orig_Name to Liens Main */
dLiensMainWithOrigName  :=  JOIN(
                              DEDUP(SORT(DISTRIBUTE(dLiensMain,
                                HASH( tmsid)),
                                      tmsid, LOCAL),
                                      tmsid, LOCAL),
                              DISTRIBUTE(dLiensParty(name_type IN ['C']),HASH(tmsid)),
                                LEFT.tmsid  = RIGHT.tmsid,
                              TRANSFORM(
                                {
                                  RECORDOF(LEFT),
                                  STRING  orig_name :=  ''; 
                                },
                                SELF.orig_name      :=  RIGHT.orig_name;
                                SELF.tmsid          :=  IF(LEFT.tmsid<>'',LEFT.tmsid,RIGHT.tmsid);
                                SELF                :=  LEFT;
                              ),
                              LOCAL,
                              RIGHT OUTER // RIGHT OUTER takes care of any PARTY orphans
                            );
  /*  Set Medical Terms Flag  */
LiensV2.MAC_Remove_Medical_Terms(	
                                  dLiensMainWithOrigName,
                                  orig_name,
                                  dLiensMainWithMedicalTerms
                                );

  /*  Project results into our layout */
dMedicalSuppression	:=	PROJECT(dLiensMainWithMedicalTerms(bHasMedicalTerm),
                          TRANSFORM(
                            rLiensSuppressions,
                            SELF.bMedicalSuppression  :=  TRUE;
                            SELF.rmsid                :=  '';
                            SELF.COURTID              :=  '';
                            SELF                      :=  LEFT
                          )
                        );
                       												
//	Remove Main records by TMSID/RMSID from Jurisdictions that are non-updating
dJurisdictionSuppression	:=	JOIN(
                                DEDUP(SORT(DISTRIBUTE(dLiensMain,
                                HASH( TMSID, RMSID)),
                                      TMSID, RMSID,LOCAL),
                                      TMSID, RMSID,LOCAL),
                                DEDUP(SORT(DISTRIBUTE(LiensV2_SrcInfoRpt.fn_SuppressedFCRALiensMain,
                                HASH( TMSID, RMSID)),
                                      TMSID, RMSID,LOCAL),
                                      TMSID, RMSID,LOCAL),
                                  LEFT.tmsid  = RIGHT.tmsid	AND
                                  LEFT.rmsid  = RIGHT.rmsid,
                                TRANSFORM(
                                  rLiensSuppressions,
                                  SELF.bJurisdictionSuppression :=  TRUE;
                                  SELF.CourtID                  :=  '';
                                  SELF                          :=  LEFT;
                                ),
                                LOCAL
                              );

rLiensSuppressions	tTMSIDSuppressions(rLiensSuppressions l,	DATASET(rLiensSuppressions)	allRows)	:=	TRANSFORM
  SELF.tmsid                      :=  l.tmsid;
  SELF.rmsid                      :=  '';
  SELF.CaseLinkID                 :=  '';
  SELF.COURTID                    :=  '';
  SELF.Filing_Type_ID             :=  '';
  SELF.bDOPSSuppression           :=  COUNT(allRows(bDOPSSuppression))>0;
  SELF.bHoganSuppression          :=  COUNT(allRows(bHoganSuppression))>0;
  SELF.bVacatedSuppression        :=  COUNT(allRows(bVacatedSuppression))>0;
  SELF.bMedicalSuppression        :=  COUNT(allRows(bMedicalSuppression))>0;
  SELF.bJurisdictionSuppression   :=  FALSE;
  SELF.bFilteredByCaseLinkID      :=  FALSE;
  SELF.bFilteredByVacate       	  :=  COUNT(allRows(Filing_Type_ID IN sVacateSet))>0;
  SELF.bFilteredByFIE          	  :=  COUNT(allRows(Filing_Type_ID IN sFIESet))>0;
  SELF.bFilteredByCivilDismissal  :=  COUNT(allRows(Filing_Type_ID IN sCivilDismissalSet))>0;
  SELF.bFilteredByFilingTypeID    :=  COUNT(allRows(Filing_Type_ID IN sFilingTypeSet))>0;
END;

// ROLLUP Suppressions that are based on TMSID Only
dTMSIDFlags	:=	dDOPSSuppression+dHoganSuppression+dVacatedSuppression+dMedicalSuppression;
dTMSIDFlagsGrp  :=	GROUP(SORT(DISTRIBUTE(dTMSIDFlags,
                      HASH( tmsid)),
                            tmsid,LOCAL),
                            tmsid,LOCAL);
dTMSIDSuppressions  :=	ROLLUP(dTMSIDFlagsGrp, GROUP, tTMSIDSuppressions(LEFT,ROWS(LEFT)));

// Join Suppressions based on TMSID with Suppressions based on TMSID and RMSID
dTMSIDOnlyWithTMSIDAndRMSID	:=	JOIN(
                                  DISTRIBUTE(dTMSIDSuppressions,HASH(tmsid)),
                                  DISTRIBUTE(dJurisdictionSuppression,HASH(tmsid)),
                                    LEFT.tmsid      = RIGHT.tmsid,
                                  TRANSFORM(
                                    rLiensSuppressions,
                                    SELF.tmsid                    :=  IF(LEFT.tmsid<>'',LEFT.tmsid,RIGHT.tmsid);
                                    SELF.rmsid                    :=  RIGHT.rmsid;
                                    SELF.bJurisdictionSuppression :=  RIGHT.bJurisdictionSuppression;
                                    SELF                          :=  LEFT;
                                  ),
                                  LOCAL,
                                  FULL OUTER
                                );

//  Join TMSID/RMSID Flags with CaseLinkIDs
dTMSIDAndRMSIDWithCaseLinkID	:=	JOIN(
                                    DEDUP(SORT(DISTRIBUTE(dLiensMain(CaseLinkID<>''),
                                      HASH( tmsid)),
                                            tmsid, CaseLinkID, LOCAL),
                                            tmsid, CaseLinkID, LOCAL),
                                    DISTRIBUTE(dTMSIDOnlyWithTMSIDAndRMSID,HASH(tmsid)),
                                      LEFT.tmsid	=	RIGHT.tmsid,
                                    TRANSFORM(
                                      RECORDOF(RIGHT),
                                      SELF.tmsid                    :=  IF(RIGHT.tmsid<>'',RIGHT.tmsid,LEFT.tmsid);
                                      SELF.COURTID                  :=  SELF.tmsid[LENGTH(TRIM(SELF.tmsid,LEFT,RIGHT))-6..];
                                      SELF.CaseLinkID               :=  LEFT.CaseLinkID;
                                      SELF                          :=  RIGHT;
                                    ),
                                    FULL OUTER,
                                    LOCAL
                                  );

// Propogate TMSID/RMSID Cluster Flags to CaseLinkID Clusters
dSetCaseLinkIDClusterFlags	:=	JOIN(
                                  DEDUP(SORT(DISTRIBUTE(dTMSIDAndRMSIDWithCaseLinkID(
                                    CaseLinkID <> '' AND
                                    (
                                      bVacatedSuppression OR
                                      bMedicalSuppression OR
                                      bJurisdictionSuppression
                                    )
                                  ),HASH( CaseLinkID, COURTID)),
                                          CaseLinkID, COURTID, LOCAL),
                                          CaseLinkID, COURTID, LOCAL),
                                  DISTRIBUTE(dTMSIDAndRMSIDWithCaseLinkID(
                                    CaseLinkID <> '' AND
                                    ~bVacatedSuppression AND
                                    ~bMedicalSuppression AND
                                    ~bJurisdictionSuppression
                                  ),HASH(CaseLinkID, COURTID)),
                                    LEFT.CaseLinkID = RIGHT.CaseLinkID AND
                                    LEFT.COURTID    = RIGHT.COURTID,
                                  TRANSFORM(
                                    rLiensSuppressions,
                                    SELF.bFilteredByCaseLinkID      :=	LEFT.CaseLinkID = RIGHT.CaseLinkID;
                                    SELF.bVacatedSuppression        :=	LEFT.bVacatedSuppression;
                                    SELF.bMedicalSuppression        :=	LEFT.bMedicalSuppression;
                                    SELF.bJurisdictionSuppression   :=	LEFT.bJurisdictionSuppression;
                                    SELF.bFilteredByVacate          :=	LEFT.bFilteredByVacate OR RIGHT.bFilteredByVacate;
                                    SELF.bFilteredByFIE             :=	LEFT.bFilteredByFIE OR RIGHT.bFilteredByFIE;
                                    SELF.bFilteredByCivilDismissal  :=	LEFT.bFilteredByCivilDismissal OR RIGHT.bFilteredByCivilDismissal;
                                    SELF.bFilteredByFilingTypeID    :=	LEFT.bFilteredByFilingTypeID OR RIGHT.bFilteredByFilingTypeID;
                                    SELF                            :=	RIGHT;
                                  ),
                                  LOCAL,
                                  RIGHT OUTER
                                );

rLiensSuppressions	tTMSIDCaseLinkIDSuppressions(rLiensSuppressions l,	DATASET(rLiensSuppressions)	allRows)	:=	TRANSFORM
  SELF.tmsid                      :=  l.tmsid;
  SELF.rmsid                      :=  l.rmsid;
  SELF.CaseLinkID                 :=  '';
  SELF.COURTID                    :=  '';
  SELF.Filing_Type_ID             :=  '';
  SELF.bDOPSSuppression           :=  COUNT(allRows(bDOPSSuppression))>0;
  SELF.bHoganSuppression          :=  COUNT(allRows(bHoganSuppression))>0;
  SELF.bVacatedSuppression        :=  COUNT(allRows(bVacatedSuppression))>0;
  SELF.bMedicalSuppression        :=  COUNT(allRows(bMedicalSuppression))>0;
  SELF.bJurisdictionSuppression   :=  COUNT(allRows(bJurisdictionSuppression))>0;
  SELF.bFilteredByCaseLinkID      :=  COUNT(allRows(bFilteredByCaseLinkID))>0;
  SELF.bFilteredByVacate       	  :=  COUNT(allRows(bFilteredByVacate))>0;
  SELF.bFilteredByFIE          	  :=  COUNT(allRows(bFilteredByFIE))>0;
  SELF.bFilteredByCivilDismissal  :=  COUNT(allRows(bFilteredByCivilDismissal))>0;
  SELF.bFilteredByFilingTypeID    :=  COUNT(allRows(bFilteredByFilingTypeID))>0;
END;

// ROLLUP one more time to combine TMSID/RMSID clusters with CaseLinkID clusters
dCombineTMSIDAndCaseLinkIDClusters  :=	GROUP(SORT(DISTRIBUTE(dSetCaseLinkIDClusterFlags +
                                                              dTMSIDOnlyWithTMSIDAndRMSID(
                                                                CaseLinkID = ''     OR
                                                                COURTID    = ''     OR
                                                                bVacatedSuppression OR
                                                                bMedicalSuppression OR
                                                                bJurisdictionSuppression
                                                              ),
                                        HASH( tmsid, rmsid)),
                                              tmsid, rmsid,LOCAL),
                                              tmsid, rmsid,LOCAL);
dTMSIDCaseLinkIDSuppressions	:=	ROLLUP(dCombineTMSIDAndCaseLinkIDClusters, GROUP, tTMSIDCaseLinkIDSuppressions(LEFT,ROWS(LEFT))):PERSIST('~thor_data400::persist::file_liens_fcra_filter');

EXPORT  file_liens_FCRA_Filters :=  dTMSIDCaseLinkIDSuppressions;
