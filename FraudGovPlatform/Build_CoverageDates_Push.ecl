Import FraudGovPlatform, MySQL, ut;
EXPORT Build_CoverageDates_Push := MODULE

shared coverage_dates := FraudGovPlatform.Files().Base.CoverageDates.Built;

shared MySQLServer_cert                 :=  'dbqgov-bct.risk.regn.net';
shared MySQLPort_cert                   :=  '3308';
shared MySQLDatabase_cert               :=  'ring_web';
shared MySQLUser_cert                   :=  ut.Credentials().fGetAppUserInfo('mysql_cert')[1].username;
shared MySQLPassword_cert               :=  ut.Credentials().fGetAppUserInfo('mysql_cert')[1].password;

shared MySQLServer_prod                 :=  'dbpgov-bct.risk.regn.net';
shared MySQLPort_prod                   :=  '3306';
shared MySQLDatabase_prod               :=  'ring_web';
shared MySQLUser_prod                   :=  ut.Credentials().fGetAppUserInfo('mysql_prod')[1].username;
shared MySQLPassword_prod               :=  ut.Credentials().fGetAppUserInfo('mysql_prod')[1].password;

shared fInsert_CoverageDates_Cert(dataset(FraudGovPlatform.Layouts.CoverageDates) pValues ) :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_cert),
                        server(MySQLServer_cert),
                        port(MySQLPort_cert),
                        database(MySQLDatabase_cert),
                        password(MySQLPassword_cert)
                 )
                        insert into source_coverage 
                                     (customer_id,customer_state,customer_program,contribution_code,source,source_group,max_reported_date,max_process_date,record_count, status)
                                     values (?,?,?,?,?,?,?,?,?,1);                        
        endembed;

shared fInsert_CoverageDates_Prod(dataset(FraudGovPlatform.Layouts.CoverageDates) pValues ) :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_prod),
                        server(MySQLServer_prod),
                        port(MySQLPort_prod),
                        database(MySQLDatabase_prod),
                        password(MySQLPassword_prod)
                 )
                        insert into source_coverage 
                                     (customer_id,customer_state,customer_program,contribution_code,source,source_group,max_reported_date,max_process_date,record_count, status)
                                     values (?,?,?,?,?,?,?,?,?,1);                        
        endembed;

shared fUpdate_CoverageDates_Cert  :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_cert),
                        server(MySQLServer_cert),
                        port(MySQLPort_cert),
                        database(MySQLDatabase_cert),
                        password(MySQLPassword_cert)
                 )
                        update source_coverage 
                                     set status = 0;                        
        endembed;

shared fUpdate_CoverageDates_Prod  :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_prod),
                        server(MySQLServer_prod),
                        port(MySQLPort_prod),
                        database(MySQLDatabase_prod),
                        password(MySQLPassword_prod)
                 )
                        update source_coverage 
                                     set status = 0;                        
        endembed;

export push_to_cert := sequential(     
            fUpdate_CoverageDates_Cert,
            fInsert_CoverageDates_Cert( coverage_dates )
        );
export push_to_prod := sequential(     
            fUpdate_CoverageDates_Prod,
            fInsert_CoverageDates_Prod( coverage_dates )
        );

END;

