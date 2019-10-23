Import Data_Services;
EXPORT keys := MODULE
  emaildata:=TABLE(Acquireweb_Email.files.file_Acquireweb_Base,{Acquireweb_Email.files.file_Acquireweb_Base.did;string100 email:=Acquireweb_Email.files.file_Acquireweb_Base.email;});
  EXPORT key_Acquireweb_Email:=INDEX(emaildata,{email},{did},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data200::key::acquireweb::email');
END;