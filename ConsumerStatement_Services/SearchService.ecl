// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Returns 100-word consumer statement for non-FCRA side.*/
import iesp, AutoStandardI, address, doxie;

export SearchService := macro

  rec_in := iesp.consumerstatement.t_ConsumerStatementSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('ConsumerStatementSearchRequest', FEW);
  first_row := ds_in[1] : independent;
  //set options

  // clean input
  row_searchby := global (first_row.SearchBy);

  // search can be done by statement id, or phone, or address (in this order of preference)
  stmnt_id := row_searchby.StatementID;

  //phone (if no statement ID)
 	args := module
	  export string15 phone := row_searchby.Phone10;
  end;
	phone_cleaned := if (stmnt_id != 0, '', AutoStandardI.InterfaceTranslator.phone_value.val (project(args, AutoStandardI.InterfaceTranslator.phone_value.params)));

  // address (if no stament ID or phone)
  addr := row_searchby.Address;
  string addr_line_1 := if (addr.StreetAddress1 != '',
                            addr.StreetAddress1,
                            address.Addr1FromComponents (addr.StreetNumber, addr.StreetPreDirection, addr.StreetName, addr.StreetSuffix,
                                                         addr.StreetPostDirection, addr.UnitDesignation, addr.UnitNumber));
  string addr_line_2 := if (addr.StateCityZip != '',
                            addr.StateCityZip,
                            address.Addr2FromComponents (addr.City, addr.State, addr.Zip5));

//	string60 StreetAddress2 {xpath('StreetAddress2')};
  cleaned_addr := address.GetCleanAddress (addr_line_1, addr_line_2, address.Components.Country.US).results;

  boolean is_address := addr_line_1 != '' and addr_line_2 != '';
  boolean use_clean_address := (stmnt_id = 0) and (phone_cleaned = '') and is_address;
  // those are required components for the search:
  boolean address_is_parsed := (cleaned_addr.prim_name != '') and (cleaned_addr.v_city != '') and
                               (cleaned_addr.state != '') and (cleaned_addr.zip != '');

  ConsumerStatement_Services.layouts.search_in FormatInput () := transform
    Self.statement_id := row_searchby.StatementID;
    Self.did := 0;
    Self.phone := phone_cleaned;
    Self.prim_range  := if (use_clean_address, cleaned_addr.prim_range, '');
    Self.predir      := if (use_clean_address, cleaned_addr.predir, '');
    Self.prim_name   := if (use_clean_address, cleaned_addr.prim_name, '');
    Self.addr_suffix := if (use_clean_address, cleaned_addr.suffix, '');
    Self.postdir     := if (use_clean_address, cleaned_addr.postdir, '');
    Self.unit_desig  := if (use_clean_address, cleaned_addr.unit_desig, '');
    Self.sec_range   := if (use_clean_address, cleaned_addr.sec_range, '');
    Self.p_city_name := if (use_clean_address, cleaned_addr.p_city, '');
    Self.v_city_name := if (use_clean_address, cleaned_addr.v_city, '');
    Self.st          := if (use_clean_address, cleaned_addr.state, '');
    Self.zip         := if (use_clean_address, cleaned_addr.zip, '');
    Self.addr_clean_msg := if (use_clean_address, cleaned_addr.error_msg, '');
  end;
  ds_input := dataset ([FormatInput ()]);


  statements_row := ConsumerStatement_Services.search_records (ds_input, first_row.Options.IncludeHistory);

  // format into ESDL
  iesp.consumerstatement.t_ConsumerStatementRecord FormatESDL (ConsumerStatement_Services.layouts.search_out L) := transform
    Self._Penalty := 0; // not yet
    Self.UniqueId := ''; // not yet
    Self.StatementId := L.statement_id;
    Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title);
    Self.Address := iesp.ECL2ESP.setAddress(L.prim_name, L.prim_range, L.predir, L.postdir,
                                    L.addr_suffix, L.unit_desig, L.sec_range, L.p_city_name,
																		L.st, L.zip, L.zip4, ''); //r.county_name
    // Self.OriginalName := iesp.ECL2ESP.SetName (L.orig_fname, L.orig_mname, L.orig_lname, '', '');
    // Self.OriginalAddress := iesp.ECL2ESP.setAddress ('', '', '', '', '', '', '',
                                                     // L.orig_city, L.orig_st, L.orig_zip, L.orig_zip4,
                                                     // '', '', L.orig_address);
    Self.Phone := L.phone;
    // date-time stamp is expected in the form '2011-01-12 21:17:45'
    Self.DateCreated := iesp.ECL2ESP.toTimeStamp (StringLib.StringFilterOut (L.date_created, '-:'));
    Self.DateSubmitted := iesp.ECL2ESP.toTimeStamp (StringLib.StringFilterOut (L.date_submitted, '-:'));
    Self.Statement := L.consumer_text;
    Self.OverrideFlag := L.override_flag;
  end;
  statements := project (statements_row, FormatESDL (Left));


  // no marshalling
  iesp.consumerstatement.t_ConsumerStatementSearchResponse SetOutput () := transform
    Self._Header    := iesp.ECL2ESP.GetHeaderRow();
    Self.RecordCount := count (statements);
    Self.Records     := choosen (statements, iesp.constants.MAX_CONSUMER_STATEMENTS);
  end;
  results := dataset ([SetOutput ()]);

  // do_search := output(results, named('Results'));

	// CASE(c,	10 => 'No records found',
			// 11	=>	'Search is too broad',
			// 203	=>	'Too many subjects found',
			// 301	=>	'Insufficient input',
			// 310  =>   'Incomplete Address',

  do_process := map (stmnt_id=0 and (phone_cleaned = '') and ~is_address => FAIL (301, doxie.ErrorCodes (301) + ': no ID, phone or address'),
                     use_clean_address and ~address_is_parsed => FAIL (310, doxie.ErrorCodes (310) + ': input address errors'),
                     sequential (output (ds_input, named ('clean_input')),
                                 // output (Consumerstatement.key.nonfcra.address, named ('address_index')),
                                 output(results, named('Results'))));
  do_process;
endmacro;
