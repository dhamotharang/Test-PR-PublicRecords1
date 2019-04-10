// This function will take, as input, a dataset of liens cases (presumably belonging to the same 
// 	person or entity - though this is not strictly required) and logically link the cases that are 
//  determined to be the same per linking logic specified in [RQ-13906, RQ-13768].  
//  It will assign a unique unsigned case_link_id value for each logical 
//	case such that records belonging to each will have the same case_link_id value.
// The input is any dataset that has roughly the same format as 
//	LiensV2.layout_liens_main_module.layout_liens_main - the dataset will need to have the following
//	string fields: orig_filing_number, filing_number, certificate_number, irs_serial_number, filing_book, 
//	filing_page, case_number, filing_date, amount, agency_state and agency_county. Alternate field 
//	names can be specified in the inputs.
// If the use_group_fld parameter is true - the results will partitioned along the specified
//  field (acctno is default)
// ----------------------------------------------------------------------------------------------
export fn_link_liens_cases(liens_main_in, use_group_fld = false, fld_group = 'acctno', 
  orig_filing_number = 'orig_filing_number', filing_number = 'filing_number', 
  certificate_number = 'certificate_number', irs_serial_number = 'irs_serial_number', 
  filing_book = 'filing_book', filing_page = 'filing_page', case_number = 'case_number', 
  filing_date = 'filing_date', amount = 'amount', agency_state = 'agency_state', 
  agency_county = 'agency_county', release_date = 'release_date', 
  process_date = 'process_date') := functionmacro

  local not_empty(string s) := trim(s, left, right) <> '';

  // The output layout is just the input layout with an additional case_link_id value
  local output_layout := record(recordof(liens_main_in))
    unsigned case_link_id := 0;
    unsigned case_link_priority := 0;
  end;

  // Logic to calculate case_identifier value per record
  local get_identifier(recordof(liens_main_in) l) := map(
    not_empty(l.orig_filing_number) => l.orig_filing_number,
    not_empty(l.filing_number) => l.filing_number,
    not_empty(l.certificate_number) => l.certificate_number,
    not_empty(l.irs_serial_number) => l.irs_serial_number,
    not_empty(l.filing_book) and not_empty(l.filing_page) => 
      'BK' + trim(l.filing_book, left, right) + 'PG' + trim(l.filing_page, left, right),
    not_empty(l.case_number) => l.case_number,
    ''
  );

  // Our internal layout adds a sequence number, a case identifier and a case_link_id value
  local int_layout := record(recordof(liens_main_in))
    string _group;
    unsigned case_link_sequence_num;
    string case_identifier;
    unsigned case_link_id;
  end;
  local int_layout int_trans(recordof(liens_main_in) l, unsigned ct) := transform
    self._group := if(use_group_fld, l.fld_group, '');
    self.case_link_sequence_num := ct;
    self.case_identifier := get_identifier(l);
    self.case_link_id := ct;
    self := l;
  end;

  // All the iterations use the same transform logic.  If condition matches, propogate the upper
  // case_link_id downward.
  local boolean compareProto(int_layout l, int_layout r) := false;
  local int_layout iterate_trans(int_layout l, int_layout r, compareProto cmp) := transform
    self.case_link_id := if(l.case_link_id <> 0 and cmp(l, r), l.case_link_id, r.case_link_id);
    self := r;
  end;

  // all comparisons have this in common
  local boolean base_cmp(int_layout l, int_layout r) := 
    (l._group = r._group) and (l.agency_state = r.agency_state) and (l.agency_county = r.agency_county);

  // First get records in our internal format
  local int_recs := project(liens_main_in, int_trans(left, counter));

  // initially group by tmsid
  local boolean tmsid_cmp(int_layout l, int_layout r) := (l._group = r._group) and (l.tmsid = r.tmsid);
  local int_recs_tmsid := iterate(sort(int_recs, _group, tmsid, case_link_id), 
    iterate_trans(left, right, tmsid_cmp));

  // group by case_identifier
  local boolean case_cmp(int_layout l, int_layout r) := 
    base_cmp(l, r) and not_empty(l.case_identifier) and (l.case_identifier = r.case_identifier);
  local int_recs_a := iterate(sort(int_recs_tmsid, _group, agency_state, agency_county, case_identifier, case_link_id), 
    iterate_trans(left, right, case_cmp));

  // group by filing_date and amount
  local boolean date_cmp(int_layout l, int_layout r) := 
    base_cmp(l, r) and not_empty(l.filing_date) and not_empty(l.amount) and
    (l.filing_date = r.filing_date) and (l.amount = r.amount);
  local int_recs_b := iterate(sort(int_recs_a, _group, agency_state, agency_county, filing_date, amount, case_link_id), 
    iterate_trans(left, right, date_cmp));

  // finally group by filing_number
  local boolean num_cmp(int_layout l, int_layout r) :=
    base_cmp(l, r) and not_empty(l.filing_number) and (l.filing_number = r.filing_number);
  local int_recs_c := iterate(sort(int_recs_b, _group, agency_state, agency_county, filing_number, case_link_id), 
    iterate_trans(left, right, num_cmp));

  // redoing all the grouping passes can resolve 'second order linking' and potentially compress further
  local int_recs_d := iterate(sort(int_recs_c, _group, agency_state, agency_county, case_identifier, case_link_id), 
    iterate_trans(left, right, case_cmp));
  local int_recs_e := iterate(sort(int_recs_d, _group, agency_state, agency_county, filing_date, amount, case_link_id), 
    iterate_trans(left, right, date_cmp));
  local int_recs_f := iterate(sort(int_recs_e, _group, agency_state, agency_county, filing_number, case_link_id), 
    iterate_trans(left, right, num_cmp));
  local int_recs_g := iterate(sort(int_recs_f, _group, tmsid, case_link_id), 
    iterate_trans(left, right, tmsid_cmp));

  // sort the records by priority according to release_date, process_date and filing date
  // additional sort fields should prioritize records with the most relevant information
  local recs_sorted := sort(int_recs_g(not_empty(release_date)), (integer)release_date, 
      -(integer)process_date, -(integer)filing_date, -agency_state, -agency_county, -case_identifier) & 
    sort(int_recs_g(~not_empty(release_date)), -(integer)filing_date, -(integer)process_date, 
      -agency_state, -agency_county, -case_identifier);

  // add the sort priority value to the output recs
  local recs_final := project(recs_sorted, transform(output_layout, 
    self.case_link_priority := counter, 
    self := left));

  // output tests
  //output(int_recs, named('internal_recs'));
  //output(int_recs_a, named('case_grouped'));
  //output(int_recs_b, named('date_grouped'));
  //output(int_recs_c, named('number_grouped'));
  //output(recs_final, named('recs_final'));

  return recs_final;

endmacro;
