##---------------------------------------------------------------------------
##dMatches
##Matches hacks
##---------------------------------------------------------------------------
def dMatches():
	return [
		('matches','(n = 0 => \':company_inc_state\',\'AttributeFile:\'\+\(STRING\)\(n-10000\)\);)','HACKMatches01','n = 0 => \':company_inc_state\'\n'
			+',n = 100 => \':duns_number\'/*HACKMatches01*/\n'
			+',n = 101 => \':company_fein\'/*HACKMatches01*/\n'
			+',\'AttributeFile:\'+(STRING)(n-10000));/*HACKMatches01*/\n','add rules for extra mjs'),
		('matches','(SALT311\.mac_avoid_transitives\(All_Matches,LGID31,LGID32,Conf,DateOverlap,Rule,o\);)','HACKMatches02', '// \g<1> /*HACKMatches02 - disable default salt mac_avoid_transitives*/\n'
      		+ 'import BIPV2_Tools; /*HACKMatches02 - import for new transitives macro*/\n'
      		+ 'BIPV2_Tools.mac_avoid_transitives(All_Matches,LGID31,LGID32,Conf,DateOverlap,Rule,o); // HACKMatches02 - Use new transitives macro*/\n','replace transitives macro'),
		('matches','(SALT311\.MAC_)(ParentId|ChildId)(_Patch)','HACKMatches03','/*HACKMatches03*/BIPV2_Tools.MAC_\g<2>\g<3>','replace SALT311.MAC_ParentId_Patch and SALT311.MAC_ChildId_Patch with BIPV2_Tools.MAC_ParentId_Patch')
	]	
	
##---------------------------------------------------------------------------
##BasicMatch
##Basic Match hacks
##---------------------------------------------------------------------------
def dBasicMatch():
	return [
		('BasicMatch','(\/\/ It is important.*?EXPORT basic_match_count := COUNT\(NotBlocked\);)'  ,'HACKBasicMatch'  ,  '/* \g<1> */\n'
      		+ '// HACKBasicMatch - disable BasicMatch altogether\n'
      		+ 'EXPORT patch_file := dataset([],Rec);\n'
      		+ 'EXPORT input_file := h00_match;\n'
      		+ 'EXPORT basic_match_count := 0;\n','disable basic match altogether\n')
	]

##---------------------------------------------------------------------------
##Proc_Iterate
##hacks
##---------------------------------------------------------------------------
def dProcIterate():
	return [
		('Proc_Iterate','SHARED ChangeName := \'~temp::LGID3::SALT_Reg_BIP_LGID3_new1::changes_it\'\+iter;'  ,'HACKProcIterate01'  ,
			'/*HACKProcIterate01*/import bipv2;\n'
        + 'SHARED ChangeName := \'~temp::LGID3::SALT_Reg_BIP_LGID3_new1::changes_it\'+iter+\'_\'+ bipv2.KeySuffix;','add keysuffix to changes filename\n'),
		('Proc_Iterate','(dsBMSF := CHOOSEN\(BM\.Block, 1000\)\;)'  ,'HACKProcIterate02'  ,
			'/*HACKProcIterate02*/ // \g<1>','comment out the code'),
		('Proc_Iterate','(BMSF := OUTPUT\(dsBMSF, NAMED \(\'BasicMatch_Block\'\)\);)'  ,'HACKProcIterate03'  ,
			'/*HACKProcIterate03*/ // \g<1>','comment out the code'),
		('Proc_Iterate','(EXPORT OutputExtraSamples := PARALLEL\(OMatchSamples, OBSamples, OAS, BMS, Thr, OMSD, BMSF\);)'  ,'HACKProcIterate04'  ,
			'/*HACKProcIterate04*/ // \g<1>','comment out the code')
	]

##---------------------------------------------------------------------------
##dmatch_candidates
##match_candidates
##---------------------------------------------------------------------------
def dMatchCandidates():
	return [
		('match_candidates','(,HINT\(parallel_match\))'  ,'HACKmatch_candidates00' ,'/*\g<1>*//*HACKmatch_candidates00 to prevent memory limit exceeded error*/','remove hint(parallel_match)'),
	    ('match_candidates','(SHARED UnderLinks_prop7 := JOIN\(UnderLinks_prop6,company_inc_state_props,left\.LGID3=right\.LGID3,LOCAL\);)','HACKmatch_candidates01', 
			'/*HACKmatch_candidates01*/ SHARED UnderLinks_prop7 := JOIN(UnderLinks_prop6,company_inc_state_props,left.LGID3=right.LGID3,LEFT OUTER, LOCAL);','Add Left Outer'),
	    ('match_candidates','(SHARED UnderLinks_pp := TABLE)(.*?;)', 'HACKmatch_candidates02', 
			'/*HACKmatch_candidates02*/ SHARED UnderLinks_pp := TABLE(UnderLinks_prp,Layout_UnderLinks_Candidates)((~company_inc_state_isnull OR ~active_duns_number_isnull OR ~duns_number_isnull OR ~(active_duns_number_isnull AND duns_number_isnull) OR ~company_fein_isnull OR ~sbfe_id_isnull));',
			'active_duns_number_isnull in place of active_duns_concept_isnull')
		]

