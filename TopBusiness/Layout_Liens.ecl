export Layout_Liens := module

  export main := module
	  // Separate "Filing Info" layout for use here and in the Biz rpt LienSection
    export filing_info := record
			string50  filing_jurisdiction;
			string8   orig_filing_date;
			string20  orig_filing_number;
			string50  orig_filing_type;
      string50  amount;
      string8   release_date;
      string1   eviction; 
      string75  satisfaction_type;
      string8   judg_satisfied_date;
      string8   judg_vacated_date;
			string8   lapse_date;
      string8   expiration_date;
	  end;

	  // Separate "Filings" layout for use here and in the Biz rpt LienSection
		export filings := record
      string8   filing_date;
      string20  filing_number;
      string125 filing_type_desc;
			string10  filing_status;
		  string30  filing_status_desc;
      string10  filing_book;
      string10  filing_page;
      string150 agency;
      string2   agency_state;
      string40  agency_county;
		end;

		export Unlinked := record
		  string2   source;
			string50  source_docid; // will contain tmsid ???
			// NOTE: tmsid length is 50 which is longer than source_docid can currently handle ???
      // v--- Fields from the exisiting LiensV2 base main file (LiensV2.file_allsources_base.main)
			//      which uses layout of: liensv2.layout_base_allsources_main.rec
			//string50  tmsid; // same as source_docid so doesn't need stored again???
			//string50  rmsid; // not needed??? TBD
      filing_info;
			filings;
    end;

		export Linked := record
			unsigned6 bid;
			string10  source_party;  // name_type[1] + hash of orig name/addr fields ???
			Unlinked;		
		end;

	end; // end of "main" module

 export party := record
	  // v--- fields needed for linking from brm liens main.unlinked(?) to party recs
		string50  tmsid;
		//string50  rmsid; // not needed??? TBD
    // v--- Fields from the exisiting LiensV2 base party file (LiensV2.file_allsources_base.party)
		//      which uses layout of: Liensv2.layout_base_allsources_party
    string700  orig_name; //700 length from base party layout seems excessive, chg to ???
		string9   tax_id;
		string9   ssn;
		string5   title;
		string20  fname;
		string20  mname;
		string20  lname;
		string5   name_suffix;
		string500 cname; // check/change length to be consistent with other layouts.   ???
		string10 prim_range;
		string2  predir;
		string28 prim_name;
		string4  addr_suffix;
		string2  postdir;
		string10 unit_desig;
		string8  sec_range;
		// keep 2 city fields or 1                  ???
		string25 p_city_name;
		string25 v_city_name;
		string2  st;
		string5  zip;
		string4  zip4;
		//string2  name_type; //Existing field on leins party file, which contains: 
		//                      A(Attorney), AD(Attorney for Debtor),
		//                      C(Creditor), D(Debtor), T(Third Party)
		// For field name consistency with other data types, store the name_type field 
		// into the party_type field (below) in the Liens_AsMasters attribute.
		// keep appended fields below separate or store into ssn & taxid above  ???
		string9  app_SSN;
    string9  app_tax_id;
		// v--- fields not on existing base liens party file
		string2  party_type; // on exisitng base party file the field is named "name_type",
		//                 but store into this field for consistency with other TB layouts ???
  end;	

end;
