import ut;

export SuffixStr2Num (STRING c) :=

IF(ut.is_unk(c), 2,
CASE(c,
	'JR' => 1, 
	'SR' => 3, 
	'III ' => 4, 
	'II' => 5, 
	'3' => 6, 
	'2' => 7, 
	'IV' => 8, 
	'I' => 9, 
	'4' => 10, 
	'1' => 11, 
	'JR JR' => 12, 
	'5' => 13, 
	'V' => 14,
	// blank
	0));