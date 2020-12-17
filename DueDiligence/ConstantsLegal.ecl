// IMPORT DueDiligence;


EXPORT ConstantsLegal := MODULE


    EXPORT FELONY := 'F';
    EXPORT MISDEMEANOR := 'M';
    EXPORT INFRACTION := 'I';
    EXPORT TRAFFIC := 'T';


    EXPORT INCARCERATION_TEXT := 'INCARCERATION';
    EXPORT PAROLE_TEXT := 'PAROLE';
    EXPORT PROBATION_TEXT := 'PROBATION';
    EXPORT PREVIOUSLY_INCARCERATED_TEXT := 'PREVIOUS INCARCERATION';


    EXPORT SET_INMATE_STATUS_PAROLE := ['430 PAROLE/COMM SERV', 'ACTIVE, ERS', 'ACTIVE430 PAROLE/COMM SERV', 'ACTIVE90 DAY FAIR PAROLE', 'ACTIVEDWI PAROLE',
                                        'ACTIVEREGULAR PAROLE', 'CLIENT ON PAROLE', 'COMMUTATION OR MODIFIED SENTENCE BY PAROLE BOARD', 'COMPACT IN PAROLE',
                                        'CONDITIONAL RELEASE', 'CONDITIONAL RELEASE BY PARDON & PAROLE BOARD', 'CONTINGENT RELEASE', 'DI, ADMISSION REASON: PARO',
                                        'DI, ADMISSION REASON: PAROVIOL', 'DI, ADMISSION REASON: POSTPARO', 'DISCH. ON PAROLE', 'DISCRETIONARY PAROLE',
                                        'DWI PAROLE', 'GOVERNOR\'S EMERGENCY RELEASE', 'INACTIVE, STANDARD SUPERVISED RELEASE, CONDITIONAL',
                                        'INACTIVE, SUPERVISION DISCHARGE, CONDITIONAL RELEA', 'INMATE BOOT CAMP PAROLE', 'INMATE BOOT CAMP REPRIEVE',
                                        'INTERSTATE PAROLE', 'JAIL PAROLE', 'PAR. CS', 'PAR/HOME CONFINEMENT', 'PAROLE', 'PAROLE BOARD - 90 DAY SENTENCE REDUCTION',
                                        'PAROLE CONTINUED', 'PAROLE TO CONSECUTIVE', 'PAROLE VIOLATION', 'PAROLE; ACTIVE', 'PAROLED',
                                        'PAROLED - REVENUE OWED (MAXED OUT)', 'PAROLED WHILE SERVING TIME IN ANOTHER STATE', 'PCREGULAR PAROLE', 'PRERELEASE CENTER',
                                        'REGULAR PAROLE', 'SPECIAL REPRIEVE OR CONDITIONAL COMMUTATION', 'SPECIAL SENTENCE', 'SUPERVISED REPRIEVE',
                                        'TERMINATED YOA PAROLE', 'YOA PAROLE - CONDITIONAL'];

    EXPORT SET_INMATE_STATUS_PROBATION := ['ABSCONDER - PROBATION', 'ACTIVE SUSPENSE', 'ACTIVE, ABSCONDED SUPERV', 'ACTIVELY SERVING, STANDARD SUPERVISED RELEASE, CON',
                                            'ACTIVEPOST RELEASE SENTENC', 'ACTIVEPROBATION REVOCATION', 'ACTIVESPECIAL PROBATION (S', 'ACTIVESUSPENDED SENTENCE',
                                            'AMENDED OR REMITTED TO PROBATION BY COURT', 'AMENDEDPROBATION REVOCATION', 'CANCELPROBATION REVOCATION',
                                            'CLASS A PROBATION', 'CLASS B/C PROBATION', 'COMMUNITY SUPERVISION', 'COMPACT IN PROBATION', 'COMPACT PROBATION FROM',
                                            'CONDITIONAL RELEASE OF YOUTHFUL OFFENDER', 'CONTINGENT PROBATION', 'CORRECTPROBATION REVOCATION',
                                            'COURTPROBATION REVOCATION', 'COURTSPECIAL PROBATION (S', 'CSD- DEFERRED SENTEN', 'CSD- SUSPENDED SENTE', 'DEFERRED',
                                            'DEFERRED SENTENCE', 'DEFERRED; ACTIVE', 'DI, ADMISSION REASON: PROB',
                                            'DI, ADMISSION REASON: PROBATIO', 'FELONY PROBATION', 'INACTIVE, CONFINEMENT DISCHARGE, CONDITIONAL RELEA',
                                            'INTERSTATE PROBATION', 'PCPROBATION REVOCATION', 'PR, ADMISSION REASON: PROB', 'PROBATION',
                                            'SENTENCED TO: COMMUNITY SERVICES (COMMUNITY RELEAS', 'SPECIAL PROBATION (S', 'SUSPENDED', 'SUSPENDED SENTENCE',
                                            'SUSPENDED SENTENCE; ACCELERATED TO SUSP.SENT.', 'SUSPENDED; ACTIVE', 'SPLIT; ACTIVE'];

    EXPORT SET_INMATE_STATUS_PREVIOUSLY_INCARCERATED := ['DETERMINATE; EXPIRED', 'EXPIRATION OF SENTENCE, INMATE',
                                                          'POST-IMPRISONMENT SU; ACTIVE', 'PAROLE; DISCHARGED', 'PAROLE; EXPIRED',
                                                          'DELAYED INCARCERATED; EXPIRED', 'PRE-RELEASE SUPV. PR; DISCHARGED',
                                                          'POST-IMPRISONMENT SU; EXPIRED', 'INTERSTATE PAROLE; DISCHARGED',
                                                          'PAROLE REVOCATION; EXPIRED', 'P&P POST IMPRISONMEN', 
                                                          'P&P POST IMPRISONMEN; DISCHARGED', 'INTERSTATE PAROLE IN; EXPIRED', 
                                                          'DEATH - UNKNOWN CAUSE, INMATE', 'DISCHARGED BY COURT, INMATE'];
                                                          
    EXPORT SET_INMATE_STATUS_DISCHARGED := ['VALID RELEASE DATE', 'RELEASE', 'RELEASED', 'RELEASED/DISCHARGED',
                                            'EXPIRATION OF SENTENCE', 'CLIENT DISCHARGED', 'EXPIRED', 'DISCHARGED',
                                            'SUSPENDED; EXPIRED', 'SUSPENDED SENTENCE; DISCHARGED', 'SPLIT; EXPIRED',
                                            'MANDATORY DISCHARGE', 'SENTENCE EXPIRED', 'EXPIRATION SENTENCE', 'CLIENT DEAD',
                                            'DEFERRED SENTENCE; DISCHARGED', 'DECEASED', 'INSTITUTIONAL DISCHARGE - TO AOC ISP',
                                            'DEFERRED; EXPIRED', 'INTERSTATE PROBATION; DISCHARGED', 'INACTIVE', 'DISCH', 'DEATH',
                                            'CSD- SUSPENDED SENTE; DISCHARGED', 'DRUG COURT; DISCHARGED', 'DSCHG EX',
                                            'EXPIRATION OF SENTENCE, ERS', 'DEATH, ALL TYPES. SEE DEATH TYPE.', 'VACATED',
                                            'CSD- DEFERRED SENTEN; DISCHARGED', 'RELEASED FROM SUPERVISION', 'DISCHARGED BY COURT',
                                            'INTERSTATE PROBATION; EXPIRED', 'DEATH - NATURAL CAUSES', 'BALANCE SUSPENDED; EXPIRED',
                                            'DELAYED SENTENCE; DISCHARGED', 'CSD-GEN DISCIPLINE S; DISCHARGED', 'COURT ORDERED EARLY RELEASE',
                                            'DEATH - UNKNOWN CAUSE', 'CLOSED', 'DISCHARGED, 20130828', 'RELEASED ON CASE'];
                                            
                                            
    EXPORT SET_INMATE_STATUS_UNKNOWN := ['ACTIVE', 'ACTIVECOMMITTED YOUTHFUL O', 'ACTIVECONTEMPT OF COURT', 'ACTIVECRV TERMINAL', 'ACTIVECRV/3M',
                                          'ACTIVEDWI CONVICTION', 'ACTIVEHABITUAL FELON', 'ACTIVEIMPACT', 'ACTIVEJAIL POST RELEASE',
                                          'ACTIVEMISDEMEANOR CONFINEM', 'ACTIVEPRE-SENTENCE DIAG/IN', 'ALTERNATIVE SECURE', 'AMENDEDPOST RELEASE SENTENC',
                                          'AWOL', 'BOARD ORDER', 'CCNC', 'CLIENT SERVING SENTENCE PREFIX ACTIVE', 'COMMITTED YOUTHFUL O',
                                          'COMMUTED OR MODIFIED SENTENCE BY COURT', 'CONCURRENT', 'CONTROLLING SENTENCE', 'CONV', 'CORRECTED NUMBER ASSIGNMENT RECORD',
                                          'CORRECTHABITUAL FELON', 'CORRECTPOST RELEASE SENTENC', 'COURT ORDER', 'COURTIMPACT', 'COURTPRE-SENTENCE DIAG/IN',
                                          'CRV TERMINAL', 'DI', 'DI, ADMISSION REASON: NEWCASE', 'DI, ADMISSION REASON: POST', 
                                          'DI, ADMISSION REASON: POSTSUPR', 'DI, ADMISSION REASON: UNKNOWN', 'DI, ADMISSION REASON: VIOL', 'DIAGNOSTIC',
                                          'DISCHARGE TO CONSECUTIVE', 'DIV OF CORRECTIONS OFFENDER', 'DRUG COURT', 'DWI CONVICTION', 'ESC/ABSC', 'FUTURE',
                                          'IMPACT', 'IN, ADMISSION REASON: NEWCASE', 'IN, ADMISSION REASON: VIOL', 'INACTIVE, INTENSIVE SUPERVISED RELEASE, CONDITIONA',
                                          'INACTIVE, STANDARD CONFINEMENT, CONDITIONAL RELEAS', 'INSTITUTIONAL DISCHARGE - RECALL', 'INTERSTATE COMPACT P',
                                          'INTERSTATE COMPACT', 'LC, ADMISSION REASON: VIOL', 'MISDEMEANOR CONFINEM', 'NON-JUDGEMENT', 'PA, ADMISSION REASON: PARO, ABSC',
                                          'PENDING', 'PL$DE', 'PLEA ABEYANCE', 'PO', 'PO, ABSC', 'PO, ADMISSION REASON: POST', 'PO, IMMI', 'PO, UNSU', 'PR',
                                          'PR, ADMISSION REASON: NEWCASE, ABSC', 'PR, ADMISSION REASON: NEWCASE, CMPO', 'PR, ADMISSION REASON: NEWCASE, WARR',
                                          'PR, ADMISSION REASON: PROB, ABSC', 'PRAYER FOR JUDGMENT', 'PRETRIAL RELEASE WIT', 'PRIOR CONVICTION', 'REL. C/S',
                                          'SENTENCED TO: ASSESSMENT & CLASSIFICATION CENTER;', 'SENTENCED TO: CONTROLLED INTAKE;', 'SPLIT', 'TO BE SET',
                                          'UNDER CUSTODY', 'UNSENTENCED', 'WEC RLSE-SUCCESSFUL'];




    ///////////////////////////////////////////////////////
    //These are the 5 digit court offense levels that can
    //be mapped to a FELONY/MISDEMEANOR/TRAFFIC/INFRACTION
    ///////////////////////////////////////////////////////
    EXPORT SET_FELONY := ['CA', '*F', '1F', '2F', '3F', '4 F', '4F', ';F2', 'AF', 'AF1', 
                         'AF2', 'AF3', 'AF4', 'AGGF1', 'AGGF2', 'AGGF3', 'CAPIA', 'CCA', 
                         'CF', 'CL', 'DF', 'F', 'F 3', 'F*', 'F*;F*', 'F*;F1', 'F*;F2', 
                         'F*;F3', 'F*;FS', 'F*;FX', 'F*;M*', 'F*;MA', 'F*;MB', 'F*;MC', 
                         'F*;MT', 'F*\\M*', 'F-1', 'F-1)', 'F-2', 'F-2)', 'F-3', 'F-3)', 
                         'F-4', 'F-4)', 'F-4PR', 'F-5', 'F-5)', 'F/GM', 'F/M', 'F0', 'F1', 
                         'F10', 'F1;F*', 'F1;F1', 'F1;F2', 'F1;F3', 'F1;FS', 'F1;MA', 'F1D', 
                         'F2', 'F2;F*', 'F2;F1', 'F2;F2', 'F2;F3', 'F2;FS', 'F2;MA', 'F2D', 
                         'F3', 'F3;F*', 'F3;F1', 'F3;F2', 'F3;F3', 'F3;FS', 'F3;MA', 'F3;MB', 
                         'F3D', 'F4', 'F4D', 'F5', 'F5D', 'F6', 'F6TH', 'F7', 'F8', 'F9', 
                         'FA', 'FAD', 'FB', 'FBC', 'FC', 'FCA', 'FCAP', 'FD', 'FDM', 'FE', 
                         'FEM', 'FF', 'FG', 'FH', 'FI', 'FL', 'FL1', 'FLOWE', 'FM', 'FN', 
                         'FNC', 'FNG', 'FO', 'FOG', 'FP', 'FQ', 'FS', 'FS;E', 'FS;E;', 
                         'FS;F*', 'FS;F1', 'FS;F2', 'FS;F3', 'FS;FS', 'FS;MA', 'FS;MB', 
                         'FSJ', 'FT', 'FU', 'FUPPE', 'FV', 'FW', 'FX', 'FX;F1', 'FX;FX', 
                         'FY-1', 'FY-3', 'FZ', 'LIFE', 'MA;FS', 'MB;F3', 'MB;FS', 'SF', 
                         'SJF', 'SPF', 'UF', 'MO', 'MT;F2', 'MT;FS', 'P', 'WF'];

 
    EXPORT SET_MISDEMEANOR := ['AM', 'BM', 'GM', 'GMT', 'GM2', 'GM3', 'M', '*M', 'CM', 'CTM1', 
                              'CTM2', 'CV', 'M 0', 'M*', 'M-1', 'M-1S)', 'M-2', 'M0', 'M1', 
                              'M2', 'M2N', 'M3', 'M3R', 'M4', 'M5', 'M6', 'M7', 'M8', 'M9', 
                              'MA', 'MAD', 'MAM', 'MAMUN', 'MAP', 'MB', 'MB)', 'MBD', 'MC', 
                              'MCA', 'MCLAS', 'MCT', 'MD', 'ME', 'MF', 'MG', 'MH', 'MI', 
                              'MIS', 'MK', 'ML', 'MM', 'MN', 'MO', 'MP', 'MQ', 'MR', 'MS', 
                              'MSE', 'MT', 'MU', 'MUM', 'MUMUN', 'MUNCL', 'MUNK', 'MV', 'MW', 
                              'MX', 'MY', 'MZ', 'P M', 'PM', 'PMT', 'PVM2', 'SPM', 'T', 'TM', 
                              'TVM1', 'TVM2'];

 
    EXPORT SET_TRAFFIC := ['T', 'C', 'CT', 'FFT', 'JTOT', 'MTV', 'T/MI', 'T2', 'T4', 'TA', 'TB', 
                          'TC', 'TH', 'TI', 'TL', 'TM', 'TO', 'TP', 'TR', 'TT', 'TU', 'TV', 'UC', 'UO', 'CVI'];

    
    EXPORT SET_INFRACTION := ['CI', 'CTI', 'I', 'I1', 'I2', 'IN', 'MO', 'MO1', 'MO2', 'MOR', 'MU', 'MU1', 
                             'MU2', 'MU3', 'OCO', 'OMU', 'ORD', 'OV', 'PVI', 'TVI', 'CO', 'COR', 'ICA'];
                             
                             
                             
    EXPORT CITY_COUNTY_STATE_FEDERAL := ['STATE TAX LIEN', 'STATE TAX WARRANT', 'FEDERAL TAX LIEN', 
                                          'COUNTY TAX LIEN', 'CITY TAX LIEN', 'ILLINOIS TAX LIEN', 
                                          'FEDERAL COURT NEW FILING', 'JUDGMENT OR STATE TAX LIEN', 
                                          'FEDERAL COURT JUDGMENT', 'FILED IN ERROR-ST TAX LIEN', 
                                          'FILED IN ERROR-COUNTY TAX LIEN', 'STATE TAX WARRANT RENEWED', 
                                          'FILED IN ERROR-ST TAX WARRANT', 'CITY TAX LIEN FILED IN ERROR', 
                                          'FILED IN ERROR-FED TAX LIEN', 'PROPERTY TAX LIEN', 
                                          'STATE TAX LIEN RENEWAL', 'CORRECTED FEDERAL TAX LIEN'];


END;