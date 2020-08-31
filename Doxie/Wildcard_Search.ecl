/*--SOAP--
<message name="Wildcard Vehicle Search">
   <part name="Tag" type="xsd:string"/>
   <part name="UseTagBlur" type='xsd:boolean' />
   <part name="VIN" type="xsd:string" />
   <part name="containsSearch" type="xsd:boolean"/>
   <part name="Zip" type="tns:EspStringArray"/>
   <part name="City" type="xsd:string"/>
   <part name="State" type="xsd:string"/>
   <part name="County" type="xsd:string"/>
   <part name="make" type="tns:EspStringArray"/>
   <part name="MajorColor" type="tns:EspStringArray"/>
   <part name="SortByTagTypes" type="tns:EspStringArray"/>
   <part name="Model" type="tns:EspStringArray"/>
   <part name="Body" type="tns:EspStringArray"/>
   <part name="Sex" type="xsd:string"/>
   <part name="FilterLimit" type="xsd:string"/>
   <part name="ModelYearStart" type="xsd:string"/>
   <part name="ModelYearEnd" type="xsd:string"/>
   <part name="AgeLow" type="xsd:string"/>
   <part name="AgeHigh" type="xsd:string"/>
   <part name="UnParsedFullName" type="xsd:string"/>
   <part name="FirstName" type="xsd:string"/>
   <part name="LastName" type="xsd:string"/>
   <part name="MiddleName" type="xsd:string"/>
   <part name="RegisterState" type="xsd:string"/>
   <part name="MaxResults" type="xsd:unsignedInt"/>
   <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
   <part name="SkipRecords" type="xsd:unsignedInt"/>
   <part name="DPPAPurpose" type="xsd:byte"/>
   <part name="Raw" type="xsd:boolean"/>
   <part name="RemoteOptimization" type="xsd:boolean"/>
   <part name="NeighborService" type="tns:EspStringArray"/>
   <part name="IsANeighbor" type="xsd:boolean"/>
   <part name="SSNMask" type="xsd:string"/>
   <part name="DLMask" type="xsd:string"/>
   <part name="DataRestrictionMask" type="xsd:string" default="000000000000000000"/>
   <part name="RegistrationType" type="xsd:unsignedInt"/>
   <part name="IncludeDetailedRegistrationType" type="xsd:boolean"/>
   <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
   <part name="IncludeNonRegulatedVehicleSources" type="xsd:boolean"/>
   <part name="Zip5" type="xsd:string"/>
   <part name="ZipRadius" type="xsd:unsignedInt"/>
</message>
*/
IMPORT vehicle_wildcard, doxie, WSInput, STD, VehicleV2_Services;

EXPORT Wildcard_Search() := MACRO

vehicle_wildcard.MAC_Field_Declare();

WSInput.MAC_Doxie_Wildcard_Search();

result_return := doxie.Wildcard_Search_Records;

// include best info
x_layout :=
RECORD
	result_return;
	string	best_title;
	string	best_fname;
	string	best_mname;
	string	best_lname;
	string	best_name_suffix;
	string	best_did;
	string	best_ssn;
	string	best_company_name;
	string	best_street_address;
	string	best_city;
	string	best_state;
	string	best_zip5_zip4_foreign_postal;
	string	best_apartment_number;
	string	best_zip5;
	string	best_county;
	string	best_county_name;
	string	best_dob;
	string	best_sex;
	string	best_driver_license_number;
	boolean best_hasCriminalConviction;
	boolean best_isSexualOffender;
END;

