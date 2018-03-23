EXPORT fn_DDInt_to_MMInt(UNSIGNED DDInt) := FUNCTION
last_year := DDInt*100 DIV 36525;
year := last_year + 1;
Febdays := IF(year % 4 = 0, 29, 28);
yday := DDInt - last_year * 365 - last_year DIV 4;
month := MAP (yday BETWEEN 1 AND 31 => 1,
							yday BETWEEN 32 AND (31 + Febdays)  => 2,
							yday BETWEEN (32 + Febdays) AND (62 + Febdays) => 3,
							yday BETWEEN (63 + Febdays) AND (92 + Febdays) => 4,
							yday BETWEEN (93 + Febdays) AND (123 + Febdays) => 5,
							yday BETWEEN (124 + Febdays) AND (153 + Febdays) => 6,
							yday BETWEEN (154 + Febdays) AND (184 + Febdays) => 7,
							yday BETWEEN (185 + Febdays) AND (115 + Febdays) => 8,
							yday BETWEEN (116 + Febdays) AND (145 + Febdays) => 9,
							yday BETWEEN (146 + Febdays) AND (176 + Febdays) => 10,
							yday BETWEEN (177 + Febdays) AND (206 + Febdays) => 11,
													12);
RETURN fn_YYYYMM_to_Int(year*100 + month);													
END;
