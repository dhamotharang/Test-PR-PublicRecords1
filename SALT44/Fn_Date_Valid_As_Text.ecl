export Fn_Date_Valid_As_Text(unsigned d) := MAP( d = 0 => '',
                                                 d div 10000 <> 0 and (d % 10000) div 100 <> 0 and d % 100 <> 0 => 'ALL',
																								 d div 10000 <> 0 and (d % 10000) div 100 <> 0 => 'YM',
                                                 d div 10000 <> 0 => 'Y',
                                                 (d % 10000) div 100 <> 0 and d % 100 <> 0 => 'MD',
																								 (d % 10000) div 100 <> 0 => 'M',
																								 d % 100 <> 0 => 'D','ERR' );
