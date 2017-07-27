IMPORT doxie,doxie_raw,iesp,gateway;
EXPORT SourceSummary(DATASET(doxie.Layout_ref_rid) rids,
						UNSIGNED1 dppaPurpose, UNSIGNED1 glbPurpose,
						DATASET(gateway.layouts.config) gateways) := FUNCTION

	searchRequest := RECORD
		DATASET(doxie_raw.layout_input) header_src_in;
		UNSIGNED1 DPPAPurpose;
		UNSIGNED1 GLBPurpose;
		BOOLEAN includeOccurrences;
		BOOLEAN excludeSources;
		SET OF STRING IncludeSourceList;
		Boolean _Blind := false;
	END;

	searchResult := RECORD
		iesp.share.t_ResponseHeader _Header;
		doxie_raw.occurrence.l_out;
	END;

	searchResult failx(searchRequest L) := TRANSFORM
		iesp.share.t_WsException exception() := TRANSFORM
			SELF.source := 'ROXIE',
			SELF.code := IF(FAILCODE != 0, FAILCODE, 100);
			SELF.location := FAILMESSAGE('url')[8..StringLib.StringFind(FAILMESSAGE('url'), '.', 1)-1];
			SELF.message := IF(FAILCODE != 0, FAILMESSAGE, doxie.ErrorCodes(100));
		END;
		SELF._header.exceptions := DATASET([exception()]);
		SELF := [];
	END;

	searchRequest initSrchRequest() := TRANSFORM
		SELF.header_src_in := PROJECT(rids,TRANSFORM(doxie_raw.layout_input,
			SELF.idtype:='RID',
			SELF.id:=(STRING)LEFT.rid,
			SELF:=[]));
		SELF.DPPAPurpose := dppaPurpose;
		SELF.GLBPurpose := glbPurpose;
		SELF.IncludeOccurrences := TRUE;
		SELF.ExcludeSources := TRUE;
		// 1.3.10	Requirement - ONLY 'Locator', 'Death' and 'Utility' sources
		SELF.IncludeSourceList := [doxie.SourceDocFilter.fLOCATOR, doxie.SourceDocFilter.fDECEASED, doxie.SourceDocFilter.fUTILITY];
		SELF._Blind := Gateway.Configuration.GetBlindOption(gateways);
		SELF:=[];
	END;

	soapReq := DATASET([initSrchRequest()]);
	serviceURL := gateways(Gateway.Configuration.IsNeutralRoxie(servicename))[1].URL;
	serviceName := 'doxie.HeaderSource_Service';

	soapResp := IF(serviceURL!='',SOAPCALL(soapReq,serviceURL,serviceName,
		{soapReq},DATASET(searchResult),ONFAIL(failx(LEFT)),
		PARALLEL(10),RETRY(0),TIMEOUT(20),TRIM,LOG),DATASET([],searchResult));

	RETURN PROJECT(soapResp(num_sources!=0),doxie_raw.occurrence.l_out);
END;