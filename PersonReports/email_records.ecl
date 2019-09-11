IMPORT iesp, doxie, EmailService, Census_data;

out_rec := iesp.emailsearch.t_EmailSearchRecord;

EXPORT out_rec email_records (
  DATASET (doxie.layout_references) dids,
  $.IParam.emails in_params = MODULE($.IParam.emails) END,
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

	countyName(STRING2 st,STRING3 county) := 
		Census_data.Key_Fips2County(KEYED(st=state_code AND county=county_fips))[1].county_name;

	iesp.emailsearch.t_EmailSearchEmail setEmails(EmailService.Assorted_Layouts.layout_emails L) := TRANSFORM
		SELF.EmailAddress := if(L.clean_email <> '', L.clean_email, L.orig_email);
		SELF.WebSite := L.orig_site;
		SELF.LoginDate := iesp.ECL2ESP.toDate((INTEGER)L.orig_login_date);
	END;

	iesp.share.t_Address setAddresses(EmailService.Assorted_Layouts.layout_addresses L) := TRANSFORM
		SELF.StreetNumber := L.prim_range;
		SELF.StreetPreDirection := L.predir;
		SELF.StreetName := L.prim_name;
		SELF.StreetPostDirection := L.postdir;
		SELF.StreetSuffix := L.addr_suffix;
		SELF.UnitDesignation := L.unit_desig;
		SELF.UnitNumber := L.sec_range;
		SELF.City := L.p_city_name;
		SELF.State := L.st;
		SELF.Zip5 := L.zip;
		SELF.Zip4 := L.zip4;
		SELF.County := IF(L.st!='' AND L.county!='',countyName(L.st,L.county[3..5]),'');
		SELF := [];
	END;

	iesp.share.t_Name setNames(EmailService.Assorted_Layouts.layout_names L) := TRANSFORM
		SELF.Prefix := L.title;
		SELF.First  := L.fname;
		SELF.Middle := L.mname;
		SELF.Last   := L.lname;
		SELF.Suffix := L.name_suffix;
		SELF.Full := '';
	END;

	out_rec toOut(EmailService.Assorted_Layouts.layout_report_rollup L) := TRANSFORM
		SELF.UniqueId := INTFORMAT(L.DID,12,1);
		SELF.Source := L.SRC;
		SELF.SSN := L.Best_SSN;
		SELF.DOB := iesp.ECL2ESP.toDate((INTEGER)L.Best_DOB);
		SELF.Names := CHOOSEN(PROJECT(L.Names,setNames(LEFT)),iesp.Constants.Email.MAX_NAMES_PER_PERSON);
		SELF.Addresses := CHOOSEN(PROJECT(L.Addresses,setAddresses(LEFT)),iesp.Constants.Email.MAX_ADDRS_PER_PERSON);
		SELF.Emails := CHOOSEN(PROJECT(L.Emails,setEmails(LEFT)),iesp.Constants.Email.MAX_EMAILS_PER_PERSON);
		SELF.AlsoFound := false;
		SELF.EmailId := '';
	END;

  // Same call as in comp report
  rptRecs := doxie.email_records (dids, in_params.ssn_mask, in_params.application_type);

  RETURN PROJECT(rptRecs,toOut(LEFT));
END;
