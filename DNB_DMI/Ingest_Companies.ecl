import tools;
EXPORT Ingest_Companies(

	 dataset(Layouts.Base.Companies)				pInputFile							
	,dataset(Layouts.Base.CompaniesForBIP2)	pBaseFile			= Files().base.companies.qa									
	,string																	pPersistname	= persistnames().IngestCompanies
	
) :=
MODULE

  shared base := pBaseFile; // Change IN_file_base to change input to ingest process
  shared NullFile := dataset([],Layouts.base.CompaniesForBIP2); // Use to replace files you wish to remove
// First collect together all sources
  import DNB_DMI;
  infile := pInputFile;
//infile := NullFile; // Can be uncommented to remove temporarily
  export FilesToIngest1 := infile;
  Layouts.base.CompaniesForBIP2 Into(FilesToIngest1 le) := transform
    self 	:= 	le;
		self	:=	[];
  end;
  shared FilesToIngest := project(FilesToIngest1,Into(left)); // In case local header decl and _as_ attributes differ
// Now need to discover which records are old / new / updated
  shared RecordType := utilities.recordtype;
  shared RTToText(unsigned1 c) := utilities.RTToText(c);
  shared WithRT := RECORD(Layouts.base.CompaniesForBIP2)
    __Tpe := RecordType.Unknown;	//default is zero
  END;
  shared  WithRT AddFlag(Layouts.base.CompaniesForBIP2 le,UNSIGNED1 c) := TRANSFORM
    SELF.__Tpe := c;
    SELF := le;
  END;
	
  shared  WithRT AddFlag2(WithRT le,UNSIGNED1 c) := TRANSFORM
    SELF.__Tpe := c;
    SELF := le;
  END;
