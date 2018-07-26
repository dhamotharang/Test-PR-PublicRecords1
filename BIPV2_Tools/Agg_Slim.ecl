import bipv2_proxid,tools;
EXPORT Agg_Slim(
    pDataset
   ,pID                         = 'proxid'
   ,pLimit_ChildDatasets        = '100'
   ,pSet_Add_Fields             = '[]'
) :=
functionmacro

  import mdr;
  #UNIQUENAME(ADD_FIELD)
  #UNIQUENAME(CNTR)
  #SET(ADD_FIELD,'')
  #SET(CNTR,1)
  dslim := project(pDataset, transform(
  {
  #IF(trim(#TEXT(pID)) not in ['address','source_record_id','sbfe_id','vl_id'])
     pDataset.pId
    ,string source
  #ELSE
     string source
  #END

  ,string fein
  ,pDataset.cnp_name
  ,string address
  ,string a_duns,string a_entnum
  ,string a_corpkey

  ,pDataset.cnp_number,pDataset.cnp_btype
  ,string1 company_foreign_domestic,string foreign_corp_key
  #IF(count(pSet_Add_Fields) > 0)
    #LOOP
      #IF(%CNTR% > count(pSet_Add_Fields))
        #BREAK
      #END
      
      #APPEND(ADD_FIELD  ,' ,string ' + trim(pSet_Add_Fields[%CNTR%]))
      
      #SET(CNTR ,%CNTR% + 1)
    #END
    %ADD_FIELD%
  #END
},
      source_index := STD.Str.Find( left.source, '-', 1 );
//    self.corp_key := if(left.company_charter_state != '' and left.company_charter_number != ''  ,trim(left.company_charter_state,left,right) + '-' + trim(left.company_charter_number,left,right) ,'');

    self.source            :=                                 left.source + '- ' + trim(mdr.sourceTools.translatesource(left.source));
    self.cnp_name      := left.cnp_name;
    
    self.fein       := left.company_fein;
    self.a_duns     := left.active_duns_number;
    self.a_entnum   := left.active_enterprise_number;
    self.a_corpkey  := left.active_domestic_corp_key;
    self.address    := stringlib.stringcleanspaces(trim(left.prim_range,left,right) + ' ' + trim(left.prim_name,left,right) + ' ' + trim(left.sec_range,left,right) + ' ' + trim(left.v_city_name,left,right) + ' ' + trim(left.st,left,right) + ' ' + trim(left.zip));

    self          := left;  
  ));
  
  ds_filt := dslim(pID != (typeof(dslim.pID))'') : independent;
  
  dpost := tools.mac_AggregateFieldsPerID(ds_filt,pID,,false,pLimitChildDatasts := pLimit_ChildDatasets);
  
  dcountdotids := project(dpost,transform({recordof(left)}
    ,self := left
  ));
    
//  return %'ADD_FIELD'%;
  return dcountdotids;
  
endmacro;
