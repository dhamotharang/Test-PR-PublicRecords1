import Address, aid, ut;

export Mapping_IRS_NonProfit(string filedate) := function

	file_in := govdata.File_IRS_Non_Profit_In;

	govdata.Layouts_IRS_NonProfit.Common tMapIRS_NonProfit(file_in l) := transform
		self.Process_Date										:= filedate;
		self.Employer_ID_Number							:= ut.fntrim2upper(l.Employer_ID_Number) ;
		self.Primary_Name_Of_Organization		:= ut.fntrim2upper(l.Primary_Name_Of_Organization) ; 
		self.In_Care_Of_Name 								:= ut.fntrim2upper(stringLib.StringFindReplace(l.In_Care_Of_Name, '%', ''));
		self.Street_Address									:= ut.fntrim2upper(l.Street_Address) ;
		self.City														:= ut.fntrim2upper(l.City) ;
		self.State													:= ut.fntrim2upper(l.State) ;
		self.Zip_Code												:= ut.fntrim2upper(l.Zip_Code) ;
		self.Group_Exemption_Number 				:= ut.fntrim2upper(regexreplace('^0+', l.Group_Exemption_Number, ''));
		
		self.Subsection_Code								:= ut.fntrim2upper(l.Subsection_Code) ;
		self.Affiliation_Code								:= ut.fntrim2upper(l.Affiliation_Code) ; 
		self.Classification_Code						:= ut.fntrim2upper(l.Classification_Code) ;
		self.Ruling_Date										:= ut.fntrim2upper(l.Ruling_Date) ; 
		self.Deductibility_Code							:= ut.fntrim2upper(l.Deductibility_Code) ; 
		self.Foundation_Code								:= ut.fntrim2upper(l.Foundation_Code) ;
		self.Activity_Codes									:= ut.fntrim2upper(l.Activity_Codes) ; 
		self.Organization_Code							:= ut.fntrim2upper(l.Organization_Code) ; 
		self.Univ_Loc_Code									:= ''; 
		self.Advance_Ruling_Exp_Date				:= '';
		self.Exempt_Org_Status_Code					:= ut.fntrim2upper(l.Exempt_Org_Status_Code) ;
		self.Tax_Period											:= ut.fntrim2upper(l.Tax_Period) ;
		self.Asset_Code											:= ut.fntrim2upper(l.Asset_Code) ; 
		self.Income_Code										:= ut.fntrim2upper(l.Income_Code) ;
		self.Filing_Requirement_Code_part1	:= ut.fntrim2upper(l.Filing_Requirement_Code_part1) ; 
		self.Filing_Requirement_Code_part2	:= ut.fntrim2upper(l.Filing_Requirement_Code_part2) ;
		self.Accounting_Period							:= ut.fntrim2upper(l.Accounting_Period) ; 
		self.Asset_Amount										:= ut.fntrim2upper(l.Asset_Amount) ; 
		self.Income_Amount									:= stringlib.StringFilterOut(l.income_amount,'-'); 						//remove the negative sign if it exists
		self.Negative_Sign									:= if(stringlib.StringFind(l.Income_Amount,'-',1)>0,'-','');
		self.Form_990_Revenue_Amount				:= stringlib.StringFilterOut(l.Form_990_Revenue_Amount,'-');  //remove the negative sign if it exists		
		self.Negative_Rev_Amount						:= if(stringlib.StringFind(l.Form_990_Revenue_Amount,'-',1)>0,'-','');
		self.National_Taxonomy_Exempt				:= ut.fntrim2upper(l.National_Taxonomy_Exempt) ;
		self.Sort_Name											:= ut.fntrim2upper(l.Sort_Name);	
		//name is cleaned in Cleaned_IRS_NonProfit attribute
		self.title		         							:= ''; 
		self.fname	            						:= ''; 
		self.mname	            						:= ''; 
		self.lname		         							:= ''; 
		self.name_suffix	      						:= ''; 
		self.name_score	        						:= ''; 
		self.append_rawaid									:= 0;
		self.prep_addr_line1								:= address.Addr1FromComponents(ut.fntrim2upper(l.Street_Address)
																																 ,''
																																 ,''
																																 ,''
																																 ,''
																																 ,''
																																 ,''
																																);
		self.prep_addr_last_line						:= address.Addr2FromComponents(ut.fntrim2upper(l.City)
																																 ,ut.fntrim2upper(l.State)
																																 ,trim(l.zip_code)[1..5]
																																);
		self 																:= l;
	end;

	IRS_NonProfit := project(file_in, tMapIRS_NonProfit(LEFT));

	return IRS_NonProfit;
end;