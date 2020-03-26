import corp2_mapping, corp2_raw_NE, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		//-------------------------------------    
		// Corporation Entity Input
		//-------------------------------------
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.CorpEntity, Corp2_Raw_NE.Layouts.jsonInputLayout, dCorpEntity,
		                     'CSV',,,pTerminator := ['},{'], pSeparator := '');
	
		// Parse into individual records in JSON format 
		clnCorpEntity := project(dCorpEntity.logical ,transform(Corp2_Raw_NE.Layouts.jsonInputLayout,
														self.jsonData := if(left.jsonData[1] = '['
																							 ,stringlib.stringfilterout(left.jsonData+'}','[]')
																							 ,regexreplace('\\}\\}',stringlib.stringfilterout('{"'+left.jsonData+'}','[]'),'}'))
																		));

		// Convert JSON into Layout 
		fmtCorpEntity := project(clnCorpEntity ,transform(Corp2_Raw_NE.Layouts.CorpEntityLayoutIn
																,Corp2_Raw_NE.Layouts.CorpEntityLayoutIn fields1:= FROMJSON(Corp2_Raw_NE.Layouts.CorpEntityLayoutIn
																,left.jsonData
																,trim, ONFAIL(transform(Corp2_Raw_NE.Layouts.CorpEntityLayoutIn
																,self.AcctNumber:=failmessage
																,SELF:=[]
															)));
														SELF := fields1;
														SELF := LEFT
														 ));

		EXPORT CorpEntity := fmtCorpEntity(not(regexfind('error',AcctNumber,nocase)));
		
		
		//-------------------------------------    
		// Corporate Officers Input
		//-------------------------------------
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.CorpOfficers, Corp2_Raw_NE.Layouts.jsonInputLayout, dCorpOfficers,
		                     'CSV',,,pTerminator := ['},{'], pSeparator := '');
	
		// Parse into individual records in JSON format 
		clnCorpOfficers := project(dCorpOfficers.logical ,transform(Corp2_Raw_NE.Layouts.jsonInputLayout,
														self.jsonData := if(left.jsonData[1] = '['
																							 ,stringlib.stringfilterout(left.jsonData+'}','[]')
																							 ,regexreplace('\\}\\}',stringlib.stringfilterout('{"'+left.jsonData+'}','[]'),'}'))
																		));

		// Convert JSON into Layout 
		fmtCorpOfficers := project(clnCorpOfficers ,transform(Corp2_Raw_NE.Layouts.CorpOfficersLayoutIn
																,Corp2_Raw_NE.Layouts.CorpOfficersLayoutIn fields1:= FROMJSON(Corp2_Raw_NE.Layouts.CorpOfficersLayoutIn
																,left.jsonData
																,trim, ONFAIL(transform(Corp2_Raw_NE.Layouts.CorpOfficersLayoutIn
																,self.AcctNumber:=failmessage
																,SELF:=[]
															)));
														SELF := fields1;
														SELF := LEFT
														 ));

		EXPORT CorpOfficers := fmtCorpOfficers(DateTakingOffice <> '0001-01-01T00:00:00' and not(regexfind('error',AcctNumber,nocase)));	
	
	
		//-------------------------------------    
		// Corporate Actions Input
		//-------------------------------------
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.CorpActions, Corp2_Raw_NE.Layouts.jsonInputLayout, dCorpActions,
		                     'CSV',,,pTerminator := ['},{'], pSeparator := '');
	
		// Parse into individual records in JSON format 
		clnCorpActions := project(dCorpActions.logical ,transform(Corp2_Raw_NE.Layouts.jsonInputLayout,
														self.jsonData := if(left.jsonData[1] = '['
																							 ,stringlib.stringfilterout(left.jsonData+'}','[]')
																							 ,regexreplace('\\}\\}',stringlib.stringfilterout('{"'+left.jsonData+'}','[]'),'}'))
																		));

		// Convert JSON into Layout 
		fmtCorpActions := project(clnCorpActions ,transform(Corp2_Raw_NE.Layouts.CorpActionsLayoutIn
																,Corp2_Raw_NE.Layouts.CorpActionsLayoutIn fields1:= FROMJSON(Corp2_Raw_NE.Layouts.CorpActionsLayoutIn
																,left.jsonData
																,trim, ONFAIL(transform(Corp2_Raw_NE.Layouts.CorpActionsLayoutIn
																,self.AcctNumber:=failmessage
																,SELF:=[]
															)));
														SELF := fields1;
														SELF := LEFT
														 ));

		EXPORT CorpActions := fmtCorpActions(not(regexfind('error',AcctNumber,nocase)));
		
											 
		//-------------------------------------    
		// Registered Agent Input
		//-------------------------------------
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.RegisteredAgent, Corp2_Raw_NE.Layouts.jsonInputLayout, dRegisteredAgent,
		                     'CSV',,,pTerminator := ['},{'], pSeparator := '');
	
		// Parse into individual records in JSON format 
		clnRegisteredAgent := project(dRegisteredAgent.logical ,transform(Corp2_Raw_NE.Layouts.jsonInputLayout,
														self.jsonData := if(left.jsonData[1] = '['
																							 ,stringlib.stringfilterout(left.jsonData+'}','[]')
																							 ,regexreplace('\\}\\}',stringlib.stringfilterout('{"'+left.jsonData+'}','[]'),'}'))
																		));

		// Convert JSON into Layout 
		fmtRegisteredAgent := project(clnRegisteredAgent ,transform(Corp2_Raw_NE.Layouts.RegisteredAgentLayoutIn
																,Corp2_Raw_NE.Layouts.RegisteredAgentLayoutIn fields1:= FROMJSON(Corp2_Raw_NE.Layouts.RegisteredAgentLayoutIn
																,left.jsonData
																,trim, ONFAIL(transform(Corp2_Raw_NE.Layouts.RegisteredAgentLayoutIn
																,self.AcctNumber:=failmessage
																,SELF:=[]
															)));
														SELF := fields1;
														SELF := LEFT
														 ));

		EXPORT RegisteredAgent := fmtRegisteredAgent(not(regexfind('error',AcctNumber,nocase)));										 

		
		//-------------------------------------    
		// Corporation Type Lookup Table  
		//-------------------------------------
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.CorpTypeTable, Corp2_Raw_NE.Layouts.jsonInputLayout, dCorpType,
		                     'CSV',,,pTerminator := ['},{'], pSeparator := '');
	
		// Parse into individual records in JSON format 
		clnCorpType := project(dCorpType.logical ,transform(Corp2_Raw_NE.Layouts.jsonInputLayout,
														self.jsonData := if(left.jsonData[1] = '['
																							 ,stringlib.stringfilterout(left.jsonData+'}','[]')
																							 ,regexreplace('\\}\\}',stringlib.stringfilterout('{"'+left.jsonData+'}','[]'),'}'))
																		));

		// Convert JSON into Layout 
		fmtCorpType := project(clnCorpType ,transform(Corp2_Raw_NE.Layouts.CorpTypeLayoutIn
																,Corp2_Raw_NE.Layouts.CorpTypeLayoutIn fields1:= FROMJSON(Corp2_Raw_NE.Layouts.CorpTypeLayoutIn
																,left.jsonData
																,trim, ONFAIL(transform(Corp2_Raw_NE.Layouts.CorpTypeLayoutIn
																,self.Description:=failmessage
																,SELF:=[]
															)));
														SELF := fields1;
														SELF := LEFT
														 ));

		EXPORT CorpTypeTable := fmtCorpType(not(regexfind('error',Description,nocase)));	
		
		
		//-------------------------------------    
		// Country Codes Lookup Table  
		//-------------------------------------
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.CountryCodesTable, Corp2_Raw_NE.Layouts.jsonInputLayout, dCountryCodes,
		                     'CSV',,,pTerminator := ['},{'], pSeparator := '');
	
		// Parse into individual records in JSON format 
		clnCountryCodes := project(dCountryCodes.logical ,transform(Corp2_Raw_NE.Layouts.jsonInputLayout,
														self.jsonData := if(left.jsonData[1] = '['
																							 ,stringlib.stringfilterout(left.jsonData+'}','[]')
																							 ,regexreplace('\\}\\}',stringlib.stringfilterout('{"'+left.jsonData+'}','[]'),'}'))
																		));

		// Convert JSON into Layout 
		fmtCountryCodes := project(clnCountryCodes ,transform(Corp2_Raw_NE.Layouts.CountryCodesLayoutIn
																,Corp2_Raw_NE.Layouts.CountryCodesLayoutIn fields1:= FROMJSON(Corp2_Raw_NE.Layouts.CountryCodesLayoutIn
																,left.jsonData
																,trim, ONFAIL(transform(Corp2_Raw_NE.Layouts.CountryCodesLayoutIn
																,self.Description:=failmessage
																,SELF:=[]
															)));
														SELF := fields1;
														SELF := LEFT
														 ));

		EXPORT CountryCodesTable := fmtCountryCodes(not(regexfind('error',Description,nocase)));	
	
		
		//-------------------------------------    
		// List of States Lookup Table  
		//-------------------------------------
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.ListOfStatesTable, Corp2_Raw_NE.Layouts.jsonInputLayout, dListOfStates,
		                     'CSV',,,pTerminator := ['},{'], pSeparator := '');
	
		// Parse into individual records in JSON format 
		clnListOfStates := project(dListOfStates.logical ,transform(Corp2_Raw_NE.Layouts.jsonInputLayout,
														self.jsonData := if(left.jsonData[1] = '['
																							 ,stringlib.stringfilterout(left.jsonData+'}','[]')
																							 ,regexreplace('\\}\\}',stringlib.stringfilterout('{"'+left.jsonData+'}','[]'),'}'))
																		));

		// Convert JSON into Layout 
		fmtListOfStates := project(clnListOfStates ,transform(Corp2_Raw_NE.Layouts.ListOfStatesLayoutIn
																,Corp2_Raw_NE.Layouts.ListOfStatesLayoutIn fields1:= FROMJSON(Corp2_Raw_NE.Layouts.ListOfStatesLayoutIn
																,left.jsonData
																,trim, ONFAIL(transform(Corp2_Raw_NE.Layouts.ListOfStatesLayoutIn
																,self.Description:=failmessage
																,SELF:=[]
															)));
														SELF := fields1;
														SELF := LEFT
														 ));

		EXPORT ListOfStatesTable := fmtListOfStates(not(regexfind('error',Description,nocase)));
 /*		
		//-----------------------------------------------------------------------------------------------------    
		// Filing Type Lookup Table  -- Not currently being used in the mapper but leaving here for future use 
		//------------------------------------------------------------------------------------------------------
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.FilingTypeTable, Corp2_Raw_NE.Layouts.jsonInputLayout, dFilingType,
		                     'CSV',,,pTerminator := ['},{'], pSeparator := '');
	
		// Parse into individual records in JSON format 
		clnFilingType := project(dFilingType.logical ,transform(Corp2_Raw_NE.Layouts.jsonInputLayout,
														self.jsonData := if(left.jsonData[1] = '['
																							 ,stringlib.stringfilterout(left.jsonData+'}','[]')
																							 ,regexreplace('\\}\\}',stringlib.stringfilterout('{"'+left.jsonData+'}','[]'),'}'))
																		));

		// Convert JSON into Layout 
		fmtFilingType := project(clnFilingType ,transform(Corp2_Raw_NE.Layouts.FilingTypeLayoutIn
																,Corp2_Raw_NE.Layouts.FilingTypeLayoutIn fields1:= FROMJSON(Corp2_Raw_NE.Layouts.FilingTypeLayoutIn
																,left.jsonData
																,trim, ONFAIL(transform(Corp2_Raw_NE.Layouts.FilingTypeLayoutIn
																,self.Description:=failmessage
																,SELF:=[]
															)));
														SELF := fields1;
														SELF := LEFT
														 ));

		EXPORT FilingTypeTable := fmtFilingType(not(regexfind('error',Description,nocase)));	

		//------------------------------------------------------------------------------------------------------    
		// Position Held Lookup Table -- Not currently being used in the mapper but leaving here for future use
		//------------------------------------------------------------------------------------------------------
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.PositionHeldTable, Corp2_Raw_NE.Layouts.jsonInputLayout, dPositionHeld,
		                     'CSV',,,pTerminator := ['},{'], pSeparator := '');
	
		// Parse into individual records in JSON format 
		clnPositionHeld := project(dPositionHeld.logical ,transform(Corp2_Raw_NE.Layouts.jsonInputLayout,
														self.jsonData := if(left.jsonData[1] = '['
																							 ,stringlib.stringfilterout(left.jsonData+'}','[]')
																							 ,regexreplace('\\}\\}',stringlib.stringfilterout('{"'+left.jsonData+'}','[]'),'}'))
																		));

		// Convert JSON into Layout 
		fmtPositionHeld := project(clnPositionHeld ,transform(Corp2_Raw_NE.Layouts.PositionHeldLayoutIn
																,Corp2_Raw_NE.Layouts.PositionHeldLayoutIn fields1:= FROMJSON(Corp2_Raw_NE.Layouts.PositionHeldLayoutIn
																,left.jsonData
																,trim, ONFAIL(transform(Corp2_Raw_NE.Layouts.PositionHeldLayoutIn
																,self.Description:=failmessage
																,SELF:=[]
															)));
														SELF := fields1;
														SELF := LEFT
														 ));

		EXPORT PositionHeldTable := fmtPositionHeld(not(regexfind('error',Description,nocase)));	
*/	    	 				
	END;

END;