##---------------------------------------------------------------------------
##MOD_Attr_UnderLinks
##hacks
##---------------------------------------------------------------------------
def dMOD_Attr_UnderLinks():
	return [
	    ('MOD_Attr_UnderLinks', '(INTEGER2 company_inc_state_score := IF \( company_inc_state_score_temp > Config\.company_inc_state_Force \* 100 OR active_duns_number_score > Config\.company_inc_state_OR1_active_duns_number_Force\*100 OR duns_number_score > Config\.company_inc_state_OR2_duns_number_Force\*100 OR duns_number_concept_score > Config\.company_inc_state_OR3_duns_number_concept_Force\*100 OR company_fein_score > Config\.company_inc_state_OR4_company_fein_Force\*100 OR sbfe_id_score > Config\.company_inc_state_OR5_sbfe_id_Force\*100, company_inc_state_score_temp, SKIP \); \/\/ Enforce FORCE parameter)',
		'HACKMOD_Attr_UnderLinks01',
		' /*HACKMOD_Attr_UnderLinks01*/ INTEGER2 company_inc_state_score := IF ( company_inc_state_score_temp > Config.company_inc_state_Force * 100 OR ( company_fein_score > Config.company_inc_state_OR4_company_fein_Force*100) OR ( sbfe_id_score > Config.company_inc_state_OR5_sbfe_id_Force*100), company_inc_state_score_temp,0);',
		'Remove missing parameters and skip'), 
	    ('MOD_Attr_UnderLinks','(INTEGER2 Lgid3IfHrchy_score := IF \( Lgid3IfHrchy_score_temp >= Config\.Lgid3IfHrchy_Force \* 100, Lgid3IfHrchy_score_temp, SKIP \); \/\/ Enforce FORCE parameter)',
		'HACKMOD_Attr_UnderLinks02',' /*HACKMOD_Attr_UnderLinks02*/ INTEGER2 Lgid3IfHrchy_score := IF ( Lgid3IfHrchy_score_temp >= Config.Lgid3IfHrchy_Force * 100, Lgid3IfHrchy_score_temp,0);',
		'Remove skip'), 
	    ('MOD_Attr_UnderLinks','(INTEGER2 cnp_number_score := IF \( cnp_number_score_temp >= Config\.cnp_number_Force \* 100 OR sbfe_id_score > Config\.cnp_number_OR1_sbfe_id_Force\*100, cnp_number_score_temp, SKIP \); \/\/ Enforce FORCE parameter)',
		'HACKMOD_Attr_UnderLinks03',
		' /*HACKMOD_Attr_UnderLinks03*/ INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100 OR ( sbfe_id_score > Config.cnp_number_OR1_sbfe_id_Force*100), cnp_number_score_temp,0);', 
		'Remove skip'), 
	    ('MOD_Attr_UnderLinks','(SELF\.Conf := ri\.Basis_weight100\/100;)',
		'HACKMOD_Attr_UnderLinks04', ' /*HACKMOD_Attr_UnderLinks04*/ SELF.Conf := Config.MatchThreshold+1;',
		'Remove skip' 
		)
	]

##---------------------------------------------------------------------------
##Keys
##hacks
##---------------------------------------------------------------------------
def dKeys():
	return [
	    ('Keys', 
		 '(EXPORT Keys\(DATASET\(layout_LGID3\) ih\) := MODULE\)',
		'HACKMOD_Keys01',
		'/*HACKMOD_Keys01*/ EXPORT Keys(DATASET(layout_LGID3) ih) := INLINE MODULE',
		'Add INLINE Directive for Roxie Support')
	]

	
##---------------------------------------------------------------------------
##Config
##hacks
##---------------------------------------------------------------------------
def dConfig():
	return [
		('Config','(DoSliceouts := TRUE)'  ,'HACKConfig_01'  ,'DoSliceouts := false/*HACKConfig_01*/','turn off sliceouts'),
		('Config','(EXPORT PersistExpire := 30;)'  ,'HACKConfig_02'  ,'EXPORT PersistExpire := 7;/*HACKConfig*/','adjust persist expire date')
	]
	
getHacks = 	dMatches() + \
			dBasicMatch() + \
			dProcIterate() + \
			dMatchCandidates() + \
			dMOD_Attr_UnderLinks() + \
			dConfig() + \
			dKeys

