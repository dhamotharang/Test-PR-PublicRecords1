/*
Source(s):								Nevada Secretary of State
Update Frequency:					Monthly
Update Type:							Unload
Expected Volume of Data:	550,000 documents (more or less)
Data Description:					The source contains active and inactive domestic and foreign corporations,
													partnerships, limited liability companies and other business entities registered
													with the Office of the Secretary of State.  The information dates back to the 
													late 1890's.			
Source Structure:					Relational; There are five (5) ~ delimited text files in a zip file with the naming convention: 
															Corporations.998.currentdate:  
																	1. Corporations.Crprtn.998.currentdate    (Corporation Master records)
																	2. Corporations.RsdnAgn.998.currentdate	  (Registered Agent records)
																	3. Corporations.CrptOffc.998.currentdate  (Officer Contact records)
																	4. Corporations.CrprtAct.998.currentdate  (Action records for AR & Events)
																	5. Corporations.CrprtStc.998.currentdate  (Stock records)

													Additionally, there are two (2) ~ delimited text files in a zip file with the naming convention: 
															MARK.998.currentdate:  
																 1. MARK.Mr.998.currentdate     (Trademark records)
																 2. MARK.MrAct.998.currentdate  (Trademark Action records)			

Source Notes:							Delimited (~)			
Loading Notes:						
*/

