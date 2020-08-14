IMPORT iesp, Gateway;

EXPORT getVerificationDataFromEquifax(DATASET(iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest) input,
                                      WorkforceSolutionServices.IParam.report_params config,
                                      BOOLEAN makeGWCall,
                                      DATASET(Gateway.Layouts.Config) Gateways) := FUNCTION

  input_to_gateway := PROJECT(input,TRANSFORM(iesp.equifax_evs.t_EquifaxEvsRequest,
              
    SELF.user := LEFT.user,
    SELF.remotelocations := LEFT.remotelocations,
    SELF.servicelocations := LEFT.servicelocations,
    SELF.options.verifyemployment := ~config.IncludeIncome,
    SELF.options.verifyincome := config.IncludeIncome,
    SELF.options.IntegrationStatus := IF(LEFT.signonreq.IsLNFirstParty,'FirstParty','ThirdParty');
    SELF.options := [],
    //SignonMsgsRqV1: This section contains the information needed to complete vendor authentication
    SELF.searchby.signonmsgsrqv1.sonrq.dtclient.year := LEFT.signonreq.dateclient.year,
    SELF.searchby.signonmsgsrqv1.sonrq.dtclient.month := LEFT.signonreq.dateclient.month,
    SELF.searchby.signonmsgsrqv1.sonrq.dtclient.day := LEFT.signonreq.dateclient.day,
    SELF.searchby.signonmsgsrqv1.sonrq.dtclient.hour24 := LEFT.signonreq.dateclient.hour24,
    SELF.searchby.signonmsgsrqv1.sonrq.dtclient.minute := LEFT.signonreq.dateclient.minute,
    SELF.searchby.signonmsgsrqv1.sonrq.dtclient.second := LEFT.signonreq.dateclient.second,
    SELF.searchby.signonmsgsrqv1.sonrq.userid := [],// Gateway is going to SET them,
    SELF.searchby.signonmsgsrqv1.sonrq.userpass := [],// Gateway is going to SET them
    SELF.searchby.signonmsgsrqv1.sonrq.language := LEFT.signonreq.VendorSignOnParam.Language,
    SELF.searchby.signonmsgsrqv1.sonrq.appid := LEFT.signonreq.VendorSignOnParam.AppId,
    SELF.searchby.signonmsgsrqv1.sonrq.appver := LEFT.signonreq.VendorSignOnParam.AppVersion,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.trnuid := LEFT.TransactionReq.transactionuid,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.resellerinfo.customer := LEFT.SignonReq.VendorSignOnResellerParam.customer,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.trnpurpose.code := LEFT.TransactionReq.TransactionPurpose.code,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.trnpurpose.message := LEFT.TransactionReq.TransactionPurpose.message,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.generatepdf := LEFT.options.generatepdf,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.employername := LEFT.ReportBy.employername,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.employercode := LEFT.ReportBy.employercode,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.tsvemployeeid := LEFT.ReportBy.ssn, // Passing SSN thru tsvemployeeid
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.employeestatusfilter := LEFT.ReportBy.employeestatusfilter,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.platform := LEFT.signonreq.platform,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.intermediary := LEFT.signonreq.intermediary,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.enduser := LEFT.signonreq.enduser,
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.firstname := IF(config.IsRhodeIslandResident,LEFT.ReportBy.Name.first,''),
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.middlename := IF(config.IsRhodeIslandResident,LEFT.ReportBy.Name.middle,''),
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.lastname := IF(config.IsRhodeIslandResident,LEFT.ReportBy.Name.last,''),
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.salarykey := [],
    SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.templatename := [],

    SELF.gatewayparams := [],
    //self := [];            
  ));
 

 Gateway_eq_evs := Gateways(Gateway.Configuration.IsEquifaxEVS(servicename))[1];
 gateway_results := IF (makeGWCall, gateway.SoapCall_EquifaxEVS(input_to_gateway,Gateway_eq_evs,makeGWCall));
 //output(input_to_gateway,named('input_to_gateway'));
RETURN(gateway_results);
END;
