﻿##---------------------------------------------------------------------------
##dCompanyNameScore
##Debug and matches
##---------------------------------------------------------------------------
def dCompanyNameScore(): 
	return [
		('debug','(SELF\.cnp_name_score := )([^;]*?)(; [/][/] Enforce FORCE parameter)','HACKCompanyNameScore'
			,'  import tools;\n'
			+'  cnp_name_bow_most_38    := SALT311.MatchBagOfWords(le.cnp_name,ri.cnp_name,38   ,1);  //threshold of 800\n'
			+'  string_similarity_ratio := tools.string_similarity_ratio(trim(le.cnp_name_phonetic),trim(ri.cnp_name_phonetic));\n'
			+'  not_both_legal_names    := ~(regexfind(\'legal\',le.company_name_type_derived,nocase) and regexfind(\'legal\',ri.company_name_type_derived,nocase) );\n'
			+'\n'
			+'  self.cnp_name_match_info := \n'
			+'     \'cnp_name_score_supp:\'       + (string)cnp_name_score_supp \n'
			+'   + \' cnp_name_support0:\'        + (string)cnp_name_support0 \n'
			+'   + \' cnp_name_score_temp:\'      + (string)cnp_name_score_temp\n'
			+'   + \' cnp_name_bow_most_38:\'     + (string)cnp_name_bow_most_38\n'
			+'   + \' cnp_name_phonetic_score:\'  + (string)self.cnp_name_phonetic_score\n'
			+'   + \' string_similarity_ratio:\'  + (string)string_similarity_ratio\n'
			+'   ;\n'
			+'  SELF.cnp_name_score := MAP ( \n'
			+'        le.cnp_name          = ri.cnp_name \n'
			+'    or (cnp_name_score_supp >= Config.cnp_name_Force * 100 and cnp_name_support0 = 0)\n'
			+'    or (cnp_name_score_supp >= Config.cnp_name_Force * 100 and cnp_name_support0 > 0)  \n'
			+'                                                                                                                                                                             => cnp_name_score_supp\n'
			+'    ,self.active_domestic_corp_key_score > Config.active_domestic_corp_key_Force*100  and not_both_legal_names                                                               => 0\n'
			+'    ,self.active_duns_number_score       > Config.active_duns_number_Force      *100  and not_both_legal_names                                                               => 0\n'
			+'    ,self.company_fein_score             > Config.company_fein_Force            *100  and not_both_legal_names  and (le.SALT_Partition = \'\' and ri.SALT_Partition = \'\')  => 0                    /*no partitioned sources allowed*/\n'
			+'    ,self.sbfe_id_score                  > Config.sbfe_id_Force                 *100  and not_both_legal_names  and (le.SALT_Partition = \'\' and ri.SALT_Partition = \'\')  => 0                    /*no partitioned sources allowed*/\n'
			+'\n'
			+'    ,(cnp_name_bow_most_38           >= 800 or self.cnp_name_phonetic_score        >= 700) and string_similarity_ratio >= 0.70/* or string_similarity_ratio >= 0.80 */   => map(cnp_name_bow_most_38 > self.cnp_name_phonetic_score and cnp_name_bow_most_38 > 800 => cnp_name_bow_most_38  \n'
			+'                                                                                                                                                                           ,self.cnp_name_phonetic_score  >= 700                                                   => self.cnp_name_phonetic_score\n'
			+'                                                                                                                                                                           ,0\n'
			+'                                                                                                                                                                           )    // ,cnp_name_phonetic_score        >= 700 and string_similarity >= 0.70                                                                                            => 0                    //this is already counted as a regular field, so don\'t double count\n'
			+'\n'
			+'    ,                                                                                                                                                                      -9999 \n'                                                                                                                 
			+'  );/*HACKCompanyNameScore*/ // Enforce FORCE parameter\n','company name replacement'),	
		('matches','(INTEGER2 cnp_name_score := )([^;]*?)(;)','HACKCompanyNameScore'
			,'  import tools;\n'
			+'  cnp_name_bow_most_38    := SALT311.MatchBagOfWords(le.cnp_name,ri.cnp_name,38   ,1);  //threshold of 800\n'
			+'  string_similarity_ratio := tools.string_similarity_ratio(trim(le.cnp_name_phonetic),trim(ri.cnp_name_phonetic));\n'
			+'  not_both_legal_names    := ~(regexfind(\'legal\',le.company_name_type_derived,nocase) and regexfind(\'legal\',ri.company_name_type_derived,nocase) );\n'
			+'\n'
			+'  INTEGER2 cnp_name_score := MAP ( \n'
			+'        le.cnp_name          = ri.cnp_name \n'
			+'    or (cnp_name_score_supp >= Config.cnp_name_Force * 100 and cnp_name_support0 = 0)\n'
			+'    or (cnp_name_score_supp >= Config.cnp_name_Force * 100 and cnp_name_support0 > 0)  \n'
			+'                                                                                                                                                                         => cnp_name_score_supp\n'
			+'    ,active_domestic_corp_key_score > Config.active_domestic_corp_key_Force*100  and not_both_legal_names                                                                => 0\n'
			+'    ,active_duns_number_score       > Config.active_duns_number_Force      *100  and not_both_legal_names                                                                => 0\n'
			+'    ,company_fein_score             > Config.company_fein_Force            *100  and not_both_legal_names  and (le.SALT_Partition = \'\' and ri.SALT_Partition = \'\')   => 0                    /*no partitioned sources allowed*/\n'
			+'    ,sbfe_id_score                  > Config.sbfe_id_Force                 *100  and not_both_legal_names  and (le.SALT_Partition = \'\' and ri.SALT_Partition = \'\')   => 0                    /*no partitioned sources allowed*/\n'
			+'\n'
			+'    ,(cnp_name_bow_most_38           >= 800 or cnp_name_phonetic_score        >= 700) and string_similarity_ratio >= 0.70/* or string_similarity_ratio >= 0.80 */   => map(cnp_name_bow_most_38 > cnp_name_phonetic_score and cnp_name_bow_most_38 > 800 => cnp_name_bow_most_38  \n'
			+'                                                                                                                                                                           ,cnp_name_phonetic_score  >= 700                                                   => cnp_name_phonetic_score\n'
			+'                                                                                                                                                                           ,0\n'
			+'                                                                                                                                                                           )    // ,cnp_name_phonetic_score        >= 700 and string_similarity >= 0.70                                                                                            => 0                    //this is already counted as a regular field, so don\'t double count\n'
			+'\n'
			+'    ,                                                                                                                                                                      SKIP \n'
			+'  );/*HACKCompanyNameScore*/ // Enforce FORCE parameter\n','company name replacement') 	
		]


##---------------------------------------------------------------------------
##dPrimNameExactMatch
##debug and matches
#---------------------------------------------------------------------------
def dPrimNameExactMatch():
	return [
		('debug', '(SELF\.prim_name_derived_score := IF \( )([^;]*?)(;)', 'HACKPrimName','\g<1>le.prim_name_derived = ri.prim_name_derived/*HACKPrimName*/ or \g<2>\g<3>', 'Hack prim_name_derived exact match'),
		('matches', '(INTEGER2 prim_name_derived_score := IF \( )([^;]*?)(;)', 'HACKPrimName','\g<1>le.prim_name_derived = ri.prim_name_derived/*HACKPrimName*/ or \g<2>\g<3>', 'Hack prim_name_derived exact match')
	]


