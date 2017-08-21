#OPTION('multiplePersistInstances',true);

ds_new_corp := dataset(ut.foreign_dataland + 'thor_data400::temp::corp2::as_Business_Linking_NM_NJ' ,Business_Header.Layout_Business_Linking.Linking_Interface,flat);
// output(ds_new_corp);
ds_new_corp_prep_ingest := BIPV2_Files.tools_dotid(project(ds_new_corp,BIPV2_Files.layout_ingest)).base;
ds_base_nj_nm           := bipv2.commonbase.ds_base(source in [mdr.sourcetools.src_NM_Corporations,mdr.sourcetools.src_NJ_Corporations]) : persist('~persist::lbentley::ds_base_nj_nm');

do_ingest := BIPV2_Ingest.Ingest(ds_new_corp_prep_ingest,ds_base_nj_nm,'~temp::BIPV2_Ingest::Ingest_Cache.verntest');

ingest_results     := PROJECT(do_ingest.AllRecords, TRANSFORM(BIPV2.CommonBase.Layout, SELF.ingest_status:=BIPV2_Ingest.Ingest().RTToText(LEFT.__Tpe), SELF:=LEFT));
// SHARED ds_re_DID   := BIPV2_Files.tools_dotid().APPEND_DID(distribute(bipv2_ingest.omittedSources.preserve(ingest_results)));//this can get skewed, so add distribute
// SHARED ds_ingested := project(ds_re_DID,recordof(BIPV2_Ingest.In_BASE));  

output(count(ds_new_corp            )  ,named('count_ds_new_corp'            ));
output(count(ds_new_corp_prep_ingest)  ,named('count_ds_new_corp_prep_ingest'));
output(count(ds_base_nj_nm          )  ,named('count_ds_base_nj_nm'          ));

output(choosen(ds_new_corp            ,100)  ,named('ds_new_corp'            ));
output(choosen(ds_new_corp_prep_ingest,100)  ,named('ds_new_corp_prep_ingest'));
output(choosen(ds_base_nj_nm          ,100)  ,named('ds_base_nj_nm'          ));

output(ingest_results ,,'~temp::lbentley::ingest_results_corp_nm_nj',__compressed__,overwrite);
output(table(ingest_results ,{ingest_status ,unsigned cnt := count(group)},ingest_status,merge) ,named('ingest_statuses'));
output(sort(table(ingest_results ,{string source := mdr.sourcetools.translatesource(source),ingest_status ,unsigned cnt := count(group)},source,ingest_status,merge),source,ingest_status) ,named('ingest_statuses_by_source'));

output(sort(table(ingest_results ,{string source := mdr.sourcetools.translatesource(source),company_name_type_raw,ingest_status ,unsigned cnt := count(group)},source,company_name_type_raw,ingest_status,merge),source,company_name_type_raw,ingest_status) ,named('ingest_statuses_by_source_name_type'),all);

ingest_results_nj_new := ingest_results(source = mdr.sourcetools.src_NJ_Corporations,ingest_status = 'New');
ingest_results_nj_old := ingest_results(source = mdr.sourcetools.src_NJ_Corporations,ingest_status = 'Old');

ds_srid_but_diff_status := join(ingest_results_nj_new ,ingest_results_nj_old ,left.source_record_id = right.source_record_id and left.company_name_type_raw = right.company_name_type_raw,transform({dataset({string ingest_status,BIPV2.CommonBase.Layout - ingest_status}) recs}
,self.recs := project(dataset(left) ,transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
+ project(dataset(right),transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
),hash);

output(count(ds_srid_but_diff_status)  ,named('count_ds_srid_but_diff_status'));

output(enth(ds_srid_but_diff_status,500)  ,named('ds_srid_but_diff_status'),all);

/*
ds_ingest := BIPV2_Files.files_ingest.DS_BASE;

ds_ingest_nm_nj          := ds_ingest(source in [mdr.sourcetools.src_NM_Corporations,mdr.sourcetools.src_NJ_Corporations]) : persist('~persist::lbentley::ds_ingest_nm_nj');

ds_srid_but_diff_cname := join(ds_ingest_nm_nj ,ds_new_corp ,left.source = right.source and left.source_record_id = right.source_record_id and left.company_name_type_raw = right.company_name_type_raw and left.company_name != right.company_name ,transform({dataset({string file,recordof(left)}) recs}
,self.recs := project(dataset(left) ,transform({string file,BIPV2.CommonBase.Layout},self.file := 'Ingest',self := left,self := []))
+ project(dataset(right),transform({string file,BIPV2.CommonBase.Layout},self.file := 'Rewrite',self := left,self := []))
),hash);

ds_srid_but_same_cname:= join(ds_ingest_nm_nj ,ds_new_corp ,left.source = right.source and left.source_record_id = right.source_record_id and left.company_name_type_raw = right.company_name_type_raw and left.company_name = right.company_name ,transform({dataset({string file,recordof(left)}) recs}
,self.recs := project(dataset(left) ,transform({string file,BIPV2.CommonBase.Layout},self.file := 'Ingest',self := left,self := []))
+ project(dataset(right),transform({string file,BIPV2.CommonBase.Layout},self.file := 'Rewrite',self := left,self := []))
),hash);

output(count(ds_new_corp            ) ,named('count_ds_new_corp'            ));
output(count(ds_ingest              ) ,named('count_ds_ingest'              ));
output(count(ds_ingest_nm_nj        ) ,named('count_ds_ingest_nm_nj'        ));
output(count(ds_srid_but_diff_cname ) ,named('count_ds_srid_but_diff_cname' ));
output(count(ds_srid_but_same_cname ) ,named('count_ds_srid_but_same_cname' ));

output(choosen(ds_new_corp            ,100) ,named('ds_new_corp'            ));
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