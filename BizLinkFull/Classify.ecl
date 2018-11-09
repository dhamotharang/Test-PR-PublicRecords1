IMPORT SALT37;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_BizHead) h) := MODULE
 
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  parent_proxid_tokens := PROJECT(specificities(h).parent_proxid_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.parent_proxid; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  sele_proxid_tokens := PROJECT(specificities(h).sele_proxid_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.sele_proxid; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  org_proxid_tokens := PROJECT(specificities(h).org_proxid_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.org_proxid; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  ultimate_proxid_tokens := PROJECT(specificities(h).ultimate_proxid_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.ultimate_proxid; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  source_tokens := PROJECT(specificities(h).source_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.source; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  source_record_id_tokens := PROJECT(specificities(h).source_record_id_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.source_record_id; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
  company_name_tokens := PROJECT(specificities(h).company_name_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.company_name; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
  company_name_prefix_tokens := PROJECT(specificities(h).company_name_prefix_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.company_name_prefix; SELF.TokenType := 11; SELF.Spc := LEFT.field_Specificity ));
  cnp_name_tokens := PROJECT(specificities(h).cnp_name_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.cnp_name; SELF.TokenType := 12; SELF.Spc := LEFT.field_Specificity ));
  cnp_number_tokens := PROJECT(specificities(h).cnp_number_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.cnp_number; SELF.TokenType := 13; SELF.Spc := LEFT.field_Specificity ));
  cnp_btype_tokens := PROJECT(specificities(h).cnp_btype_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.cnp_btype; SELF.TokenType := 14; SELF.Spc := LEFT.field_Specificity ));
  cnp_lowv_tokens := PROJECT(specificities(h).cnp_lowv_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.cnp_lowv; SELF.TokenType := 15; SELF.Spc := LEFT.field_Specificity ));
  company_phone_3_tokens := PROJECT(specificities(h).company_phone_3_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.company_phone_3; SELF.TokenType := 17; SELF.Spc := LEFT.field_Specificity ));
  company_phone_3_ex_tokens := PROJECT(specificities(h).company_phone_3_ex_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.company_phone_3_ex; SELF.TokenType := 18; SELF.Spc := LEFT.field_Specificity ));
  company_phone_7_tokens := PROJECT(specificities(h).company_phone_7_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.company_phone_7; SELF.TokenType := 19; SELF.Spc := LEFT.field_Specificity ));
  company_fein_tokens := PROJECT(specificities(h).company_fein_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.company_fein; SELF.TokenType := 20; SELF.Spc := LEFT.field_Specificity ));
  company_sic_code1_tokens := PROJECT(specificities(h).company_sic_code1_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.company_sic_code1; SELF.TokenType := 21; SELF.Spc := LEFT.field_Specificity ));
  prim_range_tokens := PROJECT(specificities(h).prim_range_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.prim_range; SELF.TokenType := 23; SELF.Spc := LEFT.field_Specificity ));
  prim_name_tokens := PROJECT(specificities(h).prim_name_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.prim_name; SELF.TokenType := 24; SELF.Spc := LEFT.field_Specificity ));
  sec_range_tokens := PROJECT(specificities(h).sec_range_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.sec_range; SELF.TokenType := 25; SELF.Spc := LEFT.field_Specificity ));
  city_tokens := PROJECT(specificities(h).city_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.city; SELF.TokenType := 26; SELF.Spc := LEFT.field_Specificity ));
  city_clean_tokens := PROJECT(specificities(h).city_clean_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.city_clean; SELF.TokenType := 27; SELF.Spc := LEFT.field_Specificity ));
  st_tokens := PROJECT(specificities(h).st_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.st; SELF.TokenType := 28; SELF.Spc := LEFT.field_Specificity ));
  zip_tokens := PROJECT(specificities(h).zip_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.zip; SELF.TokenType := 29; SELF.Spc := LEFT.field_Specificity ));
  company_url_tokens := PROJECT(specificities(h).company_url_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.company_url; SELF.TokenType := 30; SELF.Spc := LEFT.field_Specificity ));
  isContact_tokens := PROJECT(specificities(h).isContact_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.isContact; SELF.TokenType := 31; SELF.Spc := LEFT.field_Specificity ));
  contact_did_tokens := PROJECT(specificities(h).contact_did_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.contact_did; SELF.TokenType := 32; SELF.Spc := LEFT.field_Specificity ));
  title_tokens := PROJECT(specificities(h).title_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.title; SELF.TokenType := 33; SELF.Spc := LEFT.field_Specificity ));
  fname_tokens := PROJECT(specificities(h).fname_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.fname; SELF.TokenType := 34; SELF.Spc := LEFT.field_Specificity ));
  fname_preferred_tokens := PROJECT(specificities(h).fname_preferred_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.fname_preferred; SELF.TokenType := 35; SELF.Spc := LEFT.field_Specificity ));
  mname_tokens := PROJECT(specificities(h).mname_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.mname; SELF.TokenType := 36; SELF.Spc := LEFT.field_Specificity ));
  lname_tokens := PROJECT(specificities(h).lname_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.lname; SELF.TokenType := 37; SELF.Spc := LEFT.field_Specificity ));
  name_suffix_tokens := PROJECT(specificities(h).name_suffix_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.name_suffix; SELF.TokenType := 38; SELF.Spc := LEFT.field_Specificity ));
  contact_ssn_tokens := PROJECT(specificities(h).contact_ssn_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.contact_ssn; SELF.TokenType := 39; SELF.Spc := LEFT.field_Specificity ));
  contact_email_tokens := PROJECT(specificities(h).contact_email_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.contact_email; SELF.TokenType := 40; SELF.Spc := LEFT.field_Specificity ));
  sele_flag_tokens := PROJECT(specificities(h).sele_flag_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.sele_flag; SELF.TokenType := 41; SELF.Spc := LEFT.field_Specificity ));
  org_flag_tokens := PROJECT(specificities(h).org_flag_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.org_flag; SELF.TokenType := 42; SELF.Spc := LEFT.field_Specificity ));
  ult_flag_tokens := PROJECT(specificities(h).ult_flag_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.ult_flag; SELF.TokenType := 43; SELF.Spc := LEFT.field_Specificity ));
  fallback_value_tokens := PROJECT(specificities(h).fallback_value_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.fallback_value; SELF.TokenType := 44; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := parent_proxid_tokens + sele_proxid_tokens + org_proxid_tokens + ultimate_proxid_tokens + source_tokens + source_record_id_tokens + company_name_tokens + company_name_prefix_tokens + cnp_name_tokens + cnp_number_tokens + cnp_btype_tokens + cnp_lowv_tokens + company_phone_3_tokens + company_phone_3_ex_tokens + company_phone_7_tokens + company_fein_tokens + company_sic_code1_tokens + prim_range_tokens + prim_name_tokens + sec_range_tokens + city_tokens + city_clean_tokens + st_tokens + zip_tokens + company_url_tokens + isContact_tokens + contact_did_tokens + title_tokens + fname_tokens + fname_preferred_tokens + mname_tokens + lname_tokens + name_suffix_tokens + contact_ssn_tokens + contact_email_tokens + sele_flag_tokens + org_flag_tokens + ult_flag_tokens + fallback_value_tokens;
SHARED all_tokens := SALT37.fn_process_multitokens(all_tokens0);
 
EXPORT TokenKeyName := '~'+'key::BizLinkFull::proxid::Token::TokenKey';
 
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
 
EXPORT MultiTokenKeyName := '~'+'key::BizLinkFull::proxid::Token::MultiTokenKey';
 
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT37.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
  CONTACTNAME_tokens := PROJECT(specificities(h).CONTACTNAME_values_persisted,TRANSFORM(SALT37.Layout_Classify_Concept,SELF.ConceptHash := LEFT.CONTACTNAME; SELF.TokenType := 45; SELF.Spc := LEFT.field_Specificity ));
  STREETADDRESS_tokens := PROJECT(specificities(h).STREETADDRESS_values_persisted,TRANSFORM(SALT37.Layout_Classify_Concept,SELF.ConceptHash := LEFT.STREETADDRESS; SELF.TokenType := 46; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens1 := CONTACTNAME_tokens + STREETADDRESS_tokens;
 
EXPORT ConceptKeyName := '~'+'key::BizLinkFull::proxid::Token::ConceptKey';
 
EXPORT ConceptKey := INDEX(all_tokens1,{ConceptHash,TokenType},{all_tokens1},ConceptKeyName);
// Now compute the patterns of filled in field values for the various concept fields
SHARED s := specificities(h).specificities;
SHARED ih := specificities(h).input_file;
SHARED Layout_ConceptTemplate := RECORD
    UNSIGNED2 TokenType;
    UNSIGNED2 FieldNumber1 := 0; // The field number occupying position 1 in this template
    UNSIGNED2 FieldNumber2 := 0; // The field number occupying position 2 in this template
    UNSIGNED2 FieldNumber3 := 0; // The field number occupying position 3 in this template
    REAL Field_Specificity;
    UNSIGNED Cnt;
  END;
  CONTACTNAME_filled_rec := RECORD
    boolean fname_filled :=(SALT37.StrType)ih.fname != '';
    boolean mname_filled :=(SALT37.StrType)ih.mname != '';
    boolean lname_filled :=(SALT37.StrType)ih.lname != '';
  END;
  t := table(ih,CONTACTNAME_filled_rec);
  CONTACTNAME_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 45;
    t.fname_filled;
    t.mname_filled;
    t.lname_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,CONTACTNAME_filled_rec_totals,fname_filled,mname_filled,lname_filled,few);
  SALT37.MAC_Field_Specificities(t_tot,o_tot);
shared CONTACTNAME_combinations := o_tot;
  Layout_ConceptTemplate Into(CONTACTNAME_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.fname_filled => 34, le.mname_filled => 36, le.lname_filled => 37,0);
    SELF.FieldNumber2 := MAP ( le.mname_filled AND SELF.FieldNumber1 != 36 => 36, le.lname_filled AND SELF.FieldNumber1 != 37 => 37,0);
    SELF.FieldNumber3 := MAP ( le.lname_filled AND SELF.FieldNumber1 != 37 AND SELF.FieldNumber2 != 37 => 37,0);
    SELF := le;
  END;
shared CONTACTNAME_templates := project(CONTACTNAME_combinations,Into(LEFT));
  STREETADDRESS_filled_rec := RECORD
    boolean prim_range_filled :=(SALT37.StrType)ih.prim_range != '';
    boolean prim_name_filled :=(SALT37.StrType)ih.prim_name != '';
    boolean sec_range_filled :=(SALT37.StrType)ih.sec_range != '';
  END;
  t := table(ih,STREETADDRESS_filled_rec);
  STREETADDRESS_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 46;
    t.prim_range_filled;
    t.prim_name_filled;
    t.sec_range_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,STREETADDRESS_filled_rec_totals,prim_range_filled,prim_name_filled,sec_range_filled,few);
  SALT37.MAC_Field_Specificities(t_tot,o_tot);
shared STREETADDRESS_combinations := o_tot;
  Layout_ConceptTemplate Into(STREETADDRESS_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.prim_range_filled => 23, le.prim_name_filled => 24, le.sec_range_filled => 25,0);
    SELF.FieldNumber2 := MAP ( le.prim_name_filled AND SELF.FieldNumber1 != 24 => 24, le.sec_range_filled AND SELF.FieldNumber1 != 25 => 25,0);
    SELF.FieldNumber3 := MAP ( le.sec_range_filled AND SELF.FieldNumber1 != 25 AND SELF.FieldNumber2 != 25 => 25,0);
    SELF := le;
  END;
shared STREETADDRESS_templates := project(STREETADDRESS_combinations,Into(LEFT));
SHARED all_templates := CONTACTNAME_templates + STREETADDRESS_templates;
 
EXPORT ConceptTemplatesKey := '~'+'key::BizLinkFull::proxid::Token::ConceptTemplatesKey';
 
EXPORT ConceptTemplateKey := INDEX(all_templates,{FieldNumber1,TokenType},{all_templates},ConceptTemplatesKey);
 
EXPORT Build := PARALLEL(BUILDINDEX(TokenKey, OVERWRITE),BUILDINDEX(MultiTokenKey, OVERWRITE),BUILDINDEX(ConceptKey, OVERWRITE),BUILDINDEX(ConceptTemplateKey, OVERWRITE));
 
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
 
EXPORT StreamAnnotateConcepts(SALT37.StrType s,DATASET(SALT37.Layout_Classify_Hypothesis) Classified) := FUNCTION
// Now we need to look for concept-templates in the fields
  Layout_Template_Hypothesis := RECORD(SALT37.Layout_Classify_Hypothesis)
    UNSIGNED CPos; // Could be > StartPos+fieldno because of multi-token chars
    UNSIGNED2 FieldNumber1;
    UNSIGNED2 FieldNumber2;
    UNSIGNED2 FieldNumber3;
  SALT37.StrType Txt := '';
  END;
  Layout_Template_Hypothesis NotePossibles(Classified le,ConceptTemplateKey ri) := TRANSFORM
    SELF.Len := IF(ri.FieldNumber1=0,0,1)+IF(ri.FieldNumber2=0,0,1)+IF(ri.FieldNumber3=0,0,1);
    SELF.Spc := le.spc+ri.Field_Specificity;
    SELF.Confirmed := ri.FieldNumber2 = 0;
    SELF.CPos := le.StartPos+le.Len;
    SELF.Txt := SALT37.GetRangeOfWords(s,le.StartPos,le.StartPos+le.Len-1);
    SELF := ri;
    SELF := le;
  END;
  J1 := JOIN(Classified,ConceptTemplateKey,LEFT.TokenType=RIGHT.FieldNumber1,NotePossibles(LEFT,RIGHT))(Len>=2);
  Layout_Template_Hypothesis NextStep(Layout_Template_Hypothesis le,Classified ri,UNSIGNED1 step) := TRANSFORM
    SELF.Spc := le.spc+ri.spc;
    SELF.CPos := le.Cpos + ri.Len;
    SELF.Txt := le.Txt + SALT37.GetRangeOfWords(s,le.Cpos,le.Cpos+ri.len-1); // No spaces - to allow hashes to collide
    SELF.Confirmed := le.Len = step;
    SELF := le;
  END;
  J2 := JOIN(J1(~Confirmed),Classified,LEFT.FieldNumber2 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,2));
  J3 := JOIN(J2(~Confirmed),Classified,LEFT.FieldNumber3 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,3));
  AP0 := (J1+J2+J3)(Confirmed);
  AP := JOIN(AP0,ConceptKey,HASH32(LEFT.Txt)=RIGHT.ConceptHash AND LEFT.TokenType=RIGHT.TokenType,TRANSFORM(Layout_Template_Hypothesis, SELF.Spc := RIGHT.Spc; SELF := LEFT));
  RETURN PROJECT(AP,TRANSFORM(SALT37.Layout_Classify_Hypothesis,SELF.Len := LEFT.Cpos-LEFT.StartPos; SELF.Spc := LEFT.SPC / SELF.Len; SELF := LEFT));
END;
 
EXPORT StreamClassify(SALT37.StrType s) := FUNCTION
  NWords := SALT37.WordCount(s);
  EmptyStart := dataset([],SALT37.Layout_Classify_Hypothesis);
  AH := LOOP(EmptyStart,NWords,SALT37.fn_next_working_hypothesis( ROWS(LEFT),TokenClassify_Raw(SALT37.GetNthWord(s,COUNTER)),COUNTER,Nwords) );
  DD := StreamVerify(s,AH);
  WC := DD+StreamAnnotateConcepts(s,DD);
  DH := SALT37.fn_classify_dedup_hypothesis(WC,TRUE);
  RETURN SORT(DH,SPC,-Len);
END;
 
EXPORT PrettyStreamClassify(SALT37.StrType s) := SALT37.fn_pretty_hypothesis(s,StreamClassify(s),Fields.FieldName);
END;
