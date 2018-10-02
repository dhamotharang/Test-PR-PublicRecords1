IMPORT  ut, _Validate;

EXPORT Standardize_Input := MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fPreProcess( DATASET(QA_Data.Layouts.Input.Sprayed_Addresses)    pRawAddrInput
	                   ,DATASET(QA_Data.Layouts.Input.Sprayed_Transactions) pRawTransInput
										 ,STRING pversion) := FUNCTION
	     
    AddrDedup  := DISTRIBUTE(pRawAddrInput,  HASH(masteraddressid));	
    TransDedup := DISTRIBUTE(pRawTransInput, HASH(masteraddressid));

		QA_Data.Layouts.Base tPreProcessIndividuals(QA_Data.Layouts.Input.Sprayed_Transactions L
		                                           ,QA_Data.Layouts.Input.Sprayed_Addresses    R) := TRANSFORM
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			date_temp                               := StringLib.StringFilter(L.date, '0123456789')[1..8];
			SELF.dt_first_seen											:= IF(_validate.date.fIsValid(date_temp) and _validate.date.fIsValid(date_temp,_validate.date.rules.DateInPast)	,(UNSIGNED4)date_temp, 0);
			SELF.dt_last_seen												:= IF(_validate.date.fIsValid(date_temp) and _validate.date.fIsValid(date_temp,_validate.date.rules.DateInPast)	,(UNSIGNED4)date_temp, 0);
			SELF.dt_vendor_first_reported						:= IF(_validate.date.fIsValid(pversion[1..8]) and _validate.date.fIsValid(pversion[1..8],_validate.date.rules.DateInPast), (UNSIGNED4)pversion[1..8], 0);
			SELF.dt_vendor_last_reported						:= IF(_validate.date.fIsValid(pversion[1..8]) and _validate.date.fIsValid(pversion[1..8],_validate.date.rules.DateInPast), (UNSIGNED4)pversion[1..8], 0);
			SELF.record_type            						:= 'C';
			
			//Populate the raw transaction fields
			SELF.rawTrans.MasterAddressId						:= ut.CleanSpacesAndUpper(L.MasterAddressId);
			SELF.rawTrans.Date						          := ut.CleanSpacesAndUpper(L.Date);
			SELF.rawTrans.Category						      := ut.CleanSpacesAndUpper(L.Category);
			SELF.rawTrans.Subcategory						    := ut.CleanSpacesAndUpper(L.Subcategory);
			SELF.rawTrans.Name						          := ut.CleanSpacesAndUpper(L.Name);
			SELF.rawTrans.Company						        := ut.CleanSpacesAndUpper(L.Company);
			SELF.rawTrans.AddressOne						    := ut.CleanSpacesAndUpper(L.AddressOne);
			SELF.rawTrans.AddressTwo						    := ut.CleanSpacesAndUpper(L.AddressTwo);
			SELF.rawTrans.City						          := ut.CleanSpacesAndUpper(L.City);
			SELF.rawTrans.State						          := ut.CleanSpacesAndUpper(L.State);
			SELF.rawTrans.PostalCode						    := ut.CleanSpacesAndUpper(L.PostalCode);
			
			//Populate the raw address fields
			SELF.rawAddr.FirstName      						:= ut.CleanSpacesAndUpper(R.FirstName);
			SELF.rawAddr.MiddleInitial      				:= ut.CleanSpacesAndUpper(R.MiddleInitial);
			SELF.rawAddr.LastName      						  := ut.CleanSpacesAndUpper(R.LastName);
			SELF.rawAddr.Company      						  := ut.CleanSpacesAndUpper(R.Company);
			SELF.rawAddr.Other      						    := ut.CleanSpacesAndUpper(R.Other);
			SELF.rawAddr.Phone      						    := ut.CleanSpacesAndUpper(R.Phone);
			SELF.rawAddr.DatabaseMatchCode      		:= ut.CleanSpacesAndUpper(R.DatabaseMatchCode);
			SELF.rawAddr.HomeBusinessFlag      			:= ut.CleanSpacesAndUpper(R.HomeBusinessFlag);
			SELF.rawAddr.AddressOne      						:= ut.CleanSpacesAndUpper(R.AddressOne);
			SELF.rawAddr.AddressTwo      						:= ut.CleanSpacesAndUpper(R.AddressTwo);
			SELF.rawAddr.StreetNumber      					:= ut.CleanSpacesAndUpper(R.StreetNumber);
			SELF.rawAddr.PreDirection      					:= ut.CleanSpacesAndUpper(R.PreDirection);
			SELF.rawAddr.StreetName      						:= ut.CleanSpacesAndUpper(R.StreetName);
			SELF.rawAddr.StreetType						      := ut.CleanSpacesAndUpper(R.StreetType);
			SELF.rawAddr.PostDirection						  := ut.CleanSpacesAndUpper(R.PostDirection);
			SELF.rawAddr.Extension						      := ut.CleanSpacesAndUpper(R.Extension);
			SELF.rawAddr.ExtensionNumber						:= ut.CleanSpacesAndUpper(R.ExtensionNumber);
			SELF.rawAddr.Village						        := ut.CleanSpacesAndUpper(R.Village);
			SELF.rawAddr.City						            := ut.CleanSpacesAndUpper(R.City);
			SELF.rawAddr.State						          := ut.CleanSpacesAndUpper(R.State);
			SELF.rawAddr.ZipPlus4						        := ut.CleanSpacesAndUpper(R.ZipPlus4);
			SELF.rawAddr.ZipCode						        := ut.CleanSpacesAndUpper(R.ZipCode);
			SELF.rawAddr.ZipAddOn						        := ut.CleanSpacesAndUpper(R.ZipAddOn);
			SELF.rawAddr.CarrierRoute						    := ut.CleanSpacesAndUpper(R.CarrierRoute);
			SELF.rawAddr.PMB						            := ut.CleanSpacesAndUpper(R.PMB);
			SELF.rawAddr.PMBDesignator						  := ut.CleanSpacesAndUpper(R.PMBDesignator);
			SELF.rawAddr.DeliveryPoint						  := ut.CleanSpacesAndUpper(R.DeliveryPoint);
			SELF.rawAddr.DeliveryPointCheckDigit		:= ut.CleanSpacesAndUpper(R.DeliveryPointCheckDigit);
			SELF.rawAddr.CMRA						            := ut.CleanSpacesAndUpper(R.CMRA);
			SELF.rawAddr.DPV						            := ut.CleanSpacesAndUpper(R.DPV);
			SELF.rawAddr.DPVFootnote						    := ut.CleanSpacesAndUpper(R.DPVFootnote);
			SELF.rawAddr.CongressDistrict						:= ut.CleanSpacesAndUpper(R.CongressDistrict);
			SELF.rawAddr.County						          := ut.CleanSpacesAndUpper(R.County);
			SELF.rawAddr.CountyNumber						    := ut.CleanSpacesAndUpper(R.CountyNumber);
			SELF.rawAddr.StateNumber						    := ut.CleanSpacesAndUpper(R.StateNumber);
			SELF.rawAddr.Latitude						        := ut.CleanSpacesAndUpper(R.Latitude);
			SELF.rawAddr.Longitude						      := ut.CleanSpacesAndUpper(R.Longitude);
			SELF.rawAddr.CensusTract						    := ut.CleanSpacesAndUpper(R.CensusTract);
			SELF.rawAddr.BlockNumber						    := ut.CleanSpacesAndUpper(R.BlockNumber);
			SELF.rawAddr.BlockGroup						      := ut.CleanSpacesAndUpper(R.BlockGroup);
			SELF.rawAddr.MasterAddressId						:= ut.CleanSpacesAndUpper(R.MasterAddressId);			
			SELF 																		:= L;
			SELF 																		:= R;
			SELF 																		:= [];
			
		END;
		
		dPreProcess := JOIN(TransDedup
		                   ,AddrDedup
                       ,stringlib.stringcleanspaces(LEFT.masteraddressid) = stringlib.stringcleanspaces(RIGHT.masteraddressid)
                       ,tPreProcessIndividuals(LEFT, RIGHT)
									     ,RIGHT OUTER, LOCAL);

    dPreProcess_dedup  := DEDUP( SORT( DISTRIBUTE(dPreProcess, HASH(rawAddr.MasterAddressId) ), RECORD, LOCAL ), RECORD, LOCAL );	
	
		RETURN dPreProcess_dedup;

	END;  //End fPreProcess
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(QA_Data.Layouts.Input.Sprayed_Addresses)     pRawAddrInput
							,DATASET(QA_Data.Layouts.Input.Sprayed_Transactions)  pRawTransInput
							,STRING                                               pversion
							,STRING                                               pPersistname = QA_Data.Persistnames().StandardizeInput
	           ) := FUNCTION
	
		dPreprocess					:= fPreProcess(pRawAddrInput,pRawTransInput,pversion	) : PERSIST(pPersistname);

		RETURN dPreprocess;
	
	END;

END;