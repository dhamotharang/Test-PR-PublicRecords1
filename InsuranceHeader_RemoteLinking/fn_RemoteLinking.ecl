

EXPORT fn_RemoteLinking(DATASET(InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch)In_Data) := FUNCTION
  IMPORT SALT37,InsuranceHeader_RemoteLinking,InsuranceHeader_Postprocess;
  #CONSTANT('Superfile_Name','');
  
  In_Data_Norm := NORMALIZE(In_Data,2,Layouts.NormEm(LEFT,COUNTER));
  
  Input_Candidates := InsuranceHeader_RemoteLinking.Match_Candidates(In_Data_Norm).Candidates;

  s := InsuranceHeader_RemoteLinking.Specificities(In_Data_Norm).Specificities[1];
  LinkScore_pre := JOIN(Input_Candidates,Input_Candidates,LEFT.RemID = RIGHT.RemID AND LEFT.RemFlag = TRUE AND RIGHT.RemFlag = FALSE,InsuranceHeader_RemoteLinking.Debug(In_Data_Norm,s).sample_match_join(LEFT,RIGHT,0),ALL);

  //Best Lexid Logic
  seg_key := InsuranceHeader_Postprocess.segmentation_keys.key_did_ind;
  
  rec := RECORD 
    RECORDOF(LinkScore_pre);
    STRING8 Inquiry_Seg;
    STRING8 Results_Seg;
  END;
  
  //Get Segmentation Levels
  out_seg_Inq := JOIN(LinkScore_pre,seg_key, KEYED(LEFT.did1 = RIGHT.did),TRANSFORM(REC, SELF.Inquiry_Seg := IF(RIGHT.ind IN ['CORE','DEAD'], RIGHT.ind,'OTHER'), SELF := LEFT, SELF:=[];),LEFT OUTER);
  out_seg := JOIN(out_seg_Inq,seg_key, KEYED(LEFT.did2 = RIGHT.did),TRANSFORM(REC, SELF.Results_Seg := IF(RIGHT.ind IN ['CORE','DEAD'], RIGHT.ind,'OTHER'), SELF := LEFT),LEFT OUTER);
  
  // Match Logic
  LinkScore := PROJECT(out_seg, TRANSFORM(InsuranceHeader_RemoteLinking.Layouts.ServiceOutputLayout_Batch, 
                    SELF.Best_Lexid := IF(LEFT.conf >= InsuranceHeader_RemoteLinking.Config.MatchThreshold, 
                      MAP(LEFT.Inquiry_Seg = LEFT.Results_Seg  => LEFT.did1,
                        LEFT.Inquiry_Seg = 'CORE' => LEFT.did1,
                        LEFT.Results_Seg = 'DEAD' => LEFT.did1,
                        LEFT.did2),0);
                    SELF.Match := IF(LEFT.conf >= InsuranceHeader_RemoteLinking.Config.MatchThreshold, TRUE, FALSE);SELF.Inquiry_Lexid:= LEFT.did1; SELF.Results_Lexid:= LEFT.did2; SELF := LEFT)); 
  RETURN LinkScore;
END;

