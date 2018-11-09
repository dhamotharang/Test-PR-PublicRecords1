//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','LocationId_xLink.BWR_GoExternal - External Linking Keybuild - SALT V3.7.0');
IMPORT LocationId_xLink,SALT37;
LocationId_xLink.Proc_GoExternal;
 
//If you want/need to shrink your external keys a little then removing some extra credit fields can help
  Shrinkage := LocationId_xLink.Key_LocationId_STATECITY.Shrinkage + LocationId_xLink.Key_LocationId_ZIP.Shrinkage;
//TOPN(Shrinkage,10000,-ShrinkGB);
