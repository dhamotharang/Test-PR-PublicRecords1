import _Control,lib_fileservices, std;

SourceIP := _Control.IPAddress.edata10;
preLF  := '~thor_data400::output::d2c::';
preDir := '/data/d2c/';
 
Despray(string filename) := lib_fileservices.fileservices.Despray(preLF + filename,SourceIP,preDir + filename,,,,TRUE);

desprayFiles := sequential(
            Despray('consumer_file'),
            Despray('address_history'),
            Despray('akas'),
            Despray('relatives'),
            Despray('bankruptcy'),
            Despray('concealed_weapons'),
            Despray('civil_criminal_records'),
            Despray('email_addresses'),
            Despray('faa_aircraft'),
            Despray('faa_pilots'),
            Despray('hunting_fishing_permits'),
            Despray('liens_judgements'),
            Despray('national_ucc_filings'),
            Despray('people_at_work'),
            Despray('phones'),
            Despray('professional_licenses'),
            Despray('sex_offenders'),
            Despray('voter_registration'),
            Despray('deeds_mortgages'),
            Despray('tax_assessments')
            );

// mode = 1 -> FULL
// mode = 2 -> QUARTERLY(CORE)
// mode = 3 -> MONTHLY(DEROGATORY)
// mode <> 1,2,3 -> INVALID MODE
EXPORT proc_build_all(unsigned1 mode = 1, string8 version = (string8)std.Date.Today(), string20 customer_name = '') := sequential(
          proc_build_consumers(mode, version, customer_name),
          proc_build_addresses(mode, version, customer_name),
          proc_build_akas(mode, version, customer_name),
          proc_build_bankruptcy(mode, version, customer_name),
          proc_build_weapons(mode, version, customer_name),
          proc_build_criminals(mode, version, customer_name),
          proc_build_emails(mode, version, customer_name),
          proc_build_aircraft(mode, version, customer_name),
          proc_build_airmen(mode, version, customer_name),
          proc_build_hunting(mode, version, customer_name),
          proc_build_liens(mode, version, customer_name),
          proc_build_ucc(mode, version, customer_name),
          proc_build_people_at_work(mode, version, customer_name),
          proc_build_phones(mode, version, customer_name),
          proc_build_professional_licenses(mode, version, customer_name),
          proc_build_sex_offenders(mode, version, customer_name),
          proc_build_voters(mode, version, customer_name), //layout mismatach
          proc_build_deeds(mode, version, customer_name),
          proc_build_tax(mode, version, customer_name),
          proc_build_relatives(mode, version, customer_name)
          );



// EXPORT proc_build_all(unsigned1 mode = 1, string8 version = (string8)std.Date.Today(), string20 customer_name = '') := 
              // sequential(
                // buildFiles(mode, version, customer_name),
                // desprayFiles
                // );