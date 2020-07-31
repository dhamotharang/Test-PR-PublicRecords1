Import FraudGovPlatform, MySQL, ut,Fraudshared;
EXPORT Build_CoverageDates_Push := MODULE

shared coverage_dates := FraudGovPlatform.Files().Base.CoverageDates.Built;

shared bank_names	:= dedup(sort(project(Pull(Fraudshared.Key_BankName('FraudGov'))
													,Transform(FraudGovplatform.Layouts.banknames,self:=left)),bank_name),bank_name);

shared isp_names	:= dedup(sort(project(Pull(Fraudshared.Key_ISP('FraudGov'))
													,Transform(FraudGovplatform.Layouts.IspNames,self.isp_name:=left.isp,self:=left)),isp_name),isp_name);
													
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
//BankNames
shared dataset(Fraudgovplatform.Layouts.banknames) fGetBankNames_Cert :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_cert),
                        server(MySQLServer_cert),
                        port(MySQLPort_cert),
                        database(MySQLDatabase_cert),
                        password(MySQLPassword_cert)
                 )              						
								Select Bank_name from bank_names ;                 
        endembed;
				
shared dataset(Fraudgovplatform.Layouts.banknames) fGetBankNames_Prod :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_prod),
                        server(MySQLServer_prod),
                        port(MySQLPort_prod),
                        database(MySQLDatabase_prod),
                        password(MySQLPassword_prod)
                 )              						
								Select Bank_name from bank_names ;                 
        endembed;

shared fNewBankNames_Cert := Join(bank_names, fGetBankNames_Cert,left.bank_name=right.bank_name,left only);
shared fNewBankNames_Prod := Join(bank_names, fGetBankNames_Prod,left.bank_name=right.bank_name,left only);
				
shared fInsert_BankNames_Cert(dataset(FraudGovPlatform.Layouts.BankNames) pValues ) :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_Cert),
                        server(MySQLServer_Cert),
                        port(MySQLPort_Cert),
                        database(MySQLDatabase_Cert),
                        password(MySQLPassword_Cert)
                 )            
							
								insert into bank_names (bank_name)
                 values(?);                 
        endembed;
				
shared fInsert_BankNames_Prod(dataset(FraudGovPlatform.Layouts.BankNames) pValues ) :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_Prod),
                        server(MySQLServer_Prod),
                        port(MySQLPort_Prod),
                        database(MySQLDatabase_Prod),
                        password(MySQLPassword_Prod)
                 )            
							
								insert into bank_names (bank_name)
                 values(?);                 
        endembed;
//ISP Names				
shared dataset(Fraudgovplatform.Layouts.ispnames) fGetISPNames_Cert :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_cert),
                        server(MySQLServer_cert),
                        port(MySQLPort_cert),
                        database(MySQLDatabase_cert),
                        password(MySQLPassword_cert)
                 )              						
								Select Isp_name from isp_names ;                 
        endembed;
				
shared dataset(Fraudgovplatform.Layouts.ispnames) fGetISPNames_Prod :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_prod),
                        server(MySQLServer_prod),
                        port(MySQLPort_prod),
                        database(MySQLDatabase_prod),
                        password(MySQLPassword_prod)
                 )              						
								Select Isp_name from isp_names ;                  
        endembed;
				
shared fNewIspNames_Cert := Join(isp_names, fGetISPNames_Cert,left.isp_name=right.isp_name,left only);
shared fNewIspNames_Prod := Join(isp_names, fGetISPNames_Prod,left.isp_name=right.isp_name,left only);

shared fInsert_IspNames_Cert(dataset(FraudGovPlatform.Layouts.IspNames) pValues ) :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_Cert),
                        server(MySQLServer_Cert),
                        port(MySQLPort_Cert),
                        database(MySQLDatabase_Cert),
                        password(MySQLPassword_Cert)
                 )            
							
								insert into Isp_names (Isp_name)
                 values(?);                 
        endembed;
				
shared fInsert_IspNames_Prod(dataset(FraudGovPlatform.Layouts.IspNames) pValues ) :=
        embed(mysql :   MYSQL_OPT_SSL_CIPHER('DHE-RSA-AES256-SHA'),
                        user(MySQLUser_Prod),
                        server(MySQLServer_Prod),
                        port(MySQLPort_Prod),
                        database(MySQLDatabase_Prod),
                        password(MySQLPassword_Prod)
                 )            
							
								insert into Isp_names (Isp_name)
                 values(?);                 
        endembed;
				
export push_to_cert := sequential(     
            fUpdate_CoverageDates_Cert,
            fInsert_CoverageDates_Cert( coverage_dates ),
						fInsert_BankNames_Cert(fNewBankNames_Cert),
						fInsert_IspNames_Cert(fNewIspNames_Cert)
						
        );
export push_to_prod := sequential(     
            fUpdate_CoverageDates_Prod,
            fInsert_CoverageDates_Prod( coverage_dates ),
						fInsert_BankNames_Prod(fNewBankNames_Prod),
						fInsert_IspNames_Prod(fNewIspNames_Prod)
        );

END;

