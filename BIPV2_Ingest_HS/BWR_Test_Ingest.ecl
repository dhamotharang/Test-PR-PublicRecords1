#OPTION('multiplePersistInstances',true);

// -- Set these three to what source(s) you are testing.  This example is for 4 corporation states, AK, DC, NV & OK.
// -- ds_as_linking_sample -- this is pointing to the corp as linking file for those states, but could easily be
// --                         the as_linking attribute for a particular source(list in BIPV2.Business_Sources)
// --                         ,such as DNB_DMI.As_Business_Linking()
set_sample_sources    := [mdr.sourcetools.src_AK_Corporations,mdr.sourcetools.src_DC_Corporations,mdr.sourcetools.src_NV_Corporations,mdr.sourcetools.src_OK_Corporations];
ds_as_linking_sample  := dataset(ut.foreign_dataland + 'thor_data400::temp::corp2::as_Business_Linking_AK_DC_NV_OK' ,Business_Header.Layout_Business_Linking.Linking_Interface,flat);
ds_base_sample        := bipv2.commonbase.ds_base(source in set_sample_sources) : persist('~persist::bipv2_ingest_hs::ds_base_sample');


// output(ds_as_linking_sample);
ds_as_linking_sample_prep_ingest := BIPV2_Files.tools_dotid(project(ds_as_linking_sample,BIPV2_Files.layout_ingest)).base;

do_ingest := BIPV2_Ingest_HS.Ingest(,,ds_base_sample,ds_as_linking_sample_prep_ingest,'~temp::BIPV2_Ingest_HS::Ingest_Cache.test');

ingest_results     := PROJECT(do_ingest.AllRecords, TRANSFORM(BIPV2.CommonBase.Layout, SELF.ingest_status:=BIPV2_Ingest_HS.Ingest().RTToText(LEFT.__Tpe), SELF:=LEFT));
// SHARED ds_re_DID   := BIPV2_Files.tools_dotid().APPEND_DID(distribute(BIPV2_Ingest_HS.omittedSources.preserve(ingest_results)));//this can get skewed, so add distribute
// SHARED ds_ingested := project(ds_re_DID,recordof(BIPV2_Ingest_HS.In_BASE));  

output(count(ds_as_linking_sample            )  ,named('count_ds_as_linking_sample'            ));
output(count(ds_as_linking_sample_prep_ingest)  ,named('count_ds_as_linking_sample_prep_ingest'));
output(count(ds_base_sample          )  ,named('count_ds_base_sample'          ));

output(choosen(ds_as_linking_sample            ,100)  ,named('ds_as_linking_sample'            ));
output(choosen(ds_as_linking_sample_prep_ingest,100)  ,named('ds_as_linking_sample_prep_ingest'));
output(choosen(ds_base_sample          ,100)  ,named('ds_base_sample'          ));

output(ingest_results ,,'~temp::lbentley::ingest_results_corp_ak_dc_nv_ok',__compressed__,overwrite);
output(table(ingest_results ,{ingest_status ,unsigned cnt := count(group)},ingest_status,merge) ,named('ingest_statuses'));
output(sort(table(ingest_results ,{string source := mdr.sourcetools.translatesource(source),ingest_status ,unsigned cnt := count(group)},source,ingest_status,merge),source,ingest_status) ,named('ingest_statuses_by_source'));

output(sort(table(ingest_results ,{string source := mdr.sourcetools.translatesource(source),company_name_type_raw,ingest_status ,unsigned cnt := count(group)},source,company_name_type_raw,ingest_status,merge),source,company_name_type_raw,ingest_status) ,named('ingest_statuses_by_source_name_type'),all);

// -- these are for individual sources to see examples of what fields changed.
// -- it has examples for the 4 corp states, but if you are doing a different source, then use that source to filter
///////////////////////////////////////
ingest_results_ak_new := ingest_results(source = mdr.sourcetools.src_AK_Corporations  ,ingest_status = 'New');
ingest_results_ak_old := ingest_results(source = mdr.sourcetools.src_AK_Corporations  ,ingest_status = 'Old');

