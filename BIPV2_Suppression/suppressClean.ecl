EXPORT suppressClean(ds) := functionmacro

// This should read from a file instead of being hard-coded. 
// This was created in haste so should be re-implemented when possible.

	supRec1 := {
    string cnp_name;
    string2 st;
  };
	supDs1 := 
  dataset([
    {'CALABASAS COUNTRY CL', 'CA'}, 
    {'CALABASAS COUNTRY CLUB', 'CA'}, 
    {'CALABASAS COUNTY CLUB', 'CA'}, 
    {'CALABASAS GOLF', 'CA'}, 
    {'CALABASAS GOLF & C', 'CA'}, 
    {'CALABASAS GOLF & C C', 'CA'}, 
    {'CALABASAS GOLF & COUNTRY', 'CA'}, 
    {'CALABASAS GOLF & COUNTRY CLUB', 'CA'}, 
    {'CALABASAS GOLF ACADEMY', 'CA'}, 
    {'CALABASAS GOLF COURSE', 'CA'}, 
    {'CALABASSAS COUNTRY CLUB', 'CA'}, 
    {'KNIGHT CALABAS', 'CA'}, 
    {'KNIGHT CALABASAS', 'CA'}, 
    {'KNIGHT CALADASAS', 'CA'}, 
    {'KNIGHTCALABASAS', 'CA'}, 
    {'KNIGHTSCALABASAS', 'CA'}],
		supRec1);

	ds1 := 
		join(ds, supDs1,
			left.cnp_name = right.cnp_name
				and left.st = right.st,
			transform(left), left only, lookup);

	return ds1;

endmacro;