IMPORT	LiensV2,	LiensV2_SrcInfoRpt,	BIPV2,	FCRA,	STD,	lib_date;

dLiensParty                     :=	LiensV2.File_Liens_Party_BIPV2_with_Linkflags;
dAllSuppressionsWithCaseLinkID	:=	LiensV2.file_liens_FCRA_Filters;
//  Join our Party file with the Suppressions file to get the flags
dLiensPartyWithFlags :=  JOIN(
                          DISTRIBUTE(dAllSuppressionsWithCaseLinkID(
                            bDOPSSuppression         OR
                            bHoganSuppression        OR
                            bVacatedSuppression      OR
                            bMedicalSuppression      OR
                            bJurisdictionSuppression
                          ),HASH(tmsid)),
                          DISTRIBUTE(dLiensParty,HASH(tmsid)),
                            LEFT.tmsid	=	RIGHT.tmsid	AND
                            (
                             // Jurisdictions Suppressions requires TMSID/RMSID match
                             (
                              LEFT.rmsid	=	RIGHT.rmsid	AND
                              LEFT.bJurisdictionSuppression
                             )	                      OR
                             LEFT.bDOPSSuppression    OR
                             LEFT.bHoganSuppression   OR
                             LEFT.bVacatedSuppression OR
                             LEFT.bMedicalSuppression
                            ),
                          TRANSFORM(
                            {
                              RECORDOF(RIGHT);
                              BOOLEAN bDOPSSuppression          :=	FALSE;
                              BOOLEAN bHoganSuppression         :=	FALSE;
                              BOOLEAN bVacatedSuppression       :=	FALSE;
                              BOOLEAN bMedicalSuppression       :=	FALSE;
                              BOOLEAN bJurisdictionSuppression  :=	FALSE;
                              BOOLEAN bFilteredByCaseLinkID     :=	FALSE;
                              BOOLEAN bFilteredByVacate         :=	FALSE;
                              BOOLEAN bFilteredByFIE            :=	FALSE;
                              BOOLEAN bFilteredByCivilDismissal :=	FALSE;
                              BOOLEAN bFilteredByFilingTypeID   :=	FALSE;
                            },
                            SELF.bDOPSSuppression           :=	LEFT.bDOPSSuppression;
                            SELF.bHoganSuppression          :=	LEFT.bHoganSuppression;
                            SELF.bVacatedSuppression        :=	LEFT.bVacatedSuppression;
                            SELF.bMedicalSuppression        :=	LEFT.bMedicalSuppression;
                            SELF.bJurisdictionSuppression   :=	LEFT.bJurisdictionSuppression;
                            SELF.bFilteredByCaseLinkID      :=  LEFT.bFilteredByCaseLinkID;
                            SELF.bFilteredByVacate          :=	LEFT.bFilteredByVacate;
                            SELF.bFilteredByFIE             :=	LEFT.bFilteredByFIE;
                            SELF.bFilteredByCivilDismissal  :=	LEFT.bFilteredByCivilDismissal;
                            SELF.bFilteredByFilingTypeID    :=	LEFT.bFilteredByFilingTypeID;
                            SELF                            :=	RIGHT;
                          ),
                          RIGHT OUTER,
                          LOCAL
                        ):PERSIST('~thor_data400::persist::filtered::file_liens_fcra_party');

dLiensPartySuppressed  :=  dLiensPartyWithFlags(
                            (
                              ~bDOPSSuppression     AND
                              ~bHoganSuppression    AND
                              ~bVacatedSuppression  AND
                              ~bMedicalSuppression  AND
                              ~bJurisdictionSuppression
                            ) OR
                            (
                              bFilteredByCaseLinkID AND
                              ~bFilteredByFilingTypeID
                            )
                          );



//	Set LexID=0 for Party records that don't meet the Weight threshold.
dPartyFCRALexIDFilter	:=	PROJECT(	
                            dLiensPartySuppressed,
                            TRANSFORM(
                              LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags,
                              SELF.did	:=	IF((UNSIGNED)LEFT.did	>	0 AND 
                                                (	LEFT.xadl2_weight >=	32 AND (LEFT.xadl2_distance	>=	9 OR LEFT.xadl2_distance	=	0)	OR
                                                  LEFT.xadl2_weight	=	0	)
                                              ,LEFT.did
                                              ,INTFORMAT(0,LENGTH(LEFT.did),1)
                                            );
                              SELF	:=	LEFT;
                            )
                          );
									
EXPORT	file_liens_fcra_party	:=	dPartyFCRALexIDFilter;