import ut;
export Rollup_Base(

	dataset(Layouts.Base) pDataset
	
) :=
function

	pDataset_Dist := distribute(pDataset, hash(rawfields.zoomId));
	pDataset_sort := sort(pDataset_Dist
		,rawfields.zoomID																							
		,rawfields.Name_Last																						
		,rawfields.Name_First															
		,rawfields.Name_Middle																
		,rawfields.Name_Prefix															
		,rawfields.Name_Suffix															
		,rawfields.Job_Title																
		,rawfields.Job_Title_Hierarchy_Level	
		,rawfields.Job_Function
		,rawfields.Company_Division_Name										
		,rawfields.Phone																		
		,rawfields.Email_Address	
		,rawfields.Person_Street   
		,rawfields.Person_City   
		,rawfields.Person_State  
		,rawfields.Person_Zip    
		,rawfields.Person_Country
		,rawfields.Source_Count														
		,rawfields.Zoom_Company_ID													
		,rawfields.Acquiring_Company_ID										
		,rawfields.Parent_Company_ID												
		,rawfields.Company_Name														
		,rawfields.Company_Domain_Name											
		,rawfields.Company_Phone														
		,rawfields.Industry_Label													
		,rawfields.Industry_Hierarchical_Category					
		,rawfields.Secondary_Industry_Label								
		,rawfields.Secondary_Industry_Hierarchical_Category
		,rawfields.Revenue   
		,rawfields.Employees 
		,rawfields.SIC1
		,rawfields.SIC2
		,rawfields.TitleCode 
		,rawfields.Highest_Level_Job_Fuction
		,rawfields.Person_Pro_URL
		,rawfields.Encrypted_Email_Address
		,rawfields.Email_Domain
		,rawfields.Query_Name
		,ace_aid																							
		,local
	);
	
	Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := 
	transform
		self.dt_first_seen 													:=	ut.EarliestDate(
																								ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen)
																								,ut.EarliestDate(l.dt_last_seen		,r.dt_last_seen	)
																								);
		self.dt_last_seen 					        	      := MAX(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 								:= MAX(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported               := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id						              := if(l.source_rec_id <> 0, l.source_rec_id, r.source_rec_id);
		self.record_type							              := if(l.record_type = 'C' or r.record_type = 'C', 'C', 'H');
		self.rawfields.Acquiring_Company_ID			    := if(l.rawfields.Acquiring_Company_ID = '', r.rawfields.Acquiring_Company_ID, l.rawfields.Acquiring_Company_ID);
		self.rawfields.Parent_Company_ID			      := if(l.rawfields.Parent_Company_ID = '', r.rawfields.Parent_Company_ID, l.rawfields.Parent_Company_ID);
		self.rawfields.SIC1	                        := if(l.rawfields.SIC1 = '', r.rawfields.SIC1, l.rawfields.SIC1);
		self.rawfields.SIC2	                        := if(l.rawfields.SIC2 = '', r.rawfields.SIC2, l.rawfields.SIC2);
		self.rawfields.TitleCode	                  := if(l.rawfields.TitleCode = '', r.rawfields.TitleCode, l.rawfields.TitleCode);
		self.rawfields.Highest_Level_Job_Fuction	  := if(l.rawfields.Highest_Level_Job_Fuction = '', r.rawfields.Highest_Level_Job_Fuction, l.rawfields.Highest_Level_Job_Fuction);
		self.rawfields.Person_Pro_URL	              := if(l.rawfields.Person_Pro_URL = '', r.rawfields.Person_Pro_URL, l.rawfields.Person_Pro_URL);
		self.rawfields.Encrypted_Email_Address	    := if(l.rawfields.Encrypted_Email_Address = '', r.rawfields.Encrypted_Email_Address, l.rawfields.Encrypted_Email_Address);
		self.rawfields.Email_Domain	                := if(l.rawfields.Email_Domain = '', r.rawfields.Email_Domain, l.rawfields.Email_Domain);
    self.rawfields.Query_Name	                  := if(l.rawfields.Query_Name = '', r.rawfields.Query_Name, l.rawfields.Query_Name);
		self := l;

	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,rawfields.zoomID																							
														,rawfields.Name_Last																						
														,rawfields.Name_First															
														,rawfields.Name_Middle																
														,rawfields.Name_Prefix															
														,rawfields.Name_Suffix															
														,rawfields.Job_Title																
														,rawfields.Job_Title_Hierarchy_Level	
														,rawfields.Job_Function
														,rawfields.Company_Division_Name										
														,rawfields.Phone																		
														,rawfields.Email_Address
                            ,rawfields.Person_Street 
														,rawfields.Person_City   
														,rawfields.Person_State  
														,rawfields.Person_Zip    
														,rawfields.Person_Country
														,rawfields.Source_Count														
														,rawfields.Zoom_Company_ID													
														,rawfields.Acquiring_Company_ID										
														,rawfields.Parent_Company_ID												
														,rawfields.Company_Name														
														,rawfields.Company_Domain_Name											
														,rawfields.Company_Phone														
														,rawfields.Industry_Label													
														,rawfields.Industry_Hierarchical_Category					
														,rawfields.Secondary_Industry_Label								
														,rawfields.Secondary_Industry_Hierarchical_Category
														,rawfields.Revenue   
														,rawfields.Employees
														,rawfields.SIC1
														,rawfields.SIC2
														,rawfields.TitleCode 
														,rawfields.Highest_Level_Job_Fuction
														,rawfields.Person_Pro_URL
														,rawfields.Encrypted_Email_Address
														,rawfields.Email_Domain
														,rawfields.Query_Name
														,ace_aid																							
														,local
										);


	//Add the source_rec_id to records
	UT.MAC_Append_Rcid(pDataset_rollup, source_rec_id, ds_source_rcid);

	// --for update that is not full file
	dnotfull_sort 			:= sort	(ds_source_rcid, rawfields.zoomId, local	);
	dnotfull_group			:= group(pDataset_sort	, rawfields.zoomId, local	);
	dnotfull_sort_group	:= sort	(dnotfull_group	, -dt_last_seen						);

	Layouts.Base SetRecordType(Layouts.Base L, Layouts.Base R) := 
	transform
		self.record_type	:= if(l.record_type = '', 'C', r.record_type);
		self							:= r;
	end;

	dSetRecordType := group(iterate(dnotfull_sort_group, SetRecordType(left, right)));

	output_dataset := if(_Flags.IsUpdateFullFile
											,ds_source_rcid
											,dSetRecordType
										);

	return output_dataset;

end;