IMPORT	LiensV2_SrcInfoRpt,	FCRA, STD, lib_date;

dLiensMain                      :=	LiensV2.file_liens_main;
dAllSuppressionsWithCaseLinkID	:=	LiensV2.file_liens_FCRA_Filters;

//  Join our Main file with the Suppressions file to get the flags
dLiensMainWithFlags	:=	JOIN(
                          DISTRIBUTE(dAllSuppressionsWithCaseLinkID(
                            bDOPSSuppression         OR
                            bHoganSuppression        OR
                            bVacatedSuppression      OR
                            bMedicalSuppression      OR
                            bJurisdictionSuppression
                          ),HASH(tmsid)),
                          DISTRIBUTE(dLiensMain,HASH(tmsid)),
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
                        ):PERSIST('~thor_data400::persist::filtered::file_liens_fcra_main');
								
dLiensMainSuppressed  :=  dLiensMainWithFlags(
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

//	Set bCBFlag for FCRA
dFillbCBFlag	:=	JOIN(
                    SORT(DISTRIBUTE(dLiensMainSuppressed,
                      HASH(	TMSID,RMSID)),
                            TMSID,RMSID,LOCAL),
                    DEDUP(SORT(DISTRIBUTE(LiensV2.file_Hogan_party,
                      HASH(	TMSID,RMSID)),
                            TMSID,RMSID,bCBFlag,LOCAL), // We want any FALSE records at the top
                            TMSID,RMSID,LOCAL),
                      LEFT.tmsid	=	RIGHT.tmsid	AND
                      LEFT.rmsid	=	RIGHT.rmsid,
                    TRANSFORM(
                      liensv2.Layout_liens_main_module.layout_liens_main,
                      SELF.bCBFlag	:=	IF(RIGHT.tmsid<>'',RIGHT.bCBFlag,FALSE);
                      SELF					:=	LEFT;
                    ),
                    LEFT OUTER,
                    LOCAL
                  );

EXPORT	file_liens_fcra_main	:=	dFillbCBFlag;

