
IMPORT AutoStandardI;

// A group of generic functions for simple penalization of Name, Company Name, and Address pairs.

EXPORT mod_penalize := MODULE

	// ]==========[ Penalize a matched Address ]==========
	
	EXPORT IGenericAddress := INTERFACE
		EXPORT STRING prim_range  := '';
		EXPORT STRING predir      := '';
		EXPORT STRING prim_name   := '';
		EXPORT STRING postdir     := '';
		EXPORT STRING addr_suffix := '';
		EXPORT STRING sec_range   := '';
		EXPORT STRING p_city_name := '';
		EXPORT STRING st          := '';
		EXPORT STRING z5          := '';
		EXPORT BOOLEAN allow_wildcard := FALSE;											
		EXPORT BOOLEAN useGlobalScope := FALSE;
	END;

	// Calculate penalty for a pair of addresses.			
	EXPORT address(IGenericAddress input_address, IGenericAddress matched_address) :=
		FUNCTION			
		
			IAddress := PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt);

			mod_addr := 
				MODULE(IAddress)					
						// The 'input' address:
					EXPORT prim_name       := input_address.prim_name;
					EXPORT predir          := input_address.predir;
					EXPORT prim_range      := input_address.prim_range;
					EXPORT postdir         := input_address.postdir;
					EXPORT addr_suffix     := input_address.addr_suffix;
					EXPORT sec_range       := input_address.sec_range;
					EXPORT p_city_name     := input_address.p_city_name;
					EXPORT st              := input_address.st;
					EXPORT z5              := input_address.z5;					
						// The address in the matching record:						
					EXPORT pname_field     := matched_address.prim_name;
					EXPORT predir_field    := matched_address.predir;
					EXPORT prange_field    := matched_address.prim_range;
					EXPORT postdir_field   := matched_address.postdir;
					EXPORT suffix_field    := matched_address.addr_suffix;
					EXPORT sec_range_field := matched_address.sec_range;
					EXPORT city_field      := matched_address.p_city_name;
					EXPORT city2_field     := '';
					EXPORT state_field     := matched_address.st;
					EXPORT zip_field       := matched_address.z5;
						// Booleans to control behavior.
					EXPORT allow_wildcard  := matched_address.allow_wildcard;											
					EXPORT useGlobalScope  := matched_address.useGlobalScope;
				END;
				
			RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(mod_addr);
		END;	

	EXPORT address_is_exact_match(IGenericAddress input_address, IGenericAddress matched_address) :=
		FUNCTION			
		
			is_exact_match :=			
				input_address.prim_name    = matched_address.prim_name AND 
				input_address.predir       = matched_address.predir AND 
				input_address.prim_range   = matched_address.prim_range AND 
				input_address.postdir      = matched_address.postdir AND 
				input_address.addr_suffix  = matched_address.addr_suffix AND 
				input_address.sec_range    = matched_address.sec_range AND 
				input_address.p_city_name  = matched_address.p_city_name AND 
				input_address.st           = matched_address.st AND 
				input_address.z5           = matched_address.z5;			

			RETURN is_exact_match;
		END;	

	// ]==========[ Penalize a matched Person Name ]==========

	EXPORT IGenericPersonName := INTERFACE
		EXPORT STRING name_last   := '';
		EXPORT STRING name_first  := '';
		EXPORT STRING name_middle := '';
	END;
	
	EXPORT person_name(IGenericPersonName input_personname, IGenericPersonName matched_personname) := 
		FUNCTION
			IPersonName := PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt);
  
			mod_personname := 
				MODULE(IPersonName)						
					EXPORT lastname       := input_personname.name_last;  
					EXPORT middlename     := input_personname.name_middle;
					EXPORT firstname      := input_personname.name_first; 
					
					EXPORT lname_field    := matched_personname.name_last;
					EXPORT mname_field    := matched_personname.name_middle;
					EXPORT fname_field    := matched_personname.name_first;						
						// Booleans to control behavior.
					EXPORT allow_wildcard := FALSE;
				END;	
			
			RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(mod_personname);
	END;
	
	// ]==========[ Penalize a matched Company Name ]==========

	EXPORT company_name(STRING input_companyname, STRING matched_companyname) := 
		FUNCTION
			ICompanyName := PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt);
			
			mod_bizname := 
				MODULE(ICompanyName)
					EXPORT companyname 			:= input_companyname;									
					EXPORT cname_field 			:= matched_companyname;		
					EXPORT allow_wildcard 	:= FALSE;
				END;	
				
			RETURN AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(mod_bizname);
	END;

	EXPORT company_name_is_exact_match(STRING input_companyname, STRING matched_companyname) := 
		FUNCTION
			RETURN TRIM(input_companyname,LEFT,RIGHT) = TRIM(matched_companyname,LEFT,RIGHT);
	END;

	EXPORT standardized_company_name_is_exact_match(STRING input_companyname, STRING matched_companyname) := 
		FUNCTION
			input_companyname_std   := stringlib.StringFilter(stringlib.StringToUpperCase(input_companyname),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
			matched_companyname_std := stringlib.StringFilter(stringlib.StringToUpperCase(input_companyname),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
			RETURN input_companyname_std = matched_companyname_std;
		END;
	
	// ]==========[ Penalize a matched SSN ]==========

	EXPORT SSN(STRING input_ssn, STRING matched_ssn) := 
		FUNCTION
			ISocialSecurityNumber := PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_SSN.full,opt);
			
			mod_SSN := 
				MODULE(ISocialSecurityNumber)
					EXPORT ssn      			:= input_ssn;									
					EXPORT ssn_field 			:= matched_ssn;		
					EXPORT allow_wildcard := FALSE;
				END;	
			RETURN AutoStandardI.LIBCALL_PenaltyI_SSN.val(mod_SSN);
	END;

	EXPORT ssn_is_exact_match(STRING input_ssn, STRING matched_ssn) := 
		FUNCTION
			RETURN TRIM(input_ssn,LEFT,RIGHT) = TRIM(matched_ssn,LEFT,RIGHT);
	END;
	
	// ]==========[ Penalize a matched Phone Number ]==========

	EXPORT phone(STRING input_phone, STRING matched_phone) := 
		FUNCTION
			IPhoneNumber := PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Phone.full,opt);
			
			mod_Phone := 
				MODULE(IPhoneNumber)
					EXPORT phone      		:= input_phone;									
					EXPORT phone_field 		:= matched_phone;		
					EXPORT allow_wildcard := FALSE;
				END;	
			RETURN AutoStandardI.LIBCALL_PenaltyI_Phone.val(mod_Phone);
	END;

	EXPORT phone_is_exact_match(STRING input_phone, STRING matched_phone) := 
		FUNCTION
			RETURN TRIM(input_phone,LEFT,RIGHT) = TRIM(matched_phone,LEFT,RIGHT);
	END;
	
END;