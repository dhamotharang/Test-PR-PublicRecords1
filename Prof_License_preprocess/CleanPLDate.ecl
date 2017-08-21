EXPORT CleanPLDate(string pDate) := function

string yy := pDate[length(pDate)-1..];
string mm := pDate[4..6];

integer current_yy := (integer)(stringlib.GetDateYYYYMMDD()[3..4]);

string4 AdjustYear(string year) := map(length(year) <> 2 => year,
                                       (integer)year <= (current_yy + 30) => (string4)(2000 + (integer)year),
									   (string4)(1900 + (integer)year));

string Stdyear := AdjustYear(yy);

string2 ConvertMonth(string3 mname) := map(mname = 'JAN' => '01',
                                          mname = 'FEB' => '02',
                                          mname = 'MAR' => '03',
                                          mname = 'APR' => '04',
                                          mname = 'MAY' => '05',
                                          mname = 'JUN' => '06',
                                          mname = 'JUL' => '07',
                                          mname = 'AUG' => '08',
                                          mname = 'SEP' => '09',
                                          mname = 'OCT' => '10',
                                          mname = 'NOV' => '11',
                                          mname = 'DEC' => '12',
                                          '00');
string Stdmmonth := ConvertMonth(stringlib.stringtouppercase( mm ));
string day := pDate[1..2];

return Stdyear+Stdmmonth+day;
end;