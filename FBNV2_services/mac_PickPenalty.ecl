export mac_PickPenalty(
	lpen_1,lpen_phone_1,lpen_addr_1,lpen_bdid_1,rpen_1,rpen_phone_1,rpen_addr_1,rpen_bdid_1,
	lpen_2,lpen_phone_2,lpen_addr_2,lpen_bdid_2,rpen_2,rpen_phone_2,rpen_addr_2,rpen_bdid_2) := MACRO

		overall_penalt :=
			MAX(
				lpen_1 + rpen_1 + MIN(lpen_phone_1,rpen_phone_1) + MIN(lpen_addr_1,rpen_addr_1) + MIN(lpen_bdid_1,rpen_bdid_1),
				lpen_2 + rpen_2 + MIN(lpen_phone_2,rpen_phone_2) + MIN(lpen_addr_2,rpen_addr_2) + MIN(lpen_bdid_2,rpen_bdid_2));
		
		self.penalt :=overall_penalt;
ENDMACRO;