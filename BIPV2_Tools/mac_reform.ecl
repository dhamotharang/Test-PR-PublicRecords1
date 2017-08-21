/*
  resets the pParent_ID to the lowest pChild_ID per pGrouping_Field
*/
EXPORT mac_reform(

   pDs
  ,pParent_ID         = 'proxid'
  ,pChild_ID          = 'dotid'
  ,pLowest_Child_ID   = 'lowest_dotid'
  ,pGrouping_Field    = 'cnp_name'
  ,pIsTesting         = 'false'         //if true, will return more temp fields for research and testing
  ,pCnp_Name1_regex   = ''              // -- first company name.  this can be a regex
  ,pCnp_Name2_regex   = ''              // -- second company name.  this can also be a regex.

) :=
functionmacro

    ds_local      := project(pDs ,transform({unsigned6 pLowest_Child_ID,recordof(left)},self.pLowest_Child_ID := left.pChild_ID,self := left));
    ds_prep_slim  := table(ds_local ,{pParent_ID  ,pChild_ID  ,pLowest_Child_ID ,pGrouping_Field
#IF(pIsTesting = true)      
    ,unsigned6 lowest_ID1 := pLowest_Child_ID
    ,unsigned6 lowest_ID2 := pLowest_Child_ID
    ,unsigned6 lowest_ID3 := pLowest_Child_ID
    ,unsigned6 lowest_ID4 := pLowest_Child_ID
    ,unsigned6 lowest_ID5 := pLowest_Child_ID
    ,unsigned6 lowest_ID6 := pLowest_Child_ID
    ,unsigned6 lowest_ID7 := pLowest_Child_ID
    ,string  grouping_help1 := ''  
    ,string  grouping_help2 := ''  
    ,string  grouping_help3 := ''  
    ,string  grouping_help4 := ''  
    ,string  grouping_help5 := ''  
    ,string  grouping_help6 := ''  
    ,string  grouping_help7 := ''  
#END
    } ,pParent_ID  ,pChild_ID  ,pLowest_Child_ID ,pGrouping_Field ,merge);
    
    ds_cand_table1       := group(sort(distribute(ds_prep_slim ,hash64(pParent_ID,pGrouping_Field)),pParent_ID,pGrouping_Field,pLowest_Child_ID,local),pParent_ID,pGrouping_Field,local);
    ds_cand_iter1        := iterate(ds_cand_table1  ,transform(
        recordof(left)
       ,self.pLowest_Child_ID := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
#IF(pIsTesting = true)      
       ,self.lowest_ID1       := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
       ,self.grouping_help1    := if(right.pLowest_Child_ID != left.pLowest_Child_ID and left.pLowest_Child_ID != 0  ,left.pGrouping_Field ,'')
#END
       ,self                  := right
    ));

    ds_cand_table2       := group(sort(distribute(ds_cand_iter1 ,hash64(pParent_ID,pChild_ID)),pParent_ID,pChild_ID,pLowest_Child_ID,local),pParent_ID,pChild_ID,local);
    ds_cand_iter2        := iterate(ds_cand_table2  ,transform(
        recordof(left)
       ,self.pLowest_Child_ID := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
#IF(pIsTesting = true)      
       ,self.lowest_ID2       := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
       ,self.grouping_help2    := if(right.pLowest_Child_ID != left.pLowest_Child_ID and left.pLowest_Child_ID != 0  ,'proxid-' + (string)left.pChild_ID ,'')
#END
       ,self                  := right
    ));
