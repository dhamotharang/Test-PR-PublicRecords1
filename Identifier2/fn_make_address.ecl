import iesp, risk_indicators;

search_by := record
iesp.share.t_Address Address;
end; 

EXPORT fn_make_address (iesp.share.t_Address addr_in) := FUNCTION
    	search_by make_addr():= TRANSFORM
    	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(global(addr_in).StreetAddress1, 
																															global(addr_in).city, 
																															global(addr_in).state, 
																															global(addr_in).zip5);
			self.address.StreetNumber := clean_a2[1..10];
			self.address.StreetPreDirection := clean_a2[11..12];
			self.address.StreetName := clean_a2[13..40];
			self.address.StreetSuffix := clean_a2[41..44];
			self.address.StreetPostDirection := clean_a2[45..46];
			self.address.UnitDesignation := clean_a2[47..56];
			self.address.UnitNumber := clean_a2[57..65];
			self.address.City := clean_a2[90..114];
			self.address.State := clean_a2[115..116];
			self.address.Zip5 := if(trim(clean_a2[117..121],all)= '', global(addr_in).zip5,clean_a2[117..121]) ;
			self.address.Zip4 := clean_a2[122..125];
			self.address.County := clean_a2[143..145];
			self.address := addr_in;
	    self := []; 
  end;
  return dataset([make_addr()]);
END;