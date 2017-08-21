import ut;

/* The translations for crim case codes are found throughout the code tables file  
   You need to look in a number of locations to compile all the relevant values
   The following are my best guess at which are the proper codes to use, but it should be
   noted that although juvenile cases are included, no defendants coded as juvenile are
   used within the party file:

   APCR - "Appeal Criminal"
   APDS - "Appeal Death Sentence"
   APHC - "Appeal Habeas Corpus"
   APJL - "Appeal Juvenile Delinquency"
   APJV - "Appeal Juvenile"
   APPC - "Appeal Post Conviction"
   APPR - "Appeal Parol Review"
   APTR - "Appeal Traffic"
   JUDF - "Juvenile Delinquency: Felony"
   JUDI - "Juvenile Delinquency: Infraction"
   JUDM - "Juvenile Delinquency: Misdemeanor"
   JUDV - "Juvenile Delinquency: Violation"
   JUJU - "Juvenile"
   JUOT - "Juvenile Other"
   JURM - "Juvenile Remand"
   JUSO - "Juvenile Status Offense"
   OFEX - "Offense Extradition"
   OFFE - "Offense Felony I"
   OFIF - "Offense Infraction"
   OFMI - "Offense Misdemeanor I"
   OFOT - "Offense Other"
   OFVI - "Offense Violation"

*/
crim_cases    := ['APCR','APDS','APHC','APJL','APJV','APPC','APPR','APTR','JUDF','JUDI','JUDM'
			     ,'JUDV','JUJU','JUOT','JURM','JUSO','OFEX','OFFE','OFIF','OFMI','OFOT','OFVI'];

ds_case := dataset(ut.foreign_dataland + '~thor_data400::in::OR_Court_mapped_cases',Crim.Layout_OR_Case,flat);

// Filter for just criminal cases
export File_OR_Raw_Case := ds_case(case_class+case_type IN crim_cases);

