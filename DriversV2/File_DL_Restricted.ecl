// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

IMPORT DriversV2;

EXPORT File_DL_Restricted := DATASET(DriversV2.Constants.Cluster + 'base::DL2::RESTRICTED_drvlic_AID', DriversV2.Layout_Base_withAID, THOR);