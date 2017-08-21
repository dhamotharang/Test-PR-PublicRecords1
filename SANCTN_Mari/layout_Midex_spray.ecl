export layout_Midex_spray := Module

export recIncident := record
		STRING8 	BATCH{xpath('BATCH')};
		STRING10 	BATCHDATE{xpath('BATCHDATE')};				// Date loaded to MIDEX. fmt MM/DD/YYYY
		STRING1 	DBCODE{xpath('DBCODE')};							// N=Non-public, F=FreddieMac
		INTEGER 	INCIDENT_NO{xpath('INCIDENT_NO')};		// Use to link to PARTYDATA
		STRING10 	INCDT{xpath('INCDT')};								// fmt MM/DD/YY does not contain leading zeroes for month or day
		STRING8 	BILLING_CODE{xpath('BILLING_CODE')};	// Feddie Mac only field
		STRING20 	CASE_NUMBER{xpath('CASE_NUMBER')};		// Feddie Mac only field
		STRING70 	JURISDICTION{xpath('JURIS')};					// Feddie Mac only field
		STRING70 	AGENCY{xpath('AGENCY')};						 	// Feddie Mac only field
		STRING70 	SOURCE_DOC{xpath('SOURCE_DOC')};			// Feddie Mac only field
		STRING17 	SOURCE_REF{xpath('SOURCE_REF')};			// Non-Public only field		
		STRING70 	ADDINF{xpath('ADDINF')};							// Text field: Feddie Mac only field
		INTEGER 	INTPK{xpath('INTPK')};								// Link to INTERNALCODE
		STRING10 	MODIFY_DATE{xpath('MODIFIED')};				// Last Modified Date, fmt MM/DD/YYYY
		STRING10 	ENTRY_DATE{xpath('ENTRY_DATE')};			// Date the incident was entered: Non-Public only field		
		STRING45 	MEMBER_NAME{xpath('MEMBER_NAME')};		// Name of submitting institution; Non-Public only field		
		STRING45 	SUBMITTER{xpath('SUBMITTER')};				// Name of submitter; Non-Public only field				
		STRING13 	SUBMIT_PHONE{xpath('SUBMIT_PHONE')};	// Non-Public only field		
		STRING20 	SUBMIT_PHONE_FAX{xpath('FAXNUMBER')};	// Non-Public only field		
		STRING80	SUBMIT_EMAIL{xpath('EMAIL_ADDR')};		// Non-Public only field		
		STRING100 PROP_ADDRESS{xpath('PROP_ADDR')};	// Address of the property the incident is referencing; Non-Public only field
		STRING45 	PROP_CITY{xpath('PROP_CITY')};        // Non-Public only field
		STRING2 	PROP_STATE{xpath('PROP_STATE')};      // Non-Public only field
		STRING10 	PROP_ZIP{xpath('PROP_ZIP')};          // Non-Public only field
end;
export recParty := record
		STRING8 	BATCH{xpath('BATCH')};
		STRING1 	DBCODE{xpath('DBCODE')};
		INTEGER 	INCIDENT_NO{xpath('INCIDENT_NO')};
		STRING7 	NUMBER{xpath('NUMBER')};									// Originator designated by NUMBER=0
		STRING 		SANCTIONS{xpath('SANCTIONS')};					// Feddie Mac Only
		STRING 		INFO{xpath('INFO')};										// Text field: Feddie Mac only
		STRING150 COMPANY{xpath('COMPANY')};
		STRING10 	TIN{xpath('TIN')};
		STRING50 	FIRSTNAME{xpath('FIRSTNAME')};
		STRING50 	LASTNAME{xpath('LASTNAME')};
		STRING50 	MIDDLENAME{xpath('MIDDLENAME')};
		STRING10 	SUFFIX{xpath('SUFFIX')};
		STRING45 	POSITION_TITLE{xpath('POSITION_TITLE')};
		STRING150 EMPLOYER{xpath('EMPLOYER')};
		STRING11 	SSN{xpath('SSN')};
		STRING10 	DOB{xpath('DOB')};
		STRING45 	ADDRESS{xpath('ADDRESS')};
		STRING30 	CITY{xpath('CITY')};
		STRING2 	STATE{xpath('STATE')};
		STRING10 	ZIP{xpath('ZIP')};
		INTEGER 	PARTYPK{xpath('PARTYPK')};									// Link to PROFESSIONCODE,LICENSECODE
		INTEGER 	INTPK{xpath('INTPK')};	
		STRING20	PHONE{xpath('PHONE')};											// new field
		STRING500 AKANAME{xpath('AKANAME')};									// new field
		STRING500	DBANAME{xpath('DBANAME')};									// new field

