// Filter any bad records from previous Business Header file on a new build

export boolean BC_Fix_Filter := 
not(
File_Business_Contacts.source in ['BR'] or
(File_Business_Contacts.source = 'D' and File_Business_Contacts.company_fein > 0) or
(File_Business_Contacts.source = 'C' and File_Business_Contacts.company_name
 in ['X','SAME','NATIONAL REGISTERED AGENTS, INC.','NATIONAL REGISTERED AGENTS']) or
(File_Business_Contacts.source = 'C' and File_Business_Contacts.vendor_id[1..2] in ['45', '48', '19', '28'])
);

