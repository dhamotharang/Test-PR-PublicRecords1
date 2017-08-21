import _Control;

export Spray_NewLayout(string filedate) := function

//Spray file with new layout
spray_tempfile := FileServices.SprayFixed(_control.IPAddress.edata12
								, '/data_build_1/calbus/data/'+filedate+'/'+filedate+'.ACTIVE305.TXT'
								, 396
								, 'thor400_92'
								, Calbus.Constants.Cluster +'in::Calbus::temp'
								,-1,,,true,true,true);

layout_temp := record
       string3	DISTRICT_BRANCH;
       string13	ACCOUNT_NUMBER;
       string3	DISTRICT;
       string4	TAX_CODE_FULL;
       string50	FIRM_NAME;
       string50	OWNER_NAME;
       string40	BUSINESS_STREET;
       string30	BUSINESS_CITY;
       string2	BUSINESS_STATE;
       string5	BUSINESS_ZIP_5;
       string4	BUSINESS_ZIP_PLUS_4;
       string7	BUSINESS_FOREIGN_ZIP;
       string35	BUSINESS_COUNTRY_NAME;
       string40	MAILING_STREET;
       string30	MAILING_CITY;
       string2	MAILING_STATE;
       string5	MAILING_ZIP_5;
       string4	MAILING_ZIP_PLUS_4;
       string7	MAILING_FOREIGN_ZIP;
       string35	MAILING_COUNTRY_NAME;
       string8	START_DATE;
       string5	INDUSTRY_CODE;
	   string6	NAICS_CODE; //New field added to vendor's file. Removing it so as to allow the build to continue until new field is added to keys.
       string2	COUNTY_CODE;
       string3	CITY_CODE;
       string1	OWNERSHIP_CODE;
	   string2 	crlf;
	end;

//Project Temp into old layout(that don't have NAICS_CODE, removing this field from the file)
Calbus.Layouts_Calbus.Layout_raw_crlf reformat(layout_temp l) := transform
self := l;
end;

project_file := project(dataset(Calbus.Constants.Cluster +'in::Calbus::temp',layout_temp,flat),reformat(left));

outputfile := output(project_file,,Calbus.Constants.Cluster +'in::Calbus::raw_'+filedate,__compressed__, overwrite); //New starting point for Calbus.Mac_Calbus_Spray

retval := sequential(spray_tempfile
							, outputfile);
return retval;
end;