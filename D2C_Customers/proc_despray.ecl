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

EXPORT proc_despray(unsigned1 mode, string8 version) 
       := sequential(
            parallel(
              Despray(mode,1,version), //consumers
              Despray(mode,5,version), //bankruptcy
              Despray(mode,7,version)  //criminals
            ),
            parallel(
              Despray(mode,13,version), //liens
              Despray(mode,18,version), //sex_offenders   
              Despray(mode,2,version)   //addresses
            ),
            parallel(
              Despray(mode,3,version), //akas
              Despray(mode,6,version), //weapons
              Despray(mode,9,version)  //emails
            ),
            parallel(
              Despray(mode,10,version), //aircraft
              Despray(mode,11,version), //airmen
              Despray(mode,12,version)  //hunting
            ),
            parallel(
              Despray(mode,14,version), //ucc
              Despray(mode,15,version), //paw
              Despray(mode,16,version)  //phones
            ),
            parallel(
              Despray(mode,17,version), //pl
              Despray(mode,19,version), //voters         
              Despray(mode,20,version)  //deeds
            ),
            parallel(
              Despray(mode,21,version), //tax
              Despray(mode,4,version),  //relatives          
              Despray(mode,22,version), //students
              Despray(mode,8,version)   //civil
            )
       );