x_layout pushup(result_return le) :=
TRANSFORM
  SELF.best_title := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_title, le.own_2_title, le.reg_1_title, le.reg_2_title);
  SELF.best_fname := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_fname, le.own_2_fname, le.reg_1_fname, le.reg_2_fname);
  SELF.best_mname := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_mname, le.own_2_mname, le.reg_1_mname, le.reg_2_mname);
  SELF.best_lname := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname);
  SELF.best_name_suffix := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_name_suffix, le.own_2_name_suffix, le.reg_1_name_suffix, le.reg_2_name_suffix);
  SELF.best_did := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_did, le.own_2_did, le.reg_1_did, le.reg_2_did);
  SELF.best_ssn := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_ssn, le.own_2_ssn, le.reg_1_ssn, le.reg_2_ssn);
  SELF.best_company_name := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_company_name, le.own_2_company_name, le.reg_1_company_name, le.reg_2_company_name);
  SELF.best_STREET_ADDRESS := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_STREET_ADDRESS, le.own_2_STREET_ADDRESS, le.reg_1_STREET_ADDRESS, le.reg_2_STREET_ADDRESS);
  SELF.best_CITY := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_CITY, le.own_2_CITY, le.reg_1_CITY, le.reg_2_CITY);
  SELF.best_STATE := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_STATE, le.own_2_STATE, le.reg_1_STATE, le.reg_2_STATE);
  SELF.best_ZIP5_ZIP4_FOREIGN_POSTAL := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_ZIP5_ZIP4_FOREIGN_POSTAL, le.own_2_ZIP5_ZIP4_FOREIGN_POSTAL, le.reg_1_ZIP5_ZIP4_FOREIGN_POSTAL, le.reg_2_ZIP5_ZIP4_FOREIGN_POSTAL);
  SELF.best_APARTMENT_NUMBER := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_APARTMENT_NUMBER, le.own_2_APARTMENT_NUMBER, le.reg_1_APARTMENT_NUMBER, le.reg_2_APARTMENT_NUMBER);
  SELF.best_zip5 := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_zip5, le.own_2_zip5, le.reg_1_zip5, le.reg_2_zip5);
  SELF.best_county := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_county, le.own_2_county, le.reg_1_county, le.reg_2_county);
  SELF.best_county_name := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_county_name, le.own_2_county_name, le.reg_1_county_name, le.reg_2_county_name);
  SELF.best_dob := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_dob, le.own_2_dob, le.reg_1_dob, le.reg_2_dob);
  SELF.best_sex := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_sex, le.own_2_sex, le.reg_1_sex, le.reg_2_sex);
  SELF.best_DRIVER_LICENSE_NUMBER := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_DRIVER_LICENSE_NUMBER, le.own_2_DRIVER_LICENSE_NUMBER, le.reg_1_DRIVER_LICENSE_NUMBER, le.reg_2_DRIVER_LICENSE_NUMBER);
  SELF.best_hasCriminalConviction := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_hasCriminalConviction, le.own_2_hasCriminalConviction, le.reg_1_hasCriminalConviction, le.reg_2_hasCriminalConviction);
  SELF.best_isSexualOffender := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_isSexualOffender, le.own_2_isSexualOffender, le.reg_1_isSexualOffender, le.reg_2_isSexualOffender);
  SELF := le;
END;
Fetched := project(result_return, pushup(LEFT));
// SORT by tagTypeSelection first ONLY if the user sent in values for the SortByTagTypes input field
// Sort Filtered by TAG, id, and name to create unique ordering
outfile := SORT(Fetched, 		
               -(VehicleV2_Services.Functions.tagTypeSelection(
                   SortByTagTypes,
                   STD.Str.ToUpperCase(license_plate_code ),
                   STD.Str.ToUpperCase(orig_state ),
                   STD.Str.ToUpperCase(license_plate_desc ) )
                ),
               make_code, -model_description, LICENSE_PLATE_NUMBERxBG4,
               VID, own_1_lname, own_1_fname, own_1_mname, pick);

doxie.MAC_Marshall_Results(outfile,outf);

