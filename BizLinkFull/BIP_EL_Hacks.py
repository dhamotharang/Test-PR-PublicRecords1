##---------------------------------------------------------------------------
##HACK03
##Additional condition on force-failed to apply a FORCE(+3) on thor appends
##only, leaving search without the FORCE.  This is because the force
##helps with thor batch precision, but we want to be looser with roxie
##search.
##---------------------------------------------------------------------------
def dAppendForce(): 
	return [
		('Process_Biz_Layouts','(combine_scores.+SELF.ForceFailed :=[^;]+)\);','HACK03','\g<1>/*HACK03*/ OR SELF.cnp_nameWeight < 4);','Additional FORCE for Append')
	]

##---------------------------------------------------------------------------
##HACK07
##Update all attributes with key declarations so that they get their file
##names from the filename_keys attribute rather than being hard-coded.  This
##is so we have a uniform naming convention and all of the key names in
##one place.
#---------------------------------------------------------------------------
def dUpdateKeynames():
	return [
		('Key_BizHead_L_ADDRESS1',     '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_ADDRESS2',     '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_ADDRESS3',     '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_CNPNAME',      '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_CNPNAME_FUZZY','(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_CNPNAME_ST',   '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_CNPNAME_ZIP',  '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_CONTACT',      '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_CONTACT_DID',  '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_CONTACT_SSN',  '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_EMAIL',        '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_FEIN',         '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_PHONE',        '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_SIC',          '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_SOURCE',       '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		('Key_BizHead_L_URL',          '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.\g<2>; /*HACK07*/','Standardize key name'),
		#('Key_BizHead_',               '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07Refs','\g<1> '+'BizLinkFull'+'.Filename_keys.Refs; /*HACK07Refs*/','Standardize key name'),
		#('Key_BizHead_',               '(EXPORT ValueKeyName :=)[^;]+:([^:\';]+)\';','HACK07Words','\g<1> '+'BizLinkFull'+'.Filename_keys.Words; /*HACK07Words*/','Standardize key name'),
		('Process_Biz_Layouts',        '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07meow','\g<1> '+'BizLinkFull'+'.Filename_keys.meow; /*HACK07meow*/','Standardize key name'),
		('Process_Biz_Layouts',        '(EXPORT KeyproxidUpName :=)[^;]+:([^:\';]+)\';','HACK07sup_proxid','\g<1> '+'BizLinkFull'+'.Filename_keys.sup_proxid; /*HACK07sup_proxid*/','Standardize key name'),
		('Process_Biz_Layouts',        '(EXPORT KeyseleidUpName :=)[^;]+:([^:\';]+)\';','HACK07sup_seleid','\g<1> '+'BizLinkFull'+'.Filename_keys.sup_seleid; /*HACK07sup_seleid*/','Standardize key name'),
		('Process_Biz_Layouts',        '(EXPORT KeyorgidUpName :=)[^;]+:([^:\';]+)\';','HACK07sup_orgid','\g<1> '+'BizLinkFull'+'.Filename_keys.sup_orgid; /*HACK07sup_orgid*/','Standardize key name'),
		('Process_Biz_Layouts',        '(EXPORT KeyIDHistoryName :=)[^;]+:([^:\';]+)\';','HACK07sup_rcid','\g<1> '+'BizLinkFull'+'.Filename_keys.sup_rcid; /*HACK07sup_rcid*/','Standardize key name'),
		('specificities',              '(EXPORT cnp_nameValuesKeyName :=)[^;]+:([^:\';]+)\';','HACK07cnp_name','\g<1> '+'BizLinkFull'+'.Filename_keys.cnp_name; /*HACK07cnp_name*/','Standardize key name'),
		('specificities',              '(EXPORT company_urlValuesKeyName :=)[^;]+:([^:\';]+)\';','HACK07company_url','\g<1> '+'BizLinkFull'+'.Filename_keys.company_url; /*HACK07company_url*/','Standardize key name'),
		('Wheel',                      '(EXPORT KeyName_city_clean :=)[^;]+:([^:\';]+)\';','HACK07Wheel_city_clean','\g<1> '+'BizLinkFull'+'.Filename_keys.Wheel_city_clean; /*HACK07Wheel_city_clean*/','Standardize key name'),
		('Wheel',                      '(EXPORT KeyNameQuick_city_clean :=)[^;]+:([^:\';]+)\';','HACK07Wheel_Quick_city_clean','\g<1> '+'BizLinkFull'+'.Filename_keys.Wheel_Quick_city_clean; /*HACK07Wheel_Quick_city_clean*/','Standardize key name'),
		('Mod_Ext_Data',               '(EXPORT [Key]*([A-Z,a-z,_,0-9]+)Name :=) \'.*?;','HACK07','\g<1> '+'BizLinkFull'+'.Filename_keys.Ext_\g<2>; /*HACK07*/','Standardize key name')
	]

##---------------------------------------------------------------------------
##HACK08
##Loosen up the scoring on cnp_name in the address linkpaths to add extra
##emphasis on the cnp_name weight.
##---------------------------------------------------------------------------
def dAdjustCNPScore():
	return [
		('Key_BizHead_L_ADDRESS1','(EXPORT RawFetch[^;]+MatchBagOfWords[^)]+[)])','HACK08','\g<1>+400/*HACK08*/','Loosen cnp_name score in address linkpaths'),
		('Key_BizHead_L_ADDRESS2','(EXPORT RawFetch[^;]+MatchBagOfWords[^)]+[)])','HACK08','\g<1>+400/*HACK08*/','Loosen cnp_name score in address linkpaths'),
		('Key_BizHead_L_ADDRESS3','(EXPORT RawFetch[^;]+MatchBagOfWords[^)]+[)])','HACK08','\g<1>+400/*HACK08*/','Loosen cnp_name score in address linkpaths'),
		('Mod_Ext_Data','(EXPORT RawFetchL_ADDRESS1[^;]+MatchBagOfWords[^)]+[)])','HACK08_a','\g<1>+400/*HACK08_a*/','Loosen cnp_name score in address linkpaths'),
		('Mod_Ext_Data','(EXPORT RawFetchL_ADDRESS2[^;]+MatchBagOfWords[^)]+[)])','HACK08_b','\g<1>+400/*HACK08_b*/','Loosen cnp_name score in address linkpaths'),
		('Mod_Ext_Data','(EXPORT RawFetchL_ADDRESS3[^;]+MatchBagOfWords[^)]+[)])','HACK08_c','\g<1>+400/*HACK08_c*/','Loosen cnp_name score in address linkpaths')
	]

##---------------------------------------------------------------------------
##HACK09
##Remove the forcefailed filter on search.  We like roxie search to give
##extra stuff even if that means including items that would otherwise fail
##because of a force.  Thor batch appends are not effected.
##This hack wasn't applied in SALT 3.7 upgrade, so stayed out of 3.11
##---------------------------------------------------------------------------
def dMEOWBizNoForce():
	return [
		('MEOW_Biz'	,'([(][^)]*ForceFailed[^)]*[)])','HACK09','/*HACK09 \g<1>*/','Remove ForceFailed in MEOW_Biz')
	]

##---------------------------------------------------------------------------
##HACK11
##Remove the ONFAIL for L_CNPNAME_FUZZY so that keys_failed is not reported
##on that linkpath.  CNPNAME_FUZZY is sort of a way to pick up some extra
##finds using a looser match on cnp_name.  So if the user gets good results
##with any of the other cnp_name linkpaths, we don't want to confuse things
##by indicating a key_fail on the FUZZY one.  So we do NOT tell them when
##this occurs.
##This hack wasn't applied in SALT 3.7 upgrade, so stayed out of 3.11
##---------------------------------------------------------------------------
def dFuzzyNoFail():
	return [
		('Key_BizHead_L_CNPNAME_FUZZY'	,'ONFAIL[^;]+,KEYED','HACK11','/*HACK11 ONFAIL removed*/ SKIP,KEYED','Remove ONFAIL for fuzzy results'),
		('Mod_Ext_Data'	,'(RawFetchL_CNPNAME_FUZZY[^;]+)(ONFAIL[^;]+,KEYED)','HACK11','\g<1>/*HACK11 ONFAIL removed*/ SKIP,KEYED','Remove ONFAIL for fuzzy results')
	]

##---------------------------------------------------------------------------
##HACK14
##Modify the CNPNAME_ZIP so that the specificity threshold of wds is raised
##as more zips are added to zip_cases.  Normally, wds is a simple hard-coded
##threshold.  But in the case of CNPNAME_ZIP, the weight of the zip code
##found will vary depending on how far out from the center of the zip radius
##that zip is.  In this case, we want to vary wds based on how many zip
##codes we are trying to search on so that we can accout for this fluctuation
##---------------------------------------------------------------------------
def dZipThreshold():
	return [
		('Key_BizHead_L_CNPNAME_ZIP','(IF[(]SUM[(]wds,spec[)] > )([^,]+)([^;]+)','HACK14','IF(COUNT(param_zip)>600,DATASET([],indexOutputRecord),\g<1>(\g<2>+(LOG(COUNT(param_zip))/LOG(2)))\g<3>)/*HACK14*/','Make wds threshold variable for zip key'),
		('Mod_Ext_Data','(EXPORT RawFetchL_CNPNAME_ZIP.*?)(IF[(]SUM[(]wds,spec[)] > )([^,]+)([^;]+)','HACK14','\g<1>IF(COUNT(param_zip)>600,DATASET([],indexOutputRecord),\g<2>(\g<3>+(LOG(COUNT(param_zip))/LOG(2)))\g<4>)/*HACK14*/','Make wds threshold variable for zip key')
	]
	

##---------------------------------------------------------------------------
##HACK15
##Drop the size of the payload key so no single proxid has more than 9999
##rows.  This is so we don't get any "More than 10,000 rows" errors in our
##key fetch, but also to reduce the size of the key to improve performance.
##Part of this hack is to remove from the key any fields that significantly
##increase the number of unique rows (e.g. the AID fields).
##---------------------------------------------------------------------------
def dPayloadRestriction():
	return [
		('Process_Biz_Layouts','(EXPORT Key :=[^(]+[(])[^,]+(,[^}]+[}],[{])[^}]+','HACK15','/*HACK15  Removing aid fields and cnp_nameid field from base file before building the key.\n         also not including rcid, vl_id, and source_record_id in the sort/dedup\n         which preserves those values for singletons (which we need) and leaves those\n         values as arbitrary where we dont care about them.  */\n' + 'import bipv2;\n' + '  s01:=DEDUP(SORT(h(BIPV2.mod_sources.srcInBase(source)),EXCEPT rcid,vl_id,source_record_id),EXCEPT rcid,vl_id,source_record_id);\n/* HACK  Now taking the post-collapsed key data and truncating the few remaining proxids\n         that have more than 9999 records */  \n  s:=DEDUP(SORT(s01,proxid,rcid),proxid,KEEP(9999));\n\g<1>s\g<2>s','Reduce size of clusters in the payload')
	]

##---------------------------------------------------------------------------
##HACK16
##Modify search so that zip specificity is not taken into account when
##calculating zip weight.  This is so if we have more than one result at
##different radii from the center the difference in weight of the two zip
##codes returned does NOT bump up the total weight of the row which can 
##cause ordering issues if the company name of the outer zip has a higher
##weight than the one with the inner zip.  The value being used in this hack
##is basically the average specificity of all of the zips in the corpus.
##---------------------------------------------------------------------------
def dZipSpecificity():
	return [
		('Key_BizHead_L_ADDRESS1',     '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_ADDRESS2',     '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_ADDRESS3',     '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CNPNAME',      '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CNPNAME_FUZZY','(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CNPNAME_ST',   '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CNPNAME_ZIP',  '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CONTACT',      '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CONTACT_SSN',  '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_EMAIL',        '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_FEIN',         '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_PHONE',        '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_SIC',          '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_SOURCE',       '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_URL',          '(SELF.zipWeight :=.*SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Mod_Ext_Data',               '(SELF.zipWeight :=.*?SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>)([^*]+)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100','Disregard zip specificity when calculating weight')
		]

##---------------------------------------------------------------------------
##HACK20
##Filter out no rcid records or failed attemps.
##---------------------------------------------------------------------------
def dRemoveRcid():
	return [
		('MEOW_Biz','(EXPORT Data_[^;]+[)]);','HACK20','\g<1>(rcid>0 OR KeysFailed<>0); /*HACK20 KeysFailed added*/','Filter out rcids or failed attempts'),
		('Mod_Ext_Data','(EXPORT Data_[^;]+[)]);','HACK20','\g<1>(rcid>0 OR KeysFailed<>0); /*HACK20 KeysFailed added*/','Filter out rcids or failed attempts')
	]

##---------------------------------------------------------------------------
##HACK21
##Remove parallel match hints from joins
##---------------------------------------------------------------------------
def dRemoveParallel():
	return [
		('match_candidates','(,HINT[(]parallel_match[)])','HACK21','/*HACK21 \g<1>*/','Remove the parallel match hints from joins')
	]

##---------------------------------------------------------------------------
##HACK22
##Cnp_NameWeight using GSS word weight can be inflated, use MatchBagOfWords instead
##---------------------------------------------------------------------------
def dGSSCnpNameWeight():
	return [
		('Key_BizHead_L_CNPNAME',      '(SELF\.cnp_nameWeight \:\= le\.gss_word_weight\; \/\/Fixed Wordbag weights accumulated in gss_weight field)','HACK22_a','SELF.cnp_nameWeight := SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)/100; /*HACK22_a*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Key_BizHead_L_CNPNAME',      '(SELF\.cnp_name_GSS_Weight := le\.gss_word_weight\;\/\/ MORE \- need to scale in independence)','HACK22_b','SELF.cnp_name_GSS_Weight := SELF.cnp_nameWeight; /*HACK22_b*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Key_BizHead_L_CNPNAME_ST',      '(SELF\.cnp_nameWeight \:\= le\.gss_word_weight\; \/\/Fixed Wordbag weights accumulated in gss_weight field)','HACK22_a','SELF.cnp_nameWeight := SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)/100; /*HACK22_a*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Key_BizHead_L_CNPNAME_ST',      '(SELF\.cnp_name_GSS_Weight := le\.gss_word_weight\;\/\/ MORE \- need to scale in independence)','HACK22_b','SELF.cnp_name_GSS_Weight := SELF.cnp_nameWeight; /*HACK22_b*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Key_BizHead_L_CNPNAME_ZIP',      '(SELF\.cnp_nameWeight \:\= le\.gss_word_weight\; \/\/Fixed Wordbag weights accumulated in gss_weight field)','HACK22_a','SELF.cnp_nameWeight := SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)/100; /*HACK22_a*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Key_BizHead_L_CNPNAME_ZIP',      '(SELF\.cnp_name_GSS_Weight := le\.gss_word_weight\;\/\/ MORE \- need to scale in independence)','HACK22_b','SELF.cnp_name_GSS_Weight := SELF.cnp_nameWeight; /*HACK22_b*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Mod_Ext_Data',      '(SELF\.cnp_nameWeight \:\= le\.gss_word_weight\; \/\/Fixed Wordbag weights accumulated in gss_weight field)','HACK22_a','SELF.cnp_nameWeight := SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)/100; /*HACK22_a*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Mod_Ext_Data',      '(SELF\.cnp_name_GSS_Weight := le\.gss_word_weight\;\/\/ MORE \- need to scale in independence)','HACK22_b','SELF.cnp_name_GSS_Weight := SELF.cnp_nameWeight; /*HACK22_b*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight')
		]

##---------------------------------------------------------------------------
##HACK23
##Turns DisableForce on for External File Linking when we call BizLinkFull.Config_BIP.MAC_MEOW_Biz_Batch_Wrapper. Also turns on DoClean option - ZRS 3/22/2019
##---------------------------------------------------------------------------
def dExtFileDisableForceOn():
	return [
			('Mod_Ext_Data', 'ofi,false,,,,,false\);','HACK23','ofi,false,,,,true,true); /*HACK23*/','Turns DisableForce on for External File Linking')
		]

##---------------------------------------------------------------------------
##HACK24
##Remove RCID join condition in Fetch_Stream. RCID is not a keyed field and seems 
##to be causing KEEP to behave unexpectedly, resulting in an error when more 10000 
##records are returned. Similar code will be kept in Mod_Ext_Data since it is needed
##for external files - JA 20190511
##---------------------------------------------------------------------------
def dRemoveRcidJoinCondition():
	return [
			('Process_Biz_Layouts', ' AND \(LEFT\.rcid \= 0 AND LEFT\.proxid\<\>0 OR LEFT\.rcid \= RIGHT\.rcid\)','HACK24','/*HACK24*/','Remove RCID join condition in Fetch_Stream')
		]
		
##---------------------------------------------------------------------------
##HACK25
##Add CNPNAME_SLIM logic to Key_BizHead_L_CNPNAME. New key to speed up 
##company name searches
##---------------------------------------------------------------------------
def dCnpNameOptimizations():
	return [
			('Key_BizHead_L_CNPNAME', '(HACK07\*\/)', 'HACK25a', '\g<1>\nEXPORT SlimKeyName := BizLinkFull.Filename_keys.L_CNPNAME_SLIM; /*HACK25a*/', 'Added Slim Index Logic'),
			('Key_BizHead_L_CNPNAME', '(EXPORT Key := INDEX.*?;)','HACK25b','\g<1>\n\nEXPORT slimIndLay := {unsigned4 gss_hash, unsigned8 gss_bloom, h.fallback_value, h.ultid, h.orgid, h.seleid, h.proxid, unsigned2 gss_word_weight := 0}; /*HACK25b*/','Added Slim Index Logic'),
			('Key_BizHead_L_CNPNAME', '(HACK25b\*\/)','HACK25c','\g<1>\nSlimKeyData := dedup(project(DataForKey, slimIndLay), record, all); /*HACK25c*/','Added Slim Index Logic'),
			('Key_BizHead_L_CNPNAME', '(HACK25c\*\/)','HACK25d','\g<1>\nEXPORT SlimKey := INDEX(SlimKeyData,{SlimKeyData},{},SlimKeyName); /*HACK25d*/','Added Slim Index Logic'),
			('Key_BizHead_L_CNPNAME', '(HACK25d\*\/)','HACK25e','\g<1>\nSHARED SlimKeyRec := recordof(SlimKey); /*HACK25e*/','Added Slim Index Logic'),
			('Key_BizHead_L_CNPNAME', '(doIndexRead\(UNSIGNED4 search,UNSIGNED2 spc\) :=) .*?;','HACK25f','''\g<1> STEPPED(LIMIT(SlimKey( KEYED(GSS_hash = search) // ADDED LIMIT
                                                                      AND KEYED(GSS_Bloom = BloomF)
                                                                      AND Keyed(fallback_value >= param_fallback_value)
                                                                      
                                                                  ),
                                                                  Config_BIP.L_CNPNAME_MAXBLOCKLIMIT,
                                                                  ONFAIL(TRANSFORM(SlimKeyRec, 
                                                                                   SELF := ROW([],SlimKeyRec))),
                                                                  keyed),
                                                           ultid,
                                                           orgid,
                                                           seleid,
                                                           proxid,
                                                           PRIORITY(40-spc)); /*HACK25f*/''','Change the index lookup code for Roxie'),
			('Key_BizHead_L_CNPNAME', '(res := JOIN\(.*?steppedmatches, Key,).*?;','HACK25g','''\g<1>
                KEYED(RIGHT.GSS_Hash = wds[1].hsh) 
                AND KEYED(RIGHT.fallback_value >= param_fallback_value) 
                AND KEYED(LEFT.proxid = RIGHT.proxid 
                      AND LEFT.seleid = RIGHT.seleid 
                      AND LEFT.orgid = RIGHT.orgid 
                      AND LEFT.ultid = RIGHT.ultid)
                AND ((param_prim_name = (TYPEOF(RIGHT.prim_name))'' 
                  OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'') 
                  OR (RIGHT.prim_name = param_prim_name) 
                  OR ((Config_BIP.WithinEditN(RIGHT.prim_name,RIGHT.prim_name_len,param_prim_name,param_prim_name_len,1, 0))))
                AND ((param_city = (TYPEOF(RIGHT.city))'' 
                  OR RIGHT.city = (TYPEOF(RIGHT.city))'') 
                  OR (RIGHT.city = param_city) 
                  OR ( (metaphonelib.DMetaPhone1(RIGHT.city)=metaphonelib.DMetaPhone1(param_city))  
                  OR (Config_BIP.WithinEditN(RIGHT.city,RIGHT.city_len,param_city,param_city_len,2, 0)))),
                TRANSFORM(indexOutputRecord,
                          SELF.gss_word_weight := LEFT.gss_word_weight,
                          SELF := RIGHT),
                LIMIT(Config_BIP.L_CNPNAME_MAXBLOCKLIMIT,
                      SKIP,
                      TRANSFORM(indexOutputRecord, 
                                SELF := ROW([],indexOutputRecord)))); /*HACK25g*/''','Change the join in rawfetch_server code for Roxie'),
			('Key_BizHead_L_CNPNAME', '(Returnable(.*?))<>.( OR.*?;)','HACK25h','\g<1>>1\g<3> /*HACK25h*/','Change fallback logic to actually work'),
		]		
		
##---------------------------------------------------------------------------
##HACK26
##Change layout of CNPNAME_FUZZY to move the fallback_value up to second
##from the top. This helps cut back on seeks against the index.
##---------------------------------------------------------------------------		
def dCnpNameFuzzyFallbackValueChanges():
	return [
		('Key_BizHead_L_CNPNAME_FUZZY', 'h.fallback_value; // Populate the fallback field', 'HACK26a', '// Moved fallback_value up in layout to decrease number of seeks against index /*HACK26a*/', 'Remove field from previous position'),
		('Key_BizHead_L_CNPNAME_FUZZY', '(h.company_name_prefix;)', 'HACK26b', '\g<1>\n  h.fallback_value; // Populate the fallback field /*HACK26b*/', 'Add field to new position'),
		('Key_BizHead_L_CNPNAME_FUZZY', '\n(.*?)AND KEYED\(fallback_value >= param_fallback_value\)\n', 'HACK26c', '\g<1>', 'Remove old placement of fallback value in index lookup'),
		('Key_BizHead_L_CNPNAME_FUZZY', '(KEYED\(\(company_name_prefix = param_company_name_prefix\)\))', 'HACK26d', '\g<1>\n      AND KEYED(fallback_value >= param_fallback_value) /*HACK26d*/', 'Add new placement of fallback value in index lookup')
	]

##---------------------------------------------------------------------------
##HACK27
##Change limits and block sizes for CNPNAME_ZIP, CNPNAME_ST, CNPNAME_FUZZY
##in BizLinkFull.Config
##---------------------------------------------------------------------------		
def dChangeConfigLimits():
    return[
        ('Config', 'EXPORT L_CNPNAME_ZIP_MAXBLOCKSIZE:=10000;', 'HACK27a', 'EXPORT L_CNPNAME_ZIP_MAXBLOCKSIZE:=250000; // Increased limit to 250K from 10K /*HACK27a*/', 'Increased limit to 100K from 10K'),
        ('Config', 'EXPORT L_CNPNAME_ZIP_MAXBLOCKLIMIT:=10000;', 'HACK27b', 'EXPORT L_CNPNAME_ZIP_MAXBLOCKLIMIT:=250000; // Increased limit to 250K from 10K /*HACK27b*/', 'Increased limit to 100K from 10K'),
        ('Config', 'EXPORT L_CNPNAME_ST_MAXBLOCKSIZE:=10000;', 'HACK27c', 'EXPORT L_CNPNAME_ST_MAXBLOCKSIZE:=250000; // Increased limit to 250K from 10K /*HACK27c*/', 'Increased limit to 100K from 10K'),
        ('Config', 'EXPORT L_CNPNAME_ST_MAXBLOCKLIMIT:=10000;', 'HACK27d', 'EXPORT L_CNPNAME_ST_MAXBLOCKLIMIT:=250000; // Increased limit to 250K from 10K /*HACK27d*/', 'Increased limit to 100K from 10K'),
        ('Config', 'EXPORT L_CNPNAME_FUZZY_MAXBLOCKSIZE:=10000;', 'HACK27e', 'EXPORT L_CNPNAME_FUZZY_MAXBLOCKSIZE:=250000; // Increased limit to 250K from 10K /*HACK27e*/', 'Increased limit to 100K from 10K'),
        ('Config', 'EXPORT L_CNPNAME_FUZZY_MAXBLOCKLIMIT:=10000;', 'HACK27f', 'EXPORT L_CNPNAME_FUZZY_MAXBLOCKLIMIT:=250000; // Increased limit to 250K from 10K /*HACK27f*/', 'Increased limit to 100K from 10K'),
        ('Config', 'EXPORT L_CNPNAME_MAXBLOCKSIZE:=10000;', 'HACK27g', 'EXPORT L_CNPNAME_MAXBLOCKSIZE:=250000; // Increased limit to 250K from 10K /*HACK27g*/', 'Increased limit to 250K from 10K'),
        ('Config', 'EXPORT L_CNPNAME_MAXBLOCKLIMIT:=10000;', 'HACK27h', 'EXPORT L_CNPNAME_MAXBLOCKLIMIT:=250000; // Increased limit to 250K from 10K /*HACK27h*/', 'Increased limit to 250K from 10K')
    ]

##---------------------------------------------------------------------------
##HACK28
##Add limits to L_CNPNAME_ST and L_CNPNAME_ZIP for Roxie. Don't exists since
##company name is using BOW
##---------------------------------------------------------------------------		
def dAddLimitsForBOW():
    return[
        # ('Key_BizHead_L_CNPNAME_ST', '(doIndexRead.*? := STEPPED\()(KEY.*?$)', 'HACK28a', '\g<1>LIMIT/*HACK28a*/(\g<2>', 'Add Limit to keyed lookup so as to not blow out the result set'),
        # ('Key_BizHead_L_CNPNAME_ST', '(AND .*?)(,ultid,orgid,seleid,proxid,PRIORITY.*?$)', 'HACK28b', '\g<1>,Config_BIP.L_CNPNAME_ST_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED)/*HACK28b*/\g<2>', 'Add Limit to keyed lookup so as to not blow out the result set'),
        # ('Key_BizHead_L_CNPNAME_ST', '(Returnable\(DATASET\(RECORDOF\(RawData0\)\) d\).*?)<>(.*?$)', 'HACK28c', '\g<1>>\g<2>/*HACK28c*/', 'Fix fallback logic to actually work and fallback'),
        # ('Key_BizHead_L_CNPNAME_ZIP', '(doIndexRead.*? := STEPPED\()(KEY.*?$)', 'HACK28a', '\g<1>LIMIT/*HACK28a*/(\g<2>', 'Add Limit to keyed lookup so as to not blow out the result set'),
        # ('Key_BizHead_L_CNPNAME_ZIP', '(AND .*?)(,ultid,orgid,seleid,proxid,PRIORITY.*?$)', 'HACK28b', '\g<1>,Config_BIP.L_CNPNAME_ZIP_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED)/*HACK28b*/\g<2>', 'Add Limit to keyed lookup so as to not blow out the result set'),
        # ('Key_BizHead_L_CNPNAME_ZIP', '(Returnable\(DATASET\(RECORDOF\(RawData0\)\) d\).*?)<>(.*?$)', 'HACK28c', '\g<1>>\g<2>/*HACK28c*/', 'Fix fallback logic to actually work and fallback'),
		('Mod_Ext_Data', '(STEPPED\()(KEYL_CNPNAME_ZIP.*?)(,ultid,orgid,seleid,proxid,PRIORITY.*?$)', 'HACK28a', '\g<1>LIMIT(\g<2>,Config_BIP.L_CNPNAME_ZIP_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED)/*HACK28a*/\g<3>', 'Add Limit to keyed lookup so as to not blow out the result set'),
		('Mod_Ext_Data', '(STEPPED\()(KEYL_CNPNAME_ST.*?)(,ultid,orgid,seleid,proxid,PRIORITY.*?$)', 'HACK28b', '\g<1>LIMIT(\g<2>,Config_BIP.L_CNPNAME_ST_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED)/*HACK28b*/\g<3>', 'Add Limit to keyed lookup so as to not blow out the result set'),
		('Mod_Ext_Data', '(STEPPED\()(KEYL_CNPNAME.*?)(,ultid,orgid,seleid,proxid,PRIORITY.*?$)', 'HACK28c', '\g<1>LIMIT(\g<2>,Config_BIP.L_CNPNAME_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED)/*HACK28c*/\g<3>', 'Add Limit to keyed lookup so as to not blow out the result set'),
		('Mod_Ext_Data', '(STEPPED\()(KEYL_URL.*?)(,ultid,orgid,seleid,proxid,PRIORITY.*?$)', 'HACK28d', '\g<1>LIMIT(\g<2>,Config_BIP.L_URL_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED)/*HACK28d*/\g<3>', 'Add Limit to keyed lookup so as to not blow out the result set')
	]

##---------------------------------------------------------------------------
##HACK29
##Add use of CNPNAME slim key to L_CNPNAME_ST and L_CNPNAME_ZIP for Roxie. (BH-1169)
##Also adding limits to keyed joins on BOW linkpaths (BH-1175)
##---------------------------------------------------------------------------		
def dAddCnpSlim():
    return [
        ('Key_BizHead_L_CNPNAME_ST', '(slimrec := {.*?;)', 'HACK29a', '\g<1>\n\tslimKeyRec := recordof(Key_BizHead_L_CNPNAME.SlimKey);/*HACK29a*/', 'Adding layout of slim key'),
        ('Key_BizHead_L_CNPNAME_ST', '(doIndexRead\(UNSIGNED4 search,UNSIGNED2 spc\) :=) .*?;', 'HACK29b', '''\g<1> STEPPED(LIMIT(Key_BizHead_L_CNPNAME.SlimKey( KEYED(GSS_hash = search) // ADDED LIMIT
                                                                      AND KEYED(GSS_Bloom = BloomF)
                                                                      AND Keyed(fallback_value >= param_fallback_value)
                                                                      
                                                                  ),
                                                                  Config_BIP.L_CNPNAME_MAXBLOCKLIMIT,
                                                                  ONFAIL(TRANSFORM(SlimKeyRec, 
                                                                                   SELF := ROW([],SlimKeyRec))),
                                                                  keyed),
                                                           ultid,
                                                           orgid,
                                                           seleid,
                                                           proxid,
                                                           PRIORITY(40-spc)); /*HACK29b*/''', 'Adding Slim Key Lookup'),
        ('Key_BizHead_L_CNPNAME_ST', '(res := JOIN\(.*?steppedmatches, Key,).*?;', 'HACK29c', '''\g<1>KEYED(RIGHT.GSS_Hash = wds[1].hsh)
                AND KEYED((RIGHT.st = param_st)) 
                AND KEYED(RIGHT.fallback_value >= param_fallback_value) 
                AND KEYED(LEFT.proxid = RIGHT.proxid 
                          AND LEFT.seleid = RIGHT.seleid 
                          AND LEFT.orgid = RIGHT.orgid 
                          AND LEFT.ultid = RIGHT.ultid)
                AND ((param_prim_name = (TYPEOF(RIGHT.prim_name))'' 
                    OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'') 
                    OR (RIGHT.prim_name = param_prim_name) 
                    OR ((Config_BIP.WithinEditN(RIGHT.prim_name,RIGHT.prim_name_len,param_prim_name,param_prim_name_len,1, 0))))
                AND ((~EXISTS(param_zip) 
                    OR RIGHT.zip = (TYPEOF(RIGHT.zip))'') 
                    OR (RIGHT.zip IN SET(param_zip,zip))),
                TRANSFORM(indexOutputRecord,
                          SELF.gss_word_weight := LEFT.gss_word_weight,
                          SELF := RIGHT),
                LIMIT(Config_BIP.L_CNPNAME_ST_MAXBLOCKLIMIT,
                      SKIP,
                      TRANSFORM(indexOutputRecord, 
                                SELF := ROW([],indexOutputRecord)))); /*HACK29c*/''', 'Change Keyed join and add limit/skip logic'),      
        ('Key_BizHead_L_CNPNAME_ZIP', '(slimrec := {.*?;)', 'HACK29d', '\g<1>\n\tslimKeyRec := recordof(Key_BizHead_L_CNPNAME.SlimKey);/*HACK29d*/', 'Adding layout of slim key'),
        ('Key_BizHead_L_CNPNAME_ZIP', '(doIndexRead\(UNSIGNED4 search,UNSIGNED2 spc\) :=) .*?;', 'HACK29e', '''\g<1> STEPPED(LIMIT(Key_BizHead_L_CNPNAME.SlimKey( KEYED(GSS_hash = search) // ADDED LIMIT
                                                                      AND KEYED(GSS_Bloom = BloomF)
                                                                      AND Keyed(fallback_value >= param_fallback_value)
                                                                      
                                                                  ),
                                                                  Config_BIP.L_CNPNAME_MAXBLOCKLIMIT,
                                                                  ONFAIL(TRANSFORM(SlimKeyRec, 
                                                                                   SELF := ROW([],SlimKeyRec))),
                                                                  keyed),
                                                           ultid,
                                                           orgid,
                                                           seleid,
                                                           proxid,
                                                           PRIORITY(40-spc)); /*HACK29e*/''', 'Adding Slim Key Lookup'),
        ('Key_BizHead_L_CNPNAME_ZIP', '(res := JOIN\(.*?steppedmatches, Key,).*?;', 'HACK29f', '''\g<1>KEYED(RIGHT.GSS_Hash = wds[1].hsh)
                AND KEYED((RIGHT.zip IN SET(param_zip,zip))) 
                AND KEYED(RIGHT.fallback_value >= param_fallback_value) 
                AND KEYED(LEFT.proxid = RIGHT.proxid 
                    AND LEFT.seleid = RIGHT.seleid 
                    AND LEFT.orgid = RIGHT.orgid 
                    AND LEFT.ultid = RIGHT.ultid)
                AND ((param_prim_name = (TYPEOF(RIGHT.prim_name))'' 
                    OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'') 
                    OR (RIGHT.prim_name = param_prim_name) 
                    OR ((Config_BIP.WithinEditN(RIGHT.prim_name,RIGHT.prim_name_len,param_prim_name,param_prim_name_len,1, 0))))
                AND ((param_st = (TYPEOF(RIGHT.st))'' 
                    OR RIGHT.st = (TYPEOF(RIGHT.st))'') 
                    OR (RIGHT.st = param_st)),
                TRANSFORM(indexOutputRecord,
                          SELF.gss_word_weight := LEFT.gss_word_weight,
                          SELF := RIGHT),
                LIMIT(Config_BIP.L_CNPNAME_ZIP_MAXBLOCKLIMIT,
                      SKIP,
                      TRANSFORM(indexOutputRecord, 
                                SELF := ROW([],indexOutputRecord)))); /*HACK29f*/''', 'Change Keyed join and add limit/skip logic'),        
        ('Key_BizHead_L_URL', '(res := JOIN\( steppedmatches, Key, .*?)\);', 'HACK29g', '\g<1>,LIMIT(Config_BIP.L_URL_MAXBLOCKLIMIT,SKIP,TRANSFORM(indexOutputRecord, SELF := ROW([],indexOutputRecord)))); /*HACK29g*/', 'Adding limit to keyed join'),                                      
    ]

# getHacks = 	dAppendForce() + \
# 			dUpdateKeynames() + \
# 			dAdjustCNPScore() + \
# 			dZipThreshold() + \
# 			dPayloadRestriction() + \
# 			dZipSpecificity() + \
# 			dRemoveRcid() + \
# 			dRemoveParallel() + \
# 			dGSSCnpNameWeight() + \
# 			dExtFileDisableForceOn() + \
# 			dRemoveRcidJoinCondition() + \
# 			dCnpNameOptimizations() + \
# 			dCnpNameFuzzyFallbackValueChanges() + \
#             dChangeConfigLimits() + \
#             dAddLimitsForBOW() + \
#             dAddCnpSlim()
			
getHacks = dAddCnpSlim()
