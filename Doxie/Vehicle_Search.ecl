/*--SOAP--
<message name="VehicleSearchRequest" wuTimeout="500000">
 <part name="SSN" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="RelativeFirstName1" type="xsd:string"/>
  <part name="RelativeFirstName2" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="OtherLastName1" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="CompanyName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="OtherCity1" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="OtherState1" type="xsd:string"/>
  <part name="OtherState2" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
  <part name="DID" type="xsd:string"/>
  <part name="BDID" type="xsd:string"/>
  <part name="DriversLicense" type="xsd:string"/>
  <part name="VIN" type="xsd:string"/>
  <part name="Tag" type="xsd:string"/>
  <part name="Household" type="xsd:boolean"/> 
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="SeisintAdlService" type="xsd:string"/> 
  <part name="NeighborService" type="tns:EspStringArray"/>
  <part name="IsANeighbor" type="xsd:boolean"/>
  <part name="VID" type="xsd:string"/>
  <part name="ScoreThreshold" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="DataPermissionMask" type="xsd:string" default="00000000000"/>
	<part name="DataRestrictionMask" type="xsd:string" default="000000000000000000"/>	
	<part name="IncludeNonRegulatedVehicleSources" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service searches the vehicle file.*/

export Vehicle_Search := MACRO
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#STORED('ScoreThreshold',10);

doxie.MAC_Header_Field_Declare()

qstring25 vid_value := '' : STORED('VID');

result_return := doxie.Vehicle_Search_Records;

// include best info
x_layout :=
RECORD
	result_return;
	string5  	best_title;
	string20 	best_fname;
	string20 	best_mname;
	string20 	best_lname;
	string5  	best_name_suffix;
	string12 	best_did;
	string9	best_ssn;
	string53	best_company_name;
	string61	best_street_address;
	string34	best_city;
	string2	best_state;
	string11	best_zip5_zip4_foreign_postal;
	string5	best_apartment_number;
	string5	best_zip5;
	string3	best_county;
	string18	best_county_name;
	string8	best_dob;
	string1	best_sex;
	string13	best_driver_license_number;
	string10  best_prim_range;
	string2   best_predir;
	string28  best_prim_name;
	string4   best_suffix;
	string2   best_postdir;
	string10  best_unit_desig;
	string8   best_sec_range;
	
	string10 fake_phone;
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
  SELF.best_prim_range := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_prim_range, le.own_2_prim_range, le.reg_1_prim_range, le.reg_2_prim_range);
  SELF.best_predir := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_predir, le.own_2_predir, le.reg_1_predir, le.reg_2_predir);
  SELF.best_prim_name := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_prim_name, le.own_2_prim_name, le.reg_1_prim_name, le.reg_2_prim_name);
  SELF.best_suffix := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_suffix, le.own_2_suffix, le.reg_1_suffix, le.reg_2_suffix);
  SELF.best_postdir := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_postdir, le.own_2_postdir, le.reg_1_postdir, le.reg_2_postdir);
  SELF.best_unit_desig := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_unit_desig, le.own_2_unit_desig, le.reg_1_unit_desig, le.reg_2_unit_desig);
  SELF.best_sec_range := doxie.firstnonblank(le.pick, le.own_1_lname, le.own_2_lname, le.reg_1_lname, le.reg_2_lname,
									le.own_1_sec_range, le.own_2_sec_range, le.reg_1_sec_range, le.reg_2_sec_range);
  SELF.fake_phone := phone_value;
  SELF := le;
END;
Fetched := project(result_return, pushup(LEFT));

doxie.MAC_Header_Result_Rank(best_fname,best_mname,best_lname,
                             best_ssn,best_dob,best_did,
                             best_predir,best_prim_range,best_prim_name,best_suffix,best_postdir,best_sec_range,
                             best_city,best_county_name,best_state,best_zip5,
                             fake_phone,true,best_company_name,true)

outfile := sort(outf1,penalt,history_name,history,orig_vin);

doxie.MAC_Marshall_Results(outfile,outf);

PrettyLayout := record
	outf.output_seq_no;
	outf.penalt;
	outf.source;
	outf.record_type;
	outf.NonDMVSource;
	outf.vid;
	outf.history;
	outf.history_name;
	outf.vehicle_type_name;
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
	outf.OWN_1_SRC_FIRST_DATE;
	outf.OWN_1_SRC_LAST_DATE;
	
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
	outf.OWN_2_SRC_FIRST_DATE;
	outf.OWN_2_SRC_LAST_DATE;
	
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
end;

MAP( ~dppa_ok 			=> 	FAIL(2, doxie.ErrorCodes(2)),
						output(TABLE(outf, PrettyLayout), NAMED('results')) )

ENDMACRO;