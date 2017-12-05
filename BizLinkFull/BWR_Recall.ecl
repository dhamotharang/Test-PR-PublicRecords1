#workunit('name','BIP External Append Testing - 20151014');
dRawData:=BIPV2_Testing.files.xlink;
// THISMODULE:=BizLinkFull;
THISMODULE:=BizLinkFull;
lAppended:={UNSIGNED proxid;UNSIGNED score;UNSIGNED weight;RECORDOF(dRawData);};
OUTPUT(dRawData,NAMED('RawData'));
dInputFormalized:=THISMODULE._Search.macFormalize(dRawData);
OUTPUT(dInputFormalized,NAMED('InputFormalized'));
dBatchResult:=THISMODULE._Search.BatchSubmit(dInputFormalized);//:PERSIST('~dhw::persist::recall_appends');
dBatchNormed:=NORMALIZE(dBatchResult,COUNT(LEFT.results),TRANSFORM({UNSIGNED uniqueid;RECORDOF(LEFT.results);},SELF.uniqueid:=LEFT.reference;SELF:=LEFT.results[COUNTER];));
dBatchTop:=DEDUP(SORT(dBatchNormed,uniqueid,-score),uniqueid);
dBatchJoined:=JOIN(dRawData,dBatchTop,LEFT.rid=RIGHT.uniqueid,TRANSFORM(lAppended,SELF.proxid:=RIGHT.proxid;SELF.score:=RIGHT.score;SELF.weight:=RIGHT.weight;SELF:=LEFT;),LEFT OUTER);
OUTPUT(CHOOSEN(dBatchResult,100),NAMED('dBatchResult'));
OUTPUT(CHOOSEN(dBatchJoined,100),NAMED('dBatchJoined'));
macSamples(s):=MACRO
  #UNIQUENAME(dMissing)
  %dMissing%:=PROJECT(dBatchJoined,TRANSFORM(
    {STRING search__html;RECORDOF(LEFT);},
    sSearchParameters:=REGEXREPLACE(' ','uniqueid='+LEFT.rid+
      IF(LEFT.company_name='','','&company_name='+TRIM(LEFT.company_name))+
      IF(LEFT.company_prim_range='','','&prim_range='+TRIM(LEFT.company_prim_range))+
      IF(LEFT.company_prim_name='','','&prim_name='+TRIM(LEFT.company_prim_name))+
      IF(LEFT.company_sec_range='','','&sec_range='+TRIM(LEFT.company_sec_range))+
      IF(LEFT.company_city='','','&city='+TRIM(LEFT.company_city))+
      IF(LEFT.company_state='','','&st='+TRIM(LEFT.company_state))+
      IF(LEFT.company_phone='','','&company_phone='+TRIM(LEFT.company_phone))+
      IF(LEFT.company_fein='','','&company_fein='+TRIM(LEFT.company_fein))+
      IF(LEFT.email_address='','','&contact_email='+TRIM(LEFT.email_address))+
      IF(LEFT.fname='','','&fname='+TRIM(LEFT.fname))+
      IF(LEFT.mname='','','&mname='+TRIM(LEFT.mname))+
      IF(LEFT.lname='','','&lname='+TRIM(LEFT.lname)),'+');
    SELF.search__html:=BIPV2.Hyperlink().BIPSearch(sSearchParameters);
    SELF:=LEFT;
  ));
  OUTPUT(%dMissing%(src=s AND score=0),NAMED(TRIM(s[..4])+'_Missing'),ALL);
  OUTPUT(%dMissing%(src=s AND score<75),NAMED(TRIM(s[..4])+'_Missing75'),ALL);
  
  #UNIQUENAME(dAmbiguous)
  %dAmbiguous%:=dBatchJoined(src=s AND score>=50 AND score<75);
  OUTPUT(JOIN(dBatchNormed,%dAmbiguous%,LEFT.uniqueid=RIGHT.rid,TRANSFORM(LEFT)),NAMED(TRIM(s[..4])+'_50_75'),ALL);
  
  #UNIQUENAME(dHighPairs)
  %dHighPairs%:=JOIN(dBatchResult(Results[1].score>10 AND Results[2].score>10),%dAmbiguous%,LEFT.reference=RIGHT.rid,TRANSFORM(
    {STRING proxid_01__html;STRING proxid_02__html;STRING proxid_compare__html;UNSIGNED1 weight_01;UNSIGNED1 score_01;UNSIGNED1 weight_02;UNSIGNED1 score_02;STRING address1__html;STRING address2__html;},
    SELF.proxid_01__html:=BIPV2.Hyperlink().BIPHeader(LEFT.Results[1].proxid);
    SELF.proxid_02__html:=BIPV2.Hyperlink().BIPHeader(LEFT.Results[2].proxid);
    SELF.proxid_compare__html:=BIPV2.Hyperlink().ProxidCompare(LEFT.Results[1].proxid,LEFT.Results[2].proxid);
    SELF.weight_01:=LEFT.Results[1].weight;
    SELF.score_01:=LEFT.Results[1].score;
    SELF.weight_02:=LEFT.Results[2].weight;
    SELF.score_02:=LEFT.Results[2].score;
    SELF.address1__html:=BIPV2.Hyperlink().GoogleMaps(LEFT.Results[1].prim_range+' '+LEFT.Results[1].prim_name+' '+LEFT.Results[1].city+' '+LEFT.Results[1].st+' '+LEFT.Results[1].zip_cases[1].zip);  
    SELF.address2__html:=BIPV2.Hyperlink().GoogleMaps(LEFT.Results[2].prim_range+' '+LEFT.Results[2].prim_name+' '+LEFT.Results[2].city+' '+LEFT.Results[2].st+' '+LEFT.Results[2].zip_cases[1].zip);  
  ));
  OUTPUT(%dHighPairs%,NAMED(TRIM(s[..4])+'_Ambiguous_Links'),ALL);
