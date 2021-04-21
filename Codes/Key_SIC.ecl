IMPORT Codes, Data_Services, doxie;

SicCodeKeyLayout := 
  RECORD
    STRING8 Code;
    STRING80 Desc;
  END;

Sic4Key :=
  DISTRIBUTE(PULL(                                      
    INDEX(Codes.Key_SIC4(),data_services.foreign_prod+'thor_data400::key::SIC4::Codes_Lookup_qa')),
    HASH64(SIC4_Code));

Sic8BaseFilie :=
  DISTRIBUTE(PULL(                                      
    DATASET(data_services.foreign_prod+'thor_data400::base::siccodes::qa::lookup',
            {STRING8 sic_code, STRING80 sic_description},FLAT)),
    HASH64(SIC_Code));
        
Sic4Recs := 
  PROJECT(Sic4Key,
    TRANSFORM(SicCodeKeyLayout,
      SELF.code := LEFT.sic4_code,
      SELF.desc := LEFT.sic4_description));

Sic8Recs := 
  PROJECT(Sic8BaseFilie,
    TRANSFORM(SicCodeKeyLayout,
      SELF.code := LEFT.sic_code,
      SELF.desc := LEFT.sic_description));

SicRecs := Sic4Recs + Sic8Recs;

KeyName := 'thor_data400::key::SIC::';

EXPORT Key_SIC := 
  INDEX(sicRecs,
        {Code},
				{sicRecs},
				Data_Services.Data_location.Prefix('SIC_CODES') + KeyName + doxie.Version_SuperKey + '::Codes_lookup');
