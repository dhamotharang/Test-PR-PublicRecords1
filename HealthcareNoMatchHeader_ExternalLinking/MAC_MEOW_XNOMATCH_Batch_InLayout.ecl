 
EXPORT MAC_MEOW_XNOMATCH_Batch_InLayout(infile,OutFile,AsIndex = 'true',In_UpdateIDs = 'false',Stats = '',In_disableForce = 'false',DoClean = 'true') := MACRO
  IMPORT SALT311,HealthcareNoMatchHeader_ExternalLinking;
  #UNIQUENAME(ToProcess)
  #UNIQUENAME(TPRec)
  %TPRec% := RECORD(HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.InputLayout)
  END;
  #UNIQUENAME(infile_updateids)
  %infile_updateids% := IF(In_UpdateIDs, PROJECT(infile, %TPRec%), PROJECT(infile, TRANSFORM(%TPRec%, SELF.Entered_nomatch_id := (TYPEOF(SELF.Entered_nomatch_id))'', SELF := LEFT)));
  #UNIQUENAME(infile_clean)
  %infile_clean% := IF(DoClean, PROJECT(HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.CleanInput(%infile_updateids%), %TPRec%), %infile_updateids%);
  #UNIQUENAME(fats)
  #UNIQUENAME(dups)
  // In case multiple copies of the same indicative are in there - remove them
  SALT311.MAC_Dups_Note(%infile_clean%,%TPRec%,%fats%,%dups%,,HealthcareNoMatchHeader_ExternalLinking.Config.meow_dedup);
  %ToProcess% := %fats%(Entered_nomatch_id = 0);
  #UNIQUENAME(OutputNewIDs)
  #IF (#TEXT(Input_nomatch_id) <> '')
    #UNIQUENAME(ToUpdate)
    %ToUpdate% := %fats%(~(Entered_nomatch_id = 0));
    %OutputNewIDs% := HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.UpdateIDs(%ToUpdate%);
  #ELSE
    %OutputNewIDs% := DATASET([],HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputNOMATCH)
  #IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_FNAME)<>'')
    #UNIQUENAME(HoldNOMATCH)
    %HoldNOMATCH% := %ToProcess%;
    HealthcareNoMatchHeader_ExternalLinking.Key_HEADER_NOMATCH.MAC_ScoredFetch_Batch(%HoldNOMATCH%,UniqueId,DOB,FNAME,LNAME,CITY_NAME,ZIP,ST,GENDER,PRIM_NAME,PRIM_RANGE,MNAME,SSN,LEXID,SEC_RANGE,SUFFIX,%OutputNOMATCH%,AsIndex,In_disableForce)
  #ELSE
    %OutputNOMATCH% := DATASET([],HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(AllRes)
  %AllRes% := %OutputNOMATCH%+%OutputNewIDs%;
  #UNIQUENAME(All)
  %All% := HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.CombineAllScores(%AllRes%, In_disableForce);
  #UNIQUENAME(OutFile0)
  SALT311.MAC_Dups_Restore(%All%,%dups%,%OutFile0%);
  #UNIQUENAME(RestoreChildReference)
  TYPEOF(%OutFile0%) %RestoreChildReference%(%OutFile0% le) := TRANSFORM
    SELF.Results := PROJECT(le.Results, TRANSFORM(HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.LayoutScoredFetch,SELF.Reference := le.Reference, SELF := LEFT));
    SELF := le;
  END;
  OutFile := PROJECT(%OutFile0%,%RestoreChildReference%(LEFT));
  #IF (#TEXT(Stats)<>'')
    Stats := HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
