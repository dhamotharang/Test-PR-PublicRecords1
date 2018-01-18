IMPORT iesp, FBNV2_services;

EXPORT transform_FBN (dataset (FBNV2_services.Layout_FBN_Report) fbni) := function

iesp.fictitiousbusinesssearch.t_OwnerInformation SetOwners (FBNV2_services.Layout_Contact l) := TRANSFORM
	self.UniqueId := intformat(l.did,12,1);
	self.Name := l.CONTACT_NAME ;
	self.Phone := l.CONTACT_PHONE;
	self.Address := iesp.ECL2ESP.SetUniversalAddress(l.prim_name, l.prim_range, l.predir, l.postdir, l.addr_suffix, l.unit_desig, l.sec_range,
			l.v_city_name, l.st, l.zip5, l.zip4, l.county_name);
	self.ContactType := l.Contact_Type_decoded;
	self.Status := l.CONTACT_STATUS;
	self.NameFormat := l.Contact_Name_Format_decoded;
	self.FEIN := l.CONTACT_FEI_NUM;  
	self.CharterNumber := l.CONTACT_CHARTER_NUM;
	self.WithdrawlDate := iesp.ECL2ESP.toDate(l.WITHDRAWAL_DATE);
 END;

iesp.fictitiousbusinesssearch.t_FictitiousBusinessSearchRecord toOut (FBNV2_services.Layout_FBN_Report l) := TRANSFORM
	self.TMSId :=l.TMSId;
	self.RMSId := l.RMSId;
	self.FilingJurisdiction := L.Filing_Jurisdiction;
	self.FilingNumber := l.FILING_NUMBER;
	self.OriginalFilingNumber := l.ORIG_FILING_NUMBER;
	self.FilingType := l.FILING_TYPE;
	self.FilingDate := iesp.ECL2ESP.toDate(l.Filing_date);
	self.OriginalFilingDate := iesp.ECL2ESP.toDate(l.ORIG_FILING_DATE);
	self.FilingExpirationDate := iesp.ECL2ESP.toDate(l.EXPIRATION_DATE);
	self.FilingCancellationDate := iesp.ECL2ESP.toDate(l.CANCELLATION_DATE);
	self.Business := project(l, transform(iesp.fictitiousbusinesssearch.t_BusinessInformation,
		self.BusinessId := intformat(l.bdid,12,1),
		self.Name := l.BUS_NAME,
		self.SICCode := l.SIC_CODE,
		self.TypeDescription := l.BUS_TYPE_DESC,
		self.FEIN := l.orig_FEIN,   
		self.Phone := l.BUS_PHONE_NUM,
		self.Status := l.bus_status,
		self.StartDate := iesp.ECL2ESP.todate(l.bus_comm_dATE),
		self.OfficeAddress := iesp.ECL2ESP.SetUniversalAddress(l.prim_name, l.prim_range, l.predir, l.postdir, l.addr_suffix, l.unit_desig, l.sec_range,
			l.v_city_name, l.st, l.zip5, l.zip4, l.county_name),
		self.MailingAddress := iesp.ECL2ESP.SetAddressFields(l.mail_prim_name, l.mail_prim_range, l.mail_predir, L.mail_postdir, l.mail_addr_suffix, l.mail_unit_desig, l.mail_sec_range,
			'', l.mail_v_city_name, '', l.mail_st, l.mail_zip5, l.mail_zip4, '', '')));
   self.owners := project (choosen (l.Contacts, iesp.Constants.FBN.MaxCountOwners), SetOwners (Left));
	 self := [];
end;

RETURN PROJECT (fbni, toOut (Left));
end;