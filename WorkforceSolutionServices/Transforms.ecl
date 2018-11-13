import Address, WorkforceSolutionServices, iesp, Suppress;

//iesp.emplincverificationreport_fcra

//(WorkforceSolutionServices.IParam.report_params in_params)
EXPORT Transforms := module

	shared	iesp.share.t_User SetUser (WorkforceSolutionServices.IParam.report_params in_params) := transform
		Self.GLBPurpose := (string) in_params.GLBPurpose;
		Self.DLPurpose := (string) in_params.DPPAPurpose;
		Self := [];
	end;


	export iesp.person_picklist.t_PersonPickListRequest InRequest_to_lexID_Resolution
	(iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest L,
	 WorkforceSolutionServices.IParam.report_params in_params) := transform
		self.user := row (SetUser(in_params));
		self.remotelocations:= l.remotelocations;
		self.servicelocations := l.servicelocations;
		self.options.ReturnUniqueIdsOnly := true;
		self.searchby.ssn := l.ReportBy.ssn;
		self.searchby.name := l.ReportBy.name;
		self.searchby.address := l.ReportBy.address;
		self.searchby.dob := l.ReportBy.dob;
		self := [];
	end;

	export iesp.person_picklist.t_PersonPickListRequest GwEmployee_to_lexID_Resolution
	(WorkforceSolutionServices.Layouts.gateway_employee L,
	 WorkforceSolutionServices.IParam.report_params in_params) := transform
		self.user := row (SetUser(in_params));
		self.remotelocations:= [];
		self.servicelocations := [];
		self.options.ReturnUniqueIdsOnly := true;
		self.options := [];
		self.searchby.ssn := l.ssn;
		self.searchby.name.first := l.FirstName;
		self.searchby.name.middle := [];
		self.searchby.name.last := l.LastName;
		self.searchby.dob := l.DtBirth;
		self := [];
	end;


