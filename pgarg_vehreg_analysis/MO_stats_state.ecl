//c := VehLic.File_Base_Vehicles_Dev(orig_state='NM'):PERSIST('~thor_data400::persist::File_NM_Vehlic');
//output(c(ORIG_VIN='02550628L'));
//c := VehLic.File_Base_Vehicles_Dev(orig_state='OH'):PERSIST('~thor_data400::persist::File_OH_Vehlic');
c := VehLic.File_Base_Vehicles_Dev(orig_state='MO'):PERSIST('~thor_data400::persist::File_MO_Vehlic');


c_dist := distribute(c,hash(ORIG_VIN,REG_1_CUSTOMER_NAME));
c_sort := sort(c_dist,ORIG_VIN,REG_1_CUSTOMER_NAME,local);
//output(c_sort);
//##### not bothered if first expiration date or the last expiration date is in field but need just one instance.
c_dedup := dedup(c_sort,ORIG_VIN,REG_1_CUSTOMER_NAME,KEEP 1, right, local);




//####normalize records now
Layout_Normalize := record
    unsigned6        vrid := 0 ;
    unsigned3        dt_first_seen;
    unsigned3        dt_last_seen;
    unsigned3        dt_vendor_first_reported;
    unsigned3        dt_vendor_last_reported;
    string2          orig_state;
	string2          source_code ;
    qstring8         price  ;
    unsigned4        seq_no ;
    qstring20        VEHICLE_NUMBERxBG1 ;
    qstring25        ORIG_VIN ;
    qstring10        VEHICLE_TRANSACTION_ID  ;
    qstring8         FIRST_REGISTRATION_DATE  ;
    qstring4         YEAR_MAKE  ;
    qstring5         MAKE_CODE  ;
    qstring4         VEHICLE_TYPE  ;
    qstring3         MODEL ;
    qstring5         BODY_CODE  ;
    qstring1         VEHICLE_USE  ;
    qstring3         MAJOR_COLOR_CODE ;
    qstring3         MINOR_COLOR_CODE  ;
    qstring2         TRANSFER_TYPE ;
    qstring2         FUEL_TYPE  ;
    qstring9         UNIT_NUMBERxBG2  ;
    qstring3         FLEET_NUMBER  ;
    qstring1         ODOMETER_STATUS  ;
    qstring8         ODOMETER_DATE  ;
    qstring7         ODOMETER_MILEAGE  ;
    qstring6         NET_WEIGHT  ;
    qstring6         GROSS_WEIGHT  ;
    qstring1         NUMBER_OF_AXLES  ;
    qstring4         HORSE_POWER  ;
    qstring4         CUBIC_CENTIMETERS  ;
    qstring3         LENGTH_FEET  ;
    qstring2         WIDTH_FEET  ;
    qstring2         MH_COUNTY_CODE  ;
    qstring2         MH_CITY_CODE  ;
    qstring2         VESSEL_PROPULSION_TYPE  ;
    qstring5         HULL_MATERIAL_TYPE  ;
    qstring3         VESSEL_TYPE  ;
    qstring1         VESSEL_WATER_TYPE  ;
    qstring8         flaghistory  ; 
    qstring1         FILE_HANDLER_ACTIVITY_FLAG  ;
    qstring1         CORRESPONDENCE_LETTER_FLAG  ;
	unsigned1        CUSTOMER_TYPE :=0;
    qstring10        CUSTOMER_NUMBER  ;
    qstring9         FEID_SSN  ;
	qstring61        CUSTOMER_NAME  ;
    qstring12        DEALER_LICENSE_NUMBER  ;
    qstring13        DRIVER_LICENSE_NUMBER  ;
    qstring8         DOB  ;
    qstring1         SEX  ;
    qstring1         SEXUAL_PREDATOR_FLAG  ;
    qstring1         MAIL_SUPPESSION_FLAG  ;
    qstring1         ADDR_NON_DISCLOSURE_FLAG  ;
    qstring1         LAW_ENFORCEMENT_FLAG  ;
    qstring10        ADDRESS_NUMBER  ;
    qstring1         FOREIGN_ADDRESS_FLAG  ;
    qstring61        STREET_ADDRESS  ;
    qstring5         APARTMENT_NUMBER  ;
    qstring34        CITY  ;
    qstring2         STATE  ;
    qstring11        ZIP5_ZIP4_FOREIGN_POSTAL  ;
    qstring3         RESIDENCE_COUNTY  ;
    qstring3         JOINT_OWNERSHIP_CODExAND_OR  ;
    qstring8         flagvin  ;      
    qstring10        LICENSE_PLATE_NUMBERxBG4  ;
    qstring10        REGISTRATION_NUMBER  ;
    qstring10        REGISTRATION_TRANSACTION_ID  ;
    qstring8         REGISTRATION_EFFECTIVE_DATE  ;
    string8          REGISTRATION_EXPIRATION_DATE  ;
    qstring8         PLATE_ISSUE_DATE  ;
    qstring3         VEHICLE_CLASS_CODE  ;
    qstring2         ARF_CREDIT  ;
    qstring10        DECAL_NUMBER  ;
    qstring4         DECAL_YEAR  ;
    qstring3         DECAL_TYPE  ;
    qstring1         REGISTRATION_STATUS_CODE  ;
    qstring2         REG_ONLY_REASON_CODE  ;
    qstring4         LICENSE_PLATE_CODE  ;
    qstring2         REGISTRATION_USE  ;
    qstring10        TRUE_LICENSE_PLSTE_NUMBER  ;
    qstring8         flagmatchcode  ;
    qstring1         VESSEL_RESIDENT_STATUS  ;
    qstring8         ACTIVITY_DATExBG6  ;
    qstring4         ACTIVITY_COUNTY  ;
    qstring4         ACTIVITY_AGENCYxEG6  ;
    qstring5         INSURANCE_COMPANY_CODExBG7  ;
    qstring35        INSURANCE_NUMBER  ;
    qstring1         INSURANCE_STATUS  ;
    qstring2         INSURANCE_TYPExEG7  ;
    qstring1         EMISSIONS_INSPECTION_STATUSxBG8  ;
    qstring8         EMISSIONS_INSPECTION_DATE  ;
    qstring4         EMISSIONS_INSP_REG_YEAR  ;
    qstring1         EMISSIONS_INSPECTION_LEVEL  ;
    qstring16        EMISSIONS_CERTIFICATE_NUMBERxEG8  ;
    qstring20        TITLE_NUMBERxBG9  ;
    qstring10        TITLE_TRANSACTION_ID  ;
    qstring8         TITLE_ISSUE_DATE  ;
    qstring8         PREVIOUS_TITLE_ISSUE_DATE  ;
    qstring2         TITLE_STATUS_CODE  ;
    qstring2         TITLE_TYPE  ;
    qstring2         PREVIOUS_TITLE_STATE  ;
    qstring1         SALVAGE_TYPE  ;
  //qstring12        DEALER_LICENSE_NUMBER  ;
    qstring1         TITLE_PENDING_FLAG  ;
    qstring1         NAME_TOO_LONG_FLAG  ;
    qstring1         DUPLICATE_TITLE_FLAG  ;
    qstring10        BRAND_CODESx5  ;
    qstring2         EFS_STATUSxEG9  ;
    qstring1         LIEN_COUNTxBG10  ;
    qstring8         LIEN_DATE  ;
   // qstring8         LH_2_LEIN_DATE  ;
   // qstring8         LH_3_LIEN_DATE  ;

