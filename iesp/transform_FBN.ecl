IMPORT FBNV2_services;

export transform_FBN (dataset (FBNV2_services.Layout_FBN_Report) fbni) := function

iesp.fictitiousbusinesssearch.t_OwnerInformation SetOwners (FBNV2_services.Layout_Contact l) := TRANSFORM
	self.UniqueId := intformat(l.did,12,1);
	self.Name := l.CONTACT_NAME ;
	self.Phone := l.CONTACT_PHONE;
  self.Address := ROW ({L.prim_name, L.prim_range, L.predir, L.postdir, L.addr_suffix, L.unit_desig, L.sec_range,
                                    '', '', L.st, L.v_city_name, L.zip5, L.zip4, L.county_name, '', '','','',false}, share.t_UniversalAddress);
	self.ContactType := l.Contact_Type_decoded;
	self.Status := l.CONTACT_STATUS;
	self.NameFormat := l.Contact_Name_Format_decoded;
	self.FEIN := l.CONTACT_FEI_NUM;  
	self.CharterNumber := l.CONTACT_CHARTER_NUM;
	self.WithdrawlDate := iesp.ECL2ESP.toDate(l.WITHDRAWAL_DATE);
 END;


iesp.fictitiousbusinesssearch.t_FictitiousBusinessSearchRecord toOut (FBNV2_services.Layout_FBN_Report L) := TRANSFORM

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
	self.Business := project(L, transform(iesp.fictitiousbusinesssearch.t_BusinessInformation,
				self.BusinessId := intformat(l.bdid,12,1),
				self.Name := l.BUS_NAME,
				self.SICCode := l.SIC_CODE,
				self.TypeDescription := l.BUS_TYPE_DESC,
				self.FEIN := l.orig_FEIN,   
				self.Phone := l.BUS_PHONE_NUM,
				self.Status := l.bus_status,
				self.StartDate := iesp.ECL2ESP.todate(l.bus_comm_dATE),
	      self.OfficeAddress := ROW ({L.prim_name, L.prim_range, L.predir, L.postdir, L.addr_suffix, L.unit_desig, L.sec_range,
                                    '', '', L.st, L.v_city_name, L.zip5, L.zip4, L.county_name, '', '','','',false}, share.t_UniversalAddress),
	      self.MailingAddress := iesp.ECL2ESP.SetAddressFields(L.mail_prim_name, L.mail_prim_range, L.mail_predir, L.mail_postdir, L.mail_addr_suffix, L.mail_unit_desig, L.mail_sec_range,
                                    '', L.mail_v_city_name, '', L.mail_st, L.mail_zip5, L.mail_zip4, '', '')));
   self.owners      := project (choosen (L.Contacts,      iesp.Constants.FBN.MaxCountOwners),      SetOwners (Left));
	 self := [];
end;

RETURN PROJECT (fbni, toOut (Left));
end;
