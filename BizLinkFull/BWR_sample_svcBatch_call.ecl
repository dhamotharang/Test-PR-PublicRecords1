//ModifiedBy:vern_p bentley
//ModifiedDate:2015-10-27T18:22:45Z
//Description:
newDS:=DATASET([
  {1,'LEXISNEXIS','6601','PARK OF COMMERCE','','BOCA RATON','FL','33487','','','','','','','','','','',''}
],BizLinkFull.lBatchInput);
PIPE(newDS,
'roxiepipe -iw '+ SIZEOF(BizLinkFull.lBatchInput)+' -t 1 -ow '+ SIZEOF(BizLinkFull.lBatchOutput)+' -b 100 -mr 2 -h 10.239.190.1:9876 -vip -r Results '+
'-q "<BizLinkFull.svcbatch format=\'raw\'><batch_in id=\'id\' format=\'raw\'></batch_in></BizLinkFull.svcbatch>"',
BizLinkFull.lBatchOutput);