##---------------------------------------------------------------------------
##dCompanyNumberEquality
##matches
##---------------------------------------------------------------------------
def dCompanyNumberEquality():
	return [
		('matches', '(INTEGER2 cnp_number_score := IF \( )([^;]*?)(;)', 'HACKCompanyNumber','\g<1>le.cnp_number = ri.cnp_number /*HACKCompanyNumber*/ /* cnp_number_score_temp >= Config.cnp_number_Force * 100 */ , cnp_number_score_temp, SKIP );', 'Add cnp_number equality condition')
	]
			
##---------------------------------------------------------------------------
##dScoreAssignment
##debug and matches
##---------------------------------------------------------------------------
def dScoreAssignment():
	return [
		('debug', '(SELF\.Conf := \(SELF\.cnp_number_score \+)([^;]*?)(\/ 100 \+ outside;)', 'HACKScoreAssignment','import ut;\n'
			+'iComp1 := (self.salt_partition_score + SELF.cnp_number_score + SELF.hist_enterprise_number_score + SELF.ebr_file_number_score + SELF.active_enterprise_number_score + SELF.hist_domestic_corp_key_score + SELF.foreign_corp_key_score + SELF.unk_corp_key_score + SELF.active_domestic_corp_key_score + SELF.hist_duns_number_score + SELF.active_duns_number_score + SELF.company_phone_score + SELF.company_fein_score + SELF.cnp_name_score + SELF.cnp_btype_score + SELF.company_name_type_derived_score + IF(SELF.company_address_score>0,MAX(SELF.company_address_score,IF(SELF.company_addr1_score>0,MAX(SELF.company_addr1_score,SELF.prim_range_derived_score + SELF.prim_name_derived_score + SELF.sec_range_score),SELF.prim_range_derived_score + SELF.prim_name_derived_score + SELF.sec_range_score) + IF(SELF.company_csz_score>0,MAX(SELF.company_csz_score,SELF.v_city_name_score + SELF.st_score + SELF.zip_score),SELF.v_city_name_score + SELF.st_score + SELF.zip_score)),IF(SELF.company_addr1_score>0,MAX(SELF.company_addr1_score,SELF.prim_range_derived_score + SELF.prim_name_derived_score + SELF.sec_range_score),SELF.prim_range_derived_score + SELF.prim_name_derived_score + SELF.sec_range_score) + IF(SELF.company_csz_score>0,MAX(SELF.company_csz_score,SELF.v_city_name_score + SELF.st_score + SELF.zip_score),SELF.v_city_name_score + SELF.st_score + SELF.zip_score))) / 100 + outside;\n'
			+'iComp  := map( iComp1            >= MatchThreshold                                   => iComp1 \n'
			+'              ,le.company_address = ri.company_address and le.cnp_name = ri.cnp_name and ut.nneq(le.active_duns_number,ri.active_duns_number)=> 9000 + iComp1\n'
			+'              ,le.cnp_name = ri.cnp_name and  le.prim_range_derived = ri.prim_range_derived and le.prim_name_derived = ri.prim_name_derived and ut.nneq(le.v_city_name,ri.v_city_name) and le.st = ri.st and le.zip = ri.zip and ut.nneq(le.active_duns_number,ri.active_duns_number)=> 9000 + iComp1\n'
			+'              ,                                                                         iComp1\n'
			+'          );\n'
			+'SELF.Conf := iComp;/*HACKScoreAssignment*/', 'score assignment'),
		('matches', '(iComp := \(cnp_number_score \+)([^;]*?)(\/ 100 \+ outside;)', 'HACKScoreAssignment','import ut;\n'
			+'iComp1 := (cnp_number_score +\g<2>\g<3>\n'
			+'iComp  := map( iComp1            >= MatchThreshold                                   => iComp1 \n'
			+'              ,le.company_address = ri.company_address and le.cnp_name = ri.cnp_name and ut.nneq(le.active_duns_number,ri.active_duns_number)=> MatchThreshold\n'
			+'              ,le.cnp_name = ri.cnp_name and  le.prim_range_derived = ri.prim_range_derived and le.prim_name_derived = ri.prim_name_derived and ut.nneq(le.v_city_name,ri.v_city_name) and le.st = ri.st and le.zip = ri.zip and ut.nneq(le.active_duns_number,ri.active_duns_number)=> MatchThreshold\n'
			+'              ,                                                                         iComp1\n'
			+'          );/*HACKScoreAssignment*/', 'score assignment'),

		('matches', '[+] cnp_name_phonetic_score'     , 'HACKcnp_name_phonetic_score','/*+ cnp_name_phonetic_score*/ /*HACKcnp_name_phonetic_score*/','matches HACKcnp_name_phonetic_score'),
		('Debug'  , '[+] SELF\.cnp_name_phonetic_score', 'HACKcnp_name_phonetic_score','/*+ SELF.cnp_name_phonetic_score*/ /*HACKcnp_name_phonetic_score*/', 'debug HACKcnp_name_phonetic_score')
	]

