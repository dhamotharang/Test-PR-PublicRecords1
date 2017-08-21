c := VehLic.File_Base_Vehicles_Dev(orig_state='NM'):PERSIST('~thor_data400::persist::File_NM_Vehlic');
//output(c(ORIG_VIN='02550628L'));

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
	string2          source_code := '';
    qstring8         price := '' ;
    unsigned4        seq_no := 0;
    qstring20        VEHICLE_NUMBERxBG1 := '' ;
    qstring25        ORIG_VIN := '' ;
    qstring10        VEHICLE_TRANSACTION_ID := '' ;
    qstring8         FIRST_REGISTRATION_DATE := '' ;
    qstring4         YEAR_MAKE := '' ;
    qstring5         MAKE_CODE := '' ;
    qstring4         VEHICLE_TYPE := '' ;
    qstring3         MODEL := '' ;
    qstring5         BODY_CODE := '' ;
    qstring1         VEHICLE_USE := '' ;
    qstring3         MAJOR_COLOR_CODE := '' ;
    qstring3         MINOR_COLOR_CODE := '' ;
    qstring2         TRANSFER_TYPE := '' ;
    qstring2         FUEL_TYPE := '' ;
    qstring9         UNIT_NUMBERxBG2 := '' ;
    qstring3         FLEET_NUMBER := '' ;
    qstring1         ODOMETER_STATUS := '' ;
    qstring8         ODOMETER_DATE := '' ;
    qstring7         ODOMETER_MILEAGE := '' ;
    qstring6         NET_WEIGHT := '' ;
    qstring6         GROSS_WEIGHT := '' ;
    qstring1         NUMBER_OF_AXLES := '' ;
    qstring4         HORSE_POWER := '' ;
    qstring4         CUBIC_CENTIMETERS := '' ;
    qstring3         LENGTH_FEET := '' ;
    qstring2         WIDTH_FEET := '' ;
    qstring2         MH_COUNTY_CODE := '' ;
    qstring2         MH_CITY_CODE := '' ;
    qstring2         VESSEL_PROPULSION_TYPE := '' ;
    qstring5         HULL_MATERIAL_TYPE := '' ;
    qstring3         VESSEL_TYPE := '' ;
    qstring1         VESSEL_WATER_TYPE := '' ;
    qstring8         flaghistory := '' ; 
    qstring1         FILE_HANDLER_ACTIVITY_FLAG := '' ;
    qstring1         CORRESPONDENCE_LETTER_FLAG := '' ;
    //qstring1         CUSTOMER_TYPExBG3 := '' ;
    //qstring10        OWN_1_CUSTOMER_NUMBER := '' ;
    //qstring9         OWN_1_FEID_SSN := '' ;
	unsigned1        CUSTOMER_TYPE :=0;
	qstring61        CUSTOMER_NAME := '' ;
    //qstring12        DEALER_LICENSE_NUMBER := '' ;
    //qstring13        DRIVER_LICENSE_NUMBER := '' ;
    //qstring8         DOB := '' ;
    //qstring1         SEX := '' ;
    //qstring1         SEXUAL_PREDATOR_FLAG := '' ;
    //qstring1         MAIL_SUPPESSION_FLAG := '' ;
    //qstring1         ADDR_NON_DISCLOSURE_FLAG := '' ;
    //qstring1         LAW_ENFORCEMENT_FLAG := '' ;
    //qstring10        ADDRESS_NUMBER := '' ;
    //qstring1         FOREIGN_ADDRESS_FLAG := '' ;
    //qstring61        STREET_ADDRESS := '' ;
    //qstring5         APARTMENT_NUMBER := '' ;
    //qstring34        CITY := '' ;
    //qstring2         STATE := '' ;
    //qstring11        ZIP5_ZIP4_FOREIGN_POSTAL := '' ;
    //qstring3         RESIDENCE_COUNTY := '' ;
end;


Layout_Normalize normalize_names(c_dedup l, unsigned1 cnt) := TRANSFORM
  self.CUSTOMER_NAME := choose(cnt, l.OWN_1_CUSTOMER_NAME, l.OWN_2_CUSTOMER_NAME, l.REG_1_CUSTOMER_NAME, l.REG_2_CUSTOMER_NAME, l.LH_1_CUSTOMER_NAME, l.LH_2_CUSTOMER_NAME, l.LH_3_CUSTOMER_NAME);
  self.CUSTOMER_TYPE := cnt;
  self := l;
end;

d := NORMALIZE(c_dedup,7,normalize_names(left,counter));
e := d(ORIG_VIN='02550628L');
output(e)



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
has_CUSTOMER_NAME := AVE(group,IF(stringlib.stringfilterout(d.CUSTOMER_NAME,'0')<>'' and trim(d.CUSTOMER_NAME,left,right)<>'NOT ON FILE' and trim(d.CUSTOMER_NAME,left,right)<>'MISSING LIEN INFO',100,0));
  
end;

stat_file := table(d,stat_rec,CUSTOMER_TYPE,few);


output(choosen(stat_file,all))
