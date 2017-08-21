/*
  if you want to get a dataset result from a remote environment(not local), the layout passed in needs to have xpaths for each field(because I need to use httpcall and parse the resulting xml)
  if you are just grabbing a local dataset result(within the environment this runs), then you don't need xpaths.
*/
/*
import wk_ut_dev;
export get_DS_Result(pWuid,pNamedOutput,pRecordLayout,pesp = '_constants.LocalEsp') := 
functionmacro
  attr := DATASET( WORKUNIT(pWuid , pNamedOutput ), pRecordLayout );
  return if(wk_ut_dev.Is_Valid_Wuid(pWuid) ,attr ,dataset([],pRecordLayout));
endmacro;
*/

import wk_ut_dev,tools;
export get_DS_Result(pWuid,pNamedOutput,pRecordLayout,pesp = 'wk_ut_dev._constants.LocalEsp') := 
functionmacro
  
  import wk_ut_dev,tools;
  
  shared local_DS_result := DATASET( WORKUNIT(pWuid , pNamedOutput ), pRecordLayout );

  seq := wk_ut_dev.get_WUInfo(pWuid,pesp).ScalarResultSeq2(pNamedOutput);
  // seq := 2;

  // #uniquename(mylayoutmod )
  // #uniquename(mylayout    )
  
  // #SET(mylayoutmod  ,tools.macf_LayoutTools(pRecordLayout,true,,true,false)   )
  // #SET(mylayout     ,%mylayoutmod%.layout_record_xpath                        )


  // mylayoutmod := tools.macf_LayoutTools(pRecordLayout,false,,true,false);
  // mylayout    := mylayoutmod.layout_record_xpath;

  mylayout := pRecordLayout;
  
  myd := {dataset(mylayout) fred{xpath('Row')}};

  raw := HTTPCALL('http://' + pesp + ':8010/WsWorkunits/WUResult.xml?Wuid=' + pWuid + '&Sequence=' + (string)seq, 'GET', 'text/xml', myd,xpath('WUResultResponse/Result/Dataset')); 

  remote_DS_result  := normalize(dataset(raw),left.fred,transform(mylayout,self := right));

  IsEspLocal        := if(pesp in wk_ut_dev._constants.LocalEsps ,true ,false);

  return if(wk_ut_dev.Is_Valid_Wuid(pWuid) 
    ,if(IsEspLocal  ,local_DS_result 
                    ,remote_DS_result
    )
    ,dataset([],pRecordLayout)
  );

endmacro;

