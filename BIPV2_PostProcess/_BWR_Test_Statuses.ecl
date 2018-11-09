/*
  update bug with findings from meeting
    start with runtime, but fix multiple location bug and also the recent bug(most recent = inactive, but it still flags as active.  
    take a look at the status key, chad said some are blank)

    runtime says this seleid is defunct 9256900.  should probably not be.  why does it flag it as such?

*/
ds_sample1         := BIPV2.CommonBase.DS_CLEAN_BASE(
                      st           in ['FL','GA','OH']
                     ,v_city_name  in ['ALPHARETTA','BOCA RATON','DELRAY BEACH','DAYTON','MIAMISBURG']);
ds_seleids := table(ds_sample1 ,{seleid},seleid,merge);
ds_sample := join(BIPV2.CommonBase.DS_CLEAN_BASE,ds_seleids  ,left.seleid = right.seleid ,transform(left),hash)
                     : persist('~persist::lbentley::Bug::174796_LINKING_ETS_reconcile_segmentation_code.ds_sample');
                   ;

ds_regular_segs	  := BIPV2_PostProcess.segmentation     (ds_sample,'SELEID').result;
ds_gold_segs	    := BIPV2_PostProcess.segmentation_gold(ds_sample,'SELEID').result;
ds_runtime_segs   := BIPV2_Tools.mac_Set_Statuses       (ds_sample         );
// ds_runtime_segs   := BIPV2.mac_AddStatus                (ds_sample         );

ds_runtime_segs_slim := project(ds_runtime_segs  ,transform(recordof(ds_gold_segs)
  ,self.idname        := 'SELEID'
  ,self.id            := left.seleid
  ,self.reccnt        := 1
  ,self.core          := if(left.isactive = true  ,'1'  ,'')
  ,self.emergingcore  := ''
  ,self.inactive      := map(left.isactive = false and left.isdefunct = false  => 'I'
                            ,left.isactive = false and left.isdefunct = true   => 'D'
                            ,'')
));
ds_runtime_segs_dedup := table(ds_runtime_segs_slim ,{idname,id,reccnt,core,emergingcore,inactive},idname,id,reccnt,core,emergingcore,inactive,merge);

ds_table_inactive_diffs := 
    table(ds_regular_segs       ,{string file := 'regular',inactive,unsigned cnt := count(group)},inactive,merge)
  + table(ds_gold_segs          ,{string file := 'Gold'   ,inactive,unsigned cnt := count(group)},inactive,merge)
  + table(ds_runtime_segs_dedup ,{string file := 'Runtime',inactive,unsigned cnt := count(group)},inactive,merge)
  ;
  
ds_combine_regular_gold := join(ds_regular_segs ,ds_gold_segs ,left.id = right.id 
  ,transform({unsigned6 id,dataset({string file,recordof(ds_regular_segs) - id - idname - reccnt - core - emergingcore}) recs}
    ,self.recs := project(dataset(left ),transform({string file,recordof(ds_regular_segs) - id - idname - reccnt - core - emergingcore},self.file := 'Regular',self := left))
                + project(dataset(right),transform({string file,recordof(ds_regular_segs) - id - idname - reccnt - core - emergingcore},self.file := 'Gold'   ,self := left))  
    ,self := left
  )
,hash);  
  
ds_combine_regular_gold_runtime := join(ds_combine_regular_gold ,ds_runtime_segs_dedup ,left.id = right.id 
  ,transform(recordof(left)
    ,self.recs := left.recs 
                + project(dataset(right),transform({string file,recordof(ds_regular_segs)- id - idname - reccnt - core - emergingcore},self.file := 'Runtime',self := left))  
    ,self := left
  )
,hash);  

  
 hrec := record
		unsigned6 	id;
			string source;
			ds_sample.dt_last_seen;
			ds_sample.company_status_derived;
			ds_sample.company_name;
			ds_sample.zip;
			ds_sample.prim_range;
			ds_sample.prim_name;
			ds_sample.sec_range;
			string30 company_status_derived_w_date := '';
			string50 source_decoded_w_type := '';
			string addr_type := '';
	end;

ds_sample_slim := project(ds_sample ,transform(hrec,self.id := left.seleid
  // ,self.source := if(left.source in BIPV2_PostProcess.constants.tricore ,'Tricore'  ,mdr.sourcetools.translatesource(left.source))
  ,self.source := mdr.sourcetools.translatesource(left.source)
  ,self := left));
  
ds_sample_dedup := dedup(
                    sort(
                      distribute(ds_sample_slim/*(company_status_derived != '' or source = 'TC')*/,hash64(source,company_status_derived,company_name,zip,prim_range,prim_name,sec_range))
                    ,source,company_status_derived,company_name,zip,prim_range,prim_name,sec_range,-dt_last_seen,local)
                    ,source,company_status_derived,company_name,zip,prim_range,prim_name,sec_range,local
                  );

