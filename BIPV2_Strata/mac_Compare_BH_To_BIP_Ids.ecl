/*
Bug: 178358 - Linking 2.2 : consolidate contacts index with EmpID
next steps are:
create table by source and file(bip or old bh) on bdid->lexid and powid->lexid
so we can see our progress.
do overall powid->lexid and bdid->lexid stats for 2.2, maybe also empid.

mac_Compare_BH_To_BIP_Ids(pIsTesting := true);
*/
import bipv2_build,paw,bipv2,strata;

EXPORT mac_Compare_BH_To_BIP_Ids(
   pversion     = 'bipv2.KeySuffix'                           // build date
  ,pPaw_Base    = 'paw.File_Base'           
  ,pBIP_Base    = 'bipv2.CommonBase.ds_built'
  ,pBIP_Key     = 'BIPV2_Build.key_contact_linkids.keybuilt'
  ,pEmail_List  = 'BIPV2_Build.mod_email.emailList'           // email list 
  ,pIsTesting   = 'false'
  ,pOverwrite   = 'false'
) :=
functionmacro

  import bipv2_build,paw,bipv2,strata;
  
  dBIP := table(pBIP_Base,{source,powid,empid,contact_did}) + table(pBIP_Key,{source,powid,empid,contact_did});

  bh_base       := pPaw_Base  (bdid  != 0,did         != 0);
  bip_base      := dBIP       (powid != 0,contact_did != 0);
  bip_base_emp  := dBIP       (empid != 0,contact_did != 0);

  countgroup := count(bip_base) + count(bh_base);

  source_table  := table(table(bh_base     ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source)})
                        +table(bip_base    ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source)}),{source,unsigned cnt := count(group)},source,merge);
                                                                                                                              
  bh_source_table_bdid   := table(table(bh_base     ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),bdid ,did        }),{source,bdid ,did        },source,bdid ,did        ,merge);
  bip_source_table_powid := table(table(bip_base    ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),powid,contact_did}),{source,powid,contact_did},source,powid,contact_did,merge);
  bip_source_table_empid := table(table(bip_base_emp,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),empid,contact_did}),{source,empid,contact_did},source,empid,contact_did,merge);

  bh_source_table_bdid2   := table(bh_source_table_bdid  ,{source,unsigned cnt := count(group)},source,merge);
  bip_source_table_powid2 := table(bip_source_table_powid,{source,unsigned cnt := count(group)},source,merge);
  bip_source_table_empid2 := table(bip_source_table_empid,{source,unsigned cnt := count(group)},source,merge);

  lay_strata := {string source,unsigned countgroup := 0,unsigned cnt_bdid_did,unsigned cnt_powid_did,unsigned cnt_empid_did := 0};

  ds_join_powid_bdid := join(bh_source_table_bdid2,bip_source_table_powid2,left.source = right.source,transform(
    lay_strata
    ,self.source        := if(left.source != '',left.source,right.source)
    ,self.cnt_bdid_did  := left.cnt
    ,self.cnt_powid_did := right.cnt
  ), full outer);

  ds_join_empid := join(ds_join_powid_bdid,bip_source_table_empid2,left.source = right.source,transform(
    lay_strata
    ,self.source        := if(left.source != '',left.source,right.source)
    ,self.cnt_bdid_did  := left.cnt_bdid_did
    ,self.cnt_powid_did := left.cnt_powid_did
    ,self.cnt_empid_did := right.cnt
    ,self.countgroup    := 0
  ), full outer);

  ds_join_source_table := join(ds_join_empid,source_table,left.source = right.source,transform(
    lay_strata
    ,self.source        := if(left.source != '',left.source,right.source) //should not need this, but just in case
    ,self.cnt_bdid_did  := left.cnt_bdid_did 
    ,self.cnt_powid_did := left.cnt_powid_did
    ,self.cnt_empid_did := left.cnt_empid_did   
    ,self.countgroup    := right.cnt
  ), full outer);

  //add in totals
  bdid_totals  := count(table(bh_base       ,{bdid ,did        },bdid ,did         ,merge));
  powid_totals := count(table(bip_base      ,{powid,contact_did},powid,contact_did ,merge));
  empid_totals := count(table(bip_base_emp  ,{empid,contact_did},empid,contact_did ,merge));

  ds_totals := dataset([

  {'Total',countgroup,bdid_totals,powid_totals,empid_totals }

  ],lay_strata);

  ds_total := sort(ds_join_source_table           ,source) + ds_totals
  : independent;

  // return parallel(
     // output(sort(ds_join_empid           ,source) + ds_totals ,named('Bdid_Lexid_Powid_lexid_table' ),all)
    // ,output(sort(bip_source_table_empid2 ,source)             ,named('bip_source_table_empid'       ),all)
    // ,output(sort(bh_source_table_bdid2   ,source)             ,named('bh_source_table_bdid2'        ),all)
    // ,output(sort(bip_source_table_powid2 ,source)             ,named('bip_source_table_powid2'      ),all)
  // );
  return Strata.macf_CreateXMLStats (ds_total ,'BIPV2','2.2'  ,pversion	,pEmail_List	,'VS_BDID' ,'POWID'	,pIsTesting,pOverwrite);

endmacro;
