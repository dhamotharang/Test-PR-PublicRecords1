Import data_services,doxie;
r:=RECORD
  UNICODE200 DisposableEmailDomain;
 END;

d	:=dataset([],r);

EXPORT Key_DisposableEmailDomains	:= Index(d,{DisposableEmailDomain},{d},
																									 data_services.Data_location.Prefix('FraudGov') + 'thor_data400::key::fraudgov::' 
																									 + doxie.Version_SuperKey +'::kel::disposableemaildomains');
