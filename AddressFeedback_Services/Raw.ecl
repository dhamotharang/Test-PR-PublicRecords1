import AddressFeedback;

EXPORT Raw := module

  export byAddress(dataset(Layouts.feedback_input) dIn) := function
  
    dRecs := join(dIn, AddressFeedback.Key_AddressFeedback,
                  keyed(left.prim_name = right.prim_name) and
                  keyed(left.zip = right.zip) and
                  keyed(left.prim_range = right.Prim_range) and
                  keyed(left.sec_range='' or left.sec_range = right.sec_range) and
                  keyed(left.did = right.did) and
                  left.predir = right.predir and
                  left.postdir = right.postdir and
                  left.suffix = right.addr_suffix and
                  left.unit_desig = right.unit_desig,
                  transform(Layouts.feedback_common, self := right),
                  limit(0), keep(Constants.Limits.FEEDBACK_PER_ADDRESS));
    dRecsDD := dedup(sort(dRecs, record), record);
    return dRecsDD;
    
  end;
  
end;
