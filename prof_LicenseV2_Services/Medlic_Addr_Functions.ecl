Import Address,AutoStandardI;

EXPORT Medlic_Addr_Functions := Module

	shared gm:=AutoStandardI.GlobalModule();

	EXPORT getModBusiness(Medlic_layout.layout_w_penalt_plus rec, integer rownum) := FUNCTION
		tempmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
				EXPORT predir         := rec.predir;
				EXPORT prim_name      := rec.prim_name;
				EXPORT prim_range     := rec.prim_range;
				EXPORT postdir        := rec.postdir;
				EXPORT addr_suffix    := rec.addr_suffix;
				EXPORT sec_range      := rec.sec_range;
				EXPORT p_city_name    := rec.p_city_name;
				EXPORT st             := rec.st;
				EXPORT z5             := rec.z5;											
				//	The address in the matching record:						
				EXPORT allow_wildcard  := FALSE;															
				EXPORT city_field      := rec.business_Address_rec[rownum].Prov_Clean_v_city_name;
				EXPORT city2_field     := rec.business_Address_rec[rownum].Prov_Clean_p_CIty_name;										
				EXPORT pname_field     := rec.business_Address_rec[rownum].Prov_Clean_prim_name;									
				EXPORT prange_field    := rec.business_Address_rec[rownum].Prov_Clean_prim_range;										
				EXPORT postdir_field   := rec.business_Address_rec[rownum].Prov_Clean_postdir;																				
				EXPORT predir_field    := rec.business_Address_rec[rownum].Prov_Clean_predir;									
				EXPORT state_field     := rec.business_Address_rec[rownum].Prov_Clean_st;										
				EXPORT suffix_field    := rec.business_Address_rec[rownum].Prov_Clean_addr_suffix;										
				EXPORT zip_field       := rec.business_Address_rec[rownum].Prov_Clean_zip;											
				EXPORT sec_range_field := rec.business_Address_rec[rownum].Prov_Clean_sec_range;
				EXPORT useGlobalScope  := FALSE;
		END;		
		RETURN tempmod;
		
	END;

	EXPORT getModGroup(Medlic_layout.layout_w_penalt_plus rec, integer rownum) := FUNCTION
		a1 := Address.CleanFields(address.GetCleanAddress(rec.group_address_rec[rownum].Address,rec.group_address_rec[rownum].City+' '+rec.group_address_rec[rownum].State+' '+rec.group_address_rec[rownum].Zip,address.Components.Country.US).str_addr);
		tempmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
				EXPORT predir         := rec.predir;
				EXPORT prim_name      := rec.prim_name;
				EXPORT prim_range     := rec.prim_range;
				EXPORT postdir        := rec.postdir;
				EXPORT addr_suffix    := rec.addr_suffix;
				EXPORT sec_range      := rec.sec_range;
				EXPORT p_city_name    := rec.p_city_name;
				EXPORT st             := rec.st;
				EXPORT z5             := rec.z5;											
				//	The address in the matching record:						
				EXPORT allow_wildcard  := FALSE;															
				EXPORT useGlobalScope  := FALSE;
				EXPORT city_field      := a1.p_city_name;
				EXPORT city2_field     := a1.p_city_name;										
				EXPORT pname_field     := a1.prim_name;									
				EXPORT prange_field    := a1.prim_range;										
				EXPORT postdir_field   := a1.postdir;																				
				EXPORT predir_field    := a1.predir;									
				EXPORT state_field     := a1.st;										
				EXPORT suffix_field    := a1.addr_suffix;										
				EXPORT zip_field       := a1.zip;											
				EXPORT sec_range_field := a1.sec_range;
		END;		
		RETURN tempmod;
		
	END;

	EXPORT getModHosp(Medlic_layout.layout_w_penalt_plus rec, integer rownum) := FUNCTION
		a1 := Address.CleanFields(address.GetCleanAddress(rec.hospital_address_rec[rownum].Address,rec.hospital_address_rec[rownum].City+' '+rec.hospital_address_rec[rownum].State+' '+rec.hospital_address_rec[rownum].Zip,address.Components.Country.US).str_addr);
		tempmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
				EXPORT predir         := rec.predir;
				EXPORT prim_name      := rec.prim_name;
				EXPORT prim_range     := rec.prim_range;
				EXPORT postdir        := rec.postdir;
				EXPORT addr_suffix    := rec.addr_suffix;
				EXPORT sec_range      := rec.sec_range;
				EXPORT p_city_name    := rec.p_city_name;
				EXPORT st             := rec.st;
				EXPORT z5             := rec.z5;											
				//	The address in the matching record:						
				EXPORT allow_wildcard  := FALSE;															
				EXPORT useGlobalScope  := FALSE;
				EXPORT city_field      := a1.p_city_name;
				EXPORT city2_field     := a1.p_city_name;										
				EXPORT pname_field     := a1.prim_name;									
				EXPORT prange_field    := a1.prim_range;										
				EXPORT postdir_field   := a1.postdir;																				
				EXPORT predir_field    := a1.predir;									
				EXPORT state_field     := a1.st;										
				EXPORT suffix_field    := a1.addr_suffix;										
				EXPORT zip_field       := a1.zip;											
				EXPORT sec_range_field := a1.sec_range;
		END;		
		RETURN tempmod;
		
	END;


End;