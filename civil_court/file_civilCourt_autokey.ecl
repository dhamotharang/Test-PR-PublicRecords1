import standard;
// base file for civil court
base_file := civil_court.file_in_civil_court_party;

// A record/layout with all the fields needed to build the autokeys
ak_rec := record
	string60  case_key;
	string20  fname;
	string20  mname;
	string20  lname;
	string70  companyname;
	string25  city;
	string2   state;
	string60  jurisdiction;
	unsigned1 zero   := 0;
	unsigned1 zero2  := 0;
	unsigned6 zeroDID := 0;
	unsigned6 zeroBDID := 0; // important to keep these 2 attrs as type unsigned6 
	                         // if its defined as a lower numeric
	                         // type the resulting number in autokey build
													 // overflows the attr and produces invalid autokeys.
	string1   blank  := '';
	string1   blank_prim_name  := '';
	string1   blank_prim_range := '';
	STRING1   blank_st         := '';
	STRING1   blank_city       := '';
	STRING1   blank_zip5       := '';
	STRING1   blank_sec_range  := '';
end;

ak_rec slim_rec(base_file l) := transform
  // several jurisdictions such as MD, AR have data in different places
	// so this logic is to account for that possiblity and still get adequate usage
	// out of the autokeys.
  boolean is_company_ec1 := if( (trim(l.e1_cname1) <> '' AND trim(l.e1_lname1) = '' 
	                            //AND trim(l.v1_lname1) = '' AND trim(l.v1_lname2) = '' AND trim(l.v2_lname1) = '' AND trim(l.v2_lname2) = ''
	                           ),true,false); 
	boolean is_company_ec2 := if ( (trim(l.e1_cname2) <> '' AND trim(l.e1_lname1) = '' 
	                           // trim(l.v1_lname1) = '' AND trim(l.v1_lname2) = '' AND trim(l.v2_lname1) = '' AND trim(l.v2_lname2) = '')
															),true,false);
  	boolean is_company_vc1 := if ( (trim(l.v1_cname1) <> '' AND trim(l.v1_lname1) = '' AND trim(l.v1_lname2) = '' 
															 //AND trim(l.v2_lname1) = '' AND trim(l.v2_lname2) = '')
	                            AND trim(l.e1_lname1) = ''
															 
															),true,false);
		boolean is_company_vc2 := if ( (trim(l.v1_cname2) <> '' 
		                                                       //AND trim(l.v1_lname1) = '' AND trim(l.v1_lname2) = ''
		                                                       // AND trim(l.v2_lname1) = '' AND trim(l.v2_lname2) = ''
																														AND trim(l.e1_lname1) = ''
	                            
															   ) ,true,false);			
   boolean is_company_vc3 := if ( (trim(l.v2_cname1) <> '' 
	                                                         //AND trim(l.v1_lname1) = '' AND trim(l.v1_lname2) = ''
	                                                        // AND trim(l.v2_lname1) = '' AND trim(l.v2_lname2) = ''
																													 AND trim(l.e1_lname1) = ''
															),true,false);
		boolean is_company_vc4 := if ( (trim(l.v2_cname2) <> ''  
		                                                         //AND trim(l.v1_lname1) = '' AND trim(l.v1_lname2) = '' 
		                                                         //AND trim(l.v2_lname1) = '' AND trim(l.v2_lname2) = ''
																														 AND trim(l.e1_lname1) = ''
															),true,false);															
																														
	boolean is_company := is_company_ec1 OR is_company_ec2 OR is_company_vc1 OR is_company_vc2 OR
	                      is_company_vc3 OR is_company_vc4;

	self.case_key := l.case_key,
	// people fields

  	self.fname        :=   //l.e1_fname1, 
												if (~is_company, 
	                          if (l.e1_fname1 <> '', l.e1_fname1, 
														   if (l.v1_fname1 <> '', l.v1_fname1,																															
														       if (l.e1_fname2 <> '', l.e1_fname2,
														         if (l.e1_fname3 <> '', l.e1_fname3,
															         if (l.e1_fname4 <> '', l.e1_fname4, 
																         if (l.e1_fname5 <> '', l.e1_fname5, 
																	         if (l.e2_fname1 <> '', l.e2_fname1,
																		         if (l.e2_fname2 <> '', l.e2_fname2,
																			         if (l.e2_fname3 <> '', l.e2_fname3,
																				          if (l.e2_fname4 <> '', l.e2_fname4, 
																					           if (l.e2_fname5 <> '', l.e2_fname5, 
																								        if (l.v1_fname2 <> '', l.v1_fname2,
																												  if (l.v1_fname3<> '', l.v1_fname3,
																					   if (l.v1_fname4<> '', l.v1_fname4,
																						  if (l.v1_fname5<> '', l.v1_fname5,
																							  if (l.v2_fname1 <> '', l.v2_fname1,
																								  if (l.v2_fname2 <> '', l.v2_fname2,
																									   if (l.v2_fname3 <> '', l.v2_fname3,
																										  if (l.v2_fname4 <> '', l.v2_fname4,
																											  if (l.v2_fname5 <> '', l.v2_fname5,
																												          '')))))))))))))))))))), ''),
																										
																										
  self.mname        :=  //l.e1_mname1,
													if(~is_company, 
	                         if (l.e1_mname1 <> '', l.e1_mname1,
													   if (l.v1_mname1 <> '', l.v1_mname1,
														     if (l.e1_mname2 <> '' , l.e1_mname2,
														       if (l.e1_mname3 <> '', l.e1_mname3,
															       if (l.e1_mname4 <> '', l.e1_mname4, 
																       if (l.e1_mname5 <> '', l.e1_mname5, 
																	         if (l.e2_mname1 <> '', l.e2_mname1,
																		         if (l.e2_mname2 <> '', l.e2_mname2,
																			         if (l.e2_mname3 <> '', l.e2_mname3,
																				         if (l.e2_mname4 <> '' , l.e2_mname4, 
																					         if (l.e2_mname5 <> '', l.e2_mname5, 
																								      if (l.v1_mname2 <> '', l.v1_mname2,
																											  if (l.v1_mname3<> '', l.v1_mname3,
																					   if (l.v1_mname4<> '', l.v1_mname4,
																						  if (l.v1_mname5<> '', l.v1_mname5,
																							  if (l.v2_mname1 <> '', l.v2_mname1,
																								  if (l.v2_mname2 <> '', l.v2_mname2,
																									   if (l.v2_mname3 <> '', l.v2_mname3,
																										  if (l.v2_mname4 <> '', l.v2_mname4,
																											  if (l.v2_mname5 <> '', l.v2_mname5,
																											  '')))))))))))))))))))), ''),
    self.lname        :=  //l.e1_lname1,
		                      if(~is_company, 
	                         if (l.e1_lname1 <> '', l.e1_lname1,
													  if (l.v1_lname1 <> '', l.v1_lname1,
														 if (l.e1_lname2 <> '' , l.e1_lname2,
														  if (l.e1_lname3 <> '', l.e1_lname3,
															 if (l.e1_lname4 <> '', l.e1_lname4, 
																if (l.e1_lname5 <> '', l.e1_lname5, 
																	  if (l.e2_lname1 <> '', l.e2_lname1,
																		 if (l.e2_lname2 <> '', l.e2_lname2,
																			if (l.e2_lname3 <> '', l.e2_lname3,
																			 if (l.e2_lname4 <> '' , l.e2_lname4, 
																			  if (l.e2_lname5 <> '', l.e2_lname5, 
																				 if (l.v1_lname2 <> '', l.v1_lname2,
																				   if (l.v1_lname3<> '', l.v1_lname3,
																					   if (l.v1_lname4<> '', l.v1_lname4,
																						  if (l.v1_lname5<> '', l.v1_lname5,
																							  if (l.v2_lname1 <> '', l.v2_lname1,
																								  if (l.v2_lname2 <> '', l.v2_lname2,
																									   if (l.v2_lname3 <> '', l.v2_lname3,
																										  if (l.v2_lname4 <> '', l.v2_lname4,
																											  if (l.v2_lname5 <> '', l.v2_lname5,
																												    '')))))))))))))))))))), ''),																				
																						

	// business fields
	self.companyname        := //l.e1_cname1,
															if (is_company_ec1, l.e1_cname1,
	                              if (is_company_vc3, l.v2_cname1,
	                                 if (is_company_ec2, l.e1_cname2,
															       if (is_company_vc1, l.v1_cname1,
																       if (is_company_vc2, l.v1_cname2,
																	        if (is_company_vc4, l.v2_cname2, '')))))),
																  
																	
  self.state               := if (l.st1 <> '', l.st1, if (l.st2 <> '', l.st2, 
	                                                       if (l.state_origin <> '', l.state_origin, ''))),																	
	self.city                := if (l.v_city_name1 <> '', l.v_city_name1,
	                                if (l.p_city_name1 <> '', l.p_city_name1, '')),
	self.jurisdiction := l.court
