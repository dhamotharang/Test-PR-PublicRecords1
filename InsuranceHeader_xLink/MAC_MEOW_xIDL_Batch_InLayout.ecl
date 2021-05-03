 
EXPORT MAC_MEOW_xIDL_Batch_InLayout(infile,OutFile,AsIndex = 'true',In_UpdateIDs = 'false',Stats = '',In_disableForce = 'false',DoClean = 'true') := MACRO
  IMPORT SALT311,InsuranceHeader_xLink;
  #UNIQUENAME(ToProcess)
  #UNIQUENAME(TPRec)
  %TPRec% := RECORD(InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout)
  END;
  #UNIQUENAME(infile_updateids)
  %infile_updateids% := IF(In_UpdateIDs, PROJECT(infile, %TPRec%), PROJECT(infile, TRANSFORM(%TPRec%, SELF.Entered_DID := (TYPEOF(SELF.Entered_DID))'', SELF := LEFT)));
  #UNIQUENAME(infile_clean)
  %infile_clean% := IF(DoClean, PROJECT(InsuranceHeader_xLink.Process_xIDL_Layouts().CleanInput(%infile_updateids%), %TPRec%), %infile_updateids%);
  #UNIQUENAME(fats)
  #UNIQUENAME(dups)
  // In case multiple copies of the same indicative are in there - remove them
  SALT311.MAC_Dups_Note(%infile_clean%,%TPRec%,%fats%,%dups%,,InsuranceHeader_xLink.Config.meow_dedup);
  %ToProcess% := %fats%(Entered_DID = 0);
  #UNIQUENAME(OutputNewIDs)
  #IF (#TEXT(Input_DID) <> '')
    #UNIQUENAME(ToUpdate)
    %ToUpdate% := %fats%(~(Entered_DID = 0));
    %OutputNewIDs% := InsuranceHeader_xLink.Process_xIDL_Layouts().UpdateIDs(%ToUpdate%);
  #ELSE
    %OutputNewIDs% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputNAME)
  #IF(#TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'')
    #UNIQUENAME(HoldNAME)
    %HoldNAME% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_NAME().MAC_ScoredFetch_Batch(%HoldNAME%,UniqueId,FNAME,LNAME,ST,DERIVED_GENDER,SNAME,MNAME,SSN5,SSN4,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,DOB,%OutputNAME%,AsIndex,In_disableForce)
  #ELSE
    %OutputNAME% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputADDRESS)
  #IF(#TEXT(Input_PRIM_RANGE)<>'' AND #TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_ZIP)<>'')
    #UNIQUENAME(HoldADDRESS)
    %HoldADDRESS% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_ADDRESS().MAC_ScoredFetch_Batch(%HoldADDRESS%,UniqueId,PRIM_RANGE,PRIM_NAME,ZIP_cases,SEC_RANGE,FNAME,MNAME,LNAME,CITY,ST,DERIVED_GENDER,SNAME,DOB,%OutputADDRESS%,AsIndex,In_disableForce)
  #ELSE
    %OutputADDRESS% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputSSN)
  #IF(#TEXT(Input_SSN5)<>'' AND #TEXT(Input_SSN4)<>'')
    #UNIQUENAME(HoldSSN)
    %HoldSSN% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_SSN().MAC_ScoredFetch_Batch(%HoldSSN%,UniqueId,SSN5,SSN4,FNAME,MNAME,LNAME,CITY,ST,DERIVED_GENDER,SNAME,DOB,%OutputSSN%,AsIndex,In_disableForce)
  #ELSE
    %OutputSSN% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputSSN4)
  #IF(#TEXT(Input_SSN4)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'')
    #UNIQUENAME(HoldSSN4)
    %HoldSSN4% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_SSN4().MAC_ScoredFetch_Batch(%HoldSSN4%,UniqueId,SSN4,FNAME,LNAME,DOB,SSN5,DERIVED_GENDER,SNAME,%OutputSSN4%,AsIndex,In_disableForce)
  #ELSE
    %OutputSSN4% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputDOB)
  #IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_LNAME)<>'')
    #UNIQUENAME(HoldDOB)
    %HoldDOB% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_DOB().MAC_ScoredFetch_Batch(%HoldDOB%,UniqueId,DOB,LNAME,FNAME,MNAME,ST,CITY,SSN5,SSN4,DERIVED_GENDER,DL_NBR,DL_STATE,SNAME,%OutputDOB%,AsIndex,In_disableForce)
  #ELSE
    %OutputDOB% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputDOBF)
  #IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_FNAME)<>'')
    #UNIQUENAME(HoldDOBF)
    %HoldDOBF% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_DOBF().MAC_ScoredFetch_Batch(%HoldDOBF%,UniqueId,DOB,FNAME,LNAME,MNAME,ST,CITY,SSN5,SSN4,DERIVED_GENDER,DL_NBR,DL_STATE,SNAME,%OutputDOBF%,AsIndex,In_disableForce)
  #ELSE
    %OutputDOBF% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputZIP_PR)
  #IF(#TEXT(Input_ZIP)<>'' AND #TEXT(Input_PRIM_RANGE)<>'')
    #UNIQUENAME(HoldZIP_PR)
    %HoldZIP_PR% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_ZIP_PR().MAC_ScoredFetch_Batch(%HoldZIP_PR%,UniqueId,ZIP_cases,PRIM_RANGE,FNAME,LNAME,PRIM_NAME,SEC_RANGE,CITY,ST,DERIVED_GENDER,SNAME,DOB,%OutputZIP_PR%,AsIndex,In_disableForce)
  #ELSE
    %OutputZIP_PR% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputSRC_RID)
  #IF(#TEXT(Input_SRC)<>'' AND #TEXT(Input_SOURCE_RID)<>'')
    #UNIQUENAME(HoldSRC_RID)
    %HoldSRC_RID% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_SRC_RID().MAC_ScoredFetch_Batch(%HoldSRC_RID%,UniqueId,SRC,SOURCE_RID,FNAME,DOB,CITY,DERIVED_GENDER,SNAME,ST,%OutputSRC_RID%,AsIndex,In_disableForce)
  #ELSE
    %OutputSRC_RID% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputDLN)
  #IF(#TEXT(Input_DL_NBR)<>'' AND #TEXT(Input_DL_STATE)<>'')
    #UNIQUENAME(HoldDLN)
    %HoldDLN% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_DLN().MAC_ScoredFetch_Batch(%HoldDLN%,UniqueId,DL_NBR,DL_STATE,FNAME,MNAME,LNAME,SSN5,SSN4,DERIVED_GENDER,SNAME,DOB,%OutputDLN%,AsIndex,In_disableForce)
  #ELSE
    %OutputDLN% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputPH)
  #IF(#TEXT(Input_PHONE)<>'')
    #UNIQUENAME(HoldPH)
    %HoldPH% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_PH().MAC_ScoredFetch_Batch(%HoldPH%,UniqueId,PHONE,FNAME,MNAME,LNAME,DOB,CITY,ST,SSN5,SSN4,%OutputPH%,AsIndex,In_disableForce)
  #ELSE
    %OutputPH% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputLFZ)
  #IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_ZIP)<>'')
    #UNIQUENAME(HoldLFZ)
    %HoldLFZ% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_LFZ().MAC_ScoredFetch_Batch(%HoldLFZ%,UniqueId,LNAME,FNAME,ZIP_cases,CITY,PRIM_RANGE,PRIM_NAME,SSN5,SSN4,MNAME,SEC_RANGE,SNAME,DOB,ST,%OutputLFZ%,AsIndex,In_disableForce)
  #ELSE
    %OutputLFZ% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputRELATIVE)
  #IF(#TEXT(Input_fname2)<>'' AND #TEXT(Input_lname2)<>'')
    #UNIQUENAME(HoldRELATIVE)
    %HoldRELATIVE% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_RELATIVE().MAC_ScoredFetch_Batch(%HoldRELATIVE%,UniqueId,fname2,lname2,FNAME,LNAME,%OutputRELATIVE%,AsIndex,In_disableForce)
  #ELSE
    %OutputRELATIVE% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputVIN)
  #IF(#TEXT(Input_VIN)<>'')
    #UNIQUENAME(HoldVIN)
    %HoldVIN% := %ToProcess%;
    InsuranceHeader_xLink.Key_InsuranceHeader_VIN().MAC_ScoredFetch_Batch(%HoldVIN%,UniqueId,VIN,FNAME,%OutputVIN%,AsIndex,In_disableForce)
  #ELSE
    %OutputVIN% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
  #END
  #UNIQUENAME(AllRes)
  %AllRes% := %OutputNAME%+%OutputADDRESS%+%OutputSSN%+%OutputSSN4%+%OutputDOB%+%OutputDOBF%+%OutputZIP_PR%+%OutputSRC_RID%+%OutputDLN%+%OutputPH%+%OutputLFZ%+%OutputRELATIVE%+%OutputVIN%+%OutputNewIDs%;
  #UNIQUENAME(All)
  %All% := InsuranceHeader_xLink.Process_xIDL_Layouts().CombineAllScores(%AllRes%, In_disableForce);
  #UNIQUENAME(OutFile0)
  SALT311.MAC_Dups_Restore(%All%,%dups%,%OutFile0%);
  #UNIQUENAME(RestoreChildReference)
  TYPEOF(%OutFile0%) %RestoreChildReference%(%OutFile0% le) := TRANSFORM
    SELF.Results := PROJECT(le.Results, TRANSFORM(InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch,SELF.Reference := le.Reference, SELF := LEFT));
    SELF := le;
  END;
  OutFile := PROJECT(%OutFile0%,%RestoreChildReference%(LEFT));
  #IF (#TEXT(Stats)<>'')
    Stats := InsuranceHeader_xLink.Process_xIDL_Layouts().ScoreSummary(OutFile);
  #END
ENDMACRO;