##---------------------------------------------------------------------------
##dDebug
##Debug hacks
##---------------------------------------------------------------------------
def dDebug():
	return [
		('debug','(SALT311\.StrType   Matching_Attributes := \'\'; \/\/ Keys from attribute files which match)','HACKDebug01','\g<1>\n'
		 	+'	string cnp_name_match_info := \'\';\n'
			+'	string2 left_salt_partition;\n'
			+'  string2 right_salt_partition;\n'
			+'  INTEGER2 salt_partition_score;/*HACKDebug01*/','add partition fields for compareservice'),
		('debug','SELF\.left_cnp_number := le\.cnp_number;','HACKDebug02','SELF.left_salt_partition  := le.salt_partition;\n'
			+'  SELF.right_salt_partition := ri.salt_partition;\n'
			+'  SELF.salt_partition_score := if(le.SALT_Partition = ri.SALT_Partition OR le.SALT_Partition=\'\' OR ri.SALT_Partition = \'\'  ,0,-9999);/*HACKDebug02*/\n'
			+'  SELF.left_cnp_number := le.cnp_number;','set partition fields in match sample join'),
		('debug', 'END;[ \n\t]*SHARED AppendAttribs.*END;[ \n\t]*EXPORT Layout_RolledEntity', 'HACKDebug03','END;\n'
      + 'SHARED AppendAttribs(DATASET(layout_sample_matches) am,DATASET(match_candidates(ih).layout_attribute_matches) ia) := FUNCTION\n'
      + '  Layout_Sample_Matches add_attr(am le, ia ri) := TRANSFORM\n'
      + '    SELF.Attribute_Conf := ri.Conf;\n'
      + '    SELF.Matching_Attributes := ri.Source_Id;\n'
      + '    SELF.Conf := le.Conf + ri.Conf;\n'
      + '  // SELF.support_cnp_name := le.support_cnp_name+ri.support_cnp_name;\n'
      + '  SELF.support_cnp_name := le.support_cnp_name;\n'
      + '    SELF := le;\n'
      + '  END;\n'
      + '  RETURN JOIN(am,ia,LEFT.Proxid1=RIGHT.Proxid1 AND LEFT.Proxid2=RIGHT.Proxid2,add_attr(LEFT,RIGHT),LEFT OUTER,HASH);\n'
      + 'END;\n'
      + '  \n'
      + '/*HACKDebug03*/\n'
      + 'EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data  ,DATASET(match_candidates(ih).layout_matches)  im,DATASET(match_candidates(ih).layout_attribute_matches) ia) := FUNCTION//Faster form when rcid known\n'
      + '\n'
      + '  p0 := project(im,transform(match_candidates(ih).layout_attribute_matches,self := left,self := []));\n'
      + '  j0 := join(p0,ia,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2,transform(match_candidates(ih).layout_attribute_matches,self.support_cnp_name := right.support_cnp_name,self.source_id := right.source_id,self := left,self := []),left outer,hash);\n'
      + '  \n'
      + '  j1 := JOIN(in_data,j0,LEFT.rcid = RIGHT.rcid1,HASH);\n'
      + '  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM\n'
      + '    SELF := le;\n'
      + '  END;\n'
      + '//  output(topn(ia,100,proxid1,proxid2),named(\'ia\'));\n'
      + '//  output(topn(ia,100,proxid2,proxid1),named(\'ia_reverse\'));\n'
      + '//  output(choosen(p0,100),named(\'p0\'));\n'
      + '//  output(choosen(p0(rule = 10000),100),named(\'p0_rule10000\'));\n'
      + '//  output(choosen(j0,100),named(\'j0\'));\n'
      + '//  output(choosen(j0(support_cnp_name > 0),100),named(\'j0_withsupport\'));\n'
      + '  returndataset := JOIN(j1,in_data,LEFT.rcid2 = RIGHT.rcid  ,sample_match_join( PROJECT(LEFT,strim(LEFT)) ,RIGHT,left.rule,,left.support_cnp_name) ,HASH); //-- NEED RULE HERE\n'
      + '//  output(choosen(returndataset(support_cnp_name > 0),100),named(\'returndataset\'));\n'
      + '  \n'
      + '  RETURN returndataset;\n'
      + 'END;\n'
      + '\n'
      + '// -- USED BY THE KEYS ATTRIBUTE TO BUILD THE MATCH SAMPLE KEY\n'
      + 'EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches)  im,dataset(Match_Candidates(ih).layout_attribute_matches) ia) := FUNCTION\n'
      + '  RETURN AppendAttribs( AnnotateMatchesFromRecordData(h,im,ia), ia );\n'
      + 'END;\n'
      + '///////////////\n'
      + '\n'
      + '// -- USED BY SALT_REGRESSION_TESTING.mac_Rollup_Match_Scores TO GET EXAMPLES\n'
      + 'EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im,dataset(Match_Candidates(ih).layout_attribute_matches) ia) := FUNCTION\n'
      + '  j1 := JOIN(in_data,im,LEFT.Proxid = RIGHT.Proxid1,HASH);\n'
      + '  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM\n'
      + '    SELF := le;\n'
      + '  END;\n'

      + '\n'
      + '  r1 := JOIN(j1,in_data,LEFT.Proxid2 = RIGHT.Proxid,transform({unsigned6 proxid1,unsigned6 proxid2,recordof(left) leftrec,recordof(right) rightrec},self.leftrec := left,self.rightrec := right,self := left),HASH);  //new hack\n'
      + '\n'  
      + '  r2 := JOIN(r1,ia,LEFT.Proxid1 = RIGHT.Proxid1 and left.proxid2 = right.proxid2,transform({recordof(left),unsigned rule,unsigned support_cnp_name}\n'
      + '    ,self.rule              := if(right.proxid1 != 0,right.rule,left.leftrec.rule)\n'
      + '    ,self.support_cnp_name  := right.support_cnp_name\n'
      + '    ,self                   := left\n'
      + '  ),HASH,left outer);\n'
      + '\n'
      + '  r := project(distribute(r2),sample_match_join( PROJECT(LEFT.leftrec,strim(LEFT)),left.rightrec,left.rule,,left.support_cnp_name));\n'
      + '  // r := JOIN(r1,ia,LEFT.Proxid1 = RIGHT.Proxid1 and left.proxid2 = right.proxid2,sample_match_join( PROJECT(LEFT.leftrec,strim(LEFT)),left.rightrec,left.leftrec.rule,,right.support_cnp_name),HASH,left outer);\n'
      + '  // d := DEDUP( SORT( r, Proxid1, Proxid2, -Conf, LOCAL ), Proxid1, Proxid2, LOCAL ); // Proxid2 distributed by join\n'
      + '  d := DEDUP( SORT( r, Proxid1, Proxid2, -map(Conf between 30 and 7000 => conf ,conf > 7000  => 29 ,conf - 1), LOCAL ), Proxid1, Proxid2, LOCAL ); // Proxid2 distributed by join\n'
      + '  RETURN AppendAttribs( d, ia );\n'
      + '\n'
      + '  // RETURN AppendAttribs( AnnotateMatchesFromRecordData(in_data,im,ia), ia );\n'
      + 'END;\n'
      + '\n'
      + 'EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT311.UIDType BaseRecord) := FUNCTION//Faster form when rcid known\n'
      + '  j1 := in_data(rcid = BaseRecord);\n'
      + '  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM\n'
      + '    SELF := le;\n'
      + '  END;\n'
      + '  RETURN JOIN(in_data(rcid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);\n'
      + 'END;\n'
       + '\n'
      + 'EXPORT Layout_RolledEntity'
      ,'hack attribute file scores'),
		('debug', '(ds_roll := ROLLUP\( )(.*?;)', 'HACKDebug04',
			'//\g<1>\g<2>\n'
			+'rollup1 :=  ROLLUP( SORT( distribute(infile  ,random()) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACKDebug04*/\n'
			+'rollup2 :=  ROLLUP( SORT( distribute(rollup1 ,random()) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACKDebug04*/\n'
			+'rollup3 :=  ROLLUP( SORT( distribute(rollup2 ,proxid)   , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACKDebug04*/\n'
			+'ds_roll := rollup3; ', 'hack return rollup to eliminate skew errors')
		,('debug'
      ,'EXPORT Layout_RolledEntity.*?END;'
      ,'HACKDebug_Layout_RolledEntity'
			,'EXPORT Layout_RolledEntity /*HACKDebug_Layout_RolledEntity*/:= RECORD,MAXLENGTH(63000)\n'
			+'  SALT311.UIDType Proxid;\n'
			+'  DATASET(SALT311.Layout_FieldValueList) company_name_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) company_address_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) sbfe_id_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) active_domestic_corp_key_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) active_duns_number_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) company_fein_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) hist_enterprise_number_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) ebr_file_number_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) active_enterprise_number_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) hist_domestic_corp_key_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) foreign_corp_key_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) unk_corp_key_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) hist_duns_number_Values := DATASET([],SALT311.Layout_FieldValueList); \n' 
			+'  DATASET(SALT311.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) company_phone_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) company_name_type_derived_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) company_name_type_raw_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) cnp_hasnumber_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) cnp_lowv_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) cnp_translated_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) cnp_classid_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) company_foreign_domestic_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) company_bdid_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) prim_range_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) prim_name_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
			+'  DATASET(SALT311.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
      +'  DATASET(SALT311.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT311.Layout_FieldValueList);\n'
      +'END;\n'
      
      , 'hack Layout_RolledEntity for easier match sample reviews'),

		('debug','(SELF\.cnp_name_phonetic_values :=.*?;)'  ,'HACKDebug remove cnp_name_phonetic_values'  ,'//\g<1>/*HACKDebug remove cnp_name_phonetic_values*/' ,'HACKDebug remove cnp_name_phonetic_values'),
		('debug','SELF\.cnp_name_phonetic_size := SALT311\.Fn_SwitchSpec[(]s\.cnp_name_phonetic_switch,count[(]le[.]cnp_name_phonetic_values[)][)];'  ,'HACKDebug remove cnp_name_phonetic_size'  ,'//SELF.cnp_name_phonetic_size := SALT311.Fn_SwitchSpec(s.cnp_name_phonetic_switch,count(le.cnp_name_phonetic_values));/*HACKDebug remove cnp_name_phonetic_size*/\n'  ,'HACKDebug remove cnp_name_phonetic_size'),

		('debug','UNSIGNED1 cnp_name_phonetic_size := 0;'  ,'HACKDebug remove cnp_name_phonetic_size in layout'  ,'//UNSIGNED1 cnp_name_phonetic_size := 0;/*HACKDebug remove cnp_name_phonetic_size in layout*/\n' ,'HACKDebug remove cnp_name_phonetic_size in layout'),
		('debug','\+t\.cnp_name_phonetic_size'  ,'HACKDebug remove cnp_name_phonetic_size from score add'  ,'/*+t.cnp_name_phonetic_size*//*HACKDebug remove cnp_name_phonetic_size from score add*/' ,'HACKDebug remove cnp_name_phonetic_size from score add')
	]

