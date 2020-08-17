//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_xLink.BWR_TestExternal - Test External Linking - Precision and Recall - SALT V3.11.10-PV1');
IMPORT InsuranceHeader_xLink,SALT311;
// This is the 'thor only' version (no roxie)
  SmallJob := FALSE;
  InUpdateIDs := FALSE;
  DisableForce := FALSE;
  DoClean := TRUE;
  Infile := InsuranceHeader_xLink.File_InsuranceHeader; // You can make this a different file - but must be in 'as header' format
  Mapping := 'UniqueID:RID,ZIP_cases:ZIP';
  MyInfile := SALT311.FromFlat(InFile,InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout,Mapping);
  InsuranceHeader_xLink.MAC_Meow_xIDL_Batch(myinfile,UniqueId,/* MY_DID */,SNAME,FNAME,MNAME,LNAME,DERIVED_GENDER,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,ST,ZIP_cases,SSN5,SSN4,DOB,PHONE,DL_STATE,DL_NBR,SRC,SOURCE_RID,DT_FIRST_SEEN,DT_LAST_SEEN,DT_EFFECTIVE_FIRST,DT_EFFECTIVE_LAST,MAINNAME,FULLNAME,ADDR1,LOCALE,ADDRESS,fname2,lname2,VIN,MyOutFile,SmallJob,InUpdateIDs,Stats,DisableForce,DoClean);
  Rec := { BOOLEAN Present; BOOLEAN Equal; BOOLEAN Resolved };
  Rec note(Infile le,MyOutFile ri) := TRANSFORM
    SELF.Present := ri.Results[1].DID <> 0;
    SELF.Resolved := ri.Resolved;
    SELF.Equal := le.DID=ri.Results[1].DID;
  END;
  J := JOIN(infile,myoutfile,LEFT.RID=RIGHT.Reference,note(LEFT,RIGHT),LEFT OUTER);
  TABLE(J,{ Recall := AVE(GROUP, IF (Present,100,0) ), AvailableTrueRecall := AVE( GROUP,IF (Present AND Equal, 100, 0 ) ), TrueRecall := AVE( GROUP,IF (Present AND Equal AND Resolved, 100, 0 ) ) });
  Errors := JOIN(infile,myoutfile,LEFT.RID=RIGHT.Reference AND LEFT.DID<>RIGHT.Results[1].DID);
  Errors;
  MyOutFile;
  Stats;
