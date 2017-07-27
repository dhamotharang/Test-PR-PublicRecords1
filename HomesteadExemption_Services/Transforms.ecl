
IMPORT Address, Std;

EXPORT Transforms := MODULE
    //added condition to transform to not make a 2nd record if there isn't a 2nd input owner name.
		EXPORT Layouts.batch_in_raw_normed xfm_norm(Layouts.batch_in_raw_with_seq le, INTEGER c) :=
			TRANSFORM, SKIP(c = 2 and le.owner_name_2 = '')
				SELF.acctno      := TRIM(le.acctno) + '_' + (STRING)c;
				SELF.tax_year    := le.tax_year;
				SELF.owner_name  := IF( c = 1, le.owner_name_1, le.owner_name_2 );
				SELF.owner_ssn   := IF( c = 1, le.owner_ssn_1, le.owner_ssn_2 );
				SELF.owner_dob   := IF( c = 1, le.owner_dob_1, le.owner_dob_2 );
				SELF.street_addr := le.street_addr;
				SELF.city        := le.city;
				SELF.state       := le.state;
				SELF.zip         := le.zip;
			END;
		
		
	EXPORT Layouts.batch_in xfm_clean_record(Layouts.batch_in_raw_normed le) :=
		TRANSFORM
				clean_name   := Address.CleanPersonFML73( Functions.fn_remove_trust(le.owner_name) );
				addr_line_1  := le.street_addr;
				addr_line_2  := Address.Addr2FromComponents(le.city, le.state, le.zip);
				clean_addr   := Address.GetCleanAddress(addr_line_1, addr_line_2, Address.Components.country.US).results;
				is_cleanable := clean_addr.error_msg[1] != 'E';
			
			// Transform now:
			SELF.acctno          := le.acctno;
			SELF.did             := 0;
			SELF.name_first      := clean_name[6..25],  
			SELF.name_middle     := clean_name[26..45], 
			SELF.name_last       := clean_name[46..65],
			SELF.name_suffix     := clean_name[66..70],
			SELF.prim_range      := IF(is_cleanable, clean_addr.prim_range, '');
			SELF.prim_name 	     := IF(is_cleanable, clean_addr.prim_name , '');
			SELF.sec_range 	     := IF(is_cleanable, clean_addr.sec_range , '');
			SELF.addr_suffix     := IF(is_cleanable, clean_addr.suffix    , '');
			SELF.predir          := IF(is_cleanable, clean_addr.predir    , '');
			SELF.postdir         := IF(is_cleanable, clean_addr.postdir   , '');
			SELF.unit_desig      := IF(is_cleanable, clean_addr.unit_desig, '');
			SELF.p_city_name     := IF(is_cleanable, clean_addr.p_city    , '');
			SELF.z5              := IF(is_cleanable, clean_addr.zip       , '');
			SELF.st	             := IF(is_cleanable, clean_addr.state     , '');
			SELF.ssn             := STD.Str.Filter( le.owner_ssn, Constants.AlphaNumericOnlyChars );
			SELF.dob             := STD.Str.Filter( le.owner_dob, Constants.AlphaNumericOnlyChars );				
			SELF.record_err_msg  := '';
			SELF.is_rejected_rec := FALSE;
			SELF                 := le;
			SELF                 := []
		END;
  
	//TRANSFORM USING 2 MACROS to fill 10 sets of 33 property output fields
 
  EXPORT mac_fieldname(fname, inCnt) := macro
    #uniquename(fieldsymbol);
    #uniquename(fieldsymbolLEFT);
    #uniquename(fieldsymbolRIGHT);
    #set(fieldsymbol,'self.'+fname+'_'+inCnt);
    #set(fieldsymbolLEFT,'l.'+fname+'_'+inCnt);
    #set(fieldsymbolRIGHT,'r.'+fname);
	  %fieldsymbol% := if ((integer)inCnt = c, %fieldsymbolRIGHT%, %fieldsymbolLEFT%);
  ENDMACRO;				 
  
	EXPORT mac_propfields(cnt) := macro
		mac_fieldname('owner_1_first_name',cnt);
		mac_fieldname('owner_1_middle_name',cnt);
		mac_fieldname('owner_1_last_name',cnt);
		mac_fieldname('owner_1_name_suffix',cnt);
		mac_fieldname('owner_1_company_name',cnt);
		mac_fieldname('owner_2_first_name',cnt);
		mac_fieldname('owner_2_middle_name',cnt);
		mac_fieldname('owner_2_last_name',cnt);
		mac_fieldname('owner_2_name_suffix',cnt);
		mac_fieldname('owner_2_company_name',cnt);
		mac_fieldname('parcel',cnt);
		mac_fieldname('county_property',cnt);
		mac_fieldname('property_address1',cnt);
		mac_fieldname('property_address2',cnt);
		mac_fieldname('property_p_city_name',cnt);
		mac_fieldname('property_st',cnt);
		mac_fieldname('property_zip',cnt);
		mac_fieldname('property_zip4',cnt);
		mac_fieldname('prop_full_address',cnt);
		mac_fieldname('homestead_exemption_flag',cnt);
		mac_fieldname('homestead_count_years',cnt);
		mac_fieldname('owner_occupied',cnt);
		mac_fieldname('seller_first',cnt);
		mac_fieldname('seller_last',cnt);
		mac_fieldname('seller_company',cnt);
		mac_fieldname('sale_date',cnt);
		mac_fieldname('business_owner_flag',cnt);
		mac_fieldname('business_seller_flag',cnt);
		mac_fieldname('property_coownership',cnt);
		mac_fieldname('coowner_mult_exemption',cnt);
		mac_fieldname('purchase_date',cnt);
		mac_fieldname('ownership_length',cnt);
  ENDMACRO;	

  EXPORT HomesteadExemption_Services.Layouts.layout_property_recs xfm_10_property(HomesteadExemption_Services.Layouts.layout_property_recs l, 
	                                                                                HomesteadExemption_Services.Layouts.layout_temp_property_rec r, 
																																									INTEGER C) := TRANSFORM
   self.acctno := l.acctno;
   mac_propfields('1')   
	 mac_propfields('2')
   mac_propfields('3')
   mac_propfields('4')
   mac_propfields('5')
   mac_propfields('6')
   mac_propfields('7')
   mac_propfields('8')
   mac_propfields('9')
   mac_propfields('10')
   self := l;	//remove this if its not necessary, which I think it isn't.																																								
	END;
	EXPORT HomesteadExemption_Services.Layouts.layout_temp_property_rec xfm_1_prop(HomesteadExemption_Services.layouts.layout_prop_batch_plus L) := TRANSFORM
		SELF.acctno := l.acctno[1..(length(trim(l.acctno))-2)];
		SELF.parcel := l.clean_parcelID;
		self.county_property := l.property_county_name;
		self := l;  //all other fields have same name.
		END;
END;