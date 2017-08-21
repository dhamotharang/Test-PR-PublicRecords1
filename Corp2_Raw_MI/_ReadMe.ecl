/*
Source(s):								Michigan Bureau of Commercial Services/Department of Labor and Economic Development
Update Frequency:					Weekly
Update Type:							Update Only
Expected Volume of Data:	
Data Description:					There is one vendor file that consists of 13 different record types and layouts.
													The vendor data has 13 record layouts in fixed record format with a total
													of 192 fields.  The vendor sends a delete record.

													Only one master record and zero to many of all other records exists per online
													document.  Master records are identified as 1A & 1B (corporations), 2A & 2B 
													(partnerships), 3A & 3B (LLCs), 30 (Name Registrations) and 60 (Pending records).
													All other records (50, 70, 80 and 90) are subordinate records to those master 
													records. Not all fields below will be used.

Source Structure:					
Source Notes:							Concerning 00 - Delete Record:  The delete record is not being handled at this time.
													A future project is being considered to handle delete records sent from the vendor.

													Concerning 60 - Pending Record: Pending record contains a temporary Indicator Number
													and temporary filing information.  The Indicator Number changes once the business
													entity becomes an official corporate filing.  If we map this data, we will have two
													Corp History records for the same company:  one with a status of "pending" for
													perpetuity and one with the ongoing corporate status.  There is no number that links
													a pending record and the permanent Indicator Number.  In order not to have two charter
													numbers and two corporate filings for the same company, this record layout will not
													be mapped.
Loading Notes:						
*/

