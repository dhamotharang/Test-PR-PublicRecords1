/*--SOAP--
<message name="CarrierSearchService" wuTimeout="300000">
  <part name="DPPAPurpose"         type="xsd:byte"/>
  <part name="GLBPurpose"          type="xsd:byte"/> 
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
  <part name="HealthcareSubrogationSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
import AutoStandardI,iesp,ut, Address, CarrierID_Services, STD, Doxie, NID;
// export CarrierSearchService () :=  FUNCTION
export CarrierSearchService :=  MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		#stored('PhoneticMatch','true');

    //get xml input 
    // rec_in    := iesp.healthcaresubrogationsearch.t_HealthcareSubrogationSearchRequest;
    ds_in     := dataset([],iesp.healthcaresubrogationsearch.t_HealthcareSubrogationSearchRequest) : stored ('HealthcareSubrogationSearchRequest', FEW);
    first_row := ds_in[1] : independent;

    //set options
    iesp.ECL2ESP.SetInputBaseRequest(first_row);
    Search_opt := global(first_row.Options);

    //set search criteria
    search_by 			 := global(first_row.searchBy);
		
		//Clean Input:
		iesp.bpsreport.t_BpsReportBy xformCleanInput(iesp.healthcaresubrogationsearch.t_HealthcareSubrogationSearchBy aInputData) := transform
				/* --- Name Information ---*/
				Name_DS := ROW ({aInputData.Name.Full,aInputData.Name.First,aInputData.Name.Middle,aInputData.Name.Last,aInputData.Name.Suffix,aInputData.Name.Prefix},iesp.share.t_name);
				
				Name := Address.GetCleanNameAddress.fnCleanName (Name_DS);

				self.name :=  iesp.ECL2ESP.SetName (Name.fname,Name.mname,Name.lname,Name.name_suffix,'','');

				/* --- ADDRESS INFORMATION --- */
				addr1			 								:= map(aInputData.Address.StreetAddress1 <> '' => aInputData.Address.StreetAddress1,
																				Address.Addr1FromComponents(aInputData.Address.StreetNumber, aInputData.Address.StreetPreDirection, aInputData.Address.StreetName,
		                                     aInputData.Address.StreetSuffix, aInputData.Address.StreetPostDirection, 
																				 '', aInputData.Address.UnitNumber));
																				 
				addr2 										:= map(aInputData.Address.StateCityZip <> '' => aInputData.Address.StateCityZip,
																				Address.Addr2FromComponents(aInputData.Address.City, aInputData.Address.State, aInputData.Address.Zip5));
				
				clean_addr 								:= address.GetCleanAddress(addr1, addr2, address.Components.Country.US);
				ca												:= clean_addr.results;
				
				self.Address := iesp.ECL2ESP.SetAddress (
															ca.prim_name, ca.prim_range, ca.predir, ca.postdir, ca.suffix, ca.unit_desig, ca.sec_range,
															ca.p_city, ca.state, ca.zip, ca.zip4, ca.county, '',
															Address.Addr1FromComponents(ca.prim_range, ca.predir, ca.prim_name, ca.suffix, ca.postdir, ca.unit_desig, ca.sec_range),
															'',
															Address.Addr2FromComponents(ca.p_city, ca.state, ca.zip));	

				self := aInputData;
				self := [];
		end;
		
		reportby_clean := row(search_by, xformCleanInput(left));
		clean_lname := reportby_clean.name.last;
		clean_fname := reportby_clean.name.first;
		String8	Date_of_Service := if(search_by.DateOfService.year>0,(string)search_by.DateOfService.Year+(intformat(search_by.DateOfService.Month,2,1))+(intformat(search_by.DateOfService.Day,2,1)),'');			
		#stored('DateOfService', if(search_by.DateOfService.year>0,(string)search_by.DateOfService.Year+(intformat(search_by.DateOfService.Month,2,1))+(intformat(search_by.DateOfService.Day,2,1)),''));			
		isValidOrder := Std.Date.IsValidDate((INTEGER)Date_of_Service) AND search_by.Address.State NOT IN HealthCareSubrogation.Constants.Restricted_States;
		iesp.ECL2ESP.SetInputReportBy(reportby_clean);
		iesp.ECL2ESP.Marshall.Mac_Set(Search_opt);
			
    tempmod := module(project(AutoStandardI.GlobalModule(), 
        CarrierID_Services.IParam.searchrecords,opt));
        export string   AccidentNumber_raw  := '' : stored('AccidentNumber');
				export string   AccidentNumber 			:= stringlib.stringfilter(stringlib.stringtouppercase(AccidentNumber_raw),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
				export string   DateOfService       := '' : stored('DateOfService');
				export integer  SearchDaysBeforeDateOfService := 0 : stored('SearchDaysBeforeDateOfService');
				export integer  SearchDaysAfterDateOfService  := 0 : stored('SearchDaysAfterDateOfService');
				export string30 VIN 			          := '';
				export boolean  IsDeepDive          := true;
    end;

		experian_vin_ds := HealthCareSubrogation.Call_Experian_VIN (reportby_clean, Date_of_Service);
		experian_vin := Experian_vin_ds[1].VIN;
		
    tempmodvin := module(project(AutoStandardI.GlobalModule(), 
        CarrierID_Services.IParam.searchrecords,opt));
        export string   AccidentNumber_raw  := '' : stored('AccidentNumber');
				export string   AccidentNumber 			:= stringlib.stringfilter(stringlib.stringtouppercase(AccidentNumber_raw),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
				export string   DateOfService       := '' : stored('DateOfService');
				export integer  SearchDaysBeforeDateOfService := 0 : stored('SearchDaysBeforeDateOfService');
				export integer  SearchDaysAfterDateOfService  := 0 : stored('SearchDaysAfterDateOfService');
				export string30 VIN 			          := experian_vin;
				export boolean  IsDeepDive          := true;
    end;
		dummy_ds := DATASET ([],iesp.healthcaresubrogationsearch.t_HealthcareSubrogationSearchRespData);
		recc 		:= CarrierID_Services.Records(tempmod);
		recs 		:= IF(isValidOrder,project (CarrierID_Services.Records(tempmod),transform(iesp.healthcaresubrogationsearch.t_HealthcareSubrogationSearchRespData, self := left;)),dummy_ds);
		recsvin := IF(isValidOrder,project (CarrierID_Services.Records(tempmodvin),transform(iesp.healthcaresubrogationsearch.t_HealthcareSubrogationSearchRespData, self := left;)),dummy_ds);
		
		isNoHit := count(recs) = 0;
		final_recs := MAP (~isValidOrder => dummy_ds, isNoHit and isValidOrder => recsvin,recs);

		days_before := if (search_by.SearchDaysBeforeDateOfService > 0,search_by.SearchDaysBeforeDateOfService,90);
		days_after  := if (search_by.SearchDaysAfterDateOfService > 0,search_by.SearchDaysAfterDateOfService,10);

		iesp.healthcaresubrogationsearch.t_HealthcareSubrogationSearchRespData xFilter (iesp.healthcaresubrogationsearch.t_HealthcareSubrogationSearchRespData l) := TRANSFORM, SKIP(
			  ~Date_of_Service between 
			  (ut.DateFrom_DaysSince1900(ut.DaysSince1900((string)l.incident.DateOfLoss.Year, (string)l.incident.DateOfLoss.Month, (string)l.incident.DateOfLoss.Day) - (integer)days_before)) and 
			  (ut.DateFrom_DaysSince1900(ut.DaysSince1900((string)l.incident.DateOfLoss.Year, (string)l.incident.DateOfLoss.Month, (string)l.incident.DateOfLoss.Day) + (integer)days_after)))
			lname_match := clean_lname <> '' and l.driver.name.last <> '' and stringlib.stringtouppercase (clean_lname) = stringlib.stringtouppercase (l.driver.name.last); 
			lname_close_match := clean_lname <> '' and l.driver.name.last <> '' and stringlib.stringtouppercase (clean_lname [1..2]) = stringlib.stringtouppercase (l.driver.name.last[1..2]); 
			fname_match := clean_fname <> '' and l.driver.name.first <> '' and stringlib.stringtouppercase (clean_fname) = stringlib.stringtouppercase (l.driver.name.first);
			fname_close_match := clean_fname <> '' and l.driver.name.first <> '' and stringlib.stringtouppercase (clean_fname) = stringlib.stringtouppercase (nid.preferredfirstnew(l.driver.name.first));
			self.incident.isdirecthit := (lname_match or lname_close_match) and (fname_match or fname_close_match);
			self := l;
		end;
		
		filter_recs := sort(dedup(normalize (final_recs,count(final_recs),xFilter (left)),all),-incident.DateOfLoss.Year,-incident.DateOfLoss.Month,-incident.DateOfLoss.Day);
		
		carrier_service_resp := filter_recs (DataSource in HealthCareSubrogation.Constants.Non_CRU_DataSource AND Incident.State NOT IN  HealthCareSubrogation.Constants.Restricted_States);
		
    iesp.healthcaresubrogationsearch.t_HealthcareSubrogationSearchResponse marshall() := transform	
		  self._Header                   := IF (isValidOrder,row([],iesp.share.t_ResponseHeader),row({-1,'','','',[]},iesp.share.t_ResponseHeader));
			self.InputEcho.vin             := search_by.vin;
			//not recognizing the namesuffix global
			self.InputEcho.name            := iesp.ecl2esp.setnameandcompany(search_by.Name.First,search_by.Name.Middle,search_by.Name.Last,search_by.Name.Suffix,search_by.Name.Prefix,search_by.Name.Full,'');
			//we want to echo the user input and not the clean address per Product
			self.InputEcho.address         := search_by.address;
			self.InputEcho.ssn             := search_by.ssn;
			self.InputEcho.dob             := iesp.ecl2esp.toDatestring8((string)tempmod.dob);
			self.InputEcho.dateofservice	 := iesp.ecl2esp.toDatestring8((string)tempmod.dateofservice);
      self.RecordCount               := count(carrier_service_resp);
			self.LegalDisclaimer           := '';
			self.Records                   := carrier_service_resp;
			self.inputecho.searchdaysbeforedateofservice 	:= search_by.SearchDaysBeforeDateOfService;
			self.inputecho.searchdaysafterdateofservice 	:= search_by.SearchDaysAfterDateOfService;
		end;
		
    results := dataset([marshall()]);
		// output (recs,named('recs'));
		// output (recsvin,named('recsvin'));
		// OUTPUT (carrier_service_resp,NAMED('carrier_service_resp'));
		// output (reportby_clean,named('reportby_clean'));
		// OUTPUT (Date_of_Service,NAMED('Date_of_Service'));
		// output (Date_of_Loss,named('Date_of_Loss'));
		// OUTPUT (date_before_range,NAMED('date_before_range'));
		// OUTPUT (date_after_range,NAMED('date_after_range'));		
		// output (first_row,named('first_row'));
		// output (final_recs,named('final_recs'));
		// OUTPUT (filter_recs,NAMED('filter_recs'));
		// OUTPUT (recc,named('CarrierIDResult'));
		OUTPUT (results,named('Results'));
		// RETURN Results;
ENDMACRO;
// END;
