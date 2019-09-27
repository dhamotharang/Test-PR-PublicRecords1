/***************************************************************************************************************************************
* NAME: mac_declare_clean_layout
* PARAMETERS: 1) [REQUIRED]  recfmt  => any layout, dataset or index.
*             2) [OPTIONAL]  layoutName  => the name for the record layout that will be declared. 
              3) [OPTIONAL]  declareLocal  => should the record layout be declared with a local specifier.
              3) [OPTIONAL]  addXpath  => add an xpath declaration for each field (default is true).
* PURPOSE: -This will essentially declare a 'clean' copy of a record layout in that everything is declared locally and
*             - each field will (optionally) have a valid xpath() -- this is helpful for outputting records with TOJSON().
*****************************************************************************************************************************************/
export mac_declare_clean_layout(recfmt, layoutName = '\'clean_record_layout\'', 
  declareLocal = 'false', addXpath = 'true') := macro

  #exportxml(r_xml, recfmt);
  #declare(doExpand);
  #declare(str_out);
  #declare(rec_dec);

  #set(str_out, '');
  #set(rec_dec, '');
  #set(doExpand, false);

  #if (declareLocal)
    #append(rec_dec, 'local ');
  #end
  #append(rec_dec, layoutName + ' := record\n');

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

        #if (addXpath)
          #append(str_out, '}) ' + %'{@name}'% + ' {xpath(\'' + %'{@name}'% + '\')};\n');
        #else
          #append(str_out, '}) ' + %'{@name}'% + ';\n');
        #end

      #elif (%doExpand%)

        // nothing else currently needs to be done on expansion
        // leaving this for future additions

      #else
        #if (addXpath)
          #append(str_out, %'{@ecltype}'% + ' ' + %'{@name}'% + ' {xpath(\'' + %'{@name}'% + '\')};\n');
        #else
          #append(str_out, %'{@ecltype}'% + ' ' + %'{@name}'% + ';\n');
        #end
      #end

    #end
  #end

  #append(rec_dec, %'str_out'% + 'end;');

  %rec_dec%;

endmacro;
