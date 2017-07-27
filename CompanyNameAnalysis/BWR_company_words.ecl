import FSM;
company_words := FSM.key_names( src = 'W' );
output(count(company_words),NAMED('c_company_words'));
output(company_words,NAMED('company_words'));

output(
       company_words
			 ,
			 ,'thumphrey::temp::company_words::CSV'
			 ,CSV(HEADING,SEPARATOR('|'))
			 ,OVERWRITE
			);

FileServices.DeSpray(
    'thumphrey::temp::company_words::CSV'
		,'10.140.128.250'
    ,'/data/thumphrey/thumphrey/090519_company_words_csv'
    ,-1,,,true
);
