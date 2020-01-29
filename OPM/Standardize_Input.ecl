IMPORT  ut,  _Validate,  std,  mdr;

EXPORT Standardize_Input := MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fPreProcess(DATASET(OPM.Layouts.Sprayed_Input) pRawInput, STRING pversion) := FUNCTION
		
		OPM.Layouts.Base tPreProcess(OPM.Layouts.Sprayed_Input L) := TRANSFORM
				List                              :=['INVALID','REDACTED','*','NO DATA REPORTED' ];//Vendor data has invalid verbiage! 
				SELF.record_type            			:= 'C';		
				SELF.process_date                 := STD.Date.CurrentDate(TRUE);
				SELF.dt_first_seen								:= IF(_validate.date.fIsValid(l.Computation_Date) and _validate.date.fIsValid(l.Computation_Date,_validate.date.rules.DateInPast), (UNSIGNED4)l.Computation_Date, 0);
				SELF.dt_last_seen									:= IF(_validate.date.fIsValid(l.Computation_Date) and _validate.date.fIsValid(l.Computation_Date,_validate.date.rules.DateInPast), (UNSIGNED4)l.Computation_Date, 0);
				SELF.dt_vendor_first_reported			:= IF(_validate.date.fIsValid(pversion[1..8]) and _validate.date.fIsValid(pversion[1..8],_validate.date.rules.DateInPast), (UNSIGNED4)pversion[1..8], 0);
				SELF.dt_vendor_last_reported			:= IF(_validate.date.fIsValid(pversion[1..8]) and _validate.date.fIsValid(pversion[1..8],_validate.date.rules.DateInPast), (UNSIGNED4)pversion[1..8], 0);
				SELF.source 											:= MDR.sourceTools.src_OPM;
				SELF.Employee_Name 								:= ut.CleanSpacesAndUpper(l.Employee_Name);
				SELF.Duty_Station	 								:= IF(ut.CleanSpacesAndUpper(l.Duty_Station)in [List,'DUTY_STATION '],'',ut.CleanSpacesAndUpper(l.Duty_Station));
				SELF.Country											:= IF(ut.CleanSpacesAndUpper(l.Country	)in List,'',ut.CleanSpacesAndUpper(l.Country));
				SELF.State												:= IF(ut.CleanSpacesAndUpper(l.State)in [List,'STATE'],'',l.State);
				SELF.State_Code										:= OPM.Functions.get_StateCode(self.State);
				SELF.City													:= IF(ut.CleanSpacesAndUpper(l.City)in List,'',ut.CleanSpacesAndUpper(l.City));
				SELF.Zip5                         := ziplib.CityToZip5( self.State, self.City);
				SELF.County											  := IF(ut.CleanSpacesAndUpper(l.County)in List,'',ut.CleanSpacesAndUpper(l.County));
				SELF.Agency										    := ut.CleanSpacesAndUpper(l.Agency);	
				SELF.Agency_Sub_Element						:= IF(ut.CleanSpacesAndUpper(l.Agency_Sub_Element)in [List,'SUB_AGENCY','VA**-INVALID'],'',ut.CleanSpacesAndUpper(l.Agency_Sub_Element));
				SELF.Computation_Date						  := IF(_validate.date.fIsValid(l.Computation_Date),l.Computation_Date,'');
				SELF.Occupational_Series 					:= IF(ut.CleanSpacesAndUpper(l.Occupational_Series)in [List,'*-IN','SERIES'],'',ut.CleanSpacesAndUpper(l.Occupational_Series));
				SELF.Occu_Series_Desc             := OPM.Functions.get_OccuDesc(self.Occupational_Series);
				SELF.File_Date                    := l.File_Date; //Only 6 in length from vendor     
				SELF 															:= l;
				SELF 															:= []  ;
		END;
		
		dPreProcess        := PROJECT(pRawInput,tPreProcess(LEFT));

    dPreProcess_dedup  := DEDUP( SORT(dPreProcess, RECORD, LOCAL ), RECORD, LOCAL );	
	
		RETURN dPreProcess_dedup;

	END;  //End fPreProcess
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(OPM.Layouts.Sprayed_Input) pRawInput
							,STRING  pversion
							,STRING  pPersistname = OPM.Persistnames().StandardizeInput
	           ) := FUNCTION
	
		dPreprocess	:= fPreProcess(pRawInput,pversion	) : PERSIST(pPersistname);

		RETURN dPreprocess;
	
	END;

END;