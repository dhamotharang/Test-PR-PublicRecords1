/***************************************************************************************************************************************
* NAME: mac_declare_rec_layout
* PARAMETERS: 1) [OPTIONAL]  depth  => the recursive/child depth of the layout to declare.  Default is zero.
*             2) [OPTIONAL]  prefix  => the prefix for the record(s) declared.  The main layout will be %prefix%_layout - 
                      ie. if prefix is 'my_rec', a record named my_rec_layout will be declared.
              3) [OPTIONAL]  declareLocal  => should the record formats be declared with a local specifier.
* PURPOSE: -This will declare a record structure to describe a record format with a specified depth (of child elements).
* USEAGE: -This is used internally by get_rec_layout to declare its output structure.  In can be used externally if a client 
*         -wishes to have a named copy of the return structure of get_rec_layout.
*****************************************************************************************************************************************/
export mac_declare_rec_layout(depth = 0, prefix = '\'record\'', declareLocal = 'false') := macro

  #declare(recstr);
  #declare(it);
  #set(recstr, '');
  #set(it, depth);

  // base information returned for each field
  #if (declareLocal)
    #append(recstr, 'local ');
  #end
  #append(recstr, prefix + '_base := record\n');
  #append(recstr, 'string20 field_type;\n');
  #append(recstr, 'integer4 field_size;\n');
  #append(recstr, 'string field_name;\n');
  #append(recstr, 'end;\n');

  #loop
    #if (%it% <= 0)
      #break
    #end

    #if (declareLocal)
      #append(recstr, 'local ');
    #end
    #append(recstr, prefix + '_layout_' + (%it% - 1) + ' := record\n');
    #append(recstr, prefix + '_base;\n');
    #if (%it% < depth)
      #append(recstr, 'dataset(' + prefix + '_layout_' + %it% + ') sub_fields := dataset([], ' + prefix + '_layout_' + %it% + ');\n');
    #end
    #append(recstr, 'end;\n');

    #set(it, %it% - 1);
  #end

  #if (declareLocal)
    #append(recstr, 'local ');
  #end
  #append(recstr, prefix + '_layout := record\n');
  #append(recstr, prefix + '_base;\n');
  #if (depth > 0)
    #append(recstr, 'dataset(' + prefix + '_layout_0) sub_fields := dataset([], ' + prefix + '_layout_0);\n');
  #end
  #append(recstr, 'end;\n');

  %recstr%;
  
endmacro;
