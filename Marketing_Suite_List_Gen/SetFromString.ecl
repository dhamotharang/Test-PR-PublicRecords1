import STD, ut;

/*=========================================================================================================
| This function takes in a string of values, cleans out any special characters, validates the values &
| then outputs a SET of those values.
|========================================================================================================*/
export SetFromString := module

	export fCheckValues(string CleanSTR, SET OF STRING SetofCodes, integer FieldLen) := FUNCTION

		STR_Values	:=	{string Value};                                                     // define the layout
		Tmp					:=	dataset(length(CleanSTR), transform(  STR_Values                    // reformat filter
                                                    , skip(counter % FieldLen != 1)
                                                    , self.Value := if (CleanSTR[counter..counter + (FieldLen - 1)] in SetofCodes, CleanSTR[counter..counter + (FieldLen - 1)],'');
                                                   ))(Value != '');
                                                   
		cnt_items		:=	count(Tmp);
  
		string fail_string := (string)CleanSTR + ': Cleaned Value is not evenly divisable by ' + (string)FieldLen + '. Please check Parm file Values';
  
		FinalValue :=  if(length(TRIM(TMP[cnt_items].value,ALL)) in [FieldLen,0] 
												, TMP
												, FAIL(TMP,99,fail_string)
											): FAILURE(mod_email.SendFailureEmail(fail_string, '')); 
  
		return set(FinalValue, Value); 
	end;
	
	export SearchType(string SetValues)	:=	function
		SearchTypeSet	:=	['S','P'];
		CleanSTR		:=	STD.Str.FilterOut(trim(SetValues, ALL), '\',"');                    // remove any quotes/commas
		FieldLen		:=	1;
		
		STR_Values	:=	{string Value};                                                     // define the layout
		Tmp					:=	dataset(length(CleanSTR), transform(  STR_Values                    // reformat filter
																													,skip(counter % FieldLen != 1 and counter <> 1)
																													, self.Value := if (CleanSTR[counter..counter + (FieldLen - 1)] in SearchTypeSet, CleanSTR[counter..counter + (FieldLen - 1)],'');
																												))(Value != '');
                                                   
		string fail_string := (string)CleanSTR + ': Either the Search Location Type is missing, is invalid or there are multiple provided. Please check Parm file Values';
  
		FinalValue :=  if(length(CleanSTR)=1 
												, TMP
												, FAIL(TMP,99,fail_string)
											): FAILURE(mod_email.SendFailureEmail(fail_string, '')); 

		return set(FinalValue, Value); 	
	end;

	export tollfree(string SetValues)	:=	function
		TollFreeSet	:=	['800','888','877','866','855','844','833','822','880','887','889','400'];
		CleanSTR		:=	STD.Str.FilterOut(trim(SetValues, ALL), '\',"');                    // remove any quotes/commas

		set of string GoodTollFreeSet	:=	fCheckValues(CleanSTR, TollFreeSet, 3);
  
		return GoodTollFreeSet; 
	end;
	
	export areacode(string SetValues)	:=	function
		CleanSTR		:=	STD.Str.FilterOut(trim(SetValues, ALL), '\',"');                    // remove any quotes/commas
		FieldLen		:=	3;
		STR_Values	:=	{string Value};                                                     // define the layout
		Tmp					:=	dataset(length(CleanSTR), transform(  STR_Values                    // reformat filter
                                                    , skip(counter % FieldLen != 1)
                                                    , self.Value := if(ut.isNumeric(CleanSTR[counter..counter + (FieldLen - 1)]),
																																				CleanSTR[counter..counter + (FieldLen - 1)],
																																				''
																																			 );
                                                   ))(Value != '');
                                                   
		cnt_items		:=	count(Tmp);
  
		string fail_string := (string)CleanSTR + ': Cleaned Value is not evenly divisable by ' + (string)FieldLen + '. Please check Parm file Values';
  
		FinalValue :=  if(length(TRIM(TMP[cnt_items].value,ALL)) in [FieldLen,0] 
												, TMP
												, FAIL(TMP,99,fail_string)
											): FAILURE(mod_email.SendFailureEmail(fail_string, '')); 
  
		return set(FinalValue, Value);   
	end;
	
	export GeoState(string SetValues)	:=	function
		StateSet	:=	[	'AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI',
										'ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO',
										'MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA',
										'PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE',
										'AP','AA'];
									
		CleanSTR		:=	STD.Str.FilterOut(trim(SetValues, ALL), '\',"');	// remove any quotes/commas

		set of string GoodGeoStateSet	:=	fCheckValues(CleanSTR, StateSet, 2);
  
		return GoodGeoStateSet; 
	
	end;
	
	export CommonGeo(string SetGeo, integer DashCnt, string FailMsg)	:=	function
									
		CleanGeo	:=	STD.Str.FilterOut(trim(SetGeo, ALL), '\'"');		// remove any quotes

		GeoList 	:= 	dataset([{CleanGeo}], {string val});

		CountofValues	:= 	StringLib.StringFindCount(CleanGeo, ',') + 1;

		OutRec := record
			string Value;
			boolean Valid;
		end;

		OutRec NormIt(GeoList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanGeo, C);
			self.valid	:= if(StringLib.Stringfind(self.value, '-', DashCnt) = 0 and length(self.value)<>0,
													false,
													true
												);
		end;

		NormGeoValues	:= 	NORMALIZE(GeoList,CountofValues,NormIt(LEFT,COUNTER));
		
		InValidRecs			:=	NormGeoValues(not Valid);
		
		FinalValue :=  if(count(InValidRecs) <>	0
												, FAIL(NormGeoValues,99,FailMsg)
												,	NormGeoValues
											): FAILURE(mod_email.SendFailureEmail(FailMsg, '')); 

		return set(FinalValue, Value); 
	end;	

	export GeoStateCity(string SetStateCity)	:=	function

		string FailMsg	:=	'State or city is missing from the StateCity parameter. Please check parameter file values';
		
		CheckStateCity	:=	CommonGeo(SetStateCity, 1, FailMsg);
			
		return CheckStateCity; 

	end;

	export GeoStateCounty(string SetStateCounty)	:=	function
									
		string FailMsg		:=	'State or county is missing from the StateCounty parameter. Please check parameter file values';
		
		CheckStateCounty	:=	CommonGeo(SetStateCounty, 1, FailMsg);
			
		return CheckStateCounty; 
		
	end;
	
	export GeoStateCityCounty(string SetStateCityCounty)	:=	function
									
		string FailMsg				:=	'State, city or county is missing from the StateCityCounty parameter. Please check parameter file values';
		
		CheckStateCityCounty	:=	CommonGeo(SetStateCityCounty, 2, FailMsg);
			
		return CheckStateCityCounty;  

	end;
	
	export GeoStateCityCountyZip(string SetStateCityCountyZip)	:=	function

		string FailMsg					:=	'State, city, county or zip is missing from the StateCityCountyZip parameter. Please check parameter file values';
		
		CheckStateCityCountyZip	:=	CommonGeo(SetStateCityCountyZip, 3, FailMsg);
			
		return CheckStateCityCountyZip;  

	end;
	
	export GeoStateZip(string SetStateZip)	:=	function
		
		string FailMsg	:=	'State or zip is missing from the StateZip parameter. Please check parameter file values';
		
		CheckStateZip		:=	CommonGeo(SetStateZip, 1, FailMsg);
			
		return CheckStateZip;  

	end;
	
	export GeoStateCityZip(string SetStateCityZip)	:=	function

		string FailMsg		:=	'State, city or zip is missing from the StateCityZip parameter. Please check parameter file values';
		
		CheckStateCityZip	:=	CommonGeo(SetStateCityZip, 2, FailMsg);
			
		return CheckStateCityZip;  

	end;
	
	export GeoStateCountyZip(string SetStateCountyZip)	:=	function

		string FailMsg		:=	'State, county or zip is missing from the StateCountyZip parameter. Please check parameter file values';
		
		CheckStateCountyZip	:=	CommonGeo(SetStateCountyZip, 2, FailMsg);
			
		return CheckStateCountyZip;  

	end;
	
	export GeoZipCode(string SetZip)	:=	function
	
		CleanZip		:=	STD.Str.FilterOut(trim(SetZip, ALL), '\'"');		// remove any quotes

		ZipList 	:= 	dataset([{CleanZip}], {string val});

		CountOfZipValues	:= StringLib.StringFindCount(CleanZip, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(ZipList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanZip, C);
		end;

		NormZipValues := NORMALIZE(ZipList,CountOfZipValues,NormIt(LEFT,COUNTER));
									
		return set(NormZipValues, Value);
	end;	

	export RevenueRange(string SetRevenueRange)	:=	function
	
		CleanRevenueRange		:=	STD.Str.FilterOut(trim(SetRevenueRange, ALL), '\'"');		// remove any quotes

		RevenueRangeList	 	:= 	dataset([{CleanRevenueRange}], {string val});

		CountOfRangeValues	:= 	StringLib.StringFindCount(CleanRevenueRange, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(RevenueRangeList L, integer C) := TRANSFORM
			position		:=	stringlib.stringFind(CleanRevenueRange,'-',C);
			self.Value	:= 	StringLib.StringExtract(CleanRevenueRange, C);
		end;

		NormRevenueRangeValues := NORMALIZE(RevenueRangeList,CountOfRangeValues,NormIt(LEFT,COUNTER));
									
		return set(NormRevenueRangeValues, Value);
	end;	

	export RevenueGT(string SetRevenueGT)	:=	function
	
		CleanRevenueGT			:=	STD.Str.FilterOut(trim(SetRevenueGT, ALL), '\'"');		// remove any quotes

		RevenueGTList	 			:= 	dataset([{CleanRevenueGT}], {string val});

		CountOfGTValues			:= StringLib.StringFindCount(CleanRevenueGT, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(RevenueGTList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanRevenueGT, C);
		end;

		NormRevenueGTValues := NORMALIZE(RevenueGTList,CountOfGTValues,NormIt(LEFT,COUNTER));
									
		return set(NormRevenueGTValues, Value);
	end;

	export RevenueLT(string SetRevenueLT)	:=	function
	
		CleanRevenueLT			:=	STD.Str.FilterOut(trim(SetRevenueLT, ALL), '\'"');		// remove any quotes

		RevenueLTList	 			:= 	dataset([{CleanRevenueLT}], {string val});

		CountOfLTValues			:= StringLib.StringFindCount(CleanRevenueLT, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(RevenueLTList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanRevenueLT, C);
		end;

		NormRevenueLTValues := NORMALIZE(RevenueLTList,CountOfLTValues,NormIt(LEFT,COUNTER));
									
		return set(NormRevenueLTValues, Value);
	end;

	export IndustryPrimarySIC(string SetIndustryPrimarySIC)	:=	function
	
		CleanIndustryPrimarySIC			:=	STD.Str.FilterOut(trim(SetIndustryPrimarySIC, ALL), '\'"');		// remove any quotes

		IndustryPrimarySICList 			:= 	dataset([{CleanIndustryPrimarySIC}], {string val});

		CntIndustryPrimarySICValues	:= StringLib.StringFindCount(CleanIndustryPrimarySIC, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(IndustryPrimarySICList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanIndustryPrimarySIC, C);
		end;

		NormIndustryPrimarySICValues := NORMALIZE(IndustryPrimarySICList,CntIndustryPrimarySICValues,NormIt(LEFT,COUNTER));
									
		return set(NormIndustryPrimarySICValues, Value);
	end;

	export IndustryAllSIC(string SetIndustryAllSIC)	:=	function
	
		CleanIndustryAllSIC			:=	STD.Str.FilterOut(trim(SetIndustryAllSIC, ALL), '\'"');		// remove any quotes

		IndustryAllSICList 			:= 	dataset([{CleanIndustryAllSIC}], {string val});

		CntIndustryAllSICValues	:= StringLib.StringFindCount(CleanIndustryAllSIC, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(IndustryAllSICList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanIndustryAllSIC, C);
		end;

		NormIndustryAllSICValues := NORMALIZE(IndustryAllSICList,CntIndustryAllSICValues,NormIt(LEFT,COUNTER));
									
		return set(NormIndustryAllSICValues, Value);
	end;	
	
	export IndustryPrimaryNAICS(string SetIndustryPrimaryNAICS)	:=	function
	
		CleanIndustryPrimaryNAICS				:=	STD.Str.FilterOut(trim(SetIndustryPrimaryNAICS, ALL), '\'"');		// remove any quotes

		IndustryPrimaryNAICSList	 			:= 	dataset([{CleanIndustryPrimaryNAICS}], {string val});

		CntOfIndustryPrimaryNAICSValues	:= StringLib.StringFindCount(CleanIndustryPrimaryNAICS, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(IndustryPrimaryNAICSList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanIndustryPrimaryNAICS, C);
		end;

		NormIndustryPrimaryNAICSValues 	:= NORMALIZE(IndustryPrimaryNAICSList,CntOfIndustryPrimaryNAICSValues,NormIt(LEFT,COUNTER));
									
		return set(NormIndustryPrimaryNAICSValues, Value);
	end;
	
	export IndustryAllNAICS(string SetIndustryAllNAICS)	:=	function
	
		CleanIndustryAllNAICS				:=	STD.Str.FilterOut(trim(SetIndustryAllNAICS, ALL), '\'"');		// remove any quotes

		IndustryAllNAICSList	 			:= 	dataset([{CleanIndustryAllNAICS}], {string val});

		CntOfIndustryAllNAICSValues	:= StringLib.StringFindCount(CleanIndustryAllNAICS, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(IndustryAllNAICSList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanIndustryAllNAICS, C);
		end;

		NormIndustryAllNAICSValues 	:= NORMALIZE(IndustryAllNAICSList,CntOfIndustryAllNAICSValues,NormIt(LEFT,COUNTER));
									
		return set(NormIndustryAllNAICSValues, Value);
	end;

	export EmployeeRange(string SetEmployeeRange)	:=	function
	
		CleanEmployeeRange		:=	STD.Str.FilterOut(trim(SetEmployeeRange, ALL), '\'"');		// remove any quotes

		EmployeeRangeList	 	:= 	dataset([{CleanEmployeeRange}], {string val});

		CountOfRangeValues	:= 	StringLib.StringFindCount(CleanEmployeeRange, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(EmployeeRangeList L, integer C) := TRANSFORM
			position		:=	stringlib.stringFind(CleanEmployeeRange,'-',C);
			self.Value	:= 	StringLib.StringExtract(CleanEmployeeRange, C);
		end;

		NormEmployeeRangeValues := NORMALIZE(EmployeeRangeList,CountOfRangeValues,NormIt(LEFT,COUNTER));
									
		return set(NormEmployeeRangeValues, Value);
	end;	

	export EmployeeGT(string SetEmployeeGT)	:=	function
	
		CleanEmployeeGT			:=	STD.Str.FilterOut(trim(SetEmployeeGT, ALL), '\'"');		// remove any quotes

		EmployeeGTList	 			:= 	dataset([{CleanEmployeeGT}], {string val});

		CountOfGTValues			:= StringLib.StringFindCount(CleanEmployeeGT, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(EmployeeGTList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanEmployeeGT, C);
		end;

		NormEmployeeGTValues := NORMALIZE(EmployeeGTList,CountOfGTValues,NormIt(LEFT,COUNTER));
									
		return set(NormEmployeeGTValues, Value);
	end;

	export EmployeeLT(string SetEmployeeLT)	:=	function
	
		CleanEmployeeLT			:=	STD.Str.FilterOut(trim(SetEmployeeLT, ALL), '\'"');		// remove any quotes

		EmployeeLTList	 			:= 	dataset([{CleanEmployeeLT}], {string val});

		CountOfLTValues			:= StringLib.StringFindCount(CleanEmployeeLT, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(EmployeeLTList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanEmployeeLT, C);
		end;

		NormEmployeeLTValues := NORMALIZE(EmployeeLTList,CountOfLTValues,NormIt(LEFT,COUNTER));
									
		return set(NormEmployeeLTValues, Value);
	end;
	
	export BusYearsRange(string SetBusYearsRange)	:=	function
	
		CleanBusYearsRange		:=	STD.Str.FilterOut(trim(SetBusYearsRange, ALL), '\'"');		// remove any quotes

		BusYearsRangeList	 	:= 	dataset([{CleanBusYearsRange}], {string val});

		CountOfRangeValues	:= 	StringLib.StringFindCount(CleanBusYearsRange, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(BusYearsRangeList L, integer C) := TRANSFORM
			position		:=	stringlib.stringFind(CleanBusYearsRange,'-',C);
			self.Value	:= 	StringLib.StringExtract(CleanBusYearsRange, C);
		end;

		NormBusYearsRangeValues := NORMALIZE(BusYearsRangeList,CountOfRangeValues,NormIt(LEFT,COUNTER));
									
		return set(NormBusYearsRangeValues, Value);
	end;	

	export BusYearsGT(string SetBusYearsGT)	:=	function
	
		CleanBusYearsGT			:=	STD.Str.FilterOut(trim(SetBusYearsGT, ALL), '\'"');		// remove any quotes

		BusYearsGTList	 			:= 	dataset([{CleanBusYearsGT}], {string val});

		CountOfGTValues			:= StringLib.StringFindCount(CleanBusYearsGT, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(BusYearsGTList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanBusYearsGT, C);
		end;

		NormBusYearsGTValues := NORMALIZE(BusYearsGTList,CountOfGTValues,NormIt(LEFT,COUNTER));
									
		return set(NormBusYearsGTValues, Value);
	end;

	export BusYearsLT(string SetBusYearsLT)	:=	function
	
		CleanBusYearsLT			:=	STD.Str.FilterOut(trim(SetBusYearsLT, ALL), '\'"');		// remove any quotes

		BusYearsLTList	 			:= 	dataset([{CleanBusYearsLT}], {string val});

		CountOfLTValues			:= StringLib.StringFindCount(CleanBusYearsLT, ',') + 1;

		OutRec := record
			string Value;
		end;

		OutRec NormIt(BusYearsLTList L, integer C) := TRANSFORM
			self.Value	:= StringLib.StringExtract(CleanBusYearsLT, C);
		end;

		NormBusYearsLTValues := NORMALIZE(BusYearsLTList,CountOfLTValues,NormIt(LEFT,COUNTER));
									
		return set(NormBusYearsLTValues, Value);
	end;
	
end;