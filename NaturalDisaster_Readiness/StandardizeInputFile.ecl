import Address, Ut, lib_stringlib, _Control, business_header,_Validate, idl_header;

export StandardizeInputFile := module
	
	export SetOfValidTypes := ['A','B','C'];	
	
	export fPreProcess(dataset(NaturalDisaster_Readiness.Layouts.Input) pRawFileInput, string pversion) := function    
	
	Validate_State(string StateIn) := function
		State := If (length(StateIn) = 2
								,StateIn
								,If (length(StringLib.StringFilter(StateIn,'0123456789')) = 0
									,''
									,Address_Parser.GetState(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(StateIn)),true)
									)
								);

		return State;
	end; //end Validate_State
	
	Validate_Zip(string StateIn, string ZipIn) := function
		//Validate that the ZipIn parm (if data exists) is not all zeroes
		Zip_Filtered := If (StringLib.StringFilterOut(ZipIn,'0')='','',ZipIn);
		//Validate that the StateIn parm (if data exists) is not all zeroes
		State_Filtered := If (StringLib.StringFilterOut(StateIn,'0')='','',StateIn);
		//Validate that the zip is all numeric and a length of 5
		Zip := If (length(StringLib.StringFilter(Zip_Filtered,'0123456789')) = 5
							,Zip_Filtered
							,If (length(StringLib.StringFilter(Zip_Filtered,'0123456789')) = 4
							,'0'+Zip_Filtered
									,If (length(StringLib.StringFilter(State_Filtered,'0123456789')) = 5 AND Zip_Filtered = ''
											,State_Filtered
											,Zip_Filtered
											)
									)
							);

		return Zip;
	end; //end Validate_Zip
	
	Validate_Phone_Length(integer2 Phone_Length, string PhoneIn) := function
	/*If the phone is a length of 11, check to see if the first digit
		is a "1".  If so, bypass it and extract the remaining digits.  Otherwise
		the phone must be 10 digits else a blank phone number is returned.*/
			PhoneNo := If (Phone_Length = 11 AND PhoneIn[1] = '1'
										,PhoneIn[2..]
										,If (Phone_Length = 10
												,PhoneIn
												,If (Phone_Length > 10
														,PhoneIn[Phone_Length-10+1..]  //eliminate the out of country code
														,''
														)	
												)
										);
			return PhoneNo;
	end; //end Validate_Phone_Length

	Validate_Phone(string Input_Phone) := function
		Phone_No_Count  := StringLib.StringFindCount(Input_Phone,'/');
		EXT_LOC	       	:= StringLib.StringFind(Input_Phone,'EXT',1);
		Phone_Minus_Ext := IF (EXT_LOC > 0,Input_Phone[1..EXT_LOC-1],Input_Phone);
		Phone_Numeric   := StringLib.StringFilter(Phone_Minus_Ext,'/0123456789');

		Loc_Slash_1 := IF (Phone_No_Count > 0, StringLib.StringFind(Phone_Numeric,'/',1),0);
		Loc_Slash_2 := IF (Phone_No_Count > 0, StringLib.StringFind(Phone_Numeric,'/',2),0);
		Loc_Slash_3 := IF (Phone_No_Count > 0, StringLib.StringFind(Phone_Numeric,'/',3),0);
		Loc_Slash_4 := IF (Phone_No_Count > 0, StringLib.StringFind(Phone_Numeric,'/',4),0);

		Phone_5 	:= If(Loc_Slash_4 > 0,Phone_Numeric[Loc_Slash_4+1..],'');
		Phone_4 	:= If(Loc_Slash_4 > 0,Phone_Numeric[Loc_Slash_3+1..Loc_Slash_4-1],
										If(Loc_Slash_3 > 0,Phone_Numeric[Loc_Slash_2+1..Loc_Slash_3-1]
										,''));
		Phone_3 	:= If(Loc_Slash_4 > 0 OR Loc_Slash_3 > 0,Phone_Numeric[Loc_Slash_3+1..Loc_Slash_4-1],
										If(Loc_Slash_2 > 0,Phone_Numeric[Loc_Slash_2+1..]
										,''));
		Phone_2 	:= If(Loc_Slash_4 > 0 OR Loc_Slash_3 > 0 OR Loc_Slash_2 > 0,Phone_Numeric[Loc_Slash_1+1..Loc_Slash_2-1],
										If(Loc_Slash_1 > 0,Phone_Numeric[Loc_Slash_1+1..]
										,''));
		Phone_1 	:= If(Loc_Slash_4 > 0 OR Loc_Slash_3 > 0 OR Loc_Slash_2 > 0 OR Loc_Slash_1 > 0
										,trim(Phone_Numeric[1..Loc_Slash_1-1])
										,trim(Phone_Numeric)
										);
		
		Business_Phone1 := Validate_Phone_Length(Length(Phone_1),trim(Phone_1,left,right));
		Business_Phone2 := Validate_Phone_Length(Length(Phone_2),trim(Phone_2,left,right));
		Business_Phone3 := Validate_Phone_Length(Length(Phone_3),trim(Phone_3,left,right));
		Business_Phone4 := Validate_Phone_Length(Length(Phone_4),trim(Phone_4,left,right));
		Business_Phone5 := Validate_Phone_Length(Length(Phone_5),trim(Phone_5,left,right));
		
		return_phone := MAP(Business_Phone5 != '' => trim(Business_Phone1)+','+trim(Business_Phone2)+','+trim(Business_Phone3)+','+trim(Business_Phone4)+','+trim(Business_Phone5),
												Business_Phone4 != '' => trim(Business_Phone1)+','+trim(Business_Phone2)+','+trim(Business_Phone3)+','+trim(Business_Phone4)+','+trim(Business_Phone5),
												Business_Phone3 != '' => trim(Business_Phone1)+','+trim(Business_Phone2)+','+trim(Business_Phone3)+','+trim(Business_Phone4)+','+trim(Business_Phone5),
												Business_Phone2 != '' => trim(Business_Phone1)+','+trim(Business_Phone2)+','+trim(Business_Phone3)+','+trim(Business_Phone4)+','+trim(Business_Phone5),
												Business_Phone1 != '' => trim(Business_Phone1),
												'');

		return return_phone;
	
	end; //end Validate_Phone												
																		
	Derive_MailAddress1(string Addr1,string Addr2,string City,string State,string Zip)	:=	function
			MailAddress1	:= If (City !='' OR State !='' OR Zip !=''
													 ,StringLib.StringCleanSpaces(trim(Addr1)+' '+trim(Addr2)
													 )
													 ,If (Datalib.StringFind(Addr2[1..2],'US',1) > 0 AND length(Addr2[4..])>0
															 ,StringLib.StringCleanSpaces(trim(Addr1))
															 ,''
															 )
													);
			return MailAddress1;
	end; //end Derive_MailAddress1
	
	Derive_MailAddressLast(string Addr1,string Addr2,string City,string State,string Zip)	:=	function
			MailAddressLast	:= If ((State !='' OR Zip !='') AND City !='',
														 StringLib.StringCleanSpaces(trim(City)+', '+trim(State)+' '+trim(Zip[1..5])
														 ),
														 If (Datalib.StringFind(Addr2[1..2],'US',1) > 0,
														  	 NaturalDisaster_Readiness.Address_Parser.FindAddr(Addr2[4..]), 
																 ''
												  			)
														 );
			return MailAddressLast;
		end; //end Derive_MailAddressLast

		NaturalDisaster_Readiness.Layouts.Temp trfFileToTemp(NaturalDisaster_Readiness.Layouts.Input l)	:=	transform	
				self.Website					  					:= StringLib.StringToUpperCase(l.Website);
				self.State												:= StringLib.StringToUpperCase(l.State);
			  self.Business_Name								:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Name));
				self.Business_Acronym							:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Acronym));
				self.Business_Address1						:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Address1));
				self.Business_Address2						:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Address2));
				self.Clean_Business_Address2			:= If (l.Business_Address2[3]='-'
																								,StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Address2[4..]))
																								,StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Address2))
																								);
				self.Business_City								:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_City));
				self.Clean_Business_City					:= If (l.Business_City[3]='-'
																								,StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_City[4..]))
																								,StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_City))
																								);
				self.Business_State								:= Validate_State(l.Business_State);
				self.Business_Zip_Code						:= Validate_Zip(l.Business_State, l.Business_Zip_Code);
				self.Business_Country							:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Country));
				self.Business_Phone_No						:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Phone_No));
				self.Business_Clean_Phone_No			:= If (l.Business_Country = 'USA'
																								,trim(Validate_Phone(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Phone_No))))
																								,'');																					
				self.Business_Fax_No							:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Fax_No));
				self.Business_Clean_Fax_No				:= If (l.Business_Country = 'USA'
																								,trim(Validate_Phone(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Fax_No))))
																								,'');	
				self.Business_Telex_No						:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Business_Telex_No));
				self.Business_Email_Id						:= StringLib.StringToUpperCase(l.Business_Email_Id);
				self.Business_Website							:= StringLib.StringToUpperCase(l.Business_Website);		
				self.ISO_Committee_Reference1			:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Reference1));		
				self.ISO_Committee_Title1					:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Title1));		
				self.ISO_Committee_Type1					:= If(StringLib.StringToUpperCase(l.ISO_Committee_Type1) IN SetOfValidTypes,l.ISO_Committee_Type1,'');
				self.ISO_Committee_Reference2			:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Reference2));
				self.ISO_Committee_Title2					:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Title2));		
				self.ISO_Committee_Type2					:= If(StringLib.StringToUpperCase(l.ISO_Committee_Type2) IN SetOfValidTypes,l.ISO_Committee_Type2,'');
				self.ISO_Committee_Reference3			:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Reference3));		
				self.ISO_Committee_Title3					:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Title3));		
				self.ISO_Committee_Type3					:= If(StringLib.StringToUpperCase(l.ISO_Committee_Type3) IN SetOfValidTypes,l.ISO_Committee_Type3,'');
				self.ISO_Committee_Reference4			:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Reference4));
				self.ISO_Committee_Title4					:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Title4));		
				self.ISO_Committee_Type4					:= If(StringLib.StringToUpperCase(l.ISO_Committee_Type4) IN SetOfValidTypes,l.ISO_Committee_Type4,'');
				self.ISO_Committee_Reference5			:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Reference5));		
				self.ISO_Committee_Title5					:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Title5));		
				self.ISO_Committee_Type5					:= If(StringLib.StringToUpperCase(l.ISO_Committee_Type5) IN SetOfValidTypes,l.ISO_Committee_Type5,'');		
				self.ISO_Committee_Reference6			:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Reference6));
				self.ISO_Committee_Title6					:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Title6));		
				self.ISO_Committee_Type6					:= If(StringLib.StringToUpperCase(l.ISO_Committee_Type6) IN SetOfValidTypes,l.ISO_Committee_Type6,'');
				self.ISO_Committee_Reference7			:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Reference7));		
				self.ISO_Committee_Title7					:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Title7));		
				self.ISO_Committee_Type7					:= If(StringLib.StringToUpperCase(l.ISO_Committee_Type7) IN SetOfValidTypes,l.ISO_Committee_Type7,'');	
				self.ISO_Committee_Reference8			:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Reference8));
				self.ISO_Committee_Title8					:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Title8));		
				self.ISO_Committee_Type8					:= If(StringLib.StringToUpperCase(l.ISO_Committee_Type8) IN SetOfValidTypes,l.ISO_Committee_Type8,'');	
				self.ISO_Committee_Reference9			:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Reference9));		
				self.ISO_Committee_Title9					:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Title9));		
				self.ISO_Committee_Type9					:= If(StringLib.StringToUpperCase(l.ISO_Committee_Type9) IN SetOfValidTypes,l.ISO_Committee_Type9,'');
				self.ISO_Committee_Reference10		:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Reference10));
				self.ISO_Committee_Title10				:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.ISO_Committee_Title10));		
				self.ISO_Committee_Type10					:= If(StringLib.StringToUpperCase(l.ISO_Committee_Type10) IN SetOfValidTypes,l.ISO_Committee_Type10,'');
				self.Append_MailAddress1					:= If(l.Business_Country = 'USA'
																								,Derive_MailAddress1(StringLib.StringToUpperCase(l.Business_Address1)
																																		,StringLib.StringToUpperCase(l.Business_Address2)
																																		,StringLib.StringToUpperCase(l.Business_City)
																																		,StringLib.StringToUpperCase(l.Business_State)
																																		,l.Business_Zip_Code)
																								,''
																								);
				self.Append_MailAddressLast				:= If(l.Business_Country = 'USA'
																								,Derive_MailAddressLast(l.Business_Address1
																																				,StringLib.StringToUpperCase(l.Business_Address2)
																																				,StringLib.StringToUpperCase(l.Business_City)
																																				,StringLib.StringToUpperCase(l.Business_State)
																																				,l.Business_Zip_Code)
																								,''
																								);
				self															:= l;
				self															:= [];
		end; //end trfFileToTemp transform

		dPreProcess		:=	project(pRawFileInput, trfFileToTemp(left));
	
		return dPreProcess;
	end; //end fPreProcess function

	export fStandardizeProcess(dataset(NaturalDisaster_Readiness.Layouts.Temp) pPreProcessInput, string pversion) := function

		NaturalDisaster_Readiness.Layouts.Base trfFileToBase(NaturalDisaster_Readiness.Layouts.Temp l)	:=	transform	
				self.ISO_Committee_Reference := MAP(l.ISO_Committee_Reference10 != '' => trim(l.ISO_Committee_Reference1)+';'+
																													 trim(l.ISO_Committee_Reference2)+';'+
																													 trim(l.ISO_Committee_Reference3)+';'+
																													 trim(l.ISO_Committee_Reference4)+';'+
																													 trim(l.ISO_Committee_Reference5)+';'+
																													 trim(l.ISO_Committee_Reference6)+';'+
																													 trim(l.ISO_Committee_Reference7)+';'+
																													 trim(l.ISO_Committee_Reference8)+';'+
																													 trim(l.ISO_Committee_Reference9)+';'+
																													 trim(l.ISO_Committee_Reference10),
																						l.ISO_Committee_Reference9 	!= '' => trim(l.ISO_Committee_Reference1)+';'+
																													 trim(l.ISO_Committee_Reference2)+';'+
																													 trim(l.ISO_Committee_Reference3)+';'+
																													 trim(l.ISO_Committee_Reference4)+';'+
																													 trim(l.ISO_Committee_Reference5)+';'+
																													 trim(l.ISO_Committee_Reference6)+';'+
																													 trim(l.ISO_Committee_Reference7)+';'+
																													 trim(l.ISO_Committee_Reference8)+';'+
																													 trim(l.ISO_Committee_Reference9),
																						l.ISO_Committee_Reference8 	!= '' => trim(l.ISO_Committee_Reference1)+';'+
																													 trim(l.ISO_Committee_Reference2)+';'+
																													 trim(l.ISO_Committee_Reference3)+';'+
																													 trim(l.ISO_Committee_Reference4)+';'+
																													 trim(l.ISO_Committee_Reference5)+';'+
																													 trim(l.ISO_Committee_Reference6)+';'+
																													 trim(l.ISO_Committee_Reference7)+';'+
																													 trim(l.ISO_Committee_Reference8),
																						l.ISO_Committee_Reference7 	!= '' => trim(l.ISO_Committee_Reference1)+';'+
																													 trim(l.ISO_Committee_Reference2)+';'+
																													 trim(l.ISO_Committee_Reference3)+';'+
																													 trim(l.ISO_Committee_Reference4)+';'+
																													 trim(l.ISO_Committee_Reference5)+';'+
																													 trim(l.ISO_Committee_Reference6)+';'+
																													 trim(l.ISO_Committee_Reference7),
																						l.ISO_Committee_Reference6 	!= '' => trim(l.ISO_Committee_Reference1)+';'+
																													 trim(l.ISO_Committee_Reference2)+';'+
																													 trim(l.ISO_Committee_Reference3)+';'+
																													 trim(l.ISO_Committee_Reference4)+';'+
																													 trim(l.ISO_Committee_Reference5)+';'+
																													 trim(l.ISO_Committee_Reference6),
																						l.ISO_Committee_Reference5 	!= '' => trim(l.ISO_Committee_Reference1)+';'+
																													 trim(l.ISO_Committee_Reference2)+';'+
																													 trim(l.ISO_Committee_Reference3)+';'+
																													 trim(l.ISO_Committee_Reference4)+';'+
																													 trim(l.ISO_Committee_Reference5),
																						l.ISO_Committee_Reference4 	!= '' => trim(l.ISO_Committee_Reference1)+';'+
																													 trim(l.ISO_Committee_Reference2)+';'+
																													 trim(l.ISO_Committee_Reference3)+';'+
																													 trim(l.ISO_Committee_Reference4),
																						l.ISO_Committee_Reference3 	!= '' => trim(l.ISO_Committee_Reference1)+';'+
																													 trim(l.ISO_Committee_Reference2)+';'+
																													 trim(l.ISO_Committee_Reference3),
																						l.ISO_Committee_Reference2 	!= '' => trim(l.ISO_Committee_Reference1)+';'+
																													 trim(l.ISO_Committee_Reference2),
																						l.ISO_Committee_Reference1 	!= '' => trim(l.ISO_Committee_Reference1),
																						'');
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
				self.ISO_Committee_Title := MAP(l.ISO_Committee_Title10 != '' => trim(l.ISO_Committee_Title1)+';'+
																													 trim(l.ISO_Committee_Title2)+';'+
																													 trim(l.ISO_Committee_Title3)+';'+
																													 trim(l.ISO_Committee_Title4)+';'+
																													 trim(l.ISO_Committee_Title5)+';'+
																													 trim(l.ISO_Committee_Title6)+';'+
																													 trim(l.ISO_Committee_Title7)+';'+
																													 trim(l.ISO_Committee_Title8)+';'+
																													 trim(l.ISO_Committee_Title9)+';'+
																													 trim(l.ISO_Committee_Title10),
																				l.ISO_Committee_Title9 	!= '' => trim(l.ISO_Committee_Title1)+';'+
																													 trim(l.ISO_Committee_Title2)+';'+
																													 trim(l.ISO_Committee_Title3)+';'+
																													 trim(l.ISO_Committee_Title4)+';'+
																													 trim(l.ISO_Committee_Title5)+';'+
																													 trim(l.ISO_Committee_Title6)+';'+
																													 trim(l.ISO_Committee_Title7)+';'+
																													 trim(l.ISO_Committee_Title8)+';'+
																													 trim(l.ISO_Committee_Title9),
																				l.ISO_Committee_Title8 	!= '' => trim(l.ISO_Committee_Title1)+';'+
																													 trim(l.ISO_Committee_Title2)+';'+
																													 trim(l.ISO_Committee_Title3)+';'+
																													 trim(l.ISO_Committee_Title4)+';'+
																													 trim(l.ISO_Committee_Title5)+';'+
																													 trim(l.ISO_Committee_Title6)+';'+
																													 trim(l.ISO_Committee_Title7)+';'+
																													 trim(l.ISO_Committee_Title8),
																				l.ISO_Committee_Title7 	!= '' => trim(l.ISO_Committee_Title1)+';'+
																													 trim(l.ISO_Committee_Title2)+';'+
																													 trim(l.ISO_Committee_Title3)+';'+
																													 trim(l.ISO_Committee_Title4)+';'+
																													 trim(l.ISO_Committee_Title5)+';'+
																													 trim(l.ISO_Committee_Title6)+';'+
																													 trim(l.ISO_Committee_Title7),
																				l.ISO_Committee_Title6 	!= '' => trim(l.ISO_Committee_Title1)+';'+
																													 trim(l.ISO_Committee_Title2)+';'+
																													 trim(l.ISO_Committee_Title3)+';'+
																													 trim(l.ISO_Committee_Title4)+';'+
																													 trim(l.ISO_Committee_Title5)+';'+
																													 trim(l.ISO_Committee_Title6),
																				l.ISO_Committee_Title5 	!= '' => trim(l.ISO_Committee_Title1)+';'+
																													 trim(l.ISO_Committee_Title2)+';'+
																													 trim(l.ISO_Committee_Title3)+';'+
																													 trim(l.ISO_Committee_Title4)+';'+
																													 trim(l.ISO_Committee_Title5),
																				l.ISO_Committee_Title4 	!= '' => trim(l.ISO_Committee_Title1)+';'+
																													 trim(l.ISO_Committee_Title2)+';'+
																													 trim(l.ISO_Committee_Title3)+';'+
																													 trim(l.ISO_Committee_Title4),
																				l.ISO_Committee_Title3 	!= '' => trim(l.ISO_Committee_Title1)+';'+
																													 trim(l.ISO_Committee_Title2)+';'+
																													 trim(l.ISO_Committee_Title3),
																				l.ISO_Committee_Title2 	!= '' => trim(l.ISO_Committee_Title1)+';'+
																													 trim(l.ISO_Committee_Title2),
																				l.ISO_Committee_Title1 	!= '' => trim(l.ISO_Committee_Title1),
																				'');
												
				self.ISO_Committee_Type := MAP(l.ISO_Committee_Type10 != '' => trim(l.ISO_Committee_Type1)+';'+
																													 trim(l.ISO_Committee_Type2)+';'+
																													 trim(l.ISO_Committee_Type3)+';'+
																													 trim(l.ISO_Committee_Type4)+';'+
																													 trim(l.ISO_Committee_Type5)+';'+
																													 trim(l.ISO_Committee_Type6)+';'+
																													 trim(l.ISO_Committee_Type7)+';'+
																													 trim(l.ISO_Committee_Type8)+';'+
																													 trim(l.ISO_Committee_Type9)+';'+
																													 trim(l.ISO_Committee_Type10),
																				l.ISO_Committee_Type9 	!= '' => trim(l.ISO_Committee_Type1)+';'+
																													 trim(l.ISO_Committee_Type2)+';'+
																													 trim(l.ISO_Committee_Type3)+';'+
																													 trim(l.ISO_Committee_Type4)+';'+
																													 trim(l.ISO_Committee_Type5)+';'+
																													 trim(l.ISO_Committee_Type6)+';'+
																													 trim(l.ISO_Committee_Type7)+';'+
																													 trim(l.ISO_Committee_Type8)+';'+
																													 trim(l.ISO_Committee_Type9),
																				l.ISO_Committee_Type8 	!= '' => trim(l.ISO_Committee_Type1)+';'+
																													 trim(l.ISO_Committee_Type2)+';'+
																													 trim(l.ISO_Committee_Type3)+';'+
																													 trim(l.ISO_Committee_Type4)+';'+
																													 trim(l.ISO_Committee_Type5)+';'+
																													 trim(l.ISO_Committee_Type6)+';'+
																													 trim(l.ISO_Committee_Type7)+';'+
																													 trim(l.ISO_Committee_Type8),
																				l.ISO_Committee_Type7 	!= '' => trim(l.ISO_Committee_Type1)+';'+
																													 trim(l.ISO_Committee_Type2)+';'+
																													 trim(l.ISO_Committee_Type3)+';'+
																													 trim(l.ISO_Committee_Type4)+';'+
																													 trim(l.ISO_Committee_Type5)+';'+
																													 trim(l.ISO_Committee_Type6)+';'+
																													 trim(l.ISO_Committee_Type7),
																				l.ISO_Committee_Type6 	!= '' => trim(l.ISO_Committee_Type1)+';'+
																													 trim(l.ISO_Committee_Type2)+';'+
																													 trim(l.ISO_Committee_Type3)+';'+
																													 trim(l.ISO_Committee_Type4)+';'+
																													 trim(l.ISO_Committee_Type5)+';'+
																													 trim(l.ISO_Committee_Type6),
																				l.ISO_Committee_Type5 	!= '' => trim(l.ISO_Committee_Type1)+';'+
																													 trim(l.ISO_Committee_Type2)+';'+
																													 trim(l.ISO_Committee_Type3)+';'+
																													 trim(l.ISO_Committee_Type4)+';'+
																													 trim(l.ISO_Committee_Type5),
																				l.ISO_Committee_Type4 	!= '' => trim(l.ISO_Committee_Type1)+';'+
																													 trim(l.ISO_Committee_Type2)+';'+
																													 trim(l.ISO_Committee_Type3)+';'+
																													 trim(l.ISO_Committee_Type4),
																				l.ISO_Committee_Type3 	!= '' => trim(l.ISO_Committee_Type1)+';'+
																													 trim(l.ISO_Committee_Type2)+';'+
																													 trim(l.ISO_Committee_Type3),
																				l.ISO_Committee_Type2 	!= '' => trim(l.ISO_Committee_Type1)+';'+
																													 trim(l.ISO_Committee_Type2),
																				l.ISO_Committee_Type1 	!= '' => trim(l.ISO_Committee_Type1),
																				'');		
				self.Append_MailRawAID						:=	0;
				self.Append_MailAceAID						:=	0;	
				self.Date_FirstSeen               :=  (integer) pversion;
				self.Date_LastSeen                :=  (integer) pversion;			
				self															:= 	l;
  	end; //end trfFileToBase transform

		dBaseRecSet		:=	project(pPreProcessInput, trfFileToBase(left));
	
		return dBaseRecSet;
 
	end; //end fStandardizeProcess function

	NaturalDisaster_Readiness.Layouts.Base Normalize_Business_Phone(NaturalDisaster_Readiness.Layouts.Base l, integer c)	:=	transform
		self.Business_Clean_Phone_No := StringLib.StringExtract(l.Business_Clean_Phone_No, c);
		self 									 := l;
	end; //end Normalize_Business_Phone transform
	
	export fAll( dataset(NaturalDisaster_Readiness.Layouts.Input)  pRawFileInput, string pversion) := function
   
		dPreprocess	 			 := fPreProcess (pRawFileInput,pversion);

		dStandardBaseInfo  := fStandardizeProcess (dPreprocess, pversion);
		//Filter out those records that do not need to be normalized
		dNotNormBase 			 := dStandardBaseInfo((business_country='USA' AND StringLib.StringFindCount(Business_Phone_No,'/')=0) OR (business_country!='USA'));  
		//Filter out those records that do need to be normalized; only USA records that have multiple business phone numbers
		dNormProcess 			 := dStandardBaseInfo(business_country='USA' AND StringLib.StringFindCount(Business_Phone_No,'/')>0);
		//Normalize those records that have multiple business phone numbers
		dNormBase 	 			 := Normalize(dNormProcess,StringLib.StringFindCount(left.Business_Phone_No,'/')+1,Normalize_Business_Phone(left,counter));
		
		//Concatenate those records that were normalized with those records that were not normalized
		#if(_flags.UseStandardizePersists)
			dAppendBusinessInfo  := dNormBase + dNotNormBase : persist(Persistnames.standardizeInput);
		#else
			dAppendBusinessInfo  := dNormBase + dNotNormBase;
		#end
		
		return dAppendBusinessInfo;
	
	end; //end fAll function

end; //end StandardizeInputFile