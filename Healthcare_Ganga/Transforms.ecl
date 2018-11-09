import iesp, Healthcare_Ganga,Healthcare_Header_Services,std;

EXPORT Transforms := MODULE
 	EXPORT iesp.healthcare_identity.t_HealthCareIdentityScreeningResponse xformWeb (Healthcare_Ganga.Layouts.IdentityInput l,Healthcare_Ganga.Layouts.IdentityOutput R) := TRANSFORM
			self._Record.APSTransactionID := l.APSTransactionID;
			self._Header.TransactionId := R.TransactionId;
			//self._Record.RecordIdentifier := l.APSTransactionID;
			self._Record.EnrollmentId := l.EnrollmentId;
			self._Record.Business.BusinessId := R.BusinessId;
			self._Record.Business.Name := R.BusinessName;
			self._Record.Business.LegalName := R.LegalName;
			self._Record.Business.DoingBusinessAs := R.DoingBusinessAs;
			self._Record.Business.PhoneNumber := R.PhoneNumber;
			self._Record.Business.FaxNumber := R.FaxNumber;
			self._Record.Email := R.email;
			self._Record.Business.Url := R.url;
			self._Record.Business.Description := R.Description;
			self._Record.Business._Type := R.BusinessType;
			self._Record.Business.YearStarted := R.StartYear;
			self._Record.Business.TotalEmployees := R.TotalEmployees;
			self._Record.Business.Sales	:= R.Sales;
			self._Record.Business.SICCode := R.SicCode;
			self._Record.Business.SICDescription := R.SicDesc;
			self._Record.Individual.UniqueId	:= R.UniqueId;
			self._Record.Individual.Name.First := R.FirstName;
			self._Record.Individual.Name.Middle := R.MiddleName;
			self._Record.Individual.Name.Last := R.LastName;
			self._Record.Individual.Name.Prefix := R.NamePrefix;
			self._Record.Individual.Name.Suffix := R.NameSuffix;
			self._Record.Individual.Gender := R.Gender;
			self._Record.Individual.DOB := iesp.ECL2ESP.toDatestring8(R.DOB);
			self._Record.Individual.DOD := iesp.ECL2ESP.toDatestring8(R.DOD);
			self._Record.Individual.SSN := R.SSN;
			self._Record.Individual.RawPhoneNumber := R.RawPhoneNumber;
			self._Record.TaxId:= R.TaxId;
			self._Record.NPI	:= R.NPI;
			self._Record.CorrespondenceAddresses := project(R,transform(iesp.share.t_Address,
																													self.StreetAddress1 := left.StreetAddress1;
																													self.StreetAddress2 := left.StreetAddress2;
																													self.City := left.City;
																													self.State := left.State;
																													self.Zip5 := left.Zip5;
																													self.Zip4 := left.Zip4;
																													self:=[]));
			self.Warnings := choosen(project(R.Warnings, 
																				transform(iesp.healthcare_identity.t_HealthCareIdentityScreeningWarning,
																											self.Code := left.Code;
																											self.Source := left.Source;
																											self := [])),iesp.Constants.Tista.MAX_WARNINGS);
			self := [];
	END;

	EXPORT Healthcare_Ganga.Layouts.IdentityOutput xformCommon (Healthcare_Header_Services.Layouts.CombinedHeaderResultsDoxieLayout l,Healthcare_Ganga.Layouts.IdentityInput r) := TRANSFORM
					names:= sort(l.Names,-nameSeq);
					addr := sort(l.Addresses,-v_last_seen);
					self.acctno := l.acctno;
					self.TransactionId := l.acctno;
					//self.recordIdentifier := r.apstransactionid[1];
					self.UniqueId	:= (string)l.dids[1].did;
					self.NamePrefix := names[1].title;
					self.FirstName := names[1].FirstName;
					self.MiddleName := names[1].MiddleName;
					self.LastName := names[1].LastName;
					self.NameSuffix := names[1].suffix;
					self.Gender := names(Gender<>'')[1].Gender;
					self.DOB := l.dobs(dob<>'')[1].dob;
					self.DOD := l.DateofDeath;
					self.SSN := l.ssns(ssn<>'')[1].ssn;
					self.TaxId:= map(exists(l.taxids)=>l.taxids[1].taxid,
												exists(l.feins)=>l.feins[1].fein,
												'');
					phones := addr(PhoneNumber<>'')[1].PhoneNumber;
					self.PhoneNumber := phones;
					self.RawPhoneNumber := phones;
					self.StreetAddress1 := STD.str.cleanspaces(addr[1].prim_range+ ' ' + addr[1].predir+ ' ' + addr[1].prim_name+ ' ' + addr[1].addr_suffix + ' ' + addr[1].postdir);
					self.StreetAddress2 := STD.str.cleanspaces(addr[1].unit_desig+ ' ' +addr[1].sec_range);
					self.City := addr[1].p_city_name;
					self.State := addr[1].st;
					self.Zip5 := addr[1].z5;
					self.Zip4 := addr[1].zip4;
					self.NPI	:= l.npis[1].npi;
					self.BusinessId := (string)l.bdids[1].bdid;
					self.BusinessName := names[1].CompanyName;
					lbn :=  names(nameSeq = 2 or nameSeq = 4)[1].CompanyName;
					self.LegalName := if(l.NPIRaw[1].EntityInformation.ParentOrganization <> '',l.NPIRaw[1].EntityInformation.ParentOrganization,lbn);
					self.DoingBusinessAs	:= if(l.NPIRaw[1].EntityInformation.CompanyNameAKA <> '',l.NPIRaw[1].EntityInformation.CompanyNameAKA,lbn);
					self.FaxNumber := addr(FaxNumber<>'')[1].FaxNumber;
					self := l;
					self := r;
					self := [];
	END;
END;