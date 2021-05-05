/*
  Run this on HTHOR if you use the keys passed in or you pass in other keys.  if you pass in a file(s), run it on thor.
  it should run on hthor very quickly, like in 4 minutes or so.

  mac_How_Did_This_Link()
    This is useful when you have an overlinked seleid and at least two names within it that you think are not related.
    this will drill down into the proxids and then the dotids to find out where the overlink occurs.
    then it will look at fein, duns, ent num, corpkey, sbfe_id, vl_id & source_record_id to see if any of these ids have both cnp_names in common.
    the cnp_names have the source code prepended to them so you know the source of each cnp_name.(ex, 'BC-7 11' means that BC(SBFE) was the source of the '7 11' cnp_name)
    you can find out how they overlinked based on which one(s) share one of those keys.

Examples:
BIPV2_Tools.mac_How_Did_This_Link(87324387,'LIBERTY BAY CREDIT UNION' ,'SMITH & BRINK'                        );
BIPV2_Tools.mac_How_Did_This_Link(29825   ,'BRITLEY'                  ,'(7[- ]11|7[- ]ELEVEN|seven[- ]eleven)');

my_id       := 134146476918 ;//658
regexname1  := ''           ;
regexname2  := ''           ;
my_id_type  := 'seleid'           ;

#workunit('name'  ,my_id_type + ': ' + (string)my_id + ' ' + regexname1 + ',' + regexname2 + ' how did this link');

keyversion  := 'qa'            ;

BIPV2_Tools.mac_How_Did_This_Link(
   my_id 
  ,regexname1 
  ,regexname2                        
  ,pID_Type             := #EXPAND(my_id_type)
  ,pLinkids_key         := BIPV2_Build.BIPV2FullKeys_Package(keyversion).linkids.logical
  ,pLinkids_key_hidden  := BIPV2_Build.BIPV2FullKeys_Package(keyversion).linkids_hidden.logical
  ,pKeyproxidUp         := BIPV2_Build.BIPV2FullKeys_Package(keyversion).Xlinksup_proxid.logical
  ,pKeyseleidUp         := BIPV2_Build.BIPV2FullKeys_Package(keyversion).Xlinksup_seleid.logical
);
*/
EXPORT mac_How_Did_This_Link(

   pID_Value                                                            // -- overlinked seleid.  Make sure the seleid = ultid.  if not, pass in the ultid.
  ,pCnp_Name1_regex                                                     // -- first company name.  this can be a regex
  ,pCnp_Name2_regex                                                     // -- second company name.  this can also be a regex.
  ,pID_Type             = 'seleid' 
  ,pLinkids_key         = 'BIPV2.Key_BH_Linking_Ids.key'                //'BIPV2_Build.BIPV2FullKeys_Package().linkids.qa'
  ,pLinkids_key_hidden  = 'BIPV2.Key_BH_Linking_Ids.key_hidden'         //'BIPV2_Build.BIPV2FullKeys_Package().linkids_hidden.qa'  //rest of records not in ds_clean
  ,pKeyproxidUp         = 'BizLinkFull.Process_Biz_Layouts.KeyproxidUp' //'BIPV2_Build.BIPV2FullKeys_Package().Xlinksup_proxid.qa' 
  ,pKeyseleidUp         = 'BizLinkFull.Process_Biz_Layouts.KeyseleidUp' //'BIPV2_Build.BIPV2FullKeys_Package().Xlinksup_seleid.qa' 
  ,pOutputExtraInfo     = 'false'                                       //also output the ultid, orgid(s) and seleid(s)?  if true, will take longer, around 10 minutes instead of 4 minutes
  ,pLimitChildDatasets  = '100'                                         //limit the child datasets to 100 records each to make this run faster and also allow them to be displayed. 0 = no limit

) :=
functionmacro

  #IF(#TEXT(pID_Type) = 'seleid')
    lultid := pKeyseleidUp(seleid = pID_Value)[1].ultid; 
  #ELSEIF(#TEXT(pID_Type) = 'proxid')
    lultid := pKeyproxidUp(proxid = pID_Value)[1].ultid;
  #ELSE//IF(#TEXT(pID_Type) = 'ultid')
    lultid := pID_Value;
  #END

  ds_filtered_prep        := pLinkids_key       (ultid = lultid ,#TEXT(pID_Type) != 'seleid' or seleid = pID_Value  ,#TEXT(pID_Type) != 'proxid' or proxid = pID_Value) 
                          +  pLinkids_key_hidden(ultid = lultid ,#TEXT(pID_Type) != 'seleid' or seleid = pID_Value  ,#TEXT(pID_Type) != 'proxid' or proxid = pID_Value)
                          ;
                          
  ds_filtered := ds_filtered_prep : independent;
  
  key_cnp_name_words := BIPV2_proxid.specificities(BIPV2_proxid.In_DOT_Base).cnp_name_values_index;
  ds_get_bow_field := join(dataset([{trim(pCnp_Name1_regex)},{trim(pCnp_Name2_regex)}],{string cnp_name})  ,key_cnp_name_words, left.cnp_name = right.cnp_name ,transform({string bow_field,real field_specificity,integer4 bow_spec,recordof(left)}
    ,self.bow_field         := (unsigned)(right.field_specificity * 100) +' '+ trim(right.word)
    ,self.field_specificity := right.field_specificity
    ,self.bow_spec          := (integer4)(right.field_specificity * 100)
    ,self                   := left
  ),hash,keyed);
  
  bow_field1 := ds_get_bow_field(trim(cnp_name) = trim(pCnp_Name1_regex))[1].bow_field;
  bow_field2 := ds_get_bow_field(trim(cnp_name) = trim(pCnp_Name2_regex))[1].bow_field;
  
  get_BOW_Score := SALT311.MatchBagOfWords(bow_field1,bow_field2,46614,1);

  ds_agg_ultid            := BIPV2_Tools.AggregateProxidElements(ds_filtered,ultid ,pLimitChildDatasets);
  ds_agg_orgid            := BIPV2_Tools.AggregateProxidElements(ds_filtered,orgid ,pLimitChildDatasets);
  ds_agg_seleid           := BIPV2_Tools.AggregateProxidElements(ds_filtered,seleid,pLimitChildDatasets);
  ds_agg_lgid3            := BIPV2_Tools.AggregateProxidElements(ds_filtered,lgid3 ,pLimitChildDatasets);
  ds_agg_proxid           := BIPV2_Tools.AggregateProxidElements(ds_filtered,proxid,pLimitChildDatasets,,,true);
  ds_agg_dotid            := BIPV2_Tools.AggregateProxidElements(ds_filtered,dotid ,pLimitChildDatasets);
  
  ds_agg_parent_proxid    := BIPV2_Tools.AggregateProxidElements(ds_filtered,parent_proxid   ,pLimitChildDatasets);
  ds_agg_sele_proxid      := BIPV2_Tools.AggregateProxidElements(ds_filtered,sele_proxid     ,pLimitChildDatasets);
  ds_agg_org_proxid       := BIPV2_Tools.AggregateProxidElements(ds_filtered,org_proxid      ,pLimitChildDatasets);
  ds_agg_ultimate_proxid  := BIPV2_Tools.AggregateProxidElements(ds_filtered,ultimate_proxid ,pLimitChildDatasets);

  both_names_exist(
     dataset(recordof(ds_agg_proxid.cnp_names     )) pcnp_names
    ,dataset(recordof(ds_agg_proxid.company_names )) pcompany_names
  ) :=
        (pCnp_Name1_regex != '' and (exists(pcnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(pcompany_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))) )
    and (pCnp_Name2_regex != '' and (exists(pcnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(pcompany_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase)))) )
    ;
  
  ds_agg_ultid_filtered   := ds_agg_ultid (both_names_exist(cnp_names,company_names));
  ds_agg_orgid_filtered   := ds_agg_orgid (both_names_exist(cnp_names,company_names));
  ds_agg_seleid_filtered  := ds_agg_seleid(both_names_exist(cnp_names,company_names));
  ds_agg_lgid3_filtered   := ds_agg_lgid3 (both_names_exist(cnp_names,company_names));
  ds_agg_proxid_filtered  := ds_agg_proxid(both_names_exist(cnp_names,company_names));
  ds_agg_dotid_filtered   := ds_agg_dotid (both_names_exist(cnp_names,company_names));
  
  ds_agg_parent_proxid_filtered     := ds_agg_parent_proxid   (both_names_exist(cnp_names,company_names));
  ds_agg_sele_proxid_filtered       := ds_agg_sele_proxid     (both_names_exist(cnp_names,company_names));
  ds_agg_org_proxid_filtered        := ds_agg_org_proxid      (both_names_exist(cnp_names,company_names));
  ds_agg_ultimate_proxid_filtered   := ds_agg_ultimate_proxid (both_names_exist(cnp_names,company_names));

  ds_agg_lgid3_filtered1  := ds_agg_lgid3 (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase))) );
  ds_agg_lgid3_filtered2  := ds_agg_lgid3 (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );

  ds_agg_lgid3_filtered3  := ds_agg_lgid3 (count(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) = count(cnp_names) );
  ds_agg_lgid3_filtered4  := ds_agg_lgid3 (count(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) = count(cnp_names) );

  ds_agg_lgid3_filtered5  := ds_agg_lgid3 (~exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) );
  ds_agg_lgid3_filtered6  := ds_agg_lgid3 (~exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) );

  ds_agg_proxid_filtered1 := ds_agg_proxid(exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase))) );
  ds_agg_proxid_filtered2 := ds_agg_proxid(exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );

  ds_agg_proxid_filtered3  := ds_agg_proxid (count(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) = count(cnp_names) );
  ds_agg_proxid_filtered4  := ds_agg_proxid (count(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) = count(cnp_names) );

  ds_agg_proxid_filtered5  := ds_agg_proxid (~exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) );
  ds_agg_proxid_filtered6  := ds_agg_proxid (~exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) );

  ds_agg_proxid_filtered7  := ds_agg_proxid (~(count(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) = count(cnp_names) ));
  ds_agg_proxid_filtered8  := ds_agg_proxid (~(count(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) = count(cnp_names) ));

  ds_agg_proxid_filtered5_proxids  := table(ds_agg_proxid_filtered5 ,{unsigned6 seleid := seleids[1].seleid,proxid});   
  ds_agg_proxid_filtered6_proxids  := table(ds_agg_proxid_filtered6 ,{unsigned6 seleid := seleids[1].seleid,proxid});   
  
  ds_agg_proxid_filtered7_proxids  := table(ds_agg_proxid_filtered7 ,{unsigned6 seleid := seleids[1].seleid,proxid});   
  ds_agg_proxid_filtered8_proxids  := table(ds_agg_proxid_filtered8 ,{unsigned6 seleid := seleids[1].seleid,proxid});   
  
  sum_proxid_filtered7_proxids  := sum(ds_agg_proxid_filtered7 ,cnt);   
  sum_proxid_filtered8_proxids  := sum(ds_agg_proxid_filtered8 ,cnt);   

  ds_agg_dotid_filtered1  := ds_agg_dotid (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase))) );
  ds_agg_dotid_filtered2  := ds_agg_dotid (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );

  ds_suppress_proxids_without_cnp_name1               := join(ds_filtered ,ds_agg_proxid_filtered5  ,left.proxid = right.proxid ,transform(left)  ,left only  ,hash);
  ds_agg_seleid_remove_proxids_dont_contain_cnp_name1 := BIPV2_Tools.AggregateProxidElements(ds_suppress_proxids_without_cnp_name1,seleid,pLimitChildDatasets);

  ds_suppress_proxids_without_cnp_name2               := join(ds_filtered ,ds_agg_proxid_filtered6  ,left.proxid = right.proxid ,transform(left)  ,left only  ,hash);
  ds_agg_seleid_remove_proxids_dont_contain_cnp_name2 := BIPV2_Tools.AggregateProxidElements(ds_suppress_proxids_without_cnp_name2,seleid,pLimitChildDatasets);

  ds_suppress_lgid3s_without_cnp_name1               := join(ds_filtered ,ds_agg_lgid3_filtered5  ,left.lgid3 = right.lgid3 ,transform(left)  ,left only  ,hash);
  ds_agg_seleid_remove_lgid3s_dont_contain_cnp_name1 := BIPV2_Tools.AggregateProxidElements(ds_suppress_lgid3s_without_cnp_name1,seleid,pLimitChildDatasets);

  ds_suppress_lgid3s_without_cnp_name2               := join(ds_filtered ,ds_agg_lgid3_filtered6  ,left.lgid3 = right.lgid3 ,transform(left)  ,left only  ,hash);
  ds_agg_seleid_remove_lgid3s_dont_contain_cnp_name2 := BIPV2_Tools.AggregateProxidElements(ds_suppress_lgid3s_without_cnp_name2,seleid,pLimitChildDatasets);

  ds_filtered_only_cnp_name1            := ds_filtered(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase));
  ds_agg_seleid_filtered_only_cnp_name1 := BIPV2_Tools.AggregateProxidElements(ds_filtered_only_cnp_name1,seleid,pLimitChildDatasets);
  ds_filtered_not_cnp_name1             := ds_filtered(~regexfind(pCnp_Name1_regex,trim(cnp_name),nocase));
  ds_filtered_not_cnp_name1_rcids       := table(ds_filtered_not_cnp_name1 ,{rcid});

  ds_filtered_only_cnp_name2            := ds_filtered(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase));
  ds_agg_seleid_filtered_only_cnp_name2 := BIPV2_Tools.AggregateProxidElements(ds_filtered_only_cnp_name2,seleid,pLimitChildDatasets);
  ds_filtered_not_cnp_name2             := ds_filtered(~regexfind(pCnp_Name2_regex,trim(cnp_name),nocase));
  ds_filtered_not_cnp_name2_rcids       := table(ds_filtered_not_cnp_name2 ,{rcid});


  set_overlinked_proxids  := set(ds_agg_proxid_filtered,proxid);

  ds_proxid_filter                 := ds_filtered;//(count(set_overlinked_proxids) = 0 or proxid in set_overlinked_proxids);
  ds_agg_cnp_name                  := BIPV2_Tools.AggregateProxidElements(ds_proxid_filter,cnp_name_raw             ,pLimitChildDatasets);
  ds_agg_company_fein              := BIPV2_Tools.AggregateProxidElements(ds_proxid_filter,company_fein             ,pLimitChildDatasets);
  ds_agg_duns_number               := BIPV2_Tools.AggregateProxidElements(ds_proxid_filter,duns_number              ,pLimitChildDatasets);
  ds_agg_active_enterprise_number  := BIPV2_Tools.AggregateProxidElements(ds_proxid_filter,active_enterprise_number ,pLimitChildDatasets);
  ds_agg_active_domestic_corp_key  := BIPV2_Tools.AggregateProxidElements(ds_proxid_filter,active_domestic_corp_key ,pLimitChildDatasets);
  ds_agg_sbfe_id                   := BIPV2_Tools.AggregateProxidElements(ds_proxid_filter,sbfe_id                  ,pLimitChildDatasets);
  ds_agg_vl_id                     := BIPV2_Tools.AggregateProxidElements(ds_proxid_filter,vl_id                    ,pLimitChildDatasets);
  ds_agg_source_rid                := BIPV2_Tools.AggregateProxidElements(ds_proxid_filter,source_record_id         ,pLimitChildDatasets);
  ds_agg_address                   := BIPV2_Tools.AggregateProxidElements(ds_proxid_filter,address                  ,pLimitChildDatasets);
  ds_agg_phone                     := BIPV2_Tools.AggregateProxidElements(ds_proxid_filter,company_phone            ,pLimitChildDatasets);

  ds_agg_company_fein_filtered              := ds_agg_company_fein              (both_names_exist(cnp_names,company_names));
  ds_agg_duns_number_filtered               := ds_agg_duns_number               (both_names_exist(cnp_names,company_names));
  ds_agg_active_enterprise_number_filtered  := ds_agg_active_enterprise_number  (both_names_exist(cnp_names,company_names));
  ds_agg_active_domestic_corp_key_filtered  := ds_agg_active_domestic_corp_key  (both_names_exist(cnp_names,company_names));
  ds_agg_sbfe_id_filtered                   := ds_agg_sbfe_id                   (both_names_exist(cnp_names,company_names));
  ds_agg_vl_id_filtered                     := ds_agg_vl_id                     (both_names_exist(cnp_names,company_names));
  ds_agg_source_rid_filtered                := ds_agg_source_rid                (both_names_exist(cnp_names,company_names));
  ds_agg_address_filtered                   := ds_agg_address                   (both_names_exist(cnp_names,company_names));
  ds_agg_phone_filtered                     := ds_agg_phone                     (both_names_exist(cnp_names,company_names));

  ds_agg_company_fein_gt1_name              := ds_agg_company_fein              (count(cnp_names) > 1,(trim(pCnp_Name1_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))))  or (trim(pCnp_Name2_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))))) );
  ds_agg_duns_number_gt1_name               := ds_agg_duns_number               (count(cnp_names) > 1,(trim(pCnp_Name1_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))))  or (trim(pCnp_Name2_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))))) );
  ds_agg_active_enterprise_number_gt1_name  := ds_agg_active_enterprise_number  (count(cnp_names) > 1,(trim(pCnp_Name1_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))))  or (trim(pCnp_Name2_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))))) );
  ds_agg_active_domestic_corp_key_gt1_name  := ds_agg_active_domestic_corp_key  (count(cnp_names) > 1,(trim(pCnp_Name1_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))))  or (trim(pCnp_Name2_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))))) );
  ds_agg_sbfe_id_gt1_name                   := ds_agg_sbfe_id                   (count(cnp_names) > 1,(trim(pCnp_Name1_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))))  or (trim(pCnp_Name2_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))))) );
  ds_agg_vl_id_gt1_name                     := ds_agg_vl_id                     (count(cnp_names) > 1,(trim(pCnp_Name1_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))))  or (trim(pCnp_Name2_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))))) );
  ds_agg_source_rid_gt1_name                := ds_agg_source_rid                (count(cnp_names) > 1,(trim(pCnp_Name1_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))))  or (trim(pCnp_Name2_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))))) );
  ds_agg_address_gt1_name                   := ds_agg_address                   (count(cnp_names) > 1,(trim(pCnp_Name1_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))))  or (trim(pCnp_Name2_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))))) );
  ds_agg_phone_gt1_name                     := ds_agg_phone                     (count(cnp_names) > 1,(trim(pCnp_Name1_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))))  or (trim(pCnp_Name2_regex) != '' and (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))))) );

  count_records := count(ds_filtered);
  count_ultids  := count(table(ds_filtered  ,{ultid } ,ultid  ,few));
  count_orgids  := count(table(ds_filtered  ,{orgid } ,orgid  ,few));
  count_seleids := count(table(ds_filtered  ,{seleid} ,seleid ,few));
  count_lgid3s  := count(table(ds_filtered  ,{lgid3 } ,lgid3  ,merge));
  count_proxids := count(table(ds_filtered  ,{proxid} ,proxid ,merge));
  count_dotids  := count(table(ds_filtered  ,{dotid } ,dotid  ,merge));

  // -- try to add hierarchy info so if we need to suppress at the hierarchy level
  // -- filter for three sources of hierarchy
  
  ds_filtered_hrchy_sources := ds_filtered(source in [mdr.sourcetools.src_Dunn_Bradstreet,mdr.sourcetools.src_DCA,mdr.sourcetools.src_Frandx],(trim(duns_number) != '' or trim(active_enterprise_number) != '' or trim(if(source = mdr.sourcetools.src_Frandx,vl_id[1..6],'')) != '' ));
  ds_filtered_hrchy_sources_slim := table(ds_filtered_hrchy_sources 
    ,{seleid,lgid3,proxid,source,has_lgid,is_sele_level,is_org_level,is_ult_level,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,levels_from_top,nodes_below,nodes_total,duns_number,active_enterprise_number,string franchisee_id  := if(source = mdr.sourcetools.src_Frandx,vl_id[1..6],'')} 
    , seleid,lgid3,proxid,source,has_lgid,is_sele_level,is_org_level,is_ult_level,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,levels_from_top,nodes_below,nodes_total,duns_number,active_enterprise_number,if(source = mdr.sourcetools.src_Frandx,vl_id[1..6],'')
    ,merge);


  // -- try to do transitive closure to find the link
  #IF(#TEXT(pID_Type) in ['seleid','lgid3','orgid','ultid'])
    ds_agg_for_reform := ds_agg_proxid;
  #ELSE
    ds_agg_for_reform := ds_agg_dotid;
  #END
  
  ds_reform_lgid3_prep  := normalize(ds_agg_for_reform 
      , left.count_cnp_name_raws 
      + left.count_feins		          
      + left.count_a_dunss            
      + left.count_a_entnums          
      + left.count_a_corpkeys         
      + left.count_sbfe_ids           
      ,transform(
         {unsigned6 lgid3  ,unsigned6 proxid  ,unsigned6 dotid  ,string grouping_field}
        ,self.lgid3           := left.lgid3s[1].lgid3
  #IF(#TEXT(pID_Type) in ['seleid','lgid3','orgid','ultid'])
        ,self.proxid          := left.proxid
        ,self.dotid           := left.dotids[counter].dotid
  #ELSE
        ,self.proxid          := left.proxids[1].proxid
        ,self.dotid           := left.dotid
  #END
        ,self.grouping_field  := map(
          counter between 1                                                                                                                     and left.count_cnp_name_raws                                                                                                              => 'name-' + left.cnp_name_raws [counter].cnp_name_raw
         ,counter between left.count_cnp_name_raws + 1                                                                                          and left.count_cnp_name_raws + left.count_feins                                                                                           => 'fein-' + left.feins         [counter - left.count_cnp_name_raws].fein
         ,counter between left.count_cnp_name_raws + left.count_feins + 1                                                                       and left.count_cnp_name_raws + left.count_feins + left.count_a_dunss                                                                      => 'duns-' + left.a_dunss       [counter - left.count_cnp_name_raws - left.count_feins].a_duns
         ,counter between left.count_cnp_name_raws + left.count_feins + left.count_a_dunss + 1                                                  and left.count_cnp_name_raws + left.count_feins + left.count_a_dunss + left.count_a_entnums                                               => 'enum-' + left.a_entnums     [counter - left.count_cnp_name_raws - left.count_feins - left.count_a_dunss].a_entnum
         ,counter between left.count_cnp_name_raws + left.count_feins + left.count_a_dunss + left.count_a_entnums + 1                           and left.count_cnp_name_raws + left.count_feins + left.count_a_dunss + left.count_a_entnums + left.count_a_corpkeys                       => 'ckey-' + left.a_corpkeys    [counter - left.count_cnp_name_raws - left.count_feins - left.count_a_dunss - left.count_a_entnums ].a_corpkey
         ,counter between left.count_cnp_name_raws + left.count_feins + left.count_a_dunss + left.count_a_entnums + left.count_a_corpkeys + 1   and left.count_cnp_name_raws + left.count_feins + left.count_a_dunss + left.count_a_entnums + left.count_a_corpkeys + left.count_sbfe_ids => 'sbfe-' + left.sbfe_ids      [counter - left.count_cnp_name_raws - left.count_feins - left.count_a_dunss - left.count_a_entnums - left.count_a_corpkeys].sbfe_id
         ,                                                                                                                                                                                                                                                                                   ''
        )
  ))(trim(grouping_field) != '');

  #uniquename(reform_id)
  #uniquename(lowest_id)
  #uniquename(lower_id)
  #IF(#TEXT(pID_Type) in ['seleid','lgid3','orgid','ultid'])
    #SET(reform_id  ,'lgid3'        )
    #SET(lowest_id  ,'lowest_proxid')
    #SET(lower_id   ,'proxid'       )
  #ELSE
    #SET(reform_id  ,'proxid'       )
    #SET(lowest_id  ,'lowest_dotid' )
    #SET(lower_id   ,'dotid'        )
  #END
  
  reform_lgid3      := BIPV2_Tools.mac_reform(ds_reform_lgid3_prep  ,%reform_id%  ,%lower_id% ,%lowest_id%  ,grouping_field ,true,pCnp_Name1_regex,pCnp_Name2_regex);
  #uniquename(reform_id)
  #uniquename(lowest_id)
  #uniquename(lower_id)
  #IF(#TEXT(pID_Type) in ['seleid','lgid3','orgid','ultid'])
    #SET(reform_id  ,'lgid3'        )
    #SET(lowest_id  ,'lowest_proxid')
    #SET(lower_id   ,'proxid'       )
  #ELSE
    #SET(reform_id  ,'proxid'       )
    #SET(lowest_id  ,'lowest_dotid' )
    #SET(lower_id   ,'dotid'        )
  #END
  reform_lgid3_agg  := tools.mac_AggregateFieldsPerID(reform_lgid3 ,%reform_id%);

  is_overlinked_directly := 
     exists(ds_agg_company_fein_filtered              )
  or exists(ds_agg_duns_number_filtered               )
  or exists(ds_agg_active_enterprise_number_filtered  )
  or exists(ds_agg_active_domestic_corp_key_filtered  )
  or exists(ds_agg_sbfe_id_filtered                   )
  or exists(ds_agg_vl_id_filtered                     )
  ;
  
  result :=  parallel(
     output(pID_Value         ,named('ID'       ))
    ,output(#TEXT(pID_Type)   ,named('ID_Type'  ))
    ,output(pCnp_Name1_regex  ,named('Cnp_Name1'))
    ,output(pCnp_Name2_regex  ,named('Cnp_Name2'))
    ,output(ds_get_bow_field  ,named('ds_get_bow_field'))
    ,output(bow_field1        ,named('bow_field1'))
    ,output(bow_field2        ,named('bow_field2'))
    ,output(get_BOW_Score     ,named('get_BOW_Score'))
    ,output('----------------------------------------',named('_______________________'))
    ,output(enth    (ds_filtered                                                                ,300 )  ,named('Sample_records'                     ))
    ,output(topn    (ds_agg_seleid(#TEXT(pID_Type) != 'seleid' or seleid = pID_Value)           ,300  ,-count_cnp_name_raws )  ,named('Sample_Seleids'                     ),all)
    ,output(topn    (ds_agg_lgid3                                                               ,300  ,-count_cnp_name_raws )  ,named('Sample_lgid3s'                      ),all)
    ,output(topn    (ds_agg_proxid(#TEXT(pID_Type) != 'proxid' or proxid = pID_Value)           ,300  ,-count_cnp_name_raws )  ,named('Sample_proxids'                     ),all)
    ,output(topn    (ds_agg_dotid                                                               ,300  ,-count_cnp_name_raws )  ,named('Sample_dotids'                      ),all)
    ,output(topn    (ds_agg_seleid(#TEXT(pID_Type) != 'seleid' or seleid = pID_Value)           ,300  ,-cnt )  ,named('Biggest_Seleids_rec_Cnt'                     ),all)
    ,output(topn    (ds_agg_lgid3                                                               ,300  ,-cnt )  ,named('Biggest_lgid3s_rec_Cnt'                      ),all)
    ,output(topn    (ds_agg_proxid(#TEXT(pID_Type) != 'proxid' or proxid = pID_Value)           ,300  ,-cnt )  ,named('Biggest_proxids_rec_Cnt'                     ),all)
    ,output(topn    (ds_agg_dotid                                                               ,300  ,-cnt )  ,named('Biggest_dotids_rec_Cnt'                      ),all)
    ,output('----------------------------------------',named('____________________'))
    ,if(exists(ds_agg_dotid_filtered            ) ,output(ds_agg_dotid_filtered             ,named('overlinked_dotids'            ),all))
    ,if(exists(ds_agg_proxid_filtered           ) ,output(ds_agg_proxid_filtered            ,named('overlinked_proxids'           ),all))
    ,if(exists(ds_agg_lgid3_filtered            ) ,output(ds_agg_lgid3_filtered             ,named('overlinked_lgid3s'            ),all))
#IF(pOutputExtraInfo = true)                                    
    ,if(exists(ds_agg_seleid_filtered           ) ,output(ds_agg_seleid_filtered            ,named('overlinked_seleids'           )))
    ,if(exists(ds_agg_orgid_filtered            ) ,output(ds_agg_orgid_filtered             ,named('overlinked_orgids'            )))
    ,if(exists(ds_agg_ultid_filtered            ) ,output(ds_agg_ultid_filtered             ,named('overlinked_ultids'            )))
    ,if(exists(ds_agg_parent_proxid_filtered    ) ,output(ds_agg_parent_proxid_filtered     ,named('overlinked_parent_proxids'    ),all))
    ,if(exists(ds_agg_sele_proxid_filtered      ) ,output(ds_agg_sele_proxid_filtered       ,named('overlinked_sele_proxids'      ),all))
    ,if(exists(ds_agg_org_proxid_filtered       ) ,output(ds_agg_org_proxid_filtered        ,named('overlinked_org_proxids'       ),all))
    ,if(exists(ds_agg_ultimate_proxid_filtered  ) ,output(ds_agg_ultimate_proxid_filtered   ,named('overlinked_ultimate_proxids'  ),all))
#END

    ,output('----------------------------------------',named('_____________________'))
    ,if(exists(ds_agg_company_fein_filtered              ) ,output(topn(ds_agg_company_fein_filtered             ,300,company_fein            ) ,named('overlinked_by_fein'               ),all))
    ,if(exists(ds_agg_duns_number_filtered               ) ,output(topn(ds_agg_duns_number_filtered              ,300,duns_number             ) ,named('overlinked_by_duns'               ),all))
    ,if(exists(ds_agg_active_enterprise_number_filtered  ) ,output(topn(ds_agg_active_enterprise_number_filtered ,300,active_enterprise_number) ,named('overlinked_by_enterprise_number'  ),all))
    ,if(exists(ds_agg_active_domestic_corp_key_filtered  ) ,output(topn(ds_agg_active_domestic_corp_key_filtered ,300,active_domestic_corp_key) ,named('overlinked_by_corpkey'            ),all))
    ,if(exists(ds_agg_sbfe_id_filtered                   ) ,output(topn(ds_agg_sbfe_id_filtered                  ,300,sbfe_id                 ) ,named('overlinked_by_sbfe_id'            ),all))
    ,if(exists(ds_agg_vl_id_filtered                     ) ,output(topn(ds_agg_vl_id_filtered                    ,300,vl_id                   ) ,named('overlinked_by_vl_id'              ),all))
    ,if(exists(ds_agg_source_rid_filtered                ) ,output(topn(ds_agg_source_rid_filtered               ,300,source_record_id        ) ,named('overlinked_by_source_record_id'   ),all))
    ,if(exists(ds_agg_address_filtered                   ) ,output(topn(ds_agg_address_filtered                  ,300,address                 ) ,named('overlinked_by_address'            ),all))
    ,if(exists(ds_agg_phone_filtered                     ) ,output(topn(ds_agg_phone_filtered                    ,300,company_phone           ) ,named('overlinked_by_phone'              ),all))
    
    
    ,output('----------------------------------------',named('___________________________'))
    ,if(exists(ds_agg_cnp_name                           ) ,output(topn(ds_agg_cnp_name                          ,300,-(count_feins + count_a_dunss + count_a_corpkeys))                       ,named('Big_Cnp_Names'                              ),all))
    ,if(exists(ds_agg_address                            ) ,output(topn(ds_agg_address                           ,300,-count_cnp_name_raws                    ) ,named('Big_Addresses'                          ),all))
    ,if(exists(ds_agg_company_fein                       ) ,output(topn(ds_agg_company_fein                      ,300,-count_cnp_name_raws                    ) ,named('Big_feins'                              ),all))
    ,if(exists(ds_agg_sbfe_id                            ) ,output(topn(ds_agg_sbfe_id                           ,300,-count_cnp_name_raws                    ) ,named('Big_sbfe_ids'                           ),all))
    ,if(exists(ds_agg_duns_number                        ) ,output(topn(ds_agg_duns_number                       ,300,-count_cnp_name_raws                    ) ,named('Big_Duns'                               ),all))

    ,if(exists(ds_agg_company_fein_gt1_name              ) ,output(topn(ds_agg_company_fein_gt1_name             ,300,company_fein            ) ,named('fein_with_multiple_names'               ),all))
    ,if(exists(ds_agg_duns_number_gt1_name               ) ,output(topn(ds_agg_duns_number_gt1_name              ,300,duns_number             ) ,named('duns_with_multiple_names'               ),all))
    ,if(exists(ds_agg_active_enterprise_number_gt1_name  ) ,output(topn(ds_agg_active_enterprise_number_gt1_name ,300,active_enterprise_number) ,named('enterprise_number_with_multiple_names'  ),all))
    ,if(exists(ds_agg_active_domestic_corp_key_gt1_name  ) ,output(topn(ds_agg_active_domestic_corp_key_gt1_name ,300,active_domestic_corp_key) ,named('corpkey_with_multiple_names'            ),all))
    ,if(exists(ds_agg_sbfe_id_gt1_name                   ) ,output(topn(ds_agg_sbfe_id_gt1_name                  ,300,sbfe_id                 ) ,named('sbfe_id_with_multiple_names'            ),all))
    ,if(exists(ds_agg_vl_id_gt1_name                     ) ,output(topn(ds_agg_vl_id_gt1_name                    ,300,vl_id                   ) ,named('vl_id_with_multiple_names'              ),all))
    ,if(exists(ds_agg_source_rid_gt1_name                ) ,output(topn(ds_agg_source_rid_gt1_name               ,300,source_record_id        ) ,named('source_record_id_with_multiple_names'   ),all))
    ,if(exists(ds_agg_address_gt1_name                   ) ,output(topn(ds_agg_address_gt1_name                  ,300,address                 ) ,named('address_with_multiple_names'            ),all))
    ,if(exists(ds_agg_phone_gt1_name                     ) ,output(topn(ds_agg_phone_gt1_name                    ,300,company_phone           ) ,named('phone_with_multiple_names'              ),all))

    
    ,output('-----Hierarchy Info.  First record should contain the duns_number/enterprise_number/Franchisee_id that is the base for the hierarchy.  If this is suppressed, the hierarchy will not be created.' ,named('__Hierarch_Info____'))
    ,if(count_lgid3s > 1 ,output(topn(ds_filtered_hrchy_sources_slim ,300
      ,if(proxid = ds_filtered_hrchy_sources_slim[1].ultimate_proxid,0,1)
      ,if(proxid = ds_filtered_hrchy_sources_slim[1].org_proxid     ,0,1)
      ,if(proxid = ds_filtered_hrchy_sources_slim[1].sele_proxid    ,0,1)
      ,if(proxid = ds_filtered_hrchy_sources_slim[1].parent_proxid  ,0,1)
      ,proxid
      ,map(source = mdr.sourcetools.src_DCA             => 0
          ,source = mdr.sourcetools.src_Dunn_Bradstreet => 1
          ,source = mdr.sourcetools.src_Frandx          => 2
          ,                                                2
       )
      
      ,seleid,lgid3,proxid)                           ,named('Hierarchy_Info'                       )))

    ,output('----------------------------------------',named('_________________________'))
    ,output(count_records                           ,named('count_records'                      ))
    ,output(count_ultids                            ,named('count_ultids'                       ))
    ,output(count_orgids                            ,named('count_orgids'                       ))
    ,output(count_seleids                           ,named('count_seleids'                      ))
    ,output(count_lgid3s                            ,named('count_lgid3s'                       ))
    ,output(count_proxids                           ,named('count_proxids'                      ))
    ,output(count_dotids                            ,named('count_dotids'                       ))



    ,output('----------------------------------------',named('________________________'))
    ,output(choosen (ds_agg_lgid3_filtered1 ,300 )  ,named('lgid3s_containing_first_cnp_name'   ),all)
    ,output(choosen (ds_agg_lgid3_filtered2 ,300 )  ,named('lgid3s_containing_second_cnp_name'  ),all)
    ,output(choosen (ds_agg_proxid_filtered1,300 )  ,named('proxids_containing_first_cnp_name'  ),all)
    ,output(choosen (ds_agg_proxid_filtered2,300 )  ,named('proxids_containing_second_cnp_name' ),all)
    ,output(choosen (ds_agg_dotid_filtered1 ,300 )  ,named('dotids_containing_first_cnp_name'   ),all)
    ,output(choosen (ds_agg_dotid_filtered2 ,300 )  ,named('dotids_containing_second_cnp_name'  ),all)


    ,output('----------------------------------------',named('_______________________________'))
    ,output(topn (ds_agg_lgid3_filtered3  ,300 ,-cnt)  ,named('lgid3s_containing_only_first_cnp_name'  ),all)
    ,output(topn (ds_agg_lgid3_filtered4  ,300 ,-cnt)  ,named('lgid3s_containing_only_second_cnp_name'  ),all)
    ,output(topn (ds_agg_proxid_filtered3 ,300 ,-cnt)  ,named('proxids_containing_only_first_cnp_name'  ),all)
    ,output(topn (ds_agg_proxid_filtered4 ,300 ,-cnt)  ,named('proxids_containing_only_second_cnp_name'  ),all)

    ,output('----------------------------------------',named('_____________________________________'))
    ,output(topn (ds_agg_lgid3_filtered5  ,300 ,-cnt)  ,named('lgid3s_NOT_containing_first_cnp_name'  ),all)
    ,output(topn (ds_agg_lgid3_filtered6  ,300 ,-cnt)  ,named('lgid3s_NOT_containing_second_cnp_name'  ),all)
    ,output(topn (ds_agg_proxid_filtered5 ,300 ,-cnt)  ,named('proxids_NOT_containing_first_cnp_name'  ),all)
    ,output(topn (ds_agg_proxid_filtered6 ,300 ,-cnt)  ,named('proxids_NOT_containing_second_cnp_name'  ),all)

    ,output('----------------------------------------',named('_________________________________________'))
    ,output(sum (ds_agg_lgid3_filtered5  ,cnt)  ,named('count_total_recs_of_lgid3s_NOT_containing_first_cnp_name'  ))
    ,output(sum (ds_agg_lgid3_filtered6  ,cnt)  ,named('count_total_recs_of_lgid3s_NOT_containing_second_cnp_name' ))
    ,output(sum (ds_agg_proxid_filtered5 ,cnt)  ,named('count_total_recs_of_proxids_NOT_containing_first_cnp_name' ))
    ,output(sum (ds_agg_proxid_filtered6 ,cnt)  ,named('count_total_recs_of_proxids_NOT_containing_second_cnp_name'))

    ,output('----------------------------------------',named('____________________________________________________________'))
    ,output(topn (ds_agg_seleid_remove_proxids_dont_contain_cnp_name1 ,300 ,-cnt)  ,named('Seleid_NOT_containing_proxids_that_contain_first_cnp_name'  ),all)
    ,output(topn (ds_agg_seleid_remove_proxids_dont_contain_cnp_name2 ,300 ,-cnt)  ,named('Seleid_NOT_containing_proxids_that_contain_second_cnp_name' ),all)
    ,output(topn (ds_agg_seleid_remove_lgid3s_dont_contain_cnp_name1  ,300 ,-cnt)  ,named('Seleid_NOT_containing_lgid3s_that_contain_first_cnp_name'   ),all)
    ,output(topn (ds_agg_seleid_remove_lgid3s_dont_contain_cnp_name2  ,300 ,-cnt)  ,named('Seleid_NOT_containing_lgid3s_that_contain_second_cnp_name'  ),all)

    ,output('----------------------------------------',named('________________________________________________________________'))
    ,output(topn (ds_agg_seleid_filtered_only_cnp_name1 ,300 ,-cnt)  ,named('Seleid_containing_only_records_that_contain_first_cnp_name'  ),all)
    ,output(topn (ds_agg_seleid_filtered_only_cnp_name2 ,300 ,-cnt)  ,named('Seleid_containing_only_records_that_contain_second_cnp_name'  ),all)
    
    ,output('--Can use below rcids to put into BIPV2.ManualSuppression.addCandidates-------',named('_Rcids_For_Suppression_Macro_'))
    ,output(sort (ds_filtered_not_cnp_name1_rcids      ,rcid)  ,named('Seleid_rcids_NOT_containing_first_cnp_name'  ),all)
    ,output(sort (ds_filtered_not_cnp_name2_rcids      ,rcid)  ,named('Seleid_rcids_NOT_containing_second_cnp_name' ),all)

    ,output('--Can use below seleid,proxids to put into BIPV2_Suppression.Proc_build_candidates-------',named('_Seleids_Proxids_For_Suppression_Macro_'))
    ,output(sort (ds_agg_proxid_filtered5_proxids      ,seleid,proxid)  ,named('Seleid_proxids_NOT_containing_first_cnp_name'  ),all)
    ,output(sort (ds_agg_proxid_filtered6_proxids      ,seleid,proxid)  ,named('Seleid_proxids_NOT_containing_second_cnp_name' ),all)

    ,output('--Can use below seleid,proxids to put into BIPV2_Suppression.Proc_build_candidates----------',named('_______Seleids_Proxids_For_Suppression_Macro______'))
    ,output(sum_proxid_filtered7_proxids  ,named('Record_count_proxids_NOT_containing_ONLY_first_cnp_name'  ),all)
    ,output(sum_proxid_filtered8_proxids  ,named('Record_count_proxids_NOT_containing_ONLY_second_cnp_name'  ),all)

    ,output(topn (ds_agg_proxid_filtered7 ,300 ,-cnt)  ,named('proxids_NOT_containing_ONLY_first_cnp_name'  ),all)
    ,output(topn (ds_agg_proxid_filtered8 ,300 ,-cnt)  ,named('proxids_NOT_containing_ONLY_second_cnp_name'  ),all)
    ,output(sort (ds_agg_proxid_filtered7_proxids      ,seleid,proxid)  ,named('Seleid_proxids_NOT_containing_ONLY_first_cnp_name'  ),all)
    ,output(sort (ds_agg_proxid_filtered8_proxids      ,seleid,proxid)  ,named('Seleid_proxids_NOT_containing_ONLY_second_cnp_name' ),all)

/*
    ,if(is_overlinked_directly = false
      ,parallel(
         output('----------------------------------------',named('_______________________________________'))
        ,output(choosen (ds_reform_lgid3_prep ,300 )  ,named('ds_reform_' + %'reform_id'% + '_prep' ),all)
        ,output(choosen (reform_lgid3         ,300 )  ,named('reform_'    + %'reform_id'%           ),all)
        ,output(choosen (reform_lgid3_agg     ,300 )  ,named('reform_'    + %'reform_id'% + '_agg'  ),all)
    ))
*/
  );
  
  return result;
  
endmacro;