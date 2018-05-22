export mac_stat_matrix(
   pDataset         = 'bipv2.commonbase.ds_base'
  ,pID              = 'seleid'
  ,pNotes           = '\'\''
  ,pCnp_name        = 'cnp_name'
  ,pFein            = 'company_fein'
) := 
functionmacro

  #UNIQUENAME(PERSISTUNIQUE)
  #SET(PERSISTUNIQUE  ,'_' + TRIM(#TEXT(pID)) + '_' + TRIM(pNotes))
  
  ds_duns_slim_all      := table(pDataset,{pID,pCnp_name,pFein}  ,pID,pCnp_name,pFein ,merge);// : persist('~persist::lbentley::ds_duns_slim_all' + %'PERSISTUNIQUE'%);
  ds_cnt_cnp_names_all  := table(table(ds_duns_slim_all ,{pID,pCnp_name    } ,pID,pCnp_name      ,merge),{pID,unsigned cnt_cnp_names := count(group)                            },pID ,merge);// : persist('~persist::lbentley::ds_cnt_cnp_names_all' + %'PERSISTUNIQUE'%);
  ds_cnt_feins_all      := table(table(ds_duns_slim_all ,{pID,pFein} ,pID,pFein  ,merge),{pID,unsigned cnt_feins     := sum  (group,if(pFein != '',1,0)) },pID,merge);//  : persist('~persist::lbentley::ds_cnt_feins_all' + %'PERSISTUNIQUE'%);
  ds_join_all           := join(ds_cnt_cnp_names_all,ds_cnt_feins_all ,left.pID = right.pID,transform({recordof(left) or recordof(right)},self := right,self := left),hash);//  : persist('~persist::lbentley::ds_join_all' + %'PERSISTUNIQUE'%);
  
  ds_all_catgrs := project(ds_join_all ,transform({string cnt_feins,recordof(left) - cnt_feins}
  //  ,self.cnt_cnp_names := map(left.cnt_cnp_names  > 15                               => 15
  //                            ,left.cnt_cnp_names  >=11 and left.cnt_cnp_names <= 15  => 11
  //                            ,left.cnt_cnp_names  >= 6 and left.cnt_cnp_names <= 10  =>  6
  //                            ,                                                          left.cnt_cnp_names
  //  )
    ,self.cnt_feins     := map(left.cnt_feins  > 15                           => '15 plus'
                              ,left.cnt_feins  >=11 and left.cnt_feins <= 15  => '11-15'
                              ,left.cnt_feins  >= 6 and left.cnt_feins <= 10  => '6-10'
                              ,                                                  (string)left.cnt_feins
    )
    ,self               := left
  ));
  ds_all_catgrs_count := table(ds_all_catgrs  ,{string ID := #TEXT(pID),cnt_cnp_names ,cnt_feins  ,unsigned cnt := count(group)} ,cnt_cnp_names ,cnt_feins  ,merge);//   : persist('~persist::lbentley::ds_all_catgrs_count' + %'PERSISTUNIQUE'%);
  ds_all_catgrs_prep_rollup := project(ds_all_catgrs_count  ,transform({string ID,string Company_Name ,ds_all_catgrs_count.cnt_feins,unsigned cnt_1,unsigned cnt_2,unsigned cnt_3,unsigned cnt_4,unsigned cnt_5,unsigned cnt_6_10,unsigned cnt_11_15,unsigned cnt_15_plus}
    ,self.Company_Name  := 'Fein'
    ,self.cnt_1         := if(left.cnt_cnp_names =  1                                 ,left.cnt ,0)
    ,self.cnt_2         := if(left.cnt_cnp_names =  2                                 ,left.cnt ,0)
    ,self.cnt_3         := if(left.cnt_cnp_names =  3                                 ,left.cnt ,0)
    ,self.cnt_4         := if(left.cnt_cnp_names =  4                                 ,left.cnt ,0)
    ,self.cnt_5         := if(left.cnt_cnp_names =  5                                 ,left.cnt ,0)
    ,self.cnt_6_10      := if(left.cnt_cnp_names >= 6  and left.cnt_cnp_names <= 10   ,left.cnt ,0)
    ,self.cnt_11_15     := if(left.cnt_cnp_names >= 11 and left.cnt_cnp_names <= 15   ,left.cnt ,0)
    ,self.cnt_15_plus   := if(left.cnt_cnp_names >  15                                ,left.cnt ,0)
    ,self               := left
  ));
  ds_all_catgrs_rollup := rollup(sort(ds_all_catgrs_prep_rollup,cnt_feins)  ,left.cnt_feins = right.cnt_feins ,transform(recordof(left)
    ,self.Company_Name  := 'Fein'
    ,self.cnt_1         := left.cnt_1       + right.cnt_1       
    ,self.cnt_2         := left.cnt_2       + right.cnt_2       
    ,self.cnt_3         := left.cnt_3       + right.cnt_3       
    ,self.cnt_4         := left.cnt_4       + right.cnt_4       
    ,self.cnt_5         := left.cnt_5       + right.cnt_5       
    ,self.cnt_6_10      := left.cnt_6_10    + right.cnt_6_10    
    ,self.cnt_11_15     := left.cnt_11_15   + right.cnt_11_15   
    ,self.cnt_15_plus   := left.cnt_15_plus + right.cnt_15_plus 
    ,self               := left
  
  ));
  
  ds_all_catgrs_result := project(ds_all_catgrs_rollup  ,transform({string ID,string Notes,string Company_Name ,ds_all_catgrs_count.cnt_feins,string cnt_1,string cnt_2,string cnt_3,string cnt_4,string cnt_5,string cnt_6_10,string cnt_11_15,string cnt_15_plus}
    ,self.cnt_1         := ut.fIntWithCommas(left.cnt_1       )
    ,self.cnt_2         := ut.fIntWithCommas(left.cnt_2       )
    ,self.cnt_3         := ut.fIntWithCommas(left.cnt_3       )
    ,self.cnt_4         := ut.fIntWithCommas(left.cnt_4       )
    ,self.cnt_5         := ut.fIntWithCommas(left.cnt_5       )
    ,self.cnt_6_10      := ut.fIntWithCommas(left.cnt_6_10    )
    ,self.cnt_11_15     := ut.fIntWithCommas(left.cnt_11_15   )
    ,self.cnt_15_plus   := ut.fIntWithCommas(left.cnt_15_plus )
    ,self.Notes         := pNotes
    ,self               := left
  ));

  return ds_all_catgrs_result;
  
endmacro;