end;


Layout_Normalize normalize_names(c_dedup l, unsigned1 cnt) := TRANSFORM
  self.CUSTOMER_NAME := choose(cnt, l.OWN_1_CUSTOMER_NAME, l.OWN_2_CUSTOMER_NAME, l.REG_1_CUSTOMER_NAME, l.REG_2_CUSTOMER_NAME, l.LH_1_CUSTOMER_NAME, l.LH_2_CUSTOMER_NAME, l.LH_3_CUSTOMER_NAME);
  self.CUSTOMER_TYPE := cnt;
  
  self.customer_number := map(cnt=1=>l.OWN_1_CUSTOMER_NUMBER,
							  cnt=2=>l.OWN_2_CUSTOMER_NUMBER,
							  cnt=3=>l.REG_1_CUSTOMER_NUMBER,
							  cnt=4=>l.REG_2_CUSTOMER_NUMBER,
							  cnt=5=>l.LH_1_CUSTOMER_NUMBER,
						      cnt=6=>l.LH_2_CUSTOMER_NUMBER,
						      cnt=7=>l.LH_3_CUSTOMER_NUMBER,
						     '');

   self.feid_ssn := map(cnt=1=>l.OWN_1_feid_ssn,
							  cnt=2=>l.OWN_2_feid_ssn,
							  cnt=3=>l.REG_1_feid_ssn,
							  cnt=4=>l.REG_2_feid_ssn,
							  cnt=5=>l.LH_1_feid_ssn,
						      cnt=6=>l.LH_2_feid_ssn,
						      cnt=7=>l.LH_3_feid_ssn,
						     '');
							 


    self.DEALER_LICENSE_NUMBER := map(cnt=1=>l.OWN_1_DEALER_LICENSE_NUMBER,
							  cnt=2=>l.OWN_2_DEALER_LICENSE_NUMBER,
							  cnt=3=>l.REG_1_DEALER_LICENSE_NUMBER,
							  cnt=4=>l.REG_2_DEALER_LICENSE_NUMBER,
							  cnt=5=>l.LH_1_DEALER_LICENSE_NUMBER,
						      cnt=6=>l.LH_2_DEALER_LICENSE_NUMBER,
						      cnt=7=>l.LH_3_DEALER_LICENSE_NUMBER,
						     '');
							 
     self.DRIVER_LICENSE_NUMBER := map(cnt=1=>l.OWN_1_DRIVER_LICENSE_NUMBER,
							  cnt=2=>l.OWN_2_DRIVER_LICENSE_NUMBER,
							  cnt=3=>l.REG_1_DRIVER_LICENSE_NUMBER,
							  cnt=4=>l.REG_2_DRIVER_LICENSE_NUMBER,
							  cnt=5=>l.LH_1_DRIVER_LICENSE_NUMBER,
						      cnt=6=>l.LH_2_DRIVER_LICENSE_NUMBER,
						      cnt=7=>l.LH_3_DRIVER_LICENSE_NUMBER,
						     '');
							 
     self.DOB := map(cnt=1=>l.OWN_1_DOB,
							  cnt=2=>l.OWN_2_DOB,
							  cnt=3=>l.REG_1_DOB,
							  cnt=4=>l.REG_2_DOB,
							  cnt=5=>l.LH_1_DOB,
						      cnt=6=>l.LH_2_DOB,
						      cnt=7=>l.LH_3_DOB,
						     '');
							 
    self.SEX := map(cnt=1=>l.OWN_1_SEX,
							  cnt=2=>l.OWN_2_SEX,
							  cnt=3=>l.REG_1_SEX,
							  cnt=4=>l.REG_2_SEX,
							  cnt=5=>l.LH_1_SEX,
						      cnt=6=>l.LH_2_SEX,
						      cnt=7=>l.LH_3_SEX,
						     '');
							 
							 
  self.SEXUAL_PREDATOR_FLAG := map(cnt=1=>l.OWN_1_SEXUAL_PREDATOR_FLAG,
							  cnt=2=>l.OWN_2_SEXUAL_PREDATOR_FLAG,
							  cnt=3=>l.REG_1_SEXUAL_PREDATOR_FLAG,
							  cnt=4=>l.REG_2_SEXUAL_PREDATOR_FLAG,
							  cnt=5=>l.LH_1_SEXUAL_PREDATOR_FLAG,
						      cnt=6=>l.LH_2_SEXUAL_PREDATOR_FLAG,
						      cnt=7=>l.LH_3_SEXUAL_PREDATOR_FLAG,
						     '');
  self.MAIL_SUPPESSION_FLAG := map(cnt=1=>l.OWN_1_MAIL_SUPPESSION_FLAG,
							  cnt=2=>l.OWN_2_MAIL_SUPPESSION_FLAG,
							  cnt=3=>l.REG_1_MAIL_SUPPESSION_FLAG,
							  cnt=4=>l.REG_2_MAIL_SUPPESSION_FLAG,
							  cnt=5=>l.LH_1_MAIL_SUPPESSION_FLAG,
						      cnt=6=>l.LH_2_MAIL_SUPPESSION_FLAG,
						      cnt=7=>l.LH_3_MAIL_SUPPESSION_FLAG,
						     '');

			
		
  self.LAW_ENFORCEMENT_FLAG := map(cnt=1=>l.OWN_1_LAW_ENFORCEMENT_FLAG,
							  cnt=2=>l.OWN_2_LAW_ENFORCEMENT_FLAG,
							  cnt=3=>l.REG_1_LAW_ENFORCEMENT_FLAG,
							  cnt=4=>l.REG_2_LAW_ENFORCEMENT_FLAG,
							  cnt=5=>l.LH_1_LAW_ENFORCEMENT_FLAG,
						      cnt=6=>l.LH_2_LAW_ENFORCEMENT_FLAG,
						      cnt=7=>l.LH_3_LAW_ENFORCEMENT_FLAG,
						     '');
  self.ADDRESS_NUMBER := map(cnt=1=>l.OWN_1_ADDRESS_NUMBER,
							  cnt=2=>l.OWN_2_ADDRESS_NUMBER,
							  cnt=3=>l.REG_1_ADDRESS_NUMBER,
							  cnt=4=>l.REG_2_ADDRESS_NUMBER,
							  cnt=5=>l.LH_1_ADDRESS_NUMBER,
						      cnt=6=>l.LH_2_ADDRESS_NUMBER,
						      cnt=7=>l.LH_3_ADDRESS_NUMBER,
						     '');
  self.ADDR_NON_DISCLOSURE_FLAG := map(cnt=1=>l.OWN_1_ADDR_NON_DISCLOSURE_FLAG,
							  cnt=2=>l.OWN_2_ADDR_NON_DISCLOSURE_FLAG,
							  cnt=3=>l.REG_1_ADDR_NON_DISCLOSURE_FLAG,
							  cnt=4=>l.REG_2_ADDR_NON_DISCLOSURE_FLAG,
							  cnt=5=>l.LH_1_ADDR_NON_DISCLOSURE_FLAG,
						      cnt=6=>l.LH_2_ADDR_NON_DISCLOSURE_FLAG,
						      cnt=7=>l.LH_3_ADDR_NON_DISCLOSURE_FLAG,
						     '');
  self.FOREIGN_ADDRESS_FLAG := map(cnt=1=>l.OWN_1_FOREIGN_ADDRESS_FLAG,
							  cnt=2=>l.OWN_2_FOREIGN_ADDRESS_FLAG,
							  cnt=3=>l.REG_1_FOREIGN_ADDRESS_FLAG,
							  cnt=4=>l.REG_2_FOREIGN_ADDRESS_FLAG,
							  cnt=5=>l.LH_1_FOREIGN_ADDRESS_FLAG,
						      cnt=6=>l.LH_2_FOREIGN_ADDRESS_FLAG,
						      cnt=7=>l.LH_3_FOREIGN_ADDRESS_FLAG,
						     '');
	
  self.STREET_ADDRESS := map(cnt=1=>l.OWN_1_STREET_ADDRESS,
							  cnt=2=>l.OWN_2_STREET_ADDRESS,
							  cnt=3=>l.REG_1_STREET_ADDRESS,
							  cnt=4=>l.REG_2_STREET_ADDRESS,
							  cnt=5=>l.LH_1_STREET_ADDRESS,
						      cnt=6=>l.LH_2_STREET_ADDRESS,
						      cnt=7=>l.LH_3_STREET_ADDRESS,
						     '');
  self.APARTMENT_NUMBER := map(cnt=1=>l.OWN_1_APARTMENT_NUMBER,
							  cnt=2=>l.OWN_2_APARTMENT_NUMBER,
							  cnt=3=>l.REG_1_APARTMENT_NUMBER,
							  cnt=4=>l.REG_2_APARTMENT_NUMBER,
							  cnt=5=>l.LH_1_APARTMENT_NUMBER,
						      cnt=6=>l.LH_2_APARTMENT_NUMBER,
						      cnt=7=>l.LH_3_APARTMENT_NUMBER,
						     '');
  self.CITY := map(cnt=1=>l.OWN_1_CITY,
							  cnt=2=>l.OWN_2_CITY,
							  cnt=3=>l.REG_1_CITY,
							  cnt=4=>l.REG_2_CITY,
							  cnt=5=>l.LH_1_CITY,
						      cnt=6=>l.LH_2_CITY,
						      cnt=7=>l.LH_3_CITY,
						     '');
  self.STATE := map(cnt=1=>l.OWN_1_STATE,
							  cnt=2=>l.OWN_2_STATE,
							  cnt=3=>l.REG_1_STATE,
							  cnt=4=>l.REG_2_STATE,
							  cnt=5=>l.LH_1_STATE,
						      cnt=6=>l.LH_2_STATE,
						      cnt=7=>l.LH_3_STATE,
						     '');
  self.ZIP5_ZIP4_FOREIGN_POSTAL := map(cnt=1=>l.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL,
							  cnt=2=>l.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL,
							  cnt=3=>l.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL,
							  cnt=4=>l.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL,
							  cnt=5=>l.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL,
						      cnt=6=>l.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL,
						      cnt=7=>l.LH_3_ZIP5_ZIP4_FOREIGN_POSTAL,
						     '');
  self.RESIDENCE_COUNTY := map(cnt=1=>l.OWN_1_RESIDENCE_COUNTY,
							  cnt=2=>l.OWN_2_RESIDENCE_COUNTY,
							  cnt=3=>l.REG_1_RESIDENCE_COUNTY,
							  cnt=4=>l.REG_2_RESIDENCE_COUNTY,
							  cnt=5=>l.LH_1_RESIDENCE_COUNTY,
						      cnt=6=>l.LH_2_RESIDENCE_COUNTY,
						      cnt=7=>l.LH_3_RESIDENCE_COUNTY,
						     '');
							 
	
	
							 
							 

							 
							 
  self.LIEN_DATE := map(cnt=5=>l.LH_1_LIEN_DATE,
						cnt=6=>l.LH_2_LEIN_DATE,
						cnt=7=>l.LH_3_LIEN_DATE,
						'');
  self := l;
