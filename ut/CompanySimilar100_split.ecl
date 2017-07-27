
mini(integer l, integer r) := IF(l < r, l, r);

EXPORT CompanySimilar100_split(string40 indic_l, string40 sec_l, string40 indic_r, string40 sec_r) := 
	mini(CS100S.current(indic_l, sec_l, indic_r, sec_r), CS100S.current(indic_r, sec_r, indic_l, sec_l));