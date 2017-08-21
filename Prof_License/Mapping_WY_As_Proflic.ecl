EXPORT Mapping_WY_As_Proflic := FUNCTION

  FullTrim(STRING s) := FUNCTION
	  RETURN TRIM(s, LEFT, RIGHT);
	END;

	Prof_License.Layout_proLic_in Map_WY_Trans(Layout_WY_Raw.Input L) := TRANSFORM
		SELF.date_first_seen 		 := L.date_added;
		SELF.date_last_seen 		 := L.date_updated;
		SELF.profession_or_board := L.website;
		SELF.source_st 					 := L.state;
		SELF.prolic_key 				 := IF(StringLib.StringFilter(L.license_number, '123456789') <> '',
		                               (HASH32(FullTrim(L.state) + 'OKC') + FullTrim(L.license_number)),
																	 '');
		SELF.company_name 			 := L.business_name;
		SELF.orig_name 					 := TRIM(L.name_first) + TRIM(' ' + L.name_middle) +
		                            TRIM(' ' + L.name_last) + TRIM(' ' + L.name_suffix);
		SELF.fname 					     := L.name_first;
		SELF.mname 					     := L.name_middle;
		SELF.lname 						   := L.name_last;
		SELF.name_suffix 				 := L.name_suffix;
		SELF.orig_addr_1 				 := IF(FullTrim(L.address_line_1) = 'ADDRESS NOT AVAILABLE',
		                               '',
															  	 L.address_line_1);
		SELF.orig_addr_2				 := L.address_line_2;
		SELF.orig_city 					 := L.address_city;
		SELF.orig_st					   := L.address_st;
		SELF.orig_zip 					 := L.address_zip;
		SELF.zip4                := L.address_z4;
		SELF.misc_email					 := L.email;
		SELF.orig_license_number := L.license_number;
		SELF.license_number 		 := L.license_number;
		SELF.license_type 			 := L.license_type;
		SELF.issue_date 				 := L.license_date_from;
		SELF.expiration_date 		 := L.license_date_to;
		SELF.status 					   := L.license_status;
		SELF.vendor 					   := 'OKC';

		SELF := [];
	END;

  Map_IN_Clean := PROJECT(Prof_License.File_WY_Clean, Map_WY_Trans(LEFT));

  pDataset_dist := DISTRIBUTE(Map_IN_Clean, HASH32(TRIM(prolic_key)));
  pDataset_sort	:= SORT(pDataset_dist, EXCEPT date_first_seen, date_last_seen, LOCAL);

  Prof_License.Layout_proLic_in Rollup_dates(Prof_License.Layout_proLic_in L,
	                                           Prof_License.Layout_proLic_in R) := TRANSFORM
	  SELF.date_first_seen :=	IF(L.date_first_seen > R.date_first_seen, R.date_first_seen, L.date_first_seen);
	  SELF.date_last_seen	 :=	IF(L.date_last_seen < R.date_last_seen, R.date_last_seen, L.date_last_seen);

   	SELF := L;
	END;

	Map_WY_rollup := ROLLUP(pDataset_sort,
													Rollup_dates(LEFT, RIGHT),
													EXCEPT date_first_seen, date_last_seen,
													LOCAL);

  RETURN Map_WY_rollup;

END;	