end;

d := NORMALIZE(c_dedup,7,normalize_names(left,counter));
//e := d(ORIG_VIN='02550628L');
//output(e)



//count(c_dedup);
//output(c_dedup);
//## group by owner types


stat_rec := record
d.CUSTOMER_TYPE;
total := count(group);
has_price := AVE(group,IF(stringlib.stringfilterout(d.price,'0')<>'',100,0));
has_VEHICLE_NUMBERxBG1 := AVE(group,IF(stringlib.stringfilterout(d.VEHICLE_NUMBERxBG1,'0')<>'',100,0));
has_ORIG_VIN := AVE(group,IF(stringlib.stringfilterout(d.ORIG_VIN,'0')<>'',100,0));
has_VEHICLE_TRANSACTION_ID := AVE(group,IF(stringlib.stringfilterout(d.VEHICLE_TRANSACTION_ID,'0')<>'',100,0));
has_FIRST_REGISTRATION_DATE := AVE(group,IF(stringlib.stringfilterout(d.FIRST_REGISTRATION_DATE,'0')<>'',100,0));
has_YEAR_MAKE := AVE(group,IF(stringlib.stringfilterout(d.YEAR_MAKE,'0')<>'',100,0));
has_MAKE_CODE := AVE(group,IF(stringlib.stringfilterout(d.MAKE_CODE,'0')<>'',100,0));
has_VEHICLE_TYPE := AVE(group,IF(stringlib.stringfilterout(d.VEHICLE_TYPE,'0')<>'',100,0));
has_MODEL := AVE(group,IF(stringlib.stringfilterout(d.MODEL,'0')<>'',100,0));
has_BODY_CODE := AVE(group,IF(stringlib.stringfilterout(d.BODY_CODE,'0')<>'',100,0));
has_VEHICLE_USE := AVE(group,IF(stringlib.stringfilterout(d.VEHICLE_USE,'0')<>'',100,0));
has_MAJOR_COLOR_CODE := AVE(group,IF(stringlib.stringfilterout(d.MAJOR_COLOR_CODE,'0')<>'' and trim(d.MAJOR_COLOR_CODE,left,right)<>'UNK',100,0));
has_MINOR_COLOR_CODE := AVE(group,IF(stringlib.stringfilterout(d.MINOR_COLOR_CODE,'0')<>'' and trim(d.MAJOR_COLOR_CODE,left,right)<>'UNK',100,0));
has_TRANSFER_TYPE := AVE(group,IF(stringlib.stringfilterout(d.TRANSFER_TYPE,'0')<>'',100,0));
has_FUEL_TYPE := AVE(group,IF(stringlib.stringfilterout(d.FUEL_TYPE,'0')<>'',100,0));
has_UNIT_NUMBERxBG2 := AVE(group,IF(stringlib.stringfilterout(d.UNIT_NUMBERxBG2,'0')<>'',100,0));
has_FLEET_NUMBER := AVE(group,IF(stringlib.stringfilterout(d.FLEET_NUMBER,'0')<>'',100,0));
has_ODOMETER_STATUS := AVE(group,IF(stringlib.stringfilterout(d.ODOMETER_STATUS,'0')<>'',100,0));
has_ODOMETER_DATE := AVE(group,IF(stringlib.stringfilterout(d.ODOMETER_DATE,'0')<>'',100,0));
has_ODOMETER_MILEAGE := AVE(group,IF(stringlib.stringfilterout(d.ODOMETER_MILEAGE,'0')<>'',100,0));
has_NET_WEIGHT := AVE(group,IF(stringlib.stringfilterout(d.NET_WEIGHT,'0')<>'',100,0));
						  
