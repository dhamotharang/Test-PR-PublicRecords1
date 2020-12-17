// This function will take, as input, a dataset of liens cases (presumably belonging to the same
// person or entity - though this is not strictly required) and logically link the cases that are
// determined to be the same per linking logic specified in [RQ-13906, RQ-13768].
// It will assign a unique unsigned case_link_id value for each logical
// case such that records belonging to each will have the same case_link_id value.
// The input is any dataset that has roughly the same format as
// LiensV2.layout_liens_main_module.layout_liens_main - the dataset will need to have the following
// string fields: orig_filing_number, filing_number, certificate_number, irs_serial_number, filing_book,
// filing_page, case_number, filing_date, amount, agency_state and agency_county. Alternate field
// names can be specified in the inputs.
// If the use_group_fld parameter is true - the results will partitioned along the specified
// field (acctno is default)
// ----------------------------------------------------------------------------------------------
EXPORT fn_link_liens_cases(liens_main_in, use_group_fld = FALSE, fld_group = 'acctno',
  orig_filing_number = 'orig_filing_number', filing_number = 'filing_number',
  certificate_number = 'certificate_number', irs_serial_number = 'irs_serial_number',
  filing_book = 'filing_book', filing_page = 'filing_page', case_number = 'case_number',
  filing_date = 'filing_date', amount = 'amount', agency_state = 'agency_state',
  agency_county = 'agency_county', release_date = 'release_date',
  process_date = 'process_date') := FUNCTIONMACRO

  LOCAL not_empty(STRING s) := TRIM(s, LEFT, RIGHT) <> '';

  // The output layout is just the input layout with an additional case_link_id value
  LOCAL output_layout := RECORD(RECORDOF(liens_main_in))
    UNSIGNED case_link_id := 0;
    UNSIGNED case_link_priority := 0;
  END;

  // Logic to calculate case_identifier value per record
  LOCAL get_identifier(RECORDOF(liens_main_in) l) := MAP(
    not_empty(l.orig_filing_number) => l.orig_filing_number,
    not_empty(l.filing_number) => l.filing_number,
    not_empty(l.certificate_number) => l.certificate_number,
    not_empty(l.irs_serial_number) => l.irs_serial_number,
    not_empty(l.filing_book) AND not_empty(l.filing_page) =>
      'BK' + TRIM(l.filing_book, LEFT, RIGHT) + 'PG' + TRIM(l.filing_page, LEFT, RIGHT),
    not_empty(l.case_number) => l.case_number,
    ''
  );

  // Our internal layout adds a sequence number, a case identifier and a case_link_id value
  LOCAL int_layout := RECORD(RECORDOF(liens_main_in))
    STRING _group;
    UNSIGNED case_link_sequence_num;
    STRING case_identifier;
    UNSIGNED case_link_id;
  END;
  LOCAL int_layout int_trans(RECORDOF(liens_main_in) l, UNSIGNED ct) := TRANSFORM
    SELF._group := IF(use_group_fld, l.fld_group, '');
    SELF.case_link_sequence_num := ct;
    SELF.case_identifier := get_identifier(l);
    SELF.case_link_id := ct;
    SELF := l;
  END;

  // All the iterations use the same transform logic. If condition matches, propogate the upper
  // case_link_id downward.
  LOCAL BOOLEAN compareProto(int_layout l, int_layout r) := FALSE;
  LOCAL int_layout iterate_trans(int_layout l, int_layout r, compareProto cmp) := TRANSFORM
    SELF.case_link_id := IF(l.case_link_id <> 0 AND cmp(l, r), l.case_link_id, r.case_link_id);
    SELF := r;
  END;

  // all comparisons have this in common
  LOCAL BOOLEAN base_cmp(int_layout l, int_layout r) :=
    (l._group = r._group) AND (l.agency_state = r.agency_state) AND (l.agency_county = r.agency_county);

  // First get records in our internal format
  LOCAL int_recs := PROJECT(liens_main_in, int_trans(LEFT, COUNTER));

  // initially group by tmsid
  LOCAL BOOLEAN tmsid_cmp(int_layout l, int_layout r) := (l._group = r._group) AND (l.tmsid = r.tmsid);
  LOCAL int_recs_tmsid := ITERATE(SORT(int_recs, _group, tmsid, case_link_id),
    iterate_trans(LEFT, RIGHT, tmsid_cmp));

  // group by case_identifier
  LOCAL BOOLEAN case_cmp(int_layout l, int_layout r) :=
    base_cmp(l, r) AND not_empty(l.case_identifier) AND (l.case_identifier = r.case_identifier);
  LOCAL int_recs_a := ITERATE(SORT(int_recs_tmsid, _group, agency_state, agency_county, case_identifier, case_link_id),
    iterate_trans(LEFT, RIGHT, case_cmp));

  // group by filing_date and amount
  LOCAL BOOLEAN date_cmp(int_layout l, int_layout r) :=
    base_cmp(l, r) AND not_empty(l.filing_date) AND not_empty(l.amount) AND
    (l.filing_date = r.filing_date) AND (l.amount = r.amount);
  LOCAL int_recs_b := ITERATE(SORT(int_recs_a, _group, agency_state, agency_county, filing_date, amount, case_link_id),
    iterate_trans(LEFT, RIGHT, date_cmp));

  // finally group by filing_number
  LOCAL BOOLEAN num_cmp(int_layout l, int_layout r) :=
    base_cmp(l, r) AND not_empty(l.filing_number) AND (l.filing_number = r.filing_number);
  LOCAL int_recs_c := ITERATE(SORT(int_recs_b, _group, agency_state, agency_county, filing_number, case_link_id),
    iterate_trans(LEFT, RIGHT, num_cmp));

  // redoing all the grouping passes can resolve 'second order linking' and potentially compress further
  LOCAL int_recs_d := ITERATE(SORT(int_recs_c, _group, agency_state, agency_county, case_identifier, case_link_id),
    iterate_trans(LEFT, RIGHT, case_cmp));
  LOCAL int_recs_e := ITERATE(SORT(int_recs_d, _group, agency_state, agency_county, filing_date, amount, case_link_id),
    iterate_trans(LEFT, RIGHT, date_cmp));
  LOCAL int_recs_f := ITERATE(SORT(int_recs_e, _group, agency_state, agency_county, filing_number, case_link_id),
    iterate_trans(LEFT, RIGHT, num_cmp));
  LOCAL int_recs_g := ITERATE(SORT(int_recs_f, _group, tmsid, case_link_id),
    iterate_trans(LEFT, RIGHT, tmsid_cmp));

  // sort the records by priority according to release_date, process_date and filing date
  // additional sort fields should prioritize records with the most relevant information
  LOCAL recs_sorted := SORT(int_recs_g(not_empty(release_date)), (INTEGER)release_date,
      -(INTEGER)process_date, -(INTEGER)filing_date, -agency_state, -agency_county, -case_identifier) &
    SORT(int_recs_g(~not_empty(release_date)), -(INTEGER)filing_date, -(INTEGER)process_date,
      -agency_state, -agency_county, -case_identifier);

  // add the sort priority value to the output recs
  LOCAL recs_final := PROJECT(recs_sorted, TRANSFORM(output_layout,
    SELF.case_link_priority := COUNTER,
    SELF := LEFT));

  // output tests
  //output(int_recs, named('internal_recs'));
  //output(int_recs_a, named('case_grouped'));
  //output(int_recs_b, named('date_grouped'));
  //output(int_recs_c, named('number_grouped'));
  //output(recs_final, named('recs_final'));

  RETURN recs_final;

ENDMACRO;
