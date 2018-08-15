import iesp, Gateway;

EXPORT getVerificationDataFromEquifax(dataset(iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest) input, 
																			WorkforceSolutionServices.IParam.report_params config,
																			boolean makeGWCall,
																			dataset(Gateway.Layouts.Config) Gateways) := function

  input_to_gateway := project(input,transform(iesp.equifax_evs.t_EquifaxEvsRequest,
							
							self.user := left.user,
							self.remotelocations := left.remotelocations,
							self.servicelocations := left.servicelocations,
							self.options.verifyemployment := ~config.IncludeIncome, 
							self.options.verifyincome := config.IncludeIncome,
							self.options.IntegrationStatus := if(left.signonreq.IsLNFirstParty,'FirstParty','ThirdParty');
							self.options := [],
							//SignonMsgsRqV1:  This section contains the information needed to complete vendor authentication
							self.searchby.signonmsgsrqv1.sonrq.dtclient.year := left.signonreq.dateclient.year, 
							self.searchby.signonmsgsrqv1.sonrq.dtclient.month := left.signonreq.dateclient.month, 
							self.searchby.signonmsgsrqv1.sonrq.dtclient.day := left.signonreq.dateclient.day, 
							self.searchby.signonmsgsrqv1.sonrq.dtclient.hour24 := left.signonreq.dateclient.hour24, 
							self.searchby.signonmsgsrqv1.sonrq.dtclient.minute := left.signonreq.dateclient.minute, 
							self.searchby.signonmsgsrqv1.sonrq.dtclient.second := left.signonreq.dateclient.second, 
							self.searchby.signonmsgsrqv1.sonrq.userid := [],// Gateway is going to set them, 
							self.searchby.signonmsgsrqv1.sonrq.userpass := [],// Gateway is going to set them																	
							self.searchby.signonmsgsrqv1.sonrq.language := left.signonreq.VendorSignOnParam.Language,
							self.searchby.signonmsgsrqv1.sonrq.appid := left.signonreq.VendorSignOnParam.AppId,
							self.searchby.signonmsgsrqv1.sonrq.appver := left.signonreq.VendorSignOnParam.AppVersion,
							self.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.trnuid := left.TransactionReq.transactionuid,
							self.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.resellerinfo.customer := left.SignonReq.VendorSignOnResellerParam.customer,
							self.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.trnpurpose.code := left.TransactionReq.TransactionPurpose.code,
							self.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.trnpurpose.message := left.TransactionReq.TransactionPurpose.message,
							self.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.generatepdf := left.options.generatepdf,
							self.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.employername := left.ReportBy.employername, 
							self.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.employercode := left.ReportBy.employercode, 
							self.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.tsvemployeeid := left.ReportBy.ssn, // Passing SSN thru tsvemployeeid
							self.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.employeestatusfilter := left.ReportBy.employeestatusfilter,
							SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.platform := left.signonreq.platform,
							SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.intermediary := left.signonreq.intermediary,
							SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.enduser := left.signonreq.enduser,
							SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.firstname := if(config.IsRhodeIslandResident,left.ReportBy.Name.first,''),
							SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.middlename := if(config.IsRhodeIslandResident,left.ReportBy.Name.middle,''),
							SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.lastname :=  if(config.IsRhodeIslandResident,left.ReportBy.Name.last,''),
							SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.salarykey := [],
							SELF.searchby.tsvermsgsrqv1.tsvtwnselecttrnrq.tsvtwnselectsmrq.templatename := [],

							self.gatewayparams := [],
							//self := [];
							
	)); 
 

 Gateway_eq_evs := Gateways(Gateway.Configuration.IsEquifaxEVS(servicename))[1];
 gateway_results := if (makeGWCall, gateway.SoapCall_EquifaxEVS(input_to_gateway,Gateway_eq_evs,makeGWCall));
 //output(input_to_gateway,named('input_to_gateway'));
return(gateway_results);
end;