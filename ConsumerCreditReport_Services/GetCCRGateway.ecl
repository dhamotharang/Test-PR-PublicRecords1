IMPORT iesp, Gateway, MDR;

EXPORT GetCCRGateway (DATASET(ConsumerCreditReport_Services.Layouts.workRec) ds_work_in,
											ConsumerCreditReport_Services.IParams.Params in_mod) := FUNCTION

	iesp.conscredit_req.t_ConsumerCreditReportRequest xformRequest(ds_work_in L) := TRANSFORM
		SELF.User.ReferenceCode:=in_mod.ReferenceCode;
		SELF.User.BillingCode:=in_mod.BillingCode;
		// QueryId is assigned as acctno as the ONLY input field returned in gateway response
		SELF.User.QueryId:=(STRING)L.acctno;
		SELF.User.EndUser.CompanyName:=in_mod.EndUserCompanyName;
		SELF.Options.PermissiblePurpose:=in_mod.PermissiblePurpose; 
		SELF.SearchBy.Subject.SSN:=L.ssn;
		SELF.SearchBy.Subject.PhoneNumber:=L.phoneno;
		SELF.SearchBy.Subject.Name.First:=L.name_first;
		SELF.SearchBy.Subject.Name.Middle:=L.name_middle;
		SELF.SearchBy.Subject.Name.Last:=L.name_last;
		SELF.SearchBy.Subject.Name.Suffix:=L.name_suffix;
		SELF.SearchBy.Subject.Address.StreetNumber:=L.prim_range;
		SELF.SearchBy.Subject.Address.StreetPreDirection:=L.predir;
		SELF.SearchBy.Subject.Address.StreetName:=L.prim_name;
		SELF.SearchBy.Subject.Address.StreetSuffix:=L.addr_suffix;
		SELF.SearchBy.Subject.Address.StreetPostDirection:=L.postdir;
		SELF.SearchBy.Subject.Address.UnitDesignation:=L.unit_desig;
		SELF.SearchBy.Subject.Address.UnitNumber:=L.sec_range;
		SELF.SearchBy.Subject.Address.StreetAddress1:=L.addr;
		SELF.SearchBy.Subject.Address.City:=L.p_city_name;
		SELF.SearchBy.Subject.Address.State:=L.st;
		SELF.SearchBy.Subject.Address.Zip5:=L.z5;
		SELF.SearchBy.Subject.Address.Zip4:=L.zip4;
		SELF.SearchBy.Subject.Address.County:=L.county_name;
		SELF.SearchBy.Subject.DOB:=iesp.ECL2ESP.toDatestring8(L.dob);
		SELF:=[];
	END;

	ccrRequest := PROJECT(ds_work_in,xformRequest(LEFT));
	ccrGateway := in_mod.gateways(Gateway.Configuration.IsConsumerCreditReport(servicename));
	makeGWCall := EXISTS(ccrRequest) AND EXISTS(ccrGateway);
	responseEx := Gateway.SoapCall_CCR(ccrRequest,ccrGateway[1],makeGWCall);

	ConsumerCreditReport_Services.Layouts.ccrResp xformResponse(responseEx L) := TRANSFORM
		R:=ROW(L.response,TRANSFORM(iesp.conscredit_resp.t_ConsumerCreditReportResponse,SELF:=LEFT));
		// QueryId is assigned as acctno as the ONLY input field returned in gateway response
		SELF.AccountNumber:=R._header.QueryId;
		SELF.Source:=MDR.sourceTools.src_Equifax;
		SELF._Header:=R._Header;
		SELF.ConsumerCreditReports:=PROJECT(R.ConsumerCreditReports,TRANSFORM(iesp.consumercreditreport_fcra.t_FcraCCReport,
			SELF.Source:=MDR.sourceTools.src_Equifax,
			SELF:=LEFT));
		SELF:=[];
	END;

	ccrResponse:=PROJECT(responseEx,xformResponse(LEFT));

	ConsumerCreditReport_Services.Layouts.ccrResp joinResponse(ds_work_in L, ccrResponse R) := TRANSFORM
		SELF.AccountNumber:=L.acctno;
		SELF.UniqueId1:=(STRING)L.did;
		SELF._Header.QueryId:=L.acctno;
		SELF._Header.Exceptions:=MAP(
			R.AccountNumber='' => ConsumerCreditReport_Services.Constants.SOAP_ERROR_CCR,
			R._Header.Exceptions);
		SELF.ConsumerStatements:=L.ConsumerStatements;
		SELF:=R;
	END;

	RETURN JOIN(ds_work_in,ccrResponse,
		LEFT.acctno=RIGHT.AccountNumber,
		joinResponse(LEFT,RIGHT),
		LEFT OUTER,KEEP(1),LIMIT(0));
END;