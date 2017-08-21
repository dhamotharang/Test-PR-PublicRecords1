import Address, aid, ut;

export Mapping_IRS_NonProfit(string filedate) := function

	file_in := govdata.File_IRS_Non_Profit_In;

	govdata.Layouts_IRS_NonProfit.Common tMapIRS_NonProfit(file_in l) := transform
		self.Process_Date										:= filedate;
		self.Employer_ID_Number							:= ut.CleanSpacesAndUpper(l.Employer_ID_Number) ;
		self.Primary_Name_Of_Organization		:= ut.CleanSpacesAndUpper(l.Primary_Name_Of_Organization) ; 
		self.In_Care_Of_Name 								:= ut.CleanSpacesAndUpper(stringLib.StringFindReplace(l.In_Care_Of_Name, '%', ''));
		self.Street_Address									:= ut.CleanSpacesAndUpper(l.Street_Address) ;
		self.City														:= ut.CleanSpacesAndUpper(l.City) ;
		self.State													:= ut.CleanSpacesAndUpper(l.State) ;
		self.Zip_Code												:= ut.CleanSpacesAndUpper(l.Zip_Code) ;
		self.Group_Exemption_Number 				:= ut.CleanSpacesAndUpper(regexreplace('^0+', l.Group_Exemption_Number, ''));
		
		self.Subsection_Code								:= ut.CleanSpacesAndUpper(l.Subsection_Code) ;
		self.Affiliation_Code								:= ut.CleanSpacesAndUpper(l.Affiliation_Code) ; 
		self.Classification_Code						:= ut.CleanSpacesAndUpper(l.Classification_Code) ;
		self.Ruling_Date										:= ut.CleanSpacesAndUpper(l.Ruling_Date) ; 
		self.Deductibility_Code							:= ut.CleanSpacesAndUpper(l.Deductibility_Code) ; 
		self.Foundation_Code								:= ut.CleanSpacesAndUpper(l.Foundation_Code) ;
		self.Activity_Codes									:= ut.CleanSpacesAndUpper(l.Activity_Codes) ; 
		self.Organization_Code							:= ut.CleanSpacesAndUpper(l.Organization_Code) ; 
		self.Univ_Loc_Code									:= ''; 
		self.Advance_Ruling_Exp_Date				:= '';
		self.Exempt_Org_Status_Code					:= ut.CleanSpacesAndUpper(l.Exempt_Org_Status_Code) ;
		self.Tax_Period											:= ut.CleanSpacesAndUpper(l.Tax_Period) ;
		self.Asset_Code											:= ut.CleanSpacesAndUpper(l.Asset_Code) ; 
		self.Income_Code										:= ut.CleanSpacesAndUpper(l.Income_Code) ;
		self.Filing_Requirement_Code_part1	:= ut.CleanSpacesAndUpper(l.Filing_Requirement_Code_part1) ; 
		self.Filing_Requirement_Code_part2	:= ut.CleanSpacesAndUpper(l.Filing_Requirement_Code_part2) ;
		self.Accounting_Period							:= ut.CleanSpacesAndUpper(l.Accounting_Period) ; 
		self.Asset_Amount										:= ut.CleanSpacesAndUpper(l.Asset_Amount) ; 
		self.Income_Amount									:= stringlib.StringFilterOut(l.income_amount,'-'); 						//remove the negative sign if it exists
		self.Negative_Sign									:= if(stringlib.StringFind(l.Income_Amount,'-',1)>0,'-','');
		self.Form_990_Revenue_Amount				:= stringlib.StringFilterOut(l.Form_990_Revenue_Amount,'-');  //remove the negative sign if it exists		
		self.Negative_Rev_Amount						:= if(stringlib.StringFind(l.Form_990_Revenue_Amount,'-',1)>0,'-','');
		self.National_Taxonomy_Exempt				:= ut.CleanSpacesAndUpper(l.National_Taxonomy_Exempt) ;
		self.Sort_Name											:= ut.CleanSpacesAndUpper(l.Sort_Name);	
		//name is cleaned in Cleaned_IRS_NonProfit attribute
		self.title		         							:= ''; 
		self.fname	            						:= ''; 
		self.mname	            						:= ''; 
		self.lname		         							:= ''; 
		self.name_suffix	      						:= ''; 
		self.name_score	        						:= ''; 
		self.append_rawaid									:= 0;
		self.prep_addr_line1								:= address.Addr1FromComponents(ut.CleanSpacesAndUpper(l.Street_Address)
																																 ,''
																																 ,''
																																 ,''
																																 ,''
																																 ,''
																																 ,''
																																);
		self.prep_addr_last_line						:= address.Addr2FromComponents(ut.CleanSpacesAndUpper(l.City)
																																 ,ut.CleanSpacesAndUpper(l.State)
																																 ,trim(l.zip_code)[1..5]
																																);
		self 																:= l;
	end;

	IRS_NonProfit := project(file_in, tMapIRS_NonProfit(LEFT));

	return IRS_NonProfit;
end;