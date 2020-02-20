/***************************************************************************************************************************************
* NAME: get_layout_text
* PARAMETERS: 1) [REQUIRED]  recfmt  => any layout, dataset or index.
*             2) [OPTIONAL]  addXpath => should XPATH information be added for each field
* PURPOSE: -This will return a record containing a text representation of the ECL layout (for the input) along 
*             - with a field count and the maximum depth (of child records/datasets).
*****************************************************************************************************************************************/
export get_layout_text(recfmt, addXpath = 'false') := functionmacro

  #exportxml(r_xml, recfmt);
  #declare(depth);
  #declare(fld_count);
  #declare(max_depth);
  #declare(doExpand);
  #declare(str_out);

  #set(str_out, '');
  #set(depth, 0);
  #set(fld_count, 0);
  #set(max_depth, 0);
  #set(doExpand, false);

  #for(r_xml)
    #for(Field)
      
      // does this element have sub-elements?
      #if (%'{@isRecord}'% <> '')
        #set(doExpand, true);
        #append(str_out, 'recordof({');
      #elif (%'{@isDataset}'% <> '')
        #set(doExpand, true);
        #append(str_out, 'dataset({');
      #else
        #set(doExpand, false);
      #end

      #if (%'{@isEnd}'% <> '')

        #set(depth, %depth% - 1);
        #if (addXpath)
          #append(str_out, '}) ' + %'{@name}'% + ' {xpath(\'' + %'{@name}'% + '\')};\n');
        #else
          #append(str_out, '}) ' + %'{@name}'% + ';\n');
        #end
        #set(fld_count, %fld_count% + 1);     // a record/dataset counts as a field

      #elif (%doExpand%)

        #set(depth, %depth% + 1);
        #if (%depth% > %max_depth%)
          #set(max_depth, %depth%);
        #end

      #else
        #if (addXpath)
          #append(str_out, %'{@ecltype}'% + ' ' + %'{@name}'% + ' {xpath(\'' + %'{@name}'% + '\')};\n');
        #else
          #append(str_out, %'{@ecltype}'% + ' ' + %'{@name}'% + ';\n');
        #end
        #set(fld_count, %fld_count% + 1);     // record count of fields
      #end

    #end
  #end

  return row({%'str_out'%, %fld_count%, %max_depth%}, {string text; integer cnt; integer depth});

endmacro;
