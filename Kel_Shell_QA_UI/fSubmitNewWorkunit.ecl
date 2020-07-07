EXPORT	STRING	fSubmitNewWorkunit(STRING pECLText, STRING pCluster, STRING pQueue,STRING Env)	:=	FUNCTION
		STRING fWUCreateAndUpdate(STRING pECLText)	:=		FUNCTION
            rDebugValue  := RECORD
				STRING		Name{XPATH('Name'),MAXLENGTH(100)};
				STRING		Value{XPATH('Value'),MAXLENGTH(50)};
            END;
            
            dsValues := dataset([{'PublicRecords-branch','ScoringQA'}],rDebugValue);
			rDebugValues :=
			record
				dataset (rDebugValue)								DebugValue{xpath('DebugValue')}	:= dsValues;//   ,maxcount(1)};
			end;

			rWUCreateAndUpdateRequest	:= RECORD
				STRING	QueryText{XPATH('QueryText'),MAXLENGTH(20000)}								:=	pECLText;
                rDebugValues							DebugValues{xpath('DebugValues')};// ,maxcount(1)};
			END;

			rESPExceptions	:= RECORD
				STRING		Code{XPATH('Code'),MAXLENGTH(10)};
				STRING		Audience{XPATH('Audience'),MAXLENGTH(50)};
				STRING		Source{XPATH('Source'),MAXLENGTH(30)};
				STRING		Message{XPATH('Message'),MAXLENGTH(200)};
			END;
            
			rWUCreateAndUpdateResponse	:=	RECORD
				STRING										Wuid{XPATH('Workunit/Wuid'),MAXLENGTH(20)};
				DATASET(rESPExceptions)		Exceptions{XPATH('Exceptions/ESPException'),maxcount(110)};
			END;

			dWUCreateAndUpdateResult	:=	SOAPCALL(Env,//'http://10.193.211.1:8010/WsWorkunits/',
																						 'WUUpdate',
																						 rWUCreateAndUpdateRequest,
																						 rWUCreateAndUpdateResponse,
																						 XPATH('WUUpdateResponse')
																						);

			RETURN	dWUCreateAndUpdateResult.WUID;
			
		END;
		
		fWUSubmit(STRING pWUID, STRING pCluster, STRING pQueue)	:= FUNCTION
			rWUSubmitRequest	:=	RECORD
				STRING										WUID{XPATH('Wuid'),MAXLENGTH(20)}										:=	pWUID;
				STRING										Cluster{XPATH('Cluster'),MAXLENGTH(30)}							:=	pCluster;
				STRING										Queue{XPATH('Queue'),MAXLENGTH(30)}									:=	pQueue;
				STRING										Snapshot{XPATH('Snapshot'),MAXLENGTH(10)}						:=	'';
				STRING										MaxRunTime{XPATH('MaxRunTime'),MAXLENGTH(10)}				:=	'0';
				STRING										Block{XPATH('BlockTillFinishTimer'),MAXLENGTH(10)}	:=	'0';
			END;

			rWUSubmitResponse	:= RECORD
				STRING										Code{XPATH('Code'),MAXLENGTH(10)};
				STRING										Audience{XPATH('Audience'),MAXLENGTH(50)};
				STRING										Source{XPATH('Source'),MAXLENGTH(30)};
				STRING										Message{XPATH('Message'),MAXLENGTH(200)};
			END;

			dWUSubmitResult	:=	SOAPCALL(Env,//'http://10.193.211.1:8010/WsWorkunits/',
																	 'WUSubmit',
																	 rWUSubmitRequest,
																	 rWUSubmitResponse,//DATASET(rWUSubmitResponse),
																	 XPATH('WUSubmitResponse/Exceptions/Exception')
																	);

			RETURN	dWUSubmitResult;
		END;

		STRING	lWUIDCreated	:=	fWUCreateAndUpdate(pECLText);
		dExceptions						:=	fWUSubmit(lWUIDCreated, pCluster, pQueue);
		STRING	RETURNValue		:=	IF(dExceptions.Code = '',
																 lWUIDCreated,
																 ''
																);
		RETURN	dExceptions.Code;//RETURN	RETURNValue;
	END;