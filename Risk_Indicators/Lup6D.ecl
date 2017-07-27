export Lup6D(STRING dlnum, UNSIGNED1 len) := MAP(len < 8 AND dlnum[1]>='A' AND dlnum[1]<='Z' AND IsAllNumeric(dlnum[2..(len)]) => '0',
									  len < 8 AND dlnum[1]>='A' AND dlnum[1]<='Z' => '12',
									  len < 8 => '6',
									  '1');