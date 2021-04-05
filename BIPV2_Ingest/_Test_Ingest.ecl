import corp2,mdr,bipv2;

EXPORT _Test_Ingest(

   pAs_Linking_Mappers        = 'Corp2.Corp2_As_Business_Linking()'
  ,pSet_Test_Sources          = '[mdr.sourcetools.src_AZ_Corporations,mdr.sourcetools.src_DC_Corporations]'
  ,pBase_File                 = 'bipv2.commonbase.ds_built'
  ,pReturn_Code               = 'false'
  ,pPreserve_Ingest_Statuses  = 'false'
  ,pShould_Output_Src_samples = 'true'
  ,pShould_Reclean_base_file  = 'true'
  ,pShould_Xlink_file         = 'true'
  
) :=
functionmacro

  import ut, business_header,business_header_ss, address, BIPV2,BIPV2_Files;

  #OPTION('multiplePersistInstances',true);

  ds_as_linking             := pAs_Linking_Mappers      ;  
  ds_as_linking_filtered    := ds_as_linking      (count(pSet_Test_Sources) = 0 or source in pSet_Test_Sources)  : persist('~persist::BIPV2_Ingest._Test_Ingest::ds_as_linking_filtered');


  #IF(pShould_Reclean_base_file = true)
  ds_base_Filtered          := BIPV2_Files.tools_dotid().reclean(pBase_File(count(pSet_Test_Sources) = 0 or source in pSet_Test_Sources)) : persist('~persist::BIPV2_Ingest._Test_Ingest::ds_base_Filtered');
  #ELSE
  ds_base_Filtered          := pBase_File(count(pSet_Test_Sources) = 0 or source in pSet_Test_Sources) : persist('~persist::BIPV2_Ingest._Test_Ingest::ds_base_Filtered');
  #END
  // --
  // ds_base_blank_above_lgid3 := project(BIPV2_Tools.idIntegrity().blank_above_lgid3(ds_base_Filtered),transform(BIPV2.CommonBase.Layout,self := left,self := []));
  // ds_base_reclean           := BIPV2_Files.tools_dotid().reclean(ds_base_blank_above_lgid3,false,false);
  // ds_base_prep              := project(ds_base_reclean,transform(BIPV2.CommonBase.Layout,self := left,self := []));
  // -- 
  
  
  ds_as_linking_prep_ingest := if(count(pAs_Linking_Mappers) != 0
                                  ,BIPV2_Files.tools_dotid(BIPV2.BL_Init(ds_as_linking_filtered)).base_NoDebug
                                  ,dataset([],RECORDOF(BIPV2_Ingest.In_INGEST))
                               );
  do_ingest                 := BIPV2_Ingest.Ingest(false,,ds_base_Filtered,ds_as_linking_prep_ingest,'~persist::BIPV2_Ingest._Test_Ingest::do_ingest');
  // do_ingest                 := BIPV2_Ingest.Ingest(false,,ds_base_prep,ds_as_linking_prep_ingest,'~persist::BIPV2_Ingest._Test_Ingest::do_ingest');

  ingest_results1     := PROJECT(do_ingest.AllRecords, TRANSFORM(BIPV2.CommonBase.Layout, SELF.ingest_status:=BIPV2_Ingest.Ingest().RTToText(LEFT.__Tpe), SELF:=LEFT));
  #IF(pPreserve_Ingest_Statuses = true)
    ingest_results   := BIPV2_Build.proc_ingest('preserve').omittedSources(pSet_Test_Sources).preserve(ingest_results1);//this can get skewed, so add distribute
  #ELSE
    ingest_results   := ingest_results1;//this can get skewed, so add distribute
  #END
  // SHARED ds_re_DID   := BIPV2_Files.tools_dotid().APPEND_DID(distribute(bipv2_ingest.omittedSources.preserve(ingest_results)));//this can get skewed, so add distribute
  // SHARED ds_ingested := project(ds_re_DID,recordof(BIPV2_Ingest.In_BASE));  
  ds_ingest_statuses                      := table(ingest_results ,{ingest_status ,unsigned cnt := count(group)},ingest_status,merge);
  // ds_ingest_statuses_by_source            := sort(table(ingest_results ,{string source := mdr.sourcetools.translatesource(source),ingest_status ,unsigned cnt := count(group)},source,ingest_status,merge),source,ingest_status);
  ds_ingest_statuses_by_source_name_type  := sort(table(ingest_results ,{string source := mdr.sourcetools.translatesource(source),company_name_type_raw,ingest_status ,unsigned cnt := count(group)},source,company_name_type_raw,ingest_status,merge),source,company_name_type_raw,ingest_status);  
  
  ds_ingest_statuses_by_source_prep1  := sort(table(ingest_results ,{string source := mdr.sourcetools.translatesource(source),string ingest_status := ingest_status ,unsigned cnt := count(group)},source,ingest_status,merge),source,ingest_status);
  ds_ingest_statuses_by_source_prep2  := project(ds_ingest_statuses_by_source_prep1 ,transform(
     {string source,unsigned cnt_ancient,unsigned cnt_old,unsigned cnt_unchanged,unsigned cnt_updated,unsigned cnt_new}
    ,self.source        := left.source
    ,self.cnt_ancient   := if(trim(left.ingest_status) = 'Ancient'    ,left.cnt ,0)
    ,self.cnt_old       := if(trim(left.ingest_status) = 'Old'        ,left.cnt ,0)
    ,self.cnt_unchanged := if(trim(left.ingest_status) = 'Unchanged'  ,left.cnt ,0)
    ,self.cnt_updated   := if(trim(left.ingest_status) = 'Updated'    ,left.cnt ,0)
    ,self.cnt_new       := if(trim(left.ingest_status) = 'New'        ,left.cnt ,0)
  ));
  ds_ingest_statuses_by_source_rollup := rollup(sort(ds_ingest_statuses_by_source_prep2,source) ,left.source = right.source ,transform(recordof(left)
    ,self.source        := left.source
    ,self.cnt_ancient   := left.cnt_ancient   + right.cnt_ancient   
    ,self.cnt_old       := left.cnt_old       + right.cnt_old       
    ,self.cnt_unchanged := left.cnt_unchanged + right.cnt_unchanged 
    ,self.cnt_updated   := left.cnt_updated   + right.cnt_updated   
    ,self.cnt_new       := left.cnt_new       + right.cnt_new       
  ));
  ds_ingest_statuses_by_source_alert1 := project(ds_ingest_statuses_by_source_rollup ,transform(recordof(ds_ingest_statuses_by_source_prep1)
    ,self.ingest_status := BIPV2_Build.proc_ingest().fileTyp(left.cnt_ancient, left.cnt_old, left.cnt_unchanged, left.cnt_updated, left.cnt_new)
    ,self               := left
    ,self.cnt           := 0
  ))(ingest_status != '');
  
  // -- only sources with alerts
  ds_ingest_statuses_by_source_alert := sort(
    join(ds_ingest_statuses_by_source_prep1 ,ds_ingest_statuses_by_source_alert1  ,left.source = right.source,transform(recordof(left),self := left)) 
  +      ds_ingest_statuses_by_source_alert1 
  ,source,cnt);
  
  ds_ingest_statuses_by_source  := sort(ds_ingest_statuses_by_source_prep1 + ds_ingest_statuses_by_source_alert1 ,source,cnt);

  /////////////////////////////////
  // -- Do a xlink append on the new records to see how much lift we might get
  lay_append    := {BIPV2.CommonBase.Layout or BIPV2.IDlayouts.l_xlink_ids};
  ds_ingest_new := project(ingest_results(trim(ingest_status) = 'New')  ,transform(lay_append,self := left,self := []));
  Matchset      := ['A','F','P'];

  Business_Header_SS.MAC_Match_Flex
  (
     ds_ingest_new
    ,matchset
    ,company_name
    ,prim_range
    ,prim_name
    ,zip
    ,sec_range
    ,st
    ,company_phone
    ,company_fein
    ,company_bdid
    ,lay_append
    ,FALSE
    ,BDID_score_field
    ,ds_new_xlink_append
    ,												
    ,												//score_threshold				= '75'
    ,												//pFileVersion						= '\'prod\''														// default to use prod version of superfiles
    ,												//pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
    // ,[BIPV2.IDconstants.xlink_version_BIP_dev]
    ,[BIPV2.IDconstants.xlink_version_BIP]
    ,												//pURL										=	''
    ,//email_address									
    ,v_city_name						//pCity									= ''	
    ,fname	
    ,mname												//pContact_mname					= ''
    ,lname			
    ,												//,contact_ssn					  = ''
    ,source/*change to sub_source when available!*/												//,source					        = ''
    ,source_record_id												//,source_record_id				= ''
  );

  ds_xlink_stats := dataset([
    
    {'New'  ,count(ds_new_xlink_append) ,count(ds_new_xlink_append(proxid != 0))  ,count(ds_new_xlink_append(seleid != 0))    
        ,realformat((count(ds_new_xlink_append(proxid != 0)) / count(ds_new_xlink_append)) * 100.0,8,3)
        ,count(table(ds_new_xlink_append(proxid = 0)  ,{cnp_name,prim_range,prim_name,v_city_name}  ,cnp_name,prim_range,prim_name,v_city_name ,merge)  )
    }
  
  ],{string ingest_status ,unsigned cnt ,unsigned cnt_proxids ,unsigned cnt_seleids ,string pct_append  ,unsigned cnt_max_new_proxids});
  
  
  /////////////////////////////////

  #uniquename(gen_work_code   )
  #uniquename(gen_output_code11 )
  #uniquename(gen_output_code1 )
  #uniquename(gen_output_code2 )
  #uniquename(gen_output_code3 )
  #uniquename(gen_output_code4 )
  #uniquename(gen_output_code5 )
  #uniquename(gen_output_code6 )
  #uniquename(gen_as_linking_outputs )
  #uniquename(current_source  )
  #uniquename(current_source4condition  )
  #uniquename(current_source_desc  )
  #uniquename(cnt             )
  
  #SET(gen_work_code    ,'')
  #SET(gen_as_linking_outputs  ,'')
  #SET(gen_output_code11  ,'')
  #SET(gen_output_code1  ,'')
  #SET(gen_output_code2  ,'')
  #SET(gen_output_code3  ,'')
  #SET(gen_output_code4  ,'')
  #SET(gen_output_code5  ,'')
  #SET(gen_output_code6  ,'')
  #SET(cnt              ,1 )

  #APPEND(gen_work_code  ,'fdedupright(pDs_Dedup) := \n')
  #APPEND(gen_work_code  ,'functionmacro\n')
  #APPEND(gen_work_code  ,'  ds_dedupright1  := dedup(sort(pDs_Dedup       ,company_name,company_name_type_raw,lname,fname,prim_name,prim_range,v_city_name,-rcid,local),company_name,company_name_type_raw,lname,fname,prim_name,prim_range,v_city_name,local);\n')
  #APPEND(gen_work_code  ,'  ds_result       := dedup(sort(distribute(ds_dedupright1  ,hash64(company_name,company_name_type_raw,lname,fname,prim_name,prim_range,v_city_name)),company_name,company_name_type_raw,lname,fname,prim_name,prim_range,v_city_name,-rcid,local),company_name,company_name_type_raw,lname,fname,prim_name,prim_range,v_city_name,local);\n')
  #APPEND(gen_work_code  ,'  return ds_result;\n')
  #APPEND(gen_work_code  ,'endmacro;\n')
  
  import std;
  #LOOP
    #IF(%cnt% > count(pSet_Test_Sources))
      #BREAK
    #END
    #SET(current_source ,pSet_Test_Sources[%cnt%] )
    #SET(current_source4condition ,regexreplace('\\\\',pSet_Test_Sources[%cnt%],'\\\\\\') )
    #SET(current_source_desc  ,trim(std.str.filter(regexreplace(' ',std.str.cleanspaces(mdr.sourceTools.translatesource(%'current_source'%)),'_',nocase) ,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'))  )

    #APPEND(gen_work_code  ,'ingest_results_' + %'current_source_desc'% + '_new := ingest_results(source = \'' + %'current_source4condition'% + '\',ingest_status  = \'New\');\n')
    #APPEND(gen_work_code  ,'ingest_results_' + %'current_source_desc'% + '_old := ingest_results(source = \'' + %'current_source4condition'% + '\',ingest_status != \'New\');\n')

    #APPEND(gen_work_code  ,'ds_diff_srid_' + %'current_source_desc'% + ' := join(')
    #APPEND(gen_work_code  ,' ingest_results_' + %'current_source_desc'% + '_new') 
    // #APPEND(gen_work_code  ,',ingest_results_' + %'current_source_desc'% + '_old \n')
    #APPEND(gen_work_code  ,',fdedupright(ingest_results_' + %'current_source_desc'% + '_old) \n')
    #APPEND(gen_work_code  ,',left.company_name = right.company_name and left.company_name_type_raw = right.company_name_type_raw and left.lname  = right.lname and left.fname  = right.fname and left.prim_name = right.prim_name and left.prim_range = right.prim_range and left.v_city_name = right.v_city_name')
    #APPEND(gen_work_code  ,',transform({dataset({string ingest_status,BIPV2.CommonBase.Layout - ingest_status}) recs}\n')
    #APPEND(gen_work_code  ,',self.recs := project(dataset(left) ,transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))\n')
    #APPEND(gen_work_code  ,'+ project(dataset(right),transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))\n')
    #APPEND(gen_work_code  ,'),hash,keep(1));\n')





    #APPEND(gen_work_code  ,'ds_srid_but_diff_status_' + %'current_source_desc'% + ' := join(ingest_results_' + %'current_source_desc'% + '_new ,ingest_results_' + %'current_source_desc'% + '_old \n')
    #APPEND(gen_work_code  ,',left.source_record_id = right.source_record_id and left.company_name_type_raw = right.company_name_type_raw and left.fname  = right.fname and left.prim_name = right.prim_name,transform({dataset({string ingest_status,BIPV2.CommonBase.Layout - ingest_status}) recs}\n')
    #APPEND(gen_work_code  ,',self.recs := project(dataset(left) ,transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))\n')
    #APPEND(gen_work_code  ,'+ project(dataset(right),transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))\n')
    #APPEND(gen_work_code  ,'),hash,keep(1));\n')
    
    #APPEND(gen_work_code  ,'ds_base_Filtered_' + %'current_source_desc'% + ' := ds_base_Filtered(source = \'' + %'current_source4condition'% + '\');\n')

    #APPEND(gen_output_code11,',output(enth (ds_base_Filtered_'        + %'current_source_desc'% + ',500)  ,named(\'Example___' + %'current_source_desc'% + '\'),all)\n')
    #APPEND(gen_output_code1 ,',output(topn (ds_srid_but_diff_status_' + %'current_source_desc'% + ',500,recs[2].rcid,recs[1].rcid)  ,named(\'Example_' + %'current_source_desc'% + '\'),all)\n')
    #APPEND(gen_output_code2 ,',output(count(ds_srid_but_diff_status_' + %'current_source_desc'% + '    )  ,named(\'Count_'   + %'current_source_desc'% + '\')    )\n')

    #APPEND(gen_output_code3 ,',output(topn (ds_diff_srid_' + %'current_source_desc'% + ',500,recs[2].rcid,recs[1].rcid)  ,named(\'Example__' + %'current_source_desc'% + '\'),all)\n')
    #APPEND(gen_output_code4 ,',output(count(ds_diff_srid_' + %'current_source_desc'% + '    )  ,named(\'Count__'   + %'current_source_desc'% + '\')    )\n')



    #APPEND(gen_output_code5 ,',output(enth (ingest_results_' + %'current_source_desc'% + '_new ,500)  ,named(\'Example_New_' + %'current_source_desc'% + '\'),all)\n')
    #APPEND(gen_output_code6 ,',output(count(ingest_results_' + %'current_source_desc'% + '_new    )  ,named(\'Count_New_'   + %'current_source_desc'% + '\')    )\n')

    #APPEND(gen_as_linking_outputs ,',output(choosen(ds_as_linking(source = \'' + %'current_source4condition'% + '\') ,300)  ,named(\'as_linking_' + %'current_source_desc'% + '\'            ))\n')
    
    #SET(cnt  ,%cnt% + 1)
  #END
  
  #IF(count(pSet_Test_Sources) != 0 and pReturn_Code = false) %gen_work_code%; #END
  
  return_output := parallel(
     output(ingest_results ,,'~temp::BIPV2_Ingest._Test_Ingest::ingest_results.' + workunit,__compressed__,overwrite)
    ,output(pSet_Test_Sources                       ,named('Set_Of_Sources_Tested'                    ))
    ,output(ds_ingest_statuses                      ,named('Ingest_statuses_overall'                  ),all)
    ,output(ds_ingest_statuses_by_source            ,named('Ingest_statuses_by_source'                ),all)
    ,output(ds_ingest_statuses_by_source_alert      ,named('Ingest_statuses_by_source_ALERT'          ),all)
    ,output(ds_ingest_statuses_by_source_name_type  ,named('Ingest_statuses_by_source_and_name_type'  ),all)


#IF(pShould_Xlink_file = true)
    ,output('Results of Xlink Append on New Records'  ,named('__________'))
    ,output(ds_xlink_stats                         ,named('Xlink_Stats_New_Records'                  ),all)
    ,output(choosen(ds_new_xlink_append      ,100)  ,named('Examples_Xlink_Append_For_New_Records'         ))
#END
    ,output('Counts of As Linking and Base File records'  ,named('_'))
    ,output(count(ds_as_linking_filtered             )  ,named('Count_ds_as_linking_filtered'    ))
    ,output(count(ds_base_Filtered                   )  ,named('Count_ds_base_Filtered'          ))
    ,output(count(ingest_results                     )  ,named('Count_ingest_results'            ))
    ,output(count(ds_base_Filtered                   ) - count(ingest_results                     )  ,named('Count_Records_Lost'            ))
    ,output(count(ds_as_linking_prep_ingest          )  ,named('Count_ds_as_linking_prep_ingest' ))

    ,output('Examples of As Linking and Base File records'  ,named('__'))
    ,output(choosen(ds_as_linking            ,100)  ,named('Examples_ds_as_linking'            ))
    ,output(choosen(ds_as_linking_prep_ingest,100)  ,named('Examples_ds_as_linking_prep_ingest'))
    ,output(choosen(ds_base_Filtered         ,100)  ,named('Examples_ds_base_Filtered'         ))
    
#IF(pShould_Output_Src_samples = true)   
    #IF(count(pSet_Test_Sources) != 0 and pReturn_Code = false) %gen_as_linking_outputs% #END

    ,output('Examples of base file records for each source'  ,named('___'))
    #IF(count(pSet_Test_Sources) != 0 and pReturn_Code = false) %gen_output_code11% #END

    ,output('Examples of Same source record id but different Ingest status Follows for each source'  ,named('____'))
    #IF(count(pSet_Test_Sources) != 0 and pReturn_Code = false) %gen_output_code1% #END
    ,output('Counts of Same source record id but different Ingest status Follows'  ,named('_____'))
    #IF(count(pSet_Test_Sources) != 0 and pReturn_Code = false) %gen_output_code2% #END
    ,output('Examples of Different source record id but same data Follows for each source'  ,named('______'))
    #IF(count(pSet_Test_Sources) != 0 and pReturn_Code = false) %gen_output_code3% #END
    ,output('Counts of Different source record id but same data Follows'  ,named('_______'))
    #IF(count(pSet_Test_Sources) != 0 and pReturn_Code = false) %gen_output_code4% #END
    ,output('Examples of New Records Follow'  ,named('________'))
    #IF(count(pSet_Test_Sources) != 0 and pReturn_Code = false) %gen_output_code5% #END
    ,output('Counts of New Records Follow'  ,named('_________'))
    #IF(count(pSet_Test_Sources) != 0 and pReturn_Code = false) %gen_output_code6% #END
#END
 );