//////////////////////
    ds_cand_table3       := group(sort(distribute(ds_cand_iter2 ,hash64(pParent_ID,pGrouping_Field)),pParent_ID,pGrouping_Field,pLowest_Child_ID,local),pParent_ID,pGrouping_Field,local);
    ds_cand_iter3        := iterate(ds_cand_table3  ,transform(
        recordof(left)
       ,self.pLowest_Child_ID := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
#IF(pIsTesting = true)      
       ,self.lowest_ID3       := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
       ,self.grouping_help3    := if(right.pLowest_Child_ID != left.pLowest_Child_ID and left.pLowest_Child_ID != 0  ,left.pGrouping_Field ,'')
#END
       ,self                  := right
    ));

    ds_cand_table4       := group(sort(distribute(ds_cand_iter3 ,hash64(pParent_ID,pChild_ID)),pParent_ID,pChild_ID,pLowest_Child_ID,local),pParent_ID,pChild_ID,local);
    ds_cand_iter4        := iterate(ds_cand_table4  ,transform(
        recordof(left)
       ,self.pLowest_Child_ID := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
#IF(pIsTesting = true)      
       ,self.lowest_ID4       := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
       ,self.grouping_help4    := if(right.pLowest_Child_ID != left.pLowest_Child_ID and left.pLowest_Child_ID != 0  ,'proxid-' + (string)left.pChild_ID ,'')
#END
       ,self                  := right
    ));
    
    ds_cand_table5       := group(sort(distribute(ds_cand_iter4 ,hash64(pParent_ID,pGrouping_Field)),pParent_ID,pGrouping_Field,pLowest_Child_ID,local),pParent_ID,pGrouping_Field,local);
    ds_cand_iter5        := iterate(ds_cand_table5  ,transform(
        recordof(left)
       ,self.pLowest_Child_ID := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
#IF(pIsTesting = true)      
       ,self.lowest_ID5       := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
       ,self.grouping_help5    := if(right.pLowest_Child_ID != left.pLowest_Child_ID and left.pLowest_Child_ID != 0  ,left.pGrouping_Field ,'')
#END
       ,self                  := right
    ));

    ds_cand_table6       := group(sort(distribute(ds_cand_iter5 ,hash64(pParent_ID,pChild_ID)),pParent_ID,pChild_ID,pLowest_Child_ID,local),pParent_ID,pChild_ID,local);
    ds_cand_iter6        := iterate(ds_cand_table6  ,transform(
        recordof(left)
       ,self.pLowest_Child_ID := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
#IF(pIsTesting = true)      
       ,self.lowest_ID6       := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
       ,self.grouping_help6    := if(right.pLowest_Child_ID != left.pLowest_Child_ID and left.pLowest_Child_ID != 0  ,'proxid-' + (string)left.pChild_ID ,'')
#END
       ,self                  := right
    ));

    ds_cand_table7       := group(sort(distribute(ds_cand_iter6 ,hash64(pParent_ID,pGrouping_Field)),pParent_ID,pGrouping_Field,pLowest_Child_ID,local),pParent_ID,pGrouping_Field,local);
    ds_cand_iter7        := iterate(ds_cand_table7  ,transform(
        recordof(left)
       ,self.pLowest_Child_ID := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
#IF(pIsTesting = true)      
       ,self.lowest_ID7       := if(left.pLowest_Child_ID = 0 ,right.pLowest_Child_ID ,left.pLowest_Child_ID)
       ,self.grouping_help7    := if(right.pLowest_Child_ID != left.pLowest_Child_ID and left.pLowest_Child_ID != 0  ,left.pGrouping_Field ,'')
#END
       ,self                  := right
    ));

/////////////////////

    ds_final_form       := table(ds_cand_iter7 ,{pParent_ID,pChild_ID,unsigned6 pLowest_Child_ID := min(group,pLowest_Child_ID)}, pParent_ID,pChild_ID,merge);    

    #uniquename(parent_old)
    #SET(parent_old       ,#TEXT(pParent_ID)   + '_old')
    
    ds_reset_candidates  := join(ds_local ,ds_final_form 
      ,   left.pParent_ID       = right.pParent_ID 
      and left.pChild_ID        = right.pChild_ID  
      ,transform({unsigned6 %parent_old% ,  recordof(left)}
        ,self.%parent_old%      := left.pParent_ID
        ,self.pParent_ID        := right.pLowest_Child_ID
        ,self                   := left
      )
    ,hash);

