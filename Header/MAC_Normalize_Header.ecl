export MAC_Normalize_Header(infile,outfile) := macro

//****** Normalize the header file
MDH_big_file := normalize(infile, 4, header.Tra_Denormalize_Header(left, counter));

//-- Function that determines whether or not a record has name information
MDH_has_name := MDH_big_file.fname <> '' or MDH_big_file.mname <> '' or 
            MDH_big_file.lname <> '';

//****** Keep only the records that have some sort of name information
outfile := MDH_big_file(MDH_has_name);

  endmacro;