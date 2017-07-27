import AutoStandardI, iesp;

export IParam := MODULE

	export CommonParams := interface(AutoStandardI.InterfaceTranslator.glb_purpose.params,
																	 AutoStandardI.InterfaceTranslator.dppa_purpose.params,
																	 AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
																	 AutoStandardI.InterfaceTranslator.phonetics.params,
																	 AutoStandardI.InterfaceTranslator.strictmatch_value.params)
		export unicode100 uFullName;		
		export unicode20 uFirstName;
		export unicode20 uMiddleName;
		export unicode20 uPaternalName;
		export unicode20 uMaternalName;		
		
		export string20 sFirstName;
		export string20 sMiddleName;		
		export string20 sPaternalName;		
		export string20 sMaternalName;		
	end;

	export DocketSearchParams := INTERFACE(CommonParams)
		export unsigned8 UniqueId;
		export string1   InputGender;
		export string20  DocketType;
		export unsigned2 DocketPubYear;
		export string50	 DocketNumber;
		export set of string3 DocketStateCodes;
	end;
	
	export ProfessionSearchParams := INTERFACE(CommonParams)
		export unsigned8 UniqueId;
		export string1   InputGender;
		export unsigned1 Category;
	end;
	
	export SetInputName (iesp.internationaldocket.t_InternationalName xml_in) := FUNCTION
    unicode50 First 		:= global(xml_in).First;
    unicode50 Middle 		:= global(xml_in).Middle;
    unicode50 Paternal 	:= global(xml_in).PaternalLast;
    unicode50 Maternal 	:= global(xml_in).MaternalLast;
    unicode5 	Suffix 		:= global(xml_in).Suffix;
    unicode100 Full 		:= global(xml_in).Full;

    #stored ('FullName', Full);		
    #stored ('FirstName', First);
    #stored ('MiddleName', Middle);
    #stored ('PaternalName', Paternal);
    #stored ('MaternalName', Maternal);
    #stored ('namesuffix', Suffix);

    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;	
	
	export SetInputDocketSearchBy (iesp.internationaldocket.t_InternationalDocketSearchBy searchBy) := FUNCTION
		SetInputName(global(searchBy).Name);	
		#stored('UniqueId', searchBy.UniqueId);
		#stored('DocketType', searchBy._type);
		#stored('Gender', searchBy.Gender);
		#stored('DocketPubYear', searchBy.DocketYear);
		#stored('DocketNumber', searchBy.DocketNumber);
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
  
	export SetInputDocketSearchOptions (iesp.internationaldocket.t_InternationalDocketOption options) := FUNCTION	
		iesp.ECL2ESP.SetInputSearchOptions(options);	  
		iesp.ECL2ESP.Marshall.Mac_Set(options);
		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  end;

	export SetInputProfessionSearchBy (iesp.internationalprofcert.t_InternationalProfCertificationSearchBy searchBy) := FUNCTION
		SetInputName(global(searchBy).Name);		
		#stored('UniqueId', searchBy.UniqueId);
		#stored('Category', searchBy.Category);
		#stored('Gender', searchBy.Gender);
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
  	
	export SetInputProfessionSearchOptions (iesp.internationalprofcert.t_InternationalProfCertificationOption options) := FUNCTION	
		iesp.ECL2ESP.SetInputSearchOptions(options);	  
		iesp.ECL2ESP.Marshall.Mac_Set(options);		
		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  end;

end;