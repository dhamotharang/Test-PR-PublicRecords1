IMPORT SALT37;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_LocationId) h) := MODULE
 
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  prim_range_tokens := PROJECT(specificities(h).prim_range_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.prim_range; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  predir_tokens := PROJECT(specificities(h).predir_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.predir; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  prim_name_tokens := PROJECT(specificities(h).prim_name_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.prim_name; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  addr_suffix_tokens := PROJECT(specificities(h).addr_suffix_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.addr_suffix; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  postdir_tokens := PROJECT(specificities(h).postdir_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.postdir; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  unit_desig_tokens := PROJECT(specificities(h).unit_desig_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.unit_desig; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  sec_range_tokens := PROJECT(specificities(h).sec_range_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.sec_range; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  v_city_name_tokens := PROJECT(specificities(h).v_city_name_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.v_city_name; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
  st_tokens := PROJECT(specificities(h).st_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.st; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  zip5_tokens := PROJECT(specificities(h).zip5_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.zip5; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := prim_range_tokens + predir_tokens + prim_name_tokens + addr_suffix_tokens + postdir_tokens + unit_desig_tokens + sec_range_tokens + v_city_name_tokens + st_tokens + zip5_tokens;
SHARED all_tokens := SALT37.fn_process_multitokens(all_tokens0);
 
EXPORT TokenKeyName := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+_CFG.KeyInfix+'::LocId::Token::TokenKey';
 
EXPORT TokenKeyName_sf := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+KeySuperfile+'::LocId::Token::TokenKey';
 
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
 
EXPORT MultiTokenKeyName := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+_CFG.KeyInfix+'::LocId::Token::MultiTokenKey';
 
EXPORT MultiTokenKeyName_sf := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+KeySuperfile+'::LocId::Token::MultiTokenKey';
 
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT37.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
// Now compute the patterns of filled in field values for the various concept fields
SHARED s := specificities(h).specificities;
SHARED ih := specificities(h).input_file;
 
EXPORT Build := PARALLEL(BUILDINDEX(TokenKey, OVERWRITE),BUILDINDEX(MultiTokenKey, OVERWRITE));
 
SHARED TokenClassify_Raw(SALT37.StrType s,SET OF UNSIGNED2 Poss=[]) := PROJECT( TokenKey(TokenHash=HASH32(s),TokenValue = s,Poss=[] OR TokenType IN Poss),TRANSFORM(SALT37.Layout_Classify_Token,SELF := LEFT) );
SHARED MultiTokenClassify_Raw(SALT37.StrType s) := PROJECT( MultiTokenKey(TokenHash=HASH32(s),TokenValue = s),TRANSFORM(SALT37.Layout_Classify_Token,SELF := LEFT) );
 
EXPORT TokenClassify(SALT37.StrType s) := SORT(TokenClassify_Raw(s),spc);
 
EXPORT FieldClassify(SALT37.StrType s,SET OF UNSIGNED2 Poss=[]) := FUNCTION
  NWords := SALT37.WordCount(s);
  AsData := DATASET([{s}],{SALT37.StrType s1;});
  SALT37.Layout_Classify_Working_Hypothesis FindParts(AsData le,UNSIGNED4 Posit) := TRANSFORM
    SELF.Cpos := Posit;
    SELF.Possibles := TokenClassify_Raw(SALT37.GetNthWord(le.s1,Posit),Poss)(TokenCount = NWords,Pos = Posit);
  END;
  RETURN SALT37.fn_combine_working_hypothesis( NORMALIZE(AsData,NWords,FindParts(LEFT,COUNTER)) );
END;
// Provide classification information for entire parse stream - ASAP
EXPORT ParseClassify(DATASET(SALT37.Layout_Parse_Raw) p) := FUNCTION
  sp := SALT37.fn_split_parsed(p); // Processing module for this parse stream
  cl := JOIN(sp.Words,TokenKey,HASH32(LEFT.tstring)=RIGHT.TokenHash AND LEFT.tstring=RIGHT.TokenValue,TRANSFORM(SALT37.layout_classify_token,SELF := RIGHT));
  rl := sp.Combine(cl); // Multi-tokens will now be together
  rl0 := rl(TokenCount=1);
  rl1 := rl(TokenCount>1);
  rl2 := JOIN(rl1,MultiTokenKey,RIGHT.TokenHash=HASH32(LEFT.TokenValue) AND RIGHT.TokenValue=LEFT.TokenValue AND LEFT.TokenType = RIGHT.TokenType,TRANSFORM(sp.r,SELF.Verified := LEFT.TokenValue=RIGHT.TokenValue,SELF := LEFT),LEFT OUTER);
  RETURN sp.JoinBack(rl0+rl2);
END;
 
EXPORT StreamVerify(SALT37.StrType s,DATASET(SALT37.Layout_Classify_Hypothesis) Classified) := FUNCTION
  // MORE - could try to get clever and combine fetches for different types of same multi-token
  SALT37.Layout_Classify_Hypothesis Confirm(Classified le) := TRANSFORM
    SELF.Confirmed := EXISTS ( MultiTokenClassify_Raw(SALT37.GetRangeOfWords(s,le.StartPos,le.Startpos+le.Len-1))(TokenType=le.TokenType));
    SELF := le;
  END;
  R := Classified(len=1) + PROJECT(Classified(len>1),Confirm(LEFT))(Confirmed);
  R0 := SALT37.fn_classify_dedup_hypothesis(R,TRUE);
  RETURN SORT(R,SPC,-Len);
END;
 
EXPORT StreamClassify(SALT37.StrType s) := FUNCTION
  NWords := SALT37.WordCount(s);
  EmptyStart := dataset([],SALT37.Layout_Classify_Hypothesis);
  AH := LOOP(EmptyStart,NWords,SALT37.fn_next_working_hypothesis( ROWS(LEFT),TokenClassify_Raw(SALT37.GetNthWord(s,COUNTER)),COUNTER,Nwords) );
  DD := StreamVerify(s,AH);
  DH := SALT37.fn_classify_dedup_hypothesis(DD,TRUE);
  RETURN SORT(DH,SPC,-Len);
END;
 
EXPORT PrettyStreamClassify(SALT37.StrType s) := SALT37.fn_pretty_hypothesis(s,StreamClassify(s),Fields.FieldName);
END;
