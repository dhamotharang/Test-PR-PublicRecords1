#workunit('name', 'CREATE UCC OUTPUT FILES ' + ucc.UCC_Build_Date);

// Make output UCC Debtor Master, UCC Secured Master, UCC Events
// -- put this layout in an attribute so I can make output file attributes
// -- for the keybuild code to reference
//Layout_UCC_Master_Out := RECORD
//STRING12 bdid;
//UCC.Layout_UCC_Expanded_Party;
//STRING1 event_flag;
//STRING1 current_flag;
//END;

ucc.Layout_UCC_Master_Out FormatUCCMasterOutput(UCC.Layout_UCC_Initial_Party_Master L) := TRANSFORM
SELF.bdid := IF(L.bdid <> 0, (STRING12)INTFORMAT(L.bdid, 12, 1), '');
SELF := L;
END;

// Project UCC Debtor Master to Output Format
UCC_Debtor_Master_Out := PROJECT(UCC.File_UCC_Debtor_Master, FormatUCCMasterOutput(LEFT));

// Project UCC Secured Master to Output Format
UCC_Secured_Master_Out := PROJECT(UCC.File_UCC_Secured_Master, FormatUCCMasterOutput(LEFT));

OUTPUT(UCC_Debtor_Master_Out,,'OUT::UCC_Debtor_Master_' + UCC.UCC_Build_Date, OVERWRITE);
OUTPUT(UCC_Secured_Master_Out,,'OUT::UCC_Secured_Master_' + UCC.UCC_Build_Date, OVERWRITE);

// Output the UCC Filing Events File
OUTPUT(UCC.File_UCC_Filing_Events,,'OUT::UCC_Filing_Events_' + UCC.UCC_Build_Date, OVERWRITE);

// Output the UCC Filing Summary File
OUTPUT(UCC.File_UCC_Filing_Summary,,'OUT::UCC_Filing_Summary_' + UCC.UCC_Build_Date, OVERWRITE);

// Output the UCC Filing Place File
OUTPUT(UCC.File_UCC_Filing_Place,,'OUT::UCC_Filing_Place_' + UCC.UCC_Build_Date, OVERWRITE);