has_GROSS_WEIGHT := AVE(group,IF(stringlib.stringfilterout(d.GROSS_WEIGHT,'0')<>'',100,0));
has_NUMBER_OF_AXLES := AVE(group,IF(stringlib.stringfilterout(d.NUMBER_OF_AXLES,'0')<>'',100,0));
has_HORSE_POWER := AVE(group,IF(stringlib.stringfilterout(d.HORSE_POWER,'0')<>'',100,0));
has_CUBIC_CENTIMETERS := AVE(group,IF(stringlib.stringfilterout(d.CUBIC_CENTIMETERS,'0')<>'',100,0));
has_LENGTH_FEET := AVE(group,IF(stringlib.stringfilterout(d.LENGTH_FEET,'0')<>'',100,0));
has_WIDTH_FEET := AVE(group,IF(stringlib.stringfilterout(d.WIDTH_FEET,'0')<>'',100,0));

has_MH_COUNTY_CODE := AVE(group,IF(stringlib.stringfilterout(d.MH_COUNTY_CODE,'0')<>'',100,0));
has_MH_CITY_CODE := AVE(group,IF(stringlib.stringfilterout(d.MH_CITY_CODE,'0')<>'',100,0));
has_VESSEL_PROPULSION_TYPE := AVE(group,IF(stringlib.stringfilterout(d.VESSEL_PROPULSION_TYPE,'0')<>'',100,0));
has_HULL_MATERIAL_TYPE := AVE(group,IF(stringlib.stringfilterout(d.HULL_MATERIAL_TYPE,'0')<>'',100,0));
has_VESSEL_TYPE := AVE(group,IF(stringlib.stringfilterout(d.VESSEL_TYPE,'0')<>'',100,0));
has_VESSEL_WATER_TYPE := AVE(group,IF(stringlib.stringfilterout(d.VESSEL_WATER_TYPE,'0')<>'',100,0));
  
