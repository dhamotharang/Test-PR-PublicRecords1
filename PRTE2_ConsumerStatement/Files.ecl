IMPORT business_header, TopBusiness_BIPV2, Cortera, PRTE2_ConsumerStatement, PRTE2;
EXPORT Files := MODULE

  //Input Files
  EXPORT Input := DATASET('~prte::in::ConsumerStatement::Insurance', PRTE2_ConsumerStatement.Layouts.INPUT,
                          CSV(HEADING(3), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')))(recordtype = 'CS');
 
  //Base
  EXPORT Base := DATASET(PRTE2_ConsumerStatement.Constants.base_prefix +'ConsumerStatement', 
                         PRTE2_ConsumerStatement.Layouts.Base, thor);

  //Non_FCRA Keys
  EXPORT Address := dedup(PROJECT(Base, TRANSFORM(PRTE2_ConsumerStatement.Layouts.Address_Key, 
                                                  SELF := LEFT, 
                                                  SELF := [])), record,all);  
  
  EXPORT Phone := dedup(PROJECT(Base(phone <> ''), TRANSFORM(PRTE2_ConsumerStatement.Layouts.Phone_Key, 
                                                             SELF := LEFT, 
                                                             SELF := [])), record,all); 
   
  EXPORT StatementID := dedup(PROJECT(Base(statement_id > 0), TRANSFORM(PRTE2_ConsumerStatement.Layouts.StatementID_Key, 
                                                                        SELF := LEFT, 
                                                                        SELF := [])), record,all); 
  
  //FCRA Keys
  EXPORT lexid := dedup(PROJECT(Base(did > 0), TRANSFORM(PRTE2_ConsumerStatement.Layouts.LexID_Key,
                                                         SELF.lexid := LEFT.DID;
                                                         SELF.CS_text := LEFT.consumer_text;
                                                         SELF.datecreated := LEFT.date_created;
                                                         SELF := LEFT, 
                                                         SELF := [])), record,all);  
                                                          
  EXPORT SSN := dedup(PROJECT(Base(ssn <> ''), TRANSFORM(PRTE2_ConsumerStatement.Layouts.SSN_Key,
                                                         SELF.lexid := LEFT.DID;
                                                         SELF.CS_text := LEFT.consumer_text;
                                                         SELF.datecreated := LEFT.date_created;
                                                         SELF := LEFT, 
                                                         SELF := [])), record,all);                                                         

END;