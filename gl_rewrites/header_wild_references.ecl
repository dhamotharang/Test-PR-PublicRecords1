import doxie;
export header_wild_references(
	gl_rewrites.person_interfaces.i__header_wild_references in_parms) :=
		function
			IF(in_parms.is_inv_wildcard, FAIL(302, doxie.ErrorCodes(302)));

			Fetched_dups := MAP( (unsigned8)in_parms.did_value<>0 	
											 => Fetch_Header_Did(in_parms),
													 (unsigned8)in_parms.rid_value<>0 								
															=> Fetch_Header_Rid(in_parms),
								 length(trim(in_parms.ssn_value))=9 
															=> if(in_parms.score_threshold_value>10, 
													 Fetch_header_wild_ssn(in_parms) + Fetch_header_wild_StNameSmall(in_parms), 
												Fetch_header_wild_ssn(in_parms)),
							 in_parms.phone_value<>'' 									
															=> Fetch_Header_Wild_Phone(in_parms),
							 // Given a Street name, with some (potentially accidental) fuzziness
							 in_parms.pname_value<>'' AND in_parms.zip_value<>[]  AND 
								(in_parms.prange_value='' OR in_parms.addr_error_value OR in_parms.addr_loose)						
													 => Fetch_Header_Wild_Street(in_parms),
							 // Given an Full address, or partial with not much else to go on
							 in_parms.pname_value<>'' AND 
								(in_parms.prange_value<>'' or in_parms.lname_wild_val='') AND 
								(~in_parms.addr_error_value 	or in_parms.addr_loose)					
													 => Fetch_Header_Wild_Address(in_parms) + 
												IF(in_parms.any_addr_error_value and ~(in_parms.pname_wild or in_parms.addr_wild), Fetch_Header_Wild_Zip(in_parms)),
							 //Allow ssn value to be 4 or 5 digits			    
							 length(trim(in_parms.ssn_value)) in [4,5]
															=> Fetch_header_wild_SSN_partial(in_parms),			    
							 // Otherwise, at this point, if there's no last name...
							 in_parms.lname_wild_val=''			
															=> Fetch_Header_Wild_FnameSmall(in_parms),
							 // Zip-Radius
							 in_parms.zip_value<>[]												
															=> Fetch_Header_Wild_Zip(in_parms),
							 // Just a Name
							 in_parms.city_value='' AND in_parms.state_value='' 		
															=> Fetch_Header_Wild_Name(in_parms),
							 // State+Name 
							 in_parms.city_value=''	 											
															=> Fetch_Header_Wild_StFLName(in_parms),
							 // Otherwise, try the City/State/Name key
							 Fetch_Header_Wild_StCityFLName(in_parms)
								);

			fetched := dedup(Fetched_dups,all);

			return fetched;
		END;