end;

export recCode := record
		STRING8 	BATCH{xpath('BATCH')};
		STRING1 	DBCODE{xpath('DBCODE')};
		INTEGER 	INCIDENT_NO{xpath('INCIDENT_NO')};			// Link to INCIDENTDATA
		STRING7 	NUMBER{xpath('NUMBER')};
		STRING20 	FIELDNAME{xpath('FIELDNAME')};					// LICENSECODE, INTERNALCODE, PROFESSIONCODE
		INTEGER 	PKID{xpath('PKID')};										
		INTEGER 	FKID{xpath('FKID')};										// Party PK or IntPK link to INTERNALCODE; also can use INCIDENT_NUMER + NUMBER
		STRING20 	CODETYPE{xpath('CODETYPE')};						// LICENSECODE(license type), INTERNALCODE(verification or incident; do not display), PROFESSIONCODE(blank)
		STRING20 	CODEVALUE{xpath('CODEVALUE')};					// LICENSECODE(license_number), INTERNALCODE('verfication','incident'),PROFESSIONCODE(profession ocde) 
		STRING80 	CODEDESC{xpath('CODEDESC')};						// NOT USED
		STRING10 	CODESTATE{xpath('CODESTATE')};					// LICENSECODE(license state)
		STRING500 OTHERDESC{xpath('OTHERDESC')};					// PROFESSIONCODE(addl information for CODEVALUE), INTERNALCODE(addl info for Verification/Incident code)
end;

export recIncidentText := record
		STRING8 	BATCH{xpath('BATCH')};
		STRING1 	DBCODE{xpath('DBCODE')};
		INTEGER 	INCIDENT_NO{xpath('INCIDENT_NO')};			// Link to INCIDENTDATA
		STRING20 	FIELDNAME{xpath('FIELDNAME')};					// INCIDENT_TEXT, OTHERINFO, INCIDENT_RESPONSE
		STRING3  	SEQ{xpath('SEQ')};											// Order to display the text of this FIELDNAME
		STRING 		TXT{xpath('TXT')};											//There will be a tilde(~) at the end of the paragrapj if there was a CR in the text
end;

export recPartyText := record
		STRING8 	BATCH{xpath('BATCH')};
		STRING1 	DBCODE{xpath('DBCODE')};
		INTEGER 	INCIDENT_NO{xpath('INCIDENT_NO')};			
		STRING7 	NUMBER{xpath('NUMBER')};
		STRING20 	FIELDNAME{xpath('FIELDNAME')};					// FIELDNAME= OTHERINFO; Typically AKA's
		STRING3 	SEQ{xpath('SEQ')};
		STRING 		TXT{xpath('TXT')};
end;

export recBatch := record
		STRING BATCH{xpath('BATCH')};
		STRING DBF{xpath('DBF')};
		STRING LOAD_DATE{xpath('LOAD_DATE')};
End;


export recPartyAkaDba := record
		STRING8 	BATCH{xpath('BATCH')};					// Name of Batch
		STRING1 	DBCODE{xpath('DBCODE')};				// Either N=Non-Public or F=Feddie
		INTEGER 	INCIDENT_NO{xpath('INCIDENT_NO')};			// Incident Number
		STRING7 	NUMBER{xpath('NUMBER')};								// Party Number (Note: Party Number = 0 is the originator of Record)
		STRING1 	NAME_TYPE{xpath('NAMETYPE')};						// A=AKA, D=DBA
		STRING50 	FIRST_NAME{xpath('FIRSTNAME')};
		STRING50 	LAST_NAME{xpath('LASTNAME')};
		STRING50 	MIDDLE_NAME{xpath('MIDDLENAME')};
		STRING100 COMPANY{xpath('COMPANY')};
		INTEGER 	PARTYPK{xpath('PARTYPK')};							// (Don't need since you can join by INCIDENT_NO + NUMBER)
end;


export ref_license_type := record
		string	LICENSE_TYPE;
		string  LICENSE_DESCRIPTION;
		string	SRCE_UPDT;
		string	CREATE_DT;
end;


export ref_position_title := record
		string	POSITION_TITLE;
		string  STD_POSITION_TTL;
		string	SRCE_UPDT;
		string	CREATE_DT;
end;

export ref_incident_code := record
		string5		code;
		string100 text;
end;

end;