export boolean fn_midmatch(string20 L, string20 R) := map (
											l = '' or r = ''										=> false,
											l = r 															=> true,
									    length(trim(l)) = 1 and l[1] = r[1] => true,
									    length(trim(r)) = 1 and l[1] = r[1] => true,
									    false);