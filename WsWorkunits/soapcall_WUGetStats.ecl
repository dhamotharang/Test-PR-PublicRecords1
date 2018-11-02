/*
  patterned after ThorBackup.GetWUModified
  apparently gets the time that a wuid finished in Zulu time which is 4 hours ahead of EST.
  there might be other stats to get from the wuid using the "Kind" field.  
*/

import _control,std;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export soapcall_WUGetStats(
   string pWorkunitID = ''
  ,string pesp        = _Config.localEsp
) :=
function

  checkoutAttributeInRecord := 
  record

    string WUID         {xpath('WUID'         )} := pWorkunitID         ;
    string CreatorType  {xpath('CreatorType'  )} := 'hthor_dev'         ; // after 6.2.14
    string Kind         {xpath('Kind'         )} := 'WhenQueryFinished' ; // after 6.2.14

  end;


  WUStatisticItem := 
  record
    string Value{xpath('Value')};
  end;

  checkoutAttributeOutRecord := 
  record
    string                    WUID  {xpath('WUID'                       )};
    dataset(WUStatisticItem)  stats {xpath('Statistics/WUStatisticItem' )};
  end;

  esp				:= pesp + ':8010';	//oss is 242,infiniband is '10.241.3.242'

  results := SOAPCALL(
     'http://'+esp+'/WsWorkunits?ver_=1.48'
    ,'WUGetStats'
    ,checkoutAttributeInRecord
    ,dataset(checkoutAttributeOutRecord)
    ,xpath('WUGetStatsResponse')
    ,timelimit(600) //5 minutes
  );
    
  return if(Is_Valid_Wuid(pWorkunitID)  ,results ,dataset([],checkoutAttributeOutRecord));
		
end;