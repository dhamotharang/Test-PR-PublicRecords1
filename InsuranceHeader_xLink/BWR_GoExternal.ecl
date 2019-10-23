//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_xLink.BWR_GoExternal - External Linking Keybuild - SALT V3.7.0');
IMPORT InsuranceHeader_xLink,SALT37;
BOOLEAN incrementalkeyBuild := FALSE;
InsuranceHeader_xLink.Proc_GoExternal(incrementalkeyBuild);
 
//If you want/need to shrink your external keys a little then removing some extra credit fields can help
//  Shrinkage := InsuranceHeader_xLink.Key_InsuranceHeader_NAME().Shrinkage + InsuranceHeader_xLink.Key_InsuranceHeader_ADDRESS().Shrinkage + InsuranceHeader_xLink.Key_InsuranceHeader_SSN().Shrinkage + InsuranceHeader_xLink.Key_InsuranceHeader_SSN4().Shrinkage + InsuranceHeader_xLink.Key_InsuranceHeader_DOB().Shrinkage + InsuranceHeader_xLink.Key_InsuranceHeader_DOBF().Shrinkage + InsuranceHeader_xLink.Key_InsuranceHeader_ZIP_PR().Shrinkage + InsuranceHeader_xLink.Key_InsuranceHeader_SRC_RID().Shrinkage + InsuranceHeader_xLink.Key_InsuranceHeader_DLN().Shrinkage + InsuranceHeader_xLink.Key_InsuranceHeader_PH().Shrinkage + InsuranceHeader_xLink.Key_InsuranceHeader_LFZ().Shrinkage + InsuranceHeader_xLink.Key_InsuranceHeader_RELATIVE().Shrinkage;
//TOPN(Shrinkage,10000,-ShrinkGB);
