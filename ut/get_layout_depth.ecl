/***************************************************************************************************************************************
* NAME: get_layout_depth
* PARAMETERS: 1) [REQUIRED]  recfmt  => any layout, dataset or index.
* PURPOSE: -This will return the number of recursive/child levels in the input layout - ie. if one of the fields in the input layout is a dataset, 
*          -then the result will be at least one (more if that child dataset itself has child records).
* USEAGE: -This is normally used internally by the get_rec_layout attribute.
*****************************************************************************************************************************************/
export get_layout_depth(recfmt) := functionmacro

  import std.Str AS Str;

  #exportxml(r_xml, recfmt);
  #declare(level);
  #declare(max_level);
  #declare(doExpand);
  #set(level, 0);
  #set(max_level, 0);
  #set(doExpand, false);
  #for(r_xml)
    #for(Field)
      
      // does this element have sub-elements?
      #if (%'{@isRecord}'% <> '')
        #set(doExpand, true);
      #elif (%'{@isDataset}'% <> '')
        #set(doExpand, true);
      #else
        #set(doExpand, false);
      #end

      #if (%'{@isEnd}'% <> '')
        #set(level, %level% - 1);
      #elif (%doExpand%)
        #set(level, %level% + 1);
        #if(%level% > %max_level%)
          #set(max_level, %level%);
        #end
      #end

    #end
  #end

  max_out := %max_level%;
  return max_out;

endmacro;
