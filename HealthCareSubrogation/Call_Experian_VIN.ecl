IMPORT iesp, ut, Gateway, Doxie,  Royalty;
EXPORT Call_Experian_VIN (iesp.bpsreport.t_BpsReportBy Input, STRING8 Date_of_Service) := FUNCTION
	
		iesp.experian_vin.t_ExperianVinRequest setVinReq() := TRANSFORM
			SELF.User.ReferenceCode 										:= ut.getTime(); 
			SELF.User.BillingCode 											:= '';
			SELF.User.QueryID 													:= 'HealthCareSubrogation';
			SELF.User.GLBPurpose 												:= '1';
			SELF.User.DLPurpose 												:= '1';
			SELF.Options 																:= [];
			SELF.getVinVerifyPlus.quoteback 						:= 'quoteback';// default?
			SELF.getVinVerifyPlus.dppaUseCode 					:= '1';
			SELF.getVinVerifyPlus.dppaSubCategoryCode 	:= 'L';
			STRING SubCustomerID 												:= 'BR';
			SELF.getVinVerifyPlus.SubCustomerId 				:= IF(SubCustomerID!='',SubCustomerID,'BR');
			SELF.getVinVerifyPlus.processType 					:= 'N';
			SELF.getVinVerifyPlus.inquiryType 					:= '1';
			SELF.getVinVerifyPlus.firstName 						:= TRIM(Input.Name.first);
			SELF.getVinVerifyPlus.middleName 						:= TRIM(Input.Name.middle);
			SELF.getVinVerifyPlus.lastName 							:= TRIM(Input.Name.last);
			SELF.getVinVerifyPlus.nameSuffix 						:= TRIM (Input.Name.suffix);
			SELF.getVinVerifyPlus.firmBusinessName 			:= '';
			SELF.getVinVerifyPlus.addressType 					:= ''; 
			SELF.getVinVerifyPlus.range 								:= Input.Address.StreetNumber;
			SELF.getVinVerifyPlus.preDirectional 				:= Input.Address.StreetPreDirection;
			SELF.getVinVerifyPlus.streetName 						:= Input.Address.StreetName; //IF(~isPoBox AND ~isRRTyp,clnAddr.prim_name,'');
			SELF.getVinVerifyPlus.addressSuffix 				:= Input.Address.StreetSuffix;
			SELF.getVinVerifyPlus.postDirectional 			:= Input.Address.StreetPostDirection; 
			SELF.getVinVerifyPlus.pob 									:=  ''; 
			SELF.getVinVerifyPlus.ruralRouteNumber			:= ''; 
			SELF.getVinVerifyPlus.ruralRouteBox 				:= '';
			SELF.getVinVerifyPlus.apartmentNumber 			:= Input.Address.UnitNumber;
			SELF.getVinVerifyPlus.city 									:= Input.Address.City;
			SELF.getVinVerifyPlus.state 								:= Input.Address.State;
			SELF.getVinVerifyPlus.zipCode 							:= Input.Address.Zip5;
			SELF.getVinVerifyPlus.zipFour 							:= Input.Address.Zip4;
			SELF.getVinVerifyPlus.vin 									:= '';
			SELF.getVinVerifyPlus.year 									:= '';
			SELF.getVinVerifyPlus.make 									:= '';
			SELF.getVinVerifyPlus.model 								:= '';
			SELF.getVinVerifyPlus.plateNumber 					:= '';
			SELF.getVinVerifyPlus.plateState						:= '';
			SELF := [];
		END;

		vinReq := DATASET([setVinReq()]);
		gateway_cfg					 := Gateway.Configuration.Get();
		experian_gateway_cfg := gateway_cfg(~doxie.DataPermission.use_Polk, Gateway.Configuration.IsExperian(servicename));	
		dummy_ds := dataset ([],iesp.experian_vin.t_ExperianVinResponseEx);		
		isValidRequest := Input.Address.StreetName <> '' and Input.Address.Zip5 <> '';
	// changing the logic below to be as close as possible to the one used in Get_Polk_Data.
		vMakeGWCall := experian_gateway_cfg[1].Url !='' and isValidRequest;
	// STRING serviceURL := 'http://webapp_roxie_test:web33436$@10.194.5.12:5004/';		
		VIN_Resp := if (isValidRequest,Gateway.SoapCall_Experian(vinReq, gateway_cfg[1],,,vMakeGWCall),dummy_ds); 

		r := record
			string quoteback;
			string firstName; 
			string fullNameFlag; 
			string lastName; 
			string middleName; 
			string nameSuffix; 
			string surnameFlag;
			string addressMatchFlag;
			string vin;
			string registration_date;
		end;

		r norm_veh(iesp.experian_vin.t_ExperianVinResponseEx R, integer c) := TRANSFORM
			SELF.quoteback	:= r.response.response.quoteback; 
			SELF.firstName := r.response.response.vehicles[c].RegisteredOwners(nameRole = 'OWNER')[1].firstName; 
			SELF.fullNameFlag := r.response.response.vehicles[c].RegisteredOwners(nameRole = 'OWNER')[1].fullNameFlag; 
			SELF.lastName	:= r.response.response.vehicles[c].RegisteredOwners(nameRole = 'OWNER')[1].lastName; 
			SELF.middleName	:= r.response.response.vehicles[c].RegisteredOwners(nameRole = 'OWNER')[1].middleName; 
			SELF.nameSuffix	:= r.response.response.vehicles[c].RegisteredOwners(nameRole = 'OWNER')[1].nameSuffix; 
			SELF.surnameFlag	:= r.response.response.vehicles[c].RegisteredOwners(nameRole = 'OWNER')[1].surnameFlag; 
			SELF.addressMatchFlag	:= r.response.response.vehicles[c].addressMatchFlag; 
			SELF.vin	:= r.response.response.vehicles[c].vin; 
			SELF.registration_date := r.response.response.vehicles[c].registrationExpireDate;
		END;

		Vin_Result := SORT(NORMALIZE(VIN_Resp, max(count(LEFT.response.response.vehicles),1), norm_veh (LEFT, COUNTER)) (VIN <> '' AND fullNameFlag = 'Y'),-Registration_Date); 
		
		// VIN_Rec := RECORD
			// STRING25 Vin;
		// end;
		// output (experian_gateway_cfg,named('experian_gateway_cfg'));
		// Output (vinReq,named('vinReq')); 
		// Output (VIN_Resp,named('VIN_Resp')); 
		// output (Vin_Result,named('Vin_Result'));
		// STRING25 Experian_VIN := PROJECT (Vin_Result,VIN_REC)[1].VIN;
		// royalties := Royalty.RoyaltyVehicles.MAC_GetRoyalties(Vin_Result);			
		// IF(vMakeGWCall, OUTPUT(royalties, NAMED('RoyaltySet')));		
		RETURN Vin_Result;
END;

