EXPORT _Hack:=MODULE
  IMPORT Tools;
  
  SHARED sESP:='dataland_esp.br.seisint.com:8145';
  SHARED sModule:='BizLinkFull';
  //---------------------------------------------------------------------------
  // HACK01
  // Drop the ATMOSTs for selected linkpaths in J0 and J1.  This improves 
  // thor batch append performance.
  //---------------------------------------------------------------------------
  // EXPORT dAtmostChange:=DATASET([
    // {sModule,'Key_BizHead_L_ADDRESS1',     '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_ADDRESS2',     '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_ADDRESS3',     '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_CNPNAME',      '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_CNPNAME_FUZZY','(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_CNPNAME_ST',   '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_CNPNAME_ZIP',  '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_CONTACT',      '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/5000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_CONTACT_SSN',  '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_EMAIL',        '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_FEIN',         '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_PHONE',        '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_SIC',          '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_SOURCE',       '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'},
    // {sModule,'Key_BizHead_L_URL',          '(ATMOST[(][^,]+,)[0-9]+','HACK01','$1/*HACK01*/2000','ATMOST changed'}
  // ],Tools.layout_attribute_hacks2);
  //---------------------------------------------------------------------------
  // HACK03
  // Additional condition on force-failed to apply a FORCE(+3) on thor appends
  // only, leaving search without the FORCE.  This is because the force
  // helps with thor batch precision, but we want to be looser with roxie
  // search.
  //---------------------------------------------------------------------------
  EXPORT dAppendForce:=DATASET([
    {sModule,'Process_Biz_Layouts','(combine_scores.+SELF.ForceFailed :=[^;]+);','HACK03','$1/*HACK03*/ OR SELF.cnp_nameWeight < 4;','Additional FORCE for Append'}
  ],Tools.layout_attribute_hacks2);
  //---------------------------------------------------------------------------
  // HACK07
  // Update all attributes with key declarations so that they get their file
  // names from the filename_keys attribute rather than being hard-coded.  This
  // is so we have a uniform naming convention and all of the key names in
  // one place.
  //---------------------------------------------------------------------------
  EXPORT dUpdateKeynames:=DATASET([
    {sModule,'Key_BizHead_L_ADDRESS1',     '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_ADDRESS2',     '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_ADDRESS3',     '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_CNPNAME',      '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_CNPNAME_FUZZY','(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_CNPNAME_ST',   '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_CNPNAME_ZIP',  '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_CONTACT',      '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_CONTACT_DID',  '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_CONTACT_SSN',  '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_EMAIL',        '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_FEIN',         '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_PHONE',        '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_SIC',          '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_SOURCE',       '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_L_URL',          '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07','$1 '+sModule+'.Filename_keys.$2; /*HACK07*/','Standardize key name'},
    {sModule,'Key_BizHead_',               '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07Refs','$1 '+sModule+'.Filename_keys.Refs; /*HACK07Refs*/','Standardize key name'},
    {sModule,'Key_BizHead_',               '(EXPORT ValueKeyName :=)[^;]+:([^:\';]+)\';','HACK07Words','$1 '+sModule+'.Filename_keys.Words; /*HACK07Words*/','Standardize key name'},
    {sModule,'Process_Biz_Layouts',        '(EXPORT KeyName :=)[^;]+:([^:\';]+)\';','HACK07meow','$1 '+sModule+'.Filename_keys.meow; /*HACK07meow*/','Standardize key name'},
    {sModule,'Process_Biz_Layouts',        '(EXPORT KeyproxidUpName :=)[^;]+:([^:\';]+)\';','HACK07sup_proxid','$1 '+sModule+'.Filename_keys.sup_proxid; /*HACK07sup_proxid*/','Standardize key name'},
    {sModule,'Process_Biz_Layouts',        '(EXPORT KeyseleidUpName :=)[^;]+:([^:\';]+)\';','HACK07sup_seleid','$1 '+sModule+'.Filename_keys.sup_seleid; /*HACK07sup_seleid*/','Standardize key name'},
    {sModule,'Process_Biz_Layouts',        '(EXPORT KeyorgidUpName :=)[^;]+:([^:\';]+)\';','HACK07sup_orgid','$1 '+sModule+'.Filename_keys.sup_orgid; /*HACK07sup_orgid*/','Standardize key name'},
    {sModule,'Process_Biz_Layouts',        '(EXPORT KeyIDHistoryName :=)[^;]+:([^:\';]+)\';','HACK07sup_rcid','$1 '+sModule+'.Filename_keys.sup_rcid; /*HACK07sup_rcid*/','Standardize key name'},
    {sModule,'specificities',              '(EXPORT cnp_nameValuesKeyName :=)[^;]+:([^:\';]+)\';','HACK07cnp_name','$1 '+sModule+'.Filename_keys.cnp_name; /*HACK07cnp_name*/','Standardize key name'},
    {sModule,'specificities',              '(EXPORT company_urlValuesKeyName :=)[^;]+:([^:\';]+)\';','HACK07company_url','$1 '+sModule+'.Filename_keys.company_url; /*HACK07company_url*/','Standardize key name'},
    {sModule,'Wheel',                      '(EXPORT KeyName_city_clean :=)[^;]+:([^:\';]+)\';','HACK07Wheel_city_clean','$1 '+sModule+'.Filename_keys.Wheel_city_clean; /*HACK07Wheel_city_clean*/','Standardize key name'},
    {sModule,'Wheel',                      '(EXPORT KeyNameQuick_city_clean :=)[^;]+:([^:\';]+)\';','HACK07Wheel_Quick_city_clean','$1 '+sModule+'.Filename_keys.Wheel_Quick_city_clean; /*HACK07Wheel_Quick_city_clean*/','Standardize key name'}
  ],Tools.layout_attribute_hacks2);
  //---------------------------------------------------------------------------
  // HACK08
  // Loosen up the scoring on cnp_name in the address linkpaths to add extra
  // emphasis on the cnp_name weight.
  //---------------------------------------------------------------------------
  EXPORT dAdjustCNPScore:=DATASET([
    {sModule,'Key_BizHead_L_ADDRESS1','(EXPORT RawFetch[^;]+MatchBagOfWords[^)]+[)])','HACK08','$1+400/*HACK08*/','Loosen cnp_name score in address linkpaths'},
    {sModule,'Key_BizHead_L_ADDRESS2','(EXPORT RawFetch[^;]+MatchBagOfWords[^)]+[)])','HACK08','$1+400/*HACK08*/','Loosen cnp_name score in address linkpaths'},
    {sModule,'Key_BizHead_L_ADDRESS3','(EXPORT RawFetch[^;]+MatchBagOfWords[^)]+[)])','HACK08','$1+400/*HACK08*/','Loosen cnp_name score in address linkpaths'}
  ],Tools.layout_attribute_hacks2);
  //---------------------------------------------------------------------------
  // HACK09
  // Remove the forcefailed filter on search.  We like roxie search to give 
  // extra stuff even if that means including items that would otherwise fail
  // because of a force.  Thor batch appends are not effected.
  //---------------------------------------------------------------------------
  EXPORT dMEOWBizNoForce:=DATASET([
    {sModule,'MEOW_Biz','([(][^)]*ForceFailed[^)]*[)])','HACK09','/*HACK09 $1*/','Remove ForceFailed in MEOW_Biz'}
  ],Tools.layout_attribute_hacks2);
  
  //---------------------------------------------------------------------------
  // HACK10
  // Modify MEOW_Biz to provide information about whether a search has hit the
  // MaxIDs limit or not.  Somewhat complex, but we are required by the roxie
  // team to provide them with this information.  So we actually retrieve one
  // row MORE than the MaxIDs value, and then deteremine if the results are
  // more than MaxIDs -- if so, we set is_truncated to TRUE, otherwise FALSE
  //---------------------------------------------------------------------------
  // EXPORT dTrackTruncated:=DATASET([
    // {sModule,
     // 'MEOW_Biz',
     // '(le.MaxIDs)(.+)process_Biz_layouts.id_stream_layout n(.+)(END.+)EXPORT Uid_Results[^;]+;(.+)(Layout_Matched_Data :=.+)(END;.+Layout_Matched_Data score_fields.+)(EXPORT Data_ :=)([^;]+)',
     // 'HACK10','$1/*HACK10a*/+1$2'+
     // '/*HACK10b*/\n  lTmpIDStreamLayout:={process_Biz_layouts.id_stream_layout;UNSIGNED _row:=1;UNSIGNED _max:=0;};\n'+
     // '  lTmpIDStreamLayout n$3  SELF._row:=c;\n'+
     // '  $4'+
     // 'SHARED uid_results0:=NORMALIZE(Raw_Results,COUNT(LEFT.Results),n(LEFT,COUNTER))+PROJECT(pass_thru,lTmpIDStreamLayout);\n'+
     // '  SHARED uid_results1:=JOIN(uid_results0,in,LEFT.uniqueid=RIGHT.uniqueid,TRANSFORM(RECORDOF(LEFT),SELF._max:=RIGHT.MaxIDs;SELF:=LEFT;));\n'+
     // '  EXPORT Uid_Results:=PROJECT(uid_results1(_row<=_max),TRANSFORM(process_Biz_layouts.id_stream_layout,SELF:=LEFT;));\n'+
     // '  SHARED dTruncated:=uid_results1(_row>_max);\n'+
     // '$5$6'+
     // '  /*HACK10c*/BOOLEAN is_truncated:=FALSE;\n    $7'+
     // '/*HACK10d*///$8$9;\n  $8JOIN($9,dTruncated,LEFT.uniqueid=RIGHT.uniqueid,TRANSFORM(RECORDOF(LEFT),SELF.is_truncated:=IF(RIGHT.weight=0,FALSE,TRUE);SELF:=LEFT;),LEFT OUTER)',
     // 'Include code to track if the results are truncated'}
  // ],Tools.layout_attribute_hacks2);
  
  //---------------------------------------------------------------------------
  // HACK11
  // Remove the ONFAIL for L_CNPNAME_FUZZY so that keys_failed is not reported
  // on that linkpath.  CNPNAME_FUZZY is sort of a way to pick up some extra
  // finds using a looser match on cnp_name.  So if the user gets good results
  // with any of the other cnp_name linkpaths, we don't want to confuse things
  // by indicating a key_fail on the FUZZY one.  So we do NOT tell them when
  // this occurs.
  //---------------------------------------------------------------------------
  // EXPORT dFuzzyNoFail:=DATASET([
    // {sModule,'Key_BizHead_L_CNPNAME_FUZZY','ONFAIL[^;]+,KEYED','HACK11','/*HACK11 ONFAIL removed*/ SKIP,KEYED','Remove ONFAIL for fuzzy results'}
  // ],Tools.layout_attribute_hacks2);
  
  //---------------------------------------------------------------------------
  // HACK13
  // Modify the batch append process to enable an extra parameter to turn on or
  // off the ForceFailed filter in case the user prefers to see those results.
  //---------------------------------------------------------------------------
  // EXPORT dForcefailedParam:=DATASET([
    // {sModule,'MAC_MEOW_Biz_Batch','^([^)]+)([)].+CombineAllScores[^)]+)','HACK13','$1,bIncludeFilter=TRUE$2,bIncludeFilter/*HACK13*/','Additional parameter to toggle ForceFailed'},
    // {sModule,'Process_Biz_Layouts','(CombineAllScores[^:]+in_data)(.+r0)( :=[^;]+[)])([(][^)]+[)])','HACK13','$1,BOOLEAN bIncludeFilter=TRUE$2_$3;\n  r0 := IF(bIncludeFilter,r0_$4,r0_)/*HACK13*/','Additional parameter to toggle ForceFailed'}
  // ],Tools.layout_attribute_hacks2);
  
  //---------------------------------------------------------------------------
  // HACK14
  // Modify the CNPNAME_ZIP so that the specificity threshold of wds is raised
  // as more zips are added to zip_cases.  Normally, wds is a simple hard-coded
  // threshold.  But in the case of CNPNAME_ZIP, the weight of the zip code
  // found will vary depending on how far out from the center of the zip radius
  // that zip is.  In this case, we want to vary wds based on how many zip
  // codes we are trying to search on so that we can accout for this fluctuation
  //---------------------------------------------------------------------------
  EXPORT dZipThreshold:=DATASET([
    {sModule,'Key_BizHead_L_CNPNAME_ZIP','(IF[(]SUM[(]wds,spec[)] > )([^,]+)([^;]+)','HACK14','IF(COUNT(param_zip)>600,DATASET([],indexOutputRecord),$1($2+(LOG(COUNT(param_zip))/LOG(2)))$3)/*HACK14*/','Make wds threshold variable for zip key'}
  ],Tools.layout_attribute_hacks2);
  
  //---------------------------------------------------------------------------
  // HACK15
  // Drop the size of the payload key so no single proxid has more than 9999
  // rows.  This is so we don't get any "More than 10,000 rows" errors in our
  // key fetch, but also to reduce the size of the key to improve performance.
  // Part of this hack is to remove from the key any fields that significantly
  // increase the number of unique rows (e.g. the AID fields).
  //---------------------------------------------------------------------------
  EXPORT dPayloadRestriction:=DATASET([
    {sModule,'Process_Biz_Layouts','(EXPORT Key :=[^(]+[(])[^,]+(,[^}]+[}],[{])[^}]+','HACK15','/*HACK15  Removing aid fields and cnp_nameid field from base file before building the key.\n         also not including rcid, vl_id, and source_record_id in the sort/dedup\n         which preserves those values for singletons (which we need) and leaves those\n         values as arbitrary where we dont care about them.  */\n' + 'import bipv2;\n' + '  s01:=DEDUP(SORT(DISTRIBUTE(h(BIPV2.mod_sources.srcInBase(source)),HASH32(proxid)),EXCEPT rcid,vl_id,source_record_id,LOCAL),EXCEPT rcid,vl_id,source_record_id,LOCAL);\n/* HACK  Now taking the post-collapsed key data and truncating the few remaining proxids\n         that have more than 9999 records */  \n  s:=DEDUP(SORT(s01,proxid,rcid,LOCAL),proxid,LOCAL,KEEP(9999));\n$1s$2s','Reduce size of clusters in the payload'}
  ],Tools.layout_attribute_hacks2);
  //---------------------------------------------------------------------------
  // HACK16
  // Modify search so that zip specificity is not taken into account when
  // calculating zip weight.  This is so if we have more than one result at
  // different radii from the center the difference in weight of the two zip
  // codes returned does NOT bump up the total weight of the row which can 
  // cause ordering issues if the company name of the outer zip has a higher
  // weight than the one with the inner zip.  The value being used in this hack
  // is basically the average specificity of all of the zips in the corpus.
  //---------------------------------------------------------------------------
  EXPORT dZipSpecificity:=DATASET([
    {sModule,'Key_BizHead_L_ADDRESS1',     '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_ADDRESS2',     '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_ADDRESS3',     '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_CNPNAME',      '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_CNPNAME_FUZZY','(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_CNPNAME_ST',   '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_CNPNAME_ZIP',  '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_CONTACT',      '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_CONTACT_SSN',  '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_EMAIL',        '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_FEIN',         '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_PHONE',        '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_SIC',          '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_SOURCE',       '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'},
    {sModule,'Key_BizHead_L_URL',          '(SELF.zipWeight :=[^>]+>)([^*]+)(.+ScoredFetch_Batch)','HACK16','$1 /*HACK16 $2*/ 1100 $3','Disregard zip specificity when calculating weight'}
  ],Tools.layout_attribute_hacks2);
  //---------------------------------------------------------------------------
  // HACK20
  // Filter out no rcid records or failed attemps. 
  //---------------------------------------------------------------------------
  EXPORT dRemoveRcid:=DATASET([
    {sModule,'MEOW_Biz','(EXPORT Data_[^;]+[^,]+[^)]+)\\);','HACK20','$1)(rcid>0 OR KeysFailed<>0); /*HACK20 KeysFailed added*/','Filter out rcids or failed attempts'}
  ],Tools.layout_attribute_hacks2);
  //---------------------------------------------------------------------------
  // HACK21
  // Remove parallel match hints from joins
  //---------------------------------------------------------------------------
  EXPORT dRemoveParallel:=DATASET([
    {sModule,'match_candidates','(,HINT[(]parallel_match[)])','HACK21','/*HACK21 $1*/','Remove the parallel match hints from joins'}
  ],Tools.layout_attribute_hacks2);
  //---------------------------------------------------------------------------
  // HACK22
  // Add in a parameter to MAC_Meow_Biz_Batch that passes through to
  // Process_Biz_Layouts which tells it whether to process parent scores or
  // not.  Default is to do it, which is the SALT default before this hack
  //---------------------------------------------------------------------------
  // EXPORT dIDParentParameter:=DATASET([
    // {sModule,'Process_Biz_Layouts','(EXPORT CombineAllScores[(][^:]+)([)].+SELF.Results_seleid := )([^;]+)(.+SELF.Results_orgid := )([^;]+)(.+SELF.Results_ultid := )([^;]+)(.+SELF.Results_powid := )([^;]+)','HACK22','$1/*HACK22*/,BOOLEAN bGetAllScores=TRUE$2/*HACK22*/IF(bGetAllScores,$3,DATASET([],LayoutScoredFetch))$4/*HACK22*/IF(bGetAllScores,$5,DATASET([],LayoutScoredFetch))$6/*HACK22*/IF(bGetAllScores,$7,DATASET([],LayoutScoredFetch))$8/*HACK22*/IF(bGetAllScores,$9,DATASET([],LayoutScoredFetch))','parameterize IDParent aggregation'},
    // {sModule,'MAC_MEOW_Biz_Batch','(MAC_MEOW_Biz_Batch[(][^)]+)(.+CombineAllScores[^)]+)','HACK22','$1,/*HACK22*/bGetAllScores=TRUE$2,/*HACK22*/bGetAllScores','parameterize IDParent aggregation'}
  // ],Tools.layout_attribute_hacks2);
  //---------------------------------------------------------------------------
  // Build a linkpaths attribute with details about each linkpath to be used by
  // the search service.  This is rebuilt with each .mod file import so that we
  // have a DATASET of linkpath members that can be displayed as a helper in
  // the header service.
  // NOTE: (These two datasets must be called in a SEQUENTIAL in order for it
  // to work properly)
  //---------------------------------------------------------------------------
  // EXPORT dLinkpaths:=DATASET([
    // {sModule,'GenerationDocs','^([^L]|L[^I]|LI[^N]|LINK[^P]|LINKPATH[^:])[^\n]+\n','DONTHACK','','Create linkpath lookup dataset',sModule,'linkpaths'}
  // ],Tools.layout_attribute_hacks2);
  // EXPORT dLinkpaths2:=DATASET([
    // {sModule,'linkpaths','LINKPATH:','DONTHACK','  {\'','Create linkpath lookup dataset'},
    // {sModule,'linkpaths','\n','','\'},\n','Create linkpath lookup dataset'},
    // {sModule,'linkpaths','([{][^}+]+)(\'[}])','','$1:+:$2','Create linkpath lookup dataset'},
    // {sModule,'linkpaths','([{][^}?]+)([+])','','$1?:$2','Create linkpath lookup dataset'},
    // {sModule,'linkpaths','[?]|[+]','','\',\'','Create linkpath lookup dataset'},
    // {sModule,'linkpaths','([{][^:]+):','','$1\',\'','Create linkpath lookup dataset'},
    // {sModule,'linkpaths','[:]+\'|\'[:]+','','\'','Create linkpath lookup dataset'},
    // {sModule,'linkpaths','(.+),','','EXPORT linkpaths:=DATASET([\n$1\n],{STRING linkpath;STRING required;STRING optional;STRING bonus;});','Create linkpath lookup dataset'} 
  // ],Tools.layout_attribute_hacks2);
  //---------------------------------------------------------------------------
  // Hack Actions
  //---------------------------------------------------------------------------
  EXPORT aHack(DATASET(Tools.Layout_attribute_hacks2) d,bSaveIt=TRUE):=Tools.HackAttribute2(d,bSaveIt,sESP).saveit;
  
  EXPORT dAll:=
    // dAtmostChange+
    dAppendForce+
    dUpdateKeynames+
    dAdjustCNPScore+
    // dTrackTruncated+
    // dFuzzyNoFail+
    // dForcefailedParam+
    dZipThreshold+
    dPayloadRestriction+
    dZipSpecificity+
    dRemoveRcid+
    dRemoveParallel;//+
    // dIDParentParameter;
  // These need to run sequentially
  // EXPORT aHackLinkpaths:=SEQUENTIAL(
    // aHack(dLinkpaths),
    // aHack(dLinkpaths2)
  // );
  // All at once
  // EXPORT aHackAll:=SEQUENTIAL(aHack(dAll),aHackLinkpaths);
  EXPORT aHackAll:=aHack(dAll);
END;
