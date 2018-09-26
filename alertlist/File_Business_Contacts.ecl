IMPORT business_header;

EXPORT File_Business_Contacts := dataset(alertlist.constants.prefix + 'base::business_contacts', recordof(business_header.File_Business_Contacts), thor);