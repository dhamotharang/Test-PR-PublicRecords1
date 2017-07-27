import ut;
is_num(string n) := trim(n)=(string)(integer)n;

po_1(string n) := ut.word(n,1)='B' and
	is_num(ut.word(n,2)) and
	ut.word(n,3)='PO' and ut.word(n,4) = '';

po_2(string n) := ut.word(n,1)='B' and
	is_num(ut.word(n,2)) and
	ut.word(n,3)='PO' and ut.word(n,4) IN ['RR','R','RT'] and
	is_num(ut.word(n,5)) and ut.word(n,6)='';

rt_1(string n) := ut.word(n,1)='B' and
	is_num(ut.word(n,2)) and
	ut.word(n,3) IN ['RT','R','RR'] and is_num(ut.word(n,4)) and
	ut.word(n,5)='';

export Clean_PrimName(string s) := 
(string30)IF( po_1(s),'PO BOX '+ut.word(s,2), s );