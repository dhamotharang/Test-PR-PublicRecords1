/***************************************************************************************************************************************
* NAME: get_rec_layout
* PARAMETERS: 1) [REQUIRED]  recfmt  => any layout, dataset or index.
*             2) [OPTIONAL]  recurse_depth  => will set the layout of the output dataset to the specified number of recursive levels. 
*                               the default value of -1 will auto-calculate the number of depth levels.
* PURPOSE: -This will return a dataset describing the record layout of the input.  The output dataset has fields that specify 
*          -the field_type, field_size and field_name of the input layout.  This output dataset can be filtered, joined etc. by a client
*          -interested in any specific details about the input layout.
* USEAGE: -It can be used to output the layout structure of any recordset, or used as a reflection mechanism to query elements of a record's layout.
* EXAMPLE: 
*   my_layout := ut.get_rec_layout(iesp.nac_search.t_NACSearchRequest); // my_layout describes all layout fields including the nested record and dataset structures.
*   has_did_field := exists(my_layout(field_name = 'did'));             // specifies if the layout has a field named 'did'
*   num_int := count(my_layout(field_type = 'integer'));                // counts the number of integer fields
*****************************************************************************************************************************************/
export get_rec_layout(recfmt, recurse_depth = -1) := functionmacro

  import std.Str AS Str;

  // passing a negative depth will cause the appropriate depth to be auto-selected
  local record_depth := if (recurse_depth < 0, ut.get_layout_depth(recfmt), recurse_depth);
  local max_level := record_depth;

  // create the local record format for the specified depth
  ut.mac_declare_rec_layout(record_depth, 'record', true);

  #exportxml(r_xml, recfmt);
  #declare(stmp);
  #declare(ix);
  #declare(rec);
  #declare(sub_level);
  #declare(stype);
  #declare(sz);
  #set(stmp, 'dataset([');
  #set(ix, 0);
  #set(rec, false);
  #set(sub_level, 0);
  #set(stype, '');
  #set(sz, -1);
  #for(r_xml)
    #for(Field)
      
      // does this element have sub-elements?
      #if (%'{@isRecord}'% <> '')
        #set(rec, true);
        #set(stype, 'record');
      #elif (%'{@isDataset}'% <> '')
        #set(rec, true);
        #set(stype, 'dataset');
      #else
        #set(rec, false);
        #set(stype, %'{@type}'%);
      #end

      #set(sz, %'{@size}'%);
      #if (%sz% < 0)
        #set(sz, -1);
      #end

      #if (%'{@isEnd}'% <> '')

        #set(sub_level, %sub_level% - 1);
        #set(ix, 1);
        #if (%sub_level% < max_level)
          #append(stmp, '], record_layout_' + %sub_level% + ')');
        #end
        #if (%sub_level% <= max_level)
          #append(stmp, '}');
        #end

      #else

        #if (%sub_level% <= max_level)
          #if (%ix% > 0)
            #append(stmp, ',');
          #end
          #append(stmp, ' {\'' + %'stype'% + '\', ' + %sz% + ', \'' + %'{@name}'% + '\'');
        #end

        #if (%rec%)
          #if (%sub_level% < max_level)
            #append(stmp, ', dataset([');
          #end
          #set(sub_level, %sub_level% + 1);
          #set(ix, -1);
        #else
          #if (%sub_level% <= max_level)
            #append(stmp, '}');
          #end
        #end

      #end

      #set(ix, %ix% + 1);
    #end
  #end

  #append(stmp, '], record_layout)');

  recs_out := %stmp%;
  return recs_out;

endmacro;
