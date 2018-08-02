EXPORT fn_RemoteLinking(DATASET(InsuranceHeader_RemoteLinking.Layout_HEADER)In_Data, UNSIGNED8 Input_Inquiry_Lexid=0, UNSIGNED8 Input_Results_Lexid=0) := FUNCTION
  IMPORT SALT37,InsuranceHeader_RemoteLinking;
  #CONSTANT('Superfile_Name','');
  Input_Candidates := InsuranceHeader_RemoteLinking.Match_Candidates(In_Data).Candidates;
  s := InsuranceHeader_RemoteLinking.Specificities(In_Data).Specificities[1];
  LinkScore_pre := JOIN(Input_Candidates,Input_Candidates,left.RID>right.RID,InsuranceHeader_RemoteLinking.Debug(In_Data,s).sample_match_join(LEFT,RIGHT,0),ALL);
  LinkScore := PROJECT(LinkScore_pre, TRANSFORM(InsuranceHeader_RemoteLinking.Layouts.ServiceOutputLayout, SELF.Best_Lexid := IF(LEFT.conf >= InsuranceHeader_RemoteLinking.Config.MatchThreshold, IF(Input_Results_Lexid<>0,Input_Results_Lexid,Input_Inquiry_Lexid), 0); SELF.Match := IF(LEFT.conf >= InsuranceHeader_RemoteLinking.Config.MatchThreshold, TRUE, FALSE);SELF.Inquiry_Lexid:= Input_Inquiry_Lexid; SELF.Results_Lexid:= Input_Results_Lexid; SELF := LEFT)); 
  RETURN LinkScore;
END;
