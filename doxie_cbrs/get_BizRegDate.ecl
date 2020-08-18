IMPORT ut, std;

STRING4 guessyear(STRING2 yr, INTEGER yearOU) :=
  IF((INTEGER)yr < yearOU, '20' + yr, '19' + yr);
  
UNSIGNED4 thisyear := (UNSIGNED4)(((STRING)Std.Date.Today())[1..4]);

checkflip(STRING8 dt) :=
  IF(abs(thisyear - (UNSIGNED4)(dt[1..4])) < abs(thisyear - (UNSIGNED4)(dt[5..8])),
  dt,
  dt[5..8] + dt[1..4]);

EXPORT STRING8 get_BizRegDate(STRING dt, yearOU = 50) :=
  CASE(LENGTH(TRIM(dt)),
       10 => ut.dob_convert(dt, 4),
       8 => checkflip(dt),
       6 => ut.dob_convert(dt[1..2] + '/' + dt[3..4] + '/' + guessyear(dt[5..6],yearOU), 4),
       '');
