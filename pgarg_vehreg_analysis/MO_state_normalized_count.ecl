//c := VehLic.File_Base_Vehicles_Dev(orig_state='OH'):PERSIST('~thor_data400::persist::File_OH_Vehlic');
c := VehLic.File_Base_Vehicles_Dev(orig_state='MO'):PERSIST('~thor_data400::persist::File_MO_Vehlic');

c_dist := distribute(c,hash(ORIG_VIN,REG_1_CUSTOMER_NAME));
c_sort := sort(c_dist,ORIG_VIN,REG_1_CUSTOMER_NAME,local);
c_dedup := dedup(c_sort,ORIG_VIN,REG_1_CUSTOMER_NAME,KEEP 1, right, local);
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
count(d);





