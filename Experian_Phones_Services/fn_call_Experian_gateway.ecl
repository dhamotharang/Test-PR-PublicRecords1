
IMPORT Gateway, iesp, progressive_phone;

EXPORT fn_call_Experian_gateway( 
					DATASET(Gateway.Layouts.Config) gateways_in, 
					DATASET(progressive_phone.layout_experian_phones) ds_inhouse_Experian_recs_for_Gateway) := 
	FUNCTION
	
				err := Constants.Search_Errors;
				
				progressive_phone.layout_progressive_phones.layout_exp_multiple_phones GetMultPhones(
															progressive_phone.layout_experian_phones le) := TRANSFORM
					SELF.Phones_Last3Digits := CHOOSEN(DATASET([{(le.Phone_Last3Digits)}], 
																			progressive_phone.layout_progressive_phones.Phone_Last3Digits), 
																			iesp.Constants.MaxCountLast3Digits);
					SELF := le;
				END;
				
        ds_mult_phones_exp := PROJECT(ds_inhouse_Experian_recs_for_Gateway, getMultPhones(LEFT));				
				
				// Submit in-house Experian records to the Experian Gateway. The following code is 
				// cribbed from AddrBest.Progressive_phone_common, lines 473-481.
				metronetGateway_cfg := gateways_in(Gateway.Configuration.IsMetronet(servicename))[1];
				metronetGatewayURL := metronetGateway_cfg.url;
				f_out_experian_phones := 
						IF(
							metronetGatewayURL != '', 
							ds_mult_phones_exp, 
							DATASET([], progressive_phone.layout_progressive_phones.layout_exp_multiple_phones)
						);
				
				f_out_gateway := 
					PROJECT(
						f_out_experian_phones,
						  TRANSFORM(progressive_phone.layout_progressive_phones.layout_exp_multiple_phones,
							SELF := Gateway.SoapCall_Metronet(DATASET(LEFT), metronetGateway_cfg)[1], // gateway call
							SELF := []
						)
					);
				
				f_out_gateway_with_error_code :=
					PROJECT(
						f_out_gateway,
						TRANSFORM( progressive_phone.layout_experian_phones,
							SELF.error_code := 
								IF( TRIM(LEFT.subj_phone10) != '',
										err.GATEWAY_RECORD_FOUND, 
										err.GATEWAY_RECORD_NOT_FOUND
								),
							SELF := LEFT
						)
					);
					
				RETURN f_out_gateway_with_error_code;
	END;



// ======================== JUNK =========================
/*
	// f_out_gateway := Gateway.SoapCall_Metronet(f_out_experian_phones, metronetGateway_cfg);
*/