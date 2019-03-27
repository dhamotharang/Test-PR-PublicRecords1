/*--SOAP--
<message name="VehicleReportRequest" wuTimeout="300000">
  <part name="DID" type="xsd:string"/>
  <part name="BDID" type="xsd:string"/>
  <part name="VID" type="xsd:string"/>
  <part name="StateCode" type="xsd:string"/>
  <part name="VehicleNumber" type="xsd:string"/>
  <part name="NeighborService" type="tns:EspStringArray"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="DataRestrictionMask" type="xsd:string" default="000000000000000000"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
  <part name="LnBranded" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service searches the vehicle file.*/

import codes;

export Vehicle_Report := MACRO
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
doxie.MAC_Header_Field_Declare()
qstring25 vid_value := '' : STORED('VID');
string2 st_code_value := '' : STORED('StateCode');
string20 veh_num_value := '' : STORED('VehicleNumber');
#CONSTANT('IncludeNonRegulatedVehicleSources', true);
report_in_recs := doxie.Vehicle_Search_Records;

report_rec := record
     Doxie.Layout_VehicleSearch;
	integer own_1_age;
	integer own_2_age;
	integer reg_1_age;
	integer reg_2_age;
	string120 VP_RESTRAINT_NAME;
	string20 VP_AIR_CONDITIONING_NAME;
	string20 VP_POWER_STEERING_NAME;
	string20 VP_POWER_BRAKES_NAME;
	string20 VP_POWER_WINDOWS_NAME;
	string20 VP_SECURITY_SYSTEM_NAME;
	string30 VP_ROOF_NAME;
	string30 VP_OPTIONAL_ROOF1_NAME;
	string30 VP_OPTIONAL_ROOF2_NAME;
	string20 VP_RADIO_NAME;
	string20 VP_OPTIONAL_RADIO1_NAME;
	string20 VP_OPTIONAL_RADIO2_NAME;
	string20 VP_TILT_WHEEL_NAME;
	string40 VP_ANTI_LOCK_BRAKES_NAME;
	string20 VP_DAYTIME_RUNNING_LIGHTS_NAME;
	string40 VP_FRONT_WHEEL_DRIVE_NAME;
	string40 VP_FOUR_WHEEL_DRIVE_NAME;
	string6 BASE_PRICE;
end;	

report_rec decode_them(report_in_recs l) := transform
	self.VP_RESTRAINT_NAME := codes.VEHICLE_REGISTRATION.VP_RESTRAINT(l.VP_RESTRAINT);
     self.VP_AIR_CONDITIONING_NAME := codes.VEHICLE_REGISTRATION.VP_AIR_CONDITIONING(l.VP_AIR_CONDITIONING);
	self.VP_POWER_STEERING_NAME := codes.VEHICLE_REGISTRATION.VP_POWER_STEERING(l.VP_POWER_STEERING);
	self.VP_POWER_BRAKES_NAME := codes.VEHICLE_REGISTRATION.VP_POWER_BRAKES(l.VP_POWER_BRAKES);
	self.VP_POWER_WINDOWS_NAME := codes.VEHICLE_REGISTRATION.VP_POWER_WINDOWS(l.VP_POWER_WINDOWS);
	self.VP_SECURITY_SYSTEM_NAME := codes.VEHICLE_REGISTRATION.VP_SECURITY_SYSTEM(l.VP_SECURITY_SYSTEM);
	self.VP_ROOF_NAME := codes.VEHICLE_REGISTRATION.VP_ROOF(l.VP_ROOF);
	self.VP_OPTIONAL_ROOF1_NAME := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF1(l.VP_OPTIONAL_ROOF1);
	self.VP_OPTIONAL_ROOF2_NAME := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF2(l.VP_OPTIONAL_ROOF2);
	self.VP_RADIO_NAME := codes.VEHICLE_REGISTRATION.VP_RADIO(l.VP_RADIO);
	self.VP_OPTIONAL_RADIO1_NAME := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO1(l.VP_OPTIONAL_RADIO1);
	self.VP_OPTIONAL_RADIO2_NAME := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO2(l.VP_OPTIONAL_RADIO2);
	self.VP_TILT_WHEEL_NAME := codes.VEHICLE_REGISTRATION.VP_TILT_WHEEL(l.VP_TILT_WHEEL);
	self.VP_ANTI_LOCK_BRAKES_NAME := codes.VEHICLE_REGISTRATION.VP_ANTI_LOCK_BRAKES(l.VP_ANTI_LOCK_BRAKES);
	self.VP_DAYTIME_RUNNING_LIGHTS_NAME := codes.VEHICLE_REGISTRATION.VP_DAYTIME_RUNNING_LIGHTS(l.VP_DAYTIME_RUNNING_LIGHTS);
	self.VP_FRONT_WHEEL_DRIVE_NAME := codes.VEHICLE_REGISTRATION.VP_FRONT_WHEEL_DRIVE(l.VP_FRONT_WHEEL_DRIVE);
	self.VP_FOUR_WHEEL_DRIVE_NAME := codes.VEHICLE_REGISTRATION.VP_FOUR_WHEEL_DRIVE(l.VP_FOUR_WHEEL_DRIVE);
	self.BASE_PRICE := l.VINA_PRICE;
	self := l;
end;

report_recs := project(report_in_recs, decode_them(left));

result_return := SORT(report_recs,nonDMVSource,history_name,history,orig_vin);

MAP( vid_value = '' AND did_value = '' AND st_code_value = '' AND  veh_num_value = ''
                                        =>   FAIL(3, doxie.ErrorCodes(3)),
	~dppa_ok 						=> 	FAIL(2, doxie.ErrorCodes(2)),
									output(result_return, NAMED('results')))

ENDMACRO;