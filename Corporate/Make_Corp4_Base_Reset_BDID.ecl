IMPORT ut, Business_Header, Business_Header_SS, did_add;

#workunit('name', 'Corporate Base Reset BDID ' + corporate.Corp4_Reset_Date);


//************************************************************
// BDID the Corporate Records
//************************************************************

Corp4_Base := Corporate.File_Corp4_Base;

Corporate.MAC_BDID_Corp(Corp4_Base, Corp4_Base_BDID)

Corp4_Base_BDID_Out := Corp4_Base_BDID;

OUTPUT(Corp4_Base_BDID_Out,,'BASE::Corp4_' + Corporate.Corp4_Reset_Date, OVERWRITE);