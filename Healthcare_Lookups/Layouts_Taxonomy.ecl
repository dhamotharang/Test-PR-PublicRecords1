EXPORT Layouts_Taxonomy := Module
	Export Layout_Taxonomy := RECORD
		string10		Code;
		string10		HMSCode;
		string100		PractitionerType;
		string100		Grouping;
		string100		Classification;
		string100		Specialization;
		string30		LastLetterDescription;
		string10  	EffectiveDate;
		string10  	DeactivationDate;
		string10  	LastModifiedDate;
	END;	
		
	Export Layout_Taxonomy_Notes := RECORD
		string10		Code;
		string300		Notes;
	END;	
	Export Layout_Taxonomy_Definition := RECORD
		string10		Code;
		string2500	Definition;
	END;	
	Export BatchIn := Record
		string20 	Acctno := '';
		string10	Code := '';
		string10	HMSCode := '';
		string100	Grouping := '';
		string100	Classification := '';
		string100	Specialization := '';
		Boolean 	IncludeNotes := false;
		Boolean 	IncludeDefinition := false;
	end;
	Export BatchOut := Record
		string20 		Acctno := '';
		string10		Code := '';
		string10		HMSCode := '';
		string100		Grouping := '';
		string100		Classification := '';
		string100		Specialization := '';
		string30		LastLetterDescription;
		string10  	EffectiveDate;
		string10  	DeactivationDate;
		string10  	LastModifiedDate;
		string300		Notes := '';
		string2500	Definition := '';
	end;
	Export Layout_NameCredentials := RECORD
		string10		Credential;
		string100		Credential_Desc;
		string10		Taxonomy;
	END;	
	Export SpecialtyList := Record
		string100		Specialty := '';
	end;
	Export SpecialtyBest := Record
		Integer4		Score := 0;
		string100		Specialty := '';
	end;
	Export ClassificationList := Record
		BatchOut.Classification;
	end;
	Export SpecializationList := Record
		BatchOut.Classification;
		BatchOut.Specialization;
	end;
End;