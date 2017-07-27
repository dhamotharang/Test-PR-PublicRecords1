#workunit('name', 'CREATE UCC BASE FILES ' + ucc.UCC_Build_Date);

// Create Updated UCC Expanded Party
OUTPUT(UCC.UCC_Updated_Party,,'BASE::UCC_Expanded_Party_' + UCC.UCC_Build_Date, OVERWRITE);

// Create UCC Expanded Filing
OUTPUT(UCC.UCC_Updated_Filing,,'BASE::UCC_Expanded_Filing_' + UCC.UCC_Build_Date, OVERWRITE);

// Create UCC_Debtor_Master
OUTPUT(UCC.UCC_Parties_Combined(party_type='D'),,'BASE::UCC_Debtor_Master_' + UCC.UCC_Build_Date, OVERWRITE);

// Create UCC Secured Master
OUTPUT(UCC.UCC_Parties_Combined(party_type<>'D'),,'BASE::UCC_Secured_Master_' + UCC.UCC_Build_Date, OVERWRITE);

// Create UCC Filing Events Master
OUTPUT(UCC.UCC_Filing_Events,,'BASE::UCC_Filing_Events_' + UCC.UCC_Build_Date, OVERWRITE);

// Create UCC Filing Summary
OUTPUT(UCC.UCC_Filing_Summary,,'BASE::UCC_Filing_Summary_' + UCC.UCC_Build_Date, OVERWRITE);

// Create UCC Filing Places
// OUTPUT(UCC.UCC_Filing_Place,,'BASE::UCC_Filing_Place_' + UCC.UCC_Build_Date, OVERWRITE);
// This code is temporary until a new UCC Court Codes File is received from Experian
UCC_Filing_Place_Temp := DATASET('BASE::UCC_Filing_Place', UCC.Layout_UCC_Filing_place, THOR);
OUTPUT(UCC_Filing_Place_Temp,,'BASE::UCC_Filing_Place_' + UCC.UCC_Build_Date, OVERWRITE);