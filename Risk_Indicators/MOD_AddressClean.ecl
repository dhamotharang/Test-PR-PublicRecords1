import address, riskwise;

// store the address cleaning logic in one place
export MOD_AddressClean := module

export street_address(string street_addr, string Prim_Range = '', string Predir='', string Prim_Name = '',
				string Suffix = '', string Postdir = '', string Unit_Desig = '', string Sec_Range = '') := function
				
	street_address := if(street_addr <> '', street_addr,  
						address.Addr1FromComponents(prim_range, predir,	prim_name, suffix, postdir, unit_desig, sec_range));
	return street_address;									
end;
													
													
export clean_addr(string street_addr, string p_City_name, string St, string Z5, string street_addr2 = '') := function
	city_st_zip := if(street_addr2='', Address.Addr2FromComponents(p_city_name, St, z5), street_addr2);	
	clean_a2 := if(street_addr='' or city_st_zip='', '', Address.CleanAddress182(street_addr,city_st_zip));
	return clean_a2;
	
end;																	


export clean_addr_paro(string street_addr, string p_City_name, string St, string Z5, string street_addr2 = '') := function
	city_st_zip := if(street_addr2='', Address.Addr2FromComponents(p_city_name, St, z5), street_addr2);	
	clean_a2 := if(street_addr='' or city_st_zip='', '', riskwise.CleanAddress182_paro(street_addr,city_st_zip));
	return clean_a2;
	
end;
	
END;