end;

//
// may have to normalize the basefile before projection is done here
// AR DATA seems to have both v1_lname1 and v2_lname1 both populated but only
// one rec for both of these exists in base file.
// 
// 
//
// 066019945451



//
   Civil_court.layout_roxie_party add_xform(base_file l
	                                             //, integer C
																							 ) := transform
	   // AR is just one state e.g. (may be others)
		 // that doesn't have 2 recs for a single case so need to add the extra rec
		 // to the autokeys so that searches come out correctly.
		 // may be other jurisdictions that are added here as well.
		 boolean blankE1_E2_fields :=  l.e1_lname1 = '' AND l.e1_lname2 = '' AND l.e1_lname3 = '' AND
		                            l.e1_lname4 = '' AND l.e1_lname5 = '' AND l.e2_lname1 = '' AND
																l.e2_lname2 = '' AND l.e2_lname3 = '' AND l.e2_lname4 = '' AND
																l.e2_lname5 = '';
	   boolean state_AR := if ((l.v1_fname1 <> '' AND l.v1_lname1 <> ''  AND blankE1_E2_fields)
																																				    OR
                              (l.v1_lname1 <> '' AND l.v2_cname1 <> '' AND blankE1_E2_fields)
															          OR
															(l.v2_lname1 <> '' AND l.v1_cname1 <> '' AND blankE1_E2_fields)
															      OR
		                         (l.v1_fname2 <> '' AND l.v1_lname2 <> '' AND blankE1_E2_fields)
														                                                OR
														 (l.v1_fname3 <> '' AND l.v1_lname3 <> ''  AND blankE1_E2_fields)
																																				 OR
														 (l.v1_fname4 <> '' AND l.v1_lname4 <> ''   AND blankE1_E2_fields)
																																				OR
														 (l.v1_fname5 <> '' AND l.v1_lname5 <> ''   AND blankE1_E2_fields)
																																				OR
														 (l.v2_fname1 <> '' AND l.v2_lname1 <> ''  AND blankE1_E2_fields)
																																				OR
														 (l.v2_fname2 <> '' AND l.v2_lname2 <> ''  AND blankE1_E2_fields)
																																				OR
														 (l.v2_fname3 <> '' AND l.v2_lname3 <> ''  AND blankE1_E2_fields)
																																				OR
														 (l.v2_fname4 <> '' AND l.v2_lname4 <> ''  AND blankE1_E2_fields)
																																				OR
														 (l.v2_fname5 <> '' AND l.v2_lname5 <> ''  AND blankE1_E2_fields)
																																		, true, false);
		 self.e1_fname1 := if (state_AR,
		                       if (l.v2_fname5 <> '', l.v2_fname5,
													    if (l.v2_fname4 <> '', l.v2_fname4,
															  if (l.v2_fname3 <> '', l.v2_fname3,
																  if (l.v2_fname2 <> '', l.v2_fname2,
																	  if (l.v2_fname1 <> '', l.v2_fname1,
																		  if (l.v1_fname5 <> '', l.v1_fname5, 
																			   if (l.v1_fname4 <> '', l.v1_fname4,
																				   if (l.v1_fname3 <> '', l.v1_fname3,
																					   if (l.v1_fname2 <> '', l.v1_fname2, 
																						   if (l.v1_fname1 <> '', l.v1_fname1, '')))))))))), ''),
     self.e1_lname1 := if (state_AR,
		                       if (l.v2_lname5 <> '', l.v2_lname5,
													    if (l.v2_lname4 <> '', l.v2_lname4,
															  if (l.v2_lname3 <> '', l.v2_lname3,
																  if (l.v2_lname2 <> '', l.v2_lname2,
																	  if (l.v2_lname1 <> '', l.v2_lname1,
																		  if (l.v1_lname5 <> '', l.v1_lname5, 
																			   if (l.v1_lname4 <> '', l.v1_lname4,
																				   if (l.v1_lname3 <> '', l.v1_lname3,
																					   if (l.v1_lname2 <> '', l.v1_lname2,
																						   if (l.v1_lname1 <> '', l.v1_lname1, '')))))))))), ''),
     self.e1_mname1 :=  if (state_AR,
		                       if (l.v2_mname5 <> '', l.v2_mname5,
													    if (l.v2_mname4 <> '', l.v2_mname4,
															  if (l.v2_mname3 <> '', l.v2_mname3,
																  if (l.v2_mname2 <> '', l.v2_mname2,
																	  if (l.v2_mname1 <> '', l.v2_mname1,
																		  if (l.v1_mname5 <> '', l.v1_mname5, 
																			   if (l.v1_mname4 <> '', l.v1_mname4,
																				   if (l.v1_mname3 <> '', l.v1_mname3,
																					   if (l.v1_mname2 <> '', l.v1_mname2, 
																						   if (l.v1_mname1 <> '', l.v1_mname1, '')))))))))), ''),	
     self.e1_cname1 := if (state_AR,
		                       if (l.v2_cname5 <> '', l.v2_cname5,
													    if (l.v2_cname4 <> '', l.v2_cname4,
															  if (l.v2_cname3 <> '', l.v2_cname3,
																   if (l.v2_cname2 <> '', l.v2_cname2,
																	   if (l.v2_cname1 <> '', l.v2_cname1,
															if (l.v1_cname5 <> '', l.v1_cname5,
															   if (l.v1_cname4 <> '', l.v1_cname4,
																   if (l.v1_cname3 <> '', l.v1_cname3,
																	   if (l.v1_cname2 <> '', l.v1_cname2, 
																		  if (l.v1_cname1 <> '', l.v1_cname1, '')))))))))), ''),
																		      
     self  := l
	end;
	
	
		 
   tmp_base_file_added := project(base_file, add_xform(left));
	 // filter out the recs that are empty (i.e. non AR type recs)
	 base_file_added := tmp_base_file_added(~(e1_fname1 = '' AND e1_mname1 = '' AND e1_lname1 = '' AND e1_cname1 = ''));
	 
// output(count(tmp_base_file_added) ,named('count_tmp_base_file_added'));
// output(count(base_file_added), named('count_base_file_added'));
// output(count(base_file), named('count_base_file'));
export File_civilCourt_autokey :=   project(base_file+ base_file_added,slim_rec(left));
