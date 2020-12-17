// refactoring: layout pulled from doxie_cbrs.fn_best_information
EXPORT layout_best_info := RECORD
  STRING bdid; 
  BOOLEAN fromdca := FALSE;
  $.layout_BH_Best_String.dt_last_seen;
  $.layout_BH_Best_String.company_name;
  $.layout_BH_Best_String.prim_range;
  $.layout_BH_Best_String.predir;
  $.layout_BH_Best_String.prim_name;
  $.layout_BH_Best_String.addr_suffix;
  $.layout_BH_Best_String.postdir;
  $.layout_BH_Best_String.unit_desig;
  $.layout_BH_Best_String.sec_range;
  $.layout_BH_Best_String.city;
  $.layout_BH_Best_String.state;
  $.layout_BH_Best_String.zip;
  $.layout_BH_Best_String.zip4;
  $.layout_BH_Best_String.phone; // International numbers
  $.layout_BH_Best_String.fein;
  $.layout_BH_Best_String.best_flags; 
  BOOLEAN isCurrent := FALSE;
  BOOLEAN hasBBB := FALSE;
  UNSIGNED1 level := 0;
  STRING60 msaDesc := '';
  STRING18 county_name := '';
  STRING4 msa := '';
END;
