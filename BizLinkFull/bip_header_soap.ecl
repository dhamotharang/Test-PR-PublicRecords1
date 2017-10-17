IMPORT BizLinkFull;
EXPORT bip_header_soap := MACRO
  LOADXML(BizLinkFull._Search.sFieldNames);
  #DECLARE(input_fields)
  #DECLARE(last_field)
  #DECLARE(maps)
  #DECLARE(input_layout)
  #DECLARE(input_dataset)
  #FOR(Row)
    #IF(%'{@field}'% NOT IN ['cnp_name','cnp_number','cnp_btype','cnp_lowv','company_phone_3','company_phone_3_ex','company_phone_7','company_name_prefix','fname_preferred','sele_flag','org_flag','ult_flag','contact_name','streetaddress'])
      #APPEND(input_fields,'STRING Input_'+%'{@alternative}'%+' := \'\' : STORED(\''+%'{@alternative}'%+'\');\n')
      #IF(%'{@field}'%=%'last_field'%)
        #APPEND(maps,',Input_'+%'{@alternative}'%+'<>\'\'=>Input_'+%'{@alternative}'%)
      #ELSE
        #APPEND(maps,');\n')
        #APPEND(maps,'I_'+%'{@field}'%+':=MAP(Input_'+%'{@alternative}'%+'<>\'\'=>Input_'+%'{@alternative}'%)
        #APPEND(input_dataset,',I_'+%'{@field}'%)
        #APPEND(input_layout,'STRING '+%'{@field}'%+';')
      #END
    #END
    #SET(last_field,%'{@field}'%)
  #END
  #SET(maps,%'maps'%[3..]+');\n')
  #SET(maps,REGEXREPLACE('MAP[(]([^<]+)[^,)]+[)]',%'maps'%,'$1'))
  #SET(maps,REGEXREPLACE(',([^,<]+)[^,)]+[)]',%'maps'%,',$1)'))
  #SET(maps,REGEXREPLACE('(I_maxids:=)[^;]+',%'maps'%,'$1 50'))
  #SET(input_dataset,'DATASET([{'+%'input_dataset'%[2..]+'}],{'+%'input_layout'%+'});')
  #EXPAND(%'input_fields'%);
  BOOLEAN GroupProxID:=FALSE: stored('GroupProxID');
  BOOLEAN bDebug:=FALSE:STORED('DebugMode');
  BOOLEAN bBatch:=FALSE:STORED('BatachMode');
  
  #SET(maps,REGEXREPLACE('(STRING Input_soapcallmode := )(\'\')([^;]+);',%'maps'%,'$1\'TRUE\'$2'))
  #EXPAND(%'maps'%);
  dInput:=#EXPAND(%'input_dataset'%);
  dFormalized:=BizLinkFull._Search.macFormalize(dInput);
  dInputFormatted:=PROJECT(dFormalized,BizLinkFull.Process_Biz_Layouts.InputLayout);
  dResults:=BizLinkFull.MEOW_Biz(dInputFormatted).Data_;
  dProxids:=SORT(TABLE(dResults,{proxid;weight;KeysUsed;KeysFailed;UNSIGNED proxid_count:=COUNT(GROUP);},proxid,KeysFailed),-weight,proxid,KeysFailed);
  dNamesAddresses:=TABLE(dResults,{company_name;prim_range;prim_name;city;st;zip;},company_name,prim_range,prim_name,city,st,zip);
  dAggregated:=SORT(tools.mac_AggregateFieldsPerID(dResults,proxid),-weights[1].weight);
  dInputData:=PROJECT(dInputFormatted,TRANSFORM({RECORDOF(LEFT) AND NOT [zip_cases];STRING city_entered;STRING state_entered;STRING derived_city;STRING derived_state;STRING zip_entered;UNSIGNED zip_radius;UNSIGNED zip_count;},
    SELF.city_entered:=Input_city;
    SELF.state_entered:=Input_st;
    SELF.derived_city:=LEFT.city;
    SELF.derived_state:=LEFT.st;
    SELF.zip_entered:=Input_zip;
    SELF.zip_radius:=(UNSIGNED)Input_zip_radius;
    SELF.zip_count:=COUNT(LEFT.zip_cases);
    SELF:=LEFT;
  ));
  dKeysUsed:=TABLE(dProxids,{KeysUsed;STRING keys:=BizLinkFull.Process_Biz_Layouts.KeysUsedToText(KeysUsed);},KeysUsed);
  dKeyLegend:=BizLinkFull.linkpaths;
  
  dRawResults:=BizLinkFull.MEOW_Biz(dInputFormatted).Raw_Results;
  dRawResultsClipped:=PROJECT(dRawResults,TRANSFORM(RECORDOF(LEFT),
    SELF.results:=TOPN(LEFT.results,10,-weight);
    SELF.results_seleid:=TOPN(LEFT.results_seleid,10,-weight);
    SELF.results_orgid:=TOPN(LEFT.results_orgid,10,-weight);
    SELF.results_ultid:=TOPN(LEFT.results_ultid,10,-weight);
    SELF:=LEFT;
  ));
    
  IF((BOOLEAN)Input_soapcallmode,
    OUTPUT(dRawResultsClipped,NAMED('soap_results')),
    SEQUENTIAL(
      IF(GroupProxID,OUTPUT(dAggregated,named('Header_Data_Grouped')),IF(bDebug,OUTPUT(BizLinkFull.MEOW_Biz(dInputFormatted)),OUTPUT(dResults,named('Header_Data')))),
      OUTPUT(dInputData,NAMED('InputData')),
      OUTPUT(dProxids,NAMED('ProxidsReturned')),
      OUTPUT(dNamesAddresses,NAMED('NamesAndAddresses')),
      OUTPUT(dKeysUsed,NAMED('KeysUsed')),
      OUTPUT(dKeyLegend,NAMED('KeyLegend'))
    )
  );
    // OUTPUT(dRawResultsClipped,NAMED('soap_results'));
ENDMACRO;
  

