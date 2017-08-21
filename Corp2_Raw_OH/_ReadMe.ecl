/* Source(s)								:		  Ohio Secretary of State Business Services Division	
   		
   Update Frequency					:			Weekly
   			
   Update Type							:			Full Append	
   		
   Expected Volume of Data	:		
   											
   Data Description					:	 The file is a weekly update which contains records of active and inactive domestic and foreign profit corporations, partnerships, limited liability companies, non-profit companies,
															 business trusts, real estate trusts, churches, fictitious names, trade names, trademarks, servicemarks and name reservations.
															 The Corporation files can be divided into two functional groups, those that contain business data and those that contain validation data. 
															 The business data files contain records of the business filings and transactions.  The validation data files contain codes used in the business data and their descriptions.  
															 There is also a summary file that is provided that gives the date and time that the files were written and the record count of each file
   	
   Source Structure					:	
   							
	 Source Notes							:   The business files are:  Business (corpdata.bus), Document_Transaction (corpdata.trn), 
																Explanation (corpdata.epn), Agent_Contact (corpdata.agn), Old_Name  (corpdata.nam),  
																Business_Address (corpdata.adr ), Business_Associate (corpdata.ass), Authorized_Share  
																(corpdata.shr) and Text_Information (corpdata.inf)
																The validation files are:  Business_Type (corpdata.but), Tran_Code (corpdata.trc),  
																Explanation_Code (corpdata.exc), Share_Code (corpdata.shc), Address Type (corpdata.adt), 
																Business_Class (corpdata.buc), County_Num (corpdata.ctn), State_Code (corpdata.stc)
																	
   Loading Notes					  :		
*/					

