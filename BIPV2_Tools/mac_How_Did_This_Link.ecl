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
        (exists(pcnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(pcompany_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase))) )
    and (exists(pcnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(pcompany_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) )
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
  ds_agg_proxid_filtered1 := ds_agg_proxid(exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase))) );
  ds_agg_proxid_filtered2 := ds_agg_proxid(exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );
  ds_agg_dotid_filtered1  := ds_agg_dotid (exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase))) );
  ds_agg_dotid_filtered2  := ds_agg_dotid (exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );

  set_overlinked_proxids  := set(ds_agg_proxid_filtered,proxid);

  ds_proxid_filter                 := ds_filtered;//(count(set_overlinked_proxids) = 0 or proxid in set_overlinked_proxids);
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

  ds_agg_company_fein_gt1_name              := ds_agg_company_fein              (count(cnp_names) > 1,exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))  or exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );
  ds_agg_duns_number_gt1_name               := ds_agg_duns_number               (count(cnp_names) > 1,exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))  or exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );
  ds_agg_active_enterprise_number_gt1_name  := ds_agg_active_enterprise_number  (count(cnp_names) > 1,exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))  or exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );
  ds_agg_active_domestic_corp_key_gt1_name  := ds_agg_active_domestic_corp_key  (count(cnp_names) > 1,exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))  or exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );
  ds_agg_sbfe_id_gt1_name                   := ds_agg_sbfe_id                   (count(cnp_names) > 1,exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))  or exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );
  ds_agg_vl_id_gt1_name                     := ds_agg_vl_id                     (count(cnp_names) > 1,exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))  or exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );
  ds_agg_source_rid_gt1_name                := ds_agg_source_rid                (count(cnp_names) > 1,exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))  or exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );
  ds_agg_address_gt1_name                   := ds_agg_address                   (count(cnp_names) > 1,exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))  or exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );
  ds_agg_phone_gt1_name                     := ds_agg_phone                     (count(cnp_names) > 1,exists(cnp_names(regexfind(pCnp_Name1_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name1_regex,trim(company_name),nocase)))  or exists(cnp_names(regexfind(pCnp_Name2_regex,trim(cnp_name),nocase))) or exists(company_names(regexfind(pCnp_Name2_regex,trim(company_name),nocase))) );

  count_records := count(ds_filtered);
  count_ultids  := count(table(ds_filtered  ,{ultid } ,ultid  ,few));
  count_orgids  := count(table(ds_filtered  ,{orgid } ,orgid  ,few));
  count_seleids := count(table(ds_filtered  ,{seleid} ,seleid ,few));
  count_lgid3s  := count(table(ds_filtered  ,{lgid3 } ,lgid3  ,merge));
  count_proxids := count(table(ds_filtered  ,{proxid} ,proxid ,merge));
  count_dotids  := count(table(ds_filtered  ,{dotid } ,dotid  ,merge));


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
    ,if(exists(ds_agg_company_fein_gt1_name              ) ,output(topn(ds_agg_company_fein_gt1_name             ,300,company_fein            ) ,named('fein_with_multiple_names'               ),all))
    ,if(exists(ds_agg_duns_number_gt1_name               ) ,output(topn(ds_agg_duns_number_gt1_name              ,300,duns_number             ) ,named('duns_with_multiple_names'               ),all))
    ,if(exists(ds_agg_active_enterprise_number_gt1_name  ) ,output(topn(ds_agg_active_enterprise_number_gt1_name ,300,active_enterprise_number) ,named('enterprise_number_with_multiple_names'  ),all))
    ,if(exists(ds_agg_active_domestic_corp_key_gt1_name  ) ,output(topn(ds_agg_active_domestic_corp_key_gt1_name ,300,active_domestic_corp_key) ,named('corpkey_with_multiple_names'            ),all))
    ,if(exists(ds_agg_sbfe_id_gt1_name                   ) ,output(topn(ds_agg_sbfe_id_gt1_name                  ,300,sbfe_id                 ) ,named('sbfe_id_with_multiple_names'            ),all))
    ,if(exists(ds_agg_vl_id_gt1_name                     ) ,output(topn(ds_agg_vl_id_gt1_name                    ,300,vl_id                   ) ,named('vl_id_with_multiple_names'              ),all))
    ,if(exists(ds_agg_source_rid_gt1_name                ) ,output(topn(ds_agg_source_rid_gt1_name               ,300,source_record_id        ) ,named('source_record_id_with_multiple_names'   ),all))
    ,if(exists(ds_agg_address_gt1_name                   ) ,output(topn(ds_agg_address_gt1_name                  ,300,address                 ) ,named('address_with_multiple_names'            ),all))
    ,if(exists(ds_agg_phone_gt1_name                     ) ,output(topn(ds_agg_phone_gt1_name                    ,300,company_phone           ) ,named('phone_with_multiple_names'              ),all))

    ,output('----------------------------------------',named('_________________________'))
    ,output(count_records                           ,named('count_records'                      ))
    ,output(count_ultids                            ,named('count_ultids'                       ))
    ,output(count_orgids                            ,named('count_orgids'                       ))
    ,output(count_seleids                           ,named('count_seleids'                      ))
    ,output(count_lgid3s                            ,named('count_lgid3s'                       ))
    ,output(count_proxids                           ,named('count_proxids'                      ))
    ,output(count_dotids                            ,named('count_dotids'                       ))

    ,output('----------------------------------------',named('_______________________'))
    ,output(enth    (ds_filtered                                                                ,300 )  ,named('Sample_records'                     ))
    ,output(choosen (ds_agg_seleid(#TEXT(pID_Type) != 'seleid' or seleid = pID_Value)           ,300 )  ,named('Sample_Seleids'                     ),all)
    ,output(choosen (ds_agg_lgid3                                                               ,300 )  ,named('Sample_lgid3s'                      ),all)
    ,output(choosen (ds_agg_proxid(#TEXT(pID_Type) != 'proxid' or proxid = pID_Value)           ,300 )  ,named('Sample_proxids'                     ),all)
    ,output(choosen (ds_agg_dotid                                                               ,300 )  ,named('Sample_dotids'                      ),all)

    ,output('----------------------------------------',named('________________________'))
    ,output(choosen (ds_agg_lgid3_filtered1 ,300 )  ,named('lgid3s_containing_first_cnp_name'   ),all)
    ,output(choosen (ds_agg_lgid3_filtered2 ,300 )  ,named('lgid3s_containing_second_cnp_name'  ),all)
    ,output(choosen (ds_agg_proxid_filtered1,300 )  ,named('proxids_containing_first_cnp_name'  ),all)
    ,output(choosen (ds_agg_proxid_filtered2,300 )  ,named('proxids_containing_second_cnp_name' ),all)
    ,output(choosen (ds_agg_dotid_filtered1 ,300 )  ,named('dotids_containing_first_cnp_name'   ),all)
    ,output(choosen (ds_agg_dotid_filtered2 ,300 )  ,named('dotids_containing_second_cnp_name'  ),all)
    ,if(is_overlinked_directly = false
      ,parallel(
         output('----------------------------------------',named('_______________________________________'))
        ,output(choosen (ds_reform_lgid3_prep ,300 )  ,named('ds_reform_' + %'reform_id'% + '_prep' ),all)
        ,output(choosen (reform_lgid3         ,300 )  ,named('reform_'    + %'reform_id'%           ),all)
        ,output(choosen (reform_lgid3_agg     ,300 )  ,named('reform_'    + %'reform_id'% + '_agg'  ),all)
    ))
  );
  
  return result;
  
endmacro;