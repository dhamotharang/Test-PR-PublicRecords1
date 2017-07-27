#workunit('name', 'Corporate Contacts Stats ' + corporate.Corp4_Build_Date);

Corp_Contacts := Corporate.File_Corp4_Contacts_Base_DID;

Layout_Corp_Contacts_Slim := RECORD
string2   state_origin;
string100 officer_name;
string8   officer_title;
string70  officer_street;
string32  officer_city;
string2   officer_state;
string9   officer_zip;
STRING8   extract_date;
STRING1   record_type;
STRING12  did;
END;

Layout_Corp_Contacts_Slim InitCorpContacts(Corporate.Layout_Corp_Contacts_DID L) := TRANSFORM
self.did := (string12) L.did;
SELF := L;
END;

Corp_Contacts_Init := PROJECT(Corp_Contacts, InitCorpContacts(LEFT));

Layout_Corp_Contacts_Stat := record
Corp_Contacts_Init.state_origin;
INTEGER4  officer_name_count := SUM(GROUP, IF(Corp_Contacts_Init.officer_name<>'',1,0));

// Title code
INTEGER4  officer_title_count := SUM(GROUP, IF(Corp_Contacts_Init.officer_title<>'',1,0));
INTEGER4  officer_title_HA := SUM(GROUP, IF(Corp_Contacts_Init.officer_title='HA',1,0));
INTEGER4  officer_title_valid := SUM(GROUP, IF(Corp_Contacts_Init.officer_title<>'' AND
                                               Corp_Contacts_Init.officer_title<>'HA' AND
                                               (INTEGER)Corp_Contacts_Init.officer_title >= 1 AND
                                               (INTEGER)Corp_Contacts_Init.officer_title <= 50,1,0));
INTEGER4  officer_title_invalid := SUM(GROUP, IF(Corp_Contacts_Init.officer_title<>'' AND
                                               Corp_Contacts_Init.officer_title<>'HA' AND
                                               (INTEGER)Corp_Contacts_Init.officer_title < 1 AND
                                               (INTEGER)Corp_Contacts_Init.officer_title > 50,1,0));
INTEGER4  officer_title_blank := SUM(GROUP, IF(Corp_Contacts_Init.officer_title='',1,0));

INTEGER4  officer_street_count := SUM(GROUP, IF(Corp_Contacts_Init.officer_street<>'',1,0));
INTEGER4  officer_city_count := SUM(GROUP, IF(Corp_Contacts_Init.officer_city<>'',1,0));
INTEGER4  officer_state_count := SUM(GROUP, IF(Corp_Contacts_Init.officer_state<>'',1,0));
INTEGER4  officer_zip_count := SUM(GROUP, IF(Corp_Contacts_Init.officer_zip<>'',1,0));
INTEGER4  extract_date := SUM(GROUP, IF(Corp_Contacts_Init.extract_date<>'',1,0));

// Record Type
INTEGER4  record_type_C := SUM(GROUP, IF(Corp_Contacts_Init.record_type='C',1,0));
INTEGER4  record_type_H := SUM(GROUP, IF(Corp_Contacts_Init.record_type='H',1,0));

// DID
INTEGER4  did_count := SUM(GROUP, IF((INTEGER)Corp_Contacts_Init.did<>0,1,0));
INTEGER4  did_zero := SUM(GROUP, IF((INTEGER)Corp_Contacts_Init.did=0,1,0));

INTEGER4 total:= COUNT(GROUP);
END;

Corp_Contacts_Stat := TABLE(Corp_Contacts_Init, Layout_Corp_Contacts_Stat, state_origin, FEW);

OUTPUT(Corp_Contacts_Stat);