shared iesp.employment_verification.t_FcraInfoDetail toFcraInfoDetail(iesp.equifax_evs.t_FcraInfoDetail l ) := TRANSFORM
		self.fcraactiondetail.fcrainfoid 	:=	l.fcraactiondetail.fcrainfoid ;
		self.fcraactiondetail.fcraactiontypecode 	:=	l.fcraactiondetail.fcraactiontypecode ;
		self.fcraactiondetail.message            	:=	l.fcraactiondetail.message            ;
		self.fcraactiondetail.servicemessage     	:=	l.fcraactiondetail.twnmessage         ;
		self.fcraactiondetail.reportingemployercode 	:=	l.fcraactiondetail.reportingemployercode ;
		self.fcraactiondetail.targetemployercode    	:=	l.fcraactiondetail.targetemployercode    ;
		self.fcraactiondetail.incidentnumber        	:=	l.fcraactiondetail.incidentnumber        ;
		self.fcraactiondetail.fcramoreinformation.url 	:=	l.fcraactiondetail.fcramoreinformation.url ;
		self.fcraactiondetail.fcramoreinformation.phonenumber 	:=	l.fcraactiondetail.fcramoreinformation.phonenumber ;
		self.fcraactiondetail.fcrainfodataitems	:=	l.fcraactiondetail.fcrainfodataitems;
		self.fcraactioncreated.userid 	:=	l.fcraactioncreated.userid ;
		self.fcraactioncreated.username.full	:=	[];
		self.fcraactioncreated.username.first 	:=	l.fcraactioncreated.firstname ;
		self.fcraactioncreated.username.middle	:=	l.fcraactioncreated.middlename ;
		self.fcraactioncreated.username.last  	:=	l.fcraactioncreated.lastname   ;
		self.fcraactioncreated.username.suffix 	:=	[];
		self.fcraactioncreated.username.prefix 	:=	[];
		self.fcraactioncreated.email 	:=	l.fcraactioncreated.email      ;
		self.fcraactioncreated.daytimephone 	:=	l.fcraactioncreated.daytimephone ;
		self.fcraactioncreated.eveningphone 	:=	l.fcraactioncreated.eveningphone ;
		self.fcraactioncreated.useraddress.streetnumber 	:=	[];
		self.fcraactioncreated.useraddress.streetpredirection 	:=	[];
		self.fcraactioncreated.useraddress.streetname        	:=	[];
		self.fcraactioncreated.useraddress.streetsuffix      	:=	[];
		self.fcraactioncreated.useraddress.streetpostdirection 	:=	[];
		self.fcraactioncreated.useraddress.unitdesignation     	:=	[];
		self.fcraactioncreated.useraddress.unitnumber         	:=	[];
		self.fcraactioncreated.useraddress.streetaddress1     	:=	l.fcraactioncreated.addr1 ;
		self.fcraactioncreated.useraddress.streetaddress2     	:=	l.fcraactioncreated.addr2 ;
		self.fcraactioncreated.useraddress.city               	:=	l.fcraactioncreated.city ;
		self.fcraactioncreated.useraddress.state              	:=	l.fcraactioncreated.state ;
		self.fcraactioncreated.useraddress.zip5               	:=	[];
		self.fcraactioncreated.useraddress.zip4               	:=	[];
		self.fcraactioncreated.useraddress.county              	:=	[];
		self.fcraactioncreated.useraddress.postalcode         	:=	l.fcraactioncreated.postalcode ;
		self.fcraactioncreated.useraddress.statecityzip       	:=	[];
		self.fcraactioncreated.isocountrycode 	:=	l.fcraactioncreated.isocountrycode ;
		self.fcraactioncreated.datetimestamp.year 	:=	l.fcraactioncreated.datetimestamp.year  ;
		self.fcraactioncreated.datetimestamp.month 	:=	l.fcraactioncreated.datetimestamp.month  ;
		self.fcraactioncreated.datetimestamp.day   	:=	l.fcraactioncreated.datetimestamp.day ;
		self.fcraactioncreated.datetimestamp.hour24 	:=	l.fcraactioncreated.datetimestamp.hour24  ;
		self.fcraactioncreated.datetimestamp.minute 	:=	l.fcraactioncreated.datetimestamp.minute  ;
		self.fcraactioncreated.datetimestamp.second 	:=	l.fcraactioncreated.datetimestamp.second  ;
		self.fcraactioncreated.comments 	:=	l.fcraactioncreated.comments ;
		self.fcraactionclosed.userid 	:=	l.fcraactionclosed.userid;
		self.fcraactionclosed.username.full 	:=	[];
		self.fcraactionclosed.username.first 	:=	l.fcraactionclosed.firstname;
		self.fcraactionclosed.username.middle 	:=	l.fcraactionclosed.middlename;
		self.fcraactionclosed.username.last   	:=	l.fcraactionclosed.lastname;
		self.fcraactionclosed.username.suffix 	:=	[];
		self.fcraactionclosed.username.prefix 	:=	[];
		self.fcraactionclosed.email 	:=	l.fcraactionclosed.email      ;
		self.fcraactionclosed.daytimephone 	:=	l.fcraactionclosed.daytimephone ;
		self.fcraactionclosed.eveningphone 	:=	l.fcraactionclosed.eveningphone ;
		self.fcraactionclosed.useraddress.streetnumber 	:=	[];
		self.fcraactionclosed.useraddress.streetpredirection 	:=	[];
		self.fcraactionclosed.useraddress.streetname         	:=	[];
		self.fcraactionclosed.useraddress.streetsuffix       	:=	[];
		self.fcraactionclosed.useraddress.streetpostdirection :=	[];
		self.fcraactionclosed.useraddress.unitdesignation     :=	[];
		self.fcraactionclosed.useraddress.unitnumber          :=	[];
		self.fcraactionclosed.useraddress.streetaddress1      :=	l.fcraactionclosed.addr1;
		self.fcraactionclosed.useraddress.streetaddress2      :=	l.fcraactionclosed.addr2;
		self.fcraactionclosed.useraddress.city                :=	l.fcraactionclosed.city;
		self.fcraactionclosed.useraddress.state               :=	l.fcraactionclosed.state;
		self.fcraactionclosed.useraddress.zip5                :=	[];
		self.fcraactionclosed.useraddress.zip4                :=	[];
		self.fcraactionclosed.useraddress.county              :=	[];
		self.fcraactionclosed.useraddress.postalcode          :=	l.fcraactionclosed.postalcode;
		self.fcraactionclosed.useraddress.statecityzip        :=	[];
		self.fcraactionclosed.isocountrycode 				:=	l.fcraactionclosed.isocountrycode;
		self.fcraactionclosed.datetimestamp.year 		:=	l.fcraactionclosed.datetimestamp.year;
		self.fcraactionclosed.datetimestamp.month 	:=		l.fcraactionclosed.datetimestamp.month;
		self.fcraactionclosed.datetimestamp.day   	:=		l.fcraactionclosed.datetimestamp.day;
		self.fcraactionclosed.datetimestamp.hour24 	:=		l.fcraactionclosed.datetimestamp.hour24;
		self.fcraactionclosed.datetimestamp.minute 	:=		l.fcraactionclosed.datetimestamp.minute;
		self.fcraactionclosed.datetimestamp.second 	:=	l.fcraactionclosed.datetimestamp.second;
		self.fcraactionclosed.comments 	:=	l.fcraactionclosed.comments;
