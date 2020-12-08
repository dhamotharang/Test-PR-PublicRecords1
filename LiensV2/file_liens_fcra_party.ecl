IMPORT	LiensV2,	LiensV2_SrcInfoRpt,	BIPV2,	FCRA,	STD,	lib_date;

dLiensMain                      :=	table(LiensV2.file_liens_main,{tmsid,rmsid,filing_type_id},tmsid,rmsid,filing_type_id,few); //DF_28399
dLiensParty                     :=	LiensV2.File_Liens_Party_BIPV2_with_Linkflags;
dAllSuppressionsWithCaseLinkID	:=	LiensV2.file_liens_FCRA_Filters;
//  Join our Party file with the Suppressions file to get the flags
dLiensPartyWithFlags :=  JOIN(
                          DISTRIBUTE(dAllSuppressionsWithCaseLinkID(
                            bDOPSSuppression         OR
                            bHoganSuppression        OR
                            bVacatedSuppression      OR
                            bMedicalSuppression      OR
                            bJurisdictionSuppression OR
														bLiensWDischrgedBK //DF-28491
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
                             LEFT.bMedicalSuppression OR
														 LEFT.bLiensWDischrgedBK //DF-28491
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
															BOOLEAN bLiensWDischrgedBK        :=  FALSE; //DF-28491
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
														SELF.bLiensWDischrgedBK         :=  LEFT.bLiensWDischrgedBK; //DF-28491
                            SELF                            :=	RIGHT;
                          ),
                          RIGHT OUTER,
                          LOCAL
                        ):PERSIST('~thor_data400::persist::filtered::file_liens_fcra_party1');

dLiensPartySuppressed  :=  dLiensPartyWithFlags(
                            (
                              ~bDOPSSuppression     AND
                              ~bHoganSuppression    AND
                              ~bVacatedSuppression  AND
                              ~bMedicalSuppression  AND
                              ~bJurisdictionSuppression AND
															~bLiensWDischrgedBK //DF-28491
                            ) OR
                            (
                              bFilteredByCaseLinkID AND
                              ~bFilteredByFilingTypeID
                            )
                          );
// count(dLiensPartySuppressed);
PartyWithFilingType := record
dLiensPartySuppressed;
string2 Filing_type_cd := '';
string2 Party_filing_type_cd := '';
string2 Main_filing_type_cd := '';
end;

//Get filing types from main when it is missing in the party record DF-28399

PartyWithFilingType Get_filingType(dLiensMain L, dLiensPartySuppressed R) := transform
Filing_type_cd      := MAP(regexfind('[A-Za-z]{2}',trim(R.rmsid)[length(trim(R.rmsid))-1 ..]) =>trim(R.rmsid)[length(trim(R.rmsid))-1 ..],
                           '');
Main_filing_type_cd := L.filing_type_id;

self.Party_filing_type_cd := Filing_type_cd;
self.Main_filing_type_cd  := Main_filing_type_cd;

self.filing_type_cd := MAP(Filing_type_cd ='' => Main_filing_type_cd,
                           Main_filing_type_cd = '' => Filing_type_cd,
													 Filing_type_cd <> '' and Main_filing_type_cd <>'' and Filing_type_cd <> Main_filing_type_cd => Main_filing_type_cd,
													 Filing_type_cd);
self := R;
end;

dLiensPartySuppressedWithFilingType    := join(dLiensMain,dLiensPartySuppressed, 
                              left.tmsid =right.tmsid and left.rmsid =right.rmsid ,
													    Get_filingType(left,right),right outer);
															

//	Set LexID=0 for Party records that don't meet the Weight threshold. //DF-28399
Pos_Filings :=['AR','CD','RD','RL','RM','RS','VJ','FE','FR','SE','SR','WE','WR'];

dPartyFCRALexIDFilter	:=	PROJECT(	
                            dLiensPartySuppressedWithFilingType,
                            TRANSFORM( LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags,
                              SELF.did	:=	MAP((UNSIGNED)LEFT.did	= 999999001001 and left.orig_name = 'MARSUPIAL, MARK' =>  LEFT.did, //IRS Dummy recs//DF-28399
															                  (UNSIGNED)LEFT.did	>	0 AND 
                                                (LEFT.xadl2_weight >=	32 AND (LEFT.xadl2_distance	>=	9 OR LEFT.xadl2_distance	=	0))=>LEFT.did,
																								(UNSIGNED)LEFT.did	>	0 AND  LEFT.xadl2_weight	=	0	 and left.filing_type_cd in Pos_Filings=> LEFT.did,//DF-28399
                                                INTFORMAT(0,LENGTH(LEFT.did),1)
                                               );
                              SELF	:=	LEFT;
                            )
                          );
//Prevent IRS records from getting filtered out//DF-28399
IRS_tmsid   :=['HG039079925CJ','HG059595359SC','HG059608600ST','HG060692490RL','HG061000819SR','HG061019606FD','HG061953086FR','HG062128930BN'];
IRS_records := Project(dLiensParty(tmsid in IRS_tmsid), LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags);
													

EXPORT	file_liens_fcra_party	:=	dedup(sort(dPartyFCRALexIDFilter+IRS_records,record),record);


