import prte2_business_credit, BIPV2, Address;

EXPORT files := module
	
EXPORT infile 		:= dataset(prte2_business_credit.constants.in_prefix + 'denormalized', prte2_business_credit.layouts.input, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')))(process_date <> '');
EXPORT basefile		:= dataset(prte2_business_credit.constants.base_prefix + 'denormalized', prte2_business_credit.layouts.base, thor);
	
layouts.BIClassification 		xformBI(basefile l) := transform
	self.Version															:= L.process_date;
	self.Original_Version											:= L.process_date;
	self.record_type													:= L.Segment_Identifier; //AB
	self.Sbfe_Contributor_Number							:= L.Header_Sbfe_Contributor_Number;
	self.Contract_Account_Number							:= L.contract_account_number;
	self.Original_Contract_Account_Number			:= L.Original_Contract_Account_Number;
	self.Account_Type_Reported								:= L.account_type_reported; //003
	self.dt_first_seen												:= L.dt_first_seen;
	self.dt_last_seen													:= L.dt_last_seen;
	self.dt_vendor_first_reported							:= L.dt_vendor_first_reported;	
	self.dt_vendor_last_reported							:= L.dt_vendor_last_reported;
	self.dt_datawarehouse_first_reported			:= L.dt_datawarehouse_first_reported;
	self.dt_datawarehouse_last_reported				:= L.dt_datawarehouse_last_reported;
	self.Classification_Code_Type							:= L.BusinessIndustry_Classification_Code_Type;
	self.Classification_Code									:= L.BusinessIndustry_Classification_Code;
	self.Primary_Industry_Code_Indicator			:= L.BusinessIndustry_Primary_Industry_Code_Indicator;
	self.Privacy_Indicator										:= L.BusinessIndustry_Privacy_Indicator;
	self := L;
	self := [];
end;

EXPORT dsBusinessClassification := project(basefile, xformBI(left)); 


layouts.BusinessOwner		xformBO(basefile L) := transform
	self.Version															:= L.process_date;
	self.Original_Version											:= L.process_date;
	// self.record_type													:= L.Segment_Identifier; //AB
	self.Sbfe_Contributor_Number							:= L.Header_Sbfe_Contributor_Number;
	self.Contract_Account_Number							:= L.contract_account_number;
	self.Original_Contract_Account_Number			:= L.Original_Contract_Account_Number;
	self.Account_Type_Reported								:= L.account_type_reported; //003
	self.dt_first_seen												:= L.dt_first_seen;
	self.dt_last_seen													:= L.dt_last_seen;
	self.dt_vendor_first_reported							:= L.dt_vendor_first_reported;	
	self.dt_vendor_last_reported							:= L.dt_vendor_last_reported;
	self.dt_datawarehouse_first_reported			:= L.dt_datawarehouse_first_reported;
	self.dt_datawarehouse_last_reported				:= L.dt_datawarehouse_last_reported;
	self.Business_Name												:= L.BusinessOwner_Business_Name;
	self.Web_Address													:= L.BusinessOwner_Web_Address;
	self.Guarantor_Owner_Indicator						:= L.BusinessOwner_Guarantor_Owner_Indicator;
	self.Relationship_To_Business_Indicator		:= L.BusinessOwner_Relationship_To_Business_Indicator;
	self.Percent_Of_Liability									:= L.BusinessOwner_Percent_Of_Liability;
	self.Percent_Of_Ownership_If_Owner_Principal := L.BusinessOwner_Percent_Of_Ownership_If_Owner_Principal;
	self.did																	:= 0;
	self := L;
	self := [];
end;

EXPORT dsBusinessOwner	 := project(basefile(BusinessOwner_Segment_Identifier <> ''),xformBO(left));


layouts.Collateral		xformCollateral(basefile L) := transform
	self.Sbfe_Contributor_Number											:= L.Header_Sbfe_Contributor_Number;
	self.Contract_Account_Number											:= L.contract_account_number;
	self.Version																			:= L.process_date;
	self.Original_Version															:= L.process_date;;
	self.Original_Contract_Account_Number							:= L.Original_Contract_Account_Number;
	self.Account_Type_Reported												:= L.account_type_reported; //003
	self.dt_first_seen																:= L.dt_first_seen;
	self.dt_last_seen																	:= L.dt_last_seen;
	self.dt_vendor_first_reported											:= L.dt_vendor_first_reported;	
	self.dt_vendor_last_reported											:= L.dt_vendor_last_reported;
	self.dt_datawarehouse_first_reported							:= L.dt_datawarehouse_first_reported;
	self.dt_datawarehouse_last_reported								:= L.dt_datawarehouse_last_reported;
  self.collateral_indicator													:= L.Collateral_Indicator;
  self.type_of_collateral_secured_for_this_account	:= L.Collateral_Type_Of_Collateral_Secured_For_This_Account;
  self.collateral_description												:= L.Collateral_Description;
  self.ucc_filing_number														:= L.Collateral_UCC_Filing_Number;
  self.ucc_filing_type															:= L.Collateral_UCC_Filing_Type;
  self.ucc_filing_date															:= L.Collateral_UCC_Filing_Date;
  self.ucc_filing_expiration_date										:= L.Collateral_UCC_Filing_Expiration_Date;
  self.ucc_filing_jurisdiction											:= L.Collateral_UCC_Filing_Jurisdiction;
  self.ucc_filing_description												:= L.Collateral_UCC_Filing_Description;
  self.__internal_fpos__														:= 0;
	self := L;
	self := [];
end;	

EXPORT dsCollateral := project(basefile(Collateral_Segment_Identifier <> ''), xformCollateral(left));
		

layouts.HistorySlim		xformHistory(basefile L) := transform
	self.Version															:= L.process_date;
	self.Sbfe_Contributor_Number							:= L.Header_Sbfe_Contributor_Number;
	self.Contract_Account_Number							:= L.contract_account_number;
	self.Original_Contract_Account_Number			:= L.Original_Contract_Account_Number;
	self.Account_Type_Reported								:= L.Account_Type_Reported;
	self.Previous_Sbfe_Contributor_Number			:= L.Previous_Member_ID;
	self.Previous_Contract_Account_Number			:= L.Previous_Account_Number;
	self.Previous_Account_Type								:= L.Previous_Account_Type;
	self.change_date													:= L.Date_Account_Converted;
	END;

EXPORT dsHistory	:= project(basefile(History_Segment_Identifier <> ''), xformHistory(left));
	

layouts.IndividualOwner			xformIndvOwner(basefile L) := transform
		self.Version															:= L.process_date;
		self.Original_Version											:= L.process_date;
		self.Sbfe_Contributor_Number							:= L.Header_Sbfe_Contributor_Number;
		self.Contract_Account_Number							:= L.contract_account_number;
		self.Original_Contract_Account_Number			:= L.Original_Contract_Account_Number;
		self.Account_Type_Reported								:= L.account_type_reported; //003
		self.dt_first_seen												:= L.dt_first_seen;
		self.dt_last_seen													:= L.dt_last_seen;
		self.dt_vendor_first_reported							:= L.dt_vendor_first_reported;	
		self.dt_vendor_last_reported							:= L.dt_vendor_last_reported;
		self.dt_datawarehouse_first_reported			:= L.dt_datawarehouse_first_reported;
		self.dt_datawarehouse_last_reported				:= L.dt_datawarehouse_last_reported;	
		self.Original_fname												:= L.Original_fname;
		self.Original_mname												:= L.Original_mname;	
		self.Original_lname												:= L.Original_lname;
		self.Original_suffix											:= L.Original_suffix;
		self.E_Mail_Address												:= L.E_Mail_Address;
		self.Guarantor_Owner_Indicator						:= L.Guarantor_Owner_Indicator;
		self.Relationship_to_Business_Indicator		:= L.Relationship_To_Business_Indicator;
		self.Business_Title												:= L.Business_Title;
		self.Percent_Of_Liability									:= L.Percent_Of_Liability;
		self.Percent_Of_Ownership									:= L.Percent_Of_Ownership;
		self.did																	:= L.did;
		self := L;
		self := [];
	END;
	
EXPORT dsIndvOwner := project(basefile(IndividualOwner_Address_Segment_Identifier <> ''), xformIndvOwner(left));
	
layouts.MasterAccount			xformMaster(basefile L) := transform
		self.Version															:= L.process_date;
		self.Original_Version											:= L.process_date;
		self.Sbfe_Contributor_Number							:= L.Header_Sbfe_Contributor_Number;
		self.Contract_Account_Number							:= L.contract_account_number;
		self.Original_Contract_Account_Number			:= L.Original_Contract_Account_Number;
		self.Account_Type_Reported								:= L.account_type_reported; //003
		self.dt_first_seen												:= L.dt_first_seen;
		self.dt_last_seen													:= L.dt_last_seen;
		self.dt_vendor_first_reported							:= L.dt_vendor_first_reported;	
		self.dt_vendor_last_reported							:= L.dt_vendor_last_reported;
		self.dt_datawarehouse_first_reported			:= L.dt_datawarehouse_first_reported;
		self.dt_datawarehouse_last_reported				:= L.dt_datawarehouse_last_reported;	
		self.Master_Account_Or_Contract_Number_Identifier := L.Master_Account_Or_Contract_Number_Identifier;
	END;

EXPORT dsMasterAccount := project(basefile(MasterAccount_Segment_Identifier <> ''), xformMaster(left));
	

layouts.MemberSpecific		xformMemberSpecific(basefile L) := transform
		self.Version															:= L.process_date;
		self.Original_Version											:= L.process_date;
		self.Sbfe_Contributor_Number							:= L.Header_Sbfe_Contributor_Number;
		self.Contract_Account_Number							:= L.contract_account_number;
		self.Original_Contract_Account_Number			:= L.Original_Contract_Account_Number;
		self.Account_Type_Reported								:= L.account_type_reported; //003
		self.dt_first_seen												:= L.dt_first_seen;
		self.dt_last_seen													:= L.dt_last_seen;
		self.dt_vendor_first_reported							:= L.dt_vendor_first_reported;	
		self.dt_vendor_last_reported							:= L.dt_vendor_last_reported;
		self.dt_datawarehouse_first_reported			:= L.dt_datawarehouse_first_reported;
		self.dt_datawarehouse_last_reported				:= L.dt_datawarehouse_last_reported;	
		self.Name_Of_Value												:= L.MemberSpecific_Name_Of_Value;
		self.Value_String													:= L.MemberSpecific_Value_String;
		self.Privacy_Indicator										:= L.MemberSpecific_Privacy_Indicator;
	end;	
	
EXPORT dsMemberSpecific := project(basefile(MemberSpecific_Segment_Identifier <> ''),xformMemberSpecific(left)); 
	
layouts.ReleaseDates   xformReleaseDate(basefile L) := transform
		self.version				:= L.process_date;
		self.cert_date			:= L.process_date;
		self.cert_time			:= '';	
		self.prod_date			:= '';
		self.prod_time			:= '';
		self.update_type		:= 'F';
		self.first_date			:= L.process_date;
		self.last_date			:= L.process_date;
		self.__internal_fpos__	:= 0;
 END;
 
EXPORT dsReleaseDates := dedup(project(basefile, xformReleaseDate(left)), record, all);

export dsScoring					   		 := DATASET([ ], layouts.ScoringIndex);
export dsKey_Best								 := DATASET([ ], layouts.BestKey);

// export dsBusinessClassification  := dataset([ ], layouts.BIClassification); 
// export dsBusinessOwner					 := dataset([ ], layouts.BusinessOwner);
// export dsCollateral    					 := dataset([ ], layouts.Collateral);
// export dsHistory								 := dataset([ ], layouts.HistorySlim);
// export dsIndvOwner							 := dataset([ ], layouts.IndividualOwner);
// export dsIOInformation					 := dataset([ ], layouts.IOInformation);
// export dsMasterAccount					 := dataset([ ], layouts.MasterAccount);
// export dsMemberSpecific					 := dataset([ ], layouts.MemberSpecific);
// export dsReleaseDates						 := dataset([ ], layouts.ReleaseDates);

// export dsTradeline							 := dataset([ ], layouts.Tradelines);
// export dslinkids  							 := DATASET([ ],{layouts.LinkedBase, integer1 fp});
// export dsBusinessOwnerInfo   		 := DATASET([ ], layouts.BOInformation);
// export dsTradelineGuarantor	 		 := DATASET([ ], layouts.TradelineBase);



end;