##---------------------------------------------------------------------------
##dMatches
##matches
##---------------------------------------------------------------------------
def dMatches():
	return [
		('matches','n = 0 => \':cnp_number:st:prim_range_derived\',\'AttributeFile:\'\+\(STRING\)\(n-10000\)\);'  ,'HACKMatches01', '   n = 0 => \':cnp_number:st:prim_range_derived\'\n'
            + '  ,n = 101 => \':cnp_number:prim_range_derived:cnp_name:st:pname_digits\'      /* HACKMatches01 */\n'
            + '  ,n = 102 => \':cnp_number:prim_range_derived:prim_name_derived:st:cnp_name[1..4]\'     /* HACKMatches01 */\n'
            + '  ,n = 103 => \':prim_range_derived:prim_name_derived:st:sec_range\'         /* HACKMatches01 */\n'
            + '  ,n = 104 => \':cnp_number:prim_range_derived:v_city_name:st:pname_digits:cnp_name_raw[1..4]\'	/* HACKMatches01 */\n'
            + '  ,n = 105 => \':cnp_number:prim_range_derived:zip:st:pname_digits:cnp_name_raw[1..4]\'        /* HACKMatches01 */\n'
            + '  ,n = 106 => \':cnp_number:cnp_name:company_address\'   /* HACKMatches01 */\n'
            + '  ,\'AttributeFile:\'+(STRING)(n-10000)\n'
            + '  );\n','Hack Adding Rules for extra mjs'),
		('matches', 'LEFT\.cnp_number = RIGHT\.cnp_number'  ,'HACKMatches02'  ,'LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_name_derived = RIGHT.prim_name_derived/*HACKMatches02*/' ,'Hack adding prim_name_derived equality condition to mj0'),
		('matches', ',trans\(LEFT,RIGHT,0\)'  ,'HACKMatches03'  ,'/*HACKMatches03*/ AND ~(( left.cnp_name = right.cnp_name ) AND ( left.company_address = right.company_address )),trans(LEFT,RIGHT,0)' ,'Hack removing perfect cnp name, address matches from mj0'),
		('matches','AllAttrMatches := SORT\(MOD_Attr_SrcRidVlid\(ih\)\.Match\+MOD_Attr_ForeignCorpkey\(ih\)\.Match\+MOD_Attr_RAAddresses\(ih\)\.Match\+MOD_Attr_FilterPrimNames\(ih\)\.Match\+MOD_Attr_UnderLinks\(ih\)\.Match,Proxid1','HACKMatches04','AllAttrMatches := SORT(Mod_Attr_SrcRidVlid(ih).Match+MOD_Attr_UnderLinks(ih).Match/*HACKMatches04*/ /* +Mod_Attr_ForeignCorpkey(ih).Match+Mod_Attr_RAAddresses(ih).Match+Mod_Attr_FilterPrimNames(ih).Match*/,Proxid1','only use srcridvlid att matches for speedup'),
		('matches','(SALT311\.mac_avoid_transitives\(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o\);)'  ,'HACKMatches05','// \g<1> /*HACKMatches05 - disable default salt mac_avoid_transitives*/\n'
            + 'import BIPV2_Tools;\n /*HACKMatches05, import module for new transitives macro*/\n'
            + 'o := BIPV2_ProxID.mac_avoid_transitives_scalene(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,MatchThreshold,10); // HACKMatches05 - Use new transitives macro, bucket size 5*/\n','Hack replacing transitives macro'),
		('matches','(Patch)(lgid3|orgid|ultid|dotid)( := SALT311)(.*?$)'  ,'HACKMatches06', '\g<1>\g<2> := BIPV2_Tools\g<4>/*HACKMatches06*/','replacing parentid and childid patch call'),
		('matches','SALT311\.MAC_Reassign_UID\(ihbp,Cleave\(ih\)\.patch_file,Proxid,rcid,ih1\);'  ,'HACKMatches07a','SALT311.MAC_Reassign_UID(ihbp,Cleave(ih).patch_file,Proxid,rcid,ihbp01/*HACKMatches07a*/);','github 3140 issue'),
		('matches','SALT311\.MAC_SliceOut_ByRID\(ih1,rcid,Proxid,ToSlice,rcid,sliced0\);'  ,'HACKMatches07b','SALT311.MAC_SliceOut_ByRID(ihbp01/*HACKMatches07b*/,rcid,Proxid,ToSlice,rcid,sliced0);','github 3140 issue'),
		('matches','sliced := IF\( Config\.DoSliceouts, sliced0, ih1\)'  ,'HACKMatches07c','sliced := IF( Config.DoSliceouts, sliced0, ihbp01/*HACKMatches07c*/)','github 3140 issue'),
		('matches','attr_match := JOIN\(DISTRIBUTE\(j1,HASH\(Proxid1\)\),hd,LEFT\.Proxid1 = RIGHT\.Proxid AND \( LEFT\.SALT_Partition = RIGHT\.SALT_Partition OR LEFT\.SALT_Partition=\'\' OR RIGHT\.SALT_Partition = \'\' \).*?,LOCAL\);'  ,'HACKMatches08'  		
    , 'attr_match := JOIN(DISTRIBUTE(j1,HASH(Proxid1)),hd,LEFT.Proxid1 = RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition=\'\' OR RIGHT.SALT_Partition = \'\' )\n'                    
	+ 'AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_name_derived = RIGHT.prim_name_derived/*HACKMatches02*/\n'
    + 'AND LEFT.st = RIGHT.st\n'
    + 'AND LEFT.prim_range_derived = RIGHT.prim_range_derived\n'
    + 'AND ( ~left.st_isnull AND ~right.st_isnull )\n'
    + 'AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull )\n'
    + 'AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull )\n'
    + 'AND (( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) OR LEFT.support_cnp_name > 0 or (left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) OR ( ~left.active_duns_number_isnull AND ~right.active_duns_number_isnull ) OR ( ~left.company_fein_isnull AND ~right.company_fein_isnull ))\n'
    + 'AND ( ~left.prim_name_derived_isnull AND ~right.prim_name_derived_isnull ) AND (~left.company_address_isnull AND ~right.company_address_isnull )\n'		     
                      + ',match_join( RIGHT,PROJECT(LEFT,strim(LEFT)),LEFT.Rule, LEFT.Conf,LEFT.support_cnp_name)\n'
                      + ',ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_name_derived = RIGHT.prim_name_derived\n'
                      + '      AND LEFT.st = RIGHT.st\n'
                      + '      AND LEFT.prim_range_derived = RIGHT.prim_range_derived,1000)\n'
                      + '      ,LOCAL); \n'

     ,'BH-578 -- add hack to proxid to speed up attribute matches')
	 ]

	
