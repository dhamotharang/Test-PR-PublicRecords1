import iesp,ecrash_services;

EXPORT SoapCall_eCrash_HPD(ecrash_services.IParam.searchrecords HPDmod,
                           INTEGER retries=eCrash_Services.Constants.GW_RETRIES,
                           INTEGER timeout=eCrash_Services.Constants.GW_TIMEOUT) := FUNCTION

        iesp.hpdreportsearch.t_HPDReportSearchRequest xform_request() := transform	 		 
            self.Searchby.BlockNumber := HPDmod.BlockNumber;
            incident_date := map(HPDmod.DateOfLoss <> '' =>   HPDmod.DateOfLoss,
                                 HPDmod.DolStartdate <> '' => HPDmod.DolStartdate,
                                  '');
            self.Searchby.DateOfCrash.Year  := (integer2)incident_date[1..4];	
            self.Searchby.DateOfCrash.Month := (integer2)incident_date[5..6];	
            self.Searchby.DateOfCrash.Day   := (integer2)incident_date[7..8];
            self.Searchby.CustomerType := HPDmod.CustomerType;
            self.Searchby.DLNumber := HPDmod.driversLicenseNumber;
            self.Searchby.firstname := HPDmod.firstname;
            self.Searchby.lastName := HPDmod.lastname;
            self.Searchby.DOB := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',(STRING)HPDmod.DateofBirth,'')[1..8]);	
            self.Searchby.IncidentNumber := HPDmod.ReportNumber;
            self.Searchby.StreetName := HPDmod.AccidentLocationStreet;
            self:= [];
        end;

        ds_interim := DATASET([xform_request()]);

        iesp.hpdreportsearch.t_HPDReportSearchResponseEx FailJoin(iesp.hpdreportsearch.t_HPDReportSearchRequest ds) := TRANSFORM
               ASSERT(1=0, eCrash_Services.Constants.ERROR_STRING_SOAP_HPD + (string)FAILCODE + ':' + FAILMESSAGE + ':' + FAILMESSAGE('soapresponse'));
               self.response._header.message := eCrash_Services.Constants.ERROR_STRING_SOAP_HPD + (string) FAILCODE + ':' + FAILMESSAGE + ':' + FAILMESSAGE('soapresponse');
              self := ds;
              self := [];
        end;


        outResponse:=SOAPCALL(ds_interim , HPDmod.GatewayEspURL,
                              HPDmod.HPD_SearchEspNAME,
                              {ds_interim}, // <--- Note non-standard "{...}" format
                              dataset(iesp.hpdreportsearch.t_HPDReportSearchResponseEx),
                              xpath('HPDReportSearchResponseEx'),
                              onfail(FailJoin(left)),
                              PARALLEL(1),
                              RETRY(retries), TIMEOUT(timeout), TRIM, LOG);

        // output(ds_interim,named('ds_interim'));
        // output(outResponse,named('outResponse'));

        return  outResponse;

END;

