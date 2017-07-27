// Create UCC Filing Summary

// Count number of unique filing events per filing
Layout_UCC_Filing_Stat := RECORD
UCC.UCC_Updated_Filing_Fixed.file_state;
UCC.UCC_Updated_Filing_Fixed.orig_filing_num;
UCC.UCC_Updated_Filing_Fixed.filing_date;
UCC.UCC_Updated_Filing_Fixed.filing_type;
reccnt := COUNT(GROUP)
END;

UCC_Expanded_Filing_Filtered := UCC.UCC_Updated_Filing_Fixed(UCC.Check_Valid_State_Filing_Date(file_state, filing_date));
UCC_Expanded_Filing_Dist := DISTRIBUTE(UCC_Expanded_Filing_Filtered, HASH(file_state, orig_filing_num));
UCC_Expanded_Filing_Grpd := GROUP(UCC_Expanded_Filing_Dist, file_state, orig_filing_num, LOCAL);

UCC_Filing_Stat := TABLE(UCC_Expanded_Filing_Grpd, Layout_UCC_Filing_Stat, file_state, orig_filing_num, filing_date, filing_type, LOCAL);

Layout_UCC_Filing_Stat1 := RECORD
UCC_Filing_Stat.file_state;
UCC_Filing_Stat.orig_filing_num;
filing_count := COUNT(GROUP);
END;

UCC_Filing_Stat1 := TABLE(UCC_Filing_Stat, Layout_UCC_Filing_Stat1, file_state, orig_filing_num, LOCAL);

// Project to common format for rollup
UCC.Layout_UCC_Filing_Summary InitUCCFilingStat(Layout_UCC_Filing_Stat1 L) := TRANSFORM
SELF.filing_count := (STRING4)L.filing_count;
SELF := L;
END;

UCC_Filing_Stat_Common := PROJECT(UCC_Filing_Stat1, InitUCCFilingStat(LEFT));

// Count number of unique UCC documents per filing
Layout_UCC_Document_Stat := RECORD
UCC.UCC_Updated_Filing_Fixed.file_state;
UCC.UCC_Updated_Filing_Fixed.orig_filing_num;
UCC.UCC_Updated_Filing_Fixed.filing_date;
UCC.UCC_Updated_Filing_Fixed.filing_type;
UCC.UCC_Updated_Filing_Fixed.document_num;
reccnt := COUNT(GROUP)
END;

UCC_Document_Stat := TABLE(UCC_Expanded_Filing_Grpd, Layout_UCC_Document_Stat, file_state, orig_filing_num, filing_date, filing_type, document_num, LOCAL);

Layout_UCC_Document_Stat1 := RECORD
UCC_Document_Stat.file_state;
UCC_Document_Stat.orig_filing_num;
document_count := COUNT(GROUP);
END;

UCC_Document_Stat1 := TABLE(UCC_Document_Stat, Layout_UCC_Document_Stat1, file_state, orig_filing_num, LOCAL);

// Project to common format for rollup
UCC.Layout_UCC_Filing_Summary InitUCCDocumentStat(Layout_UCC_Document_Stat1 L) := TRANSFORM
SELF.document_count := (STRING4)L.document_count;
SELF := L;
END;

UCC_Document_Stat_Common := PROJECT(UCC_Document_Stat1, InitUCCDocumentStat(LEFT));

// Count number of current Debtor parties per filing
Layout_UCC_Party_Slim := RECORD
STRING2   file_state;
STRING18  orig_filing_num;
END;

Layout_UCC_Party_Slim SlimUCCParties(UCC.Layout_UCC_Initial_Party_Master L) := TRANSFORM
SELF := L;
END;

UCC_Current_Debtors_Init := PROJECT(UCC.UCC_Parties_Combined(party_type = 'D',current_flag = 'Y'), SlimUCCParties(LEFT));
UCC_Current_Debtors_Dist := DISTRIBUTE(UCC_Current_Debtors_Init, HASH(file_state, orig_filing_num));
UCC_Current_Debtors_Grpd := GROUP(UCC_Current_Debtors_Dist, file_state, orig_filing_num, LOCAL);


Layout_UCC_Debtor_Stat := RECORD
UCC_Current_Debtors_Init.file_state;
UCC_Current_Debtors_Init.orig_filing_num;
debtor_count := COUNT(GROUP);
END;

UCC_Debtor_Stat := TABLE(UCC_Current_Debtors_Grpd, Layout_UCC_Debtor_Stat, file_state, orig_filing_num, LOCAL);

// Project to common format for rollup
UCC.Layout_UCC_Filing_Summary InitUCCDebtorStat(Layout_UCC_Debtor_Stat L) := TRANSFORM
SELF.debtor_count := (STRING3)L.debtor_count;
SELF := L;
END;

UCC_Debtor_Stat_Common := PROJECT(UCC_Debtor_Stat, InitUCCDebtorStat(LEFT));

