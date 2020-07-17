IMPORT Address, WorkforceSolutionServices, iesp, Suppress;

//iesp.emplincverificationreport_fcra

//(WorkforceSolutionServices.IParam.report_params in_params)
EXPORT Transforms := MODULE

  SHARED iesp.share.t_User SetUser (WorkforceSolutionServices.IParam.report_params in_params) := TRANSFORM
    SELF.GLBPurpose := (STRING) in_params.GLBPurpose;
    SELF.DLPurpose := (STRING) in_params.DPPAPurpose;
    SELF := [];
  END;


  EXPORT iesp.person_picklist.t_PersonPickListRequest InRequest_to_lexID_Resolution
  (iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest L,
   WorkforceSolutionServices.IParam.report_params in_params) := TRANSFORM
    SELF.user := ROW (SetUser(in_params));
    SELF.remotelocations:= l.remotelocations;
    SELF.servicelocations := l.servicelocations;
    SELF.options.ReturnUniqueIdsOnly := TRUE;
    SELF.searchby.ssn := l.ReportBy.ssn;
    SELF.searchby.name := l.ReportBy.name;
    SELF.searchby.address := l.ReportBy.address;
    SELF.searchby.dob := l.ReportBy.dob;
    SELF := [];
  END;

  EXPORT iesp.person_picklist.t_PersonPickListRequest GwEmployee_to_lexID_Resolution
  (WorkforceSolutionServices.Layouts.gateway_employee L,
   WorkforceSolutionServices.IParam.report_params in_params) := TRANSFORM
    SELF.user := ROW (SetUser(in_params));
    SELF.remotelocations:= [];
    SELF.servicelocations := [];
    SELF.options.ReturnUniqueIdsOnly := TRUE;
    SELF.options := [];
    SELF.searchby.ssn := l.ssn;
    SELF.searchby.name.first := l.FirstName;
    SELF.searchby.name.middle := [];
    SELF.searchby.name.last := l.LastName;
    SELF.searchby.dob := l.DtBirth;
    SELF := [];
  END;


