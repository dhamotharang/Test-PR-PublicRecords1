IMPORT STD, PublicRecords_KEL;
                                                                            
EXPORT DateSelector(InData,checkchildDatasets = FALSE, AppendNotPopulate = TRUE) := FUNCTIONMACRO
	// Load up the XML containing the record structure of the data that was passed in
	#EXPORTXML(records, RECORDOF(InData))
	
	// Append all possible date name combinations that we are aware of, set them if they exist using the SELF := LEFT, if they don't exist they get set to blank
    ArchiveFieldsRec := RECORD
		DATASET(RECORDOF(InData)) BaseData; // Temporarily throw the whole record/row into a small dataset to avoid it complaining about duplicate columns
		STRING date_first_seen;
		STRING dt_first_seen;
		STRING datefirstseen;

        /*
            Insert other date first seens
        */ 
		STRING vendordatefirstreported;
		STRING date_vendor_first_reported;
		STRING dt_vendor_first_reported;
        /*
            Insert other VendorDateFirstReported
        */ 
		STRING pub_date;
		STRING dt_first_seen_contact;
		STRING orig_filing_date;
		STRING corp_ra_dt_first_seen;
		STRING fcra_date;
		STRING dateofinquiry;
		STRING addr_dt_first_seen;
		STRING rel_dt_first_seen;
		STRING event_dt;
		STRING earliest_offense_date;
		STRING dt_first_seen_company_address;
		STRING form_plan_year_begin_date;
		STRING inspection_opening_date;
		STRING ActiveDate;
		STRING fares_mortgage_date;
		STRING dt_first_reported;
		/*
						Insert other random Dates
		*/
		STRING loaddate;
        /*
            Insert other LoadDates
        */ 
	END;
	
	// Need to track the list of date field names to look for when generating the PROJECT statement further down
	SetOfDateFieldNames := ['date_first_seen', 'dt_first_seen', 'datefirstseen', //date first seen
															'vendordatefirstreported','date_vendor_first_reported','dt_vendor_first_reported', //vendor dates
															'pub_date','dt_first_seen_contact','orig_filing_date','corp_ra_dt_first_seen', 'fcra_date','dateofinquiry','addr_dt_first_seen','rel_dt_first_seen','event_dt','earliest_offense_date','dt_first_seen_company_address','form_plan_year_begin_date','inspection_opening_date','ActiveDate','fares_mortgage_date','dt_first_reported',
															'loaddate']; // load dates
	
	cleanDate(STRING DateValue) := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateValue)[1];     

	// Wish wish to generate a PROJECT statement like this:
	// Dates := PROJECT(InData, TRANSFORM(ArchiveFieldsRec,
    //  SELF.BaseData := DATASET(LEFT);
	//  // These are the date columns found within this dataset, map them and typecast to STRING
    //  SELF.date_first_seen := (STRING)LEFT.date_first_seen;
	//	SELF.dt_first_seen := (STRING)LEFT.dt_first_seen;
    //  SELF := []));
	// The following #FOR loop determines what date fields need to be mapped in the first place
	#DECLARE(eclProjectCode) // Track the TRANSFORM code
	#DECLARE(recLevel); // Track the depth of the attribute within the record

	#SET(recLevel, 0); // Start us out at the root of the RECORD structure
	#SET(eclProjectCode, ''); // Start with no date fields to cast in the PROJECT statement
	#IF (checkchildDatasets = TRUE)
		#FOR(records)
			#FOR(Field)
				#IF(%@isDataset%=0 AND %recLevel% = 0) // Not a child dataset, normal field at the root of the record layout
					#IF(%'{@name}'% IN SetOfDateFieldNames) // We have a date field we care to keep!
						#APPEND(eclProjectCode, 'SELF.' + %'{@name}'% + ' := (STRING)LEFT.' + %'{@name}'% + ';'); // SELF.FieldName := (STRING)LEFT.FieldName;
					#END
				#ELSEIF(%isDataset%=1) // We have a child dataset, potentially wish to step in to determine if there is a date field to keep - this functionmacro doesn't currently support child dataset date mapping
					// We are inside the child dataset
					#SET(recLevel, %recLevel% + 1);
				#ELSEIF(%{@isEnd}% = 1)
					// We are at the end of the Child Dataset RECORD structure, popping back up to top level
					#SET(recLevel, %recLevel% - 1);
				#END
			#END
		#END
	#ELSE //No Child datasets exist. Pass in false
		#FOR(records)
					#FOR(Field)
							#IF(%'{@name}'% IN SetOfDateFieldNames) // We have a date field we care to keep!
											#APPEND(eclProjectCode, 'SELF.' + %'{@name}'% + ' := (STRING)LEFT.' + %'{@name}'% + ';'); // SELF.FieldName := (STRING)LEFT.FieldName;
							#END
					#END
			#END
		#END
	Dates := PROJECT(InData, TRANSFORM(ArchiveFieldsRec,
		SELF.BaseData := DATASET(LEFT);
		#EXPAND(%'eclProjectCode'%)
		SELF := LEFT;
		SELF := []));
		
	 #IF(AppendNotPopulate)
		AppendedRecord := RECORD
			RECORDOF(Dates.BaseData); 
			STRING Archive_Date;
		END;	
	OutDataset := PROJECT(Dates, TRANSFORM(AppendedRecord,
		SELF.Archive_Date := 
		MAP(LEFT.date_first_seen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.date_first_seen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.date_first_seen).ValidPortion_01,
				LEFT.dt_first_seen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dt_first_seen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dt_first_seen).ValidPortion_01,		
				LEFT.datefirstseen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.datefirstseen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.datefirstseen).ValidPortion_01,
			//check other date first seens
			
			LEFT.VendorDateFirstReported NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.VendorDateFirstReported).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.VendorDateFirstReported).ValidPortion_01,
			LEFT.date_vendor_first_reported NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.date_vendor_first_reported).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.date_vendor_first_reported).ValidPortion_01,
			LEFT.dt_vendor_first_reported NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dt_vendor_first_reported).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dt_vendor_first_reported).ValidPortion_01,						
			//check other Vendor dates
			LEFT.pub_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.pub_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.pub_date).ValidPortion_01,						
			LEFT.dt_first_seen_contact NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dt_first_seen_contact).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dt_first_seen_contact).ValidPortion_01,						
			LEFT.orig_filing_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.orig_filing_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.orig_filing_date).ValidPortion_01,						
			LEFT.corp_ra_dt_first_seen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.corp_ra_dt_first_seen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.corp_ra_dt_first_seen).ValidPortion_01,						
			LEFT.fcra_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.fcra_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.fcra_date).ValidPortion_01,						
			LEFT.dateofinquiry NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dateofinquiry).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dateofinquiry).ValidPortion_01,						
			LEFT.addr_dt_first_seen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.addr_dt_first_seen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.addr_dt_first_seen).ValidPortion_01,						
			LEFT.rel_dt_first_seen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.rel_dt_first_seen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.rel_dt_first_seen).ValidPortion_01,						
			LEFT.event_dt NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.event_dt).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.event_dt).ValidPortion_01,						
			LEFT.earliest_offense_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.earliest_offense_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.earliest_offense_date).ValidPortion_01,						
			LEFT.dt_first_seen_company_address NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dt_first_seen_company_address).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dt_first_seen_company_address).ValidPortion_01,						
			LEFT.form_plan_year_begin_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.form_plan_year_begin_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.form_plan_year_begin_date).ValidPortion_01,						
			LEFT.inspection_opening_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.inspection_opening_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.inspection_opening_date).ValidPortion_01,						
			LEFT.ActiveDate NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.ActiveDate).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.ActiveDate).ValidPortion_01,						
			LEFT.fares_mortgage_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.fares_mortgage_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.fares_mortgage_date).ValidPortion_01,						
			LEFT.dt_first_reported NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dt_first_reported).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dt_first_reported).ValidPortion_01,						
			//Check other random dates
			LEFT.LoadDate NOT IN ['', '0'] AND cleanDate(LEFT.LoadDate).DateValid => (STRING)cleanDate(LEFT.LoadDate).ValidPortion_01,
			//check other load dates
			
			'');
		SELF := LEFT.BaseData[1]));
		#ELSE
		PopulatedRecord := RECORDOF(Dates.BaseData);
		OutDataset := PROJECT(Dates, TRANSFORM(PopulatedRecord,    
		SELF.Archive_Date := 
		MAP(LEFT.date_first_seen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.date_first_seen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.date_first_seen).ValidPortion_01,
			LEFT.dt_first_seen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dt_first_seen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dt_first_seen).ValidPortion_01,
			LEFT.datefirstseen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.datefirstseen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.datefirstseen).ValidPortion_01,			
			//check other date first seens
			
			LEFT.VendorDateFirstReported NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.VendorDateFirstReported).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.VendorDateFirstReported).ValidPortion_01,
			LEFT.date_vendor_first_reported NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.date_vendor_first_reported).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.date_vendor_first_reported).ValidPortion_01,
			LEFT.dt_vendor_first_reported NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dt_vendor_first_reported).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dt_vendor_first_reported).ValidPortion_01,						
			//check other Vendor dates
			LEFT.pub_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.pub_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.pub_date).ValidPortion_01,						
			LEFT.dt_first_seen_contact NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dt_first_seen_contact).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dt_first_seen_contact).ValidPortion_01,						
			LEFT.orig_filing_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.orig_filing_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.orig_filing_date).ValidPortion_01,						
			LEFT.corp_ra_dt_first_seen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.corp_ra_dt_first_seen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.corp_ra_dt_first_seen).ValidPortion_01,						
			LEFT.fcra_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.fcra_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.fcra_date).ValidPortion_01,						
			LEFT.dateofinquiry NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dateofinquiry).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dateofinquiry).ValidPortion_01,						
			LEFT.addr_dt_first_seen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.addr_dt_first_seen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.addr_dt_first_seen).ValidPortion_01,						
			LEFT.rel_dt_first_seen NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.rel_dt_first_seen).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.rel_dt_first_seen).ValidPortion_01,						
			LEFT.event_dt NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.event_dt).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.event_dt).ValidPortion_01,						
			LEFT.earliest_offense_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.earliest_offense_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.earliest_offense_date).ValidPortion_01,						
			LEFT.dt_first_seen_company_address NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dt_first_seen_company_address).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dt_first_seen_company_address).ValidPortion_01,						
			LEFT.form_plan_year_begin_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.form_plan_year_begin_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.form_plan_year_begin_date).ValidPortion_01,						
			LEFT.inspection_opening_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.inspection_opening_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.inspection_opening_date).ValidPortion_01,						
			LEFT.ActiveDate NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.ActiveDate).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.ActiveDate).ValidPortion_01,						
			LEFT.fares_mortgage_date NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.fares_mortgage_date).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.fares_mortgage_date).ValidPortion_01,//Check other random dates
			LEFT.dt_first_reported NOT IN ['', '0'] AND cleanDate((STRING)cleanDate(LEFT.dt_first_reported).ValidPortion_01).DateValid => (STRING)cleanDate(LEFT.dt_first_reported).ValidPortion_01,//Check other random dates
			
			LEFT.LoadDate NOT IN ['', '0'] AND cleanDate(LEFT.LoadDate).DateValid => (STRING)cleanDate(LEFT.LoadDate).ValidPortion_01,
			//check other load dates
			
			'');
		SELF := LEFT.BaseData[1]));
    #END
  
	RETURN OutDataset;
	
ENDMACRO;