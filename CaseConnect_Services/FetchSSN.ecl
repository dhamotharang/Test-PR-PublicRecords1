IMPORT ut, doxie, autokey, AutoKeyI;

export FetchSSN  (String keyNameRoot, boolean workHard,boolean aNoFail = true) := FUNCTION

	companyIdSet := Functions.getCompanyIdSet();
	
	doxie.MAC_Header_Field_Declare ();
						
	boolean is_straight_match := ~workHard OR ~fuzzy_ssn OR isCRS;
	boolean is_limitable := is_straight_match;
			
	//***** DECLARE KEYS
	k2 	:= autokey.Key_SSN2(keyNameRoot);

	outrec := AutoKey.layout_fetch;
			
	keyRead := 	map( is_straight_match => 
					k2(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])),
					k2(ssn_value<>'',wild(s1),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
					k2(ssn_value<>'',keyed(s1=ssn_value[1]),wild(s2),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
					k2(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),wild(s3),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
					k2(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),wild(s4),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
					k2(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),wild(s5),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
					k2(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),wild(s6),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
					k2(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),wild(s7),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
					k2(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),wild(s8),keyed(s9=ssn_value[9])) +
					k2(ssn_value<>'',keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]))
							);
			
	pb2 := project(keyRead(lookups in companyIdSet), outrec);
										 
	//***** THIS DOES NOT LEND ITSELF TO LIMITS AND HAS NOT HAD THEM FOR A WHILE (IF EVER)
	return pb2 ;
			
end;