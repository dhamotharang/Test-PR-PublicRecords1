export NNEQ_Suffix(string5 a, string5 b) := 
    a<>'UNK' and b<> 'UNK' and ut.NNEQ(translate_suffix(a),translate_suffix(b));
/*
//****** check to see if they are either equal or one is blank
	ut.NNEQ(trim(a),trim(b)) or
//****** or if b is a number and a is the corresponding roman numeral
	(a = choose((integer)b, '    I', '   II', '  III', '   IV', '    V', '   VI', 
							'  VII', ' VIII', '   IX', '    X', '  ZZZ')) or
//****** or vice versa
	(b = choose((integer)a, '    I', '   II', '  III', '   IV', '    V', '   VI', 
							'  VII', ' VIII', '   IX', '    X', '  ZZZ'));*/