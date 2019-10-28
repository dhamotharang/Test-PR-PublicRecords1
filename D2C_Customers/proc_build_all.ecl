import _Control,lib_fileservices, std;

// mode = 1 -> FULL
// mode = 2 -> QUARTERLY(CORE)
// mode = 3 -> MONTHLY(DEROGATORY)
// mode <> 1,2,3 -> INVALID MODE
Derogatory_builds(unsigned1 mode, string8 version, string20 customer_name) := sequential(
   D2C_Customers.proc_build_consumers(mode, version, customer_name),
   D2C_Customers.proc_build_bankruptcy(mode, version, customer_name),
   D2C_Customers.proc_build_criminals(mode, version, customer_name),
   D2C_Customers.proc_despray(mode,1,version), //consumers
   D2C_Customers.proc_despray(mode,5,version), //bankruptcy
   D2C_Customers.proc_despray(mode,7,version), //criminals
   D2C_Customers.proc_build_liens(mode, version, customer_name),
   D2C_Customers.proc_build_sex_offenders(mode, version, customer_name)
   D2C_Customers.proc_despray(mode,13,version), //liens
   D2C_Customers.proc_despray(mode,18,version), //sex_offenders
);

EXPORT proc_build_all(unsigned1 mode = 1, string8 version = (string8)std.Date.Today(), string20 customer_name = '') := sequential(
          Derogatory_builds(mode, version, customer_name),
          if(mode=3, sequential(
          D2C_Customers.proc_build_addresses(mode, version, customer_name),
          D2C_Customers.proc_build_akas(mode, version, customer_name),
          D2C_Customers.proc_build_weapons(mode, version, customer_name),
          D2C_Customers.proc_despray(mode,2,version), //addresses
          D2C_Customers.proc_despray(mode,3,version), //akas
          D2C_Customers.proc_despray(mode,6,version), //weapons
          D2C_Customers.proc_build_emails(mode, version, customer_name),
          D2C_Customers.proc_build_aircraft(mode, version, customer_name),
          D2C_Customers.proc_build_airmen(mode, version, customer_name),
          D2C_Customers.proc_despray(mode,9,version),  //emails
          D2C_Customers.proc_despray(mode,10,version), //aircraft
          D2C_Customers.proc_despray(mode,11,version), //airmen
          D2C_Customers.proc_build_hunting(mode, version, customer_name),          
          D2C_Customers.proc_build_ucc(mode, version, customer_name),
          D2C_Customers.proc_build_people_at_work(mode, version, customer_name),
          D2C_Customers.proc_despray(mode,12,version), //hunting
          D2C_Customers.proc_despray(mode,14,version), //ucc
          D2C_Customers.proc_despray(mode,15,version), //paw
          D2C_Customers.proc_build_phones(mode, version, customer_name),
          D2C_Customers.proc_build_professional_licenses(mode, version, customer_name),         
          D2C_Customers.proc_build_voters(mode, version, customer_name),
          D2C_Customers.proc_despray(mode,16,version), //phones
          D2C_Customers.proc_despray(mode,17,version), //pl
          D2C_Customers.proc_despray(mode,19,version), //voters
          D2C_Customers.proc_build_deeds(mode, version, customer_name),
          D2C_Customers.proc_build_tax(mode, version, customer_name),
          D2C_Customers.proc_build_relatives(mode, version, customer_name),
          D2C_Customers.proc_despray(mode,20,version), //deeds
          D2C_Customers.proc_despray(mode,21,version), //tax
          D2C_Customers.proc_despray(mode,4,version),  //relatives
          D2C_Customers.proc_build_students(mode, version, customer_name),
          D2C_Customers.proc_build_civil(mode, version, customer_name)
          D2C_Customers.proc_despray(mode,22,version), //students
          D2C_Customers.proc_despray(mode,8,version),  //civil
          )));