//so if update file has dups, history in it
/*when u rollup, dup records, result should be the the latest dated records are new
anything less than that are old, right, like the base file recs....
so maybe what we do is find latest dt vendor last reported after we do rollup
records with that date in update file, go into dFilesToIngest0 dataset of join
records without that date in update file, go into the dBase0 dataset of join, as if they were already in the base file
*/	
  shared WithRT MergeData(WithRT le, WithRT ri) := transform // Pick the data for the new record
    SELF.date_first_seen := MAP ( le.__Tpe = 0 OR (unsigned)le.date_first_seen = 0 => ri.date_first_seen,
                     ri.__Tpe = 0 OR (unsigned)ri.date_first_seen = 0 => le.date_first_seen,
                     (unsigned)le.date_first_seen < (unsigned)ri.date_first_seen => le.date_first_seen, // Want the lowest non-zero value
                     ri.date_first_seen);
    SELF.date_last_seen := MAP ( le.__Tpe = 0 => ri.date_last_seen,
                     ri.__Tpe = 0 => le.date_last_seen,
                     (unsigned)le.date_last_seen < (unsigned)ri.date_last_seen => ri.date_last_seen, // Want the highest value
                     le.date_last_seen);
    SELF.date_vendor_first_reported := MAP ( le.__Tpe = 0 OR (unsigned)le.date_vendor_first_reported = 0 => ri.date_vendor_first_reported,
                     ri.__Tpe = 0 OR (unsigned)ri.date_vendor_first_reported = 0 => le.date_vendor_first_reported,
                     (unsigned)le.date_vendor_first_reported < (unsigned)ri.date_vendor_first_reported => le.date_vendor_first_reported, // Want the lowest non-zero value
                     ri.date_vendor_first_reported);
    SELF.date_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.date_vendor_last_reported,
                     ri.__Tpe = 0 => le.date_vendor_last_reported,
                     (unsigned)le.date_vendor_last_reported < (unsigned)ri.date_vendor_last_reported => ri.date_vendor_last_reported, // Want the highest value
                     le.date_vendor_last_reported);
    SELF.__Tpe := MAP ( le.__Tpe = 0																				=> ri.__Tpe
											, ri.__Tpe = 0 																				=> le.__Tpe
											,		 self.date_first_seen							<> le.date_first_seen
												OR self.date_last_seen							<> le.date_last_seen 
												OR self.date_vendor_first_reported	<> le.date_vendor_first_reported 
												OR self.date_vendor_last_reported		<> le.date_vendor_last_reported 	=> RecordType.Updated
											,  																																				 RecordType.Unchanged
									);
    SELF := IF ( le.__Tpe = 0, ri, le ); // Copy most fields from left if possible
  END;

	export fRollup(dataset(WithRT)	pDataset) := 
	function
		AllRecs_dist := distribute(pDataset	,hash64(rawfields.duns_number,rawfields.business_name,rawfields.trade_style));
		AllRecs_Sort		:= sort(AllRecs_dist
	,rawfields.duns_number
	,rawfields.Business_Name
	,rawfields.trade_style
	,rawfields.street
	,rawfields.city
	,rawfields.state
	,rawfields.zip_code
	,rawfields.mail_address
	,rawfields.Mail_City
	,rawfields.Mail_State
	,rawfields.Mail_Zip_Code
	,rawfields.telephone_number
	,rawfields.county_name
	,rawfields.msa_code
	,rawfields.msa_name
	,rawfields.line_of_business_description
	,rawfields.Sic1
	,rawfields.sic1desc
	,rawfields.sic1a
	,rawfields.sic1adesc
	,rawfields.sic1b
	,rawfields.sic1bdesc
	,rawfields.sic1c
	,rawfields.sic1cdesc
	,rawfields.sic1d
	,rawfields.sic1ddesc
	,rawfields.Sic2
	,rawfields.sic2desc
	,rawfields.sic2a
	,rawfields.sic2adesc
	,rawfields.sic2b
	,rawfields.sic2bdesc
	,rawfields.sic2c
	,rawfields.sic2cdesc
	,rawfields.sic2d
	,rawfields.sic2ddesc
	,rawfields.Sic3
	,rawfields.sic3desc
	,rawfields.sic3a
	,rawfields.sic3adesc
	,rawfields.sic3b
	,rawfields.sic3bdesc
	,rawfields.sic3c
	,rawfields.sic3cdesc
	,rawfields.sic3d
	,rawfields.sic3ddesc
	,rawfields.Sic4
	,rawfields.sic4desc
	,rawfields.sic4a
	,rawfields.sic4adesc
	,rawfields.sic4b
	,rawfields.sic4bdesc
	,rawfields.sic4c
	,rawfields.sic4cdesc
	,rawfields.sic4d
	,rawfields.sic4ddesc
	,rawfields.Sic5
	,rawfields.sic5desc
	,rawfields.sic5a
	,rawfields.sic5adesc
	,rawfields.sic5b
	,rawfields.sic5bdesc
	,rawfields.sic5c
	,rawfields.sic5cdesc
	,rawfields.sic5d
	,rawfields.sic5ddesc
	,rawfields.Sic6
	,rawfields.sic6desc
	,rawfields.sic6a
	,rawfields.sic6adesc
	,rawfields.sic6b
	,rawfields.sic6bdesc
	,rawfields.sic6c
	,rawfields.sic6cdesc
	,rawfields.sic6d
	,rawfields.sic6ddesc
	,rawfields.industry_group
	,rawfields.YEAR_STARTED
	,rawfields.date_of_incorporation
	,rawfields.state_of_incorporation_abbr
	,rawfields.annual_sales_volume_sign
	,rawfields.annual_sales_volume
	,rawfields.annual_sales_code
	,rawfields.employees_here_sign
	,rawfields.employees_here
	,rawfields.employees_total_sign
	,rawfields.employees_total
	,rawfields.employees_here_code
	,rawfields.internal_use
	,rawfields.annual_sales_revision_date
	,rawfields.net_worth_sign
	,rawfields.net_worth
	,rawfields.trend_sales_sign
	,rawfields.trend_sales
	,rawfields.trend_employment_total_sign
	,rawfields.trend_employment_total
	,rawfields.base_sales_sign
	,rawfields.base_sales
	,rawfields.base_employment_total_sign
	,rawfields.base_employment_total
	,rawfields.percentage_sales_growth_sign
	,rawfields.percentage_sales_growth
	,rawfields.percentage_employment_growth_sign
	,rawfields.percentage_employment_growth
	,rawfields.square_footage
	,rawfields.sals_territory
	,rawfields.owns_rents
	,rawfields.number_of_accounts
	,rawfields.bank_duns_number
	,rawfields.bank_name
	,rawfields.accounting_firm_name
	,rawfields.small_business_indicator
	,rawfields.minority_owned
	,rawfields.cottage_indicator
	,rawfields.foreign_owned
	,rawfields.manufacturing_here_indicator
	,rawfields.public_indicator
	,rawfields.importer_exporter_indicator
	,rawfields.structure_type
	,rawfields.type_of_establishment
	,rawfields.parent_duns_number
	,rawfields.ultimate_duns_number
	,rawfields.headquarters_duns_number
	,rawfields.parent_company_name
	,rawfields.ultimate_company_name
	,rawfields.dias_code
	,rawfields.hierarchy_code
	,rawfields.ultimate_indicator
	,rawfields.internal_use1
	,rawfields.internal_use2
	,rawfields.internal_use3
	,rawfields.hot_list_new_indicator
	,rawfields.hot_list_ownership_change_indicator
	,rawfields.hot_list_ceo_change_indicator
	,rawfields.hot_list_company_name_change_ind
	,rawfields.hot_list_address_change_indicator
	,rawfields.hot_list_telephone_change_indicator
	,rawfields.hot_list_new_change_date
	,rawfields.hot_list_ownership_change_date
	,rawfields.hot_list_ceo_change_date
	,rawfields.hot_list_company_name_chg_date
	,rawfields.hot_list_address_change_date
	,rawfields.hot_list_telephone_change_date
	,local
	);
		AllRecs_rollup := rollup(AllRecs_Sort
			,			left.rawfields.duns_number = right.rawfields.duns_number 
				AND left.rawfields.Business_Name = right.rawfields.Business_Name 
				AND left.rawfields.trade_style = right.rawfields.trade_style 
				AND left.rawfields.street = right.rawfields.street 
				AND left.rawfields.city = right.rawfields.city 
				AND left.rawfields.state = right.rawfields.state 
				AND left.rawfields.zip_code = right.rawfields.zip_code 
				AND left.rawfields.mail_address = right.rawfields.mail_address 
				AND left.rawfields.Mail_City = right.rawfields.Mail_City 
				AND left.rawfields.Mail_State = right.rawfields.Mail_State 
				AND left.rawfields.Mail_Zip_Code = right.rawfields.Mail_Zip_Code 
				AND left.rawfields.telephone_number = right.rawfields.telephone_number 
				AND left.rawfields.county_name = right.rawfields.county_name 
				AND left.rawfields.msa_code = right.rawfields.msa_code 
				AND left.rawfields.msa_name = right.rawfields.msa_name 
				AND left.rawfields.line_of_business_description = right.rawfields.line_of_business_description 
				AND left.rawfields.Sic1 = right.rawfields.Sic1 
				AND left.rawfields.sic1desc = right.rawfields.sic1desc 
				AND left.rawfields.sic1a = right.rawfields.sic1a 
				AND left.rawfields.sic1adesc = right.rawfields.sic1adesc 
				AND left.rawfields.sic1b = right.rawfields.sic1b 
				AND left.rawfields.sic1bdesc = right.rawfields.sic1bdesc 
				AND left.rawfields.sic1c = right.rawfields.sic1c 
				AND left.rawfields.sic1cdesc = right.rawfields.sic1cdesc 
				AND left.rawfields.sic1d = right.rawfields.sic1d 
				AND left.rawfields.sic1ddesc = right.rawfields.sic1ddesc 
				AND left.rawfields.Sic2 = right.rawfields.Sic2 
				AND left.rawfields.sic2desc = right.rawfields.sic2desc 
				AND left.rawfields.sic2a = right.rawfields.sic2a 
				AND left.rawfields.sic2adesc = right.rawfields.sic2adesc 
				AND left.rawfields.sic2b = right.rawfields.sic2b 
				AND left.rawfields.sic2bdesc = right.rawfields.sic2bdesc 
				AND left.rawfields.sic2c = right.rawfields.sic2c 
				AND left.rawfields.sic2cdesc = right.rawfields.sic2cdesc 
				AND left.rawfields.sic2d = right.rawfields.sic2d 
				AND left.rawfields.sic2ddesc = right.rawfields.sic2ddesc 
				AND left.rawfields.Sic3 = right.rawfields.Sic3 
				AND left.rawfields.sic3desc = right.rawfields.sic3desc 
				AND left.rawfields.sic3a = right.rawfields.sic3a 
				AND left.rawfields.sic3adesc = right.rawfields.sic3adesc 
				AND left.rawfields.sic3b = right.rawfields.sic3b 
				AND left.rawfields.sic3bdesc = right.rawfields.sic3bdesc 
				AND left.rawfields.sic3c = right.rawfields.sic3c 
				AND left.rawfields.sic3cdesc = right.rawfields.sic3cdesc 
				AND left.rawfields.sic3d = right.rawfields.sic3d 
				AND left.rawfields.sic3ddesc = right.rawfields.sic3ddesc 
				AND left.rawfields.Sic4 = right.rawfields.Sic4 
				AND left.rawfields.sic4desc = right.rawfields.sic4desc 
				AND left.rawfields.sic4a = right.rawfields.sic4a 
				AND left.rawfields.sic4adesc = right.rawfields.sic4adesc 
				AND left.rawfields.sic4b = right.rawfields.sic4b 
				AND left.rawfields.sic4bdesc = right.rawfields.sic4bdesc 
				AND left.rawfields.sic4c = right.rawfields.sic4c 
				AND left.rawfields.sic4cdesc = right.rawfields.sic4cdesc 
				AND left.rawfields.sic4d = right.rawfields.sic4d 
				AND left.rawfields.sic4ddesc = right.rawfields.sic4ddesc 
				AND left.rawfields.Sic5 = right.rawfields.Sic5 
				AND left.rawfields.sic5desc = right.rawfields.sic5desc 
				AND left.rawfields.sic5a = right.rawfields.sic5a 
				AND left.rawfields.sic5adesc = right.rawfields.sic5adesc 
				AND left.rawfields.sic5b = right.rawfields.sic5b 
				AND left.rawfields.sic5bdesc = right.rawfields.sic5bdesc 
				AND left.rawfields.sic5c = right.rawfields.sic5c 
				AND left.rawfields.sic5cdesc = right.rawfields.sic5cdesc 
				AND left.rawfields.sic5d = right.rawfields.sic5d 
				AND left.rawfields.sic5ddesc = right.rawfields.sic5ddesc 
				AND left.rawfields.Sic6 = right.rawfields.Sic6 
				AND left.rawfields.sic6desc = right.rawfields.sic6desc 
				AND left.rawfields.sic6a = right.rawfields.sic6a 
				AND left.rawfields.sic6adesc = right.rawfields.sic6adesc 
				AND left.rawfields.sic6b = right.rawfields.sic6b 
				AND left.rawfields.sic6bdesc = right.rawfields.sic6bdesc 
				AND left.rawfields.sic6c = right.rawfields.sic6c 
				AND left.rawfields.sic6cdesc = right.rawfields.sic6cdesc 
				AND left.rawfields.sic6d = right.rawfields.sic6d 
				AND left.rawfields.sic6ddesc = right.rawfields.sic6ddesc 
				AND left.rawfields.industry_group = right.rawfields.industry_group 
				AND left.rawfields.YEAR_STARTED = right.rawfields.YEAR_STARTED 
				AND left.rawfields.date_of_incorporation = right.rawfields.date_of_incorporation 
				AND left.rawfields.state_of_incorporation_abbr = right.rawfields.state_of_incorporation_abbr 
				AND left.rawfields.annual_sales_volume_sign = right.rawfields.annual_sales_volume_sign 
				AND left.rawfields.annual_sales_volume = right.rawfields.annual_sales_volume 
				AND left.rawfields.annual_sales_code = right.rawfields.annual_sales_code 
				AND left.rawfields.employees_here_sign = right.rawfields.employees_here_sign 
				AND left.rawfields.employees_here = right.rawfields.employees_here 
				AND left.rawfields.employees_total_sign = right.rawfields.employees_total_sign 
				AND left.rawfields.employees_total = right.rawfields.employees_total 
				AND left.rawfields.employees_here_code = right.rawfields.employees_here_code 
				AND left.rawfields.internal_use = right.rawfields.internal_use 
				AND left.rawfields.annual_sales_revision_date = right.rawfields.annual_sales_revision_date 
				AND left.rawfields.net_worth_sign = right.rawfields.net_worth_sign 
				AND left.rawfields.net_worth = right.rawfields.net_worth 
				AND left.rawfields.trend_sales_sign = right.rawfields.trend_sales_sign 
				AND left.rawfields.trend_sales = right.rawfields.trend_sales 
				AND left.rawfields.trend_employment_total_sign = right.rawfields.trend_employment_total_sign 
				AND left.rawfields.trend_employment_total = right.rawfields.trend_employment_total 
				AND left.rawfields.base_sales_sign = right.rawfields.base_sales_sign 
				AND left.rawfields.base_sales = right.rawfields.base_sales 
				AND left.rawfields.base_employment_total_sign = right.rawfields.base_employment_total_sign 
				AND left.rawfields.base_employment_total = right.rawfields.base_employment_total 
				AND left.rawfields.percentage_sales_growth_sign = right.rawfields.percentage_sales_growth_sign 
				AND left.rawfields.percentage_sales_growth = right.rawfields.percentage_sales_growth 
				AND left.rawfields.percentage_employment_growth_sign = right.rawfields.percentage_employment_growth_sign 
				AND left.rawfields.percentage_employment_growth = right.rawfields.percentage_employment_growth 
				AND left.rawfields.square_footage = right.rawfields.square_footage 
				AND left.rawfields.sals_territory = right.rawfields.sals_territory 
				AND left.rawfields.owns_rents = right.rawfields.owns_rents 
				AND left.rawfields.number_of_accounts = right.rawfields.number_of_accounts 
				AND left.rawfields.bank_duns_number = right.rawfields.bank_duns_number 
				AND left.rawfields.bank_name = right.rawfields.bank_name 
				AND left.rawfields.accounting_firm_name = right.rawfields.accounting_firm_name 
				AND left.rawfields.small_business_indicator = right.rawfields.small_business_indicator 
				AND left.rawfields.minority_owned = right.rawfields.minority_owned 
				AND left.rawfields.cottage_indicator = right.rawfields.cottage_indicator 
				AND left.rawfields.foreign_owned = right.rawfields.foreign_owned 
				AND left.rawfields.manufacturing_here_indicator = right.rawfields.manufacturing_here_indicator 
				AND left.rawfields.public_indicator = right.rawfields.public_indicator 
				AND left.rawfields.importer_exporter_indicator = right.rawfields.importer_exporter_indicator 
				AND left.rawfields.structure_type = right.rawfields.structure_type 
				AND left.rawfields.type_of_establishment = right.rawfields.type_of_establishment 
				AND left.rawfields.parent_duns_number = right.rawfields.parent_duns_number 
				AND left.rawfields.ultimate_duns_number = right.rawfields.ultimate_duns_number 
				AND left.rawfields.headquarters_duns_number = right.rawfields.headquarters_duns_number 
				AND left.rawfields.parent_company_name = right.rawfields.parent_company_name 
				AND left.rawfields.ultimate_company_name = right.rawfields.ultimate_company_name 
				AND left.rawfields.dias_code = right.rawfields.dias_code 
				AND left.rawfields.hierarchy_code = right.rawfields.hierarchy_code 
				AND left.rawfields.ultimate_indicator = right.rawfields.ultimate_indicator 
				AND left.rawfields.internal_use1 = right.rawfields.internal_use1 
				AND left.rawfields.internal_use2 = right.rawfields.internal_use2 
				AND left.rawfields.internal_use3 = right.rawfields.internal_use3 
				AND left.rawfields.hot_list_new_indicator = right.rawfields.hot_list_new_indicator 
				AND left.rawfields.hot_list_ownership_change_indicator = right.rawfields.hot_list_ownership_change_indicator 
				AND left.rawfields.hot_list_ceo_change_indicator = right.rawfields.hot_list_ceo_change_indicator 
				AND left.rawfields.hot_list_company_name_change_ind = right.rawfields.hot_list_company_name_change_ind 
				AND left.rawfields.hot_list_address_change_indicator = right.rawfields.hot_list_address_change_indicator 
				AND left.rawfields.hot_list_telephone_change_indicator = right.rawfields.hot_list_telephone_change_indicator 
				AND left.rawfields.hot_list_new_change_date = right.rawfields.hot_list_new_change_date 
				AND left.rawfields.hot_list_ownership_change_date = right.rawfields.hot_list_ownership_change_date 
				AND left.rawfields.hot_list_ceo_change_date = right.rawfields.hot_list_ceo_change_date 
				AND left.rawfields.hot_list_company_name_chg_date = right.rawfields.hot_list_company_name_chg_date 
				AND left.rawfields.hot_list_address_change_date = right.rawfields.hot_list_address_change_date 
				AND left.rawfields.hot_list_telephone_change_date = right.rawfields.hot_list_telephone_change_date

		,MergeData(left,right),local);
		return AllRecs_rollup;
	end;

	export maxdtvendorlastreported := max(FilesToIngest, date_vendor_last_reported) : stored('maxdtvendorlastreportedcompany');//what is date of latest update file

	export dFilesToIngest_latest	:= FilesToIngest(date_vendor_last_reported  = maxdtvendorlastreported);
	export dFilesToIngest_other		:= FilesToIngest(date_vendor_last_reported != maxdtvendorlastreported);

  export FilesToIngest0					:= project(dFilesToIngest_latest				,AddFlag(LEFT,RecordType.New));
  export Base0									:= project(Base + dFilesToIngest_other	,AddFlag(LEFT,RecordType.Old));
	
	export dFilesToIngest0				:= fRollup(FilesToIngest0		);
	export dBase0									:= fRollup(Base0						);
	
  export dFilesToIngest0_reflag	:= project(dFilesToIngest0		,AddFlag2(LEFT,RecordType.New));
  export dBase0_reflag					:= project(dBase0							,AddFlag2(LEFT,RecordType.Old));

  export AllRecs_join := JOIN(dBase0_reflag,dFilesToIngest0_reflag
		,			left.rawfields.duns_number = right.rawfields.duns_number 
			AND left.rawfields.Business_Name = right.rawfields.Business_Name 
			AND left.rawfields.trade_style = right.rawfields.trade_style 
			AND left.rawfields.street = right.rawfields.street 
			AND left.rawfields.city = right.rawfields.city 
			AND left.rawfields.state = right.rawfields.state 
			AND left.rawfields.zip_code = right.rawfields.zip_code 
			AND left.rawfields.mail_address = right.rawfields.mail_address 
			AND left.rawfields.Mail_City = right.rawfields.Mail_City 
			AND left.rawfields.Mail_State = right.rawfields.Mail_State 
			AND left.rawfields.Mail_Zip_Code = right.rawfields.Mail_Zip_Code 
			AND left.rawfields.telephone_number = right.rawfields.telephone_number 
			AND left.rawfields.county_name = right.rawfields.county_name 
			AND left.rawfields.msa_code = right.rawfields.msa_code 
			AND left.rawfields.msa_name = right.rawfields.msa_name 
			AND left.rawfields.line_of_business_description = right.rawfields.line_of_business_description 
			AND left.rawfields.Sic1 = right.rawfields.Sic1 
			AND left.rawfields.sic1desc = right.rawfields.sic1desc 
			AND left.rawfields.sic1a = right.rawfields.sic1a 
			AND left.rawfields.sic1adesc = right.rawfields.sic1adesc 
			AND left.rawfields.sic1b = right.rawfields.sic1b 
			AND left.rawfields.sic1bdesc = right.rawfields.sic1bdesc 
			AND left.rawfields.sic1c = right.rawfields.sic1c 
			AND left.rawfields.sic1cdesc = right.rawfields.sic1cdesc 
			AND left.rawfields.sic1d = right.rawfields.sic1d 
			AND left.rawfields.sic1ddesc = right.rawfields.sic1ddesc 
			AND left.rawfields.Sic2 = right.rawfields.Sic2 
			AND left.rawfields.sic2desc = right.rawfields.sic2desc 
			AND left.rawfields.sic2a = right.rawfields.sic2a 
			AND left.rawfields.sic2adesc = right.rawfields.sic2adesc 
			AND left.rawfields.sic2b = right.rawfields.sic2b 
			AND left.rawfields.sic2bdesc = right.rawfields.sic2bdesc 
			AND left.rawfields.sic2c = right.rawfields.sic2c 
			AND left.rawfields.sic2cdesc = right.rawfields.sic2cdesc 
			AND left.rawfields.sic2d = right.rawfields.sic2d 
			AND left.rawfields.sic2ddesc = right.rawfields.sic2ddesc 
			AND left.rawfields.Sic3 = right.rawfields.Sic3 
			AND left.rawfields.sic3desc = right.rawfields.sic3desc 
			AND left.rawfields.sic3a = right.rawfields.sic3a 
			AND left.rawfields.sic3adesc = right.rawfields.sic3adesc 
			AND left.rawfields.sic3b = right.rawfields.sic3b 
			AND left.rawfields.sic3bdesc = right.rawfields.sic3bdesc 
			AND left.rawfields.sic3c = right.rawfields.sic3c 
			AND left.rawfields.sic3cdesc = right.rawfields.sic3cdesc 
			AND left.rawfields.sic3d = right.rawfields.sic3d 
			AND left.rawfields.sic3ddesc = right.rawfields.sic3ddesc 
			AND left.rawfields.Sic4 = right.rawfields.Sic4 
			AND left.rawfields.sic4desc = right.rawfields.sic4desc 
			AND left.rawfields.sic4a = right.rawfields.sic4a 
			AND left.rawfields.sic4adesc = right.rawfields.sic4adesc 
			AND left.rawfields.sic4b = right.rawfields.sic4b 
			AND left.rawfields.sic4bdesc = right.rawfields.sic4bdesc 
			AND left.rawfields.sic4c = right.rawfields.sic4c 
			AND left.rawfields.sic4cdesc = right.rawfields.sic4cdesc 
			AND left.rawfields.sic4d = right.rawfields.sic4d 
			AND left.rawfields.sic4ddesc = right.rawfields.sic4ddesc 
			AND left.rawfields.Sic5 = right.rawfields.Sic5 
			AND left.rawfields.sic5desc = right.rawfields.sic5desc 
			AND left.rawfields.sic5a = right.rawfields.sic5a 
			AND left.rawfields.sic5adesc = right.rawfields.sic5adesc 
			AND left.rawfields.sic5b = right.rawfields.sic5b 
			AND left.rawfields.sic5bdesc = right.rawfields.sic5bdesc 
			AND left.rawfields.sic5c = right.rawfields.sic5c 
			AND left.rawfields.sic5cdesc = right.rawfields.sic5cdesc 
			AND left.rawfields.sic5d = right.rawfields.sic5d 
			AND left.rawfields.sic5ddesc = right.rawfields.sic5ddesc 
			AND left.rawfields.Sic6 = right.rawfields.Sic6 
			AND left.rawfields.sic6desc = right.rawfields.sic6desc 
			AND left.rawfields.sic6a = right.rawfields.sic6a 
			AND left.rawfields.sic6adesc = right.rawfields.sic6adesc 
			AND left.rawfields.sic6b = right.rawfields.sic6b 
			AND left.rawfields.sic6bdesc = right.rawfields.sic6bdesc 
			AND left.rawfields.sic6c = right.rawfields.sic6c 
			AND left.rawfields.sic6cdesc = right.rawfields.sic6cdesc 
			AND left.rawfields.sic6d = right.rawfields.sic6d 
			AND left.rawfields.sic6ddesc = right.rawfields.sic6ddesc 
			AND left.rawfields.industry_group = right.rawfields.industry_group 
			AND left.rawfields.YEAR_STARTED = right.rawfields.YEAR_STARTED 
			AND left.rawfields.date_of_incorporation = right.rawfields.date_of_incorporation 
			AND left.rawfields.state_of_incorporation_abbr = right.rawfields.state_of_incorporation_abbr 
			AND left.rawfields.annual_sales_volume_sign = right.rawfields.annual_sales_volume_sign 
			AND left.rawfields.annual_sales_volume = right.rawfields.annual_sales_volume 
			AND left.rawfields.annual_sales_code = right.rawfields.annual_sales_code 
			AND left.rawfields.employees_here_sign = right.rawfields.employees_here_sign 
			AND left.rawfields.employees_here = right.rawfields.employees_here 
			AND left.rawfields.employees_total_sign = right.rawfields.employees_total_sign 
			AND left.rawfields.employees_total = right.rawfields.employees_total 
			AND left.rawfields.employees_here_code = right.rawfields.employees_here_code 
			AND left.rawfields.internal_use = right.rawfields.internal_use 
			AND left.rawfields.annual_sales_revision_date = right.rawfields.annual_sales_revision_date 
			AND left.rawfields.net_worth_sign = right.rawfields.net_worth_sign 
			AND left.rawfields.net_worth = right.rawfields.net_worth 
			AND left.rawfields.trend_sales_sign = right.rawfields.trend_sales_sign 
			AND left.rawfields.trend_sales = right.rawfields.trend_sales 
			AND left.rawfields.trend_employment_total_sign = right.rawfields.trend_employment_total_sign 
			AND left.rawfields.trend_employment_total = right.rawfields.trend_employment_total 
			AND left.rawfields.base_sales_sign = right.rawfields.base_sales_sign 
			AND left.rawfields.base_sales = right.rawfields.base_sales 
			AND left.rawfields.base_employment_total_sign = right.rawfields.base_employment_total_sign 
			AND left.rawfields.base_employment_total = right.rawfields.base_employment_total 
			AND left.rawfields.percentage_sales_growth_sign = right.rawfields.percentage_sales_growth_sign 
			AND left.rawfields.percentage_sales_growth = right.rawfields.percentage_sales_growth 
			AND left.rawfields.percentage_employment_growth_sign = right.rawfields.percentage_employment_growth_sign 
			AND left.rawfields.percentage_employment_growth = right.rawfields.percentage_employment_growth 
			AND left.rawfields.square_footage = right.rawfields.square_footage 
			AND left.rawfields.sals_territory = right.rawfields.sals_territory 
			AND left.rawfields.owns_rents = right.rawfields.owns_rents 
			AND left.rawfields.number_of_accounts = right.rawfields.number_of_accounts 
			AND left.rawfields.bank_duns_number = right.rawfields.bank_duns_number 
			AND left.rawfields.bank_name = right.rawfields.bank_name 
			AND left.rawfields.accounting_firm_name = right.rawfields.accounting_firm_name 
			AND left.rawfields.small_business_indicator = right.rawfields.small_business_indicator 
			AND left.rawfields.minority_owned = right.rawfields.minority_owned 
			AND left.rawfields.cottage_indicator = right.rawfields.cottage_indicator 
			AND left.rawfields.foreign_owned = right.rawfields.foreign_owned 
			AND left.rawfields.manufacturing_here_indicator = right.rawfields.manufacturing_here_indicator 
			AND left.rawfields.public_indicator = right.rawfields.public_indicator 
			AND left.rawfields.importer_exporter_indicator = right.rawfields.importer_exporter_indicator 
			AND left.rawfields.structure_type = right.rawfields.structure_type 
			AND left.rawfields.type_of_establishment = right.rawfields.type_of_establishment 
			AND left.rawfields.parent_duns_number = right.rawfields.parent_duns_number 
			AND left.rawfields.ultimate_duns_number = right.rawfields.ultimate_duns_number 
			AND left.rawfields.headquarters_duns_number = right.rawfields.headquarters_duns_number 
			AND left.rawfields.parent_company_name = right.rawfields.parent_company_name 
			AND left.rawfields.ultimate_company_name = right.rawfields.ultimate_company_name 
			AND left.rawfields.dias_code = right.rawfields.dias_code 
			AND left.rawfields.hierarchy_code = right.rawfields.hierarchy_code 
			AND left.rawfields.ultimate_indicator = right.rawfields.ultimate_indicator 
			AND left.rawfields.internal_use1 = right.rawfields.internal_use1 
			AND left.rawfields.internal_use2 = right.rawfields.internal_use2 
			AND left.rawfields.internal_use3 = right.rawfields.internal_use3 
			AND left.rawfields.hot_list_new_indicator = right.rawfields.hot_list_new_indicator 
			AND left.rawfields.hot_list_ownership_change_indicator = right.rawfields.hot_list_ownership_change_indicator 
			AND left.rawfields.hot_list_ceo_change_indicator = right.rawfields.hot_list_ceo_change_indicator 
			AND left.rawfields.hot_list_company_name_change_ind = right.rawfields.hot_list_company_name_change_ind 
			AND left.rawfields.hot_list_address_change_indicator = right.rawfields.hot_list_address_change_indicator 
			AND left.rawfields.hot_list_telephone_change_indicator = right.rawfields.hot_list_telephone_change_indicator 
			AND left.rawfields.hot_list_new_change_date = right.rawfields.hot_list_new_change_date 
			AND left.rawfields.hot_list_ownership_change_date = right.rawfields.hot_list_ownership_change_date 
			AND left.rawfields.hot_list_ceo_change_date = right.rawfields.hot_list_ceo_change_date 
			AND left.rawfields.hot_list_company_name_chg_date = right.rawfields.hot_list_company_name_chg_date 
			AND left.rawfields.hot_list_address_change_date = right.rawfields.hot_list_address_change_date 
			AND left.rawfields.hot_list_telephone_change_date = right.rawfields.hot_list_telephone_change_date

	,MergeData(left,right),full outer,hash);
	
	basefilexists := exists(Base0);
	
	AllRecs0 := if(basefilexists	,AllRecs_join,dFilesToIngest0_reflag);
	