end;

shared iesp.employment_verification.t_VerificationOfEmploymentAnnualComp
			toAnnualComp(iesp.equifax_evs.t_TsVAnnualComp l) := transform
			self.employmentyear := 	l.tsvyear;
			self.basesalary     := 	l.tsvbase;
			self.overtime       := 	l.tsvovertime;
			self.commission     := 	l.tsvcommission;
			self.bonus          := 	l.tsvbonus;
			self.otherpayment   := 	l.tsvother;
			self.totalsalary    := 	l.tsvtotal;
			self.rateofpay      := 	l.tsvrateofpay;
			self.dateinfoprovided.year 	:= 	l.tsvdtinfo.year;
			self.dateinfoprovided.month := 	l.tsvdtinfo.month;
			self.dateinfoprovided.day   := 	l.tsvdtinfo.day;
			self.payfrequency.code 			:= 	l.tsvpayfrequency.code;
			self.payfrequency.message 	:= 	l.tsvpayfrequency.message;
			self.payperiodfrequency.code 		:= 	l.tsvpayperiodfrequency.code;
			self.payperiodfrequency.message := 	l.tsvpayperiodfrequency.message;
end;


shared iesp.employment_verification.t_VerificationOfEmploymentRecord
	GwRecord_to_Record(iesp.equifax_evs.t_TsVResponse_V100 L , unsigned DID , string input_ssn_mask_value, string input_dob_mask_value) := transform
		Self.TransactionDate := l.DtTransaction;
		self.employer.employeraddress.streetnumber				:=	[];
		self.employer.employeraddress.streetpredirection	:=	[];
		self.employer.employeraddress.streetname					:=	[];
		self.employer.employeraddress.streetsuffix      	:=	[];
		self.employer.employeraddress.streetpostdirection	:=	[];
		self.employer.employeraddress.unitdesignation    	:=	[];
		self.employer.employeraddress.unitnumber         	:=	[];
		self.employer.employeraddress.streetaddress1     	:=	l.tsvemployer_v100.addr1;
		self.employer.employeraddress.streetaddress2     	:=	l.tsvemployer_v100.addr2;
		self.employer.employeraddress.city 								:=	l.tsvemployer_v100.city;
		self.employer.employeraddress.state              	:=	l.tsvemployer_v100.state;
		self.employer.employeraddress.zip5               	:=	[];
		self.employer.employeraddress.zip4               	:=	[];
		self.employer.employeraddress.county             	:=	[];
		self.employer.employeraddress.postalcode         	:=	l.tsvemployer_v100.postalcode;
		self.employer.employeraddress.statecityzip       	:=	[];
		Self.Employer := l.TsVEmployer_V100;
		//Self.Employee.UniqueId := (string)DID;
		Self.employee.employeename.full 	:= '';
		Self.employee.employeename.first 	:= l.tsvemployee_v100.firstname;
		Self.employee.employeename.middle := l.tsvemployee_v100.middlename;
		Self.employee.employeename.last   := l.tsvemployee_v100.lastname;
		Self.employee.employeename.suffix := [];
		Self.employee.employeename.prefix := [];
		Self.employee.DateInfoProvided 		:= l.tsvemployee_v100.DtInfo;
		Self.employee.DateMostRecentHire 	:= l.tsvemployee_v100.DtMostRecentHire;
		Self.employee.DateOriginalHire 		:= l.tsvemployee_v100.DtOriginalHire;
		Self.employee.DateEndEmployment 	:= l.tsvemployee_v100.DtEndEmployment;
		Self.employee.DateMostRecentPay 	:= l.tsvemployee_v100.DtMostRecentPay;
		Self.employee.ssn := Suppress.ssn_mask(l.tsvemployee_v100.ssn,input_ssn_mask_value);
		Self.employee.employeeaddress.streetnumber	:=	[];
		Self.employee.employeeaddress.streetpredirection	:=	[];
		Self.employee.employeeaddress.streetname	:=	[];
		Self.employee.employeeaddress.streetsuffix	:=	[];
		Self.employee.employeeaddress.streetpostdirection	:=	[];
		Self.employee.employeeaddress.unitdesignation	:=	[];
		Self.employee.employeeaddress.unitnumber	:=	[];
		Self.employee.employeeaddress.streetaddress1	:=	l.tsvemployee_v100.address1;
		Self.employee.employeeaddress.streetaddress2	:=	l.tsvemployee_v100.address2;
		Self.employee.employeeaddress.city	:=	l.tsvemployee_v100.city;
		Self.employee.employeeaddress.state	:=	l.tsvemployee_v100.state;
		Self.employee.employeeaddress.zip5	:=	[];
		Self.employee.employeeaddress.zip4	:=	[];
		Self.employee.employeeaddress.county	:=	[];
		Self.employee.employeeaddress.postalcode	:=	l.tsvemployee_v100.postalcode;
		Self.employee.employeeaddress.statecityzip	:=	[];
		DOB	:=	iesp.ECL2ESP.DateToInteger(l.tsvemployee_v100.dtbirth);
		dobMasked	:=	Suppress.date_mask(DOB,Suppress.date_mask_math.MaskIndicator(input_dob_mask_value));
		Self.employee.DOB := iesp.ECL2ESP.toDatestring8(dobMasked.Year+dobMasked.Month+dobMasked.day);
		Self.employee.employeephone :=  l.tsvemployee_v100.phonenumber;
		Self.employee.worklocation.fedidnumber	:=	l.tsvemployee_v100.worklocation.fedidnumber;
		Self.employee.worklocation.workaddress.streetnumber	:=	[];
		Self.employee.worklocation.workaddress.streetpredirection	:=	[];
		Self.employee.worklocation.workaddress.streetname	:=	[];
		Self.employee.worklocation.workaddress.streetsuffix	:=	[];
		Self.employee.worklocation.workaddress.streetpostdirection	:=	[];
		Self.employee.worklocation.workaddress.unitdesignation	:=	[];
		Self.employee.worklocation.workaddress.unitnumber	:=	[];
		Self.employee.worklocation.workaddress.streetaddress1	:=	l.tsvemployee_v100.worklocation.address1;
		Self.employee.worklocation.workaddress.streetaddress2	:=	l.tsvemployee_v100.worklocation.address2;
		Self.employee.worklocation.workaddress.city	:=	l.tsvemployee_v100.worklocation.city;
		Self.employee.worklocation.workaddress.state	:=	l.tsvemployee_v100.worklocation.state;
		Self.employee.worklocation.workaddress.zip5	:=	[];
		Self.employee.worklocation.workaddress.zip4	:=	[];
		Self.employee.worklocation.workaddress.county	:=	[];
		Self.employee.worklocation.workaddress.postalcode	:=	l.tsvemployee_v100.worklocation.postalcode;
		Self.employee.worklocation.workaddress.statecityzip	:=	[];
		Self.employee.worklocation.stateid	:=	l.tsvemployee_v100.worklocation.stateid;
		Self.employee.worklocation.region	:=	l.tsvemployee_v100.worklocation.region;
		Self.employee.worklocation.isocountrycode	:=	l.tsvemployee_v100.worklocation.isocountrycode;
		Self.employee 		:= l.tsvemployee_v100;
		Self.BaseCompensation.PayFrequency := l.TsVBaseComp.TsVPayFrequency;
		Self.BaseCompensation.RateOfPay := l.TsVBaseComp.TsVRateOfPay;
		Self.BaseCompensation.AvgHrsWorked := l.TsVBaseComp.TsVAvgHrsWorked;
		Self.BaseCompensation.PayPeriodFrequency := l.TsVBaseComp.TsVPayPeriodFrequency;
		Self.AnnualCompData := project(l.TsVAnnualCompData,toAnnualComp(left));
		Self.CompensationAdj.LastDate   	:= l.TsVCompAdj.LastDt;
		Self.CompensationAdj.LastAmount   := l.TsVCompAdj.LastAmt;
		Self.CompensationAdj.NextDate   	:= l.TsVCompAdj.NextDt;
		Self.CompensationAdj.NextAmount   := l.TsVCompAdj.NextAmt;
		Self.OffWorkPeriod.StartDate  := l.TsVOffWork.StartDt;
		Self.OffWorkPeriod.EndDate  	:= l.TsVOffWork.EndDt;
		Self.Completeness := l.Completeness;
		Self.ServerRespId  := l.SrvrtId;
		Self.DemoTransaction := l.DemoTrn;
		Self.FcraInfo.FcraInfoDetails := project(l.FcraInfo.FcraInfoDetails,toFcraInfoDetail(left));
	end;


	export iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRecord
		toRecords(iesp.equifax_evs.t_EvsResponse l , unsigned DID , string input_ssn_mask_value, string input_dob_mask_value) := transform
			self.signonresp.status.code := l.SignonMsgsRsV1.SonRs.Status.code;
			self.signonresp.status.message := l.SignonMsgsRsV1.SonRs.Status.message;
			self.signonresp.status.severity := l.SignonMsgsRsV1.SonRs.Status.severity;
			self.signonresp.datetimeserver := l.SignonMsgsRsV1.SonRs.DtServer;
			self.signonresp.language := l.SignonMsgsRsV1.SonRs.Language;
			_trnRs := l.TsVerMsgsRsV1.TsVTwnSelectTrnRs;
			self.verificationofemploymentresp.transactionuid := _trnRs.TrnUID;
			self.verificationofemploymentresp.status.code := _trnRs.status.code ;
			self.verificationofemploymentresp.status.message := _trnRs.status.message;
			self.verificationofemploymentresp.status.severity := _trnRs.status.severity;
			self.verificationofemploymentresp.masterserverid := _trnRs.MasterSrvRtId;
			self.verificationofemploymentresp.TransactionPurpose.code := _trnRs.TrnPurpose.Code ;
			self.verificationofemploymentresp.TransactionPurpose.message := _trnRs.TrnPurpose.Message;
			self.verificationofemploymentresp.specialhandling.demohandling := _trnRs.specialhandling.DemoHandling;
			self.verificationofemploymentresp.specialhandling.complimentary := _trnRs.specialhandling.complimentary; ;
			self.verificationofemploymentresp.verificationofemploymentselectrecord.verificationofemploymentrecorddata :=
			project(_trnRs.TsVTwnSelectRs.tsvresponsedata,GwRecord_to_Record(left , DID , input_ssn_mask_value , input_dob_mask_value));
			self.Pdf := l.TsVerPDF;
			Self.UniqueID := (string) DID;
	end;


END;