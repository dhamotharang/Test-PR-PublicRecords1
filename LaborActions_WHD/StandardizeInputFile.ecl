IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, idl_header;

EXPORT StandardizeInputFile := module
	
	EXPORT fPreProcess(DATASET(LaborActions_WHD.Layouts.Input) pRawFileInput, string pversion) := FUNCTION
		
		LaborActions_WHD.Layouts.temp tPROJECTAddress(LaborActions_WHD.Layouts.Input l) := TRANSFORM
			SELF.Append_MailAddress1		:= StringLib.StringCleanSpaces(TRIM(StringLib.StringToUpperCase(L.Address1)));
			SELF.Append_MailAddressLast	:= IF (L.City!='',
																				StringLib.StringCleanSpaces(TRIM(StringLib.StringToUpperCase(L.City)) + ', ' + TRIM(L.EmployerState) + ' ' + TRIM(L.ZipCode[1..5])),
																				StringLib.StringCleanSpaces(TRIM(L.EmployerState) + ' ' + TRIM(L.ZipCode[1..5])) ); 
			SELF.EmployerName					  := StringLib.StringToUpperCase(l.EmployerName);
			SELF.Address1				    	  := StringLib.StringToUpperCase(l.Address1);
			SELF.City					          := StringLib.StringToUpperCase(l.City);
			//SELF.Append_MailRawAID		:=	0;
			SELF												:= 	L;
			SELF												:= [];
		END;
      
		dPreProcess   := PROJECT(pRawFileInput, tPROJECTAddress(left));
      
		RETURN dPreProcess;
  END;

	EXPORT fAll( DATASET(LaborActions_WHD.Layouts.Input)  pRawFileInput, string pversion) := FUNCTION
   	dPreProcess	 := fPreProcess (pRawFileInput,pversion);
	      
		#IF(_flags.UseStandardizePersists)
			dAppendBusinessInfo  := dPreProcess : persist(Persistnames.standardizeInput);
		#else
			dAppendBusinessInfo  := dPreProcess;
		#end
      
		RETURN dAppendBusinessInfo;
	END;
		
END;