#IF(pIsTesting = true)      
  import tools;

  ds_iter1_slim := project(ds_cand_iter7  ,transform({recordof(left) - pLowest_Child_ID  - lowest_ID2 - lowest_ID3 - lowest_ID4 - lowest_ID5 - lowest_ID6 - lowest_ID7 - grouping_help2 - grouping_help3 - grouping_help4 - grouping_help5 - grouping_help6 - grouping_help7},self := left ));
  ds_iter2_slim := project(ds_cand_iter7  ,transform({recordof(left) - pLowest_Child_ID  - lowest_ID1 - lowest_ID3 - lowest_ID4 - lowest_ID5 - lowest_ID6 - lowest_ID7 - grouping_help1 - grouping_help3 - grouping_help4 - grouping_help5 - grouping_help6 - grouping_help7},self := left ));
  ds_iter3_slim := project(ds_cand_iter7  ,transform({recordof(left) - pLowest_Child_ID  - lowest_ID1 - lowest_ID2 - lowest_ID4 - lowest_ID5 - lowest_ID6 - lowest_ID7 - grouping_help1 - grouping_help2 - grouping_help4 - grouping_help5 - grouping_help6 - grouping_help7},self := left ));
  ds_iter4_slim := project(ds_cand_iter7  ,transform({recordof(left) - pLowest_Child_ID  - lowest_ID1 - lowest_ID2 - lowest_ID3 - lowest_ID5 - lowest_ID6 - lowest_ID7 - grouping_help1 - grouping_help2 - grouping_help3 - grouping_help5 - grouping_help6 - grouping_help7},self := left ));
  ds_iter5_slim := project(ds_cand_iter7  ,transform({recordof(left) - pLowest_Child_ID  - lowest_ID1 - lowest_ID2 - lowest_ID3 - lowest_ID4 - lowest_ID6 - lowest_ID7 - grouping_help1 - grouping_help2 - grouping_help3 - grouping_help4 - grouping_help6 - grouping_help7},self := left ));
  ds_iter6_slim := project(ds_cand_iter7  ,transform({recordof(left) - pLowest_Child_ID  - lowest_ID1 - lowest_ID2 - lowest_ID3 - lowest_ID4 - lowest_ID5 - lowest_ID7 - grouping_help1 - grouping_help2 - grouping_help3 - grouping_help4 - grouping_help5 - grouping_help7},self := left ));
  ds_iter7_slim := project(ds_cand_iter7  ,transform({recordof(left) - pLowest_Child_ID  - lowest_ID1 - lowest_ID2 - lowest_ID3 - lowest_ID4 - lowest_ID5 - lowest_ID6 - grouping_help1 - grouping_help2 - grouping_help3 - grouping_help4 - grouping_help5 - grouping_help6},self := left ));

  agg_prep1            := tools.mac_AggregateFieldsPerID(ds_prep_slim  ,pLowest_Child_ID );
  agg_iter11           := tools.mac_AggregateFieldsPerID(ds_iter1_slim ,lowest_ID1       );
  agg_iter21           := tools.mac_AggregateFieldsPerID(ds_iter2_slim ,lowest_ID2       );
  agg_iter31           := tools.mac_AggregateFieldsPerID(ds_iter3_slim ,lowest_ID3       );
  agg_iter41           := tools.mac_AggregateFieldsPerID(ds_iter4_slim ,lowest_ID4       );
  agg_iter51           := tools.mac_AggregateFieldsPerID(ds_iter5_slim ,lowest_ID5       );
  agg_iter61           := tools.mac_AggregateFieldsPerID(ds_iter6_slim ,lowest_ID6       );
  agg_iter71           := tools.mac_AggregateFieldsPerID(ds_iter7_slim ,lowest_ID7       );
  agg_ds_final_form1   := tools.mac_AggregateFieldsPerID(ds_final_form ,pLowest_Child_ID );

  ds_iter1_slim_filt := ds_iter1_slim;
  ds_iter2_slim_filt := ds_iter2_slim;
  ds_iter3_slim_filt := ds_iter3_slim;
  ds_iter4_slim_filt := ds_iter4_slim;
  ds_iter5_slim_filt := ds_iter5_slim;
  ds_iter6_slim_filt := ds_iter6_slim;
  ds_iter7_slim_filt := ds_iter7_slim;

  agg_iter1_linking1           := tools.mac_AggregateFieldsPerID(ds_iter1_slim_filt ,lowest_ID1       );
  agg_iter2_linking1           := tools.mac_AggregateFieldsPerID(ds_iter2_slim_filt ,lowest_ID2       );
  agg_iter3_linking1           := tools.mac_AggregateFieldsPerID(ds_iter3_slim_filt ,lowest_ID3       );
  agg_iter4_linking1           := tools.mac_AggregateFieldsPerID(ds_iter4_slim_filt ,lowest_ID4       );
  agg_iter5_linking1           := tools.mac_AggregateFieldsPerID(ds_iter5_slim_filt ,lowest_ID5       );
  agg_iter6_linking1           := tools.mac_AggregateFieldsPerID(ds_iter6_slim_filt ,lowest_ID6       );
  agg_iter7_linking1           := tools.mac_AggregateFieldsPerID(ds_iter7_slim_filt ,lowest_ID7       );

  #uniquename(childids)
  #SET(childids       ,#TEXT(pChild_ID)   + 's')

  agg_prep            := project(agg_prep1         ,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter1           := project(agg_iter11        ,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter2           := project(agg_iter21        ,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter3           := project(agg_iter31        ,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter4           := project(agg_iter41        ,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter5           := project(agg_iter51        ,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter6           := project(agg_iter61        ,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter7           := project(agg_iter71        ,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_ds_final_form   := project(agg_ds_final_form1,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));

  agg_iter1_linking           := project(agg_iter1_linking1,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter2_linking           := project(agg_iter2_linking1,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter3_linking           := project(agg_iter3_linking1,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter4_linking           := project(agg_iter4_linking1,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter5_linking           := project(agg_iter5_linking1,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter6_linking           := project(agg_iter6_linking1,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));
  agg_iter7_linking           := project(agg_iter7_linking1,transform(recordof(left),self.%childids% := choosen(left.%childids%,5),self := left));


    #uniquename(grouping_fields)
    #SET(grouping_fields       ,#TEXT(pGrouping_Field)   + 's')

    agg_prep_overlinked    := topn(agg_prep          (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) and exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,pLowest_Child_ID); 
    agg_iter1_overlinked   := topn(agg_iter1         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) and exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID1      );
    agg_iter2_overlinked   := topn(agg_iter2         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) and exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID2      ); 
    agg_iter3_overlinked   := topn(agg_iter3         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) and exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID3      ); 
    agg_iter4_overlinked   := topn(agg_iter4         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) and exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID4      ); 
    agg_iter5_overlinked   := topn(agg_iter5         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) and exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID5      ); 
    agg_iter6_overlinked   := topn(agg_iter6         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) and exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID6      ); 
    agg_iter7_overlinked   := topn(agg_iter7         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) and exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID7      );    // return when(table(ds_reset_candidates  ,{%parent_old% ,pParent_ID ,pChild_ID ,pLowest_Child_ID ,pGrouping_Field}) 

    agg_prep_either_name   := topn(agg_prep          (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) or exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,pLowest_Child_ID);
    agg_iter1_either_name  := topn(agg_iter1         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) or exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID1      );
    agg_iter2_either_name  := topn(agg_iter2         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) or exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID2      );
    agg_iter3_either_name  := topn(agg_iter3         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) or exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID3      );
    agg_iter4_either_name  := topn(agg_iter4         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) or exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID4      );
    agg_iter5_either_name  := topn(agg_iter5         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) or exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID5      );
    agg_iter6_either_name  := topn(agg_iter6         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) or exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID6      );
    agg_iter7_either_name  := topn(agg_iter7         (exists(%grouping_fields%(regexfind(pCnp_Name1_regex,trim(pGrouping_Field),nocase))) or exists(%grouping_fields%(regexfind(pCnp_Name2_regex,trim(pGrouping_Field),nocase)))),500  ,lowest_ID7      );

    topn_agg_iter1_linking  := topn(agg_iter1_linking(exists(grouping_help1s)) ,500  ,lowest_ID1      );
    topn_agg_iter2_linking  := topn(agg_iter2_linking(exists(grouping_help2s)) ,500  ,lowest_ID2      );
    topn_agg_iter3_linking  := topn(agg_iter3_linking(exists(grouping_help3s)) ,500  ,lowest_ID3      );
    topn_agg_iter4_linking  := topn(agg_iter4_linking(exists(grouping_help4s)) ,500  ,lowest_ID4      );
    topn_agg_iter5_linking  := topn(agg_iter5_linking(exists(grouping_help5s)) ,500  ,lowest_ID5      );
    topn_agg_iter6_linking  := topn(agg_iter6_linking(exists(grouping_help6s)) ,500  ,lowest_ID6      );
    topn_agg_iter7_linking  := topn(agg_iter7_linking(exists(grouping_help7s)) ,500  ,lowest_ID7      );

    

    return when(ds_reset_candidates   
    ,parallel(
       output('------------------------------------------------',named('_______________________________________________'))
      ,output('------------Cluster_reform_information-------',named('Cluster_reform_information'))
      ,output('------------------------------------------------',named('________________________________________________'))
      ,if(exists(agg_prep_overlinked )  ,output(agg_prep_overlinked  ,named('agg_prep_overlinked'  ),all))
      ,if(exists(agg_iter1_overlinked)  ,output(agg_iter1_overlinked ,named('agg_iter1_overlinked' ),all))
      ,if(exists(agg_iter2_overlinked)  ,output(agg_iter2_overlinked ,named('agg_iter2_overlinked' ),all))
      ,if(exists(agg_iter3_overlinked)  ,output(agg_iter3_overlinked ,named('agg_iter3_overlinked' ),all))
      ,if(exists(agg_iter4_overlinked)  ,output(agg_iter4_overlinked ,named('agg_iter4_overlinked' ),all))
      ,if(exists(agg_iter5_overlinked)  ,output(agg_iter5_overlinked ,named('agg_iter5_overlinked' ),all))
      ,if(exists(agg_iter6_overlinked)  ,output(agg_iter6_overlinked ,named('agg_iter6_overlinked' ),all))
      ,if(exists(agg_iter7_overlinked)  ,output(agg_iter7_overlinked ,named('agg_iter7_overlinked' ),all))
      ,output('-------------------------------------------------------------')
      ,if(exists(agg_prep_either_name )  ,output(agg_prep_either_name  ,named('agg_prep_either_name'  ),all))
      ,if(exists(agg_iter1_either_name)  ,output(agg_iter1_either_name ,named('agg_iter1_either_name' ),all))
      ,if(exists(agg_iter2_either_name)  ,output(agg_iter2_either_name ,named('agg_iter2_either_name' ),all))
      ,if(exists(agg_iter3_either_name)  ,output(agg_iter3_either_name ,named('agg_iter3_either_name' ),all))
      ,if(exists(agg_iter4_either_name)  ,output(agg_iter4_either_name ,named('agg_iter4_either_name' ),all))
      ,if(exists(agg_iter5_either_name)  ,output(agg_iter5_either_name ,named('agg_iter5_either_name' ),all))
      ,if(exists(agg_iter6_either_name)  ,output(agg_iter6_either_name ,named('agg_iter6_either_name' ),all))
      ,if(exists(agg_iter7_either_name)  ,output(agg_iter7_either_name ,named('agg_iter7_either_name' ),all))

      ,output('-------------------------------------------------------------')
      ,if(exists(topn_agg_iter1_linking)  ,output(topn_agg_iter1_linking ,named('topn_agg_iter1_linking' ),all))
      ,if(exists(topn_agg_iter2_linking)  ,output(topn_agg_iter2_linking ,named('topn_agg_iter2_linking' ),all))
      ,if(exists(topn_agg_iter3_linking)  ,output(topn_agg_iter3_linking ,named('topn_agg_iter3_linking' ),all))
      ,if(exists(topn_agg_iter4_linking)  ,output(topn_agg_iter4_linking ,named('topn_agg_iter4_linking' ),all))
      ,if(exists(topn_agg_iter5_linking)  ,output(topn_agg_iter5_linking ,named('topn_agg_iter5_linking' ),all))
      ,if(exists(topn_agg_iter6_linking)  ,output(topn_agg_iter6_linking ,named('topn_agg_iter6_linking' ),all))
      ,if(exists(topn_agg_iter7_linking)  ,output(topn_agg_iter7_linking ,named('topn_agg_iter7_linking' ),all))

      // ,output(topn(agg_prep          ,500  ,pLowest_Child_ID) ,named('agg_prep'  ),all)
      // ,output(topn(agg_iter1         ,500  ,lowest_ID1      ) ,named('agg_iter1' ),all)
      // ,output(topn(agg_iter2         ,500  ,lowest_ID2      ) ,named('agg_iter2' ),all)
      // ,output(topn(agg_iter3         ,500  ,lowest_ID3      ) ,named('agg_iter3' ),all)
      // ,output(topn(agg_iter4         ,500  ,lowest_ID4      ) ,named('agg_iter4' ),all)
      // ,output(topn(agg_iter5         ,500  ,lowest_ID5      ) ,named('agg_iter5' ),all)
      // ,output(topn(agg_iter6         ,500  ,lowest_ID6      ) ,named('agg_iter6' ),all)
      // ,output(topn(agg_iter7         ,500  ,lowest_ID7      ) ,named('agg_iter7' ),all)

      // ,output(topn(agg_ds_final_form,500,pLowest_Child_ID)  ,named('ds_final_form' ),all)
      
      // ,output(topn(ds_prep_slim      (pChild_ID = 55491451),500 ,pChild_ID       ) ,named('ds_prep_slim_55491451'  ),all)
      // ,output(topn(ds_cand_iter7     (pChild_ID = 55491451),500 ,pChild_ID       ) ,named('ds_cand_iter7_55491451' ),all)
      // ,output(topn(ds_final_form     (pChild_ID = 55491451),500 ,pChild_ID       ) ,named('ds_final_form_55491451' ),all)
      
  ));
#ELSE
  return ds_reset_candidates;
#END

endmacro;