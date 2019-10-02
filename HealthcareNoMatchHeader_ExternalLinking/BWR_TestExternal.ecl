//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthcareNoMatchHeader_ExternalLinking.BWR_TestExternal - Test External Linking - Precision and Recall - SALT V3.11.7');
IMPORT HealthcareNoMatchHeader_ExternalLinking,SALT311;
// This is the 'thor only' version (no roxie)
  SmallJob := FALSE;
  InUpdateIDs := FALSE;
  DisableForce := FALSE;
  DoClean := TRUE;
  Infile := HealthcareNoMatchHeader_ExternalLinking.File_HEADER; // You can make this a different file - but must be in 'as header' format
  Mapping := 'UniqueID:RID';
  MyInfile := SALT311.FromFlat(InFile,HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.InputLayout,Mapping);
  HealthcareNoMatchHeader_ExternalLinking.MAC_Meow_XNOMATCH_Batch(myinfile,UniqueId,/* MY_nomatch_id */,SRC,SSN,DOB,LEXID,SUFFIX,FNAME,MNAME,LNAME,GENDER,PRIM_NAME,PRIM_RANGE,SEC_RANGE,CITY_NAME,ST,ZIP,DT_FIRST_SEEN,DT_LAST_SEEN,MAINNAME,ADDR1,LOCALE,ADDRESS,FULLNAME,MyOutFile,SmallJob,InUpdateIDs,Stats,DisableForce,DoClean);
  Rec := { BOOLEAN Present; BOOLEAN Equal; BOOLEAN Resolved };
  Rec note(Infile le,MyOutFile ri) := TRANSFORM
    SELF.Present := ri.Results[1].nomatch_id <> 0;
    SELF.Resolved := ri.Resolved;
    SELF.Equal := le.nomatch_id=ri.Results[1].nomatch_id;
  END;
  J := JOIN(infile,myoutfile,LEFT.RID=RIGHT.Reference,note(LEFT,RIGHT),LEFT OUTER);
  TABLE(J,{ Recall := AVE(GROUP, IF (Present,100,0) ), AvailableTrueRecall := AVE( GROUP,IF (Present AND Equal, 100, 0 ) ), TrueRecall := AVE( GROUP,IF (Present AND Equal AND Resolved, 100, 0 ) ) });
  Errors := JOIN(infile,myoutfile,LEFT.RID=RIGHT.Reference AND LEFT.nomatch_id<>RIGHT.Results[1].nomatch_id);
  Errors;
  MyOutFile;
  Stats;
