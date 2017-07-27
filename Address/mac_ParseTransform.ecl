export mac_ParseTransform(/*string182*/ clean_addr) := 
MACRO

														self.addr.prim_range 	  := Address.CleanAddressFieldsFips(clean_addr).prim_range,
														self.addr.predir 			  := Address.CleanAddressFieldsFips(clean_addr).predir,
														self.addr.prim_name 	  := Address.CleanAddressFieldsFips(clean_addr).prim_name,
														self.addr.addr_suffix   := Address.CleanAddressFieldsFips(clean_addr).addr_suffix,
														self.addr.postdir 		  := Address.CleanAddressFieldsFips(clean_addr).postdir,
														self.addr.unit_desig	  := Address.CleanAddressFieldsFips(clean_addr).unit_desig,
														self.addr.sec_range		  := Address.CleanAddressFieldsFips(clean_addr).sec_range,
														self.addr.v_city_name   := Address.CleanAddressFieldsFips(clean_addr).v_city_name,
														self.addr.st 					  := Address.CleanAddressFieldsFips(clean_addr).st,
														self.addr.zip5 				  := Address.CleanAddressFieldsFips(clean_addr).zip,
														self.addr.zip4 				  := Address.CleanAddressFieldsFips(clean_addr).zip4,
														self.addr.addr_rec_type := Address.CleanAddressFieldsFips(clean_addr).rec_type,
														self.addr.fips_state	  := Address.CleanAddressFieldsFips(clean_addr).fips_state,
														self.addr.fips_county	  := Address.CleanAddressFieldsFips(clean_addr).fips_county,
														self.addr.geo_lat			  := Address.CleanAddressFieldsFips(clean_addr).geo_lat,
														self.addr.geo_long		  := Address.CleanAddressFieldsFips(clean_addr).geo_long,
														self.addr.cbsa				  := '',
														self.addr.geo_blk			  := Address.CleanAddressFieldsFips(clean_addr).geo_blk,
														self.addr.geo_match		  := Address.CleanAddressFieldsFips(clean_addr).geo_match,
														self.addr.err_stat		  := Address.CleanAddressFieldsFips(clean_addr).err_stat,

ENDMACRO;//