EXPORT _Fix_Revenue(
   pDataset
  ,pRevenue_Field
  ,pOutlier_Pct     = '300.0'   // -- outlier revenue must be > 300 percent higher than the next highest revenue
  ,pAve_Revenue     = '1000000' // -- 1 million = 1 billion since the field is in the thousands
  ,pMinNumRevenues  = '4'       // -- must have more than 3 revenues in the vl_id for this to take effect
  ,pDebug           = 'false'
) :=
functionmacro

  #UNIQUENAME(REVENUE_FIELD)
  #SET(REVENUE_FIELD ,trim(#TEXT(pRevenue_Field)))
  
  #UNIQUENAME(ORIG_REVENUE)
  #SET(ORIG_REVENUE ,trim(#TEXT(pRevenue_Field)) + '_Orig')

  ds_fix_revenue_org_table  := table(pDataset(~regexfind('[-+]',%REVENUE_FIELD%,nocase)  ,(unsigned)%REVENUE_FIELD% > 0),{vl_id  ,company_name,dt_vendor_first_reported,%REVENUE_FIELD%} ,vl_id  ,company_name,dt_vendor_first_reported,%REVENUE_FIELD%,merge);
  ds_fix_revenue_org_table1 := table(ds_fix_revenue_org_table,{vl_id  ,%REVENUE_FIELD%} ,vl_id ,%REVENUE_FIELD%,merge);
  ds_fix_revenue_org_table1_cnt_revenues := table(ds_fix_revenue_org_table,{vl_id  ,unsigned cnt_revenues := count(group)} ,vl_id ,merge);
  ds_fix_revenue_org_table1_dedup := dedup(sort(distribute(ds_fix_revenue_org_table1 ,hash(vl_id)),vl_id,-(unsigned8)%REVENUE_FIELD%,local),vl_id,keep(2),local);
  ds_fix_revenue_org_table2 := table(ds_fix_revenue_org_table1_dedup   ,{vl_id  
                                ,unsigned  cnt         := count(group)
                                ,unsigned8 sum_revenue := sum(group,(unsigned8)%REVENUE_FIELD%)
                                ,unsigned8 max_revenue := max(group,(unsigned8)%REVENUE_FIELD%)
                                ,unsigned8 min_revenue := min(group,(unsigned8)%REVENUE_FIELD%)
                                ,real8     ave_revenue := ave(group,(unsigned8)%REVENUE_FIELD%)
                              } ,vl_id                 ,merge);
  ds_fix_revenue_add_real_count := join(ds_fix_revenue_org_table2  ,ds_fix_revenue_org_table1_cnt_revenues  ,left.vl_id = right.vl_id,transform({recordof(left) or recordof(right)},self := left,self := right),hash);
  ds_fix_revenue_org_proj := project(ds_fix_revenue_add_real_count(cnt > 1,cnt_revenues > pMinNumRevenues)  ,transform({recordof(left),real8 ave_revenue_minus_max,real8 ave_div_max  ,real8 ave_div_max_minus_max}
    ,self.ave_revenue_minus_max := if(left.cnt > 1 ,(left.sum_revenue - left.max_revenue) / (left.cnt - 1) ,left.ave_revenue)
    ,self.ave_div_max           := left.max_revenue / left.ave_revenue * 100
    ,self.ave_div_max_minus_max := left.max_revenue / self.ave_revenue_minus_max * 100
    ,self                       := left
  ));

  // -- go for over 300% larger, then blank out the max value
  ds_fix_revenue_org_proj_over300pct := ds_fix_revenue_org_proj(ave_div_max_minus_max > pOutlier_Pct,ave_revenue > pAve_Revenue); //revenue of 1B+, average div max > 300%

  // -- blank out max revenue for these outliers.
  ds_patched_revenues := join(pDataset  ,ds_fix_revenue_org_proj_over300pct ,left.vl_id = right.vl_id ,transform({boolean didsuppress,boolean didsuppress_vl_id,string vl_id,string company_name,string %ORIG_REVENUE%,string %REVENUE_FIELD%,{recordof(right) or recordof(left)} - %REVENUE_FIELD% - vl_id- company_name}
    ,self.didsuppress_vl_id    := if(right.vl_id != ''                                                        ,true ,false                )
    ,self.didsuppress          := if(right.vl_id != '' and (unsigned8)left.%REVENUE_FIELD% = right.max_revenue ,true ,false                )
    ,self.%REVENUE_FIELD%       := if(right.vl_id != '' and (unsigned8)left.%REVENUE_FIELD% = right.max_revenue ,''   ,left.%REVENUE_FIELD%  )
    ,self.%ORIG_REVENUE%       := left.%REVENUE_FIELD%
    ,self := left
    ,self := right
  )  ,left outer,hash);

  ds_stats := dataset([
  
    {'count pDataset'                               ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(pDataset                                 ))  ,ut.fIntWithCommas(count(table(pDataset                                 ,{vl_id},vl_id,merge)))}
   ,{'count ds_fix_revenue_org_table              ' ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(ds_fix_revenue_org_table                 ))  ,ut.fIntWithCommas(count(table(ds_fix_revenue_org_table                 ,{vl_id},vl_id,merge)))}
   ,{'count ds_fix_revenue_org_table1             ' ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(ds_fix_revenue_org_table1                ))  ,ut.fIntWithCommas(count(table(ds_fix_revenue_org_table1                ,{vl_id},vl_id,merge)))}
   ,{'count ds_fix_revenue_org_table1_cnt_revenues' ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(ds_fix_revenue_org_table1_cnt_revenues   ))  ,ut.fIntWithCommas(count(table(ds_fix_revenue_org_table1_cnt_revenues   ,{vl_id},vl_id,merge)))}
   ,{'count ds_fix_revenue_org_table1_dedup       ' ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(ds_fix_revenue_org_table1_dedup          ))  ,ut.fIntWithCommas(count(table(ds_fix_revenue_org_table1_dedup          ,{vl_id},vl_id,merge)))}
   ,{'count ds_fix_revenue_org_table2             ' ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(ds_fix_revenue_org_table2                ))  ,ut.fIntWithCommas(count(table(ds_fix_revenue_org_table2                ,{vl_id},vl_id,merge)))}
   ,{'count ds_fix_revenue_add_real_count         ' ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(ds_fix_revenue_add_real_count            ))  ,ut.fIntWithCommas(count(table(ds_fix_revenue_add_real_count            ,{vl_id},vl_id,merge)))}
   ,{'count ds_fix_revenue_org_proj               ' ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(ds_fix_revenue_org_proj                  ))  ,ut.fIntWithCommas(count(table(ds_fix_revenue_org_proj                  ,{vl_id},vl_id,merge)))}
   ,{'count ds_fix_revenue_org_proj_over300pct    ' ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(ds_fix_revenue_org_proj_over300pct       ))  ,ut.fIntWithCommas(count(table(ds_fix_revenue_org_proj_over300pct       ,{vl_id},vl_id,merge)))}
   ,{'count ds_patched_revenues                   ' ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(ds_patched_revenues                      ))  ,ut.fIntWithCommas(count(table(ds_patched_revenues                      ,{vl_id},vl_id,merge)))}
   ,{'count ds_patched_revenues did patch '         ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(ds_patched_revenues(didsuppress = true)  ))  ,ut.fIntWithCommas(count(table(ds_patched_revenues(didsuppress = true)  ,{vl_id},vl_id,merge)))}
   ,{'count ds_patched_revenues did NOT patch '     ,trim(%'REVENUE_FIELD'%)  ,ut.fIntWithCommas(count(ds_patched_revenues(didsuppress = false) ))  ,ut.fIntWithCommas(count(table(ds_patched_revenues(didsuppress = false) ,{vl_id},vl_id,merge)))}
  
  ],{string statdescription,string revenue_field,string records ,string vl_ids});

  ds_result := project(ds_patched_revenues  ,recordof(pDataset));
  
  return when(ds_result ,parallel(
    output(ds_stats ,named('Equifax_Business_Data__Fix_Revenue_ds_stats'),extend)
   #IF(pDebug = true)
   ,output(topn(pDataset                                ,300,vl_id),named('Equifax_Business_Data__Fix_Revenue_pDataset_'                               + trim(%'REVENUE_FIELD'%)),all)
   ,output(topn(ds_fix_revenue_org_table                ,300,vl_id),named('Equifax_Business_Data__Fix_Revenue_ds_fix_revenue_org_table_'               + trim(%'REVENUE_FIELD'%)),all)
   ,output(topn(ds_fix_revenue_org_table1               ,300,vl_id),named('Equifax_Business_Data__Fix_Revenue_ds_fix_revenue_org_table1_'              + trim(%'REVENUE_FIELD'%)),all)
   ,output(topn(ds_fix_revenue_org_table1_cnt_revenues  ,300,vl_id),named('Equifax_Business_Data__Fix_Revenue_ds_fix_revenue_org_table1_cnt_revenues_' + trim(%'REVENUE_FIELD'%)),all)
   ,output(topn(ds_fix_revenue_org_table1_dedup         ,300,vl_id),named('Equifax_Business_Data__Fix_Revenue_ds_fix_revenue_org_table1_dedup_'        + trim(%'REVENUE_FIELD'%)),all)
   ,output(topn(ds_fix_revenue_org_table2               ,300,vl_id),named('Equifax_Business_Data__Fix_Revenue_ds_fix_revenue_org_table2_'              + trim(%'REVENUE_FIELD'%)),all)
   ,output(topn(ds_fix_revenue_add_real_count           ,300,vl_id),named('Equifax_Business_Data__Fix_Revenue_ds_fix_revenue_add_real_count_'          + trim(%'REVENUE_FIELD'%)),all)
   ,output(topn(ds_fix_revenue_org_proj                 ,300,vl_id),named('Equifax_Business_Data__Fix_Revenue_ds_fix_revenue_org_proj_'                + trim(%'REVENUE_FIELD'%)),all)
   ,output(topn(ds_fix_revenue_org_proj_over300pct      ,300,vl_id),named('Equifax_Business_Data__Fix_Revenue_ds_fix_revenue_org_proj_over300pct_'     + trim(%'REVENUE_FIELD'%)),all)
   ,output(topn(ds_patched_revenues                     ,300,vl_id),named('Equifax_Business_Data__Fix_Revenue_ds_patched_revenues_'                    + trim(%'REVENUE_FIELD'%)),all)
   ,output(topn(ds_patched_revenues(didsuppress = true ),300,vl_id),named('Equifax_Business_Data__Fix_Revenue_ds_patched_revenues_DID_Patch_'          + trim(%'REVENUE_FIELD'%)),all)
   ,output(topn(ds_patched_revenues(didsuppress = false),300,vl_id),named('Equifax_Business_Data__Fix_Revenue_ds_patched_revenues_NO_PATCH_'           + trim(%'REVENUE_FIELD'%)),all)
   #END
  ));

endmacro;