has_flaghistory := AVE(group,IF(stringlib.stringfilterout(d.flaghistory,'0')<>'',100,0));
has_FILE_HANDLER_ACTIVITY_FLAG := AVE(group,IF(stringlib.stringfilterout(d.FILE_HANDLER_ACTIVITY_FLAG,'0')<>'',100,0));
has_CORRESPONDENCE_LETTER_FLAG := AVE(group,IF(stringlib.stringfilterout(d.CORRESPONDENCE_LETTER_FLAG,'0')<>'',100,0));

has_CUSTOMER_TYPE := AVE(group,IF(d.CUSTOMER_TYPE<>0,100,0));
has_CUSTOMER_NUMBER := AVE(group,IF(stringlib.stringfilterout(d.CUSTOMER_NUMBER,'0')<>'',100,0));
has_FEID_SSN := AVE(group,IF(stringlib.stringfilterout(d.FEID_SSN,'0')<>'',100,0));
has_CUSTOMER_NAME := AVE(group,IF(stringlib.stringfilterout(d.CUSTOMER_NAME,'0')<>'' and trim(d.CUSTOMER_NAME,left,right)<>'NOT ON FILE' and trim(d.CUSTOMER_NAME,left,right)<>'MISSING LIEN INFO',100,0));
  


has_DEALER_LICENSE_NUMBER := AVE(group,IF(stringlib.stringfilterout(d.DEALER_LICENSE_NUMBER,'0')<>'',100,0));
has_DRIVER_LICENSE_NUMBER := AVE(group,IF(stringlib.stringfilterout(d.DRIVER_LICENSE_NUMBER,'0')<>'',100,0));
has_DOB := AVE(group,IF(stringlib.stringfilterout(d.DOB,'0')<>'',100,0));
has_SEX := AVE(group,IF(stringlib.stringfilterout(d.SEX,'0')<>'',100,0));
has_SEXUAL_PREDATOR_FLAG := AVE(group,IF(stringlib.stringfilterout(d.SEXUAL_PREDATOR_FLAG,'0')<>'',100,0));
has_MAIL_SUPPESSION_FLAG := AVE(group,IF(stringlib.stringfilterout(d.MAIL_SUPPESSION_FLAG,'0')<>'',100,0));
has_ADDR_NON_DISCLOSURE_FLAG := AVE(group,IF(stringlib.stringfilterout(d.ADDR_NON_DISCLOSURE_FLAG,'0')<>'',100,0));
has_LAW_ENFORCEMENT_FLAG := AVE(group,IF(stringlib.stringfilterout(d.LAW_ENFORCEMENT_FLAG,'0')<>'',100,0));

