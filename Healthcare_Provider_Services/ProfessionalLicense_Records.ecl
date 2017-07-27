import iesp,doxie,prof_licensev2_services,AutoStandardI,PersonReports,Codes,ut,Healthcare_Header_Services;
export ProfessionalLicense_Records(Healthcare_Header_Services.IParams.ReportParams inputData, dataset(doxie.layout_references) dsDids) := module
	shared getProfessionalLicensebyAutoKeys(prof_licensev2_services.profLicSearch.params profLicMod) := function
			outp := iesp.proflicense.t_ProfessionalLicenseRecord;
			raw  := prof_LicenseV2_Services.ProfLicSearch.val(profLicMod);
			outp xform(prof_licensev2_services.Assorted_Layouts.Layout_Search_w_pen l) := transform
				self.LicenseType := l.license_type;
				self.LicenseNumber := l.Orig_License_Number;
				self.ProviderNumber := l.ProviderId;
				self.SanctionNumber := l.sanc_id;
				self.SSN := l.best_ssn;
				self.DateLastSeen := iesp.ecl2esp.toDatestring8(l.date_last_seen);
				self.ProfessionOrBoard := l.profession_or_board;
				self.Status := l.Status;
				self.StatusEffectiveDate := iesp.ecl2esp.toDatestring8(l.status_effective_dt);
				self.Name := iesp.ECL2ESP.SetName(l.fname, l.mname, l.lname, l.name_suffix, l.title, '');
				self.OriginalName := iesp.ECL2ESP.SetName('', '', '', '', '', l.Orig_name);
				self.AdditionalOrigName := iesp.ECL2ESP.SetName('', '', '', '', '', l.Orig_Former_Name);
				self.CompanyName := l.Company_name;
				self.Address := iesp.ecl2esp.SetAddress (l.prim_name, l.prim_range, l.predir, l.postdir,
							 l.suffix, l.unit_desig, l.sec_range, l.p_city_name,
							 l.st, l.zip, l.zip4, '','', '', '', '');
				self.OriginalAddress := iesp.ecl2esp.SetAddress ('', '', '', '','', '', '', l.Orig_City, l.Orig_St, l.Orig_Zip, '', '','', l.Orig_Addr_1, l.Orig_Addr_2, '');
				self.AdditionalOrigAddress := iesp.ecl2esp.SetAddress ('', '', '', '','', '', '', l.additional_orig_city, l.additional_orig_st, l.additional_orig_zip, '', '','', l.additional_orig_additional_1, l.additional_orig_additional_2, '');
				self.Phone := l.phone;
				self.TimeZone := '';
				self.AdditionalPhone := '';
				self.Gender := l.sex;
				self.DOB := iesp.ecl2esp.toDatestring8(l.dob);
				self.IssuedDate := iesp.ecl2esp.toDatestring8(l.issue_date);
				self.ExpirationDate := iesp.ecl2esp.toDatestring8(l.expiration_date);
				self.LastRenewalDate := iesp.ecl2esp.toDatestring8(l.last_renewal_date);
				self.LicenseObtainedBy := l.license_obtained_by;
				self.BoardActionIndicator := if(length(trim(l.Action_Status,all))>0,'Y','N'); 
				self.SourceState := l.source_st_decoded;//Possible this could also be l.source_st
				self.Occupation := '';
				self.PracticeHours := 0;
				self.PracticeType := '';
				self.Email := '';
				self.Fax := '';
				self.Action := [];
				self.ContinueEducation := '';
				self.Education1 := []; 
				self.Education2 := [];
				self.Education3 := [];
				self.AdditionalLicensingSpecs := '';
				self.PlaceOfBirth := '';
				self.Race := '';
				self := [];
			end;
			
			fmt	 := project(raw,xform(left));
			return fmt;
	end;
	emptyMod := module(project (AutoStandardI.GlobalModule(), PersonReports.input.dummy_search, opt))
					export STRING30 	LastName := '';      			
					export STRING30 	FirstName := '';
					export STRING30 	MiddleName := '';
					export string120  CompanyName := '';
					export string11 	Fein := '';
					export string25 	City := '';
					export string2	 	State := '';
					export string6	 	Zip := '';
					export unsigned8 	DOB := 0;
					export string		 	LicenseNumber := '';
					export string2	 	LicenseState := '';
					export string11 	SSN := '';
					export real 			latitude  := 0.0;
					export real 			longitude := 0.0;
					export string			BDL := '';
					export string50		DriversLicense := '';
	end;
	dsProfessionalLicensesDid := choosen(PersonReports.proflic_records(dsDids, module (project (emptyMod, PersonReports.input.proflic, opt)) end).proflicenses_v2,iesp.Constants.BR.MaxProfLicenses);
	// Do additional call if nothing found via did search to try using input criteria... 
	// Do not want to miss getting Indiana data.
	profLicMod := module(project(AutoStandardI.GlobalModule(),prof_licensev2_services.profLicSearch.params,opt))
				export STRING30 	LastName := inputData.LastName;      			
				export STRING30 	FirstName := inputData.FirstName;
				export STRING30 	MiddleName := inputData.MiddleName;
				export string120  CompanyName := inputData.CompanyName;
				export string200  Addr := inputData.addr;
				export string6 Zip := inputData.z5;
				export boolean Include_Prof_Lic := true;
				export boolean Include_Sanc := true;
				export boolean Include_Prov := true;
				export unsigned6 	Sanc_id := 0;
				export unsigned6  ProviderId := 0;
				export unsigned6  prolic_seq_num := 0;
				export string20 License_Number := '';	
				export boolean is_search := TRUE;
				export boolean nodeepdive := TRUE;
				export boolean nofail := TRUE;
				export INTEGER5 startingRecord := 1;
				export INTEGER5 returnCount := 9999;
			end;
	dsProfessionalLicensesAutoKeys := choosen(getProfessionalLicensebyAutoKeys(profLicMod),iesp.Constants.BR.MaxProfLicenses);
	dsProfessionalLicensesRaw := map(exists(dsProfessionalLicensesDid)=>dsProfessionalLicensesDid,dsProfessionalLicensesAutoKeys);
	dsRemoveExpired := dsProfessionalLicensesRaw(iesp.ecl2esp.DateToString(ExpirationDate)>=ut.Now());
	finalds := if (inputData.IncludeCurrentProfessionalLicensesOnly,dsRemoveExpired,dsProfessionalLicensesRaw);
	dsFilterCurrent := join(finalds, Codes.Key_Codes_V3,	
										keyed(right.file_name = Healthcare_Provider_Services.Constants.PROF_LIC_CODESV3_FILENAME) and 
										keyed(right.field_name = Healthcare_Provider_Services.Constants.PROF_LIC_CODESV3_FIELDNAME) and	
										left.SourceState = right.code, 
										transform(iesp.proflicense.t_ProfessionalLicenseRecord,self:=left));
	export dsProfessionalLicenses := if (inputData.IncludeCurrentProfessionalLicensesOnly,dsFilterCurrent,dsProfessionalLicensesRaw);
end;
