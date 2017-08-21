EXPORT CompileWuid(

   string  pEcl
  ,string  pcluster           = _constants.LocalHthor
  ,string  pESP               = _constants.LocalEsp
  ,string  pESPPort           = '8010'

) := 
function

  // -- add parent wuid link
  eclcode     := 'output(\'<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Summary">Parent Workunit</a>\' ,named(\'Parent_Wuid__html\'));\n'
                + pEcl
                ;
              
    rWuCompileRequest  :=
    record
      string                    ECL                 {xpath('ECL'                ),maxlength(20000)}  :=  pEcl;
      string                    Queue               {xpath('Queue'              ),maxlength(20000)}  :=  pcluster;
      string                    Cluster             {xpath('Cluster'            ),maxlength(20000)}  :=  pcluster;

      string                    ModuleName          {xpath('ModuleName'         ),maxlength(20000)}  :=  '';
      string                    AttributeName       {xpath('AttributeName'      ),maxlength(20000)}  :=  '';
      string                    Snapshot            {xpath('Snapshot'           ),maxlength(20000)}  :=  '';//pcluster;
      string                    IncludeDependencies {xpath('IncludeDependencies'),maxlength(20000)}  :=  '0';
      string                    IncludeComplexity   {xpath('IncludeComplexity'  ),maxlength(20000)}  :=  '0';
      string                    TimeToWait          {xpath('TimeToWait'         ),maxlength(20000)}  :=  '60000';
   
   end;

    rESPExceptions  :=
    record
      string    Code      {xpath('Code'     ),maxlength(10)};
      string    Source    {xpath('Source'   ),maxlength(50)};
      string    Audience  {xpath('Audience' ),maxlength(30)};
      string    Message   {xpath('Message'  ),maxlength(200)};
    end;
    
    rECLExceptions  :=
    record
      string    Code      {xpath('Code'     ),maxlength(10)};
      string    Source    {xpath('Source'   ),maxlength(50)};
      string    Severity  {xpath('Severity' ),maxlength(30)};
      string    Message   {xpath('Message'  ),maxlength(200)};
      string    FileName  {xpath('FileName' ),maxlength(200)};
      string    LineNo    {xpath('LineNo'   ),maxlength(200)};
      string    Column    {xpath('Column'   ),maxlength(200)};
    end;

    rEclExceptions2 :=
    record
      dataset(rECLExceptions)    ECLException{xpath('ECLException'),maxcount(110)};
    end;

    rWUCompileResponse  :=
    record
      // string                     Wuid{xpath('Workunit/Wuid'),maxlength(20)};
      // dataset(rECLExceptions)    Errors{xpath('Errors/ECLException'),maxcount(110)};
      dataset(rESPExceptions)    Exceptions{xpath('Exceptions/Exception'),maxcount(110)};
      dataset(rECLExceptions)    Errors{xpath('Errors/ECLException'),maxcount(110)};
    end;

    ds_WUCompileResult  :=  soapcall('http://' + pESP + ':' + pESPPort + '/WsWorkunits?ver_=1.56',
                                           'WUCompileECL',
                                           rWuCompileRequest,
                                           rWUCompileResponse,
                                           xpath('WUCompileECLResponse')
                                           ,literal
                                          );

    // return  normalize(dataset(ds_WUCompileResult),left.errors,transform(recordof(right),self := right));
    return  dataset(ds_WUCompileResult);

end;