//Now need to update 'rid' numbers on new records
//Base upon ut.Mac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New or rid = 0);
  ORe := AllRecs0(not(__Tpe=RecordType.New or rid = 0));
  PrevBase := MAX(ORe,rid);
  WithRT AddNewRid(WithRT le, WithRT ri) := transform
    SELF.rid := IF ( le.rid=0, PrevBase+1+thorlib.node(), le.rid+thorlib.nodes() );
//    SELF.BDID := SELF.rid; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NR1 := ITERATE(NR,AddNewRid(left,right),local);
  shared AllRecs := ORe+NR1  ;
  StatsRec := RECORD
    STRING Type := RTToText(AllRecs.__Tpe);
    unsigned Cnt := COUNT(GROUP);
  end;
  export UpdateStats := table(AllRecs,StatsRec,__Tpe,FEW);
  shared Layouts.base.CompaniesForBIP2 DeTag(AllRecs le) := TRANSFORM
	  self.record_type := le.__Tpe;
    SELF := le;
  END;
  export NewRecords := project(AllRecs(__Tpe=RecordType.New),DeTag(left));
  export OldRecords := project(AllRecs(__Tpe=RecordType.Old),DeTag(left));
  export AllRecords := AllRecs;
  export AllRecords_NoTag := project(AllRecords,DeTag(left)) : persist(pPersistname); // Records in 'pure' format

	export countbase												:= count(base										);
  export countFilesToIngest1							:= count(FilesToIngest1					);
	export countFilesToIngest							:= count(FilesToIngest					);
	export countdFilesToIngest_latest			:= count(dFilesToIngest_latest	);
	export countdFilesToIngest_other				:= count(dFilesToIngest_other		);
	export countFilesToIngest0							:= count(FilesToIngest0					);
	export countBase0											:= count(Base0									);
	export countdFilesToIngest0						:= count(dFilesToIngest0				);
	export countdBase0											:= count(dBase0									);
	export countdFilesToIngest0_reflag			:= count(dFilesToIngest0_reflag	);
	export countdBase0_reflag							:= count(dBase0_reflag					);
	export countAllRecs_join								:= count(AllRecs_join						);

	export base_table										:= table(base									, {string record_type := dnb_dmi.utilities.RTToText(record_type), unsigned8 cnt := count(group)}, record_type, few);
	export FilesToIngest1_table					:= table(FilesToIngest1				, {string record_type := dnb_dmi.utilities.RTToText(record_type), unsigned8 cnt := count(group)}, record_type, few);
	export FilesToIngest_table						:= table(FilesToIngest					, {string record_type := dnb_dmi.utilities.RTToText(record_type), unsigned8 cnt := count(group)}, record_type, few);
	export dFilesToIngest_latest_table 	:= table(dFilesToIngest_latest	, {string record_type := dnb_dmi.utilities.RTToText(record_type), unsigned8 cnt := count(group)}, record_type, few);
	export dFilesToIngest_other_table 		:= table(dFilesToIngest_other	, {string record_type := dnb_dmi.utilities.RTToText(record_type), unsigned8 cnt := count(group)}, record_type, few);
	export FilesToIngest0_table					:= table(FilesToIngest0				, {string record_type := dnb_dmi.utilities.RTToText(__Tpe), unsigned8 cnt := count(group)}, __Tpe, few);
	export Base0_table										:= table(Base0									, {string record_type := dnb_dmi.utilities.RTToText(__Tpe), unsigned8 cnt := count(group)}, __Tpe, few);
	export dFilesToIngest0_table					:= table(dFilesToIngest0				, {string record_type := dnb_dmi.utilities.RTToText(__Tpe), unsigned8 cnt := count(group)}, __Tpe, few);
	export dBase0_table									:= table(dBase0								, {string record_type := dnb_dmi.utilities.RTToText(__Tpe), unsigned8 cnt := count(group)}, __Tpe, few);
	export dFilesToIngest0_reflag_table	:= table(dFilesToIngest0_reflag, {string record_type := dnb_dmi.utilities.RTToText(__Tpe), unsigned8 cnt := count(group)}, __Tpe, few);
	export dBase0_reflag_table						:= table(dBase0_reflag					, {string record_type := dnb_dmi.utilities.RTToText(__Tpe), unsigned8 cnt := count(group)}, __Tpe, few);
	export AllRecs_join_table 						:= table(AllRecs_join					, {string record_type := dnb_dmi.utilities.RTToText(__Tpe), unsigned8 cnt := count(group)}, __Tpe, few);

	export testing := parallel(
		 output(maxdtvendorlastreported	,named('maxdtvendorlastreported'))
		,output(countbase											,named('countbase'									))
		,output(countFilesToIngest1						,named('countFilesToIngest1'				))
		,output(countFilesToIngest						,named('countFilesToIngest'					))
		,output(countdFilesToIngest_latest		,named('countdFilesToIngest_latest'	))
		,output(countdFilesToIngest_other			,named('countdFilesToIngest_other'	))
		,output(countFilesToIngest0						,named('countFilesToIngest0'				))
		,output(countBase0										,named('countBase0'									))
		,output(countdFilesToIngest0					,named('countdFilesToIngest0'				))
		,output(countdBase0										,named('countdBase0'								))
		,output(countdFilesToIngest0_reflag		,named('countdFilesToIngest0_reflag'))
		,output(countdBase0_reflag						,named('countdBase0_reflag'					))
		,output(countAllRecs_join							,named('countAllRecs_join'					))

		,output(base_table											,named('base_table'																		))
		,output(FilesToIngest1_table						,named('FilesToIngest1_table'													))
		,output(FilesToIngest_table							,named('FilesToIngest_table'														))
		,output(dFilesToIngest_latest_table 		,named('dFilesToIngest_latest_table' 									))
		,output(dFilesToIngest_other_table 			,named('dFilesToIngest_other_table' 										))
		,output(FilesToIngest0_table						,named('FilesToIngest0_table'													))
		,output(Base0_table											,named('Base0_table'																		))
		,output(dFilesToIngest0_table						,named('dFilesToIngest0_table'													))
		,output(dBase0_table										,named('dBase0_table'																	))
		,output(dFilesToIngest0_reflag_table		,named('dFilesToIngest0_reflag_table'									))
		,output(dBase0_reflag_table							,named('dBase0_reflag_table'														))
		,output(AllRecs_join_table 							,named('AllRecs_join_table' 														))
	);

end;