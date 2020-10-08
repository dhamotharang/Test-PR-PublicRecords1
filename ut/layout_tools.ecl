import ut;

/***************************************************************************************************************************************
* A set of convenience functions and macros for layout inspection. See selftest() below for usage.
*****************************************************************************************************************************************/
export layout_tools := module

  export get(recfmt, recurse_depth = -1) := functionmacro
    return ut.get_rec_layout(recfmt, recurse_depth);
  endmacro;
  export getText(recfmt, addXpath = 'false') := functionmacro
    return ut.get_layout_text(recfmt, addXpath);
  endmacro;
  export getDepth(recfmt) := functionmacro
    return ut.get_layout_depth(recfmt);
  endmacro;
  export getCardinality(recfmt) := functionmacro
    return count(ut.get_rec_layout(recfmt));
  endmacro;
  export compare(reca, recb) := functionmacro
    return ut.compare_rec_layout(reca, recb);
  endmacro;
  export boolean isEqual(reca, recb) := functionmacro
    local compare_res := ut.compare_rec_layout(reca, recb);
    return ~exists(compare_res(~equals));
  endmacro;    
  export boolean isSubset(reca, recb) := functionmacro
    local compare_res := ut.compare_rec_layout(reca, recb);
    return ~exists(compare_res(field_size_ri=0));
  endmacro;

  export selftest() := functionmacro 
    // a subset of b
    rec_a := record
      string20 fname;
      string20 lname;
      string20 city;
      string5 zip;
    end;

    // b superset of a
    rec_b := record(rec_a)
      string8 dob;
    end;

    // c disjoint set
    rec_c := record
      string20 f1;
      string20 f2;
      string20 f3;
    end;

    rec_d := record
      string20 f1;
      integer f2;
      string20 f3;
    end;

    rec_e := record
      rec_c child;
      string20 f2;
    end;

    rec_f := record
      dataset(rec_c) children;
      unsigned6 did;
    end;

    output(ut.layout_tools.get(rec_a), named('get_layout_1'));
    output(ut.layout_tools.get(rec_e), named('get_layout_2'));
    output(ut.layout_tools.getText(rec_a), named('get_text_1'));
    output(ut.layout_tools.getText(rec_e), named('get_text_2'));
    output(ut.layout_tools.getDepth(rec_a), named('get_depth_1'));
    output(ut.layout_tools.getDepth(rec_e), named('get_depth_2'));
    output(ut.layout_tools.getCardinality(rec_a), named('get_cardinality_1'));
    output(ut.layout_tools.getCardinality(rec_e), named('get_cardinality_2'));
    output(ut.layout_tools.compare(rec_a, rec_b), named('compare_1')); // a subset of b
    output(ut.layout_tools.compare(rec_c, rec_a), named('compare_2')); // 2 disjoint sets
    output(ut.layout_tools.compare(rec_e, rec_e), named('compare_3')); // 2 sets with child rec
    output(ut.layout_tools.compare(rec_e, rec_f), named('compare_4'));
    output(ut.layout_tools.isEqual(rec_a, rec_a), named('is_equal_1')); // true
    output(ut.layout_tools.isEqual(rec_c, rec_d), named('is_equal_2')); // false
    output(ut.layout_tools.isEqual(rec_e, rec_c), named('is_equal_3')); // false
    output(ut.layout_tools.isEqual(rec_e, rec_e), named('is_equal_4')); // true
    output(ut.layout_tools.isSubset(rec_a, rec_b), named('is_subset_1')); // true
    output(ut.layout_tools.isSubset(rec_b, rec_a), named('is_subset_2')); // false
    output(ut.layout_tools.isSubset(rec_c, rec_a), named('is_subset_3')); // false
    return true;
  endmacro;

end;

