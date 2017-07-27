w_vanity_company_name := FSM.key_names( src = 'v' );
output(count(w_vanity_company_name),NAMED('c_w_vanity_company_name'));
output(w_vanity_company_name,NAMED('w_vanity_company_name'));

output(
       w_vanity_company_name
			 ,
			 ,'thumphrey::temp::w_vanity_company_name::CSV'
			 ,CSV(HEADING,SEPARATOR('|'))
			 ,OVERWRITE
			);

FileServices.DeSpray(
    'thumphrey::temp::w_vanity_company_name::CSV'
		,'10.140.128.250'
    ,'/data/thumphrey/thumphrey/w_vanity_company_name_csv'
    ,-1,,,true
);
