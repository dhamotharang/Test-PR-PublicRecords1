import ut, Business_Header, Business_Header_SS, did_add, AID, Address, idl_header;

export Cleaned_IRS_NonProfit(string filedate,
														 dataset(Layouts_IRS_NonProfit.Base_AID) pPrevbase = govdata.File_IRS_NonProfit_Base_AID
														 ) := function

	File_in 	       := govdata.Mapping_IRS_NonProfit(filedate);
	File_base				 := pPrevBase;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Convert the Input File to Base format
	//////////////////////////////////////////////////////////////////////////////////////////////
	govdata.Layouts_IRS_NonProfit.Base_AID Convert2Base(File_in l) := transform
		self						:=	l;
		self						:=	[];
	end;

	File_in2base 			:= project(File_in, Convert2Base(left));

	File_Combined			:=	File_in2base + File_base; //need to keep source_rec_id 

	File_Combined_Dist:= distribute(File_Combined,hash(Employer_ID_Number, Primary_Name_Of_Organization, Street_Address, City, State, Zip_Code));

	File_Combined_Sort:= sort(File_Combined_Dist, Employer_ID_Number, Primary_Name_Of_Organization, Street_Address, City, State, Zip_Code, local);

	HasAddress				:=	trim(File_Combined_Sort.prep_addr_line1, left,right) != '' and 
												trim(File_Combined_Sort.prep_addr_last_line, left,right) != '';
										
	dWith_address			:= File_Combined_Sort(HasAddress);
	dWithout_address	:= File_Combined_Sort(not(HasAddress));

	unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

	AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_last_line, Append_RawAID, dwithAID, lFlags);
		
	dBase := project(dwithAID,transform(govdata.Layouts_IRS_NonProfit.Base_AID,
																			self.Append_ACEAID		:= left.aidwork_acecache.aid;
																			self.Append_RawAID		:= left.aidwork_rawaid;
																			self.zip							:= left.aidwork_acecache.zip5;
																			self									:= left.aidwork_acecache;
																			self									:= left;
																			)
									 ) + dWithout_address;
									
	Address.Mac_Is_Business( dBase(In_Care_Of_Name != ''), In_Care_Of_Name, dClean_Name, name_flag, false, true );

	cln_layout := RECORD
		recordof(dBase);
		string1		name_flag;
		string5		cln_title;
		string20	cln_fname;
		string20	cln_mname;
		string20	cln_lname;
		string5		cln_suffix;
		string5		cln_title2;
		string20	cln_fname2;
		string20	cln_mname2;
		string20	cln_lname2;
		string5		cln_suffix2;
	END;
		
	dNameBlank	:=  project(dBase(In_Care_Of_Name = ''),transform(cln_layout,self	:=	left; self	:=	[]));
	dCleanName	:=  dClean_Name   +  dNameBlank;
	
	govdata.Layouts_IRS_NonProfit.Base_AID  CleanUpName( dCleanName  l) := transform
		self.title													:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
																								l.name_flag = 'U' => l.title, 
																								''
																							);
		self.fname													:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
																								l.name_flag = 'U' => l.fname, 
																								''
																							 );
		self.mname												  := map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
																								l.name_flag = 'U' => l.mname, 
																								''
																							 );
		self.lname													:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
																								l.name_flag = 'U' => l.lname, 
																								''
																							 );
		self.name_suffix										:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
																								l.name_flag = 'U' => l.name_suffix, 
																								''
																							 );
		self.CName												  := if(l.name_flag = 'B',
																							trim(l.In_Care_Of_Name,left,right),
																							''
																						 );
		self.Employer_ID_Number							:= ut.fntrim2upper(l.Employer_ID_Number) ;
		self.Primary_Name_Of_Organization		:= ut.fntrim2upper(l.Primary_Name_Of_Organization) ; 
		self.In_Care_Of_Name								:= ut.fntrim2upper(l.In_Care_Of_Name) ;
		self.Street_Address									:= ut.fntrim2upper(l.Street_Address) ;
		self.City														:= ut.fntrim2upper(l.City) ;
		self.State													:= ut.fntrim2upper(l.State) ;
		self.Zip_Code												:= ut.fntrim2upper(l.Zip_Code) ; 
		self.Group_Exemption_Number					:= ut.fntrim2upper(l.Group_Exemption_Number) ; 
		self.Subsection_Code								:= ut.fntrim2upper(l.Subsection_Code) ;
		self.Affiliation_Code								:= ut.fntrim2upper(l.Affiliation_Code) ; 
		self.Classification_Code						:= ut.fntrim2upper(l.Classification_Code) ;
		self.Ruling_Date										:= ut.fntrim2upper(l.Ruling_Date) ; 
		self.Deductibility_Code							:= ut.fntrim2upper(l.Deductibility_Code) ; 
		self.Foundation_Code								:= ut.fntrim2upper(l.Foundation_Code) ;
		self.Activity_Codes									:= ut.fntrim2upper(l.Activity_Codes) ; 
		self.Organization_Code							:= ut.fntrim2upper(l.Organization_Code) ; 
		self.Univ_Loc_Code									:= ut.fntrim2upper(l.Univ_Loc_Code) ; 
		self.Advance_Ruling_Exp_Date				:= ut.fntrim2upper(l.Advance_Ruling_Exp_Date) ;
		self.Exempt_Org_Status_Code					:= ut.fntrim2upper(l.Exempt_Org_Status_Code) ;
		self.Tax_Period											:= ut.fntrim2upper(l.Tax_Period) ;
		self.Asset_Code											:= ut.fntrim2upper(l.Asset_Code) ; 
		self.Income_Code										:= ut.fntrim2upper(l.Income_Code) ;
		self.Filing_Requirement_Code_part1	:= ut.fntrim2upper(l.Filing_Requirement_Code_part1) ; 
		self.Filing_Requirement_Code_part2	:= ut.fntrim2upper(l.Filing_Requirement_Code_part2) ;
		self.Accounting_Period							:= ut.fntrim2upper(l.Accounting_Period) ; 
		self.Asset_Amount										:= ut.fntrim2upper(l.Asset_Amount) ; 
		self.Income_Amount									:= ut.fntrim2upper(l.Income_Amount) ;
		self.Negative_Sign									:= ut.fntrim2upper(l.Negative_Sign) ; 
		self.Form_990_Revenue_Amount				:= ut.fntrim2upper(l.Form_990_Revenue_Amount) ;
		self.Negative_Rev_Amount						:= ut.fntrim2upper(l.Negative_Rev_Amount) ;
		self.National_Taxonomy_Exempt				:= ut.fntrim2upper(l.National_Taxonomy_Exempt) ;
		self.Sort_Name											:= ut.fntrim2upper(l.Sort_Name);										 
		self																:= l;
		self																:= [];
	end;		
					
	Clean_IRS_NonProfit_Names							:=project( dCleanName ,CleanUpName(left));

	ut.mac_flipnames(Clean_IRS_NonProfit_Names, fname, mname, lname, dFlippedNames);

	Cleaned_IRS_NonProfit_ded := dedup(Sort(dFlippedNames, Employer_ID_Number, Primary_Name_Of_Organization, In_Care_Of_Name, 
																					Street_Address, City, State, Zip_Code, Group_Exemption_Number, Subsection_Code, 
																					Affiliation_Code, Classification_Code, Ruling_Date, Deductibility_Code, Foundation_Code,
																					Activity_Codes, Organization_Code, Univ_Loc_Code, Advance_Ruling_Exp_Date, Exempt_Org_Status_Code, Tax_Period,
																					Asset_Code, Income_Code, Filing_Requirement_Code_part1, Filing_Requirement_Code_part2, Accounting_Period, Asset_Amount,
																					Income_Amount, Form_990_Revenue_Amount, 
																					National_Taxonomy_Exempt, Sort_Name, -Process_Date),
																			Employer_ID_Number, Primary_Name_Of_Organization, In_Care_Of_Name, 
																			Street_Address, City, State, Zip_Code, Group_Exemption_Number, Subsection_Code, 
																			Affiliation_Code, Classification_Code, Ruling_Date, Deductibility_Code, Foundation_Code,
																			Activity_Codes, Organization_Code, Univ_Loc_Code, Advance_Ruling_Exp_Date, Exempt_Org_Status_Code, Tax_Period,
																			Asset_Code, Income_Code, Filing_Requirement_Code_part1, Filing_Requirement_Code_part2, Accounting_Period, Asset_Amount,
																			Income_Amount, Form_990_Revenue_Amount, 
																			National_Taxonomy_Exempt, Sort_Name)  : persist('~thor_data400::persist::govdata::IRS_NonProfit::Clean');

	return Cleaned_IRS_NonProfit_ded;
end;