ENDMACRO;
macSamples('BK');
macSamples('CORP');
macSamples('INQ');
macSamples('PAW');
macSamples('UCC');
macSamples('MV');
macSamples('PROP?');
macSamples('DNBF');
 
macCardinality(d):=FUNCTIONMACRO
RETURN SORT(TABLE(d,{
  score;
  UNSIGNED total_count:=COUNT(GROUP);
  UNSIGNED BK_count:=COUNT(GROUP,src='BK');
  UNSIGNED CORP_count:=COUNT(GROUP,src='CORP');
  UNSIGNED INQ_count:=COUNT(GROUP,src='INQ');
  UNSIGNED PAW_count:=COUNT(GROUP,src='PAW');
  UNSIGNED UCC_count:=COUNT(GROUP,src='UCC');
  UNSIGNED MV_count:=COUNT(GROUP,src='MV');
  UNSIGNED PROP_count:=COUNT(GROUP,src='PROP?');
  UNSIGNED DNBF_count:=COUNT(GROUP,src='DNBF');
},score),-score);
ENDMACRO;
macRecall(d):=FUNCTIONMACRO
RETURN TABLE(d,{
  src;
  count_0:=COUNT(GROUP,d.proxid>0);
  perc_0:=COUNT(GROUP,d.proxid>0)/COUNT(GROUP);
  count_25:=COUNT(GROUP,d.proxid>0 AND d.score>=25);
  perc_25:=COUNT(GROUP,d.proxid>0 AND d.score>=25)/COUNT(GROUP);
  count_50:=COUNT(GROUP,d.proxid>0 AND d.score>=50);
  perc_50:=COUNT(GROUP,d.proxid>0 AND d.score>=50)/COUNT(GROUP);
  count_75:=COUNT(GROUP,d.proxid>0 AND d.score>=75);
  perc_75:=COUNT(GROUP,d.proxid>0 AND d.score>=75)/COUNT(GROUP);
},src);
ENDMACRO;
OUTPUT(macCardinality(dBatchJoined),NAMED('Cardinality'));
OUTPUT(macRecall(dBatchJoined),NAMED('Recall'));
