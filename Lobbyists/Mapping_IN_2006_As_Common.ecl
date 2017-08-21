MyInitialDS := File_Lobbyists_IN_2006; 

pattern SingleClient := pattern('[^;]+');

MyParsedRecord := record 
	MyInitialDS;
	string CompleteName := trim(matchtext(SingleClient),left,right);
end;
	
MyParsedDS := parse(MyInitialDS,Clients,SingleClient,MyParsedRecord,scan,first);
	
MyParsedRecord MyRollup(MyParsedRecord l, MyParsedRecord r) := transform
	self.CompleteName := l.CompleteName + ', ' + r.CompleteName;
	self := l;
end;
 
MyRolledDS := rollup(MyParsedDS, right.CompleteName = 'Inc' or
															right.CompleteName = 'Inc & Clients' or
															right.CompleteName = 'Incorporated' or
															right.CompleteName = 'Inc.' or
															right.CompleteName = 'INC' or
                                 right.CompleteName = 'LLP' or
															right.CompleteName = 'LLC' or
															right.CompleteName = 'LTD' or
															right.CompleteName = 'Ltd.' or
															right.CompleteName = 'Ltd' or
															right.CompleteName = 'LP' or
															right.CompleteName = 'L.P.' or
															right.CompleteName = 'PC' or
															right.CompleteName = 'PSC' or
															right.CompleteName = 'PCC' or
															right.CompleteName = 'P.C.' or
															right.CompleteName = 'P.S.C.' or
															right.CompleteName = 'Corp' or
															right.CompleteName = 'Render' or
															right.CompleteName = 'Killian' or
															right.CompleteName = 'Heath & Lyman' or
															right.CompleteName = 'Jr' or
															right.CompleteName = 'Humana' or
															right.CompleteName = 'Hoosier Chapter' or
															right.CompleteName = 'Indiana Chapter' or
															right.CompleteName = 'Great Lakes Division' or
															right.CompleteName = 'Attorneys at Law' or
															right.CompleteName = 'Attorneys At Law' or
															right.CompleteName = 'See Clients of ISMA' or
															right.CompleteName = 'Lochmueller and Associates' or
															right.CompleteName = 'LLC d/b/a Olinger Distributing Company' or               
															right.CompleteName = 'Inc. d/b/a Theatre Owners of Indiana' or 
																 right.CompleteName = 'Inc.)' or
																 right.CompleteName = 'Indiana' or                                                                                                             
															right.CompleteName = 'Indiana Lobby' or                                                                                                                                                                                                                   
																 right.CompleteName = 'Inc. d/b/a C-1 Professional' or                                                                                             
																 right.CompleteName = 'Inc. (formerly Salomon Smith Barney' or                                                                                     
																 right.CompleteName = 'LLC d/b/a Indiana Downs' or                                                                                                 
															right.CompleteName = 'Longest & Neff, LLC' or                                                                                                     
															right.CompleteName = 'Inc. (dba Anthem Blue Cross and Blue Shield)' or                                                                            
															right.CompleteName = 'Inc. d/b/a Noble of Indiana' or                                                                                              
															right.CompleteName = 'Inc. d/b/a Sprint' or                                                                                                       
															right.CompleteName = 'Polk & Associations, LLC' or                                                                                                
															right.CompleteName = 'Scherer & Associates, LLC' or                                                                                               
															right.CompleteName = 'Inc. (AIHMES)' or                                                                                                           
															right.CompleteName = 'Inc. See clients of Indiana Statewide' or                                                                                   
															right.CompleteName = 'Inc d/b/a SBC Indiana' or                                                                                                   
															right.CompleteName = 'Indiana' or
															right.CompleteName = 'Inc. obo Harley-Davidson Motor Company' or                                                                                  
															right.CompleteName = 'Scherer & Associates' or
															right.CompleteName = 'LTd.' or                                                                                                                    
															right.CompleteName = 'LLC dba Olinger Distributing Company' or                                                                                    
															right.CompleteName = 'Jr.' or
															right.CompleteName = 'USA' or
															right.CompleteName = 'Inc. dba C-1 Professional' or                                                                                               
															right.CompleteName = 'Ohio County' or
															right.CompleteName = 'Douglas W.' or
															right.CompleteName = '342 Massachusetts Ave.' or
															right.CompleteName = 'Suite 300' or
															right.CompleteName = 'Indianapolis' or
															right.CompleteName = 'IN 46204' or
															right.CompleteName = '317-261-0900' or  
															right.CompleteName = 'Spolyar' or                                                                                                                 
															right.CompleteName = '(a subsidiary of WellPoint Health Networks, Inc.)' or                                                                       
															right.CompleteName = 'Inc. on behalf of American Massage Therapy Association' or                                                                  
															right.CompleteName = 'Inc. on behalf of North American Insulation Manufacturers Association' or                                                   
															right.CompleteName = 'Inc. on behalf of Community Financial Services Assn.' or                                                                    
															right.CompleteName = 'Inc. on behalf of CTB McGraw-Hill' or                                                                                       
															right.CompleteName = 'Inc. on behalf of Aventis Pasteur a/k/a sanofi pasteur' or                                                                  
															right.CompleteName = 'LLC d/b/a Indiana Downs',
																 
																 
					       													       													       
MyRollup(left,right));

import lib_stringlib;

Layout_Lobbyists_Common MyTransform(MyRolledDS input) := transform

	self.Key := 'IN' + hash64(input.name,input.CompleteName);
	self.Process_Date := '20060410';
	self.Source_State := 'IN';
	lobbyistiscompany := func_is_company (input.name);
	self.Lobbyist_Name_Full := if (lobbyistiscompany, '', input.name);
	self.Firm_Name_Full := if (lobbyistiscompany, input.name, '');
	self.Lobbyist_Address_Street_Line := if (lobbyistiscompany, '', input.address);
	self.Lobbyist_Address_CSZ_Line := if (lobbyistiscompany, '', input.city_state_zip);
	self.Lobbyist_Phone := (if (lobbyistiscompany,'',lib_stringlib.stringlib.stringfilter(input.telephone, '0123456789')));
	self.Firm_Address_Street_Line := if (lobbyistiscompany, input.address, ''); 
	self.Firm_Address_CSZ_Line := if (lobbyistiscompany, input.city_state_zip, '');
	self.Firm_Phone := (if (lobbyistiscompany,lib_stringlib.stringlib.stringfilter(input.telephone, '0123456789'),''));
	self.Association_Name_Full := input.CompleteName;
	self := [];
end;

export Mapping_IN_2006_As_Common := project(MyRolledDS,MyTransform(left));