// View the new DIDs added plus a few of the other high DID records in Alpha MHDR

IMPORT PRTE2_X_DataCleanse, doxie, RoxieKeyBuild, address, ut, NID;

MRGD := PRTE2_X_Ins_DataCleanse.Files_Alpha.Merged_Headers_SF_DS(DID > 888809050070);
OUTPUT(SORT(MRGD,did));

