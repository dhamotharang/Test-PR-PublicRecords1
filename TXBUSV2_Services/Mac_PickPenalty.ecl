export mac_PickPenalty(lpen_phone,lpen_addr,lpen_name,lpen_did, 
rpen_phoneb,rpen_addrb,rpen_cname,rpen_bdid) := MACRO

		Min2(integer L, integer R) :=  if ( l>r , r, l );
		overall_penalt := lpen_name+lpen_did+rpen_cname+ rpen_bdid+
									 Min2(lpen_phone,rpen_phoneb) + Min2(lpen_addr,rpen_addrb);
		self.penalt :=overall_penalt;
ENDMACRO;