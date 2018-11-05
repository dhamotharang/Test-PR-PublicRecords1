import _control,std;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export do_WUWaitComplete(string pWorkunitID = '',integer pWait = -1,boolean pReturnOnWait = false,string pesp = _Config.LocalEsp) :=
function

	WUWaitCompleteRequest :=
	record, maxlength(100)
		string  Wuid                     {xpath('Wuid'         )} := pWorkunitID;
		integer Wait                     {xpath('Wait'         )} := pWait;
		boolean ReturnOnWait             {xpath('ReturnOnWait' )} := pReturnOnWait;
	end;

	ECLExceptionLayout :=
	record
	
		string 	Source  		{xpath('Source'  	)};
		string	Severity		{xpath('Severity'	)};
		integer	Code        {xpath('Code'     )};
		string  Message 		{xpath('Message'	)};
		string  FileName		{xpath('FileName'	)};
		integer LineNo  		{xpath('LineNo'	  )};
		integer Column  		{xpath('Column'	  )};
	
	end;

	WUWaitCompleteOutRecord :=
	record, maxlength(100000)
	
		string  exception_code    {xpath('Exceptions/Exception/Code'    )};
		string  exception_source  {xpath('Exceptions/Exception/Source'  )};
		string  exception_msg     {xpath('Exceptions/Exception/Message' )};
		integer StateID           {xpath('StateID'                      )};
	
 	end;

  esp				:= pesp + ':8010';	//oss is 242,infiniband is '10.241.3.242'

  results := SOAPCALL(
    'http://' + esp + '/WsWorkunits?ver_=1.48'
    ,'WUWaitComplete'
    ,WUWaitCompleteRequest
    ,dataset(WUWaitCompleteOutRecord)
    ,xpath('WUWaitResponse')
    ,LITERAL
   //,heading('<WUWaitCompleteRequest>','</WUWaitCompleteRequest>')
   ,TIMEOUT(0) //wait forever
  );
  
  return if(WorkMan.Is_Valid_Wuid(pWorkunitID)  ,results ,dataset([],WUWaitCompleteOutRecord));
		  
end;