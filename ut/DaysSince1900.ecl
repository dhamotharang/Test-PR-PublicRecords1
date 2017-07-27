export DaysSince1900(string4 year, string2 month, string2 day) :=
  ((integer)year-1900)*365+((integer)year-1901) div 4 + DayOfYear((integer)year,(integer)month,(integer)day);