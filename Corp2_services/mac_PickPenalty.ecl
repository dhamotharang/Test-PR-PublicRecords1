export mac_PickPenalty(lpen, lpen_phone,lpen_company,lpen_addr,rpen,
			rpen_phone,rpen_company,rpen_addr,simplified_contact)
				:= MACRO

	Min2(integer L, integer R) :=  if ( l>r , r, l );
  overall_penalt := lpen+rpen+ 
								 Min2(lpen_phone,rpen_phone) + Min2(lpen_company,rpen_company)+ Min2(lpen_addr,rpen_addr);
	self.penalt :=overall_penalt;
			 
	// Contact penalty is for sorting purposes, so that if two corporations have the same penalty
	// The one with the lower contact penalty will be prioritized (as long as both corporations have
	// at least one contact).
	
	self.contact_penalt := lpen+if(simplified_contact=FALSE,lpen_phone+lpen_addr+lpen_company,0);

ENDMACRO;

