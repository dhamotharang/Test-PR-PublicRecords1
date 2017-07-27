S_vanity_company_name := FSM.key_names( src = 'V' );
output(count(S_vanity_company_name),NAMED('c_S_vanity_company_name'));
output(S_vanity_company_name,NAMED('S_vanity_company_name'));

output(
       S_vanity_company_name
			 ,
			 ,'thumphrey::temp::S_vanity_company_name::CSV'
			 ,CSV(HEADING,SEPARATOR('|'))
			 ,OVERWRITE
			);

FileServices.DeSpray(
    'thumphrey::temp::S_vanity_company_name::CSV'
		,'10.140.128.250'
    ,'/data/thumphrey/thumphrey/S_vanity_company_name_csv'
    ,-1,,,true
);