SHARED iesp.employment_verification.t_FcraInfoDetail toFcraInfoDetail(iesp.equifax_evs.t_FcraInfoDetail l ) := TRANSFORM
  SELF.fcraactiondetail.fcrainfoid := l.fcraactiondetail.fcrainfoid ;
  SELF.fcraactiondetail.fcraactiontypecode := l.fcraactiondetail.fcraactiontypecode ;
  SELF.fcraactiondetail.message := l.fcraactiondetail.message ;
  SELF.fcraactiondetail.servicemessage := l.fcraactiondetail.twnmessage ;
  SELF.fcraactiondetail.reportingemployercode := l.fcraactiondetail.reportingemployercode ;
  SELF.fcraactiondetail.targetemployercode := l.fcraactiondetail.targetemployercode ;
  SELF.fcraactiondetail.incidentnumber := l.fcraactiondetail.incidentnumber ;
  SELF.fcraactiondetail.fcramoreinformation.url := l.fcraactiondetail.fcramoreinformation.url ;
  SELF.fcraactiondetail.fcramoreinformation.phonenumber := l.fcraactiondetail.fcramoreinformation.phonenumber ;
  SELF.fcraactiondetail.fcrainfodataitems := l.fcraactiondetail.fcrainfodataitems;
  SELF.fcraactioncreated.userid := l.fcraactioncreated.userid ;
  SELF.fcraactioncreated.username.full := [];
  SELF.fcraactioncreated.username.first := l.fcraactioncreated.firstname ;
  SELF.fcraactioncreated.username.middle := l.fcraactioncreated.middlename ;
  SELF.fcraactioncreated.username.last := l.fcraactioncreated.lastname ;
  SELF.fcraactioncreated.username.suffix := [];
  SELF.fcraactioncreated.username.prefix := [];
  SELF.fcraactioncreated.email := l.fcraactioncreated.email ;
  SELF.fcraactioncreated.daytimephone := l.fcraactioncreated.daytimephone ;
  SELF.fcraactioncreated.eveningphone := l.fcraactioncreated.eveningphone ;
  SELF.fcraactioncreated.useraddress.streetnumber := [];
  SELF.fcraactioncreated.useraddress.streetpredirection := [];
  SELF.fcraactioncreated.useraddress.streetname := [];
  SELF.fcraactioncreated.useraddress.streetsuffix := [];
  SELF.fcraactioncreated.useraddress.streetpostdirection := [];
  SELF.fcraactioncreated.useraddress.unitdesignation := [];
  SELF.fcraactioncreated.useraddress.unitnumber := [];
  SELF.fcraactioncreated.useraddress.streetaddress1 := l.fcraactioncreated.addr1 ;
  SELF.fcraactioncreated.useraddress.streetaddress2 := l.fcraactioncreated.addr2 ;
  SELF.fcraactioncreated.useraddress.city := l.fcraactioncreated.city ;
  SELF.fcraactioncreated.useraddress.state := l.fcraactioncreated.state ;
  SELF.fcraactioncreated.useraddress.zip5 := [];
  SELF.fcraactioncreated.useraddress.zip4 := [];
  SELF.fcraactioncreated.useraddress.county := [];
  SELF.fcraactioncreated.useraddress.postalcode := l.fcraactioncreated.postalcode ;
  SELF.fcraactioncreated.useraddress.statecityzip := [];
  SELF.fcraactioncreated.isocountrycode := l.fcraactioncreated.isocountrycode ;
  SELF.fcraactioncreated.datetimestamp.year := l.fcraactioncreated.datetimestamp.year ;
  SELF.fcraactioncreated.datetimestamp.month := l.fcraactioncreated.datetimestamp.month ;
  SELF.fcraactioncreated.datetimestamp.day := l.fcraactioncreated.datetimestamp.day ;
  SELF.fcraactioncreated.datetimestamp.hour24 := l.fcraactioncreated.datetimestamp.hour24 ;
  SELF.fcraactioncreated.datetimestamp.minute := l.fcraactioncreated.datetimestamp.minute ;
  SELF.fcraactioncreated.datetimestamp.second := l.fcraactioncreated.datetimestamp.second ;
  SELF.fcraactioncreated.comments := l.fcraactioncreated.comments ;
  SELF.fcraactionclosed.userid := l.fcraactionclosed.userid;
  SELF.fcraactionclosed.username.full := [];
  SELF.fcraactionclosed.username.first := l.fcraactionclosed.firstname;
  SELF.fcraactionclosed.username.middle := l.fcraactionclosed.middlename;
  SELF.fcraactionclosed.username.last := l.fcraactionclosed.lastname;
  SELF.fcraactionclosed.username.suffix := [];
  SELF.fcraactionclosed.username.prefix := [];
  SELF.fcraactionclosed.email := l.fcraactionclosed.email ;
  SELF.fcraactionclosed.daytimephone := l.fcraactionclosed.daytimephone ;
  SELF.fcraactionclosed.eveningphone := l.fcraactionclosed.eveningphone ;
  SELF.fcraactionclosed.useraddress.streetnumber := [];
  SELF.fcraactionclosed.useraddress.streetpredirection := [];
  SELF.fcraactionclosed.useraddress.streetname := [];
  SELF.fcraactionclosed.useraddress.streetsuffix := [];
  SELF.fcraactionclosed.useraddress.streetpostdirection := [];
  SELF.fcraactionclosed.useraddress.unitdesignation := [];
  SELF.fcraactionclosed.useraddress.unitnumber := [];
  SELF.fcraactionclosed.useraddress.streetaddress1 := l.fcraactionclosed.addr1;
  SELF.fcraactionclosed.useraddress.streetaddress2 := l.fcraactionclosed.addr2;
  SELF.fcraactionclosed.useraddress.city := l.fcraactionclosed.city;
  SELF.fcraactionclosed.useraddress.state := l.fcraactionclosed.state;
  SELF.fcraactionclosed.useraddress.zip5 := [];
  SELF.fcraactionclosed.useraddress.zip4 := [];
  SELF.fcraactionclosed.useraddress.county := [];
  SELF.fcraactionclosed.useraddress.postalcode := l.fcraactionclosed.postalcode;
  SELF.fcraactionclosed.useraddress.statecityzip := [];
  SELF.fcraactionclosed.isocountrycode := l.fcraactionclosed.isocountrycode;
  SELF.fcraactionclosed.datetimestamp.year := l.fcraactionclosed.datetimestamp.year;
  SELF.fcraactionclosed.datetimestamp.month := l.fcraactionclosed.datetimestamp.month;
  SELF.fcraactionclosed.datetimestamp.day := l.fcraactionclosed.datetimestamp.day;
  SELF.fcraactionclosed.datetimestamp.hour24 := l.fcraactionclosed.datetimestamp.hour24;
  SELF.fcraactionclosed.datetimestamp.minute := l.fcraactionclosed.datetimestamp.minute;
  SELF.fcraactionclosed.datetimestamp.second := l.fcraactionclosed.datetimestamp.second;
  SELF.fcraactionclosed.comments := l.fcraactionclosed.comments;
