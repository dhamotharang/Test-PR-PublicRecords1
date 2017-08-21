//Hygiene
import ut,SALT;
export hygiene(dataset(Layout_BH_BDL) h) := MODULE

//A simple summary record
export Summary(string20 txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_GROUP_ID_pcnt := ave(group,if(h.GROUP_ID = (typeof(h.GROUP_ID))'',0,100));
    maxlength_GROUP_ID := max(group,length(trim((string)h.GROUP_ID)));
    avelength_GROUP_ID := ave(group,length(trim((string)h.GROUP_ID)));
    populated_COMPANY_NAME_pcnt := ave(group,if(h.COMPANY_NAME = (typeof(h.COMPANY_NAME))'',0,100));
    maxlength_COMPANY_NAME := max(group,length(trim((string)h.COMPANY_NAME)));
    avelength_COMPANY_NAME := ave(group,length(trim((string)h.COMPANY_NAME)));
  END;
  RETURN table(h,SummaryLayout);
END;


SrcCntRec := record
  h.SOURCE;  // Source Group Identifier
  unsigned SourceGroupCount := count(group);
end;
export SourceCounts := table(h,SrcCntRec,SOURCE,few);

// The character counts
  SALT.mac_character_counts.mac(h,GROUP_ID,'GROUP_ID',GROUP_ID_profile);
  SALT.mac_character_counts.mac(h,COMPANY_NAME,'COMPANY_NAME',COMPANY_NAME_profile);
export All_Profiles :=  GROUP_ID_profile + COMPANY_NAME_profile;


ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
  typeof(h.SOURCE) SOURCE; // Track errors by source
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_GROUP_ID((string)le.GROUP_ID),
    Fields.InValid_COMPANY_NAME((string)le.COMPANY_NAME),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  self.SOURCE := le.SOURCE;
end;
Errors := normalize(h,2,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
  Errors.SOURCE;
end;
TotalErrors := table(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,SOURCE);
PrettyErrorTotals := record
  TotalErrors.SOURCE;
  FieldName := CHOOSE(TotalErrors.FieldNum,'GROUP_ID','COMPANY_NAME');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_GROUP_ID(TotalErrors.ErrorNum),Fields.InValidMessage_COMPANY_NAME(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := table(TotalErrors,PrettyErrorTotals);
export ValidityErrors := join(ValErr,SourceCounts,left.SOURCE=right.SOURCE,lookup); // Add source group counts for STRATA compliance
//We have BDL specified - so we can compute statistics on the cluster counts
export ClusterCounts := function
  t := distribute(table(h,{BDL}),hash(BDL));
  r0 := record
    t.BDL;
    unsigned6 InCluster := count(group);
  end;
  tots := table(t,r0,BDL,local);
  r1 := record
    tots.InCluster;
    unsigned6 NumberOfClusters := count(group);
  end;
  return sort(table(tots,r1,InCluster,few),InCluster);
end;
end;