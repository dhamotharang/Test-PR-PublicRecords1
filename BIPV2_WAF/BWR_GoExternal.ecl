//This is the code to execute in a builder window
#workunit('name','BIPV2_WAF.BWR_GoExternal - External Linking Keybuild - SALT V2.9 Beta 3');
IMPORT BIPV2_WAF,SALT29;
BIPV2_WAF.Proc_GoExternal;
// If you wish to index all of the external files in one go - use the below AFTER the above
// BIPV2_WAF.Externals.buildall;
// The below gives a global view of the numbers of linked records for each of the external files
// BIPV2_WAF.Externals.EFRStats;
 
//If you want/need to shrink your external keys a little then removing some extra credit fields can help
  Shrinkage := BIPV2_WAF.Key_BizHead_L_CNPNAME.Shrinkage + BIPV2_WAF.Key_BizHead_L_CNPNAME_ST.Shrinkage + BIPV2_WAF.Key_BizHead_L_ADDRESS1.Shrinkage + BIPV2_WAF.Key_BizHead_L_ADDRESS2.Shrinkage + BIPV2_WAF.Key_BizHead_L_PHONE.Shrinkage + BIPV2_WAF.Key_BizHead_L_FEIN.Shrinkage + BIPV2_WAF.Key_BizHead_L_CONTACT.Shrinkage + BIPV2_WAF.Key_BizHead_L_URL.Shrinkage + BIPV2_WAF.Key_BizHead_L_EMAIL.Shrinkage + BIPV2_WAF.Key_BizHead_L_SOURCE.Shrinkage;
//TOPN(Shrinkage,10000,-ShrinkGB);
