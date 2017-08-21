export ReportCoverage (string3 sourcegroup = 'all') := function

state :=  ['US', 'AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AA','AE','AE','AE','AP'];

//FBN Base File with Filtered Dates.
fbnBaseFile_filtered := fbnv2.File_FBN_Business_Base(tmsid[1..3] = 'sourcegroup' and filing_date between 19000000 and (unsigned4)stringlib.GetDateYYYYMMDD());
fbnBaseFile_all := fbnv2.File_FBN_Business_Base(filing_date between 19000000 and (unsigned4)stringlib.GetDateYYYYMMDD());

fbnBaseFile := if(sourcegroup <> 'all'
					, fbnBaseFile_filtered
					, fbnBaseFile_all);

//Layout to populate clean state and county fields.
layout := record 
	fbnv2.Layout_Common.Business;
	string8 process_date := '' ;
	string3 source_file := '';
	string clean_state := '';
	string clean_county := '';
end;

//Populate clean_state and clean_county from the FIPS Code lookup.
layout trecs(fbnBaseFile L, FBNV2.FIPS_Codes R) := transform
self.process_date := if(length((string)l.filing_date)=8,(string)L.filing_date,''); 
self.source_file := L.tmsid[1..3];
self.clean_state := map(L.fips_state= R.fips_state and L.fips_county= R.fips_county =>
						R.state ,'');
self.clean_county := map(L.fips_state= R.fips_state and L.fips_county= R.fips_county =>
						R.county_name ,'');
self := L;
end;


//Join with FIPS Code Table to get the Cleaned County Names
county_cleaned := join(fbnBaseFile, FBNV2.FIPS_Codes,
		          trim(left.fips_state, left, right) = trim(right.fips_state, left, right) and 
				  trim(left.fips_county, left, right) = trim(right.fips_county, left, right),
		          trecs(left,right),left outer, lookup);


//Calling Coverage Report Macro.
fbnv2.mac_CoverageReport(county_cleaned, process_date, CoverageReport);

return CoverageReport;
end;
