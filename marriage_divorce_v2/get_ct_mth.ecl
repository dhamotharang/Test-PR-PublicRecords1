export get_ct_mth(string pinput) := 
map(

 pinput = '1' =>	'01',
pinput = '2' =>	'02',
pinput = '3' =>	'03',
pinput = '4' =>	'04',
pinput = '5' =>	'05',
pinput = '6' =>	'06',
pinput = '7' =>	'07',
pinput = '8' =>	'08',
pinput = '9' =>	'09',
pinput = '0' =>	'',
pinput = '-' =>	'11',
pinput = '&' =>	'12',
pinput = 'U' =>	'',
''
);
