//EXPORT Transforms := 'todo';
import iesp, Healthcare_Ganga,Healthcare_Header_Services;

EXPORT Transforms := MODULE
 	EXPORT iesp.healthcare_identity.t_HealthCareIdentityScreeningResponse xform (Healthcare_Ganga.Layouts.IdentityInput l) := TRANSFORM
			self._Record.APSTransactionID := '1';
			self._Header.TransactionId := '2';
			self._Record.RecordIdentifier := 'I';
			self._Record.EnrollmentId := '246';
			self._Record.Individual.UniqueId	:= '123456';
			self._Record.Individual.Name.Prefix := 'Mr';
			self._Record.Individual.Name.First := 'Mike';
			self._Record.Individual.Name.Middle := 'K';
			self._Record.Individual.Name.Last := 'Johnson';
			self._Record.Individual.Name.Suffix := '';
			self._Record.Individual.Gender := 'M';
			self._Record.Individual.DOB := iesp.ecl2esp.toDatestring8('19601025');
			self._Record.Individual.DOD := iesp.ecl2esp.toDatestring8('20090518');
			self._Record.Individual.SSN := '111223333';
			self._Record.TaxId:= '515658651';
			self._Record.Email := 'mike.johnson@email.com';
			self._Record.Business.PhoneNumber := '9876543210';
			self._Record.Individual.RawPhoneNumber := '1597532486';
						
			AddressRow := DATASET([{'','','','','','','','1234 Main St', '', 'Minneapolis', 'MN', '55401', '', '','',''}], iesp.share.t_address)[1];
			//self.CorrespondenceAddresses := project(l, transform(iesp.share.t_address, self := left, self := []));
			//self._Record.CorrespondenceAddresses := project(AddressRow, transform(iesp.share.t_address, self := left));
			self._Record.CorrespondenceAddresses := AddressRow;

			self._Record.NPI	:= '796432106';
			self._Record.Business.BusinessId := '90';
			self._Record.Business.Name := 'Test Data';
			self._Record.Business.LegalName := 'Test Data Inc';
			self._Record.Business.DoingBusinessAs := 'Example';
			self._Record.Business.FaxNumber := '789321546';
			self._Record.Business.Url := 'www.testingdata.com';
			self._Record.Business.Description := 'This is test data for a test business.';
			self._Record.Business._Type := 'Testing';
			self._Record.Business.YearStarted := 2002;
			self._Record.Business.TotalEmployees := 168;
			self._Record.Business.Sales	:= '26540';
			self._Record.Business.SICCode := '81';
			self._Record.Business.SICDescription := 'This is an example';
			
			Warnings := DATASET([{'104','104'}], iesp.healthcare_identity.t_HealthCareIdentityScreeningWarning)[1];
			self.Warnings := Warnings;
   		self := [];
   	END;
 	
	
	EXPORT iesp.healthcare_identity.t_HealthCareIdentityScreeningResponse xformWeb (Healthcare_Header_Services.Layouts.CombinedHeaderResultsDoxieLayout l) := TRANSFORM
			names:= sort(l.Names,nameSeq);
			addr := sort(l.Addresses,-last_seen);
			self._Record.APSTransactionID := l.acctno;
			self._Record.RecordIdentifier := ''; //gap
			self._Record.EnrollmentId := ''; //gap
			self._Record.Business.BusinessId := (string)l.bdids[1].bdid;
			self._Record.Business.Name := names[1].CompanyName;
			lbn :=  names(nameSeq = 2 or nameSeq = 4)[1].CompanyName;
			self._Record.Business.LegalName := if(l.NPIRaw[1].EntityInformation.ParentOrganization <> '',l.NPIRaw[1].EntityInformation.ParentOrganization,lbn);
			self._Record.Business.DoingBusinessAs := if(l.NPIRaw[1].EntityInformation.CompanyNameAKA <> '',l.NPIRaw[1].EntityInformation.CompanyNameAKA,lbn);
			self._Record.Business.PhoneNumber := addr(PhoneNumber<>'')[1].PhoneNumber;
			self._Record.Business.FaxNumber := addr(FaxNumber<>'')[1].FaxNumber;
			self._Record.Business.Url := '';//gap
			self._Record.Business.Description := '';//gap
			self._Record.Business._Type := '';//gap
			self._Record.Business.YearStarted := 0;//gap
			self._Record.Business.TotalEmployees := 0;//gap
			self._Record.Business.Sales	:= '';//gap
			self._Record.Business.SICCode := '';//gap
			self._Record.Business.SICDescription := '';//gap
			self._Record.Individual.UniqueId	:= (string)l.dids[1].did;
			self._Record.Individual.Name := iesp.ECL2ESP.SetName(names[1].FirstName,names[1].MiddleName,names[1].LastName,names[1].suffix,names[1].title,names[1].fullname);
			self._Record.Individual.Gender := names(Gender<>'')[1].Gender;
			self._Record.Individual.DOB := iesp.ECL2ESP.toDatestring8(l.dobs(dob<>'')[1].dob);
			self._Record.Individual.DOD := iesp.ECL2ESP.toDatestring8(l.DateofDeath);
			self._Record.Individual.SSN := l.ssns(ssn<>'')[1].ssn;
			self._Record.Individual.RawPhoneNumber := addr(PhoneNumber<>'')[1].PhoneNumber;
			self._Record.TaxId:= map(exists(l.taxids)=>l.taxids[1].taxid,
												exists(l.feins)=>l.feins[1].fein,
												'');
			self._Record.NPI	:= l.npis[1].npi;
			self._Record.Email := '';//gap
			self._Record.CorrespondenceAddresses := choosen(project(addr, transform(iesp.share.t_address, 
																									self := iesp.ECL2ESP.SetAddress(left.prim_name, Left.prim_range,Left.predir, Left.postdir,
																													 Left.addr_suffix, Left.unit_desig, Left.sec_range, Left.p_city_name, 
																													 Left.st, Left.z5, Left.zip4, '', 
																													 '', trim(Left.address1,right)+' '+Left.address2,trim(left.p_city_name,right)+' '+trim(left.st,right)+' '+left.z5);
																									)),1);//1 needs to get updated in iesp/constants and fixed in the iesp layout
			//Handle Warnings
			//self.Code := l.Code;
			//self.Source := l.Source;
   		self := [];
   	END;

END;