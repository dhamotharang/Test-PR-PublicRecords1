//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','LocationId_xLink.BWR_TestExternal - Test External Linking - Precision and Recall - SALT V3.7.0');
IMPORT LocationId_xLink,SALT37;
// This is the 'thor only' version (no roxie)
  SmallJob := FALSE;
  UpdateIDs := FALSE;
  Infile := LocationId_xLink.File_LocationId; // You can make this a different file - but must be in 'as header' format
  Mapping := 'UniqueID:rid';
  MyInfile := SALT37.FromFlat(InFile,LocationId_xLink.process_LocationID_layouts.InputLayout,Mapping);
  LocationId_xLink.MAC_Meow_LocationID_Batch(myinfile,UniqueId,/* MY_LocId */,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip5,MyOutFile,SmallJob,UpdateIDs,Stats);
  Rec := { BOOLEAN Present; BOOLEAN Equal; BOOLEAN Resolved };
  Rec note(Infile le,MyOutFile ri) := TRANSFORM
    SELF.Present := ri.Results[1].LocId <> 0;
    SELF.Resolved := ri.Resolved;
    SELF.Equal := le.LocId=ri.Results[1].LocId;
  END;
  J := JOIN(infile,myoutfile,LEFT.rid=RIGHT.Reference,note(LEFT,RIGHT),LEFT OUTER);
  TABLE(J,{ Recall := AVE(GROUP, IF (Present,100,0) ), AvailableTrueRecall := AVE( GROUP,IF (Present AND Equal, 100, 0 ) ), TrueRecall := AVE( GROUP,IF (Present AND Equal AND Resolved, 100, 0 ) ) });
  Errors := JOIN(infile,myoutfile,LEFT.rid=RIGHT.Reference AND LEFT.LocId<>RIGHT.Results[1].LocId);
  Errors;
  MyOutFile;
  Stats;
