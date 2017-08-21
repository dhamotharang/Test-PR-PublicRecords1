//ModifiedBy:vern_p bentley
//ModifiedDate:2015-10-27T18:22:45Z
//Description:
newDS:=DATASET([
  {1,'LEXISNEXIS','6601','PARK OF COMMERCE','','BOCA RATON','FL','33487','','','','','','','','','','',''}
],BizLinkFull_HS.lBatchInput);
PIPE(newDS,
'roxiepipe -iw '+ SIZEOF(BizLinkFull_HS.lBatchInput)+' -t 1 -ow '+ SIZEOF(BizLinkFull_HS.lBatchOutput)+' -b 100 -mr 2 -h 10.239.190.1:9876 -vip -r Results '+
'-q "<BizLinkFull_HS.svcbatch format=\'raw\'><batch_in id=\'id\' format=\'raw\'></batch_in></BizLinkFull_HS.svcbatch>"',
BizLinkFull_HS.lBatchOutput);
