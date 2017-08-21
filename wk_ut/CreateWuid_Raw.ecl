EXPORT CreateWuid_Raw(

   string  pEcl
  ,string  pcluster
  ,string  pESP               = _constants.LocalEsp
  ,string  pESPPort           = '8010'

) := 
function

  // -- add parent wuid link
  eclcode     := 'output(\'<a href="http://' + _constants.LocalEsp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Summary">Parent Workunit</a>\' ,named(\'Parent_Wuid__html\'));\n'
                + pEcl
                ;
              
  string fWUCreateAndUpdate(string pECLText)  :=
  function
    rWUCreateAndUpdateRequest  :=
    record
      string                    QueryText{xpath('QueryText'),maxlength(20000)}                :=  pECLText;
    end;

    rESPExceptions  :=
    record
      string    Code{xpath('Code'),maxlength(10)};
      string    Audience{xpath('Audience'),maxlength(50)};
      string    Source{xpath('Source'),maxlength(30)};
      string    Message{xpath('Message'),maxlength(200)};
    end;

    rWUCreateAndUpdateResponse  :=
    record
      string                     Wuid{xpath('Workunit/Wuid'),maxlength(20)};
      dataset(rESPExceptions)    Exceptions{xpath('Exceptions/ESPException'),maxcount(110)};
    end;

    dWUCreateAndUpdateResult  :=  soapcall('http://' + pESP + ':' + pESPPort + '/WsWorkunits',
                                           'WUUpdate',
                                           rWUCreateAndUpdateRequest,
                                           rWUCreateAndUpdateResponse,
                                           xpath('WUUpdateResponse')
                                          );

    return  dWUCreateAndUpdateResult.WUID;
  end;

  // ------------------------------------------------------------------------------------------------
  fWUSubmit(string pWUID/*, string pCluster, string pQueue*/)  :=
  function
    rWUSubmitRequest  :=
    record
      string                    WUID{xpath('Wuid'),maxlength(20)}                    :=  pWUID;
      string                    Cluster{xpath('Cluster'),maxlength(30)}              :=  pCluster;
      string                    Queue{xpath('Queue'),maxlength(30)}                  :=  pCluster;
      string                    Snapshot{xpath('Snapshot'),maxlength(10)}            :=  '';
      string                    MaxRunTime{xpath('MaxRunTime'),maxlength(10)}        :=  '0';
      string                    Block{xpath('BlockTillFinishTimer'),maxlength(10)}   :=  '0';
    end;

    rWUSubmitResponse  :=
    record
      string                    Code{xpath('Code'),maxlength(10)};
      string                    Audience{xpath('Audience'),maxlength(50)};
      string                    Source{xpath('Source'),maxlength(30)};
      string                    Message{xpath('Message'),maxlength(200)};
    end;

    dWUSubmitResult  :=  soapcall('http://' + pESP + ':' + pESPPort + '/WsWorkunits',
                                  'WUSubmit',
                                  rWUSubmitRequest,
                                  rWUSubmitResponse,
                                  xpath('WUSubmitResponse/Exceptions/Exception')
                                 );

    return  dWUSubmitResult;
  end;

  string  lWUIDCreated   :=  fWUCreateAndUpdate(eclcode);
  dExceptions            :=  fWUSubmit(lWUIDCreated);
  string  wuid           :=  if(dExceptions.Code = '',
                                lWUIDCreated,
                                ''
                               ) : global;
  return  wuid;

end;
