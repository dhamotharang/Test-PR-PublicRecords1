IMPORT AutoKeyI, DidVille, Gateway, iesp;

EXPORT SoapCall_DidVille(DATASET(DidVille.Layout_Did_InBatchRaw) batch_in,
	Gateway.IParam.DidVilleParams in_mod,
	INTEGER waittime=Gateway.Constants.Defaults.WAIT_TIMEOUT,
	INTEGER retries=Gateway.Constants.Defaults.RETRIES
	) := FUNCTION

	soapRequestRec:=RECORD
		BOOLEAN  AllowAll;
		STRING   Appends;
		STRING   AppendThreshold;
		STRING   ApplicationType;
		STRING   DataPermissionMask;
		STRING   DataRestrictionMask;
		BOOLEAN  Deduped;
		BOOLEAN  GLBData;
		UNSIGNED GLBPurpose;
		BOOLEAN  IncludeMinors;
		BOOLEAN  IncludeRanking;
		STRING   IndustryClass;
		UNSIGNED Max_Results_Per_Acct;
		BOOLEAN  PatriotProcess;
		STRING   SSNMask;
		STRING   Verify;
		DATASET(DidVille.Layout_Did_InBatchRaw) did_batch_in;
	END;

	soapRequestRec setSoapRequest():=TRANSFORM
		SELF.AllowAll:=in_mod.AllowAll;
		SELF.Appends:=in_mod.Appends;
		SELF.AppendThreshold:=in_mod.AppendThreshold;
		SELF.ApplicationType:=in_mod.ApplicationType;
		SELF.DataPermissionMask:=in_mod.DataPermissionMask;
		SELF.DataRestrictionMask:=in_mod.DataRestrictionMask;
		SELF.Deduped:=in_mod.Deduped;
		SELF.GLBData:=in_mod.AllowGLB;
		SELF.GLBPurpose:=in_mod.GLBPurpose;
		SELF.IncludeMinors:=in_mod.IncludeMinors;
		SELF.IncludeRanking:=in_mod.IncludeRanking;
		SELF.IndustryClass:=in_mod.IndustryClass;
		SELF.PatriotProcess:=in_mod.PatriotProcess;
		SELF.Max_Results_Per_Acct:=in_mod.MaxResultsPerAcct;
		SELF.SSNMask:=in_mod.SSN_Mask;
		SELF.Verify:=in_mod.Verify;
		SELF.did_batch_in:=batch_in;
	END;

	resultRec:=RECORD
		didville.Layout_Did_OutBatch_Raw;
	END;

	soapResultRec:=RECORD
		resultRec;
		STRING soap_message {MAXLENGTH(8000)}:='';
	END;

	soapResponseRec:=RECORD
		iesp.share.t_ResponseHeader;
		DATASET(resultRec) Result;
	END;

	soapResponseRecEx:=RECORD
		soapResponseRec;
		STRING soap_message {MAXLENGTH(8000)}:='';
	END;

	soapResultRec failX(soapRequestRec L):=TRANSFORM
		SELF.soap_message := FAILMESSAGE('soapresponse');
		SELF:=L;
		SELF:=[];
	END;

	soapResponseRecEx setSoapError(DATASET(DidVille.Layout_Did_InBatchRaw) L):=TRANSFORM
		err:=AutoKeyI.errorcodes._codes.SOAP_ERR;
		msg:=AutoKeyI.errorcodes._msgs(err);
		SELF.Status := err;
		SELF.Message := msg;
		SELF.Exceptions := DATASET([{'ECL',err,'',msg}],iesp.share.t_WsException);
		SELF.Result := PROJECT(L,TRANSFORM(resultRec,SELF:=LEFT,SELF:=[]));
		SELF:=[];
	END;

	serviceURL:=in_mod.gateways(Gateway.Configuration.IsNeutralRoxie(servicename))[1].URL;

	soapResponseRecEx doSoapCall(soapRequestRec L) := TRANSFORM
		ds_soapReq := DATASET([L],soapRequestRec);
		ds_soapResp := SOAPCALL(ds_soapReq,serviceURL,
			'DidVille.Did_Batch_Service_Raw',
			{ds_soapReq},DATASET(soapResultRec),
			ONFAIL(failX(LEFT)),
			TIMEOUT(waittime),RETRY(retries),TRIM,LOG);
		hasSoapMsg:=LENGTH(ds_soapResp[1].soap_message)>0;
		// As of now all queries rely on Status=0 in order to pull resolved Lexid
		// Status:=MAP() in pickupSoapMessage() should prevent an input Lexid to be confused with a resolved Lexid
		SELF.Result := IF(hasSoapMsg,PROJECT(L.did_batch_in,TRANSFORM(resultRec,SELF:=LEFT,SELF:=[])),
			PROJECT(ds_soapResp,TRANSFORM(resultRec,SELF:=LEFT,SELF:=[])));
		SELF.soap_message := ds_soapResp[1].soap_message;
		SELF:=[];
	END;

	soapRequest:=DATASET([setSoapRequest()]);
	soapResponse:=IF(serviceURL!='',PROJECT(soapRequest,doSoapCall(LEFT)),DATASET([setSoapError(batch_in)]));

	soapResponseRec pickupSoapMessage(soapResponseRecEx L) := TRANSFORM
		faultRec := RECORD
			STRING  Source   := XMLTEXT('faultactor');
			INTEGER Code     := (INTEGER) XMLTEXT('faultcode');
			STRING  Location := XMLTEXT('Location');
			STRING  Message  := XMLTEXT('faultstring');
		END;
		soapMsg := DATASET([L.soap_message],{STRING line});
		parsedSoapResponse := PARSE(soapMsg,line,faultRec,XML('soap:Envelope/soap:Body/soap:Fault'));
		soapFault := PROJECT(parsedSoapResponse,iesp.share.t_WsException);
		hasSoapMsg:=L.soap_message!='';
		SELF.Status := MAP(
			hasSoapMsg AND soapFault[1].Code!=0 => soapFault[1].Code,
			hasSoapMsg => AutoKeyI.errorcodes._codes.SOAP_ERR,
			L.Status);
		SELF.Message := IF(hasSoapMsg,soapFault[1].Message,L.Message);
		SELF.Exceptions := IF(hasSoapMsg,CHOOSEN(soapFault,iesp.Constants.MaxResponseExceptions),L.Exceptions);
		SELF:=L;
	END;

	// OUTPUT(soapRequest,NAMED('soapRequest'));
	// OUTPUT(soapResponse,NAMED('soapResponse'));

	RETURN PROJECT(soapResponse,pickupSoapMessage(LEFT));
END;
