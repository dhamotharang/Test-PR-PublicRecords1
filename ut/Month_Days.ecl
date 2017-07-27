//need year and month value in YYYYMM format

// made this a non-inline function and applied the 'define' keyword
// reduces size of generated code significantly per Gavin
import STD;

export Month_Days(unsigned year_month_val)   
          := define function

  rem := year_month_val % 100;
  res := map(rem IN [4, 6, 9, 11] => 30,
             rem = 2 => if(Std.Date.IsLeapYear(year_month_val div 100),29,28),
             // rem IN [1, 3, 5, 7, 8, 10, 12] => 31,
             31); // note: this will be a result for invalid input values as well

  return res;
end;