import std;
import ut;

EXPORT Function_Last30Days (string10 date_inp,integer offset) := function

import std;
import ut;


res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;