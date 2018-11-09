import iesp,ecrash_services;

EXPORT SoapCall_KY(dataset(iesp.ecrash.t_ECrashSearchAgency)  Ky_Agency_ds
								, ecrash_services.IParam.searchrecords kymod) := FUNCTION

		
		
		iesp.ky_search.t_KYCrashSearchRequest trans_prj(iesp.ecrash.t_ECrashSearchAgency l) := transform	 		 
			 self.Searchby.state := l.JurisdictionState;
			 self.Searchby.agencyORI := l.AgencyORI;
			 self.Searchby.firstName := kymod.firstname;
			 self.Searchby.lastName := kymod.lastname;
			
			 incident_date := map(kymod.DateOfLoss <> '' =>   kymod.DateOfLoss
													, kymod.DolStartdate <> '' => kymod.DolStartdate
													, '');
			 self.Searchby.IncidentDate.Year  := (integer2)incident_date[1..4];	
			 self.Searchby.IncidentDate.Month := (integer2)incident_date[5..6];	
			 self.Searchby.IncidentDate.Day   := (integer2)incident_date[7..8];	
			 self.Searchby.ReportNumber := kymod.ReportNumber;
			 self.Searchby.OfficerBadgeNumber := kymod.OfficerBadgeNumber;
			 self.Searchby.DriversLicenseNumber := kymod.driversLicenseNumber;
			 self.Searchby.street := kymod.AccidentLocationStreet;
			 self.Searchby.crossStreet := kymod.AccidentLocationCrossStreet;
			 Self.Searchby.VIN := kymod.VehicleVin;
			 self.options.StrictConditions := true; 
			 self := l;
			 self:= [];
			 
		end;
								
		ds_interim:= project(Ky_Agency_ds,trans_prj(left));						
						
		iesp.ky_search.t_KYCrashSearchRequest trans_soap(iesp.ky_search.t_KYCrashSearchRequest l) := transform
			 self := l;
		end;
										
		iesp.ky_search.t_KYCrashSearchResponseEx FailJoin(iesp.ky_search.t_KYCrashSearchRequest ds) := TRANSFORM
				ASSERT(1=0, 'KY Gateway Soap Error:' + (string)FAILCODE + ':' + FAILMESSAGE + ':' + FAILMESSAGE('soapresponse'));
				// FAIL(300, 'KY Gateway Soap Error');
				self.response._header.message := 'KY Gateway Soap Error' + (string) FAILCODE + ':' + FAILMESSAGE + ':' + FAILMESSAGE('soapresponse');
				self := ds;
				self := [];
		end;
			 
		outResponse:=SOAPCALL(ds_interim , kymod.KY_SearchEspURL
														, kymod.KY_SearchEspNAME
														, iesp.ky_search.t_KYCrashSearchRequest
														, trans_soap(left)
														, dataset(iesp.ky_search.t_KYCrashSearchResponseEx)
														, xpath('KYCrashSearchResponseEx')
														, onfail(FailJoin(left))      
														, PARALLEL(1)
														, RETRY(1), TIMEOUT(5), TRIM, LOG);

		return combine(ds_interim, outResponse);
	
END;

