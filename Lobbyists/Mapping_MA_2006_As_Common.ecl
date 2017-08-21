import lib_stringlib;

InFile 														:= Lobbyists.File_Lobbyists_MA_2006; 

pattern SingleClient 										:= pattern('[^,]+');

MyParsedRecord := record 
	InFile;
	string Lobbyists_Number 								:= '';
	string CompleteName 									:= trim(matchtext(SingleClient),left,right);
end;
	
MyParsedDs 													:= parse(InFile,Clients,SingleClient,MyParsedRecord,scan,first);

MyParsedRecord MyRollup(MyParsedRecord l, MyParsedRecord r) := transform
	self.CompleteName 										:= l.CompleteName + ', ' + r.CompleteName;
	self 													:= l;
end;
 
MyRolledDS 													:= rollup(MyParsedDs, right.CompleteName = 'Inc' or
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
																 right.CompleteName = 'Inc.)' or
																 right.CompleteName = 'Indiana' or                                                                                                             
													       right.CompleteName = 'Indiana Lobby' or                                                                                                                                                                                                                   
													       right.CompleteName = 'Inc. (AIHMES)' or                                                                                                           
													       right.CompleteName = 'Indiana' or
													       right.CompleteName = 'Scherer & Associates' or
													       right.CompleteName = 'LTd.' or  
																 right.CompleteName = 'LLC dba Olinger Distributing Company' or                                                                                    
													       right.CompleteName = 'Jr.' or
																 right.CompleteName = 'Inc. Entity' or 
																 right.CompleteName = 'Entity' or 
																 right.CompleteName = 'M.D.' or
																 right.CompleteName = 'MD' or
																 right.CompleteName = 'RN' or
																 right.CompleteName = 'MS' or
																 right.CompleteName = 'The' or
													       right.CompleteName = 'USA' or
																 right.CompleteName = 'National Assoc. of Industrial and Office Properties' or
																 right.CompleteName = 'AFL-CIO' or
																 right.CompleteName = 'Council 93' or
																 right.CompleteName = 'Esq. P.C.' or
																 right.CompleteName = 'on behalf of its affiliates and itself',
       													       													       
MyRollup(left,right));


Layout_Lobbyists_Common MyTransform(MyRolledDS input) := transform

	self.Key 							:= 'MA' + hash64(input.name,input.CompleteName);
	self.Process_Date 					:= '20060427';
	self.Source_State 					:= 'MA';
	lobbyistiscompany 					:= trim(input.ltype) = 'Entity';
	self.Lobbyist_Name_Full 			:= if (lobbyistiscompany, '', input.name);
	self.Lobbyist_Address_Street_Line	:= if (lobbyistiscompany, '', (trim(input.address_1)+ ' '+trim(input.address_2)));
	self.Lobbyist_Address_City			:= if (lobbyistiscompany, '', input.city);   
	self.Lobbyist_Address_State			:= if (lobbyistiscompany, '', input.state);   
	self.Lobbyist_Address_ZIP			:= if (lobbyistiscompany, '', input.zip);  
	self.Lobbyist_Phone					:= (if (lobbyistiscompany,'',lib_stringlib.stringlib.stringfilter(input.phone, '0123456789')));
	
	DateFinder 							:= '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	self.Lobby_Termination_Date			:= if(regexfind(DateFinder,input.date_terminated),
										intformat((integer)regexfind(DateFinder,input.date_terminated,3),4,1) +
										intformat((integer)regexfind(DateFinder,input.date_terminated,1),2,1) +
										intformat((integer)regexfind(DateFinder,input.date_terminated,2),2,1),
										'');
	self.Firm_Name_Full 				:= if (lobbyistiscompany, input.name, '');
	self.Firm_Address_Street_Line		:= if (lobbyistiscompany, (trim(input.address_1)+ ' '+trim(input.address_2)),'');
	self.Firm_Address_City				:= if (lobbyistiscompany, input.city, '');
	self.Firm_Address_State				:= if (lobbyistiscompany, input.state, '');		
	self.Firm_Address_ZIP				:= if (lobbyistiscompany, input.zip, '');
	self.Firm_Phone						:= (if (lobbyistiscompany,lib_stringlib.stringlib.stringfilter(input.phone, '0123456789'),''));
	
	self.Association_Name_Full 			:= input.CompleteName;
	self 								:= [];
end;

export Mapping_MA_2006_As_Common 		:= project(MyRolledDS,MyTransform(left));