has_ADDRESS_NUMBER := AVE(group,IF(stringlib.stringfilterout(d.ADDRESS_NUMBER,'0')<>'',100,0));
has_FOREIGN_ADDRESS_FLAG := AVE(group,IF(stringlib.stringfilterout(d.FOREIGN_ADDRESS_FLAG,'0')<>'',100,0));
has_STREET_ADDRESS := AVE(group,IF(stringlib.stringfilterout(d.STREET_ADDRESS,'0')<>'',100,0));
has_APARTMENT_NUMBER := AVE(group,IF(stringlib.stringfilterout(d.APARTMENT_NUMBER,'0')<>'',100,0));

has_CITY := AVE(group,IF(stringlib.stringfilterout(d.CITY,'0')<>'',100,0));
has_STATE := AVE(group,IF(stringlib.stringfilterout(d.STATE,'0')<>'',100,0));
has_ZIP5_ZIP4_FOREIGN_POSTAL := AVE(group,IF(stringlib.stringfilterout(d.ZIP5_ZIP4_FOREIGN_POSTAL,'0')<>'',100,0));
has_RESIDENCE_COUNTY := AVE(group,IF(stringlib.stringfilterout(d.RESIDENCE_COUNTY,'0')<>'',100,0));
has_JOINT_OWNERSHIP_CODExAND_OR := AVE(group,IF(stringlib.stringfilterout(d.JOINT_OWNERSHIP_CODExAND_OR,'0')<>'',100,0));
has_flagvin := AVE(group,IF(stringlib.stringfilterout(d.flagvin,'0')<>'',100,0));
has_LICENSE_PLATE_NUMBERxBG4 := AVE(group,IF(stringlib.stringfilterout(d.LICENSE_PLATE_NUMBERxBG4,'0')<>'',100,0));
has_REGISTRATION_NUMBER := AVE(group,IF(stringlib.stringfilterout(d.REGISTRATION_NUMBER,'0')<>'',100,0));
has_REGISTRATION_TRANSACTION_ID := AVE(group,IF(stringlib.stringfilterout(d.REGISTRATION_TRANSACTION_ID,'0')<>'',100,0));
has_REGISTRATION_EFFECTIVE_DATE := AVE(group,IF(stringlib.stringfilterout(d.REGISTRATION_EFFECTIVE_DATE,'0')<>'',100,0));
has_REGISTRATION_EXPIRATION_DATE := AVE(group,IF(stringlib.stringfilterout(d.REGISTRATION_EXPIRATION_DATE,'0')<>'',100,0));
has_PLATE_ISSUE_DATE := AVE(group,IF(stringlib.stringfilterout(d.PLATE_ISSUE_DATE,'0')<>'',100,0));
has_VEHICLE_CLASS_CODE := AVE(group,IF(stringlib.stringfilterout(d.VEHICLE_CLASS_CODE,'0')<>'',100,0));
has_ARF_CREDIT := AVE(group,IF(stringlib.stringfilterout(d.ARF_CREDIT,'0')<>'',100,0));
has_DECAL_NUMBER := AVE(group,IF(stringlib.stringfilterout(d.DECAL_NUMBER,'0')<>'',100,0));


