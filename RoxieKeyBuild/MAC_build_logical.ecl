EXPORT MAC_build_logical (the_index, the_dataset, 
                          superkeyname, lkeyname, 
                          seq_name, one_node = 'false', diffing = 'false') := MACRO

seq_name := 
  #IF (one_node)
    BUILD (the_index, the_dataset, lkeyname, UPDATE, FEW)
  #ELSE 
    IF (~diffing,
        BUILD (the_index, the_dataset, lkeyname, UPDATE),
        BUILD (the_index, the_dataset, lkeyname, DISTRIBUTE (INDEX (the_index, superkeyname+'_Prod')), UPDATE)
      );
  #END      
ENDMACRO;