##---------------------------------------------------------------------------
##Keys
##Key hacks
##---------------------------------------------------------------------------
def dKeys():
	return [
		('Keys','^.*$' ,'HACKKeys', 'EXPORT Keys(DATASET(layout_DOT_Base) ih = dataset([],layout_DOT_Base),string liter = \'qa\' ,boolean pUseOtherEnvironment = false) := MODULE\n'
    		+ 'SHARED s := Specificities(ih).Specificities;\n'
    		+ 'SHARED mtch := debug(ih ,s[1]).AnnotateMatches(matches(ih).PossibleMatches,matches(ih).All_Attribute_Matches);\n'
    		+ 'prop_file := match_candidates(ih).candidates; // Use propogated file\n'
			+ 'EXPORT Candidates         := INDEX(prop_file,{Proxid},{prop_file},keynames(liter,pUseOtherEnvironment).match_candidates_debug.logical);\n'
			+ 'ms_temp := sort(mtch,Conf,Proxid1,Proxid2,SKEW(1.0)); // Some headers have very skewed IDs\n'
			+ 'EXPORT MatchSample        := INDEX(ms_temp,{Conf,Proxid1,Proxid2},{ms_temp},keynames(liter,pUseOtherEnvironment).match_sample_debug.logical,SORT KEYED);\n'
			+ 's_prep := s;\n'

    		+ 'EXPORT Specificities_Key  := INDEX(s_prep,{1},{s_prep},keynames(liter,pUseOtherEnvironment).specificities_debug.logical);\n'
    		+ 'am := matches(ih).All_Attribute_Matches;\n'
    		+ 'EXPORT Attribute_Matches  := INDEX(am,{Proxid1,Proxid2},{am},keynames(liter,pUseOtherEnvironment).attribute_matches.logical);\n'
    		+ 'prop_file := matches(ih).Patched_Candidates; // Available for External ADL2\n'
    		+ 'EXPORT PatchedCandidates  := INDEX(prop_file,{Proxid},{prop_file},keynames(liter,pUseOtherEnvironment).patched_candidates.logical);\n'
    		+ 'EXPORT InData             := INDEX(ih,{Proxid},{ih},keynames(liter,pUseOtherEnvironment).in_data.logical);\n'
    		+ '\n'
    		+ '// Create logic to manage the match history key\n'
    		+ '//EXPORT MatchHistoryName := \'~keep::BIPV2_ProxID::Proxid::MatchHistory\';\n'
    		+ '//EXPORT MatchHistoryFile := DATASET(MatchHistoryName,Matches(In_DOT_Base).id_shift_r,THOR); // Read in all the change history\n'
    		+ '//EXPORT MatchHistoryKeyName := \'~\'+\'key::BIPV2_ProxID::Proxid::History::Match\';\n'
    		+ '//  MH := MatchHistoryFile;\n'
    		+ '//EXPORT MatchHistoryKey := INDEX(MH,{Proxid_after},{MH},MatchHistoryKeyName);\n'
    		+ '// Build enough to support the data services such as cleave/best\n'
    		+ '// EXPORT InDataKeyName := \'~\'+\'key::BIPV2_ProxID::Proxid::Datafile::in_data\';\n'
    		+ '// EXPORT InData := INDEX(ih,{Proxid},{ih},InDataKeyName);\n'
    		+ '// SHARED Build_InData := BUILDINDEX(InData, OVERWRITE);\n'
    		+ '// EXPORT BuildData := PARALLEL(Build_Specificities_Key,Build_InData);\n'
    		+ '// Build enough to support the debug services such as the compare service\n'
    		+ 'EXPORT BuildDebug := PARALLEL(BUILDINDEX(Candidates,keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,keynames(liter).specificities_debug.logical,FEW,OVERWRITE),BUILDINDEX(Attribute_Matches,keynames(liter).attribute_matches.logical,OVERWRITE));\n'
    		+ '// Build Everything\n'
    		+ 'EXPORT BuildAll := PARALLEL(BUILDINDEX(Candidates,keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(MatchSample,keynames(liter).match_sample_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,keynames(liter).specificities_debug.logical,FEW,OVERWRITE)/*,BUILDINDEX(PatchedCandidates,keynames(liter).patched_candidates.logical,OVERWRITE)*/,BUILDINDEX(Attribute_Matches,keynames(liter).attribute_matches.logical,OVERWRITE)/*,BUILDINDEX(InData,keynames(liter).in_data.logical,OVERWRITE)*/);\n'
    		+ 'END;/*HACKKeys*/\n','Hack keys to build them with dates embedded.')	
	]

