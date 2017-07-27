#workunit ('name', 'Build OUT::FBN_' + FBN.FBN_Build_Date);

// Convert BDID and DID to String Values

FBN.Layout_FBN_Out FormatOutput(FBN.Layout_FBN L) := TRANSFORM
SELF.did := MAP(L.did<>0 => INTFORMAT(L.did, 12, 1), '');
SELF.bdid := MAP(L.bdid<>0 => INTFORMAT(L.bdid, 12, 1), '');
SELF := L;
END;

FBN_Formatted := PROJECT(FBN.File_FBN, FormatOutput(LEFT));

OUTPUT(FBN_Formatted,,'OUT::FBN_' + FBN.FBN_Build_Date, OVERWRITE);