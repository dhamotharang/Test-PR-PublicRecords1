
IMPORT doxie, ut, STD;

EXPORT CurrentResidents := MODULE

	// The following function first performs a 'large geographical area' (i.e. state, city, zip) match hopefully
	// based on either set-of-zips or city-state. Whichever match criteria are met, the resultant set is then  
	// matched further on street address data. We will make use of NNEQ to match even if there's incomplete user 
	// input. For example, it will filter on '123 S. Main Street' as well as just 'Main Street'.
	SHARED MatchOnAddressCriteria(DATASET(doxie.Layout_presentation) ds_first_cut, 
																doxie.Header_File_Interfaces.i_AddressInfo_Basic m_AddrInfo, 
																BOOLEAN valid_addr_city_state, BOOLEAN valid_addr_zip) :=
		FUNCTION
						
			// If we have a valid set of zips, we will evaluate those, trumping a valid city-state only.
			ds_large_area_matches := 
				MAP( valid_addr_zip        => ds_first_cut( (INTEGER)zip  IN  m_AddrInfo.zips ),
             valid_addr_city_state => ds_first_cut(ut.NNEQ(city_name, m_AddrInfo.city) AND
																									 ut.NNEQ(st,        m_AddrInfo.state))
						);
			
			ds_address_matches := ds_large_area_matches( ut.NNEQ(prim_name,  m_AddrInfo.prim_name) AND
																									 ut.NNEQ(prim_range, m_AddrInfo.prim_range) AND
																									 ut.NNEQ(predir,     m_AddrInfo.predir) AND
																									 ut.NNEQ(suffix,     m_AddrInfo.suffix) AND
																									 ut.NNEQ(postdir,    m_AddrInfo.postdir) AND
																									 ut.NNEQ(sec_range,  m_AddrInfo.sec_range) );
			RETURN ds_address_matches;
			
		END;
		
		
	// The following function obtains initially a first-cut set of records based on a current dt_last_seen 
	// and TNT code != 'H'. Current residency is defined in the body of this function. This first cut will 
	// certainly include addresses not specified by the user input.	
	//		
	// It then attempts to prune further, eliminating any addresses that don't match the user input. 
	// This second cut is harder, since we have to do some address matching. Rules:
	// 1. User inputs "Addr" AND "City" AND "State", and/or
	// 2. User inputs "Addr" AND "Zip".
	//
	// If the user inputs enough information to fulfill one or both conditions, we match the input address
	// against the addresses found in the first-cut dataset. Else, we return the dataset as is.
	// 
	// As a concomitant condition, for "Addr", the possible, useful criteria are: prim_range, predir, 
	// prim_name, suffix, postdir, and sec_range. To have enough useful data for matching, we need at least  
	// prim_name. If we don't have a prim_name, we return the dataset as is. 
	SHARED GetCurrentResidents(DATASET(doxie.Layout_presentation) ds_all_records, 
	                           doxie.Header_File_Interfaces.i_AddressInfo_Basic m_AddrInfo) := 
		FUNCTION
			// Define 'current residency':
			TODAY_YYYYMM := STD.Date.Today() DIV 100;
			ONE_YEAR     := 100;
			THRESHOLD_DATE_FOR_CURRENT_RESIDENCY := (TODAY_YYYYMM - ONE_YEAR);
							
			// Derived flags:		
			BOOLEAN valid_addr_city_state := 
				IF( m_AddrInfo.prim_name != '' AND 
						m_AddrInfo.city != ''  AND 
						m_AddrInfo.state != '',
						TRUE,
						FALSE
					 );
					 
			BOOLEAN valid_addr_zip :=
				IF( m_AddrInfo.prim_name != '' AND
						m_AddrInfo.zips != [],
						TRUE,
						FALSE
					 );					
			
			// Prune off non-current records:
			ds_first_cut := ds_all_records(dt_last_seen > THRESHOLD_DATE_FOR_CURRENT_RESIDENCY);

			// Next, prune those records that do not match the input address:		
			ds_second_cut := IF( valid_addr_city_state OR valid_addr_zip,
													 MatchOnAddressCriteria(ds_first_cut, m_AddrInfo, valid_addr_city_state, valid_addr_zip),
													 ds_first_cut
													);		
			RETURN ds_second_cut;
			
		END;


	// The following function returns a filtered set of records--effectively those whose residency is 'current',
	// provided that no personal information is included in the original search criteria. NOTE: if we ever want 
	// to return a current residency of some sort when personal information IS included, the appropriate hook is 
	// the 'ELSE' clause in the conditional statement.
	EXPORT fn_GetCurrentResidentsOnly(DATASET(doxie.Layout_presentation) ds_all_records, 
																		doxie.Header_File_Interfaces.i_PersonalInfo_Basic m_PersInfo, 
																		doxie.Header_File_Interfaces.i_AddressInfo_Basic m_AddrInfo) := 
		FUNCTION

			// Determine whether any of the personally-identifying fields contain data: 
			PersonalDataAreNull() :=
				m_PersInfo.did   =  0 AND m_PersInfo.fname = '' AND m_PersInfo.mname = '' AND
				m_PersInfo.lname = '' AND m_PersInfo.ssn   = '' AND m_PersInfo.dob   =  0;
		
			// Obtain current residents for an address-only search.
			ds_current_residents := IF( PersonalDataAreNull(),
																	GetCurrentResidents(ds_all_records, m_AddrInfo),
																	ds_all_records
																 );
			
			RETURN ds_current_residents;
			
		END;

END; // Module