END;

SHARED iesp.employment_verification.t_VerificationOfEmploymentAnnualComp
  toAnnualComp(iesp.equifax_evs.t_TsVAnnualComp l) := TRANSFORM
    SELF.employmentyear := l.tsvyear;
    SELF.basesalary := l.tsvbase;
    SELF.overtime := l.tsvovertime;
    SELF.commission := l.tsvcommission;
    SELF.bonus := l.tsvbonus;
    SELF.otherpayment := l.tsvother;
    SELF.totalsalary := l.tsvtotal;
    SELF.rateofpay := l.tsvrateofpay;
    SELF.dateinfoprovided.year := l.tsvdtinfo.year;
    SELF.dateinfoprovided.month := l.tsvdtinfo.month;
    SELF.dateinfoprovided.day := l.tsvdtinfo.day;
    SELF.payfrequency.code := l.tsvpayfrequency.code;
    SELF.payfrequency.message := l.tsvpayfrequency.message;
    SELF.payperiodfrequency.code := l.tsvpayperiodfrequency.code;
    SELF.payperiodfrequency.message := l.tsvpayperiodfrequency.message;
END;


SHARED iesp.employment_verification.t_VerificationOfEmploymentRecord
  GwRecord_to_Record(iesp.equifax_evs.t_TsVResponse_V100 L , UNSIGNED DID , STRING input_ssn_mask_value, STRING input_dob_mask_value) := TRANSFORM
    SELF.TransactionDate := l.DtTransaction;
    SELF.employer.employeraddress.streetnumber := [];
    SELF.employer.employeraddress.streetpredirection := [];
    SELF.employer.employeraddress.streetname := [];
    SELF.employer.employeraddress.streetsuffix := [];
    SELF.employer.employeraddress.streetpostdirection := [];
    SELF.employer.employeraddress.unitdesignation := [];
    SELF.employer.employeraddress.unitnumber := [];
    SELF.employer.employeraddress.streetaddress1 := l.tsvemployer_v100.addr1;
    SELF.employer.employeraddress.streetaddress2 := l.tsvemployer_v100.addr2;
    SELF.employer.employeraddress.city := l.tsvemployer_v100.city;
    SELF.employer.employeraddress.state := l.tsvemployer_v100.state;
    SELF.employer.employeraddress.zip5 := [];
    SELF.employer.employeraddress.zip4 := [];
    SELF.employer.employeraddress.county := [];
    SELF.employer.employeraddress.postalcode := l.tsvemployer_v100.postalcode;
    SELF.employer.employeraddress.statecityzip := [];
    SELF.Employer := l.TsVEmployer_V100;
    //Self.Employee.UniqueId := (string)DID;
    SELF.employee.employeename.full := '';
    SELF.employee.employeename.first := l.tsvemployee_v100.firstname;
    SELF.employee.employeename.middle := l.tsvemployee_v100.middlename;
    SELF.employee.employeename.last := l.tsvemployee_v100.lastname;
    SELF.employee.employeename.suffix := [];
    SELF.employee.employeename.prefix := [];
    SELF.employee.DateInfoProvided := l.tsvemployee_v100.DtInfo;
    SELF.employee.DateMostRecentHire := l.tsvemployee_v100.DtMostRecentHire;
    SELF.employee.DateOriginalHire := l.tsvemployee_v100.DtOriginalHire;
    SELF.employee.DateEndEmployment := l.tsvemployee_v100.DtEndEmployment;
    SELF.employee.DateMostRecentPay := l.tsvemployee_v100.DtMostRecentPay;
    SELF.employee.ssn := Suppress.ssn_mask(l.tsvemployee_v100.ssn,input_ssn_mask_value);
    SELF.employee.employeeaddress.streetnumber := [];
    SELF.employee.employeeaddress.streetpredirection := [];
    SELF.employee.employeeaddress.streetname := [];
    SELF.employee.employeeaddress.streetsuffix := [];
    SELF.employee.employeeaddress.streetpostdirection := [];
    SELF.employee.employeeaddress.unitdesignation := [];
    SELF.employee.employeeaddress.unitnumber := [];
    SELF.employee.employeeaddress.streetaddress1 := l.tsvemployee_v100.address1;
    SELF.employee.employeeaddress.streetaddress2 := l.tsvemployee_v100.address2;
    SELF.employee.employeeaddress.city := l.tsvemployee_v100.city;
    SELF.employee.employeeaddress.state := l.tsvemployee_v100.state;
    SELF.employee.employeeaddress.zip5 := [];
    SELF.employee.employeeaddress.zip4 := [];
    SELF.employee.employeeaddress.county := [];
    SELF.employee.employeeaddress.postalcode := l.tsvemployee_v100.postalcode;
    SELF.employee.employeeaddress.statecityzip := [];
    DOB := iesp.ECL2ESP.DateToInteger(l.tsvemployee_v100.dtbirth);
    dobMasked := Suppress.date_mask(DOB,Suppress.date_mask_math.MaskIndicator(input_dob_mask_value));
    SELF.employee.DOB := iesp.ECL2ESP.toDatestring8(dobMasked.Year+dobMasked.Month+dobMasked.day);
    SELF.employee.employeephone := l.tsvemployee_v100.phonenumber;
    SELF.employee.worklocation.fedidnumber := l.tsvemployee_v100.worklocation.fedidnumber;
    SELF.employee.worklocation.workaddress.streetnumber := [];
    SELF.employee.worklocation.workaddress.streetpredirection := [];
    SELF.employee.worklocation.workaddress.streetname := [];
    SELF.employee.worklocation.workaddress.streetsuffix := [];
    SELF.employee.worklocation.workaddress.streetpostdirection := [];
    SELF.employee.worklocation.workaddress.unitdesignation := [];
    SELF.employee.worklocation.workaddress.unitnumber := [];
    SELF.employee.worklocation.workaddress.streetaddress1 := l.tsvemployee_v100.worklocation.address1;
    SELF.employee.worklocation.workaddress.streetaddress2 := l.tsvemployee_v100.worklocation.address2;
    SELF.employee.worklocation.workaddress.city := l.tsvemployee_v100.worklocation.city;
    SELF.employee.worklocation.workaddress.state := l.tsvemployee_v100.worklocation.state;
    SELF.employee.worklocation.workaddress.zip5 := [];
    SELF.employee.worklocation.workaddress.zip4 := [];
    SELF.employee.worklocation.workaddress.county := [];
    SELF.employee.worklocation.workaddress.postalcode := l.tsvemployee_v100.worklocation.postalcode;
    SELF.employee.worklocation.workaddress.statecityzip := [];
    SELF.employee.worklocation.stateid := l.tsvemployee_v100.worklocation.stateid;
    SELF.employee.worklocation.region := l.tsvemployee_v100.worklocation.region;
    SELF.employee.worklocation.isocountrycode := l.tsvemployee_v100.worklocation.isocountrycode;
    SELF.employee := l.tsvemployee_v100;
    SELF.BaseCompensation.PayFrequency := l.TsVBaseComp.TsVPayFrequency;
    SELF.BaseCompensation.RateOfPay := l.TsVBaseComp.TsVRateOfPay;
    SELF.BaseCompensation.AvgHrsWorked := l.TsVBaseComp.TsVAvgHrsWorked;
    SELF.BaseCompensation.PayPeriodFrequency := l.TsVBaseComp.TsVPayPeriodFrequency;
    SELF.AnnualCompData := PROJECT(l.TsVAnnualCompData,toAnnualComp(LEFT));
    SELF.CompensationAdj.LastDate := l.TsVCompAdj.LastDt;
    SELF.CompensationAdj.LastAmount := l.TsVCompAdj.LastAmt;
    SELF.CompensationAdj.NextDate := l.TsVCompAdj.NextDt;
    SELF.CompensationAdj.NextAmount := l.TsVCompAdj.NextAmt;
    SELF.OffWorkPeriod.StartDate := l.TsVOffWork.StartDt;
    SELF.OffWorkPeriod.EndDate := l.TsVOffWork.EndDt;
    SELF.Completeness := l.Completeness;
    SELF.ServerRespId := l.SrvrtId;
    SELF.DemoTransaction := l.DemoTrn;
    SELF.FcraInfo.FcraInfoDetails := PROJECT(l.FcraInfo.FcraInfoDetails,toFcraInfoDetail(LEFT));
  END;


  EXPORT iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRecord
    toRecords(iesp.equifax_evs.t_EvsResponse l , UNSIGNED DID , STRING input_ssn_mask_value, STRING input_dob_mask_value) := TRANSFORM
      SELF.signonresp.status.code := l.SignonMsgsRsV1.SonRs.Status.code;
      SELF.signonresp.status.message := l.SignonMsgsRsV1.SonRs.Status.message;
      SELF.signonresp.status.severity := l.SignonMsgsRsV1.SonRs.Status.severity;
      SELF.signonresp.datetimeserver := l.SignonMsgsRsV1.SonRs.DtServer;
      SELF.signonresp.language := l.SignonMsgsRsV1.SonRs.Language;
      _trnRs := l.TsVerMsgsRsV1.TsVTwnSelectTrnRs;
      SELF.verificationofemploymentresp.transactionuid := _trnRs.TrnUID;
      SELF.verificationofemploymentresp.status.code := _trnRs.status.code ;
      SELF.verificationofemploymentresp.status.message := _trnRs.status.message;
      SELF.verificationofemploymentresp.status.severity := _trnRs.status.severity;
      SELF.verificationofemploymentresp.masterserverid := _trnRs.MasterSrvRtId;
      SELF.verificationofemploymentresp.TransactionPurpose.code := _trnRs.TrnPurpose.Code ;
      SELF.verificationofemploymentresp.TransactionPurpose.message := _trnRs.TrnPurpose.Message;
      SELF.verificationofemploymentresp.specialhandling.demohandling := _trnRs.specialhandling.DemoHandling;
      SELF.verificationofemploymentresp.specialhandling.complimentary := _trnRs.specialhandling.complimentary; ;
      SELF.verificationofemploymentresp.verificationofemploymentselectrecord.verificationofemploymentrecorddata :=
      PROJECT(_trnRs.TsVTwnSelectRs.tsvresponsedata,GwRecord_to_Record(LEFT , DID , input_ssn_mask_value , input_dob_mask_value));
      SELF.Pdf := l.TsVerPDF;
      SELF.UniqueID := (STRING) DID;
  END;


END;
