import _Control,lib_fileservices, std;

move_path    := '/data/prod_r3/b1058817/incoming/';
despray_path := '/data/prod_r3/b1058817/dali_files/';
lz := 'bctlpbatchio04.noam.lnrm.net';

Despray(unsigned1 mode, unsigned1 record_type, string8 version) := sequential(
  lib_fileservices.fileservices.Despray(
          '~thor_data400::output::d2c::' + D2C_Customers.Constants.sMode(mode) + '::' + D2C_Customers.Constants.sFile(record_type) + '_' + version
          ,lz
          ,despray_path + D2C_Customers.Constants.sFile(record_type)
          ,,,,TRUE),
  STD.File.MoveExternalFile(lz, despray_path + D2C_Customers.Constants.sFile(record_type), move_path + D2C_Customers.Constants.sFile(record_type))
  );

EXPORT proc_despray(unsigned1 mode, unsigned1 record_type, string8 version) 
       := Despray(mode, record_type, version);