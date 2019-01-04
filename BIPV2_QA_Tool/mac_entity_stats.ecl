/* BH-579 QA monitoring tool - Postlink and Entity stats 

entity stats:

  new ids by source   : clusters that contain source and did not exist in father file
  matches by source   : new records with did < rid, or existing records that have new did < father did
  singletons by source: BIPV2_Strata.mac_Single_Multi_Sourced_IDS
  total ids by source : BIPV2_Strata.mac_Single_Multi_Sourced_IDS

ID 	    Src Description 	Stat 	                  Stat Value 
Proxid	ADLEQ 	          New ID's by source 	    0
Proxid	ADLEQ 	          Matches by Source 	    0
Proxid	ADLEQ 	          Singletons by Source 	  0
Proxid	ADLEQ 	          Total ID's by source	  0

*/

EXPORT mac_entity_stats(
   pversion           = 'bipv2.KeySuffix'                           // build date
  ,pDs_Base           = 'bipv2.CommonBase.ds_built'
  ,pDs_Father         = 'bipv2.CommonBase.ds_base'
  ,pBIP_ID            = 'Seleid'                                    // ID to do this on  
  ,pReturnDatasetOnly = 'false'
) :=
functionmacro

  import BIPV2_Strata;
  
  layout_result := BIPV2_QA_Tool.Layouts.entity_stats;

  // -- execute BIPV2_Strata.mac_Single_Multi_Sourced_IDS to get singletons and total ids per source
  ds_singletons_and_total_ids_per_source      := BIPV2_Strata.mac_Single_Multi_Sourced_IDS(pversion,pDs_Base,pBIP_ID,pOutputDatasetOnly := true);
  ds_singletons_and_total_ids_per_source_slim := table(ds_singletons_and_total_ids_per_source ,{source,countgroup,cnt_single_source});
  
  // -- Get new ids by source   : clusters that contain source and did not exist in father file
  ds_base_slim_new_ids            := table(pDs_Base    ,{pBIP_ID ,string source := mdr.sourceTools.translatesource(source)} ,pBIP_ID ,source ,merge);
  ds_father_slim_new_ids          := table(pDs_Father  ,{pBIP_ID ,string source := mdr.sourceTools.translatesource(source)} ,pBIP_ID ,source ,merge);
  ds_new_ids_by_source            := join(ds_base_slim_new_ids ,ds_father_slim_new_ids ,left.pBIP_ID = right.pBIP_ID ,transform(left)  ,left only   ,hash);
  ds_new_ids_by_source_cnt_prep   := table(ds_new_ids_by_source  ,{source,unsigned cnt := count(group)}  ,source,few);
  ds_sources_missed               := join(ds_new_ids_by_source_cnt_prep  ,table(ds_base_slim_new_ids,{source},source,few),left.source = right.source ,transform(recordof(left),self.source := right.source,self.cnt := 0)  ,right only,hash);
  ds_new_ids_by_source_cnt        := ds_new_ids_by_source_cnt_prep + ds_sources_missed;
  
  // -- Get matches by source   : new records with did < rid, or existing records that have new did < father did
  ds_get_father_did := join(table(pDs_Base,{rcid,pBIP_ID,ingest_status,string source := mdr.sourceTools.translatesource(source)})  ,table(pDs_Father,{rcid,pBIP_ID,ingest_status,string source := mdr.sourceTools.translatesource(source)}) ,left.rcid = right.rcid ,transform({recordof(left) base_rec,recordof(right) father_rec},self.base_rec := left,self.father_rec := right) ,left outer ,keep(1) ,hash);
  ds_matches_records := ds_get_father_did(
    ( // -- new records with did < rid
          trim(base_rec.ingest_status)  = 'New' 
      and      base_rec.pBIP_ID         < base_rec.rcid
    )
    or ( // -- existing records that have new did < father did
          trim(base_rec.ingest_status) != 'New'   
      and      base_rec.pBIP_ID         < father_rec.pBIP_ID
    )
  );
  ds_matches_clusters_prep  := table(ds_matches_records ,{string source := base_rec.source,unsigned6 pBIP_ID := base_rec.pBIP_ID} ,base_rec.source,base_rec.pBIP_ID ,merge);
  ds_matches_clusters_prep2 := table(ds_matches_clusters_prep ,{source,unsigned cnt := count(group)} ,source ,merge);
  ds_matches_clusters_nomatches := join(ds_matches_clusters_prep2 ,ds_singletons_and_total_ids_per_source_slim
    ,left.source = right.source
    ,transform(recordof(ds_matches_clusters_prep2),self.source := right.source,self.cnt := 0)
    ,right only
  );
  ds_matches_clusters := ds_matches_clusters_prep2 + ds_matches_clusters_nomatches;

  // concatenate them together for output
  ds_singletons_and_total_ids_per_source_norm := normalize(ds_singletons_and_total_ids_per_source_slim  ,2  ,transform({unsigned srt,layout_result}
    ,self.ID              := trim(#TEXT(pBIP_ID))
    ,self.version         := pversion
    ,self.src             := left.source
    ,self.Statname        := if(counter = 1 ,'Singletons by Source' ,'Total ID\'s by source')
    ,self.StatValue       := (string)if(counter = 1 ,left.cnt_single_source ,left.countgroup        )
    ,self.srt             := if(counter = 1 ,3,4)
  ));

  ds_new_ids_by_source_result := project(ds_new_ids_by_source_cnt ,transform({unsigned srt,layout_result}
    ,self.ID              := trim(#TEXT(pBIP_ID))
    ,self.version         := pversion
    ,self.src             := left.source
    ,self.Statname        := 'New ID\'s by source'
    ,self.StatValue       := (string)left.cnt
    ,self.srt             := 1  
  ));

  ds_matches_clusters_result := project(ds_matches_clusters ,transform({unsigned srt,layout_result}
    ,self.ID              := trim(#TEXT(pBIP_ID))
    ,self.version         := pversion
    ,self.src             := left.source
    ,self.Statname        := 'Matches by Source'
    ,self.StatValue       := (string)left.cnt
    ,self.srt             := 2  
  ));
  
  ds_concat := 
      ds_new_ids_by_source_result 
    + ds_matches_clusters_result 
    + ds_singletons_and_total_ids_per_source_norm
    ;
    
  ds_result := project(sort(ds_concat ,src,srt) ,layout_result);


  #IF(pReturnDatasetOnly = false)
    import tools;
    output_result := tools.macf_WriteFile(BIPV2_QA_Tool.Filenames(pversion,,#TEXT(pBIP_ID)).Entity_Stats.logical ,ds_result ,pOverwrite := true);
    return_result := sequential(
       output_result
      ,BIPV2_QA_Tool.Promote(pversion,#TEXT(pBIP_ID)).new2qaMult
    );
    return return_result;
  #ELSE
    return ds_result;
  #END
  
endmacro;