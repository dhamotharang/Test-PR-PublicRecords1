/***************************************************************************************************************************************
* This macro compares 2 datasets, running a field by field comparison between pairs of records (left vs right) to flag discrepancies. 
*
* Parameters: 
*   @inL [REQUIRED] => Any dataset.
*   @inR [REQUIRED] => Any dataset to be compared against the first one.
*   @field_prefix [OPTIONAL] => Any prefix to be added to metadata fields (seq and diff). 
*   @ignore_regexp [OPTIONAL] => A reg exp containing field names that should be ignored. E.g. (^(fname|lname)).
*   @recfmt [OPTIONAL] => Output layout, if different than input dataset.
*
* Limitations:
*   - Child datasets and record type fields are ignored and will require code changes to be properly compared.
*   - Both datasets are expected to have the same layout (adding a check to fail if they are not would be a good enhancement).
*          
* See usage examples at the bottom of this attribute.
*
*****************************************************************************************************************************************/
export CompareDatasets(inL, inR, field_prefix = '\'__\'', ignore_regexp = '\'\'', recfmt = '\'\'') := functionmacro
  
  loadxml('<xml/>');
  #declare(expand_layout)
  #declare(seq_field)
  #declare(diff_field)
  #set(seq_field, field_prefix + 'seq');
  #set(diff_field, field_prefix + 'diff');

  local recfmt_raw := record
    #if(recfmt != '') recfmt; #ELSE inL; #end
  end;

  #set(expand_layout, 'unsigned4 ' + %'seq_field'% + ';\n');
  #append(expand_layout, 'boolean ' + %'diff_field'% + ';\n');
  local comp_recfmt := record
    // string debug := '';
    #expand(%'expand_layout'%) 
    recfmt_raw;
  end;

  local inL_seq := project(inL, transform(comp_recfmt, 
    #expand('self.' + %'seq_field'% + ' := COUNTER;') 
    self := left; self := []));
  local inR_seq := project(inR, transform(comp_recfmt, 
    #expand('self.' + %'seq_field'% + ' := COUNTER;')  
    self := left; self := []));

  #exportxml(r_xml, recfmt_raw);
  #declare(is_first_elem)
  #declare(depth)
  #declare(equality_check_all)
  #declare(debug_str)
  #set(is_first_elem, true);
  #set(depth, 0); 
  #set(equality_check_all, ''); // will hold a boolean expression to check all fields found in input layout.
  #set(debug_str, '');

  #for(r_xml)
    #for(Field)
      #if (%'{@isRecord}'% <> '')
        // todo: handle sub-elements and child datasets
        #set(depth, %depth%+1);
      #elif (%'{@isDataset}'% <> '')
        // todo: handle child datasets
         #set(depth, %depth%+1);
      #elif (%'{@isEnd}'% <> '')
        #set(depth, %depth%-1);        
      #else
        #if (%depth%=0)
          #if (ignore_regexp = '' or not regexfind(ignore_regexp, %'{@name}'%, NOCASE))
            #if (%is_first_elem%)
              #append(equality_check_all, '(');
              #set(is_first_elem, false);
            #else
              #append(equality_check_all, ' OR ');
            #end
            #append(equality_check_all, 'left.' + %'{@name}'% + ' <> right.' + %'{@name}'%);
          #end
        #end
      #end
    #end
    #if (%is_first_elem%=false and %depth%=0) // found at least one field to compare, need to close parenthesis
      #append(equality_check_all, ')');
    #end
    
  #end
  
  // flag all records found in only one of the datasets (outer recs) as diff. -- is there a better/cleaner way to do this?
  local l_recs_outer := join(inL_seq, inR_seq, left.#expand(%'seq_field'%) = right.#expand(%'seq_field'%), left only);
  local r_recs_outer := join(inR_seq, inL_seq, left.#expand(%'seq_field'%) = right.#expand(%'seq_field'%), left only);
  local l_recs_inner := join(inL_seq, l_recs_outer, left.#expand(%'seq_field'%) = right.#expand(%'seq_field'%), left only);
  local r_recs_inner := join(inR_seq, r_recs_outer, left.#expand(%'seq_field'%) = right.#expand(%'seq_field'%), left only);

  // flag all records in both datasets (inner recs) by comparing all fields.
  local dcomp_inner := iterate(sort(l_recs_inner + r_recs_inner, #expand(%'seq_field'%), record), 
    transform(comp_recfmt,
      is_pair := left.#expand(%'seq_field'%)>0 and left.#expand(%'seq_field'%) = right.#expand(%'seq_field'%);
      // self.debug := #expand(%debug_str%);
      self.#expand(%'diff_field'%) := is_pair and #expand(%'equality_check_all'%);
      self := right;
    ));
  local dcomp_outer := project(l_recs_outer + r_recs_outer, transform(comp_recfmt, 
    self.#expand(%'diff_field'%) := true; // flag all outer records as diff
    self := left));
  
  return sort(dcomp_inner+dcomp_outer, #expand(%'seq_field'%), record);

endmacro;

/*
___BWR FOR TESTING___

l_raw_a := record
	string s1 := '';
	integer i1 := 0;
end;

l_raw := RECORD
	unsigned6 did;
	string6 dt_first;
	DATASET(l_raw_a) daa;
	l_raw_a aa;
	string last_field;
END;

d1a := DATASET([{'aaa', 10}], l_raw_a);
d1b := DATASET([{'bbb', 5}], l_raw_a);

d1 := DATASET([{111, '201906', d1a, d1a[1], 'last'}], l_raw);
d2 := DATASET([{111, '201906', d1a, d1a[1], 'last'}], l_raw);
d3 := DATASET([{222, '201906', d1a, d1a[1], 'last'}], l_raw);
d4 := DATASET([{111, '201908', d1a, d1a[1], 'last'}], l_raw);
d5 := DATASET([{111, '201008', d1a, d1a[1], 'not last'}], l_raw);

ut.CompareDatasets(d1, d2);
ut.CompareDatasets(d1, d3, 'my_prefix_');
ut.CompareDatasets(d1, d4);
ut.CompareDatasets(d1, d4, , '^(dt_first)');
ut.CompareDatasets(d1, d5, , '^(dt_first|last_field)');

*/
