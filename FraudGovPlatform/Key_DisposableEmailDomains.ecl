Import data_services,doxie;
r:=RECORD
  STRING200 domain;
  STRING1 dispsblemail;
 END;

d	:=dataset([],r);

EXPORT Key_DisposableEmailDomains	:= Index(d,{domain},{dispsblemail},
	data_services.Data_location.Prefix('FraudGov') + 'thor_data400::key::fraudgov::' 
	+ doxie.Version_SuperKey +'::kel::disposableemaildomains');
