IMPORT ut,lib_stringlib,std;

export DOBTools(unsigned8 Dob_val_in = 0) := 
MODULE
//addition to correct yyyy input for people search (Bug # 32784)
string_dob := (string)(dob_val_in * 10000);
dob_val_tmp:=(unsigned8) string_dob[1..8];
export unsigned8 Dob_val := if(dob_val_in>0, dob_val_tmp,dob_val_in);
//end of addition
shared days_in_months := [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; // using this requires checking for leap year
export year_in := dob_val div 10000;

export current_year := (unsigned2)(StringLib.getdateYYYYMMDD()[1..4]) : global;

export find_year_low(unsigned1 AgeHigh_val)
							:= MAP( year_in <> 0 => year_in,
                      agehigh_val <> 0 => current_year - agehigh_val - 1,
                      0 );   
export find_year_high(unsigned1 AgeLow_val)
							:= MAP( year_in <> 0 => year_in,
                      agelow_val <> 0 => current_year - agelow_val + 1,
                      0 );

export find_month := (DOB_val div 100) % 100;
export find_day := DOB_val % 100;

// Check DOB validity. 

// Primarily for use in header search, therefore dates older than 1900 are not considered.
// Note, that "future" dates for current year are "valid", since it is rather impractical to
// calculate current_month, current_day (calculation of current_year is unavoidable).

export IsValidMonth := (find_month > 0) and (find_month < 13);

shared leap_adjust := IF (find_month = 2 and Std.Date.IsLeapYear (year_in), 1, 0);
export IsValidDay := IsValidMonth and
                     (find_day > 0) and (find_day <= days_in_months [find_month] + leap_adjust);

export IsValidDOB := (year_in >= 1900) and (year_in <= current_year) and IsValidMonth and IsValidDay;

export IsValidYOB := (year_in >= 1900) and (year_in <= current_year);

END;