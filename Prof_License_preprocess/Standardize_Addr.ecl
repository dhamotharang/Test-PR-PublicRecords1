IMPORT Address,ut;

//////////////////////////////////////////////////////////////////////////////////////
// -- Apply AID process on the entire base recs for getting fresh address.
//////////////////////////////////////////////////////////////////////////////////////
EXPORT Standardize_Addr := module

export prolic(DATASET(layout_prolic_in_clean) pBaseFile) := module 

	tempLayout := RECORD
		STRING100 street_info;
		STRING50	city_st_zip;
		layout_prolic_in_clean;
	END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	tempLayout tPreProcess(pBaseFile L) := TRANSFORM
    // NOTE: All address pieces are already upper case, no need to apply that logic again.
		
		
	new_address1 := map ( TRIM(L.orig_city) <> '' => TRIM(L.orig_addr_1) + ' ' + TRIM(L.orig_addr_2) + ' ' + TRIM(L.orig_addr_3) + ' ' + TRIM(L.orig_addr_4) ,
                        regexfind(L.source_st+'|[0-9]{5}$',  TRIM(L.orig_addr_2))    =>  TRIM(L.orig_addr_1),
												regexfind(L.source_st+'|[0-9]{5}$',  TRIM(L.orig_addr_3))   =>  TRIM(L.orig_addr_1) + ' '+ TRIM(L.orig_addr_2),
												TRIM(L.orig_addr_1) + ' '+ TRIM(L.orig_addr_2) + ' ' + TRIM(L.orig_addr_3)
												);
												
				
											

		new_address2 := map ( TRIM(L.orig_city) <> '' or (TRIM(L.orig_addr_2) = '' and TRIM(L.orig_addr_3) = '')  => address.Addr2FromComponents (  TRIM(L.orig_city) ,TRIM(L.orig_st),TRIM(L.orig_zip[1..5])),
		                    regexfind(L.source_st+'|[0-9]{5}$',  TRIM(L.orig_addr_2)) or regexfind(L.source_st+'|[0-9]{5}$', TRIM(L.orig_addr_3))  => TRIM(L.orig_addr_2) + ' ' + TRIM(L.orig_addr_3)  ,
												TRIM(L.orig_addr_4)
												);
			
		              
									            
		SELF.street_info := new_address1;
		SELF.city_st_zip := new_address2;

		SELF := L;
	END;

	dPreAddrRec := PROJECT(pBaseFile, tPreProcess(LEFT));

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes addresses using the AID macro
	//////////////////////////////////////////////////////////////////////////////////////
	HasAddress :=	dPreAddrRec.city_st_zip != '';

	dWith_address		 := dPreAddrRec(HasAddress);
	dWithout_address := dPreAddrRec(NOT(HasAddress));


	Address.MAC_Address_Clean(dWith_address, street_info, city_st_zip, true, dwithClean);

	export dBase := PROJECT(dwithClean,
		               TRANSFORM(layout_prolic_in_clean,
			                         self.clean_address := left.clean;
														 
			                       SELF := LEFT;)) + PROJECT(dWithout_address,  transform(layout_prolic_in_clean, self.clean_address :='', self := left));

	

END;




end;