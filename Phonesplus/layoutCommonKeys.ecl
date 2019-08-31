export layoutCommonKeys := record

  unsigned3     	DateVendorFirstReported := 0;  
  unsigned3     	DateVendorLastReported := 0;
  unsigned3     	DateFirstSeen := 0;
  unsigned3     	DateLastSeen := 0;
  unsigned3         dt_nonglb_last_seen;
  string1			glb_dppa_flag;
  string1			ActiveFlag;
  data16   			CellPhoneIDKey := (data)0;
  unsigned2			ConfidenceScore := 0; 
  string60    		RecordKey := '';
  string2     		Vendor := '';
  string2     		StateOrigin := '';
  string20    		SourceFile := '';
  string2      		src;			
  string90 			OrigName := '';
  string1			NameFormat := '';
  string25 			Address1 := '';
  string25 			Address2 := '';
  string25 			Address3 := '';
  string20 			OrigCity := '';
  string2 			OrigState := '';
  string9 			OrigZip := '';
  string35 			Country := '';
  string8 			Dob := '';
  string10 			AgeGroup := '';
  string8 			Gender := '';
  string50 			Email := '';
  string10 			HomePhone := '';
  string10 			CellPhone := '';
  string2 			ListingType;
  string2 			PublishCode := '';
  string80 			Company := '';
  string25 			OrigTitle := '';
  unsigned3			RegistrationDate := 0;
  string20 			PhoneModel := '';
  string20 			IPAddress := '';
  string20 			CarrierCode := '';
  string15 			CountryCode := '';
  string15 			KeyCode := '';
  string15 			GlobalKeyCode := '';
  string10       	prim_range := '';
  string2        	predir := '';
  string28       	prim_name := '';
  string4        	addr_suffix := '';
  string2        	postdir := '';
  string10       	unit_desig := '';
  string8        	sec_range := '';
  string25       	p_city_name := '';
  string25       	v_city_name := '';
  string2        	state := '';
  string5        	zip5 := '';
  string4        	zip4 := '';
  string4        	cart := '';
  string1        	cr_sort_sz := '';
  string4        	lot := '';
  string1        	lot_order := '';
  string2        	dpbc := '';
  string1        	chk_digit := '';
  string2        	rec_type := '';
  string2        	ace_fips_st := '';
  string3        	ace_fips_county := '';
  string10       	geo_lat := '';
  string11       	geo_long := '';
  string4        	msa := '';
  string7        	geo_blk := '';
  string1        	geo_match := '';
  string4        	err_stat := '';
  string5        	title := '';
  string20       	fname := '';
  string20       	mname := '';
  string20       	lname := '';
  string5        	name_suffix := '';
  string3        	name_score := '';
  unsigned6 		did := 0;
  string3 			did_score := '';

end;