ds_sample_rollup_prep := project(ds_sample_dedup  ,transform(
{unsigned6 id,unsigned6 latest_dt_last_seen,dataset({string status}) latest_statuses,dataset(hrec - id) base_recs}
,self.id := left.id
,self.base_recs := project(dataset(left)  ,recordof(left) - id)
,self.latest_dt_last_seen := left.dt_last_seen
,self.latest_statuses := dataset([left.company_status_derived],{string status})
));

ds_rollup := rollup(sort(distribute(ds_sample_rollup_prep,id),id,-base_recs[1].dt_last_seen,local) ,left.id = right.id ,transform(
  recordof(left)
  ,self.id := left.id
  ,self.base_recs := left.base_recs + right.base_recs(company_status_derived != '' or source = 'TC')
  ,self.latest_dt_last_seen := left.latest_dt_last_seen
  ,self.latest_statuses     := left.latest_statuses 
                             + if(ut.MonthsApart((string)self.latest_dt_last_seen,(string)right.latest_dt_last_seen) <= 3,right.latest_statuses,dataset([],{string status}))
  
),local);

//get examples of differences
ds_get_examples := join(ds_rollup,ds_combine_regular_gold_runtime,left.id = right.id,transform(
  {unsigned6 id,recordof(ds_combine_regular_gold_runtime),dataset({string status,unsigned cnt}) latest_statuses,recordof(ds_rollup) - id - latest_statuses - latest_dt_last_seen}
  ,self.base_recs := choosen(left.base_recs,30)
  ,self.recs := choosen(right.recs,30)
  ,self.id    := left.id
  ,self.latest_statuses := sort(table(left.latest_statuses ,{status,unsigned cnt := count(group)},status),-cnt)
),hash);

ds_get_examples_diffs_reg_gold   := ds_get_examples(recs(file = 'Regular')[1].inactive != recs(file = 'Gold'   )[1].inactive);
ds_get_examples_diffs_gold_rtime := ds_get_examples(recs(file = 'Gold'   )[1].inactive != recs(file = 'Runtime')[1].inactive);
ds_get_examples_diffs_reg_rtime  := ds_get_examples(recs(file = 'Regular')[1].inactive != recs(file = 'Runtime')[1].inactive);

ds_all_examples_diffs := ds_get_examples( recs(file = 'Gold'   )[1].inactive != recs(file = 'Runtime')[1].inactive
                                   or recs(file = 'Regular')[1].inactive != recs(file = 'Gold'   )[1].inactive
                                   or recs(file = 'Regular')[1].inactive != recs(file = 'Runtime')[1].inactive
                                   );
output(count(ds_regular_segs) ,named('count_ds_regular_segs'));
output(count(ds_gold_segs	  ) ,named('count_ds_gold_segs'	  ));
output(count(ds_runtime_segs_dedup) ,named('count_ds_runtime_segs_dedup'));
output(count(ds_all_examples_diffs) ,named('count_ds_all_examples_diffs'));

output(topn(ds_regular_segs ,100,id),named('ds_regular_segs'));
output(topn(ds_gold_segs	  ,100,id),named('ds_gold_segs'	  ));
output(topn(ds_runtime_segs_dedup ,100,id),named('ds_runtime_segs_dedup'));
output(ds_table_inactive_diffs,named('ds_table_inactive_diffs'));

output(topn(ds_combine_regular_gold ,100,id),named('ds_combine_regular_gold'));
output(topn(ds_combine_regular_gold_runtime ,100,id),named('ds_combine_regular_gold_runtime'));
output(topn(ds_sample_slim  ,100,id),named('ds_sample_slim' ));
output(topn(ds_sample_dedup ,100,id),named('ds_sample_dedup'));
output(topn(ds_get_examples ,100,id),named('ds_get_examples'));

// output(topn(ds_get_examples_diffs_reg_gold   ,100,id),named('ds_get_examples_diffs_reg_gold'  ));
// output(topn(ds_get_examples_diffs_gold_rtime ,100,id),named('ds_get_examples_diffs_gold_rtime'));
// output(topn(ds_get_examples_diffs_reg_rtime  ,100,id),named('ds_get_examples_diffs_reg_rtime' ));

output(ds_all_examples_diffs[1..20],named('CM_examples' ));
output(ds_all_examples_diffs[21..40],named('VB_examples' ));
output(ds_all_examples_diffs[41..60],named('DS_examples' ));
output(ds_all_examples_diffs[61..80],named('DW_examples' ));
output(ds_all_examples_diffs[81..100],named('AL_examples' ));
output(ds_all_examples_diffs[101..120],named('HS_examples' ));

// BIPV2.IDmacros(155,2)