##---------------------------------------------------------------------------
##ds_ModAttrForeignCorpKey
##ModAttrForeignCorpKey hacks
##---------------------------------------------------------------------------
def dModAttrForeignCorpKey():
	return [
		('MOD_Attr_ForeignCorpkey','^.*$'  ,'HACK'  ,'// Logic to handle the matching around ForeignCorpkey\n'
    		+ ' \n'
      		+ 'IMPORT SALT311,ut,std;\n'
      		+ 'EXPORT MOD_Attr_ForeignCorpkey(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 36) := MODULE\n'
      		+ '\n'
      		+ '// Construct a function to filter matches to those that obey the force criteria on this attribute file.\n'
      		+ 'EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO\n'
      		+ '// Every attribute value must match to a value in the other attribute IF they have the same context\n'
      		+ '//  Cands0 := BIPV2_ProxID.match_candidates(inhead).ForeignCorpkey_candidates;\n'
      		+ '  Cands0 := BIPV2_ProxID.file_Foreign_Corpkey;/*HACK*/\n'
      		+ '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side\n'
      		+ 'childrec1 := \n'
      		+ 'record\n'
      		+ '    SALT311.StrType Basis    := Cands0.company_charter_number;/*HACK to get basis only*/\n'
      		+ '    SALT311.StrType Context  := Cands0.company_inc_state; // Context for the basis (\'<\')\n'
      		+ 'end;\n'
      		+ '\n'
      		+ '  ChildRec := RECORD\n'
      		+ '    Cands0.Proxid;\n'
      		+ '//    Cands0.Basis_Weight100;/*hack*/\n'
      		+ '    // SALT311.StrType Basis    := SALT311.GetNthWord(Cands0.Basis,1,\'|\');/*HACK to get basis only*/\n'
      		+ '    // SALT311.StrType Context  := SALT311.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
      		+ '    dataset(childrec1) childs := dataset([{Cands0.company_charter_number,Cands0.company_inc_state}],childrec1);\n'
      		+ '  END;\n'
     		+ '  Cands  := TABLE(Cands0,ChildRec);\n'
      		+ '  Cands1 := rollup(sort(Cands                     ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      		+ '  Cands2 := rollup(sort(distribute(Cands1,proxid) ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      		+ '\n'
      		+ '  layslimmtch := {unsigned6 id1,unsigned6 id2};\n'
      		+ '  tslim := table(infile,{id1,id2},id1,id2,merge);\n'
      		+ '  PossRec := RECORD\n'
      		+ '    tslim;\n'
      		+ '    DATASET(ChildRec1) Kids1 := DATASET([],ChildRec1);\n'
      		+ '//    DATASET(ChildRec1) Kids2 := DATASET([],ChildRec1);\n'
      		+ '    boolean   shouldFilterOut := false;\n'
      		+ '  END;\n'
      		+ '//  T  := TABLE(tslim,PossRec); // Allow for addition of children\n'
      		+ '  D1 := JOIN(Tslim ,Cands2,LEFT.id1 = RIGHT.Proxid,TRANSFORM(PossRec, SELF.Kids1 := RIGHT.childs, SELF := LEFT), HASH);\n'
      		+ '  D2 := JOIN(D1    ,Cands2,LEFT.id2 = RIGHT.Proxid,TRANSFORM(PossRec/*, SELF.Kids2 := RIGHT.childs*/\n'
      		+ '    ,self.shouldFilterOut := if(count(table(left.kids1 + RIGHT.childs,{context},context,few))  <  count(table(left.kids1 + RIGHT.childs,{context,basis},context,basis,few)),true,skip) \n'
      		+ '    ,SELF := LEFT), HASH);\n'
      		+ '  d2_table := project(d2,layslimmtch);\n'
      		+ '  \n'
      		+ '  D2_tokeep := join(infile,d2_table,left.id1 = right.id1 and left.id2 = right.id2,transform(left),left only,hash);\n'
      		+ '  RETURN D2_tokeep;\n'
      		+ '\n'
      		+ 'ENDMACRO;\n'
      		+ '\n'
      		+ '\n'
      		+ 'SHARED Cands := dataset([],recordof(match_candidates(ih).ForeignCorpkey_candidates));\n'
      		+ 'SHARED s := Specificities(ih).Specificities[1];\n'
      		+ ' \n'
      		+ '// Generate match candidates based upon this attribute file\n'
      		+ ' \n'
      		+ 'match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri,UNSIGNED cnp_name_support = 0) := TRANSFORM\n'
      		+ '  SELF.rule := 10001; // Signify Attribute File #1\n'
      		+ '  SELF.Proxid1 := le.Proxid;\n'
      		+ '  SELF.Proxid2 := ri.Proxid;\n'
      		+ '  SELF.source_id := le.Basis;\n'
      		+ '  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,\n'
     		+ '                        SALT311.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));\n'
      		+ '  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,\n'
      		+ '                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,\n'
      		+ '                        SALT311.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));\n'
      		+ '  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,\n'
      		+ '                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,\n'
      		+ '                        SALT311.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));\n'
      		+ '  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,\n'
      		+ '                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,\n'
      		+ '                        SALT311.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));\n'
      		+ '  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= 0, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= 0, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= 0, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= 0, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  SELF.Conf_Prop := (cnp_number_score + active_enterprise_number_score + active_domestic_corp_key_score + active_duns_number_score) / 100; // Score based on forced fields\n'
      		+ '  SELF.Conf := ri.Basis_weight100 *  1.00/100;\n'
      		+ 'end;\n'
      		+ 'Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.Proxid > RIGHT.Proxid,Score(LEFT,RIGHT)),Proxid1+Proxid2);\n'
      		+ ' \n'
      		+ 'EXPORT Match := DEDUP( SORT(Matches0,Proxid1,Proxid2,-(Conf+Conf_Prop+support_cnp_name),Source_Id,LOCAL),Proxid1,Proxid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match\n'
      		+ 'END;\n','Hack foreign corpkey to prevent skew and performance errors.')
	]

##---------------------------------------------------------------------------
##ds_MODAttrRAAddresses
##MOD_Attr_RAAddresses hacks
##---------------------------------------------------------------------------
def dMODAttrRAAddresses():
	return [
		('MOD_Attr_RAAddresses','^.*$'  ,'HACK'  ,  '// Logic to handle the matching around RAAddresses\n'
      		+ ' \n'
      		+ 'IMPORT SALT311,ut,std;\n'
      		+ 'EXPORT MOD_Attr_RAAddresses(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 36) := MODULE\n'
      		+ '// Construct a function to filter matches to those that obey the force criteria on this attribute file.\n'
      		+ 'EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO\n'
      		+ '// Every attribute value has to exactly match every attribute value of the corresponding identifier or both have no values\n'
      		+ '  Cands0 := BIPV2_ProxID.file_RA_Addresses;/*HACK*/\n'
      		+ '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side\n'
      		+ '////\n'
      		+ 'childrec1 := \n'
      		+ 'record\n'
      		+ '    SALT311.StrType Basis    := Cands0.cname;/*HACK to get basis only*/\n'
      		+ 'end;\n'
      		+ '\n'
      		+ '  ChildRec := RECORD\n'
      		+ '    Cands0.Proxid;\n'
      		+ '//    Cands0.Basis_Weight100;/*hack*/\n'
      		+ '    // SALT311.StrType Basis    := SALT311.GetNthWord(Cands0.Basis,1,\'|\');/*HACK to get basis only*/\n'
      		+ '    // SALT311.StrType Context  := SALT311.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
      		+ '    dataset(childrec1) childs := dataset([{Cands0.cname}],childrec1);\n'
      		+ '  END;\n'
      		+ '  Cands  := TABLE(Cands0,ChildRec);\n'
      		+ '  Cands1 := rollup(sort(Cands                     ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      		+ '  Cands2 := rollup(sort(distribute(Cands1,proxid) ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      		+ '\n'
      		+ '  layslimmtch := {unsigned6 id1,unsigned6 id2};\n'
      		+ '  tslim := table(infile,{id1,id2},id1,id2,merge);\n'
      		+ '  PossRec := RECORD\n'
      		+ '    tslim;\n'
      		+ '    DATASET(ChildRec1) Kids1 := DATASET([],ChildRec1);\n'
      		+ '//    DATASET(ChildRec1) Kids2 := DATASET([],ChildRec1);\n'
      		+ '    boolean   shouldFilterOut := false;\n'
      		+ '  END;\n'
      		+ '//  T  := TABLE(tslim,PossRec); // Allow for addition of children\n'
      		+ '  D1 := JOIN(Tslim ,Cands2,LEFT.id1 = RIGHT.Proxid,TRANSFORM(PossRec, SELF.Kids1 := RIGHT.childs, SELF := LEFT), HASH);\n'
      		+ '  D2 := JOIN(D1    ,Cands2,LEFT.id2 = RIGHT.Proxid,TRANSFORM(PossRec/* SELF.Kids2 := RIGHT.childs*/\n'
      		+ '    ,self.shouldFilterOut := if(count(table(left.kids1 + RIGHT.childs,{basis},basis,few))  <  count(left.kids1 + RIGHT.childs),skip,true) //if have one or more cnp_names in common, that is ok.  if not, filter out that potential match\n'
      		+ '    ,SELF := LEFT), HASH);\n'
      		+ '  d2_table := project(d2,layslimmtch);\n'
      		+ '  \n'
      		+ '  D2_tokeep := join(infile,d2_table,left.id1 = right.id1 and left.id2 = right.id2,transform(left),left only,hash);\n'
      		+ '\n'
      		+ '  RETURN D2_tokeep;\n'
      		+ '\n'
      		+ 'ENDMACRO;\n'
      		+ '\n'
      		+ 'SHARED Cands := dataset([],recordof(match_candidates(ih).RAAddresses_candidates));\n'
      		+ 'SHARED s := Specificities(ih).Specificities[1];\n'
      		+ ' \n'
      		+ '// Generate match candidates based upon this attribute file\n'
      		+ ' \n'
      		+ 'match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri,UNSIGNED cnp_name_support = 0) := TRANSFORM\n'
      		+ '  SELF.rule := 10002; // Signify Attribute File #2\n'
      		+ '  SELF.Proxid1 := le.Proxid;\n'
      		+ '  SELF.Proxid2 := ri.Proxid;\n'
      		+ '  SELF.source_id := le.Basis;\n'
      		+ '  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,\n'
      		+ '                        SALT311.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));\n'
      		+ '  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,\n'
      		+ '                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,\n'
      		+ '                        SALT311.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));\n'
      		+ '  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,\n'
      		+ '                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,\n'
      		+ '                        SALT311.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));\n'
      		+ '  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,\n'
      		+ '                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,\n'
      		+ '                        SALT311.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));\n'
      		+ '  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= 0, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= 0, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= 0, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= 0, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  SELF.Conf_Prop := (cnp_number_score + active_enterprise_number_score + active_domestic_corp_key_score + active_duns_number_score) / 100; // Score based on forced fields\n'
      		+ '  SELF.Conf := ri.Basis_weight100 *  1.00/100;\n'
      		+ 'end;\n'
      		+ 'Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.Proxid > RIGHT.Proxid,Score(LEFT,RIGHT)),Proxid1+Proxid2);\n'
      		+ ' \n'
      		+ 'EXPORT Match := DEDUP( SORT(Matches0,Proxid1,Proxid2,-(Conf+Conf_Prop+support_cnp_name),Source_Id,LOCAL),Proxid1,Proxid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match\n'
      		+ 'END;\n','Hack RA addresses to prevent skew and performance errors.')
	]	
	
##---------------------------------------------------------------------------
##ds_MODAttrFilterPrimNames
##MOD_Attr_FilterPrimNames
##---------------------------------------------------------------------------
def dMODAttrFilterPrimNames():
	return [
		('MOD_Attr_FilterPrimNames','^.*$' ,'HACK','// Logic to handle the matching around FilterPrimNames\n'
      		+ ' \n'
      		+ 'IMPORT SALT311,ut,std;\n'
      		+ 'EXPORT MOD_Attr_FilterPrimNames(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 30) := MODULE\n'
      		+ '// Construct a function to filter matches to those that obey the force criteria on this attribute file.\n'
      		+ 'EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO\n'
      		+ '// Every attribute value has to exactly match every attribute value of the corresponding identifier or both have no values\n'
      		+ '  Cands0 := BIPV2_ProxID.file_filter_Prim_names;/*HACK*/\n'
      		+ '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side\n'
      		+ '////\n'
      		+ 'childrec1 := \n'
      		+ 'record\n'
      		+ '    SALT311.StrType Basis    ;/*HACK to get basis only*/\n'
      		+ 'end;\n'
      		+ '  ChildRec := RECORD\n'
      		+ '    Cands0.Proxid;\n'
      		+ '//    Cands0.Basis_Weight100;/*hack*/\n'
      		+ '    // SALT311.StrType Basis    := SALT311.GetNthWord(Cands0.Basis,1,\'|\');/*HACK to get basis only*/\n'
      		+ '    // SALT311.StrType Context  := SALT311.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
      		+ '    dataset(childrec1) childs := dataset([{Cands0.pname_digits}],childrec1);\n'
      		+ '  END;\n'
      		+ '  Cands  := TABLE(Cands0,ChildRec);\n'
      		+ '  Cands1 := rollup(sort(Cands                     ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      		+ '  Cands2 := rollup(sort(distribute(Cands1,proxid) ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      		+ '  layslimmtch := {unsigned6 id1,unsigned6 id2};\n'
      		+ '  tslim := table(infile,{id1,id2},id1,id2,merge);\n'
      		+ '  PossRec := RECORD\n'
      		+ '    tslim;\n'
      		+ '    DATASET(ChildRec1) Kids1 := DATASET([],ChildRec1);\n'
      		+ '//    DATASET(ChildRec1) Kids2 := DATASET([],ChildRec1);\n'
      		+ '    boolean   shouldFilterOut := false;\n'
      		+ '  END;\n'
      		+ '//  T  := TABLE(tslim,PossRec); // Allow for addition of children\n'
      		+ '  D1 := JOIN(Tslim ,Cands2,LEFT.id1 = RIGHT.Proxid,TRANSFORM(PossRec, SELF.Kids1 := RIGHT.childs, SELF := LEFT), HASH);\n'
      		+ '  D2 := JOIN(D1    ,Cands2,LEFT.id2 = RIGHT.Proxid,TRANSFORM(PossRec/* SELF.Kids2 := RIGHT.childs*/\n'
      		+ '    ,self.shouldFilterOut := if(count(table(left.kids1 + RIGHT.childs,{basis},basis,few)) = 1 and count(left.kids1) = 1 and count(RIGHT.childs) = 1,skip,true) //if have one or more cnp_names in common, that is ok.  if not, filter out that potential match\n'
      		+ '    ,SELF := LEFT), HASH);\n'
      		+ '  d2_table := project(d2,layslimmtch);\n'
      		+ '  \n'
      		+ '  D2_tokeep := join(infile,d2_table,left.id1 = right.id1 and left.id2 = right.id2,transform(left),left only,hash);\n'
      		+ '  RETURN D2_tokeep;\n'
      		+ 'ENDMACRO;\n'
      		+ '\n'
      		+ 'SHARED Cands := dataset([],recordof(match_candidates(ih).FilterPrimNames_candidates));\n'
      		+ 'SHARED s := Specificities(ih).Specificities[1];\n'
      		+ ' \n'
      		+ '// Generate match candidates based upon this attribute file\n'
      		+ ' \n'
      		+ 'match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri,UNSIGNED cnp_name_support = 0) := TRANSFORM\n'
      		+ '  SELF.rule := 10003; // Signify Attribute File #3\n'
      		+ '  SELF.Proxid1 := le.Proxid;\n'
      		+ '  SELF.Proxid2 := ri.Proxid;\n'
      		+ '  SELF.source_id := le.Basis;\n'
      		+ '  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,\n'
      		+ '                        SALT311.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));\n'
      		+ '  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,\n'
      		+ '                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,\n'
      		+ '                        SALT311.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));\n'
      		+ '  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,\n'
      		+ '                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,\n'
      		+ '                        SALT311.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));\n'
      		+ '  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,\n'
      		+ '                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,\n'
      		+ '                        SALT311.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));\n'
      		+ '  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= Config.active_duns_number_Force * 100, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= Config.active_domestic_corp_key_Force * 100, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter\n'
      		+ '  SELF.Conf_Prop := (cnp_number_score + active_duns_number_score + active_enterprise_number_score + active_domestic_corp_key_score) / 100; // Score based on forced fields\n'
      		+ '  SELF.Conf := ri.Basis_weight100 *  1.00/100;\n'
      		+ 'end;\n'
      		+ 'Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.Proxid > RIGHT.Proxid,Score(LEFT,RIGHT)),Proxid1+Proxid2);\n'
      		+ ' \n'
      		+ 'EXPORT Match := DEDUP( SORT(Matches0,Proxid1,Proxid2,-(Conf+Conf_Prop+support_cnp_name),Source_Id,LOCAL),Proxid1,Proxid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match\n'
      		+ 'END;\n'
      		+ '\n','Hack filter prim names att file to prevent skew and performance errors.')
	]	

##---------------------------------------------------------------------------
##dBasicMatch
##BasicMatch hacks
##---------------------------------------------------------------------------
def dBasicMatch():
	return [
		('BasicMatch','h01.*?sort.*?((,(.*?)),Proxid)[)].*?Match\s*:=\s*JOIN[(]h02,','HACKBasicMatch01'
    		,'h01 := table     (h00_match ,{\g<3>,unsigned6 Proxid := min(group,Proxid)}\n'
			+'                             \g<2>,merge);/*HACKBasicMatch01 TO SPEED UP*/\n'
			+'Match := JOIN(h01,'
      		,'fix dedup skew in basic match'),
		('BasicMatch','SHARED PickOne := DEDUP\( SORT\( DISTRIBUTE\( Match,HASH\(Proxid1\) \), Proxid1, Proxid2, LOCAL\), Proxid1, LOCAL\);','HACKBasicMatch02', 'SHARED PickOne := table( Match  ,{Proxid1  ,unsigned6 Proxid2 := min(group,Proxid2)}, Proxid1, merge);/*HACKBasicMatch02*/','speed up pickone'),
		('BasicMatch','(AND LEFT\.company_csz = RIGHT\.company_csz AND LEFT\.company_addr1 = RIGHT\.company_addr1\s*AND LEFT\.company_address = RIGHT\.company_address)','HACKBasicMatch03', '/*HACKBasicMatch03*/ /*\g<1>*/','comment out the code')
	]	

##---------------------------------------------------------------------------
##ProxidCompareService
##ProxidCompareService hacks
##---------------------------------------------------------------------------
def dCompareService():
	return [
		('ProxidCompareService','^.*$'  ,'HACKCompareService'  ,  '/*HACKCompareService*/\n'
	  		+ '/*--SOAP--\n'
      		+ '<message name="ProxidCompareService">\n'
      		+ '<part name="ProxidOne" type="xsd:string"/>\n'
      		+ '<part name="ProxidTwo" type="xsd:string"/>\n'
      		+ '</message>\n'
      		+ '*/\n'
      		+ '/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/\n'
      		+ 'EXPORT ProxidCompareService := MACRO\n'
      		+ 'IMPORT SALT24,BIPV2_ProxID,ut,tools;\n'
      		+ 'STRING50 Proxidonestr := \'1234\'  : STORED(\'ProxidOne\');\n'
      		+ 'STRING20 Proxidtwostr := \'12345\'  : STORED(\'Proxidtwo\');\n'
      		+ 'combo := \'qa\';\n'
      		+ '\n'
      		+ 'BIPV2_ProxID._fun_CompareService((unsigned6)Proxidonestr,(unsigned6)Proxidtwostr,combo);\n'
      		+ 'ENDMACRO;\n'
      		+ '\n','Hack ProxidCompareService to call the function.')
	]

##---------------------------------------------------------------------------
##dProcIterate
##Proc_Iterate
##---------------------------------------------------------------------------
def dProcIterate():
	return [
		('Proc_Iterate','STRING iter'                       ,'HACKProcIterate01' ,'STRING iter,string keyversion/*HACKProcIterate01 -- add keyversion*/'            ,'add keyversion to parameters'          ),
    	('Proc_Iterate','Keys\(InFile\)\.BuildAll;'         ,'HACKProcIterate02' ,'Keys(InFile,keyversion).BuildAll; // HACKProcIterate02 keys to add keyersion'    ,'add keyversion parameter to keys call' ),
    	('Proc_Iterate','changes_it\'\+iter;'               ,'HACKProcIterate03' ,'changes_it\'+keyversion;/* HACKProcIterate03 use keyversion for changes file*/'  ,'change to keyversion for changes file' ),
    	('Proc_Iterate','CHOOSEN\(MM\.MatchSampleRecords,10000\)' ,'HACKProcIterate04'  ,'CHOOSEN(MM.MatchSampleRecords,1000)/* HACKProcIterate04 lower match sample records output*/'  ,'lower match sample records output' )
	]


##---------------------------------------------------------------------------
##ds_MatchCandidates
##match_candidates hacks
##---------------------------------------------------------------------------
def dMatchCandidates():
	return [
      ('match_candidates','SHARED Annotated :='  ,'HACK make annotated an export'  ,'export Annotated :=/*HACK make annotated an export*/' ,'HACK make annotated an export')
	
		]

##---------------------------------------------------------------------------
##dLinkBlockers
##LinkBlockers hacks
##---------------------------------------------------------------------------
def dLinkBlockers():
	return [
		  ('LinkBlockers','AND \(LEFT\.cnp_name_phonetic = RIGHT\.cnp_name_phonetic OR RIGHT\.cnp_name_phonetic = \(TYPEOF\(RIGHT\.cnp_name_phonetic\)\)\'\'\)'  ,'HACK cnp_name_phonetic not needed'  ,'// AND (LEFT.cnp_name_phonetic = RIGHT.cnp_name_phonetic OR RIGHT.cnp_name_phonetic = (TYPEOF(RIGHT.cnp_name_phonetic))\'\')/*HACK cnp_name_phonetic not needed*/' ,'HACK cnp_name_phonetic not needed'),
      ('LinkBlockers','AND \(LEFT\.sbfe_id = RIGHT\.sbfe_id OR RIGHT\.sbfe_id = \(TYPEOF\(RIGHT\.sbfe_id\)\)\'\'\)'  ,'HACK sbfe_id not needed'  ,'// AND (LEFT.sbfe_id = RIGHT.sbfe_id OR RIGHT.sbfe_id = (TYPEOF(RIGHT.sbfe_id))\'\')/*HACK sbfe_id not needed*/' ,'HACK sbfe_id not needed')
	
		]

##---------------------------------------------------------------------------
##dDebug_remove_phonetic
##Debug remove phonetic score hacks
##---------------------------------------------------------------------------
def dDebug_remove_phonetic():
	return [
		  ('Debug','(SELF[.]cnp_name_phonetic_Values := [^\n]*?)\n'  ,'HACKDebug remove cnp_name_phonetic_values'  ,'//$1/*HACKDebug remove cnp_name_phonetic_values*/\n' ,'HACKDebug remove cnp_name_phonetic_values'),
      ('Debug','SELF[.]cnp_name_phonetic_size := SALT311[.]Fn_SwitchSpec[(]s[.]cnp_name_phonetic_switch,count[(]le[.]cnp_name_phonetic_values[)][)];'  ,'HACKDebug remove cnp_name_phonetic_size'  ,'//SELF.cnp_name_phonetic_size := SALT311.Fn_SwitchSpec(s.cnp_name_phonetic_switch,count(le.cnp_name_phonetic_values));/*HACKDebug remove cnp_name_phonetic_size*/\n' ,'HACKDebug remove cnp_name_phonetic_size' ),
      ('Debug','UNSIGNED1 cnp_name_phonetic_size := 0;'  ,'HACKDebug remove cnp_name_phonetic_size in layout'  ,'//UNSIGNED1 cnp_name_phonetic_size := 0;/*HACKDebug remove cnp_name_phonetic_size in layout*/\n' ,'HACKDebug remove cnp_name_phonetic_size in layout')
	
		]

getHacks = 	dCompanyNameScore() + \
			dPrimNameExactMatch() + \
			dCompanyNumberEquality() + \
			dScoreAssignment() + \
			dDebug() + \
			dMatches() + \
			dKeys() + \
			dModAttrForeignCorpKey() + \
			dMODAttrRAAddresses() + \
			dMODAttrFilterPrimNames() + \
			dBasicMatch()+ \
			dCompareService() + \
			dProcIterate() + \
			dMatchCandidates() + \
			dLinkBlockers()