/*  
  ingest_results_AZ_new := ingest_results(source = mdr.sourcetools.src_AZ_Corporations,ingest_status = 'New');
  ingest_results_AZ_old := ingest_results(source = mdr.sourcetools.src_AZ_Corporations,ingest_status = 'Old');

  ds_srid_but_diff_status_AZ := join(ingest_results_AZ_new ,ingest_results_AZ_old 
  ,left.source_record_id = right.source_record_id and left.company_name_type_raw = right.company_name_type_raw and left.fname  = right.fname and left.prim_name = right.prim_name,transform({dataset({string ingest_status,BIPV2.CommonBase.Layout - ingest_status}) recs}
  ,self.recs := project(dataset(left) ,transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
  + project(dataset(right),transform({string ingest_status,BIPV2.CommonBase.Layout - ingest_status},self := left,self := []))
  ),hash);                                                                                                                                                                                                                                                                                                

  output(count(ds_srid_but_diff_status_AZ)  ,named('count_ds_srid_but_diff_status_AZ'));
  output(enth(ds_srid_but_diff_status_AZ,500)  ,named('ds_srid_but_diff_status_AZ'),all);
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
*/
  return 
  #IF(pReturn_Code = true)
    parallel(
       output(%'gen_work_code'% + %'gen_as_linking_outputs'% +  %'gen_output_code1'% +  %'gen_output_code2'% + %'gen_output_code3'% + %'gen_output_code4'% ,named('gen_all_code'  ))
      ,output(%'gen_work_code'%    ,named('gen_work_code'  ))
      ,output(%'gen_as_linking_outputs'%  ,named('gen_as_linking_outputs'))
      ,output(%'gen_output_code1'%  ,named('gen_output_code1'))
      ,output(%'gen_output_code2'%  ,named('gen_output_code2'))
      ,output(%'gen_output_code3'%  ,named('gen_output_code3'))
      ,output(%'gen_output_code4'%  ,named('gen_output_code4'))
    );
  #ELSE
    return_output;
  #END

endmacro;