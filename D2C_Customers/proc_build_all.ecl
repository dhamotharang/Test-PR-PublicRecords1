import _Control,lib_fileservices, std;

// mode = 1 -> FULL
// mode = 2 -> QUARTERLY(CORE)
// mode = 3 -> MONTHLY(DEROGATORY)
// mode <> 1,2,3 -> INVALID MODE
Derogatory_builds(unsigned1 mode, string8 version, string20 customer_name) := parallel(
   D2C_Customers.proc_build_consumers(mode, version, customer_name),
   D2C_Customers.proc_build_bankruptcy(mode, version, customer_name),
   D2C_Customers.proc_build_criminals(mode, version, customer_name),
   D2C_Customers.proc_build_liens(mode, version, customer_name),
   D2C_Customers.proc_build_sex_offenders(mode, version, customer_name)
);

EXPORT proc_build_all(unsigned1 mode = 1, string8 version = (string8)std.Date.Today(), string20 customer_name = '') := 
      sequential(
         parallel(
         //  Derogatory_builds(mode, version, customer_name),
          if(mode <> 3, parallel(
          D2C_Customers.proc_build_addresses(mode, version, customer_name),
          D2C_Customers.proc_build_akas(mode, version, customer_name),
          D2C_Customers.proc_build_relatives(mode, version, customer_name),
          D2C_Customers.proc_build_weapons(mode, version, customer_name),
          D2C_Customers.proc_build_emails(mode, version, customer_name),
          D2C_Customers.proc_build_aircraft(mode, version, customer_name),
          D2C_Customers.proc_build_airmen(mode, version, customer_name),
          D2C_Customers.proc_build_hunting(mode, version, customer_name),          
          D2C_Customers.proc_build_ucc(mode, version, customer_name),
          D2C_Customers.proc_build_people_at_work(mode, version, customer_name),
          D2C_Customers.proc_build_phones(mode, version, customer_name),
          D2C_Customers.proc_build_professional_licenses(mode, version, customer_name),         
          D2C_Customers.proc_build_voters(mode, version, customer_name),
          D2C_Customers.proc_build_deeds(mode, version, customer_name),
          D2C_Customers.proc_build_tax(mode, version, customer_name),         
          D2C_Customers.proc_build_students(mode, version, customer_name),
          D2C_Customers.proc_build_civil(mode, version, customer_name),
          D2C_Customers.proc_build_foreclosure(mode, version, customer_name)
          ) //end of parallel
          ) //end of if
         ) //end of parallel
         // ,D2C_Customers.proc_despray(mode, version)
      );
