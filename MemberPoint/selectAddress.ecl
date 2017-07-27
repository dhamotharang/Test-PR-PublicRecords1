IMPORT Address, AddrBest;

	EXPORT selectAddress( dataset(MemberPoint.Layouts.BestExtended) dsBestE, 
												dataset(AddrBest.Layout_BestAddr.batch_out_final) dsBestAddress,
												dataset(MemberPoint.Layouts.BatchInter) BatchInter, 
												MemberPoint.IParam.BatchParams BParams)  := FUNCTION

				
		MemberPoint.Layouts.AddressesRec SelectionXform(BatchInter l )  := transform
			self.acctno  	:= l.acctno;
			/* Run the core address selection engine	*/
			MemberPoint.MacAddressSelectionEngine();
			/*Conditionally start filling the output  */
			fillWithADLBest:= FillAddressWith = MemberPoint.Constants.FillWith.ADL_BEST;
			fillWithADLBestAddress:= FillAddressWith = MemberPoint.Constants.FillWith.BEST_ADDRESS;
			fillWithNewADLBestAddress:= FillNewAddressWith  = MemberPoint.Constants.FillWith.BEST_ADDRESS;
			self.address_match_codes := map(fillWithADLBest	=> ADLBest_address_match_codes,
																			fillWithADLBestAddress => BestAddress_address_match_codes,
																			'X'); 
			self.address := map(fillWithADLBest => ADLBestAdd1,
													fillWithADLBestAddress => BestAddressAdd1,
													'');
			self.city := map(fillWithADLBest => BestRow.c_best_p_city_name,
												fillWithADLBestAddress => BestAddressRow.p_city_name,
												''); 
			self.st := map(fillWithADLBest => BestRow.c_best_st,
											fillWithADLBestAddress => BestAddressRow.st,
											''); 
			self.z5 := map(fillWithADLBest => BestRow.c_Best_z5,
											fillWithADLBestAddress => BestAddressRow.z5,
											''); 
			self.zip4	:= map(fillWithADLBest => BestRow.c_best_zip4,
												fillWithADLBestAddress => BestAddressRow.zip4,
												'');
			self.county_name := map(fillWithADLBest => BestRow.c_best_county,
															fillWithADLBestAddress => BestAddressRow.county_name,
															''); 
			self.addr_dt_last_seen := map(fillWithADLBest => (string)BestRow.best_addr_date,
																		fillWithADLBestAddress => BestAddressRow.addr_dt_last_seen,
																		''); 
			self.addr_dt_first_seen := map(fillWithADLBest => '',
																			fillWithADLBestAddress => BestAddressRow.addr_dt_first_seen,
																			''); 
			self.addr_confidence:= map(fillWithADLBest => BestConfidence,
																	fillWithADLBestAddress => BestAddressConfidence,
																	''); 
			self.latitude := map(fillWithADLBest => BestRow.c_best_latitude,
														fillWithADLBestAddress => BestAddressRow.latitude,
														''); 
			self.longitude := map(fillWithADLBest => BestRow.c_best_longitude,
														fillWithADLBestAddress => BestAddressRow.longitude,
														'');
			self.address_new_match_codes	:=	if(fillWithNewADLBestAddress ,BestAddress_address_match_codes,'X');
			self.address_new  := 					if(fillWithNewADLBestAddress , BestAddressAdd1,'');
			self.city_new  := 						if(fillWithNewADLBestAddress , BestAddressRow.p_city_name,''); 
			self.st_new  := 							if(fillWithNewADLBestAddress , BestAddressRow.st,''); 
			self.z5_new   := 							if(fillWithNewADLBestAddress , BestAddressRow.z5,''); 
			self.zip4_new  := 						if(fillWithNewADLBestAddress , BestAddressRow.zip4,''); 
			self.county_name_new  := 			if(fillWithNewADLBestAddress , BestAddressRow.county_name,'');
			self.addr_dt_last_seen_new := if(fillWithNewADLBestAddress , BestAddressRow.addr_dt_last_seen,''); 
			self.addr_dt_first_seen_new := if(fillWithNewADLBestAddress , BestAddressRow.addr_dt_last_seen,''); 
			self.addr_confidence_new := 	if(fillWithNewADLBestAddress , BestAddressConfidence,''); 
			self.latitude_new	:= 					if(fillWithNewADLBestAddress , BestAddressRow.latitude,'');
			self.longitude_new := 				if(fillWithNewADLBestAddress , BestAddressRow.longitude,'');
		end;
	
		dsSelectedAddresses := project(BatchInter,SelectionXform(left));

		RETURN(dsSelectedAddresses);
	END;