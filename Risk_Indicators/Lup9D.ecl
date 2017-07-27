export Lup9D(STRING dlnum,UNSIGNED1 len) := MAP(len<11 AND dlnum[1]>='A' AND dlnum[1]<='Z' AND IsAllNumeric(dlnum[2..(len)]) => '0',
									   len<11 AND dlnum[1]>='A' AND dlnum[1]<='Z' => '12',
									   len<11 => '6',
									   '1');