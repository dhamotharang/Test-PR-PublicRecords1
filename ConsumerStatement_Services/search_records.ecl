import doxie, Consumerstatement;

// a dataset only for the case if we need to accommodate for more than one input row;
// currently no more than one record is expected. Errors' handling should be done outside of this call.
EXPORT search_records (dataset (layouts.search_in) ds_in, boolean keep_history=false) := function

  // by statement ID
  ids_statements := join (ds_in (statement_id != 0), Consumerstatement.key.nonfcra.statement_id,
                          keyed (left.statement_id = right.statement_id),
                          transform (layouts.search_out, self := right),
                          limit (100, fail (203, doxie.ErrorCodes(203) + ': by ID')));

  // by phone
  phones_statements := join (ds_in (phone != ''), Consumerstatement.key.nonfcra.phone,
                             keyed (left.phone = right.phone),
                             transform (layouts.search_out, self := right),
                             limit (100, fail (203, doxie.ErrorCodes(203) + ': by phone')));

  // by address
  // search by keyed (prim_name, prim_range, zip5), filtered (sec_range, predir, postdir))
  boolean is_parsed := (ds_in.prim_name != '') and (ds_in.v_city_name != '') and
                       (ds_in.st != '') and (ds_in.zip != '');
  address_statements := join (ds_in (is_parsed), Consumerstatement.key.nonfcra.address,
                              keyed (left.st = right.st) AND
                              wild (right.p_city_name) AND
                              keyed (left.v_city_name = right.v_city_name) AND
                              // flexible on zip to account for address cleaner errors
                              keyed (left.zip='' or left.zip = right.zip) AND
                              keyed (left.prim_range = right.prim_range) AND
                              keyed (left.prim_name = right.prim_name) AND
                              // flexible on a sec range
                              (left.sec_range = '' or (left.sec_range = right.sec_range)),
                              transform (layouts.search_out, self := right),
                              limit (100, fail (203, doxie.ErrorCodes(203) + ': by address')));

  statements := ids_statements + phones_statements + address_statements;


  statements_all := statements;
  // 1. A consumer can create a statements and later make corrections to it (or suppress it);
  //    such statements will have the same statement_id, but different date-submitted.
  //    Query will return only the latest statement unless "history" is requested (and indeed if it is not suppressed)
  // 2. Different consumers may create statements for the same phone/address.

  ds_grp := group (sort (statements_all, statement_id), statement_id);
  
  // take only the latest statement per consumer
  ds_latest := TOPN (ds_grp, 1, -date_submitted);
  
  // filter out suppressed
  ds_ready := ungroup (ds_latest (override_flag != ConsumerStatement.constants.suppress));

  ds_history := sort (statements_all, statement_id, -date_submitted);

  return if (keep_history, ds_history, ds_ready);
end;
