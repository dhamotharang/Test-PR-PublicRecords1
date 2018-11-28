IMPORT tools, wk_ut;
EXPORT _ApplyHacks(
	STRING pModule = 'BIPV2_LGID3',
	string pESP = wk_ut._Constants.LocalEsp + ':8145'
	)
:=MODULE
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Matches&Debug both
EXPORT ds_matches := DATASET([
						{pModule,'matches','(n = 0 =>.*?)(,\'AttributeFile:\'[+][(]STRING[)][(]n-10000[)][)];)','HACKMatches01','$1\n'
      		+ ',n = 100 => \':duns_number\'/*HACKMatches01*/\n'
      		+ ',n = 101 => \':company_fein\'/*HACKMatches01*/\n'
      		+ '$2/*HACKMatches01*/\n','add rules for extra mjs'},
						{pModule,'matches','SALT311.mac_avoid_transitives[(]All_Matches,LGID31,LGID32,Conf,DateOverlap,Rule,o[)];','HACKMatches02', '// $1 /*HACKMatches02 - disable default salt mac_avoid_transitives*/\n'
      		+ 'import BIPV2_Tools; /*HACKMatches02 - import for new transitives macro*/\n'
      		+ 'BIPV2_Tools.mac_avoid_transitives(All_Matches,LGID31,LGID32,Conf,DateOverlap,Rule,o); // HACKMatches02 - Use new transitives macro*/\n','replace transitives macro'},
					{pModule,'matches','(SALT311.MAC_)(ParentId|ChildId)(_Patch)','HACKMatches03','/*HACKMatches03*/BIPV2_Tools.MAC_$2$3','replace SALT311.MAC_ParentId_Patch and SALT311.MAC_ChildId_Patch with BIPV2_Tools.MAC_ParentId_Patch'}
			],tools.layout_attribute_hacks2);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//BasicMatch 
EXPORT ds_BasicMatch :=   DATASET([
    {  pModule
      ,'BasicMatch','(// It is important.*?EXPORT basic_match_count := COUNT[(]NotBlocked[)];)'  ,'HACKBasicMatch'  ,  '/* $1 */\n'
      		+ '// HACKBasicMatch - disable BasicMatch altogether\n'
      		+ 'EXPORT patch_file := dataset([],Rec);\n'
      		+ 'EXPORT input_file := h00_match;\n'
      		+ 'EXPORT basic_match_count := 0;\n','disable basic match altogether\n'
    }
  ],Tools.layout_attribute_hacks2);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Proc_Iterate
EXPORT ds_ProcIterate :=   DATASET([
			{pModule,'Proc_Iterate','SHARED ChangeName := \'[~]temp::LGID3::BIPV2_LGID3::changes_it\'[+]iter;'  ,'HACKProcIterate01'  ,
			'/*HACKProcIterate01*/import bipv2;\n'
        + 'SHARED ChangeName := \'~temp::LGID3::BIPV2_LGID3::changes_it\'+iter+\'_\'+ bipv2.KeySuffix;',
      	'add keysuffix to changes filename\n'},
			{pModule,'Proc_Iterate','(dsBMSF := CHOOSEN[(]BM.Block, 1000[)];)'  ,'HACKProcIterate02'  ,
			'/*HACKProcIterate02*/ //$1',
      	'comment out the code'},
			{pModule,'Proc_Iterate','(BMSF := OUTPUT[(]dsBMSF, NAMED [(]\'BasicMatch_Block\'[)][)];)'  ,'HACKProcIterate03'  ,
			'/*HACKProcIterate03*/ //$1',
      	'comment out the code'},
			{pModule,'Proc_Iterate','(EXPORT OutputExtraSamples := PARALLEL[(]OMatchSamples, OBSamples, OAS, BMS, Thr, OMSD, BMSF[)];)'  ,'HACKProcIterate04'  ,
			'/*HACKProcIterate03*/ //$1',
      	'comment out the code'}
  ],Tools.layout_attribute_hacks2);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//match_candidates