has_DECAL_YEAR := AVE(group,IF(stringlib.stringfilterout(d.DECAL_YEAR,'0')<>'',100,0));
has_DECAL_TYPE := AVE(group,IF(stringlib.stringfilterout(d.DECAL_TYPE,'0')<>'',100,0));
has_REGISTRATION_STATUS_CODE := AVE(group,IF(stringlib.stringfilterout(d.REGISTRATION_STATUS_CODE,'0')<>'',100,0));
has_REG_ONLY_REASON_CODE := AVE(group,IF(stringlib.stringfilterout(d.REG_ONLY_REASON_CODE,'0')<>'',100,0));
has_LICENSE_PLATE_CODE := AVE(group,IF(stringlib.stringfilterout(d.LICENSE_PLATE_CODE,'0')<>'',100,0));
has_REGISTRATION_USE := AVE(group,IF(stringlib.stringfilterout(d.REGISTRATION_USE,'0')<>'',100,0));
has_TRUE_LICENSE_PLSTE_NUMBER := AVE(group,IF(stringlib.stringfilterout(d.TRUE_LICENSE_PLSTE_NUMBER,'0')<>'',100,0));
has_flagmatchcode := AVE(group,IF(stringlib.stringfilterout(d.flagmatchcode,'0')<>'',100,0));
has_VESSEL_RESIDENT_STATUS := AVE(group,IF(stringlib.stringfilterout(d.VESSEL_RESIDENT_STATUS,'0')<>'',100,0));
  



