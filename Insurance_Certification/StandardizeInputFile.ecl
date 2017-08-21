IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, idl_header;

EXPORT StandardizeInputFile := module
	//-------------------------------------
	//Begin Standardize CERTIFICATON file
	//-------------------------------------
  EXPORT fAssignSeq(DATASET(Insurance_Certification.layouts_certification.Input) pRawFileInput, string pversion) := FUNCTION
	
    // Add a unique_id to the raw input records to use for normalizing the name & addresses	
		//   In:  pRawFileInput (Input layout)  
		//   Out: dAssignSeq    (TempRec layout)
		Insurance_Certification.layouts_certification.TempRec tAssignSeq(Insurance_Certification.layouts_certification.Input l, unsigned8 cnt) := TRANSFORM
			SELF.unique_id	:= cnt;
			SELF						:= L;
		END;
				 		
		dAssignSeq := PROJECT(pRawFileInput, tAssignSeq(left,counter));

		// Normalize the raw input records
		//   In:  dAssignSeq (TempRec layout)  
		//   Out: dNormalize (NormRec layout)
		Insurance_Certification.layouts_certification.NormRec	tNormalizeRec(Insurance_Certification.layouts_certification.TempRec l, unsigned8 cnt) := TRANSFORM
			SELF.unique_id	       := l.unique_id;
			SELF.Norm_Type         :=	choose(cnt ,'B'	          	/* Business                 */
			                                     ,'D'             /* DBA                      */
																					 ,'C'         );  /* 3rd Party Vendor Contact */                     
			SELF.Norm_BusinessName :=	choose(cnt ,l.BusinessName
																				   ,l.DBA
																					 ,l.ContactBusinessName);
			SELF.Norm_FirstName	   :=	choose(cnt ,l.NameFirst
																					 ,l.NameFirst
																					 ,l.ContactNameFirst   );																					 															
			SELF.Norm_Middle 			 := choose(cnt ,l.NameMiddle
																					 ,l.NameMiddle
																					 ,l.ContactNameMiddle  );
			SELF.Norm_Last				 :=	choose(cnt ,l.NameLast
																					 ,l.NameLast	
																					 ,l.ContactNameLast		 );
			SELF.Norm_Suffix 			 := choose(cnt ,l.NameSuffix
																					 ,l.NameSuffix
																					 ,l.ContactNameSuffix  );
			SELF.Norm_Address1 		 := choose(cnt ,l.AddressLine1
																					 ,l.AddressLine1
																					 ,l.ContactAddressLine1);
			SELF.Norm_Address2 		 := choose(cnt ,l.AddressLine2
																					 ,l.AddressLine2
																					 ,l.ContactAddressLine2);
			SELF.Norm_City 				 := choose(cnt ,l.AddressCity
																					 ,l.AddressCity
																			     ,l.ContactCity        );																
			SELF.Norm_State 			 := choose(cnt ,l.AddressState
																					 ,l.AddressState
																			     ,l.ContactState       );	
			SELF.Norm_Zip  				 := choose(cnt ,l.AddressZip
																					 ,l.AddressZip
																			     ,l.ContactZip				 );
			SELF.Norm_Zip4 				 := choose(cnt ,l.Zip4
																					 ,l.Zip4
																			     ,l.ContactZip4				 );
			SELF.Norm_Phone				 := choose(cnt ,l.Phone1
																					 ,l.Phone1
																			     ,l.ContactPhone			 );
			SELF.DateAdded		:= l.DateAdded;
			SELF.DateUpdated  := l.DateUpdated;
			SELF						  := L;																		
		END;

		dNormalize	:=	normalize(dAssignSeq,	3,	tNormalizeRec(left, counter));
		
		RETURN dNormalize;
	END;	
	
	// Standardize Addresses in the normalized records
	//   In:  dNormalize  (NormRec layout)  
	//   Out: dPreProcess (Temp2 layout)
	EXPORT fPreprocess(DATASET(Insurance_Certification.Layouts_certification.NormRec) dNormalize) := FUNCTION

		Insurance_Certification.Layouts_certification.temp2 tPROJECTAddress(Insurance_Certification.Layouts_certification.NormRec l) := TRANSFORM
			SELF.Append_MailAddress1		:= StringLib.StringCleanSpaces(TRIM(StringLib.StringToUpperCase(L.Norm_Address1))) + 
															 ' ' + StringLib.StringCleanSpaces(TRIM(StringLib.StringToUpperCase(L.Norm_Address2)));
			SELF.Append_MailAddressLast	:= IF (L.Norm_City!='',
																				StringLib.StringCleanSpaces(
																				      TRIM(StringLib.StringToUpperCase(L.Norm_City)) + ', ' + 
																				      TRIM(L.Norm_State) + ' ' + 
																							TRIM(L.Norm_Zip)[1..5]),
																				StringLib.StringCleanSpaces(
																							TRIM(L.Norm_State) + ' ' + 
																							TRIM(L.Norm_Zip)[1..5]) ); 
			SELF.Norm_BusinessName  		:= StringLib.StringToUpperCase(l.Norm_BusinessName);   
			SELF.Norm_FirstName  				:= StringLib.StringToUpperCase(l.Norm_FirstName);       
			SELF.Norm_Middle  					:= StringLib.StringToUpperCase(l.Norm_Middle);
			SELF.Norm_Last  						:= StringLib.StringToUpperCase(l.Norm_Last);
			SELF.Norm_Suffix  					:= StringLib.StringToUpperCase(l.Norm_Suffix);
			SELF.Norm_Address1  				:= StringLib.StringToUpperCase(l.Norm_Address1);
			SELF.Norm_Address2  				:= StringLib.StringToUpperCase(l.Norm_Address2);
			SELF.Norm_City  						:= StringLib.StringToUpperCase(l.Norm_City);
			SELF.Norm_State  						:= StringLib.StringToUpperCase(l.Norm_State);
			SELF.Norm_Phone 						:= IF (L.Norm_Phone[2] = '.','',L.Norm_Phone);
			SELF.Website							  := StringLib.StringToUpperCase(l.Website);
			SELF.SIPStatusCode  			  := StringLib.StringToUpperCase(l.SIPStatusCode);			
			SELF.BusinessType					  := StringLib.StringToUpperCase(l.BusinessType);
			SELF.NameTitle					    := StringLib.StringToUpperCase(l.NameTitle);			
			SELF.ContactFax							:= IF (L.ContactFax[2] = '.','',L.ContactFax);
      SELF.Append_MailRawAID		  := 0;	
			SELF.Append_MailACEAID		  := 0;	
			SELF												:= L;
		END;
      
		dPreprocess   := PROJECT(dNormalize, tPROJECTAddress(left));
      
		RETURN dPreprocess;
  END;

	EXPORT fAll( DATASET(Insurance_Certification.Layouts_certification.Input)  pRawFileInput, string pversion) := FUNCTION
		
		dNormalize   := fAssignseq  (pRawFileInput,pversion);
		
		dPreprocess	 := fPreProcess (dNormalize);
		
	  isValidBusiness := (dPreprocess.Norm_Type = 'B' or dPreprocess.Norm_Type = 'D') and
		                   (dPreprocess.Norm_BusinessName <> '');
		
		isValidContact  := dPreprocess.Norm_Type = 'C' and
										 ((dPreprocess.Norm_BusinessName <> '') or 
											(dPreprocess.Norm_FirstName + dPreprocess.Norm_Last <> ''));
		                   
		dGoodRecs := dPreprocess(isValidBusiness) + dPreprocess(isValidContact);
			
		RETURN dGoodRecs;
	END;
	//End Standardize CERTIFICATION file	
	
	//------------------------------
	//Begin Standardize POLICY file
	//------------------------------
	EXPORT fPreProcessPol(DATASET(Insurance_Certification.Layouts_policy.Input) pRawFileInput, string pversion) := FUNCTION    

		Insurance_Certification.Layouts_policy.Temp	trfInsCrtFile(Insurance_Certification.Layouts_policy.Input L)	:=	TRANSFORM	
				SELF  :=	L;
				SELF	:=	[];
		END;
		
		dPreProcessPol		:=	PROJECT(pRawFileInput, trfInsCrtFile(left));
		RETURN dPreProcessPol;
	END;
		
	EXPORT fStandardizeAddressesPol(DATASET(Insurance_Certification.Layouts_policy.Temp) pStandardizeNameInput, string pversion) := FUNCTION

		Insurance_Certification.Layouts_policy.temp tPROJECTAddress(Insurance_Certification.Layouts_policy.Temp l) := TRANSFORM
			SELF.Append_MailAddress1		:= StringLib.StringCleanSpaces(TRIM(StringLib.StringToUpperCase(L.InsuranceProviderAddressLine))) +
                               ' ' + StringLib.StringCleanSpaces(TRIM(StringLib.StringToUpperCase(L.InsuranceProviderAddressLine2)));			
			SELF.Append_MailAddressLast	:= IF (L.InsuranceProviderCity!='',
																				StringLib.StringCleanSpaces(
																				      TRIM(StringLib.StringToUpperCase(L.InsuranceProviderCity)) + ', ' + 
																				      TRIM(L.InsuranceProviderState) + ' ' + 
																							TRIM(L.InsuranceProviderZip)[1..5]),
																				StringLib.StringCleanSpaces(
																							TRIM(L.InsuranceProviderState) + ' ' + 
																							TRIM(L.InsuranceProviderZip)[1..5]) );
			SELF.InsuranceProvider  		       := StringLib.StringToUpperCase(l.InsuranceProvider);      
			SELF.InsuranceProviderAddressLine  := StringLib.StringToUpperCase(l.InsuranceProviderAddressLine);  
			SELF.InsuranceProviderAddressLine2 := StringLib.StringToUpperCase(l.InsuranceProviderAddressLine2);
			SELF.InsuranceProviderCity  		   := StringLib.StringToUpperCase(l.InsuranceProviderCity);
			SELF.InsuranceProviderState  		   := StringLib.StringToUpperCase(l.InsuranceProviderState);
			SELF												       := L;
		END;
      
		dAddressPrep   := PROJECT(pStandardizeNameInput, tPROJECTAddress(left));
      
		RETURN dAddressPrep;
  END;

	EXPORT fAllPol( DATASET(Insurance_Certification.Layouts_policy.Input)  pRawFileInput, string pversion) := FUNCTION
   	dPreprocessPol	 := fPreProcessPol (pRawFileInput,pversion);
		
   	dAppendBusinessInfoPol  := fStandardizeAddressesPol	(dPreprocessPol, pversion);
		      
		RETURN dAppendBusinessInfoPol;
	END;
	//End Standardize POLICY file	
END;