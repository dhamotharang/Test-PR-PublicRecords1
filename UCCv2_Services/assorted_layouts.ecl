export assorted_layouts := MODULE

 	export fn_convert_to_yyyymmdd(STRING10 date_value) := FUNCTION
		searchpattern := '^(.*)/(.*)/(.*)$';
		yyyy := REGEXFIND(searchpattern, date_value, 3) ;
		mm := REGEXFIND(searchpattern, date_value, 1) ;
		dd := REGEXFIND(searchpattern, date_value, 2) ;
		RETURN yyyy + // i.e. '1968' in '10/12/1968'
		       IF(LENGTH(mm)=1,'0'+mm,mm)+ // i.e. '10' in '10/12/1968'
		       IF(LENGTH(dd)=1,'0'+dd,dd);  // i.e. '12' in '10/12/1968'
	END;

	// export inp_rec := Interface
				// shared string cname :='' : STORED('CompanyName');
				// export string comp_name_indic_value := datalib.companyclean(cname)[1..40];
				// export string comp_name_sec_value := datalib.companyclean(cname)[41..80];
				// export String2 st := '' : STORED('State');
				// export unsigned6 zip5 := 0 : STORED('Zip');				
				// export String Filing_number := '' : STORED('FilingNumber');
				// shared String StartDate := ''  : STORED('FilingDateBegin');
				// export String Fg_StartDate := fn_convert_to_yyyymmdd(StartDate);
				// shared String EndDate := '' : STORED('FilingDateEnd');
				// export String Fg_EndDate := fn_convert_to_yyyymmdd(EndDate);
	// end;
    
		export tmsid_acctno := RECORD
		 string20 acctno ;
		 UCCv2_Services.layout_rmsid;
		END; 
		 
   
		export inp_rec := RECORD
		      string20 acctno;
		      string comp_name_indic_value;
					string comp_name_sec_value;
					String2 st ;
  				unsigned6 Secured_zip5 := 0 ;
	  			set of unsigned6 Debtor_zip5 := [] ;
		  		string SIC_code := '';
					String Filing_number ;
					String Fg_StartDate ;
					String Fg_EndDate ;
		END;
	
		shared party_raw := uccv2_services.layout_ucc_party_raw;
		export matched_party_name_rec := RECORD
			party_raw.title;
			party_raw.lname;
			party_raw.fname;
			party_raw.mname;
			party_raw.name_suffix;
		end;
		export matched_party_address_rec := RECORD
			party_raw.Orig_address1;
			party_raw.Orig_address2;
			party_raw.address1;
			party_raw.address2;
			party_raw.prim_range;
			party_raw.predir;
			party_raw.prim_name;
			party_raw.addr_suffix;
			party_raw.postdir;
			party_raw.unit_desig;
			party_raw.sec_range;
			party_raw.v_city_name;
			party_raw.st;
			party_raw.zip5;
			party_raw.zip4;
		end;		
		
		export matched_party_rec := RECORD
		  string1 party_type;
		  party_raw.orig_name;
			matched_party_name_rec  parsed_party;
			matched_party_address_rec address;
		END;

END;