has_ACTIVITY_DATExBG6 := AVE(group,IF(stringlib.stringfilterout(d.ACTIVITY_DATExBG6,'0')<>'',100,0));
has_ACTIVITY_COUNTY := AVE(group,IF(stringlib.stringfilterout(d.ACTIVITY_COUNTY,'0')<>'',100,0));
has_ACTIVITY_AGENCYxEG6 := AVE(group,IF(stringlib.stringfilterout(d.ACTIVITY_AGENCYxEG6,'0')<>'',100,0));
has_INSURANCE_COMPANY_CODExBG7 := AVE(group,IF(stringlib.stringfilterout(d.INSURANCE_COMPANY_CODExBG7,'0')<>'',100,0));
has_INSURANCE_NUMBER := AVE(group,IF(stringlib.stringfilterout(d.INSURANCE_NUMBER,'0')<>'',100,0));
has_INSURANCE_STATUS := AVE(group,IF(stringlib.stringfilterout(d.INSURANCE_STATUS,'0')<>'',100,0));
has_INSURANCE_TYPExEG7 := AVE(group,IF(stringlib.stringfilterout(d.INSURANCE_TYPExEG7,'0')<>'',100,0));
has_EMISSIONS_INSPECTION_STATUSxBG8 := AVE(group,IF(stringlib.stringfilterout(d.EMISSIONS_INSPECTION_STATUSxBG8,'0')<>'',100,0));
has_EMISSIONS_INSPECTION_DATE := AVE(group,IF(stringlib.stringfilterout(d.EMISSIONS_INSPECTION_DATE,'0')<>'',100,0));
has_EMISSIONS_INSP_REG_YEAR := AVE(group,IF(stringlib.stringfilterout(d.EMISSIONS_INSP_REG_YEAR,'0')<>'',100,0));
has_EMISSIONS_INSPECTION_LEVEL := AVE(group,IF(stringlib.stringfilterout(d.EMISSIONS_INSPECTION_LEVEL,'0')<>'',100,0));
has_EMISSIONS_CERTIFICATE_NUMBERxEG8 := AVE(group,IF(stringlib.stringfilterout(d.EMISSIONS_CERTIFICATE_NUMBERxEG8,'0')<>'',100,0));
has_TITLE_NUMBERxBG9 := AVE(group,IF(stringlib.stringfilterout(d.TITLE_NUMBERxBG9,'0')<>'',100,0));
has_TITLE_TRANSACTION_ID := AVE(group,IF(stringlib.stringfilterout(d.TITLE_TRANSACTION_ID,'0')<>'',100,0));
has_TITLE_ISSUE_DATE := AVE(group,IF(stringlib.stringfilterout(d.TITLE_ISSUE_DATE,'0')<>'',100,0));
has_PREVIOUS_TITLE_ISSUE_DATE := AVE(group,IF(stringlib.stringfilterout(d.PREVIOUS_TITLE_ISSUE_DATE,'0')<>'',100,0));
has_TITLE_STATUS_CODE := AVE(group,IF(stringlib.stringfilterout(d.TITLE_STATUS_CODE,'0')<>'',100,0));
has_TITLE_TYPE := AVE(group,IF(stringlib.stringfilterout(d.TITLE_TYPE,'0')<>'',100,0));
has_PREVIOUS_TITLE_STATE := AVE(group,IF(stringlib.stringfilterout(d.PREVIOUS_TITLE_STATE,'0')<>'',100,0));

has_SALVAGE_TYPE := AVE(group,IF(stringlib.stringfilterout(d.SALVAGE_TYPE,'0')<>'',100,0));
has_TITLE_PENDING_FLAG := AVE(group,IF(stringlib.stringfilterout(d.TITLE_PENDING_FLAG,'0')<>'',100,0));
has_NAME_TOO_LONG_FLAG := AVE(group,IF(stringlib.stringfilterout(d.NAME_TOO_LONG_FLAG,'0')<>'',100,0));
has_DUPLICATE_TITLE_FLAG := AVE(group,IF(stringlib.stringfilterout(d.DUPLICATE_TITLE_FLAG,'0')<>'',100,0));
has_BRAND_CODESx5 := AVE(group,IF(stringlib.stringfilterout(d.BRAND_CODESx5,'0')<>'',100,0));
has_EFS_STATUSxEG9 := AVE(group,IF(stringlib.stringfilterout(d.EFS_STATUSxEG9,'0')<>'',100,0));
has_LIEN_COUNTxBG10 := AVE(group,IF(stringlib.stringfilterout(d.LIEN_COUNTxBG10,'0')<>'',100,0));
has_LIEN_DATE := AVE(group,IF(stringlib.stringfilterout(d.LIEN_DATE,'0')<>'',100,0));

  
  
  
  
end;

stat_file := table(d,stat_rec,CUSTOMER_TYPE,few);


output(choosen(stat_file,all))
