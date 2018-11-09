rScraped := RECORD
                STRING Complex_Name;
                STRING Facility_Name;
                STRING Facility_address_Line_1;
                STRING Facility_Address_Line_2;
                STRING City;
                STRING State;
                STRING Zip;
                STRING Phone;
END;

scraped := DATASET('~thor_data400::in::aca::correctional_facilities_scraped',rScraped,CSV(HEADING(1)));


EXPORT File_New_ACA_In := scraped;