// Count number of current Secured and Assignee partes per filing
UCC_Current_Secured_Init := PROJECT(UCC.UCC_Parties_Combined(party_type <> 'D', current_flag = 'Y'), SlimUCCParties(LEFT));
UCC_Current_Secured_Dist := DISTRIBUTE(UCC_Current_Secured_Init, HASH(file_state, orig_filing_num));
UCC_Current_Secured_Grpd := GROUP(UCC_Current_Secured_Dist, file_state, orig_filing_num, LOCAL);

Layout_UCC_Secured_Stat := RECORD
UCC_Current_Secured_Init.file_state;
UCC_Current_Secured_Init.orig_filing_num;
secured_count := COUNT(GROUP);
END;

UCC_Secured_Stat := TABLE(UCC_Current_Secured_Grpd, Layout_UCC_Secured_Stat, file_state, orig_filing_num, LOCAL);

// Project to common format for rollup
UCC.Layout_UCC_Filing_Summary InitUCCSecuredStat(Layout_UCC_Secured_Stat L) := TRANSFORM
SELF.secured_count := (STRING3)L.secured_count;
SELF := L;
END;

UCC_Secured_Stat_Common := PROJECT(UCC_Secured_Stat, InitUCCSecuredStat(LEFT));

// Combine all stats for rollup
UCC_Stat_Common := UCC_Filing_Stat_Common +
                   UCC_Document_Stat_Common +
                   UCC_Debtor_Stat_Common +
                   UCC_Secured_Stat_Common;

// Rollup stats to produce UCC Filing Summary
UCC_Stat_Common_Dist := DISTRIBUTE(UCC_Stat_Common, HASH(file_state, orig_filing_num));
UCC_Stat_Common_Sort := SORT(UCC_Stat_Common_Dist, file_state, orig_filing_num, LOCAL);

UCC.Layout_UCC_Filing_Summary RollupStats(UCC.Layout_UCC_Filing_Summary L, UCC.Layout_UCC_Filing_Summary R) := TRANSFORM
SELF.filing_count := (STRING4)((INTEGER)L.filing_count + (INTEGER)R.filing_count);
SELF.document_count := (STRING4)((INTEGER)L.document_count + (INTEGER)R.document_count);
SELF.debtor_count := (STRING3)((INTEGER)L.debtor_count + (INTEGER)R.debtor_count);
SELF.secured_count := (STRING3)((INTEGER)L.secured_count + (INTEGER)R.secured_count);
SELF := L;
END;

UCC_Filing_Summary_Init := ROLLUP(UCC_Stat_Common_Sort,
                             LEFT.file_state = RIGHT.file_state AND
                               LEFT.orig_filing_num = RIGHT.orig_filing_num,
                             RollupStats(LEFT, RIGHT),
                             LOCAL);

COUNT(UCC_Filing_Summary_Init);

// Determine collateral code (most recent 0801 filing, or earliest filing with a collateral code if no 0801 exists)

// Most recent 0801 filing
UCC_Expanded_Filing_Sort_1 := SORT(UCC_Expanded_Filing_Dist(filing_type='0801'), file_state, orig_filing_num, IF(collateral_code <> '', 0, 1), -filing_date, LOCAL);
UCC_Expanded_Filing_Dedup_1 := DEDUP(UCC_Expanded_Filing_Sort_1, file_state, orig_filing_num, LOCAL);

// Earliest non 0801 filing with a collateral code
UCC_Expanded_Filing_Sort_2 := SORT(UCC_Expanded_Filing_Dist(filing_type<>'0801'), file_state, orig_filing_num, IF(collateral_code <> '', 0, 1), filing_date, LOCAL);
UCC_Expanded_Filing_Dedup_2 := DEDUP(UCC_Expanded_Filing_Sort_2, file_state, orig_filing_num, LOCAL);

// Combine and reduce
UCC_Expanded_Filing_Dedup_Combined := UCC_Expanded_Filing_Dedup_1 + UCC_Expanded_Filing_Dedup_2;
UCC_Expanded_Filing_Sort_3 := SORT(UCC_Expanded_Filing_Dedup_Combined, file_state, orig_filing_num, IF(filing_type = '0801', 0, 1), LOCAL);
UCC_Expanded_Filing_Dedup_3 := DEDUP(UCC_Expanded_Filing_Sort_3, file_state, orig_filing_num, LOCAL);

// Add current collateral code to filing summary
UCC.Layout_UCC_Filing_Summary AddCurrentCollateral(UCC.Layout_UCC_Filing_Summary L, UCC.Layout_UCC_Expanded_Filing R) := TRANSFORM
SELF.collateral_code := R.collateral_code;
SELF := L;
END;

UCC_Filing_Summary_Stats := JOIN(UCC_Filing_Summary_Init,
                           UCC_Expanded_Filing_Dedup_3,
                           LEFT.file_state = RIGHT.file_state AND
                             LEFT.orig_filing_num = RIGHT.orig_filing_num,
                           AddCurrentCollateral(LEFT, RIGHT),
                           LEFT OUTER,
                           LOCAL);

COUNT(UCC_Filing_Summary_Stats);

EXPORT UCC_Filing_Summary := UCC_Filing_Summary_Stats : PERSIST('TEMP::UCC_Filing_Summary');