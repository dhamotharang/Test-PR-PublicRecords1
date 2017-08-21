//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Bair_ExternalLinkKeys_V2.BWR_GoExternal - External Linking Keybuild - SALT V3.7.0');
IMPORT Bair_ExternalLinkKeys_V2,SALT37;
Bair_ExternalLinkKeys_V2.Proc_GoExternal;
 
//If you want/need to shrink your external keys a little then removing some extra credit fields can help
  Shrinkage := Bair_ExternalLinkKeys_V2.Key_Classify_PS_NAME.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_ADDRESS.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_DOB.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_ZIP_PR.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_DLN.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_PH.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_LFZ.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_VIN.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_LEXID.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_SSN.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_LATLONG.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_PLATE.Shrinkage + Bair_ExternalLinkKeys_V2.Key_Classify_PS_COMPANY.Shrinkage;
//TOPN(Shrinkage,10000,-ShrinkGB);