PrettyLayout := record
	outf.output_seq_no;
	outf.source;
	outf.vid;
	outf.dt_last_seen;
	outf.NonDMVSource;
	outf.history;
	outf.history_name;
	outf.make_description;
	outf.model_description;
	outf.series_description;
	outf.body_style_description;
	string30 major_color := outf.major_color_code;
	outf.major_color_name;
	string30 minor_color := outf.minor_color_code;
	outf.minor_color_name;
	outf.year_make;
	outf.body_code;
	outf.length_feet;
	outf.hull_material_type;
	outf.vessel_type;
	outf.orig_vin;
	outf.LICENSE_PLATE_NUMBERxBG4;
	outf.VEHICLE_NUMBERxBG1;
	outf.license_plate_code;
	outf.license_plate_desc;
	outf.orig_state;
	outf.orig_state_name;
  
	outf.own_1_title;
	outf.own_1_fname;
	outf.own_1_mname;
	outf.own_1_lname;
	outf.own_1_name_suffix;
	outf.own_1_did;
	outf.own_1_ssn;
	outf.own_1_company_name;
	outf.OWN_1_STREET_ADDRESS;
	outf.OWN_1_CITY;
	outf.OWN_1_STATE;
	outf.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL;
	outf.OWN_1_APARTMENT_NUMBER;
	outf.own_1_zip5;
	outf.own_1_county;
	outf.own_1_county_name;
	outf.own_1_dob;
	outf.own_1_sex;
	outf.OWN_1_DRIVER_LICENSE_NUMBER;
	outf.own_1_hasCriminalConviction;
	outf.own_1_isSexualOffender;
	outf.own_1_src_first_date;
	outf.own_1_src_last_date;
	
	outf.own_2_title;
	outf.own_2_fname;
	outf.own_2_mname;
	outf.own_2_lname;
	outf.own_2_name_suffix;
	outf.own_2_did;
	outf.own_2_ssn;
	outf.own_2_company_name;
	outf.own_2_STREET_ADDRESS;
	outf.own_2_CITY;
	outf.own_2_STATE;
	outf.own_2_ZIP5_ZIP4_FOREIGN_POSTAL;
	outf.own_2_APARTMENT_NUMBER;
	outf.own_2_zip5;
	outf.own_2_county;
	outf.own_2_county_name;
	outf.own_2_dob;
	outf.own_2_sex;
	outf.own_2_DRIVER_LICENSE_NUMBER;
	outf.own_2_hasCriminalConviction;
	outf.own_2_isSexualOffender;
	outf.own_2_src_first_date;
	outf.own_2_src_last_date;
	
	outf.reg_1_title;
	outf.reg_1_fname;
	outf.reg_1_mname;
	outf.reg_1_lname;
	outf.reg_1_name_suffix;
	outf.reg_1_did;
	outf.reg_1_ssn;
	outf.reg_1_company_name;
	outf.reg_1_STREET_ADDRESS;
	outf.reg_1_CITY;
	outf.reg_1_STATE;
	outf.reg_1_ZIP5_ZIP4_FOREIGN_POSTAL;
	outf.reg_1_APARTMENT_NUMBER;
	outf.reg_1_zip5;
	outf.reg_1_county;
	outf.reg_1_county_name;
	outf.reg_1_dob;
	outf.reg_1_sex;
	outf.reg_1_DRIVER_LICENSE_NUMBER;
	outf.reg_1_hasCriminalConviction;
	outf.reg_1_isSexualOffender;
	
	outf.reg_2_title;
	outf.reg_2_fname;
	outf.reg_2_mname;
	outf.reg_2_lname;
	outf.reg_2_name_suffix;
	outf.reg_2_did;
	outf.reg_2_ssn;
	outf.reg_2_company_name;
	outf.reg_2_STREET_ADDRESS;
	outf.reg_2_CITY;
	outf.reg_2_STATE;
	outf.reg_2_ZIP5_ZIP4_FOREIGN_POSTAL;
	outf.reg_2_APARTMENT_NUMBER;
	outf.reg_2_zip5;
	outf.reg_2_county;
	outf.reg_2_county_name;
	outf.reg_2_dob;
	outf.reg_2_sex;
	outf.reg_2_DRIVER_LICENSE_NUMBER;
	outf.reg_2_hasCriminalConviction;
	outf.reg_2_isSexualOffender;

	outf.best_title;
	outf.best_fname;
	outf.best_mname;
	outf.best_lname;
	outf.best_name_suffix;
	outf.best_did;
	outf.best_ssn;
	outf.best_company_name;
	outf.best_street_address;
	outf.best_city;
	outf.best_state;
	outf.best_zip5_zip4_foreign_postal;
	outf.best_apartment_number;
	outf.best_zip5;
	outf.best_county;
	outf.best_county_name;
	outf.best_dob;
	outf.best_sex;
	outf.best_driver_license_number;
	outf.best_hasCriminalConviction;
	outf.best_isSexualOffender;
end;

outRec := TABLE(outf, PrettyLayout);

outRec blanker(outRec le) :=
TRANSFORM
	SELF.vid := le.vid;
	SELF.history_name := le.history_name;
	SELF.orig_vin := le.orig_vin;
	SELF.make_description := le.make_description;
	SELF.model_description := le.model_description;
	SELF.year_make := le.year_make;
	SELF.series_description := le.series_description;
	SELF.major_color := le.major_color;
	SELF.minor_color := le.minor_color;
	SELF.major_color_name := le.major_color_name;
	SELF.minor_color_name := le.minor_color_name;
	SELF.body_style_description := le.body_style_description;
	SELF.body_code := le.body_code;
	SELF.length_feet := le.length_feet;
	SELF.hull_material_type := le.hull_material_type;
	SELF.vessel_type := le.vessel_type;
	SELF.license_plate_numberxbg4 := le.license_plate_numberxbg4;
	SELF.vehicle_numberxbg1 := le.vehicle_numberxbg1;
	SELF.orig_state := le.orig_state;
	SELF.orig_state_name := le.orig_state_name;
	SELF.best_title := le.best_title;
	SELF.best_fname := le.best_fname;
	SELF.best_mname := le.best_mname;
	SELF.best_lname := le.best_lname;
	SELF.best_name_suffix := le.best_name_suffix;
	SELF.best_zip5 := le.best_zip5;
	SELF.best_street_address := le.best_street_address;
	SELF.best_city := le.best_city;
	SELF.best_state := le.best_state;
	SELF.best_apartment_number := le.best_apartment_number;
	SELF.best_zip5_zip4_foreign_postal := le.best_zip5_zip4_foreign_postal;
	SELF.best_county := le.best_county;
	SELF.best_county_name := le.best_county_name;
	SELF.best_company_name := le.best_company_name;
	SELF.best_ssn := le.best_ssn;
	SELF.best_driver_license_number := le.best_driver_license_number;
	SELF.best_dob := le.best_dob;
	SELF.best_sex := le.best_sex;
	SELF.best_did := le.best_did;
  SELF.best_hasCriminalConviction := le.best_hasCriminalConviction;
  SELF.best_isSexualOffender := le.best_isSexualOffender;
	SELF := [];
END;

p := IF(is_remote, PROJECT(outRec, blanker(LEFT)), outRec);

map(~dppa_ok    => FAIL(2, doxie.ErrorCodes(2)),
	raw_records => output(result_return),
	output(p, NAMED('results')))

ENDMACRO;