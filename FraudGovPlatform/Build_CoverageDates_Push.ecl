Import FraudGovPlatform, MySQL, ut;
EXPORT Build_CoverageDates_Push := MODULE

shared coverage_dates := FraudGovPlatform.Files().Base.CoverageDates.Built;

//mysql_prod for Prod, mysql_qa for QA, mysql_dev for Dev
shared mysql_username := ut.Credentials().fGetAppUserInfo('mysql_cert')[1].username;
shared mysql_password := ut.Credentials().fGetAppUserInfo('mysql_cert')[1].password;


shared  MySQLServer                 :=  'dbqgov-bct.risk.regn.net';
shared  MySQLPort                   :=  '3308';
shared  MySQLDatabase               :=  'ring_web';
shared  MySQLUser                   :=  mysql_username;
shared  MySQLPassword               :=  mysql_password;


fInsert_CoverageDates(dataset(FraudGovPlatform.Layouts.CoverageDates) pValues) :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser),
                        server(MySQLServer),
                        port(MySQLPort),
                        database(MySQLDatabase),
                        password(MySQLPassword)
                 )
                        insert into source_coverage 
                                     (customer_id,customer_state,customer_program,contribution_code,source,source_group,max_reported_date,max_process_date,record_count, status)
                                     values (?,?,?,?,?,?,?,?,?,1);                        
        endembed;


fUpdate_CoverageDates :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser),
                        server(MySQLServer),
                        port(MySQLPort),
                        database(MySQLDatabase),
                        password(MySQLPassword)
                 )
                        update source_coverage 
                                     set status = 0;                        
        endembed;


export push := sequential(     
            fUpdate_CoverageDates,
            fInsert_CoverageDates(coverage_dates)
        );

END;

