IMPORT SALT311;
EXPORT Lerg6Raw_Fields := MODULE
 
EXPORT NumFields := 40;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Alpha','Invalid_BlockID','Invalid_Char','Invalid_CocTypeCode','Invalid_Filename','Invalid_Num','Invalid_Nxx','Invalid_RcTyCode','Invalid_StatusCode','Invalid_SccTypeCode','Invalid_TBlockInd','Invalid_TdCode','Invalid_TestRespCode','Invalid_YesNo');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Alpha' => 1,'Invalid_BlockID' => 2,'Invalid_Char' => 3,'Invalid_CocTypeCode' => 4,'Invalid_Filename' => 5,'Invalid_Num' => 6,'Invalid_Nxx' => 7,'Invalid_RcTyCode' => 8,'Invalid_StatusCode' => 9,'Invalid_SccTypeCode' => 10,'Invalid_TBlockInd' => 11,'Invalid_TdCode' => 12,'Invalid_TestRespCode' => 13,'Invalid_YesNo' => 14,0);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ- '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ- '))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ- '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_BlockID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789A'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_BlockID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789A'))));
EXPORT InValidMessageFT_Invalid_BlockID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789A'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\' '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\' '))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\' '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CocTypeCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CocTypeCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['700','AIN','ATC','BLG','BRD','CDA','CTV','ENP','EOC','FGB','HVL','INP','N11','ONA','PLN','PMC','RCC','RTG','SIC','SP1','SP2','TST','UFA','VOI']);
EXPORT InValidMessageFT_Invalid_CocTypeCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('700|AIN|ATC|BLG|BRD|CDA|CTV|ENP|EOC|FGB|HVL|INP|N11|ONA|PLN|PMC|RCC|RTG|SIC|SP1|SP2|TST|UFA|VOI'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Filename(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Filename(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'))));
EXPORT InValidMessageFT_Invalid_Filename(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Nxx(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789+'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Nxx(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789+'))));
EXPORT InValidMessageFT_Invalid_Nxx(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789+'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_RcTyCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_RcTyCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Z','S','+',' ']);
EXPORT InValidMessageFT_Invalid_RcTyCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Z|S|+| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_StatusCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_StatusCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['E','M','D',' ']);
EXPORT InValidMessageFT_Invalid_StatusCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('E|M|D| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_SccTypeCode(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCIJMNORSTVWXZ8'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_SccTypeCode(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCIJMNORSTVWXZ8'))));
EXPORT InValidMessageFT_Invalid_SccTypeCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCIJMNORSTVWXZ8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_TBlockInd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_TBlockInd(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['I','N','S','Y']);
EXPORT InValidMessageFT_Invalid_TBlockInd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('I|N|S|Y'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_TdCode(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789NA'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_TdCode(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789NA'))));
EXPORT InValidMessageFT_Invalid_TdCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789NA'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_TestRespCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_TestRespCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','M',' ']);
EXPORT InValidMessageFT_Invalid_TestRespCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|M| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_YesNo(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_YesNo(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N']);
EXPORT InValidMessageFT_Invalid_YesNo(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'lata','lata_name','status','eff_date','npa','nxx','block_id','filler1','coc_type','ssc','dind','td_eo','td_at','portable','aocn','filler2','ocn','loc_name','loc','loc_state','rc_abbre','rc_ty','line_fr','line_to','switch','sha_indicator','filler3','test_line_num','test_line_response','test_line_exp_date','blk_1000_pool','rc_lata','filler4','creation_date','filler5','e_status_date','filler6','last_modified_date','filler7','filename');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'lata','lata_name','status','eff_date','npa','nxx','block_id','filler1','coc_type','ssc','dind','td_eo','td_at','portable','aocn','filler2','ocn','loc_name','loc','loc_state','rc_abbre','rc_ty','line_fr','line_to','switch','sha_indicator','filler3','test_line_num','test_line_response','test_line_exp_date','blk_1000_pool','rc_lata','filler4','creation_date','filler5','e_status_date','filler6','last_modified_date','filler7','filename');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'lata' => 0,'lata_name' => 1,'status' => 2,'eff_date' => 3,'npa' => 4,'nxx' => 5,'block_id' => 6,'filler1' => 7,'coc_type' => 8,'ssc' => 9,'dind' => 10,'td_eo' => 11,'td_at' => 12,'portable' => 13,'aocn' => 14,'filler2' => 15,'ocn' => 16,'loc_name' => 17,'loc' => 18,'loc_state' => 19,'rc_abbre' => 20,'rc_ty' => 21,'line_fr' => 22,'line_to' => 23,'switch' => 24,'sha_indicator' => 25,'filler3' => 26,'test_line_num' => 27,'test_line_response' => 28,'test_line_exp_date' => 29,'blk_1000_pool' => 30,'rc_lata' => 31,'filler4' => 32,'creation_date' => 33,'filler5' => 34,'e_status_date' => 35,'filler6' => 36,'last_modified_date' => 37,'filler7' => 38,'filename' => 39,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ENUM'],[],['ALLOW'],['ALLOW'],['ALLOW'],[],['ENUM'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ENUM'],[],['ENUM'],['ALLOW'],[],[],[],[],[],[],[],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_lata(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_lata(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_lata(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_lata_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lata_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lata_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_status(SALT311.StrType s0) := MakeFT_Invalid_StatusCode(s0);
EXPORT InValid_status(SALT311.StrType s) := InValidFT_Invalid_StatusCode(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_Invalid_StatusCode(wh);
 
EXPORT Make_eff_date(SALT311.StrType s0) := s0;
EXPORT InValid_eff_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_eff_date(UNSIGNED1 wh) := '';
 
EXPORT Make_npa(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_npa(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_npa(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_nxx(SALT311.StrType s0) := MakeFT_Invalid_Nxx(s0);
EXPORT InValid_nxx(SALT311.StrType s) := InValidFT_Invalid_Nxx(s);
EXPORT InValidMessage_nxx(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nxx(wh);
 
EXPORT Make_block_id(SALT311.StrType s0) := MakeFT_Invalid_BlockID(s0);
EXPORT InValid_block_id(SALT311.StrType s) := InValidFT_Invalid_BlockID(s);
EXPORT InValidMessage_block_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_BlockID(wh);
 
EXPORT Make_filler1(SALT311.StrType s0) := s0;
EXPORT InValid_filler1(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler1(UNSIGNED1 wh) := '';
 
EXPORT Make_coc_type(SALT311.StrType s0) := MakeFT_Invalid_CocTypeCode(s0);
EXPORT InValid_coc_type(SALT311.StrType s) := InValidFT_Invalid_CocTypeCode(s);
EXPORT InValidMessage_coc_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_CocTypeCode(wh);
 
EXPORT Make_ssc(SALT311.StrType s0) := MakeFT_Invalid_SccTypeCode(s0);
EXPORT InValid_ssc(SALT311.StrType s) := InValidFT_Invalid_SccTypeCode(s);
EXPORT InValidMessage_ssc(UNSIGNED1 wh) := InValidMessageFT_Invalid_SccTypeCode(wh);
 
EXPORT Make_dind(SALT311.StrType s0) := MakeFT_Invalid_YesNo(s0);
EXPORT InValid_dind(SALT311.StrType s) := InValidFT_Invalid_YesNo(s);
EXPORT InValidMessage_dind(UNSIGNED1 wh) := InValidMessageFT_Invalid_YesNo(wh);
 
EXPORT Make_td_eo(SALT311.StrType s0) := MakeFT_Invalid_TdCode(s0);
EXPORT InValid_td_eo(SALT311.StrType s) := InValidFT_Invalid_TdCode(s);
EXPORT InValidMessage_td_eo(UNSIGNED1 wh) := InValidMessageFT_Invalid_TdCode(wh);
 
EXPORT Make_td_at(SALT311.StrType s0) := MakeFT_Invalid_TdCode(s0);
EXPORT InValid_td_at(SALT311.StrType s) := InValidFT_Invalid_TdCode(s);
EXPORT InValidMessage_td_at(UNSIGNED1 wh) := InValidMessageFT_Invalid_TdCode(wh);
 
EXPORT Make_portable(SALT311.StrType s0) := MakeFT_Invalid_YesNo(s0);
EXPORT InValid_portable(SALT311.StrType s) := InValidFT_Invalid_YesNo(s);
EXPORT InValidMessage_portable(UNSIGNED1 wh) := InValidMessageFT_Invalid_YesNo(wh);
 
EXPORT Make_aocn(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_aocn(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_aocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_filler2(SALT311.StrType s0) := s0;
EXPORT InValid_filler2(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler2(UNSIGNED1 wh) := '';
 
EXPORT Make_ocn(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_ocn(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_ocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_loc_name(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_loc_name(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_loc_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_loc(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_loc(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_loc(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_loc_state(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_loc_state(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_loc_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rc_abbre(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_rc_abbre(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_rc_abbre(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_rc_ty(SALT311.StrType s0) := MakeFT_Invalid_RcTyCode(s0);
EXPORT InValid_rc_ty(SALT311.StrType s) := InValidFT_Invalid_RcTyCode(s);
EXPORT InValidMessage_rc_ty(UNSIGNED1 wh) := InValidMessageFT_Invalid_RcTyCode(wh);
 
EXPORT Make_line_fr(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_line_fr(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_line_fr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_line_to(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_line_to(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_line_to(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_switch(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_switch(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_switch(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_sha_indicator(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sha_indicator(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sha_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_filler3(SALT311.StrType s0) := s0;
EXPORT InValid_filler3(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler3(UNSIGNED1 wh) := '';
 
EXPORT Make_test_line_num(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_test_line_num(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_test_line_num(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_test_line_response(SALT311.StrType s0) := MakeFT_Invalid_TestRespCode(s0);
EXPORT InValid_test_line_response(SALT311.StrType s) := InValidFT_Invalid_TestRespCode(s);
EXPORT InValidMessage_test_line_response(UNSIGNED1 wh) := InValidMessageFT_Invalid_TestRespCode(wh);
 
EXPORT Make_test_line_exp_date(SALT311.StrType s0) := s0;
EXPORT InValid_test_line_exp_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_test_line_exp_date(UNSIGNED1 wh) := '';
 
EXPORT Make_blk_1000_pool(SALT311.StrType s0) := MakeFT_Invalid_TBlockInd(s0);
EXPORT InValid_blk_1000_pool(SALT311.StrType s) := InValidFT_Invalid_TBlockInd(s);
EXPORT InValidMessage_blk_1000_pool(UNSIGNED1 wh) := InValidMessageFT_Invalid_TBlockInd(wh);
 
EXPORT Make_rc_lata(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_rc_lata(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_rc_lata(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_filler4(SALT311.StrType s0) := s0;
EXPORT InValid_filler4(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler4(UNSIGNED1 wh) := '';
 
EXPORT Make_creation_date(SALT311.StrType s0) := s0;
EXPORT InValid_creation_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_creation_date(UNSIGNED1 wh) := '';
 
EXPORT Make_filler5(SALT311.StrType s0) := s0;
EXPORT InValid_filler5(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler5(UNSIGNED1 wh) := '';
 
EXPORT Make_e_status_date(SALT311.StrType s0) := s0;
EXPORT InValid_e_status_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_e_status_date(UNSIGNED1 wh) := '';
 
EXPORT Make_filler6(SALT311.StrType s0) := s0;
EXPORT InValid_filler6(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler6(UNSIGNED1 wh) := '';
 
EXPORT Make_last_modified_date(SALT311.StrType s0) := s0;
EXPORT InValid_last_modified_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_last_modified_date(UNSIGNED1 wh) := '';
 
EXPORT Make_filler7(SALT311.StrType s0) := s0;
EXPORT InValid_filler7(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler7(UNSIGNED1 wh) := '';
 
EXPORT Make_filename(SALT311.StrType s0) := MakeFT_Invalid_Filename(s0);
EXPORT InValid_filename(SALT311.StrType s) := InValidFT_Invalid_Filename(s);
EXPORT InValidMessage_filename(UNSIGNED1 wh) := InValidMessageFT_Invalid_Filename(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Phonesinfo;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_lata;
    BOOLEAN Diff_lata_name;
    BOOLEAN Diff_status;
    BOOLEAN Diff_eff_date;
    BOOLEAN Diff_npa;
    BOOLEAN Diff_nxx;
    BOOLEAN Diff_block_id;
    BOOLEAN Diff_filler1;
    BOOLEAN Diff_coc_type;
    BOOLEAN Diff_ssc;
    BOOLEAN Diff_dind;
    BOOLEAN Diff_td_eo;
    BOOLEAN Diff_td_at;
    BOOLEAN Diff_portable;
    BOOLEAN Diff_aocn;
    BOOLEAN Diff_filler2;
    BOOLEAN Diff_ocn;
    BOOLEAN Diff_loc_name;
    BOOLEAN Diff_loc;
    BOOLEAN Diff_loc_state;
    BOOLEAN Diff_rc_abbre;
    BOOLEAN Diff_rc_ty;
    BOOLEAN Diff_line_fr;
    BOOLEAN Diff_line_to;
    BOOLEAN Diff_switch;
    BOOLEAN Diff_sha_indicator;
    BOOLEAN Diff_filler3;
    BOOLEAN Diff_test_line_num;
    BOOLEAN Diff_test_line_response;
    BOOLEAN Diff_test_line_exp_date;
    BOOLEAN Diff_blk_1000_pool;
    BOOLEAN Diff_rc_lata;
    BOOLEAN Diff_filler4;
    BOOLEAN Diff_creation_date;
    BOOLEAN Diff_filler5;
    BOOLEAN Diff_e_status_date;
    BOOLEAN Diff_filler6;
    BOOLEAN Diff_last_modified_date;
    BOOLEAN Diff_filler7;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_lata := le.lata <> ri.lata;
    SELF.Diff_lata_name := le.lata_name <> ri.lata_name;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_eff_date := le.eff_date <> ri.eff_date;
    SELF.Diff_npa := le.npa <> ri.npa;
    SELF.Diff_nxx := le.nxx <> ri.nxx;
    SELF.Diff_block_id := le.block_id <> ri.block_id;
    SELF.Diff_filler1 := le.filler1 <> ri.filler1;
    SELF.Diff_coc_type := le.coc_type <> ri.coc_type;
    SELF.Diff_ssc := le.ssc <> ri.ssc;
    SELF.Diff_dind := le.dind <> ri.dind;
    SELF.Diff_td_eo := le.td_eo <> ri.td_eo;
    SELF.Diff_td_at := le.td_at <> ri.td_at;
    SELF.Diff_portable := le.portable <> ri.portable;
    SELF.Diff_aocn := le.aocn <> ri.aocn;
    SELF.Diff_filler2 := le.filler2 <> ri.filler2;
    SELF.Diff_ocn := le.ocn <> ri.ocn;
    SELF.Diff_loc_name := le.loc_name <> ri.loc_name;
    SELF.Diff_loc := le.loc <> ri.loc;
    SELF.Diff_loc_state := le.loc_state <> ri.loc_state;
    SELF.Diff_rc_abbre := le.rc_abbre <> ri.rc_abbre;
    SELF.Diff_rc_ty := le.rc_ty <> ri.rc_ty;
    SELF.Diff_line_fr := le.line_fr <> ri.line_fr;
    SELF.Diff_line_to := le.line_to <> ri.line_to;
    SELF.Diff_switch := le.switch <> ri.switch;
    SELF.Diff_sha_indicator := le.sha_indicator <> ri.sha_indicator;
    SELF.Diff_filler3 := le.filler3 <> ri.filler3;
    SELF.Diff_test_line_num := le.test_line_num <> ri.test_line_num;
    SELF.Diff_test_line_response := le.test_line_response <> ri.test_line_response;
    SELF.Diff_test_line_exp_date := le.test_line_exp_date <> ri.test_line_exp_date;
    SELF.Diff_blk_1000_pool := le.blk_1000_pool <> ri.blk_1000_pool;
    SELF.Diff_rc_lata := le.rc_lata <> ri.rc_lata;
    SELF.Diff_filler4 := le.filler4 <> ri.filler4;
    SELF.Diff_creation_date := le.creation_date <> ri.creation_date;
    SELF.Diff_filler5 := le.filler5 <> ri.filler5;
    SELF.Diff_e_status_date := le.e_status_date <> ri.e_status_date;
    SELF.Diff_filler6 := le.filler6 <> ri.filler6;
    SELF.Diff_last_modified_date := le.last_modified_date <> ri.last_modified_date;
    SELF.Diff_filler7 := le.filler7 <> ri.filler7;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_lata,1,0)+ IF( SELF.Diff_lata_name,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_eff_date,1,0)+ IF( SELF.Diff_npa,1,0)+ IF( SELF.Diff_nxx,1,0)+ IF( SELF.Diff_block_id,1,0)+ IF( SELF.Diff_filler1,1,0)+ IF( SELF.Diff_coc_type,1,0)+ IF( SELF.Diff_ssc,1,0)+ IF( SELF.Diff_dind,1,0)+ IF( SELF.Diff_td_eo,1,0)+ IF( SELF.Diff_td_at,1,0)+ IF( SELF.Diff_portable,1,0)+ IF( SELF.Diff_aocn,1,0)+ IF( SELF.Diff_filler2,1,0)+ IF( SELF.Diff_ocn,1,0)+ IF( SELF.Diff_loc_name,1,0)+ IF( SELF.Diff_loc,1,0)+ IF( SELF.Diff_loc_state,1,0)+ IF( SELF.Diff_rc_abbre,1,0)+ IF( SELF.Diff_rc_ty,1,0)+ IF( SELF.Diff_line_fr,1,0)+ IF( SELF.Diff_line_to,1,0)+ IF( SELF.Diff_switch,1,0)+ IF( SELF.Diff_sha_indicator,1,0)+ IF( SELF.Diff_filler3,1,0)+ IF( SELF.Diff_test_line_num,1,0)+ IF( SELF.Diff_test_line_response,1,0)+ IF( SELF.Diff_test_line_exp_date,1,0)+ IF( SELF.Diff_blk_1000_pool,1,0)+ IF( SELF.Diff_rc_lata,1,0)+ IF( SELF.Diff_filler4,1,0)+ IF( SELF.Diff_creation_date,1,0)+ IF( SELF.Diff_filler5,1,0)+ IF( SELF.Diff_e_status_date,1,0)+ IF( SELF.Diff_filler6,1,0)+ IF( SELF.Diff_last_modified_date,1,0)+ IF( SELF.Diff_filler7,1,0)+ IF( SELF.Diff_filename,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_lata := COUNT(GROUP,%Closest%.Diff_lata);
    Count_Diff_lata_name := COUNT(GROUP,%Closest%.Diff_lata_name);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_eff_date := COUNT(GROUP,%Closest%.Diff_eff_date);
    Count_Diff_npa := COUNT(GROUP,%Closest%.Diff_npa);
    Count_Diff_nxx := COUNT(GROUP,%Closest%.Diff_nxx);
    Count_Diff_block_id := COUNT(GROUP,%Closest%.Diff_block_id);
    Count_Diff_filler1 := COUNT(GROUP,%Closest%.Diff_filler1);
    Count_Diff_coc_type := COUNT(GROUP,%Closest%.Diff_coc_type);
    Count_Diff_ssc := COUNT(GROUP,%Closest%.Diff_ssc);
    Count_Diff_dind := COUNT(GROUP,%Closest%.Diff_dind);
    Count_Diff_td_eo := COUNT(GROUP,%Closest%.Diff_td_eo);
    Count_Diff_td_at := COUNT(GROUP,%Closest%.Diff_td_at);
    Count_Diff_portable := COUNT(GROUP,%Closest%.Diff_portable);
    Count_Diff_aocn := COUNT(GROUP,%Closest%.Diff_aocn);
    Count_Diff_filler2 := COUNT(GROUP,%Closest%.Diff_filler2);
    Count_Diff_ocn := COUNT(GROUP,%Closest%.Diff_ocn);
    Count_Diff_loc_name := COUNT(GROUP,%Closest%.Diff_loc_name);
    Count_Diff_loc := COUNT(GROUP,%Closest%.Diff_loc);
    Count_Diff_loc_state := COUNT(GROUP,%Closest%.Diff_loc_state);
    Count_Diff_rc_abbre := COUNT(GROUP,%Closest%.Diff_rc_abbre);
    Count_Diff_rc_ty := COUNT(GROUP,%Closest%.Diff_rc_ty);
    Count_Diff_line_fr := COUNT(GROUP,%Closest%.Diff_line_fr);
    Count_Diff_line_to := COUNT(GROUP,%Closest%.Diff_line_to);
    Count_Diff_switch := COUNT(GROUP,%Closest%.Diff_switch);
    Count_Diff_sha_indicator := COUNT(GROUP,%Closest%.Diff_sha_indicator);
    Count_Diff_filler3 := COUNT(GROUP,%Closest%.Diff_filler3);
    Count_Diff_test_line_num := COUNT(GROUP,%Closest%.Diff_test_line_num);
    Count_Diff_test_line_response := COUNT(GROUP,%Closest%.Diff_test_line_response);
    Count_Diff_test_line_exp_date := COUNT(GROUP,%Closest%.Diff_test_line_exp_date);
    Count_Diff_blk_1000_pool := COUNT(GROUP,%Closest%.Diff_blk_1000_pool);
    Count_Diff_rc_lata := COUNT(GROUP,%Closest%.Diff_rc_lata);
    Count_Diff_filler4 := COUNT(GROUP,%Closest%.Diff_filler4);
    Count_Diff_creation_date := COUNT(GROUP,%Closest%.Diff_creation_date);
    Count_Diff_filler5 := COUNT(GROUP,%Closest%.Diff_filler5);
    Count_Diff_e_status_date := COUNT(GROUP,%Closest%.Diff_e_status_date);
    Count_Diff_filler6 := COUNT(GROUP,%Closest%.Diff_filler6);
    Count_Diff_last_modified_date := COUNT(GROUP,%Closest%.Diff_last_modified_date);
    Count_Diff_filler7 := COUNT(GROUP,%Closest%.Diff_filler7);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
