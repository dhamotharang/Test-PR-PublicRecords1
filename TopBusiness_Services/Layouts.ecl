IMPORT BIPV2;

EXPORT Layouts := MODULE

  // common report input options dataset layout for use by all the sections
 	export rec_input_options := record
	  boolean lnbranded;
	  boolean internal_testing;
		string1 BusinessReportFetchLevel;
    boolean IncludeVendorSourceB;
	end;

  // Additional input boolena needed for UCC section
 	export rec_input_options_ucc := record
 	 rec_input_options;
   boolean IncludeUCCFilingsSecureds;
  end;
	
  // common report input ids dataset layout for use by all the sections
	export rec_input_ids := record
		string25 acctno;
		BIPV2.IDlayouts.l_header_ids;  //BIP2, version 1
		// For BIP2, use this---^ OR this ---v ???
	  //iesp.share.t_BusinessIdentity; //bip2, version 2???
	end;
	
	rec_input_address := record
		string10 StreetNumber := '';
		string2 StreetPreDirection := '';
		string28 StreetName := '';
		string4 StreetSuffix := '';
		string2 StreetPostDirection := '';
		string10 UnitDesignation := '';
		string8 UnitNumber := '';
		string60 StreetAddress1 := '';
		string60 StreetAddress2 := '';
		string25 City := '';
		string2 State := '';
		string5 Zip5 := '';
		string4 Zip4 := '';
		string18 County := '';
		string9 PostalCode := '';
		string50 StateCityZip := '';
	end;

	rec_input_name := record
		string62 Full := '';
		string20 First := '';
		string20 Middle := '';
		string20 Last := '';
		string5 Suffix := '';
		string3 Prefix := '';
		string120 CompanyName := '';
	end;
	
	// common input ids with src info
	export rec_input_ids_wSrc := record
		string25 acctno;
		BIPV2.IDlayouts.l_header_ids;
		string20 IdType;
		string100 IdValue;
		string25 Section;
		string2 Source;
		rec_input_address addressInfo;
		rec_input_name nameInfo;
	end;

  // fields common to all sections
	export rec_common := record
    string2   source;
	  string70  source_docid;
	  //string10  source_party; // for bip1 only?, not needed in bip2???
		string20  source_recid; // use unsigned8 or string20 (to hold the the largest unsigned8 number)???
		//^--- for bip2 use??? A new unique/persistent source_rec_id field has been added 
		//     in some sources as unsigned8.  May need to store it separately???
	end;
	
	export rec_busHeaderLayout := BIPV2.Key_BH_Linking_Ids.kFetchOutRec;
   
	export Layout_ExecutiveTitles := record
		string position_title;
		integer order;
		boolean IsExecutive;
	end;
END;
