EXPORT mac_cleandates(infile, outfile) := macro
import ut, _validate,lib_stringlib;
#stored ('_Validate_Year_Range_Low', '1800'); 
#stored ('_Validate_Year_Range_high', ut.GetDate[1..4]); 

clean_file := project(infile, transform(recordof(infile), 
self.connect_date := if((unsigned4)_Validate.Date.fCorrectedDateString(left.connect_date) != 0, left.connect_date,''),
self.date_first_seen := if((unsigned4)_Validate.Date.fCorrectedDateString(left.date_first_seen) != 0, left.date_first_seen,''),
self.drivers_license := if(StringLib.Stringfilter(left.drivers_license, '0123456789') !=  '', left.drivers_license,''), self := left));

//dedup to remove the duplicate records 
outfile := dedup(sort(distribute(clean_file, hash(id)), record, local), record, local);

endmacro;
