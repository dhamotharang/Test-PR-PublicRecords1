/***************************************************************************************************************************************
* A macro to compare any two layouts. Input can be any layout, dataset or index. Input parameters are joined by field name for comparison.
*
* Parameters:
*   @param reca - any layout, dataset or index; REQUIRED
*   @param recb - any layout, dataset or index; REQUIRED
*
* Returns:
*   @return a dataset with fields compared side by side from left and right input parameters. 
*
* Limitation: layouts with recursive depth > 1 not fully implemented
*             
*****************************************************************************************************************************************/
export compare_rec_layout(reca, recb) := functionmacro

  import ut, STD;
  local in_rec_a := ut.get_rec_layout(reca, 1); // depth of at least 1 so we have sub-fields defined
  local in_rec_b := ut.get_rec_layout(recb, 1);  

  local layout_rec_out := RECORD
    integer seq := 0;
    TYPEOF(in_rec_a.field_name) field_name_le;
    TYPEOF(in_rec_a.field_type) field_type_le;
    TYPEOF(in_rec_a.field_size) field_size_le;
    TYPEOF(in_rec_b.field_name) field_name_ri;
    TYPEOF(in_rec_b.field_type) field_type_ri;
    TYPEOF(in_rec_b.field_size) field_size_ri;
    boolean equals := false; 
  end;

  layout_rec_out expandRec(recordof(in_rec_a) l, boolean setLeft) := transform
    self.field_name_le := if(setLeft, STD.STR.CleanSpaces(l.field_name), ''); 
    self.field_type_le := if(setLeft, l.field_type, ''); 
    self.field_size_le := if(setLeft, l.field_size, 0);
    self.field_name_ri := if(~setLeft, STD.STR.CleanSpaces(l.field_name), ''); 
    self.field_type_ri := if(~setLeft, l.field_type, ''); 
    self.field_size_ri := if(~setLeft, l.field_size, 0);
    self := [];
  end;
  layout_rec_out expandChildRec(recordof(in_rec_a) l, recordof(in_rec_a.sub_fields) r, boolean setLeft) := transform
    // combining field names if field is child record or dataset.
    combined_name := STD.STR.ToLowerCase(l.field_name) + 
      if(r.field_name<>'', '.', '') + STD.STR.ToLowerCase(r.field_name); 
    self.field_name_le := if(setLeft, STD.STR.CleanSpaces(combined_name), ''); 
    self.field_type_le := if(setLeft, r.field_type, ''); 
    self.field_size_le := if(setLeft, r.field_size, 0);
    self.field_name_ri := if(~setLeft, STD.STR.CleanSpaces(combined_name), ''); 
    self.field_type_ri := if(~setLeft, r.field_type, ''); 
    self.field_size_ri := if(~setLeft, r.field_size, 0);
    self := l;
  end;

  local in_rec_a_expanded := project(in_rec_a, expandRec(left, true)) +
    normalize(in_rec_a(field_type in ['dataset', 'record']), 
      left.sub_fields, expandChildRec(left, right, true));
  
  local in_rec_b_expanded := project(in_rec_b, expandRec(left, false)) +
    normalize(in_rec_b(field_type in ['dataset', 'record']), 
    left.sub_fields, expandChildRec(left, right, false));

  local out_rec_j := join(in_rec_a_expanded, in_rec_b_expanded, 
    left.field_name_le = right.field_name_ri,
    transform(layout_rec_out,
      self.field_name_le := left.field_name_le;
      self.field_type_le := left.field_type_le;
      self.field_size_le := left.field_size_le;
      self.field_name_ri := right.field_name_ri;
      self.field_type_ri := right.field_type_ri;
      self.field_size_ri := right.field_size_ri;
      self.equals := left.field_type_le = right.field_type_ri
        and left.field_size_le = right.field_size_ri
        and left.field_name_le = right.field_name_ri;
    ), full outer);

  local out_rec_s := sort(out_rec_j, if(field_name_le <> '', field_name_le, field_name_ri), record);
  local out_rec := project(out_rec_s, transform(layout_rec_out,
    self.seq := counter;
    self := left));
  
  return out_rec;

endmacro;
