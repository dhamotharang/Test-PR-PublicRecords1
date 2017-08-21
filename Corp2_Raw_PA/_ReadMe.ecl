/*
	Source(s)						Pennsylvania Department of State				 							
	Update Frequency		Monthly													
	Update Type					Full Replace													
															
	Data Description		The source contains active and inactive domestic and foreign corporations,
											partnerships, limited liability companies and other business entities registered 
											with the Secretary of State.  
													
	Source Structure		The vendor sends 7 data files and 7 lookup files.
											Data Files:    CorpName, Address, Officer, Corporations, Filing, Merger, Stock.  
                      Lookup files:  CorpStatus, CorpType, NameType, AddrType, OfficerParty, PartyType, DocType.
												
	Source Notes				The Stock file is always empty and will be checked in the mapper to verify that it's still empty.				

											The primary key is CorporationID. A Corporation can have more than one name and address.
											Although every corporation is required to have only one â€˜Legalâ€™ name.													

*/