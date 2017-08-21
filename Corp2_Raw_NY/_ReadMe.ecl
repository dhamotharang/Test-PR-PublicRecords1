/*
	Source(s)		        State of New York Department of State										
	Update Frequency		Weekly and Quarterly													
	Update Type		      Full Append													
														
	Data Description		The NY file contains records of active and inactive corporations, limited partnerships, 
											limited liability partnerships and limited liability companies registered with the Office
											of the Secretary of State in Albany, New York and present on the stateâ€™s database.  The 
											information currently dates back to the late 1770â€™s.													
															
	Source Notes		    "The Master record contains information identifying the type of document as well as the
								    	business name. Eight supplemental records contain information regarding the agent, fictitious 
									    names and executives.  Merger records are received quarterly only.

The records (one master and eight different supplemental records) are 250 character, fixed length format organized
sequentially in Corporation ID Number/Microfilm Number/Record Type/Date Filed order.  There is a total of 126 fields.  

In the weekly update, the vendor sends three files: a delete file, a data file (corp.adds containing all adds and
replacements) and the merger file. 

The delete record consists of the Corporation ID Number, Microfilm Number and Record Type, which is associated with
the DELETE file.  This information is used to match the same record in the master record for deletion.  The merger
records will be used to create merger/history information.  The weekly file will contain only new or modified 
records pertaining to a corporation and not ALL records (from previous updates).   All new/modified and old records 
in the master file will then need to be combined to create the new online document.  													
	
*/														
