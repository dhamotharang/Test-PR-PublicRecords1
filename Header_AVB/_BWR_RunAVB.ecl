#WORKUNIT('name','Launch - Header AVB Stats');

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* This attribute launches a soapcall that will run every hour to produce a new WU for running the Score and Attribute outcome process. The code to launch just 1 job
   from your IDE is score_logs.fn_SprayFiles(workunit);

	 DEPLOY THIS CODE in HTHOR to avoid issues with Cluster. Thanks.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

lTargetESPAddress		:=	'10.241.20.202';
lTargetESPPort			:=	'8010';

	export	string	fSubmitNewWorkunit(string pECLText, string pCluster)	:=
	function
		string fWUCreateAndUpdate(string pECLText)	:=
		function

			rWUCreateAndUpdateRequest	:=
			record
				string										QueryText{xpath('QueryText'),maxlength(20000)}	:=	pECLText;
			end;

			rESPExceptions	:=
			record
				string		Code{xpath('Code'),maxlength(10)};
				string		Audience{xpath('Audience'),maxlength(50)};
				string		Source{xpath('Source'),maxlength(30)};
				string		Message{xpath('Message'),maxlength(200)};
			end;

			rWUCreateAndUpdateResponse	:=
			record
				string										Wuid{xpath('Workunit/Wuid'),maxlength(20)};
				dataset(rESPExceptions)		Exceptions{xpath('Exceptions/ESPException'),maxcount(110)};
			end;

			dWUCreateAndUpdateResult	:=	soapcall('http://' + lTargetESPAddress + ':' + lTargetESPPort + '/WsWorkunits',
																						 'WUUpdate',
																						 rWUCreateAndUpdateRequest,
																						 rWUCreateAndUpdateResponse,
																						 xpath('WUUpdateResponse')
																						);

			return	dWUCreateAndUpdateResult.WUID;
			
		end;

		fWUSubmit(string pWUID, string pCluster)	:=
		function
			rWUSubmitRequest	:=
			record
				string										WUID{xpath('Wuid'),maxlength(20)}										:=	pWUID;
				string										Cluster{xpath('Cluster'),maxlength(30)}							:=	pCluster;
				// string										Queue{xpath('Queue'),maxlength(30)}									:=	pQueue;
				string										Snapshot{xpath('Snapshot'),maxlength(10)}						:=	'';
				string										MaxRunTime{xpath('MaxRunTime'),maxlength(10)}				:=	'0';
				string										Block{xpath('BlockTillFinishTimer'),maxlength(10)}	:=	'0';
			end;

			rWUSubmitResponse	:=
			record
				string										Code{xpath('Code'),maxlength(10)};
				string										Audience{xpath('Audience'),maxlength(50)};
				string										Source{xpath('Source'),maxlength(30)};
				string										Message{xpath('Message'),maxlength(200)};
			end;

			dWUSubmitResult	:=	soapcall('http://' + lTargetESPAddress + ':' + lTargetESPPort + '/WsWorkunits',//http://10.193.211.1:8010/WsWorkunits/',
																	 'WUSubmit',
																	 rWUSubmitRequest,
																	 rWUSubmitResponse,
																	 xpath('WUSubmitResponse/Exceptions/Exception')
																	);

			return	dWUSubmitResult;
		end;

		string	lWUIDCreated	:=	fWUCreateAndUpdate(pECLText);
		dExceptions						:=	fWUSubmit(lWUIDCreated, pCluster);
		string	ReturnValue		:=	if(dExceptions.Code = '',
																 lWUIDCreated,
																 ''
																);
		return	dExceptions.Code;//return	ReturnValue;
	end;

lECL 	:=	'header_avb.Stat.build_file';

fSubmitNewWorkunit(lECL, 'thor400_20') : WHEN(CRON('0 22 * * *'));
