/*
	Source(s)		Arizona Corporation Commission				 									
	Update Frequency		Monthly														
	Update Type		Updates Only														
	Expected Volume of Data																
	Data Description		"Arizona has two places to register business entities:  the Arizona Secretary of 
											State's Office and the Arizona Corporation Commission.  LN is only purchasing content 
											from the Corporation Commission.

The Arizona Corporation Commission accepts registrations for entity types: corporation, nonprofit corporation,
limited liability companies, trusts and cooperatives.  The commission requires that some articles of
incorporation have to be published in a newspaper; this is the reason for references to "publication" in the
record layout.

Arizona is unique in that the Arizona Secretary of State does not register corporations or limited liability 
companies (LLCs).   They do register trade names, limited partnerships, foreign limited partnerships, 
limited liability partnerships, reserved names and trademarks. LN is not receiving any of these datatypes.

	Source Structure																
	Source Notes		The vendor data consists of 4 record layouts:  CORPORATE MASTER( COREXT.TXT), 
									CHANGE LAYOUT (CHGEXT.TXT), FILING/HISTORY LAYOUT (FLMEXT.TXT) AND OFFICER LAYOUT (OFFEXT.TXT).
									One Master Record exists for each account number (COREXTM.MMDDYY).  The Record Id, Compacted 
									Corp Name and File Number are used to link CORE, CHGE and FLM.  File Number is used to link OFF.														
	Loading Notes																
*/