IMPORT SALT311;
EXPORT Lerg6Main_Fields := MODULE
 
EXPORT NumFields := 78;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Alpha','Invalid_BlockID','Invalid_Char','Invalid_CocTypeCode','Invalid_Num','Invalid_RcTyCode','Invalid_SccTypeCode','Invalid_Src','Invalid_StatusCode','Invalid_TBlockInd','Invalid_TdCode','Invalid_TestRespCode','Invalid_YesNo');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Alpha' => 1,'Invalid_BlockID' => 2,'Invalid_Char' => 3,'Invalid_CocTypeCode' => 4,'Invalid_Num' => 5,'Invalid_RcTyCode' => 6,'Invalid_SccTypeCode' => 7,'Invalid_Src' => 8,'Invalid_StatusCode' => 9,'Invalid_TBlockInd' => 10,'Invalid_TdCode' => 11,'Invalid_TestRespCode' => 12,'Invalid_YesNo' => 13,0);
 
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
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_RcTyCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_RcTyCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Z','S','+',' ']);
EXPORT InValidMessageFT_Invalid_RcTyCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Z|S|+| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_SccTypeCode(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCIJMNORSTVWXZ8'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_SccTypeCode(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCIJMNORSTVWXZ8'))));
EXPORT InValidMessageFT_Invalid_SccTypeCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCIJMNORSTVWXZ8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Src(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'L6'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Src(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'L6'))));
EXPORT InValidMessageFT_Invalid_Src(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('L6'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_StatusCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_StatusCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['E','M','D',' ']);
EXPORT InValidMessageFT_Invalid_StatusCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('E|M|D| '),SALT311.HygieneErrors.Good);
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','dt_start','dt_end','source','lata','lata_name','status','eff_date','eff_time','npa','nxx','block_id','filler1','coc_type','ssc','dind','td_eo','td_at','portable','aocn','filler2','ocn','loc_name','loc','loc_state','rc_abbre','rc_ty','line_fr','line_to','switch','sha_indicator','filler3','test_line_num','test_line_response','test_line_exp_date','test_line_exp_time','blk_1000_pool','rc_lata','filler4','creation_date','creation_time','filler5','e_status_date','e_status_time','filler6','last_modified_date','last_modified_time','filler7','is_current','os1','os2','os3','os4','os5','os6','os7','os8','os9','os10','os11','os12','os13','os14','os15','os16','os17','os18','os19','os20','os21','os22','os23','os24','os25','notes','global_sid','record_sid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','dt_start','dt_end','source','lata','lata_name','status','eff_date','eff_time','npa','nxx','block_id','filler1','coc_type','ssc','dind','td_eo','td_at','portable','aocn','filler2','ocn','loc_name','loc','loc_state','rc_abbre','rc_ty','line_fr','line_to','switch','sha_indicator','filler3','test_line_num','test_line_response','test_line_exp_date','test_line_exp_time','blk_1000_pool','rc_lata','filler4','creation_date','creation_time','filler5','e_status_date','e_status_time','filler6','last_modified_date','last_modified_time','filler7','is_current','os1','os2','os3','os4','os5','os6','os7','os8','os9','os10','os11','os12','os13','os14','os15','os16','os17','os18','os19','os20','os21','os22','os23','os24','os25','notes','global_sid','record_sid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dt_first_reported' => 0,'dt_last_reported' => 1,'dt_start' => 2,'dt_end' => 3,'source' => 4,'lata' => 5,'lata_name' => 6,'status' => 7,'eff_date' => 8,'eff_time' => 9,'npa' => 10,'nxx' => 11,'block_id' => 12,'filler1' => 13,'coc_type' => 14,'ssc' => 15,'dind' => 16,'td_eo' => 17,'td_at' => 18,'portable' => 19,'aocn' => 20,'filler2' => 21,'ocn' => 22,'loc_name' => 23,'loc' => 24,'loc_state' => 25,'rc_abbre' => 26,'rc_ty' => 27,'line_fr' => 28,'line_to' => 29,'switch' => 30,'sha_indicator' => 31,'filler3' => 32,'test_line_num' => 33,'test_line_response' => 34,'test_line_exp_date' => 35,'test_line_exp_time' => 36,'blk_1000_pool' => 37,'rc_lata' => 38,'filler4' => 39,'creation_date' => 40,'creation_time' => 41,'filler5' => 42,'e_status_date' => 43,'e_status_time' => 44,'filler6' => 45,'last_modified_date' => 46,'last_modified_time' => 47,'filler7' => 48,'is_current' => 49,'os1' => 50,'os2' => 51,'os3' => 52,'os4' => 53,'os5' => 54,'os6' => 55,'os7' => 56,'os8' => 57,'os9' => 58,'os10' => 59,'os11' => 60,'os12' => 61,'os13' => 62,'os14' => 63,'os15' => 64,'os16' => 65,'os17' => 66,'os18' => 67,'os19' => 68,'os20' => 69,'os21' => 70,'os22' => 71,'os23' => 72,'os24' => 73,'os25' => 74,'notes' => 75,'global_sid' => 76,'record_sid' => 77,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ENUM'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ENUM'],[],[],['ENUM'],['ALLOW'],[],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_first_reported(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dt_first_reported(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dt_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dt_last_reported(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dt_last_reported(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dt_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dt_start(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dt_start(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dt_start(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dt_end(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dt_end(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dt_end(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_source(SALT311.StrType s0) := MakeFT_Invalid_Src(s0);
EXPORT InValid_source(SALT311.StrType s) := InValidFT_Invalid_Src(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Src(wh);
 
EXPORT Make_lata(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_lata(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_lata(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_lata_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lata_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lata_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_status(SALT311.StrType s0) := MakeFT_Invalid_StatusCode(s0);
EXPORT InValid_status(SALT311.StrType s) := InValidFT_Invalid_StatusCode(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_Invalid_StatusCode(wh);
 
EXPORT Make_eff_date(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_eff_date(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_eff_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_eff_time(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_eff_time(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_eff_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_npa(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_npa(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_npa(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_nxx(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_nxx(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_nxx(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
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
 
EXPORT Make_test_line_exp_time(SALT311.StrType s0) := s0;
EXPORT InValid_test_line_exp_time(SALT311.StrType s) := 0;
EXPORT InValidMessage_test_line_exp_time(UNSIGNED1 wh) := '';
 
EXPORT Make_blk_1000_pool(SALT311.StrType s0) := MakeFT_Invalid_TBlockInd(s0);
EXPORT InValid_blk_1000_pool(SALT311.StrType s) := InValidFT_Invalid_TBlockInd(s);
EXPORT InValidMessage_blk_1000_pool(UNSIGNED1 wh) := InValidMessageFT_Invalid_TBlockInd(wh);
 
EXPORT Make_rc_lata(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_rc_lata(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_rc_lata(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_filler4(SALT311.StrType s0) := s0;
EXPORT InValid_filler4(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler4(UNSIGNED1 wh) := '';
 
EXPORT Make_creation_date(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_creation_date(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_creation_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_creation_time(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_creation_time(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_creation_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_filler5(SALT311.StrType s0) := s0;
EXPORT InValid_filler5(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler5(UNSIGNED1 wh) := '';
 
EXPORT Make_e_status_date(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_e_status_date(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_e_status_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_e_status_time(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_e_status_time(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_e_status_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_filler6(SALT311.StrType s0) := s0;
EXPORT InValid_filler6(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler6(UNSIGNED1 wh) := '';
 
EXPORT Make_last_modified_date(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_last_modified_date(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_last_modified_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_last_modified_time(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_last_modified_time(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_last_modified_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_filler7(SALT311.StrType s0) := s0;
EXPORT InValid_filler7(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler7(UNSIGNED1 wh) := '';
 
EXPORT Make_is_current(SALT311.StrType s0) := s0;
EXPORT InValid_is_current(SALT311.StrType s) := 0;
EXPORT InValidMessage_is_current(UNSIGNED1 wh) := '';
 
EXPORT Make_os1(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os1(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os2(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os2(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os3(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os3(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os4(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os4(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os5(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os5(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os6(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os6(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os6(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os7(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os7(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os7(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os8(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os8(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os8(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os9(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os9(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os9(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os10(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os10(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os10(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os11(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os11(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os11(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os12(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os12(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os12(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os13(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os13(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os13(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os14(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os14(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os14(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os15(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os15(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os15(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os16(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os16(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os16(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os17(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os17(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os17(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os18(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os18(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os18(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os19(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os19(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os19(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os20(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os20(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os20(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os21(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os21(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os21(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os22(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os22(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os22(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os23(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os23(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os23(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os24(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os24(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os24(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_os25(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_os25(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_os25(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_notes(SALT311.StrType s0) := s0;
EXPORT InValid_notes(SALT311.StrType s) := 0;
EXPORT InValidMessage_notes(UNSIGNED1 wh) := '';
 
EXPORT Make_global_sid(SALT311.StrType s0) := s0;
EXPORT InValid_global_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := '';
 
EXPORT Make_record_sid(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_record_sid(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
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
    BOOLEAN Diff_dt_first_reported;
    BOOLEAN Diff_dt_last_reported;
    BOOLEAN Diff_dt_start;
    BOOLEAN Diff_dt_end;
    BOOLEAN Diff_source;
    BOOLEAN Diff_lata;
    BOOLEAN Diff_lata_name;
    BOOLEAN Diff_status;
    BOOLEAN Diff_eff_date;
    BOOLEAN Diff_eff_time;
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
    BOOLEAN Diff_test_line_exp_time;
    BOOLEAN Diff_blk_1000_pool;
    BOOLEAN Diff_rc_lata;
    BOOLEAN Diff_filler4;
    BOOLEAN Diff_creation_date;
    BOOLEAN Diff_creation_time;
    BOOLEAN Diff_filler5;
    BOOLEAN Diff_e_status_date;
    BOOLEAN Diff_e_status_time;
    BOOLEAN Diff_filler6;
    BOOLEAN Diff_last_modified_date;
    BOOLEAN Diff_last_modified_time;
    BOOLEAN Diff_filler7;
    BOOLEAN Diff_is_current;
    BOOLEAN Diff_os1;
    BOOLEAN Diff_os2;
    BOOLEAN Diff_os3;
    BOOLEAN Diff_os4;
    BOOLEAN Diff_os5;
    BOOLEAN Diff_os6;
    BOOLEAN Diff_os7;
    BOOLEAN Diff_os8;
    BOOLEAN Diff_os9;
    BOOLEAN Diff_os10;
    BOOLEAN Diff_os11;
    BOOLEAN Diff_os12;
    BOOLEAN Diff_os13;
    BOOLEAN Diff_os14;
    BOOLEAN Diff_os15;
    BOOLEAN Diff_os16;
    BOOLEAN Diff_os17;
    BOOLEAN Diff_os18;
    BOOLEAN Diff_os19;
    BOOLEAN Diff_os20;
    BOOLEAN Diff_os21;
    BOOLEAN Diff_os22;
    BOOLEAN Diff_os23;
    BOOLEAN Diff_os24;
    BOOLEAN Diff_os25;
    BOOLEAN Diff_notes;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_record_sid;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_reported := le.dt_first_reported <> ri.dt_first_reported;
    SELF.Diff_dt_last_reported := le.dt_last_reported <> ri.dt_last_reported;
    SELF.Diff_dt_start := le.dt_start <> ri.dt_start;
    SELF.Diff_dt_end := le.dt_end <> ri.dt_end;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_lata := le.lata <> ri.lata;
    SELF.Diff_lata_name := le.lata_name <> ri.lata_name;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_eff_date := le.eff_date <> ri.eff_date;
    SELF.Diff_eff_time := le.eff_time <> ri.eff_time;
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
    SELF.Diff_test_line_exp_time := le.test_line_exp_time <> ri.test_line_exp_time;
    SELF.Diff_blk_1000_pool := le.blk_1000_pool <> ri.blk_1000_pool;
    SELF.Diff_rc_lata := le.rc_lata <> ri.rc_lata;
    SELF.Diff_filler4 := le.filler4 <> ri.filler4;
    SELF.Diff_creation_date := le.creation_date <> ri.creation_date;
    SELF.Diff_creation_time := le.creation_time <> ri.creation_time;
    SELF.Diff_filler5 := le.filler5 <> ri.filler5;
    SELF.Diff_e_status_date := le.e_status_date <> ri.e_status_date;
    SELF.Diff_e_status_time := le.e_status_time <> ri.e_status_time;
    SELF.Diff_filler6 := le.filler6 <> ri.filler6;
    SELF.Diff_last_modified_date := le.last_modified_date <> ri.last_modified_date;
    SELF.Diff_last_modified_time := le.last_modified_time <> ri.last_modified_time;
    SELF.Diff_filler7 := le.filler7 <> ri.filler7;
    SELF.Diff_is_current := le.is_current <> ri.is_current;
    SELF.Diff_os1 := le.os1 <> ri.os1;
    SELF.Diff_os2 := le.os2 <> ri.os2;
    SELF.Diff_os3 := le.os3 <> ri.os3;
    SELF.Diff_os4 := le.os4 <> ri.os4;
    SELF.Diff_os5 := le.os5 <> ri.os5;
    SELF.Diff_os6 := le.os6 <> ri.os6;
    SELF.Diff_os7 := le.os7 <> ri.os7;
    SELF.Diff_os8 := le.os8 <> ri.os8;
    SELF.Diff_os9 := le.os9 <> ri.os9;
    SELF.Diff_os10 := le.os10 <> ri.os10;
    SELF.Diff_os11 := le.os11 <> ri.os11;
    SELF.Diff_os12 := le.os12 <> ri.os12;
    SELF.Diff_os13 := le.os13 <> ri.os13;
    SELF.Diff_os14 := le.os14 <> ri.os14;
    SELF.Diff_os15 := le.os15 <> ri.os15;
    SELF.Diff_os16 := le.os16 <> ri.os16;
    SELF.Diff_os17 := le.os17 <> ri.os17;
    SELF.Diff_os18 := le.os18 <> ri.os18;
    SELF.Diff_os19 := le.os19 <> ri.os19;
    SELF.Diff_os20 := le.os20 <> ri.os20;
    SELF.Diff_os21 := le.os21 <> ri.os21;
    SELF.Diff_os22 := le.os22 <> ri.os22;
    SELF.Diff_os23 := le.os23 <> ri.os23;
    SELF.Diff_os24 := le.os24 <> ri.os24;
    SELF.Diff_os25 := le.os25 <> ri.os25;
    SELF.Diff_notes := le.notes <> ri.notes;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_reported,1,0)+ IF( SELF.Diff_dt_last_reported,1,0)+ IF( SELF.Diff_dt_start,1,0)+ IF( SELF.Diff_dt_end,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_lata,1,0)+ IF( SELF.Diff_lata_name,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_eff_date,1,0)+ IF( SELF.Diff_eff_time,1,0)+ IF( SELF.Diff_npa,1,0)+ IF( SELF.Diff_nxx,1,0)+ IF( SELF.Diff_block_id,1,0)+ IF( SELF.Diff_filler1,1,0)+ IF( SELF.Diff_coc_type,1,0)+ IF( SELF.Diff_ssc,1,0)+ IF( SELF.Diff_dind,1,0)+ IF( SELF.Diff_td_eo,1,0)+ IF( SELF.Diff_td_at,1,0)+ IF( SELF.Diff_portable,1,0)+ IF( SELF.Diff_aocn,1,0)+ IF( SELF.Diff_filler2,1,0)+ IF( SELF.Diff_ocn,1,0)+ IF( SELF.Diff_loc_name,1,0)+ IF( SELF.Diff_loc,1,0)+ IF( SELF.Diff_loc_state,1,0)+ IF( SELF.Diff_rc_abbre,1,0)+ IF( SELF.Diff_rc_ty,1,0)+ IF( SELF.Diff_line_fr,1,0)+ IF( SELF.Diff_line_to,1,0)+ IF( SELF.Diff_switch,1,0)+ IF( SELF.Diff_sha_indicator,1,0)+ IF( SELF.Diff_filler3,1,0)+ IF( SELF.Diff_test_line_num,1,0)+ IF( SELF.Diff_test_line_response,1,0)+ IF( SELF.Diff_test_line_exp_date,1,0)+ IF( SELF.Diff_test_line_exp_time,1,0)+ IF( SELF.Diff_blk_1000_pool,1,0)+ IF( SELF.Diff_rc_lata,1,0)+ IF( SELF.Diff_filler4,1,0)+ IF( SELF.Diff_creation_date,1,0)+ IF( SELF.Diff_creation_time,1,0)+ IF( SELF.Diff_filler5,1,0)+ IF( SELF.Diff_e_status_date,1,0)+ IF( SELF.Diff_e_status_time,1,0)+ IF( SELF.Diff_filler6,1,0)+ IF( SELF.Diff_last_modified_date,1,0)+ IF( SELF.Diff_last_modified_time,1,0)+ IF( SELF.Diff_filler7,1,0)+ IF( SELF.Diff_is_current,1,0)+ IF( SELF.Diff_os1,1,0)+ IF( SELF.Diff_os2,1,0)+ IF( SELF.Diff_os3,1,0)+ IF( SELF.Diff_os4,1,0)+ IF( SELF.Diff_os5,1,0)+ IF( SELF.Diff_os6,1,0)+ IF( SELF.Diff_os7,1,0)+ IF( SELF.Diff_os8,1,0)+ IF( SELF.Diff_os9,1,0)+ IF( SELF.Diff_os10,1,0)+ IF( SELF.Diff_os11,1,0)+ IF( SELF.Diff_os12,1,0)+ IF( SELF.Diff_os13,1,0)+ IF( SELF.Diff_os14,1,0)+ IF( SELF.Diff_os15,1,0)+ IF( SELF.Diff_os16,1,0)+ IF( SELF.Diff_os17,1,0)+ IF( SELF.Diff_os18,1,0)+ IF( SELF.Diff_os19,1,0)+ IF( SELF.Diff_os20,1,0)+ IF( SELF.Diff_os21,1,0)+ IF( SELF.Diff_os22,1,0)+ IF( SELF.Diff_os23,1,0)+ IF( SELF.Diff_os24,1,0)+ IF( SELF.Diff_os25,1,0)+ IF( SELF.Diff_notes,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_record_sid,1,0);
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
    Count_Diff_dt_first_reported := COUNT(GROUP,%Closest%.Diff_dt_first_reported);
    Count_Diff_dt_last_reported := COUNT(GROUP,%Closest%.Diff_dt_last_reported);
    Count_Diff_dt_start := COUNT(GROUP,%Closest%.Diff_dt_start);
    Count_Diff_dt_end := COUNT(GROUP,%Closest%.Diff_dt_end);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_lata := COUNT(GROUP,%Closest%.Diff_lata);
    Count_Diff_lata_name := COUNT(GROUP,%Closest%.Diff_lata_name);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_eff_date := COUNT(GROUP,%Closest%.Diff_eff_date);
    Count_Diff_eff_time := COUNT(GROUP,%Closest%.Diff_eff_time);
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
    Count_Diff_test_line_exp_time := COUNT(GROUP,%Closest%.Diff_test_line_exp_time);
    Count_Diff_blk_1000_pool := COUNT(GROUP,%Closest%.Diff_blk_1000_pool);
    Count_Diff_rc_lata := COUNT(GROUP,%Closest%.Diff_rc_lata);
    Count_Diff_filler4 := COUNT(GROUP,%Closest%.Diff_filler4);
    Count_Diff_creation_date := COUNT(GROUP,%Closest%.Diff_creation_date);
    Count_Diff_creation_time := COUNT(GROUP,%Closest%.Diff_creation_time);
    Count_Diff_filler5 := COUNT(GROUP,%Closest%.Diff_filler5);
    Count_Diff_e_status_date := COUNT(GROUP,%Closest%.Diff_e_status_date);
    Count_Diff_e_status_time := COUNT(GROUP,%Closest%.Diff_e_status_time);
    Count_Diff_filler6 := COUNT(GROUP,%Closest%.Diff_filler6);
    Count_Diff_last_modified_date := COUNT(GROUP,%Closest%.Diff_last_modified_date);
    Count_Diff_last_modified_time := COUNT(GROUP,%Closest%.Diff_last_modified_time);
    Count_Diff_filler7 := COUNT(GROUP,%Closest%.Diff_filler7);
    Count_Diff_is_current := COUNT(GROUP,%Closest%.Diff_is_current);
    Count_Diff_os1 := COUNT(GROUP,%Closest%.Diff_os1);
    Count_Diff_os2 := COUNT(GROUP,%Closest%.Diff_os2);
    Count_Diff_os3 := COUNT(GROUP,%Closest%.Diff_os3);
    Count_Diff_os4 := COUNT(GROUP,%Closest%.Diff_os4);
    Count_Diff_os5 := COUNT(GROUP,%Closest%.Diff_os5);
    Count_Diff_os6 := COUNT(GROUP,%Closest%.Diff_os6);
    Count_Diff_os7 := COUNT(GROUP,%Closest%.Diff_os7);
    Count_Diff_os8 := COUNT(GROUP,%Closest%.Diff_os8);
    Count_Diff_os9 := COUNT(GROUP,%Closest%.Diff_os9);
    Count_Diff_os10 := COUNT(GROUP,%Closest%.Diff_os10);
    Count_Diff_os11 := COUNT(GROUP,%Closest%.Diff_os11);
    Count_Diff_os12 := COUNT(GROUP,%Closest%.Diff_os12);
    Count_Diff_os13 := COUNT(GROUP,%Closest%.Diff_os13);
    Count_Diff_os14 := COUNT(GROUP,%Closest%.Diff_os14);
    Count_Diff_os15 := COUNT(GROUP,%Closest%.Diff_os15);
    Count_Diff_os16 := COUNT(GROUP,%Closest%.Diff_os16);
    Count_Diff_os17 := COUNT(GROUP,%Closest%.Diff_os17);
    Count_Diff_os18 := COUNT(GROUP,%Closest%.Diff_os18);
    Count_Diff_os19 := COUNT(GROUP,%Closest%.Diff_os19);
    Count_Diff_os20 := COUNT(GROUP,%Closest%.Diff_os20);
    Count_Diff_os21 := COUNT(GROUP,%Closest%.Diff_os21);
    Count_Diff_os22 := COUNT(GROUP,%Closest%.Diff_os22);
    Count_Diff_os23 := COUNT(GROUP,%Closest%.Diff_os23);
    Count_Diff_os24 := COUNT(GROUP,%Closest%.Diff_os24);
    Count_Diff_os25 := COUNT(GROUP,%Closest%.Diff_os25);
    Count_Diff_notes := COUNT(GROUP,%Closest%.Diff_notes);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
