EXPORT macAppendProviderAttributesV3 (Infile, InputLnpid, InputState, UseIndexThreshold=5000000, appendPrefix = '\'\'') := FUNCTIONMACRO
		IMPORT hipie_ecl, STD;
		
		STRING8 Current_Date := (STRING8) STD.DATE.Today();
		
		OutputRecord := RECORD
			RECORDOF (Infile);
			UNSIGNED8 #EXPAND(appendPrefix + 'LexID');
			STRING1	  #EXPAND(appendPrefix + 'EntityType');
			STRING20  #EXPAND(appendPrefix + 'FNAME');
			STRING20  #EXPAND(appendPrefix + 'MNAME');
			STRING28  #EXPAND(appendPrefix + 'LNAME'); 
			STRING5	  #EXPAND(appendPrefix + 'SNAME');
			STRING9	  #EXPAND(appendPrefix + 'SSN');
			STRING9	  #EXPAND(appendPrefix + 'ConsumerSSN');
			UNSIGNED4 #EXPAND(appendPrefix + 'DateOfBirth');
			UNSIGNED4 #EXPAND(appendPrefix + 'ConsumerDateOfBirth');
			STRING25  #EXPAND(appendPrefix + 'LicenseNumber');
			STRING25  #EXPAND(appendPrefix + 'CleanedLicenseNumber');
			STRING2	  #EXPAND(appendPrefix + 'LicenseState');
			STRING60  #EXPAND(appendPrefix + 'LicenseType');
			STRING60  #EXPAND(appendPrefix + 'LicenseStatus');
			UNSIGNED4 #EXPAND(appendPrefix + 'DateLicenseExpired'); 
			UNSIGNED4 #EXPAND(appendPrefix + 'LicenseCount');
			UNSIGNED4 #EXPAND(appendPrefix + 'LicenseStateCount');
			UNSIGNED4 #EXPAND(appendPrefix + 'ActiveLicenseCount');
			UNSIGNED4 #EXPAND(appendPrefix + 'InactiveLicenseCount');
			UNSIGNED4 #EXPAND(appendPrefix + 'RevokedLicenseCount');
			STRING2		#EXPAND(appendPrefix + 'InactiveLicenseState');	
			STRING2		#EXPAND(appendPrefix + 'RevokedLicenseState');	
			STRING1		#EXPAND(appendPrefix + 'InactiveLicenseFlag');	
			STRING1		#EXPAND(appendPrefix + 'RevokedLicenseFlag');	
			STRING1		#EXPAND(appendPrefix + 'ExpiredLicenseFlag');	
			STRING1	  #EXPAND(appendPrefix + 'DeathIndicator');
			UNSIGNED4 #EXPAND(appendPrefix + 'DateOfDeath');
			UNSIGNED4 #EXPAND(appendPrefix + 'BillingTaxID');
			STRING10  #EXPAND(appendPrefix + 'Phone');
			STRING10  #EXPAND(appendPrefix + 'Fax');
			STRING6	  #EXPAND(appendPrefix + 'UPIN');
			STRING10  #EXPAND(appendPrefix + 'NPINUMBER');
			STRING8   #EXPAND(appendPrefix + 'NPIEnumerationDate');
			STRING8   #EXPAND(appendPrefix + 'NPIDeactivationDate');
			STRING8   #EXPAND(appendPrefix + 'NPIReactivationDate');
			STRING1	  #EXPAND(appendPrefix + 'NPIFlag');
			UNSIGNED4 #EXPAND(appendPrefix + 'DeactivedNPICount');		
			STRING1	  #EXPAND(appendPrefix + 'DEABusinessActivityIndicator');		
			STRING10  #EXPAND(appendPrefix + 'DEANumber');
			UNSIGNED4 #EXPAND(appendPrefix + 'DateDEAExpired');
			UNSIGNED4 #EXPAND(appendPrefix + 'DEACount');
			UNSIGNED4 #EXPAND(appendPrefix + 'ActiveDEACount');
			UNSIGNED4 #EXPAND(appendPrefix + 'ExpiredDEACount');
			STRING1		#EXPAND(appendPrefix + 'DEAExpiredFlag');
			STRING1	  #EXPAND(appendPrefix + 'isStateSanction');
			STRING1	  #EXPAND(appendPrefix + 'isOIGSanction');
			STRING1	  #EXPAND(appendPrefix + 'isOPMSanction');
			STRING10  #EXPAND(appendPrefix + 'Taxonomy');
			STRING50  #EXPAND(appendPrefix + 'TaxonomyDescription');		
			STRING3	  #EXPAND(appendPrefix + 'SpecialityCode');	
			STRING1	  #EXPAND(appendPrefix + 'ProviderStatus');
			STRING40  #EXPAND(appendPrefix + 'GroupKey');
			STRING1	  #EXPAND(appendPrefix + 'hasActiveLicenseRevocation');
			STRING2	  #EXPAND(appendPrefix + 'ActiveLicenseRevocationState');			
			STRING8		#EXPAND(appendPrefix + 'ActiveLicenseRevocationDate');			
			STRING1	  #EXPAND(appendPrefix + 'hasActiveStateExclusion');
			STRING2	  #EXPAND(appendPrefix + 'ActiveLicenseExclusionState');
			STRING8	  #EXPAND(appendPrefix + 'ActiveStateExclusionDate');			
			STRING1	  #EXPAND(appendPrefix + 'hasActiveOIGExclusion');	
			STRING8	  #EXPAND(appendPrefix + 'ActiveOIGExclusionDate');
			STRING1	  #EXPAND(appendPrefix + 'hasActiveOPMExclusion');
			STRING8	  #EXPAND(appendPrefix + 'ActiveOPMExclusionDate');
			STRING8	  #EXPAND(appendPrefix + 'ActiveStateSanctionExclusionDate');
			STRING8	  #EXPAND(appendPrefix + 'ActiveOIGSanctionExclusionDate');
			STRING8	  #EXPAND(appendPrefix + 'ActiveOPMSanctionExclusionDate');
			STRING1	  #EXPAND(appendPrefix + 'hasLicenseRevocationReinstated');
			STRING2	  #EXPAND(appendPrefix + 'LicenseRevocationReinstatedState');
			STRING8	  #EXPAND(appendPrefix + 'LicenseRevocationReinstatedDate');
			STRING1	  #EXPAND(appendPrefix + 'hasStateExclusioinReinstated');
			STRING2	  #EXPAND(appendPrefix + 'StateExclusionReinstatedState');
			STRING8		#EXPAND(appendPrefix + 'StateExclusionReinstatedDate');
			STRING1	  #EXPAND(appendPrefix + 'hasOIGExclusioinReinstated');
			STRING8		#EXPAND(appendPrefix + 'OIGExclusionBeginDate');						
			STRING8		#EXPAND(appendPrefix + 'OIGExclusionReinstatedDate');			
			STRING1	  #EXPAND(appendPrefix + 'hasOPMExclusioinReinstated');
			STRING8		#EXPAND(appendPrefix + 'StateExclusionBeginDate');						
			STRING8		#EXPAND(appendPrefix + 'OPMExclusionBeginDate');						
			STRING8		#EXPAND(appendPrefix + 'OPMExclusionReinstatedDate');			
			STRING10  #EXPAND(appendPrefix + 'ResidentialPrimaryRange');
			STRING2   #EXPAND(appendPrefix + 'ResidentialPreDirectional');
			STRING28  #EXPAND(appendPrefix + 'ResidentialPrimaryName');
			STRING4   #EXPAND(appendPrefix + 'ResidentialAddressSuffix');
			STRING2   #EXPAND(appendPrefix + 'ResidentialPostDirectional');
			STRING8   #EXPAND(appendPrefix + 'ResidentialSecondaryRange');
			STRING25  #EXPAND(appendPrefix + 'ResidentialCityName');
			STRING2   #EXPAND(appendPrefix + 'ResidentialState');
			STRING5   #EXPAND(appendPrefix + 'ResidentialZip5');
			UNSIGNED3 #EXPAND(appendPrefix + 'ResidentialAddressLastSeen');
			STRING1	  #EXPAND(appendPrefix + 'ProviderWithSingleAddress');
			UNSIGNED3	#EXPAND(appendPrefix + 'SingleAddressProviderCount');
			STRING10  #EXPAND(appendPrefix + 'PractisePrimaryRange');
			STRING2   #EXPAND(appendPrefix + 'PractisePreDirectional');
			STRING28  #EXPAND(appendPrefix + 'PractisePrimaryName');
			STRING4   #EXPAND(appendPrefix + 'PractiseAddressSuffix');
			STRING2   #EXPAND(appendPrefix + 'PractisePostDirectional');
			STRING8   #EXPAND(appendPrefix + 'PractiseSecondaryRange');
			STRING25  #EXPAND(appendPrefix + 'PractiseCityName');
			STRING2   #EXPAND(appendPrefix + 'PractiseState');
			STRING5   #EXPAND(appendPrefix + 'PractiseZip5');
			STRING1	  #EXPAND(appendPrefix + 'hasBankruptcy');
			STRING8		#EXPAND(appendPrefix + 'BankruptcyLastSeen');
			STRING1	  #EXPAND(appendPrefix + 'hasCriminalHistory');			
			STRING8		#EXPAND(appendPrefix + 'LastArrestedDate');
			STRING1	  #EXPAND(appendPrefix + 'hasRelativeConvictions');
			STRING1	  #EXPAND(appendPrefix + 'hasRelativeBankruptcy');
			STRING3	  #EXPAND(appendPrefix + 'RelativeCount');
			STRING3	  #EXPAND(appendPrefix + 'RelativeBankruptcyCount');
			STRING3	  #EXPAND(appendPrefix + 'RelativeFelonyCount');
			STRING1		#EXPAND(appendPrefix + 'hasAssocActiveStateExclusion');
			STRING1		#EXPAND(appendPrefix + 'hasAssocActiveLicenseRevocation');		
			STRING1		#EXPAND(appendPrefix + 'hasAssocStateExclusionReinstated');
			STRING1		#EXPAND(appendPrefix + 'hasAssocLicenseRevocationReinstated');
			STRING1		#EXPAND(appendPrefix + 'hasAssocBankruptcy');
			STRING1		#EXPAND(appendPrefix + 'hasAssocCriminalHistory');
			STRING1		#EXPAND(appendPrefix + 'hasDeceased');
			STRING8		#EXPAND(appendPrefix + 'DeceasedDate');
			STRING1		#EXPAND(appendPrefix + 'ClientStateExclusionInd');
			STRING2		#EXPAND(appendPrefix + 'ClientStateExclusionState');
			STRING8   #EXPAND(appendPrefix + 'ClientStateExclusionDate');  
			STRING1		#EXPAND(appendPrefix + 'ClientStateLicenseRevokedInd');
			STRING2		#EXPAND(appendPrefix + 'ClientStateLicenseRevokedState');
			STRING8		#EXPAND(appendPrefix + 'ClientStateLicenseRevokedDate');
			STRING8		#EXPAND(appendPrefix + 'ClientPastStateExclusionDate');
			STRING8		#EXPAND(appendPrefix + 'ClientPastStateExclusionReinstDate');
			STRING8		#EXPAND(appendPrefix + 'ClientPastLicRevokedDate');
			STRING8		#EXPAND(appendPrefix + 'ClientPastLicRevokedReinstDate');
			STRING1	  #EXPAND(appendPrefix + 'ClientExpiredLicenseInd');			
			STRING2	  #EXPAND(appendPrefix + 'ClientExpiredLicenseState');			
			STRING25  #EXPAND(appendPrefix + 'ClientExpiredLicenseNumber');
			UNSIGNED4 #EXPAND(appendPrefix + 'ClientExpiredLicenseDate');
			STRING1	  #EXPAND(appendPrefix + 'ClientInactiveLicenseInd');			
			STRING2	  #EXPAND(appendPrefix + 'ClientInactiveLicenseState');			
			STRING25  #EXPAND(appendPrefix + 'ClientInactiveLicenseNumber');
			UNSIGNED4 #EXPAND(appendPrefix + 'ClientInactiveLicenseDate');
			#IF((BOOLEAN)AppendProviderAttributes.ShellConfig.isCCPA) STRING1 #EXPAND(appendPrefix + 'OptOutInd') := ''; #END
		END;		
		
		//concatenate these in the output
		invalidLnpidDs := Infile(InputLnpid = 0);
		
		//join to provider attributes
		joinKeyRecord := RECORD
			Infile.InputLnpid;
		END;
		
		validLnpidDs := Infile(InputLnpid > 0);		
		validLnpidDsDist := DISTRIBUTE(validLnpidDs, HASH32(InputLnpid));
		joinKeyDs := PROJECT(validLnpidDsDist, joinKeyRecord, LOCAL);
		joinKeyDsDedup := DEDUP(SORT(joinKeyDs, InputLnpid, LOCAL), InputLnpid, LOCAL);
		
		joinDs := hipie_ecl.macJoinKey(joinKeyDsDedup, AppendProviderAttributes.Key_Provider_Attributes_v4,
			'KEYED(LEFT.' + #TEXT(InputLnpid) + ' = RIGHT.LNPID)', 
			'RIGHT.' + #TEXT(InputLnpid) + ' = LEFT.LNPID', 
			UseIndexThreshold,'INNER',true,1,,,TRUE);

		joinDs2 := hipie_ecl.macJoinKey(joinDs, AppendProviderAttributes.Key_Provider_Attributes_Data,
			'KEYED(LEFT.' + #TEXT(InputLnpid) + ' = RIGHT.LNPID)', 
			'RIGHT.' + #TEXT(InputLnpid) + ' = LEFT.LNPID', 
			UseIndexThreshold,'LEFT OUTER',true,1,,,TRUE);

		OutputRecord	tOutputRecord (validLnpidDsDist L, joinDs2 R) := TRANSFORM
			SELF.#EXPAND(appendPrefix + 'LexID')						     	:= R.LexID;
			SELF.#EXPAND(appendPrefix + 'EntityType')					    := R.EntityType;
			SELF.#EXPAND(appendPrefix + 'FNAME')						     	:= R.FNAME;
			SELF.#EXPAND(appendPrefix + 'MNAME')						     	:= R.MNAME;
			SELF.#EXPAND(appendPrefix + 'LNAME') 						     	:= R.LNAME; 
			SELF.#EXPAND(appendPrefix + 'SNAME')						     	:= R.SNAME;
			SELF.#EXPAND(appendPrefix + 'SSN')						     		:= R.SSN;
			SELF.#EXPAND(appendPrefix + 'ConsumerSSN')					  := R.ConsumerSSN;
			SELF.#EXPAND(appendPrefix + 'DateOfBirth')					  := R.DateOfBirth;
			SELF.#EXPAND(appendPrefix + 'ConsumerDateOfBirth')		:= R.ConsumerDateOfBirth;
			SELF.#EXPAND(appendPrefix + 'LicenseNumber')					:= R.LicenseNumber;
			SELF.#EXPAND(appendPrefix + 'CleanedLicenseNumber')		:= R.CleanedLicenseNumber;
			SELF.#EXPAND(appendPrefix + 'LicenseState')					  := R.LicenseState;
			SELF.#EXPAND(appendPrefix + 'LicenseType')					  := R.LicenseType;
			SELF.#EXPAND(appendPrefix + 'LicenseStatus')					:= R.LicenseStatus;
			SELF.#EXPAND(appendPrefix + 'DateLicenseExpired') 		:= R.DateLicenseExpired; 
			SELF.#EXPAND(appendPrefix + 'LicenseCount')					  := R.LicenseCount;
			SELF.#EXPAND(appendPrefix + 'LicenseStateCount')			:= R.LicenseStateCount;
			SELF.#EXPAND(appendPrefix + 'ActiveLicenseCount')			:= R.ActiveLicenseCount;
			SELF.#EXPAND(appendPrefix + 'InactiveLicenseCount')		:= R.InactiveLicenseCount;
			SELF.#EXPAND(appendPrefix + 'RevokedLicenseCount')		:= R.RevokedLicenseCount;
			SELF.#EXPAND(appendPrefix + 'InactiveLicenseState')		:= R.InactiveLicenseState;	
			SELF.#EXPAND(appendPrefix + 'RevokedLicenseState')		:= R.RevokedLicenseState;	
			SELF.#EXPAND(appendPrefix + 'InactiveLicenseFlag')		:= R.InactiveLicenseFlag;
			SELF.#EXPAND(appendPrefix + 'RevokedLicenseFlag')			:= R.RevokedLicenseFlag;
			SELF.#EXPAND(appendPrefix + 'ExpiredLicenseFlag')			:= R.ExpiredLicenseFlag;
			SELF.#EXPAND(appendPrefix + 'DeathIndicator')					:= R.DeathIndicator;
			SELF.#EXPAND(appendPrefix + 'DateOfDeath')					  := R.DateOfDeath;
			SELF.#EXPAND(appendPrefix + 'BillingTaxID')					  := R.BillingTaxID;
			SELF.#EXPAND(appendPrefix + 'Phone')						     	:= R.Phone;
			SELF.#EXPAND(appendPrefix + 'Fax')						     		:= R.Fax;
			SELF.#EXPAND(appendPrefix + 'UPIN')						     		:= R.UPIN;
			SELF.#EXPAND(appendPrefix + 'NPINUMBER')					    := R.NPINUMBER;
			SELF.#EXPAND(appendPrefix + 'NPIEnumerationDate')			:= R.NPIEnumerationDate;
			SELF.#EXPAND(appendPrefix + 'NPIDeactivationDate')		:= R.NPIDeactivationDate;
			SELF.#EXPAND(appendPrefix + 'NPIReactivationDate')		:= R.NPIReactivationDate;
			SELF.#EXPAND(appendPrefix + 'NPIFlag')						    := R.NPIFlag;
			SELF.#EXPAND(appendPrefix + 'DeactivedNPICount')			:= R.DeactivedNPICount; 
			SELF.#EXPAND(appendPrefix + 'DEABusinessActivityIndicator')		:= R.DEABusinessActivityIndicator;
			SELF.#EXPAND(appendPrefix + 'DEANumber')					    := R.DEANumber;
			SELF.#EXPAND(appendPrefix + 'DateDEAExpired')					:= R.DateDEAExpired;
			SELF.#EXPAND(appendPrefix + 'DEACount')						    := R.DEACount;
			SELF.#EXPAND(appendPrefix + 'ActiveDEACount')					:= R.ActiveDEACount;
			SELF.#EXPAND(appendPrefix + 'ExpiredDEACount')				:= R.ExpiredDEACount;
			SELF.#EXPAND(appendPrefix + 'DEAExpiredFlag')					:= R.DeaExpiredFlag;
			SELF.#EXPAND(appendPrefix + 'isStateSanction')				:= R.isStateSanction;
			SELF.#EXPAND(appendPrefix + 'isOIGSanction')	 				:= R.isOIGSanction;
			SELF.#EXPAND(appendPrefix + 'isOPMSanction')					:= R.isOPMSanction;
			SELF.#EXPAND(appendPrefix + 'Taxonomy')						     := R.Taxonomy;
			SELF.#EXPAND(appendPrefix + 'TaxonomyDescription')		 := R.TaxonomyDescription; 
			SELF.#EXPAND(appendPrefix + 'SpecialityCode')					 := R.SpecialityCode;
			SELF.#EXPAND(appendPrefix + 'ProviderStatus')					 := R.ProviderStatus;
			SELF.#EXPAND(appendPrefix + 'GroupKey')						     := R.GroupKey;

			SELF.#EXPAND(appendPrefix + 'hasActiveLicenseRevocation')			 	:= R.hasActiveLicenseRevocation;	
			SELF.#EXPAND(appendPrefix + 'ActiveLicenseRevocationState')		 	:= R.ActiveLicenseRevocationState;
			
			SELF.#EXPAND(appendPrefix + 'hasActiveStateExclusion')		 			:= R.hasActiveStateExclusion;			
			SELF.#EXPAND(appendPrefix + 'ActiveLicenseExclusionState')		 	:= R.ActiveLicenseExclusionState;			
			SELF.#EXPAND(appendPrefix + 'ActiveStateExclusionDate')		 			:= R.ActiveStateExclusionDate;			
			SELF.#EXPAND(appendPrefix + 'hasActiveOIGExclusion')		 				:= R.hasActiveOIGExclusion;			
			SELF.#EXPAND(appendPrefix + 'ActiveOIGExclusionDate')		 				:= R.ActiveOIGExclusionDate;			
			SELF.#EXPAND(appendPrefix + 'hasActiveOPMExclusion')						:= R.hasActiveOPMExclusion;			
			SELF.#EXPAND(appendPrefix + 'ActiveOPMExclusionDate')		 				:= R.ActiveOPMExclusionDate;			

			SELF.#EXPAND(appendPrefix + 'ActiveLicenseRevocationDate')		 	:= R.ActiveLicenseRevocationDate;			

			SELF.#EXPAND(appendPrefix + 'ActiveStateSanctionExclusionDate')	:= R.ActiveStateExclusionDate;			
			SELF.#EXPAND(appendPrefix + 'ActiveOIGSanctionExclusionDate')		:= R.ActiveOIGExclusionDate;			
			SELF.#EXPAND(appendPrefix + 'ActiveOPMSanctionExclusionDate')		:= R.ActiveOPMExclusionDate;			
			SELF.#EXPAND(appendPrefix + 'hasLicenseRevocationReinstated')		:= R.hasLicenseRevocationReinstated_Past5Y;			
			SELF.#EXPAND(appendPrefix + 'LicenseRevocationReinstatedState')	:= R.LicenseRevocationReinstatedState_Past5Y;			
			SELF.#EXPAND(appendPrefix + 'LicenseRevocationReinstatedDate')	:= R.LicenseRevocationReinstatedDate_Past5Y;			
			SELF.#EXPAND(appendPrefix + 'hasStateExclusioinReinstated')		 	:= R.hasActiveStateExclusionReinstated_Past5Y;			
			SELF.#EXPAND(appendPrefix + 'StateExclusionReinstatedState')		:= R.StateExclusionReinstatedState_Past5Y;			
			SELF.#EXPAND(appendPrefix + 'StateExclusionReinstatedDate')		 	:= R.StateExclusionReinstatedDate_Past5Y;			
			SELF.#EXPAND(appendPrefix + 'hasOIGExclusioinReinstated')		 		:= R.hasActiveOIGExclusionReinstated_Past5Y;			
			SELF.#EXPAND(appendPrefix + 'OIGExclusionBeginDate')		 				:= R.OIGExclusionReinstatedBeginDate_Past5y;			
			SELF.#EXPAND(appendPrefix + 'OIGExclusionReinstatedDate')		 		:= R.OIGExclusionReinstatedDate_Past5Y;			
			SELF.#EXPAND(appendPrefix + 'hasOPMExclusioinReinstated')		 		:= R.hasActiveOPMExclusionReinstated_Past5Y;			
			
			SELF.#EXPAND(appendPrefix + 'StateExclusionBeginDate')		 			:= R.StateExclusionReinstatedBeginDate_Past5Y;						
			SELF.#EXPAND(appendPrefix + 'OPMExclusionBeginDate')		 				:= R.OPMExclusionReinstatedBeginDate_Past5Y;						
			SELF.#EXPAND(appendPrefix + 'OPMExclusionReinstatedDate')		 		:= R.OPMExclusionReinstatedDate_Past5Y;			
			
			SELF.#EXPAND(appendPrefix + 'ResidentialPrimaryRange')				     						:= R.ResidentialPrimaryRange;
			SELF.#EXPAND(appendPrefix + 'ResidentialPreDirectional')			     						:= R.ResidentialPreDirectional;
			SELF.#EXPAND(appendPrefix + 'ResidentialPrimaryName')				     							:= R.ResidentialPrimaryName;
			SELF.#EXPAND(appendPrefix + 'ResidentialAddressSuffix')				     						:= R.ResidentialAddressSuffix;
			SELF.#EXPAND(appendPrefix + 'ResidentialPostDirectional')			     						:= R.ResidentialPostDirectional;
			SELF.#EXPAND(appendPrefix + 'ResidentialSecondaryRange')			     						:= R.ResidentialSecondaryRange;
			SELF.#EXPAND(appendPrefix + 'ResidentialCityName')				     								:= R.ResidentialCityName;
			SELF.#EXPAND(appendPrefix + 'ResidentialState')					     									:= R.ResidentialState;
			SELF.#EXPAND(appendPrefix + 'ResidentialZip5')					     									:= R.ResidentialZip5;
			SELF.#EXPAND(appendPrefix + 'ResidentialAddressLastSeen')			 						    := R.ResidentialAddressLastSeen;
			SELF.#EXPAND(appendPrefix + 'ProviderWithSingleAddress')			   						  := R.ProviderWithSingleAddress;
			SELF.#EXPAND(appendPrefix + 'SingleAddressProviderCount')											:= R.SingleAddressProviderCount;
			SELF.#EXPAND(appendPrefix + 'PractisePrimaryRange')				     								:= R.PractisePrimaryRange;
			SELF.#EXPAND(appendPrefix + 'PractisePreDirectional')			     								:= R.PractisePreDirectional;
			SELF.#EXPAND(appendPrefix + 'PractisePrimaryName')				     								:= R.PractisePrimaryName;
			SELF.#EXPAND(appendPrefix + 'PractiseAddressSuffix')				     							:= R.PractiseAddressSuffix;
			SELF.#EXPAND(appendPrefix + 'PractisePostDirectional')			     							:= R.PractisePostDirectional;
			SELF.#EXPAND(appendPrefix + 'PractiseSecondaryRange')			     								:= R.PractiseSecondaryRange;
			SELF.#EXPAND(appendPrefix + 'PractiseCityName')				     										:= R.PractiseCityName;
			SELF.#EXPAND(appendPrefix + 'PractiseState')					     										:= R.PractiseState;
			SELF.#EXPAND(appendPrefix + 'PractiseZip5')					     											:= R.PractiseZip5;
			SELF.#EXPAND(appendPrefix + 'hasBankruptcy')			 						    						:= R.hasBankruptcy;
			SELF.#EXPAND(appendPrefix + 'BankruptcyLastSeen')															:= R.BankruptcyLastSeen;			
			SELF.#EXPAND(appendPrefix + 'hasCriminalHistory')			 						  					:= R.hasCriminalHistory;
			SELF.#EXPAND(appendPrefix + 'LastArrestedDate')																:= R.LastArrestedDate;
			SELF.#EXPAND(appendPrefix + 'hasRelativeConvictions')			 						   			:= R.hasRelativeConvictions;
			SELF.#EXPAND(appendPrefix + 'hasRelativeBankruptcy')			 						   			:= R.hasRelativeBankruptcy;
			SELF.#EXPAND(appendPrefix + 'RelativeCount')																	:= R.RelativeCount;
			SELF.#EXPAND(appendPrefix + 'RelativeBankruptcyCount')												:= R.RelativeBankruptcyCount;
			SELF.#EXPAND(appendPrefix + 'RelativeFelonyCount')														:= R.RelativeFelonyCount;
			SELF.#EXPAND(appendPrefix + 'hasAssocActiveStateExclusion')			 						  := R.hasAssocActiveStateExclusion;
			SELF.#EXPAND(appendPrefix + 'hasAssocActiveLicenseRevocation')			 					:= R.hasAssocActiveLicenseRevocation;		
			SELF.#EXPAND(appendPrefix + 'hasAssocStateExclusionReinstated')							 	:= R.hasAssocStateExclusionReinstated_Past5Y;
			SELF.#EXPAND(appendPrefix + 'hasAssocLicenseRevocationReinstated')						:= R.hasAssocLicenseRevocationReinstated_Past5Y;
			SELF.#EXPAND(appendPrefix + 'hasAssocBankruptcy')			 						    				:= R.hasAssocBankruptcy;
			SELF.#EXPAND(appendPrefix + 'hasAssocCriminalHistory')			 						   		:= R.hasAssocCriminalHistory;
			SELF.#EXPAND(appendPrefix + 'hasDeceased')																		:= R.hasDeceased;
			SELF.#EXPAND(appendPrefix + 'DeceasedDate')																		:= R.DeceasedDate;			
			
			SELF.#EXPAND(appendPrefix + 'ClientStateExclusionInd')												:= IF(EXISTS(R.CurrentExclusionStates(L.InputState = State and L.InputState <> '' and (INTEGER)R.CurrentExclusionStates(L.InputState = State)[1].REINSTATEMENT_DATE = 0)),'Y','N');
			SELF.#EXPAND(appendPrefix + 'ClientStateExclusionState')											:= R.CurrentExclusionStates(L.InputState = State and L.InputState <> '' and (INTEGER)R.CurrentExclusionStates(L.InputState = State)[1].REINSTATEMENT_DATE = 0)[1].State;
			SELF.#EXPAND(appendPrefix + 'ClientStateExclusionDate')												:= R.CurrentExclusionStates(L.InputState = State and L.InputState <> '' and (INTEGER)R.CurrentExclusionStates(L.InputState = State)[1].REINSTATEMENT_DATE = 0)[1].Sanction_Date;

			SELF.#EXPAND(appendPrefix + 'ClientStateLicenseRevokedInd')										:= IF(EXISTS(R.RevokedExclusionStates(L.InputState = State and L.InputState <> '' and (INTEGER)R.RevokedExclusionStates(L.InputState = State)[1].REINSTATEMENT_DATE = 0)),'Y','N');
			SELF.#EXPAND(appendPrefix + 'ClientStateLicenseRevokedState')									:= R.RevokedExclusionStates(L.InputState = State and L.InputState <> '' and (INTEGER)R.RevokedExclusionStates(L.InputState = State)[1].REINSTATEMENT_DATE = 0)[1].State;
			SELF.#EXPAND(appendPrefix + 'ClientStateLicenseRevokedDate')									:= R.RevokedExclusionStates(L.InputState = State and L.InputState <> '' and (INTEGER)R.RevokedExclusionStates(L.InputState = State)[1].REINSTATEMENT_DATE = 0)[1].Sanction_Date;

			SELF.#EXPAND(appendPrefix + 'ClientPastStateExclusionDate')										:= SORT(R.PastExclusionStates,REINSTATEMENT_DATE)[1].Sanction_Date;
			SELF.#EXPAND(appendPrefix + 'ClientPastStateExclusionReinstDate')							:= SORT(R.PastExclusionStates,REINSTATEMENT_DATE)[1].REINSTATEMENT_DATE;
			
			SELF.#EXPAND(appendPrefix + 'ClientPastLicRevokedDate')												:= SORT(R.PastRevokedStates,REINSTATEMENT_DATE)[1].Sanction_Date;
			SELF.#EXPAND(appendPrefix + 'ClientPastLicRevokedReinstDate')									:= SORT(R.PastRevokedStates,REINSTATEMENT_DATE)[1].REINSTATEMENT_DATE;
			
			ClientExpiredLicenseFlag																											:= IF(COUNT (R.expiredlicensestates(L.InputState = State and L.InputState <> '' and DT_LIC_EXPIRATION > 0 and DT_LIC_EXPIRATION < (integer) CURRENT_DATE)) > 0,'Y','N');
			SELF.#EXPAND(appendPrefix + 'ClientExpiredLicenseInd')												:= IF(ClientExpiredLicenseFlag = 'Y' AND R.ExpiredLicenseFlag = 'Y','Y','N');
			SELF.#EXPAND(appendPrefix + 'ClientExpiredLicenseState')											:= R.expiredlicensestates(L.InputState = State and L.InputState <> '' and DT_LIC_EXPIRATION > 0 and DT_LIC_EXPIRATION < (integer) CURRENT_DATE)[1].State;
			SELF.#EXPAND(appendPrefix + 'ClientExpiredLicenseNumber')											:= R.expiredlicensestates(L.InputState = State and L.InputState <> '' and DT_LIC_EXPIRATION > 0 and DT_LIC_EXPIRATION < (integer) CURRENT_DATE)[1].LIC_NBR;
			SELF.#EXPAND(appendPrefix + 'ClientExpiredLicenseDate')											  := R.expiredlicensestates(L.InputState = State and L.InputState <> '' and DT_LIC_EXPIRATION > 0 and DT_LIC_EXPIRATION < (integer) CURRENT_DATE)[1].DT_LIC_EXPIRATION;

			SELF.#EXPAND(appendPrefix + 'ClientInactiveLicenseInd')												:= IF(COUNT (R.InactiveLicenseStates(L.InputState = State and L.InputState <> '' and DT_LIC_EXPIRATION > 0 and DT_LIC_EXPIRATION < (integer) CURRENT_DATE)) > 0 AND R.InactiveLicenseFlag = 'Y','Y','N');
			SELF.#EXPAND(appendPrefix + 'ClientInactiveLicenseState')											:= R.InactiveLicenseStates(L.InputState = State and L.InputState <> '' and DT_LIC_EXPIRATION > 0 and DT_LIC_EXPIRATION < (integer) CURRENT_DATE)[1].State;
			SELF.#EXPAND(appendPrefix + 'ClientInactiveLicenseNumber')										:= R.InactiveLicenseStates(L.InputState = State and L.InputState <> '' and DT_LIC_EXPIRATION > 0 and DT_LIC_EXPIRATION < (integer) CURRENT_DATE)[1].LIC_NBR;
			SELF.#EXPAND(appendPrefix + 'ClientInactiveLicenseDate')										  := R.InactiveLicenseStates(L.InputState = State and L.InputState <> '' and DT_LIC_EXPIRATION > 0 and DT_LIC_EXPIRATION < (integer) CURRENT_DATE)[1].DT_LIC_EXPIRATION;
			#IF((BOOLEAN)AppendProviderAttributes.ShellConfig.isCCPA) SELF.#EXPAND(appendPrefix + 'OptOutInd') := R.optoutind,#END
			SELF :=  L;
			SELF :=  R;
			SELF :=  [];
		END;		

		//can't guarantee that macJoinKey won't redistribute
		joinDsDist := DISTRIBUTE(joinDs2, HASH32(InputLnpid) );

		outJoinedDs := JOIN (validLnpidDsDist, joinDsDist, 
								LEFT.InputLnpid = RIGHT.InputLnpid, 
								tOutputRecord(LEFT, RIGHT),								
								LEFT OUTER, LOCAL);

		outInvalidLnpidDs	:= PROJECT( invalidLnpidDs, TRANSFORM(OutputRecord, SELF:=LEFT, SELF:=[]));	
		outResult := outJoinedDs + outInvalidLnpidDs;
		RETURN outResult;
ENDMACRO;