ds_srid_but_diff_status_ak := join(ingest_results_ak_new ,ingest_results_ak_old ,left.source_record_id = right.source_record_id and left.company_name_type_raw = right.company_name_type_raw and left.fname  = right.fname and left.prim_name = right.prim_name,transform({dataset({string ingest_status,BIPV2.CommonBase.Layout - ingest_status}) recs}
,self.recs := project(dataset(left) ,transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
+ project(dataset(right),transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
),hash);

output(count(ds_srid_but_diff_status_ak)  ,named('count_ds_srid_but_diff_status_ak'));

output(enth(ds_srid_but_diff_status_ak,500)  ,named('ds_srid_but_diff_status_ak'),all);
/////////////////////////////////////////////////////////
ingest_results_DC_new := ingest_results(source = mdr.sourcetools.src_DC_Corporations,ingest_status = 'New');
ingest_results_DC_old := ingest_results(source = mdr.sourcetools.src_DC_Corporations,ingest_status = 'Old');

ds_srid_but_diff_status_DC := join(ingest_results_DC_new ,ingest_results_DC_old ,left.source_record_id = right.source_record_id and left.company_name_type_raw = right.company_name_type_raw and left.fname  = right.fname and left.prim_name = right.prim_name,transform({dataset({string ingest_status,BIPV2.CommonBase.Layout - ingest_status}) recs}
,self.recs := project(dataset(left) ,transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
+ project(dataset(right),transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
),hash);

output(count(ds_srid_but_diff_status_DC)  ,named('count_ds_srid_but_diff_status_DC'));

output(enth(ds_srid_but_diff_status_DC,500)  ,named('ds_srid_but_diff_status_DC'),all);
////////////////////////////////////////////////////////////////
ingest_results_NV_new := ingest_results(source = mdr.sourcetools.src_NV_Corporations,ingest_status = 'New');
ingest_results_NV_old := ingest_results(source = mdr.sourcetools.src_NV_Corporations,ingest_status = 'Old');

ds_srid_but_diff_status_NV := join(ingest_results_NV_new ,ingest_results_NV_old ,left.source_record_id = right.source_record_id and left.company_name_type_raw = right.company_name_type_raw and left.fname  = right.fname and left.prim_name = right.prim_name,transform({dataset({string ingest_status,BIPV2.CommonBase.Layout - ingest_status}) recs}
,self.recs := project(dataset(left) ,transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
+ project(dataset(right),transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
),hash);

output(count(ds_srid_but_diff_status_NV)  ,named('count_ds_srid_but_diff_status_NV'));

output(enth(ds_srid_but_diff_status_NV,500)  ,named('ds_srid_but_diff_status_NV'),all);
////////////////////////////////////////////////////////////////
ingest_results_OK_new := ingest_results(source = mdr.sourcetools.src_OK_Corporations,ingest_status = 'New');
ingest_results_OK_old := ingest_results(source = mdr.sourcetools.src_OK_Corporations,ingest_status = 'Old');

ds_srid_but_diff_status_OK := join(ingest_results_OK_new ,ingest_results_OK_old ,left.source_record_id = right.source_record_id and left.company_name_type_raw = right.company_name_type_raw and left.fname  = right.fname and left.prim_name = right.prim_name,transform({dataset({string ingest_status,BIPV2.CommonBase.Layout - ingest_status}) recs}
,self.recs := project(dataset(left) ,transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
+ project(dataset(right),transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
),hash);

output(count(ds_srid_but_diff_status_OK)  ,named('count_ds_srid_but_diff_status_OK'));

output(enth(ds_srid_but_diff_status_OK,500)  ,named('ds_srid_but_diff_status_OK'),all);
////////////////////////////////////////////////////////////////
/*
ds_ingest := BIPV2_Files.files_ingest.DS_BASE;

ds_ingest_nm_nj          := ds_ingest(source in [mdr.sourcetools.src_NM_Corporations,mdr.sourcetools.src_NJ_Corporations]) : persist('~persist::lbentley::ds_ingest_nm_nj');

ds_srid_but_diff_cname := join(ds_ingest_nm_nj ,ds_as_linking_sample ,left.source = right.source and left.source_record_id = right.source_record_id and left.company_name_type_raw = right.company_name_type_raw and left.company_name != right.company_name ,transform({dataset({string file,recordof(left)}) recs}
,self.recs := project(dataset(left) ,transform({string file,BIPV2.CommonBase.Layout},self.file := 'Ingest',self := left,self := []))
+ project(dataset(right),transform({string file,BIPV2.CommonBase.Layout},self.file := 'Rewrite',self := left,self := []))
),hash);

ds_srid_but_same_cname:= join(ds_ingest_nm_nj ,ds_as_linking_sample ,left.source = right.source and left.source_record_id = right.source_record_id and left.company_name_type_raw = right.company_name_type_raw and left.company_name = right.company_name ,transform({dataset({string file,recordof(left)}) recs}
,self.recs := project(dataset(left) ,transform({string file,BIPV2.CommonBase.Layout},self.file := 'Ingest',self := left,self := []))
+ project(dataset(right),transform({string file,BIPV2.CommonBase.Layout},self.file := 'Rewrite',self := left,self := []))
),hash);

output(count(ds_as_linking_sample            ) ,named('count_ds_as_linking_sample'            ));
output(count(ds_ingest              ) ,named('count_ds_ingest'              ));
output(count(ds_ingest_nm_nj        ) ,named('count_ds_ingest_nm_nj'        ));
output(count(ds_srid_but_diff_cname ) ,named('count_ds_srid_but_diff_cname' ));
output(count(ds_srid_but_same_cname ) ,named('count_ds_srid_but_same_cname' ));

output(choosen(ds_as_linking_sample            ,100) ,named('ds_as_linking_sample'            ));
output(choosen(ds_ingest              ,100) ,named('ds_ingest'              ));
output(choosen(ds_ingest_nm_nj        ,100) ,named('ds_ingest_nm_nj'        ));
output(choosen(ds_srid_but_diff_cname ,100) ,named('ds_srid_but_diff_cname' ));
output(choosen(ds_srid_but_same_cname ,100) ,named('ds_srid_but_same_cname' ));
*/
/*
ds_slim := table(ds_ingest(source = mdr.sourcetools.src_NJ_Corporations,regexfind('new',ingest_status,nocase))  ,{company_name,vl_id,source_record_id,ingest_status});

,title
,fname
,mname
,lname
,name_suffix
,company_name
,company_name_type_raw
,prim_range
,predir
,prim_name
,postdir
,sec_range
,v_city_name
,st
,zip
,zip4
,company_address_type_raw
,company_fein
,best_fein_indicator
,company_phone
,phone_type
,phone_score
,company_org_structure_raw
,company_sic_code1
,company_sic_code2
,company_sic_code3
,company_sic_code4
,company_sic_code5
,company_naics_code1
,company_naics_code2
,company_naics_code3
,company_naics_code4
,company_naics_code5
,company_ticker
,company_ticker_exchange
,company_url
,company_inc_state
,company_charter_number
,company_name_status_raw
,company_status_raw
,vl_id
,contact_type_raw
,contact_job_title_raw
,contact_ssn
,contact_dob
,contact_status_raw
,contact_email
,contact_phone
,from_hdr
,company_department
*/