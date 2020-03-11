EXPORT _mac_Fraghunter(

   pHdr             = 'bipv2.CommonBase.ds_clean'  
  ,pId              = 'proxid'                    // proxid or seleid
  ,pFrag_Threshold  = '50'
  ,pNumSamples      = '300'
  // ,pCompareServiceURL = 'http://10.173.3.1:8002/WsEcl/xslt/query/roxie_devoneway_1_eclcc/'//bipv2_lgid3.lgid3compareservice.1?lgid3one=8908677&lgid3two=8955896'
  // ,pCompareServiceURL = 'http://10.173.3.1:8002/WsEcl/xslt/query/roxie_devoneway_1_eclcc/bipv2_lgid3.lgid3compareservice.1?lgid3one=8908677&lgid3two=8955896'
) := 
functionmacro

  import BIPV2_LGID3;
  
  #uniquename(ID)
  #uniquename(IDSource)
  #uniquename(IDSource2)
  #uniquename(IDCompare)
 
  #SET(ID ,#TEXT(pId))

  #IF(trim(%'ID'%) = 'proxid')
    #SET(IDCompare ,#TEXT(pId))
  #ELSE
    #SET(IDCompare ,'lgid3')
  #END
  
  #SET(IDSource  ,trim(#TEXT(pId)) + 'Source')
  #SET(IDSource2 ,trim(%'IDCompare'%) + 'Source')

  inds := project(pHdr ,transform(bipv2.CommonBase.layout,self := left,self := []));
  key_lgid3_cands := table(BIPV2_LGID3.Keys2().Candidates  ,{lgid3} ,lgid3 ,merge);

  ds_lgid3_linkable := join(pHdr  ,key_lgid3_cands  ,left.lgid3 = right.lgid3 ,transform(left)  ,hash);
  
  #IF(trim(%'ID'%) = 'proxid')
  seg := table(pHdr(sele_gold = 'G'),{pId},pId,merge);
  #ELSE
  seg := table(ds_lgid3_linkable(sele_gold = 'G'),{pId},pId,merge);
  #END
  
  seg_samp := ENTH(seg,300);

  j_proxid := JOIN(inds,seg_samp,left.pId=right.pId,TRANSFORM(left),many lookup);


  // fH := BizLinkFull.fragHunter(j_proxid,54);
  fH := BizLinkFull._mac_FragHunter_Format_Results(j_proxid,pId,pFrag_Threshold);

  #IF(trim(%'ID'%) != 'proxid')
  ds_lgid3_linkable_out1 := join(fH                       ,key_lgid3_cands  ,left.pId         = right.lgid3 ,transform(left)  ,hash);
  ds_lgid3_linkable_out2 := join(ds_lgid3_linkable_out1   ,key_lgid3_cands  ,left.%IDSource%  = right.lgid3 ,transform(left)  ,hash);
  #ELSE
  ds_lgid3_linkable_out2 := fH;
  #END
  
  ds_id_record_counts1 := join(inds ,table(ds_lgid3_linkable_out2 ,{%IDSource%} ,%IDSource% ) ,left.pId = right.%IDSource%  ,transform({unsigned6 pId},self := left) ,hash);
  ds_id_record_counts2 := table(ds_id_record_counts1 ,{unsigned6 %IDCompare% := pId  ,unsigned cnt := count(group)} ,pId);

  outRec := 
  RECORD
    string    assignee        ;
    string    comment         ;
    unsigned6 uniqueid        ;
    unsigned6 %IDSource2%     ;
    unsigned6 %IDCompare%     ;
    string	  hyperlink__html ;
    integer2  weight          ;
   END;

  // link_text_1 := '<a href="http://10.194.21.2:8131/WsEcl/xslt/query/roxie_1_eclcc/insuranceheader_salt_t46.proxidcompareservice?proxidone=';
  // link_text_1 := '<a href="http://10.173.102.101:8002/esp/files/stub.htm?Widget=IFrameWidget&src=%2FWsEcl%2Fforms%2Fecl%2Fquery%2Froxie_102%2Fbipv2_proxid.proxidcompareservice.1?proxidone='; //no worky
  #IF(trim(%'ID'%) = 'proxid')
  link_text_1 := '<a href="http://10.173.102.101:8002/WsEcl/xslt/query/roxie_102/';
  #ELSE
  link_text_1 := '<a href="http://10.173.3.1:8002/WsEcl/xslt/query/roxie_devoneway_1_eclcc/';
  #END
  link_text_2 := 'bipv2_' + %'IDCompare'% + '.' + %'IDCompare'% + 'compareservice.1?' + %'IDCompare'% + 'one=';
  link_text_3 := '&' + %'IDCompare'% + 'two=';
  link_text_4 := '">Compare</a>';

  // http://10.173.102.101:8002/WsEcl/xslt/query/roxie_102/bipv2_proxid.proxidcompareservice.1
  set_reviewers   := BIPV2._Config.Set_Sample_Reviewers;
  count_reviewers := count(set_reviewers);
  count_samples   := count(ds_lgid3_linkable_out2);
  count_samples_per_reviewer := (unsigned)((count_samples / count_reviewers) + 1);
  
  p0 := PROJECT(SORT(ds_lgid3_linkable_out2,%IDSource%,pID,-weight),TRANSFORM(outRec
    ,self.hyperlink__html := link_text_1 + link_text_2 + (string)left.%IDSource% + link_text_3 + (string)left.pId + link_text_4
    ,self.assignee        := set_reviewers[(unsigned)(counter / count_samples_per_reviewer) + 1]
    ,self.comment         := '' //set by reviewer
    ,self.%IDCompare%     := left.pId       
    ,self.%IDSource2%     := left.%IDSource%
    ,self                 := left
  ));


  return parallel(
     OUTPUT(SORT(p0,%IDSource2%,%IDCompare%,-weight),,'~BIPV2::' + trim(%'IDCompare'%) + '_recall_testing::2020110',compressed,overwrite)
    ,OUTPUT(topn(ds_id_record_counts2 ,300,%IDCompare%),named('sample_' + trim(%'IDCompare'%) + 's_record_counts'),all)
    ,OUTPUT(topn(j_proxid             ,300,pId        ),named('sample_' + trim(%'IDCompare'%) + 's'              ),all)
  );

endmacro;