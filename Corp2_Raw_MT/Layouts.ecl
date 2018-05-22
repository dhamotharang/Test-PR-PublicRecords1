EXPORT Layouts := MODULE

	EXPORT VendorRawLayoutIn								:= RECORD
		STRING  payload;										
	END;
	
 	// Record Type  = ABN
	EXPORT FileABNLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  BusinessEntityName;
		STRING  RegistrationDate;
		STRING  RenewalDate;
		STRING  ExpirationDate;
		STRING  EntityStatusDescription;
		STRING  EntityStatusChangeReason;
		STRING  BusinessDescription;
	END;

 	
  // Record Type  = BE-CORP
  EXPORT FileBECORPLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  BusinessEntityName;
		STRING  BusinessEntityType;
		STRING  BusinessEntitySubType;
		STRING  IncorporationDate;
		STRING  QualificationDate;
		STRING  TermOfExistence;	
		STRING  ExpirationDate;
		STRING  EntityStatusDescription;
		STRING  InactiveReason;
		STRING  InactiveDate;
		STRING  ReviverReinstatementDate;
		STRING  BusinessMailingAddress1;
		STRING  BusinessMailingAddress2;
		STRING  BusinessMailingAddress3;
		STRING  BusinessMailingAddress4;  //City
		STRING  BusinessMailingAddress5;  //State
		STRING  BusinessMailingAddress6;  //Zip Code
		STRING  BusinessMailingAddress7;  //Country
		STRING  Purpose;
		STRING  TribalDesignation;
		STRING  StateOrCountryOfJurisdiction;
		STRING  NoticeDate;
		STRING  InvoluntaryDissolutionIntentDate;
		STRING  ARLastFiledDate;
		STRING  SuspensionDate;
	END;

  // Record Type  = BE-LLC
	EXPORT FileBELLCLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  BusinessEntityName;
		STRING  BusinessEntityType;
		STRING  BusinessEntitySubType;
		STRING  OrganizationDate;
		STRING  QualificationOfAForeignLLCInMontana;
		STRING  TermOfExistence;	
		STRING  ExpirationDate;
		STRING  EntityStatusDescription;
		STRING  EntityStatusChangeReason;
		STRING  InactiveDate;
		STRING  ReviverReinstatementDate;
		STRING  ManagementType;
		STRING  TribalDesignation;
		STRING  BusinessMailingAddress1;
		STRING  BusinessMailingAddress2;
		STRING  BusinessMailingAddress3;
		STRING  BusinessMailingAddress4;  //City
		STRING  BusinessMailingAddress5;  //State
		STRING  BusinessMailingAddress6;  //Zip Code
		STRING  BusinessMailingAddress7;  //Country
		STRING  Purpose;
		STRING  StateOrCountryOfJurisdiction;
		STRING  NoticeDate;
		STRING  InvoluntaryDissolutionIntentDate;
		STRING  ARLastFiledDate;
		STRING  SuspensionDate;
	END;

 	// Record Type  = BE-LLP
	EXPORT FileBELLPLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  BusinessEntityName;
		STRING  BusinessEntityType;
		STRING  BusinessEntitySubType;
		STRING  ExpirationDate;
		STRING  EntityStatusDescription;
		STRING  EntityStatusChangeReason;
		STRING  FormationDate;
		STRING  RegistrationDate;
		STRING  RenewalExpirationDate;
		STRING  BusinessMailingAddress1;
		STRING  BusinessMailingAddress2;
		STRING  BusinessMailingAddress3;
		STRING  BusinessMailingAddress4;   //City
		STRING  BusinessMailingAddress5;   //State
		STRING  BusinessMailingAddress6;   //Zip Code
		STRING  BusinessMailingAddress7;   //Country
		STRING  TribalDesignation;
		STRING  Purpose;
	END;

  // Record Type  = BE-LP
	EXPORT FileBELPLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  BusinessEntityName;
		STRING  BusinessEntityType;
		STRING  BusinessEntitySubType;
		STRING  FormationDate;
		STRING  RegistrationDate;
		STRING  TermOfExistence;	
		STRING  DurationExpirationDate;
		STRING  EntityStatusDescription;
		STRING  EntityStatusChangeReason;
		STRING  BusinessMailingAddress1;
		STRING  BusinessMailingAddress2;
		STRING  BusinessMailingAddress3;
		STRING  BusinessMailingAddress4;   //City
		STRING  BusinessMailingAddress5;   //State
		STRING  BusinessMailingAddress6;   //Zip Code
		STRING  BusinessMailingAddress7;   //Country
		STRING  TribalDesignation;
		STRING  Purpose;
		STRING  StateOrCountryOfJurisdiction;
		STRING  RenewalExpirationDate;
		STRING  ExpirationNoticeDate;
	END;
 
  // Record Type  = FBN
	EXPORT FileFBNLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  BusinessEntityName;
		STRING  RegistrationDate;
		STRING  RenewalDate;
		STRING  ExpirationDate;
		STRING  EntityStatusDescription;
		STRING  EntityStatusChangeReason;
		STRING  BusinessType;
		STRING  StateOrCountryOfJurisdiction;
		STRING  DateOfOrganizationOrIncorporation;
		STRING  BusinessDescription;
		STRING  BusinessMailingAddress1;
		STRING  BusinessMailingAddress2;
		STRING  BusinessMailingAddress3;
		STRING  BusinessMailingAddress4;   //City
		STRING  BusinessMailingAddress5;   //State
		STRING  BusinessMailingAddress6;   //Zip Code
		STRING  BusinessMailingAddress7;   //Country
	END;

  // Record Type  = TM
	EXPORT FileTMLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  BusinessEntityName;
		STRING  ExpirationDate;
		STRING  EntityStatusDescription;
		STRING  EntityStatusChangeReason;
		STRING  FilingDate;
		STRING  NoticeDate;
		STRING  DateOfFirstUseMontana;
		STRING  DateOfFirstUseAnywhere;
		STRING  RenewalDate;
		STRING  ClassCodesDesc;
		STRING  DescriptionOfGoods;
		STRING  MannerOfUse;
	END;
	
	// Record Type  = OWNER
	EXPORT FileOwnerLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  OwnerName;
		STRING  OwnerType;
		STRING  OwnerAddress1;
		STRING  OwnerAddress2;
		STRING  OwnerAddress3;
		STRING  OwnerAddress4;    //City
		STRING  OwnerAddress5;    //State
		STRING  OwnerAddress6;    //Zip Code
		STRING  OwnerAddress7;    //Country
		STRING  OwnerRelatedBusinessEntityId;
	END;

  // Record Type  = PARTNER
	EXPORT FilePartnerLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  PartnerName;
		STRING  PartnerBusinessMailingAddress1;
		STRING  PartnerBusinessMailingAddress2;
		STRING  PartnerBusinessMailingAddress3;
		STRING  PartnerBusinessMailingAddress4;    //City 
		STRING  PartnerBusinessMailingAddress5;    //State
		STRING  PartnerBusinessMailingAddress6;    //Zip Code
		STRING  PartnerBusinessMailingAddress7;    //Country
		STRING  PartnerRelatedBusinessEntityId;
	END;

	// Record Type  = MEMBER
	EXPORT FileMemberLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  MemberName;
		STRING  MemberBusinessMailingAddress1;
		STRING  MemberBusinessMailingAddress2;
		STRING  MemberBusinessMailingAddress3;
		STRING  MemberBusinessMailingAddress4;   //City
		STRING  MemberBusinessMailingAddress5;   //State
		STRING  MemberBusinessMailingAddress6;   //Zip Code
		STRING  MemberBusinessMailingAddress7;   //Country
		STRING  MemberRelatedBusinessEntityId;
	END;

  // Record Type  = SHARES
	EXPORT FileSharesLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  AuthorizedSharesClass;
		STRING  AuthorizedNumberOfShares;
		STRING  AuthorizedSharesSeries;
		STRING  AuthorizedSharesIssued;
		STRING  AuthorizedSharesParValueAmount;
	END;

	// Record Type  = AGENT
	EXPORT FileAgentLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  RegisteredAgentNameOrEntityName;
		STRING  AgentBusinessMailingPhysicalAddress1;
		STRING  AgentBusinessMailingPhysicalAddress2;
		STRING  AgentBusinessMailingPhysicalAddress3;
		STRING  AgentBusinessMailingPhysicalAddress4;   //City
		STRING  AgentBusinessMailingPhysicalAddress5;   //State
		STRING  AgentBusinessMailingPhysicalAddress6;   //Zip Code
		STRING  AgentBusinessMailingPhysicalAddress7;   //Country
		STRING  AgentBusinessMailingPostalAddress1;
		STRING  AgentBusinessMailingPostalAddress2;
		STRING  AgentBusinessMailingPostalAddress3;
		STRING  AgentBusinessMailingPostalAddress4;     //City
		STRING  AgentBusinessMailingPostalAddress5;     //State
		STRING  AgentBusinessMailingPostalAddress6;     //Zip Code
		STRING  AgentBusinessMailingPostalAddress7;     //Country
	END;
	
  // Record Type  = PRINCIPAL	
	EXPORT FilePrincipalLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  PrincipalNameOrEntityName;
		STRING  PrincipalPosition;
		STRING  PrincipalBusinessMailingAddress1;
		STRING  PrincipalBusinessMailingAddress2;
		STRING  PrincipalBusinessMailingAddress3;
		STRING  PrincipalBusinessMailingAddress4;     //City
		STRING  PrincipalBusinessMailingAddress5;     //State
		STRING  PrincipalBusinessMailingAddress6;     //Zip Code
		STRING  PrincipalBusinessMailingAddress7;     //Country
		STRING  PrincipalRelatedBusinessEntityId;
	END;

  // Record Type  = RELATED_ABN
	EXPORT FileRelatedABNLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  RelatedABNName;
		STRING  RelatedABNId;
	END;

  // Record Type  = RELATED_TRADEMARK
	EXPORT FileRelatedTrademarkLayoutIn := RECORD
		STRING  EntityRole;
		STRING  BusinessEntityNumber;
		STRING  RelatedTrademarkName;
		STRING  RelatedTrademarkId;
		STRING  RelatedTrademarkType;
	END;

	//**********************************	
	//TEMPORARY Record layouts
  //**********************************	
  export TempNormAgentLayoutIn					   := record
		STRING  BusinessEntityNumber;
		STRING  RegisteredAgentNameOrEntityName;
	  STRING  AgentAddressTypeCode;
		STRING  AgentAddressTypeDesc;
	  STRING  AgentBusinessMailingAddress1;
		STRING  AgentBusinessMailingAddress2;
		STRING  AgentBusinessMailingAddress3;
		STRING  AgentBusinessMailingCity;    
		STRING  AgentBusinessMailingState;    
		STRING  AgentBusinessMailingZipCode; 
		STRING  AgentBusinessMailingCountry; 
  end;	
	
	export TempCorpLayoutIn							:= record
			FileBECORPLayoutIn              -EntityRole; 
			TempNormAgentLayoutIn       		-BusinessEntityNumber;
			string RelatedABNId;
			string RelatedTMId;
	end;
	
	export TempNormCorpLayoutIn					:= record
			TempCorpLayoutIn; 
	    string temp_filing_date;
			string temp_filing_desc;
	end;
	
	export TempLLCLayoutIn						    	:= record
			FileBELLCLayoutIn               -EntityRole;  
			TempNormAgentLayoutIn       		-BusinessEntityNumber;
			string RelatedABNId;
			string RelatedTMId;
	end;
	
	export TempNormLLCLayoutIn					:= record
			TempLLCLayoutIn; 
	    string temp_filing_date;
			string temp_filing_desc;
	end;
	
	export TempLPLayoutIn						    	  := record
			FileBELPLayoutIn                -EntityRole;             
			TempNormAgentLayoutIn       		-BusinessEntityNumber;
			
	end;
	
	export TempNormLPLayoutIn               := record
	    TempLPLayoutIn;
			string temp_filing_date;
			string temp_filing_desc;
	end;
	
	export TempContactLayoutIn							:= record
		  string    BusinessEntityNumber;
   	  string    Corp_Legal_Name;
			string		ContType;
   		string		ContDesc;
			string 		Cont_Full_Name;
			string    Title_Position;
			string 		Cont_address_line1;
			string 		Cont_address_line2;
			string 		Cont_address_line3;
			string 		Cont_city;
			string 		Cont_state;
			string 		Cont_zip;
			string 		Cont_country;
			string    RelatedBusinessEntityId;
	end;

END;