EXPORT flatten_macro(ds) := macro
import ashirey;
 #uniquename(result)
  // %result%:=count(ds);
ashirey.flatten(ds, %result%);
 
  output(%result%,all);

endmacro;
