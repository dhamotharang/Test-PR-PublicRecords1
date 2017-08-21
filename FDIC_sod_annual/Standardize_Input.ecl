import Address, Ut, lib_stringlib, _Control, business_header,_Validate,aid,idl_header;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_Input :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Sprayed) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.StandardizeInput tPreProcess(Layouts.Input.Sprayed l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning 
			//////////////////////////////////////////////////////////////////////////////////////
			self.rawfields.InstitutionName := (QSTRING) TRIM(L.InstitutionName,LEFT,RIGHT);
		  self.rawfields.AddressBranch := (QSTRING) TRIM(L.AddressBranch,LEFT,RIGHT);
		  self.rawfields.AddressInstitution := (QSTRING) TRIM(L.AddressInstitution,LEFT,RIGHT);
			self.Formattedbranchaddr := Address.CleanAddressFieldsFips(address.CleanAddress182((QSTRING) TRIM(L.AddressBranch,LEFT,RIGHT),TRIM(L.BranchZIPCode,LEFT,RIGHT))).addressrecord; 
			self.Formattedinstitutionaddr := Address.CleanAddressFieldsFips(address.CleanAddress182((QSTRING) TRIM(L.AddressInstitution,LEFT,RIGHT),TRIM(L.InstitutionZIPCode,LEFT,RIGHT))).addressrecord;
			self.rawfields.InstitutionClass := (QSTRING) TRIM(L.InstitutionClass,LEFT,RIGHT);
			self.rawfields.CENCODES := (QSTRING) TRIM(L.CENCODES,LEFT,RIGHT);
			self.rawfields.OfficeType := (QSTRING) TRIM(L.OfficeType,LEFT,RIGHT);
			self.rawfields.BranchMetroDivisionName := (QSTRING) TRIM(L.BranchMetroDivisionName,LEFT,RIGHT);
			self.rawfields.InstitutionMetroDivisionName := (QSTRING) TRIM(L.InstitutionMetroDivisionName,LEFT,RIGHT);
			self.rawfields.InstitutionMetroStatAreaName := (QSTRING) TRIM(L.InstitutionMetroStatAreaName,LEFT,RIGHT);
			self.rawfields.BranchMetroStatAreaName := (QSTRING) TRIM(L.BranchMetroStatAreaName,LEFT,RIGHT);
			self.rawfields.BranchCoreBasedStatAreaName := (QSTRING) TRIM(L.BranchCoreBasedStatAreaName,LEFT,RIGHT);
			self.rawfields.InstitutionCoreBasedAreaName := (QSTRING) TRIM(L.InstitutionCoreBasedAreaName,LEFT,RIGHT);
			self.rawfields.CharterAgentName := (QSTRING) TRIM(L.CharterAgentName,LEFT,RIGHT);
			self.rawfields.CharterAgentCode := (QSTRING) TRIM(L.CharterAgentCode,LEFT,RIGHT);
			self.rawfields.InstitutionHQCity := (QSTRING) TRIM(L.InstitutionHQCity,LEFT,RIGHT);
			self.rawfields.BranchUSPSCity := (QSTRING) TRIM(L.BranchUSPSCity,LEFT,RIGHT);
			self.rawfields.InstitutionHQUSPSCity :=	(QSTRING) TRIM(L.InstitutionHQUSPSCity,LEFT,RIGHT);
			self.rawfields.BranchReportedCity	:= (QSTRING) TRIM(L.BranchReportedCity,LEFT,RIGHT);
			self.rawfields.BankHoldingCompanyCity := (QSTRING) TRIM(L.BankHoldingCompanyCity,LEFT,RIGHT);
			self.rawfields.FIPSCMSANameBranch := (QSTRING) TRIM(L.FIPSCMSANameBranch,LEFT,RIGHT);
			self.rawfields.FIPSCMSANameMainOffice := (QSTRING) TRIM(L.FIPSCMSANameMainOffice,LEFT,RIGHT);
			self.rawfields.FIPSCountryName := (QSTRING) TRIM(L.FIPSCountryName,LEFT,RIGHT);
			self.rawfields.FIPSCountryNameBranch := (QSTRING) TRIM(L.FIPSCountryNameBranch,LEFT,RIGHT);
			self.rawfields.CountyNameBranch := (QSTRING) TRIM(L.CountyNameBranch,LEFT,RIGHT);
			self.rawfields.CountyNameInstitution :=	(QSTRING) TRIM(L.CountyNameInstitution,LEFT,RIGHT);
			self.rawfields.BranchCombinedStatAreaName := (QSTRING) TRIM(L.BranchCombinedStatAreaName,LEFT,RIGHT);
			self.rawfields.InstitutionCombinedStatAreaName := (QSTRING) TRIM(L.InstitutionCombinedStatAreaName,LEFT,RIGHT);
			self.rawfields.FDICRegionName	:= (QSTRING) TRIM(L.FDICRegionName,LEFT,RIGHT); 
			self.rawfields.FederalReserveDistrictName	:= (QSTRING) TRIM(L.FederalReserveDistrictName,LEFT,RIGHT);
			self.rawfields.PrimaryInsuranceFund	:= (QSTRING) TRIM(L.PrimaryInsuranceFund,LEFT,RIGHT);
			self.rawfields.MSANameBranch := (QSTRING) TRIM(L.MSANameBranch,LEFT,RIGHT);
			self.rawfields.MSANameInstitution	:= (QSTRING) TRIM(L.MSANameInstitution,LEFT,RIGHT);
			self.rawfields.BranchName	:= (QSTRING) TRIM(L.BranchName,LEFT,RIGHT);
			self.rawfields.FullInstitutionName := (QSTRING) TRIM(L.FullInstitutionName,LEFT,RIGHT);
			self.rawfields.RegulatoryHighHoldNameBHC :=	(QSTRING) TRIM(L.RegulatoryHighHoldNameBHC,LEFT,RIGHT);
			self.rawfields.BranchNewEnglandCntyMetroAreasname	:= (QSTRING) TRIM(L.BranchNewEnglandCntyMetroAreasname,LEFT,RIGHT);
			self.rawfields.InstitutionNewEnglandCntyMetroAreasname := (QSTRING) TRIM(L.InstitutionNewEnglandCntyMetroAreasname,LEFT,RIGHT);
			self.rawfields.OCCRegionName := (QSTRING) TRIM(L.OCCRegionName,LEFT,RIGHT);
			self.rawfields.OTSRegionName := (QSTRING) TRIM(L.OTSRegionName,LEFT,RIGHT);
			self.rawfields.QBPRegionName := (QSTRING) TRIM(L.QBPRegionName,LEFT,RIGHT);
			self.rawfields.DataSourceIdentifier	:= (QSTRING) TRIM(L.DataSourceIdentifier,LEFT,RIGHT);
			self.rawfields.PrimaryFederalRegulator := (QSTRING) TRIM(L.PrimaryFederalRegulator,LEFT,RIGHT);
			self.rawfields.BranchFDICRegionName := (QSTRING) TRIM(L.BranchFDICRegionName,LEFT,RIGHT);
			self.rawfields.ReportDate := (QSTRING) TRIM(L.ReportDate,LEFT,RIGHT);
			self.rawfields.IndustrySpecializationDescr:= (QSTRING) TRIM(L.IndustrySpecializationDescr,LEFT,RIGHT);
			self.rawfields.StateCode := (QSTRING) TRIM(L.StateCode,LEFT,RIGHT);
			self.rawfields.BranchStateCode := (QSTRING) TRIM(L.BranchStateCode,LEFT,RIGHT);
			self.rawfields.BHCStateCode := (QSTRING) TRIM(L.BHCStateCode,LEFT,RIGHT);
			self.rawfields.InstitutionHQStateName	:= (QSTRING) TRIM(L.InstitutionHQStateName,LEFT,RIGHT);
			self.rawfields.BranchStateName := (QSTRING) TRIM(L.BranchStateName,LEFT,RIGHT);
			self.rawfields.InstitutionZIPCode	:= (QSTRING) TRIM(L.InstitutionZIPCode,LEFT,RIGHT);
			self.rawfields.BranchZIPCode := (QSTRING) TRIM(L.BranchZIPCode,LEFT,RIGHT);
			self.Branchuniqueidinteger := TRUNCATE(L.BranchUniqueIDNumber);
			ReportDateYear := L.ReportDate[6..9];
			ReportDateMon := CASE( (QSTRING) TRIM(L.ReportDate,LEFT,RIGHT) [3..5], 'JAN' => '01', 'FEB' => '02', 'MAR' => '03', 'APR' => '04', 'MAY' => '05','JUN' => '06',										 
														'JUL' => '07', 'AUG' => '08', 'SEP' => '09', 'OCT' => '10', 'NOV' => '11', 'DEC' => '12','00');
			ReportDateDay := L.ReportDate[1..2];
			self.ReportDateNew := ReportDateYear+ReportDateMon+ReportDateDay;
			 
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			                                        
			self.unique_id												                                    := cnt											;
			self.recordtype												:= 'C'											;
			self.dt_vendor_first_reported					:= (unsigned4)pversion			;
			self.dt_vendor_last_reported					:= (unsigned4)pversion			;
			self := l;                                                                                                               
			self																	:= [];	
					
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcess(left,counter));
	
		return dPreProcess;
		


	 end;
	export fAll( 
		 dataset(Layouts.Input.Sprayed	)	pRawFileInput
		,string														pversion
		,string														pPersistname = persistnames().StandardizeInput
	) :=
	function
	 
	 dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		
		dback2base :=  project(dPreprocess, transform(layouts.base, self := left;SELF := []))
			 : persist(pPersistname);
	
		return dback2base;
		end;
end;