EXPORT ds_MatchCandidates  :=  DATASET([
      {pModule,'match_candidates','(,HINT[(]parallel_match[)])'  ,'HACKmatch_candidates00' ,'/*$1*//*HACKmatch_candidates00 to prevent memory limit exceeded error*/','remove hint(parallel_match)'},
	    {pModule,'match_candidates','(SHARED UnderLinks_prop7 := JOIN\\(UnderLinks_prop6,company_inc_state_props,left.LGID3=right.LGID3,LOCAL\\);)',
				'HACKmatch_candidates01', 
				'/*HACKmatch_candidates01*/ SHARED UnderLinks_prop7 := JOIN(UnderLinks_prop6,company_inc_state_props,left.LGID3=right.LGID3,LEFT OUTER, LOCAL);',
				'Add Left Outer'},
	    {pModule,'match_candidates','(SHARED UnderLinks_pp := TABLE)(.*?;)',
				'HACKmatch_candidates02', 
				'/*HACKmatch_candidates02*/ SHARED UnderLinks_pp := TABLE(UnderLinks_prp,Layout_UnderLinks_Candidates)((~company_inc_state_isnull OR ~active_duns_number_isnull OR ~duns_number_isnull OR ~(active_duns_number_isnull AND duns_number_isnull) OR ~company_fein_isnull OR ~sbfe_id_isnull));',
				'active_duns_number_isnull in place of active_duns_concept_isnull'}
		],Tools.layout_attribute_hacks2);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Config
EXPORT ds_Config  :=  DATASET([
       {pModule,'Config','DoSliceouts := TRUE'  ,'HACKConfig'  ,'DoSliceouts := false/*HACKConfig*/','turn off sliceouts'}
  ],Tools.layout_attribute_hacks2);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//MOD_Attr_UnderLinks hacks
EXPORT ds_MOD_Attr_UnderLinks  :=  DATASET([
	    {pModule,'MOD_Attr_UnderLinks', 
		'(INTEGER2 company_inc_state_score := IF \\( company_inc_state_score_temp > Config.company_inc_state_Force \\* 100 OR active_duns_number_score > Config.company_inc_state_OR1_active_duns_number_Force\\*100 OR duns_number_score > Config.company_inc_state_OR2_duns_number_Force\\*100 OR duns_number_concept_score > Config.company_inc_state_OR3_duns_number_concept_Force\\*100 OR company_fein_score > Config.company_inc_state_OR4_company_fein_Force\\*100 OR sbfe_id_score > Config.company_inc_state_OR5_sbfe_id_Force\\*100, company_inc_state_score_temp, SKIP \\); // Enforce FORCE parameter)',
		'HACKMOD_Attr_UnderLinks01',
		' /*HACKMOD_Attr_UnderLinks01*/ INTEGER2 company_inc_state_score := IF ( company_inc_state_score_temp > Config.company_inc_state_Force * 100 OR ( company_fein_score > Config.company_inc_state_OR4_company_fein_Force*100) OR ( sbfe_id_score > Config.company_inc_state_OR5_sbfe_id_Force*100), company_inc_state_score_temp,0);',
		'Remove missing parameters and skip'}, 
	    {pModule,'MOD_Attr_UnderLinks',
		'(INTEGER2 Lgid3IfHrchy_score := IF \\( Lgid3IfHrchy_score_temp >= Config.Lgid3IfHrchy_Force \\* 100, Lgid3IfHrchy_score_temp, SKIP \\); // Enforce FORCE parameter)',
		'HACKMOD_Attr_UnderLinks02',
		' /*HACKMOD_Attr_UnderLinks02*/ INTEGER2 Lgid3IfHrchy_score := IF ( Lgid3IfHrchy_score_temp >= Config.Lgid3IfHrchy_Force * 100, Lgid3IfHrchy_score_temp,0);',
		'Remove skip'}, 
	    {pModule,'MOD_Attr_UnderLinks',
		'(INTEGER2 cnp_number_score := IF \\( cnp_number_score_temp >= Config.cnp_number_Force \\* 100 OR sbfe_id_score > Config.cnp_number_OR1_sbfe_id_Force\\*100, cnp_number_score_temp, SKIP \\); // Enforce FORCE parameter)',
		'HACKMOD_Attr_UnderLinks03',
		' /*HACKMOD_Attr_UnderLinks03*/ INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100 OR ( sbfe_id_score > Config.cnp_number_OR1_sbfe_id_Force*100), cnp_number_score_temp,0);', 
		'Remove skip'}, 
	    {pModule,'MOD_Attr_UnderLinks',
		'(SELF.Conf := ri.Basis_weight100/100;)',
		'HACKMOD_Attr_UnderLinks04', 
		' /*HACKMOD_Attr_UnderLinks04*/ SELF.Conf := Config.MatchThreshold+1;',
		'Remove skip' 
		}
  ],Tools.layout_attribute_hacks2);
	
/*-------------------------------Hack Action-------------------------------------------*/
EXPORT aHack(DATASET(Tools.Layout_attribute_hacks2) d,bSaveIt=TRUE):=Tools.HackAttribute2(d,bSaveIt,pESP).saveit;

EXPORT dAll := 
ds_Matches+
ds_BasicMatch+
ds_ProcIterate+
ds_config+
ds_MatchCandidates+
ds_MOD_Attr_UnderLinks;

EXPORT aHackIt := aHack(dAll);
END;
