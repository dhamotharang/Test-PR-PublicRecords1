//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BizLinkFull.BWR_GoExternal - External Linking Keybuild - SALT V4.4.4');
IMPORT BizLinkFull,SALT44;
BizLinkFull.Proc_GoExternal;

// If you wish to index all of the external files in one go - use the below AFTER the above
// BizLinkFull.Externals.buildall;
// The below gives a global view of the numbers of linked records for each of the external files
// BizLinkFull.Externals.EFRStats;

//If you want/need to shrink your external keys a little then removing some extra credit fields can help
  Shrinkage := BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.Shrinkage + BizLinkFull.Key_BizHead_L_CNPNAME_ST.Shrinkage + BizLinkFull.Key_BizHead_L_CNPNAME.Shrinkage + BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.Shrinkage + BizLinkFull.Key_BizHead_L_ADDRESS1.Shrinkage + BizLinkFull.Key_BizHead_L_ADDRESS2.Shrinkage + BizLinkFull.Key_BizHead_L_ADDRESS3.Shrinkage + BizLinkFull.Key_BizHead_L_PHONE.Shrinkage + BizLinkFull.Key_BizHead_L_FEIN.Shrinkage + BizLinkFull.Key_BizHead_L_URL.Shrinkage + BizLinkFull.Key_BizHead_L_CONTACT_ZIP.Shrinkage + BizLinkFull.Key_BizHead_L_CONTACT_ST.Shrinkage + BizLinkFull.Key_BizHead_L_CONTACT.Shrinkage + BizLinkFull.Key_BizHead_L_CONTACT_SSN.Shrinkage + BizLinkFull.Key_BizHead_L_EMAIL.Shrinkage + BizLinkFull.Key_BizHead_L_SIC.Shrinkage + BizLinkFull.Key_BizHead_L_SOURCE.Shrinkage + BizLinkFull.Key_BizHead_L_CONTACT_DID.Shrinkage;
//TOPN(Shrinkage,10000,-ShrinkGB);
