import bipv2,bizlinkfull,bipv2_testing;
EXPORT External_Append_Testing(

  string pversion = bipv2.KeySuffix

) :=
function

  dRawData:=BIPV2_Testing.files.xlink;

  THISMODULE:=BizLinkFull;

  lAppended:={UNSIGNED proxid;UNSIGNED score;UNSIGNED weight;RECORDOF(dRawData);};

  dInputFormalized:=THISMODULE._Search.macFormalize(dRawData);

  dBatchResult:=THISMODULE._Search.BatchSubmit(dInputFormalized);
  dBatchNormed:=NORMALIZE(dBatchResult,COUNT(LEFT.results),TRANSFORM({UNSIGNED uniqueid;RECORDOF(LEFT.results);},SELF.uniqueid:=LEFT.reference;SELF:=LEFT.results[COUNTER];));
  dBatchTop:=DEDUP(SORT(dBatchNormed,uniqueid,-score),uniqueid);
  dBatchJoined:=JOIN(dRawData,dBatchTop,LEFT.rid=RIGHT.uniqueid,TRANSFORM(lAppended,SELF.proxid:=RIGHT.proxid;SELF.score:=RIGHT.score;SELF.weight:=RIGHT.weight;SELF:=LEFT;),LEFT OUTER);

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

  return OUTPUT(project(macRecall(dBatchJoined),transform({string version, recordof(left)},self.version := pversion, self := left)),NAMED('Recall'));

end;