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
		('Key_BizHead_L_ADDRESS1',     '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_ADDRESS2',     '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_ADDRESS3',     '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CNPNAME',      '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CNPNAME_FUZZY','(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CNPNAME_ST',   '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CNPNAME_ZIP',  '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CONTACT',      '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_CONTACT_SSN',  '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_EMAIL',        '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_FEIN',         '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_PHONE',        '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_SIC',          '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_SOURCE',       '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Key_BizHead_L_URL',          '(SELF.zipWeight :=.*SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)(.+EXPORT ScoredFetch_Batch)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100 \g<3>','Disregard zip specificity when calculating weight'),
		('Mod_Ext_Data',               '(SELF.zipWeight :=.*?SELF.zip_match_code = SALT311.MatchCode.ExactMatch =>)([^*]+)','HACK16','\g<1> /*HACK16 \g<2>*/ 1100','Disregard zip specificity when calculating weight')
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
		('Key_BizHead_L_CNPNAME',      '(SELF\.cnp_nameWeight \:\=   le\.gss_word_weight\; \/\/Fixed Wordbag weights accumulated in gss_weight field)','HACK22_a','SELF.cnp_nameWeight := SALT311.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)/100; /*HACK22_a*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Key_BizHead_L_CNPNAME',      '(SELF\.cnp_name_GSS_Weight := le\.gss_word_weight\;\/\/ MORE \- need to scale in independence)','HACK22_b','SELF.cnp_name_GSS_Weight := SELF.cnp_nameWeight; /*HACK22_b*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Key_BizHead_L_CNPNAME_ST',      '(SELF\.cnp_nameWeight \:\=   le\.gss_word_weight\; \/\/Fixed Wordbag weights accumulated in gss_weight field)','HACK22_a','SELF.cnp_nameWeight := SALT311.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)/100; /*HACK22_a*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Key_BizHead_L_CNPNAME_ST',      '(SELF\.cnp_name_GSS_Weight := le\.gss_word_weight\;\/\/ MORE \- need to scale in independence)','HACK22_b','SELF.cnp_name_GSS_Weight := SELF.cnp_nameWeight; /*HACK22_b*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Key_BizHead_L_CNPNAME_ZIP',      '(SELF\.cnp_nameWeight \:\=   le\.gss_word_weight\; \/\/Fixed Wordbag weights accumulated in gss_weight field)','HACK22_a','SELF.cnp_nameWeight := SALT311.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)/100; /*HACK22_a*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Key_BizHead_L_CNPNAME_ZIP',      '(SELF\.cnp_name_GSS_Weight := le\.gss_word_weight\;\/\/ MORE \- need to scale in independence)','HACK22_b','SELF.cnp_name_GSS_Weight := SELF.cnp_nameWeight; /*HACK22_b*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
		('Mod_Ext_Data',      '(SELF\.cnp_nameWeight \:\=   le\.gss_word_weight\; \/\/Fixed Wordbag weights accumulated in gss_weight field)','HACK22_a','SELF.cnp_nameWeight := SALT311.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)/100; /*HACK22_a*/','Change cnp_nameWeigth to use MatchBagOfWords instead of GSS weight'),
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

getHacks = 	dAppendForce() + \
			dUpdateKeynames() + \
			dAdjustCNPScore() + \
			dZipThreshold() + \
			dPayloadRestriction() + \
			dZipSpecificity() + \
			dRemoveRcid() + \
			dRemoveParallel() + \
			dGSSCnpNameWeight() + \
			dExtFileDisableForceOn() + \
			dRemoveRcidJoinCondition()
