IMPORT BatchShare, Doxie, Gateway, PhoneOwnership, Phones;
EXPORT IParams := MODULE

		EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParams,Phones.IParam.inZumigoParams)
			EXPORT BOOLEAN	 contactRiskFlag		 						:= FALSE;
			EXPORT UNSIGNED1 search_level										:= 0;	
			EXPORT BOOLEAN 	 returnCurrent									:= FALSE;
			EXPORT UNSIGNED1 MaxIdentityCount 							:= 1;		
			EXPORT STRING    reverse_phonescore_model 			:= '';
			EXPORT BOOLEAN   useZumigo											:= FALSE;			
			EXPORT BOOLEAN   useAccudataCNAM								:= FALSE;					
		END;	

		EXPORT getBatchParams() := FUNCTION
			
			mBaseParams := BatchShare.IParam.getBatchParams();
			
			in_mod := MODULE(PROJECT(mBaseParams, BatchParams, OPT))					
				EXPORT BOOLEAN   contactRiskFlag				:= FALSE 	: STORED('contact_risk_flag');						
				EXPORT DATASET   (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get(); 
				STRING useCaseMask								:= '' : STORED('use_case');
				EXPORT STRING20  useCase						:= IF((UNSIGNED)useCaseMask[3]>0,PhoneOwnership.Constants.UseCaseValues[3],'');//PhoneOwnership.Functions.getUseCase(useCaseMask);
				EXPORT STRING3   productCode	 				:= '' : STORED('product_code');
				EXPORT STRING8   billingId 						:= '' : STORED('billing_id');	
				STRING searchLevel								:= '' : STORED('search_level');		
				EXPORT UNSIGNED1 search_level 					:= PhoneOwnership.Functions.getSearchLevel(searchLevel);																														
				EXPORT BOOLEAN   returnCurrent					:= TRUE : STORED('return_current');		
				EXPORT UNSIGNED1 MaxIdentityCount  				:= 1;//  : STORED('MaxIdentityCount');	- Future development
				EXPORT STRING    reverse_phonescore_model 		:= '' : STORED('reverse_phonescore_model');		
				EXPORT BOOLEAN   useZumigo					  	:= Doxie.DataPermission.use_ZumigoIdentity AND search_level = PhoneOwnership.Constants.SearchLevel.ULTIMATE;					
				EXPORT BOOLEAN   NameAddressValidation			:= useZumigo;	
				EXPORT BOOLEAN   NameAddressInfo				:= FALSE;	
				EXPORT BOOLEAN   AccountInfo					:= FALSE;	
				EXPORT BOOLEAN   AccountStatusInfo				:= useZumigo;
				EXPORT BOOLEAN   CarrierInfo					:= FALSE;	
				EXPORT BOOLEAN   CallHandlingInfo				:= FALSE;
				EXPORT BOOLEAN   DeviceInfo						:= FALSE;	
				EXPORT BOOLEAN   DeviceHistory					:= FALSE;
				EXPORT STRING10  OptInType 						:= IF(useZumigo,Phones.Constants.ZumigoInputOptions.OptInType,'');	
				EXPORT STRING5   OptInMethod 					:= IF(useZumigo,Phones.Constants.ZumigoInputOptions.TCPA_OptInMethod,'');		
				EXPORT STRING3   OptinDuration 					:= IF(useZumigo,Phones.Constants.ZumigoInputOptions.ONE_OptinDuration,'');	;	
				EXPORT STRING    OptinId 						:= '1';	
				EXPORT STRING    OptInVersionId 				:= '';	
				EXPORT STRING15  OptInTimestamp 				:= '';	
				EXPORT BOOLEAN   useAccudataCNAM		  		:= ~Doxie.DataRestriction.AccuData AND search_level <> PhoneOwnership.Constants.SearchLevel.BASIC;	// this includes Ultimate			
			END;
			
			RETURN in_mod;
		END;

END;