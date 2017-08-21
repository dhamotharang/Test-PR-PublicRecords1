import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export StandardizeInputFile := module

	export fPreProcess(dataset(LaborActions_EBSA.Layouts.Input) pRawFileInput, string pversion) := function    

		reformatZipCode(string zipcode1='0', string zipcode2='0')	:=	function
    //Blank out if they are not 5 and 4 respectively. 
    //And if Zip4 is ok, but Zip5 is not, then blank out both. 
		  Zip5 := (string)(integer)StringLib.StringFilter(zipcode1,'0123456789');
		  Zip4 := (string)(integer)StringLib.StringFilter(zipcode2,'0123456789');
			FinalZip5 := if (length(Zip5) = 5 or length(Zip5) = 9,Zip5[1..5],'');
			FinalZip4 := if (length(Zip4) = 4 and FinalZip5 != ''
											,Zip4
											,if (length(zip5) = 9
													,Zip5[6..9]
													,''
													)
											);										
			return FinalZip5 + ',' + FinalZip4;
		end;	//end reformatZipCode function

		string8 fixdate(string indate) := function
		// function to fix the invalid date values and returns the date value in ccyymmdd format.
				outdate := _Validate.date.fCorrectedDateString(trim(indate,left,right));
				return(if (trim(outdate,left,right) <> '', outdate, ''));
		end;		

		reformatPenaltyAmount(string penalty_amt)	:=	function
		//This function maps the penalty amount with the correct punctuation.
				Replace_With_Hyphen		:= trim(StringLib.StringFindReplace(penalty_amt, 'TO','-'));
				PenaltyAmountFiltered := StringLib.StringFilter(Replace_With_Hyphen,'-0123456789');
				return_penalty_amount := MAP(PenaltyAmountFiltered = '0-10000' 			=> '$0-$10,000',
																		 PenaltyAmountFiltered = '10001-50000' 	=> '$10,001-$50,000',
																		 PenaltyAmountFiltered = '50001-100000' => '$50,001-$100,000',
																		 PenaltyAmountFiltered = '100000'				=> 'OVER $100,000',
																		 PenaltyAmountFiltered);
			return (string) return_penalty_amount;
		end;	//end reformatPenaltyAmount function
		
		RemoveTextBeforeCompanyName(string in_plan_name) := FUNCTION
		//This function tries to identify the plan information before the
		//company name and removes it.  The goal is to identify the company
		//name that exists within the plan name.  This logic doesn't clean up  
		//100% because of  misspelled words and the lack of company information
		//within the plan name.
				PrefixLoc1 	:= StringLib.StringFind(in_plan_name,'PLAN OF',1);
				NewName1 		:= if(PrefixLoc1 > 0, in_plan_name[PrefixLoc1+8..],'');
				PrefixLoc2  := StringLib.StringFind(in_plan_name,'EMPLOYEES OF',1);
				NewName2	  := If(PrefixLoc2 > 0, in_plan_name[PrefixLoc2+13..],'');
				PrefixLoc3  := StringLib.StringFind(in_plan_name,'EMP OF',1);
				NewName3	  := If(PrefixLoc3 > 0, in_plan_name[PrefixLoc3+7..],'');
				PrefixLoc4  := StringLib.StringFind(in_plan_name,'EES OF',1);
				NewName4	  := If(PrefixLoc4 > 0, in_plan_name[PrefixLoc4+7..],'');
				PrefixLoc5  := StringLib.StringFind(in_plan_name,'ATTENDANTS OF ',1);
				NewName5	  := If(PrefixLoc5 > 0, in_plan_name[PrefixLoc5+14..],'');
				PrefixLoc6  := StringLib.StringFind(in_plan_name,'TRUST OF ',1);
				NewName6	  := If(PrefixLoc6 > 0, in_plan_name[PrefixLoc6+9..],'');
				PrefixLoc7  := StringLib.StringFind(in_plan_name,'401',1);
				NewName7  	:= If(PrefixLoc7 = 1,'',in_plan_name);
				PrefixLoc8  := StringLib.StringFind(in_plan_name,'PLAN NAME: ',1);
				NewName8  	:= If(PrefixLoc8 = 1,in_plan_name[PrefixLoc8+11..],'');
				PrefixLoc9  := StringLib.StringFind(in_plan_name,'PLAN NAME ',1);
				NewName9  	:= If(PrefixLoc9 = 1,in_plan_name[PrefixLoc9+10..],'');
				return If(PrefixLoc1>0,NewName1
								,If(PrefixLoc2>0,NewName2
									,If(PrefixLoc3>0,NewName3
										,If(PrefixLoc4>0,NewName4
											,If(PrefixLoc5>0,NewName5
												,If(PrefixLoc6>0,NewName6
													,If(PrefixLoc7>0,NewName7
														,If(PrefixLoc8>0,NewName8
															,If(PrefixLoc9>0,NewName9
																,in_plan_name)))))))));
		end;

		LocateCompany(string planname) := FUNCTION
		//This function tries to identify the plan information after the
		//company name and removes it.  The goal is to identify the company
		//name that exists within the plan name.  This logic doesn't clean up  
		//100% because of  misspelled words and the lack of company information
		//within the plan name.
				Loc1 	:= StringLib.StringFind(planname,'INC ',1);
				Pos1  := If(Loc1 > 0, Loc1+3,0);
				Loc2 	:= StringLib.StringFind(planname,'INCORPORATED ',1);
				Pos2  := If(Loc2 > 0, Loc2+12,0);
				Loc3  := StringLib.StringFind(planname,' CO ',1);
				Pos3  := If(Loc3 > 0, Loc3+3,0);
				Loc4  := StringLib.StringFind(planname,' CORP ',1);
				Pos4  := If(Loc4 > 0, Loc4+5,0);
				Loc5  := StringLib.StringFind(planname,' CORPORATION',1);
				Pos5  := If(Loc5 > 0, Loc5+11,0);
				Loc6  := StringLib.StringFind(planname,' INSTITUTE',1);
				Pos6  := If(Loc6 > 0, Loc6+9,0);
				Loc7  := StringLib.StringFind(planname,' LLP',1);
				Pos7  := If(Loc7 > 0, Loc7+3,0);
				Loc8	:= StringLib.StringFind(planname,' LP',1);
				Pos8  := If(Loc8 > 0, Loc8+2,0);
				Loc9  := StringLib.StringFind(planname,' GROUP',1);
				Pos9  := If(Loc9 > 0, Loc9+5,0);
				Loc10 := StringLib.StringFind(planname,' LLC',1);
				Pos10 := If(Loc10 > 0, Loc10+3,0);
				Loc11 := StringLib.StringFind(planname,' LTD',1);
				Pos11 := If(Loc11 > 0, Loc11+3,0);
				Loc12 := StringLib.StringFind(planname,' COMPANY',1);
				Pos12 := If(Loc12 > 0, Loc12+7,0);			
				Loc13 := StringLib.StringFind(planname,' ORG ',1);
				Pos13 := If(Loc13 > 0, Loc13+4,0);
				Loc14 := StringLib.StringFind(planname,' ORGANIZATION',1);
				Pos14 := If(Loc14 > 0, Loc14+12,0);
				Loc15 := StringLib.StringFind(planname,' HOSPITAL ',1);
				Pos15 := If(Loc15 > 0, Loc15+9,0);
				Loc16 := StringLib.StringFind(planname,' DIVISION ',1);
				Pos16 := If(Loc16 > 0, Loc16+9,0);				
				Loc17 := StringLib.StringFind(planname,' SHARED SAVINGS PLAN',1);
				Pos17 := If(Loc17 > 0, Loc17,0);
				Loc18 := StringLib.StringFind(planname,' PROFIT SHARING AND 401',1);
				Pos18 := If(Loc18 > 0, Loc18,0);
				Loc19 := StringLib.StringFind(planname,' SAVINGS AND RETIREMENT',1);
				Pos19 := If(Loc19 > 0, Loc19,0);
				Loc20 := StringLib.StringFind(planname,' 401',1);
				Pos20 := If(Loc20 > 0, Loc20,0);
				Loc21 := StringLib.StringFind(planname,' PROFIT SHARING',1);
				Pos21 := If(Loc21 > 0, Loc21,0);
				Loc22 := StringLib.StringFind(planname,' RETIREM',1);
				Pos22 := If(Loc22 > 0, Loc22,0);
				Loc23 := StringLib.StringFind(planname,' PENSION',1);
				Pos23 := If(Loc23 > 0, Loc23,0);
				Loc24 := StringLib.StringFind(planname,' ANNUITY',1);
				Pos24 := If(Loc24 > 0, Loc24,0);
				Loc25 := StringLib.StringFind(planname,' PROFIT',1);
				Pos25 := If(Loc25 > 0, Loc25,0);
				Loc26 := StringLib.StringFind(planname,' TRUST FUND',1);
				Pos26 := If(Loc26 > 0, Loc26,0);
				Loc27 := StringLib.StringFind(planname,' SAVINGS AND PROFIT',1);
				Pos27 := If(Loc27 > 0, Loc27,0);
				Loc28 := StringLib.StringFind(planname,' SAVINGS PLAN',1);
				Pos28 := If(Loc28 > 0, Loc28,0);
				Loc29 := StringLib.StringFind(planname,' EMPLOYE',1);
				Pos29 := If(Loc29 > 0, Loc29,0);
				return If(Pos1>0,Pos1
								,If(Pos2>0,Pos2
									,If(Pos3>0,Pos3
										,If(Pos4>0,Pos4
											,If(Pos5>0,Pos5
												,If(Pos6>0,Pos6
													,If(Pos7>0,Pos7
														,If(Pos8>0,Pos8
															,If(Pos9>0,Pos9
																,If(Pos10>0,Pos10
																	,If(Pos11>0,Pos11
																		,If(Pos12>0,Pos12
																			,If(Pos13>0,Pos13
																				,If(Pos14>0,Pos14
																					,If(Pos15>0,Pos15
																						,If(Pos16>0,Pos16
																							,If(Pos17>0,Pos17
																								,If(Pos18>0,Pos18
																									,If(Pos19>0,Pos19
																										,If(Pos20>0,Pos20
																											,If(Pos21>0,Pos21
																												,If(Pos22>0,Pos22
																													,If(Pos23>0,Pos23
																														,If(Pos24>0,Pos24
																															,If(Pos25>0,Pos25
																																,If(Pos26>0,Pos26
																																	,If(Pos27>0,Pos27
																																		,If(Pos28>0,Pos28
																																			,Pos29))))))))))))))))))))))))))));
		end;	

		LaborActions_EBSA.Layouts.base trPreCleanPlanName(LaborActions_EBSA.layouts.base l) := TRANSFORM
				self.clean_plan_name					:= RemoveTextBeforeCompanyName(l.plan_name);
				self.clean_plan_administrator	:= RemoveTextBeforeCompanyName(l.plan_administrator);
				self													:=	l;
		end;

		LaborActions_EBSA.Layouts.base trCleanPlanInfo(LaborActions_EBSA.Layouts.base l) := TRANSFORM
				self.plan_year 								:= Lib_Word.StripTail(StringLib.StringFilter(l.plan_year,'-0123456789'),'-');
				self.clean_plan_name					:= If (LocateCompany(l.clean_plan_name)> 0,l.clean_plan_name[1..LocateCompany(l.clean_plan_name)],l.clean_plan_name);
				self.clean_plan_administrator	:= If (LocateCompany(l.clean_plan_administrator)> 0,l.clean_plan_administrator[1..LocateCompany(l.clean_plan_administrator)],l.clean_plan_administrator);
				self													:=	l;
		end;

		LaborActions_EBSA.Layouts.base	trfLaborActionsEBSAFile(LaborActions_EBSA.Layouts.Input l)	:=	transform

				self.Website					  := StringLib.StringToUpperCase(l.Website);
				self.State							:= StringLib.StringToUpperCase(l.State);
			  self.Casetype						:=
					MAP(StringLib.StringToUpperCase(l.Casetype) = 'LATER FILER' => 'LATE FILER',
							StringLib.StringToUpperCase(l.Casetype));
				self.Plan_Ein						:= StringLib.StringFindReplace(l.Plan_EIN, '-',' ');
				self.Plan_Year					:= If (length(l.Plan_Year) <> 4
																,Lib_Word.Word(l.Plan_Year,1) + '-' + Lib_Word.Word(l.Plan_Year,2)
																,l.Plan_Year);
				self.Plan_Name 					:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(l.plan_name));
				self.Plan_Administrator := StringLib.StringToUpperCase(StringLib.StringCleanSpaces(l.Plan_Administrator));
				self.Admin_State 				:= StringLib.StringToUpperCase(l.Admin_State);
				self.Admin_Zip_Code			:= StringLib.StringExtract(reformatZipCode(l.Admin_Zip_Code, l.Admin_Zip_Code4),1);
				self.Admin_Zip_Code4		:= StringLib.StringExtract(reformatZipCode(l.Admin_Zip_Code, l.Admin_Zip_Code4),2);
				self.Closing_Reason			:= StringLib.StringToUpperCase(l.Closing_Reason);
				self.Closing_Date				:= fixdate((string)l.Closing_Date);
				self.Penalty_Amount			:= reformatPenaltyAmount(StringLib.StringToUpperCase(l.Penalty_Amount));
				self.Date_FirstSeen			:= (integer) pversion;
				self.Date_LastSeen			:= (integer) pversion;										
		 		self										:= l;
				self										:= [];
		end; //end trfLaborActionsEBSAFile transform

		dPreProcess		:=	project(pRawFileInput, trfLaborActionsEBSAFile(left));

		dPreCleanPlanName  := project(dPreprocess,trPreCleanPlanName(left));
		
		dCleanedFile := project(dPreCleanPlanName,trCleanPlanInfo(left));
		
		return dCleanedFile;

	end; //end fPreProcess function
   
	export fAll( dataset(LaborActions_EBSA.Layouts.Input) pRawFileInput, string pversion) := function
		dPreprocess	:= fPreProcess(pRawFileInput,pversion);
		return dPreprocess;
	end; //end fAll

end; //end StandardizeInputFile 