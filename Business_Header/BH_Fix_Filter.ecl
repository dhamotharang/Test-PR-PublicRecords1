// Filter any bad records from previous Business Header file on a new build

export  boolean BH_Fix_Filter := 
not(
File_Business_Header.source ='BR' or
(File_Business_Header.source = 'D' and File_Business_Header.fein > 0) or
(File_Business_Header.source = 'C' and File_Business_Header.company_name
 in ['X','SAME','NATIONAL REGISTERED AGENTS, INC.','NATIONAL REGISTERED AGENTS']) or
(File_Business_Header.source = 'C' and File_Business_Header.vendor_id[1..2] in ['45', '48', '19', '28'])
);
