//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BizLinkFull_HS.BWR_GoExternal - External Linking Keybuild - SALT V3.3.1');
IMPORT BizLinkFull_HS,SALT33;
BizLinkFull_HS.Proc_GoExternal;
 
//If you want/need to shrink your external keys a little then removing some extra credit fields can help
  Shrinkage := BizLinkFull_HS.Key_BizHead_L_CNPNAME_ZIP.Shrinkage + BizLinkFull_HS.Key_BizHead_L_CNPNAME_ST.Shrinkage + BizLinkFull_HS.Key_BizHead_L_CNPNAME.Shrinkage + BizLinkFull_HS.Key_BizHead_L_CNPNAME_FUZZY.Shrinkage + BizLinkFull_HS.Key_BizHead_L_ADDRESS1.Shrinkage + BizLinkFull_HS.Key_BizHead_L_ADDRESS2.Shrinkage + BizLinkFull_HS.Key_BizHead_L_ADDRESS3.Shrinkage + BizLinkFull_HS.Key_BizHead_L_PHONE.Shrinkage + BizLinkFull_HS.Key_BizHead_L_FEIN.Shrinkage + BizLinkFull_HS.Key_BizHead_L_URL.Shrinkage + BizLinkFull_HS.Key_BizHead_L_CONTACT.Shrinkage + BizLinkFull_HS.Key_BizHead_L_CONTACT_SSN.Shrinkage + BizLinkFull_HS.Key_BizHead_L_EMAIL.Shrinkage + BizLinkFull_HS.Key_BizHead_L_SIC.Shrinkage + BizLinkFull_HS.Key_BizHead_L_SOURCE.Shrinkage + BizLinkFull_HS.Key_BizHead_L_CONTACT_DID.Shrinkage;
//TOPN(Shrinkage,10000,-ShrinkGB);
