IMPORT iesp;

qid := eAuth.Constants.QID;

export file_questions := 
dataset ([ 
  {qid.NONE,   '',   'Invalid input', false},
  {qid.COUNTY1,   'county1',   'In which of the counties below have you lived?',        true},
  {qid.CITY1,     'city1',     'In which of the cities below is %s?',                   false},  //<current address>
  {qid.ZIP1,      'zip1',      'Which zip code is valid for %s?',                       false},  //<current address>
  {qid.CITY2,     'city2',     'Which of the cities below are in %s county?',           true},   //<county of residence>
  {qid.CITY3,     'city3',     'In which of the cities below is %s?',                   false},  //<prior address>
  {qid.CITY4,     'city4',     'Which of the cities below are in %s county?',           true},   //<county of prior residence>
  {qid.CITY5,     'city5',     'In which of the cities below is %s?',                   false},
  {qid.PEOPLE1,   'people1',   'Which of the following people do you know?',            true},
  {qid.PROPERTY1, 'property1', 'How long have you lived at %s?',                        false},  //<current address>
  {qid.PROPERTY2, 'property2', 'What is the approximate total square footage of your home at %s?', false},  //<current address>
  {qid.PROPERTY3, 'property3', 'How much did you pay for your home at %s?',             false},  //<current address>
  {qid.PROPERTY4, 'property4', 'From whom did you purchase your residence at %s?',      false},  //<current address>
  {qid.PROPERTY5, 'property5', 'When did you purchase your home at %s?',                false},
  {qid.PROPERTY6, 'property6', 'What type of residence is %s?',                         false},  //?<current address>? :
  // Single Family, Residence, Condominium, Townhouse, Apartment, I don't know
  {qid.PROPERTY7, 'property7', 'When was the building at %s built?',                    false},  //<current address>
  {qid.VEHICLE1,  'vehicle1',  'Which of the following vehicles do you own?',           true},
  {qid.VEHICLE2,  'vehicle2',  'What year is your %s?',                                 false},  //<vehicle description>
  {qid.VEHICLE3,  'vehicle3',  'What color is your %s?',      	                         false},  //<vehicle description>
  {qid.VEHICLE4,  'vehicle4',  'Who is the lien/lease holder for your %s?',             false},  //<vehicle description>
  {qid.VEHICLE5,  'vehicle5',  'When did you purchase/lease your %s?',                  false},  //<vehicle description>
  {qid.ADDRESS1,  'address1',  'At which of the following addresses have you lived?',   true},
  {qid.SSN1,      'ssn1',      'In what state was your social security number issued?', false},
  {qid.CITY6,     'city6',     'In what city is each of the following addresses?',      true}
], {unsigned1 qid, string12 qname, Constants.t_prompt prompt, boolean multiple_correct});

/*
For zip1 -> can use thor_data400::key::cityst2zip, but this key is in dataland and not on prod.



*/