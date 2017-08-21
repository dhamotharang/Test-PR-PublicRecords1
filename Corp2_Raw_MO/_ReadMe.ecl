Update Frequency							Weekly	
		
Update Type										Full Append		
	
Expected Volume of Data		
			
Data Description						"The Secretary of State is responsible for the registration of all Missouri and 
														 out-of-state business entities doing business in Missouri. These business entities include for profit and 
														 nonprofit corporations, specialized business entities, such as professional corporations, close corporations,
														 agricultural cooperatives, mutual associations as well as limited liability companies, limited partnerships 
														 and many others. Missouri corporations must file articles of incorporation, while out-of-state corporations 
														 must obtain a certificate of authority. In addition, all corporations must file various documents required by law, 
														 such as amendments, mergers, consolidations and articles of dissolution, terminations and withdrawals."			
														 
Source Structure
					
Source Notes								"The vendor data consists of 15 textual (.txt) files in a relational table format that are comma-delimited. 
														 There are 7  data files (CorporationNames.txt; Address.txt; Corporation.txt; Filing.txt, Merger.txt, Officer and Stock) and 
														 8 reference data files (NameType.txt; AddressType.txt; CorporationType.txt; Corporation.txt; DocumentType.txt, OfficerPartyType, 
														 PartyType and StockClass) that will serve as explosion code tables. The primary key is the CorporationID formerly called the PItemID.
														 The corporations file is the master file. Each entity contains a CorporationID number that serves as a key to the CorporationNames.txt, 
														 Address.txt, Filing.txt, Merger.txt, Officer and Stock files. A corporation entity can have one to many names and addresses."			
Loading Notes					
