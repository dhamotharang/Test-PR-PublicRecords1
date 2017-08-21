 import Drivers, DriversV2, lib_stringlib, ut;
	TrimUpper(string s):= function
			return trim(stringlib.StringToUppercase(s),left,right);
	end;

  //***************** Conviction Mapping ****************************************************
  Layout_CP_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;

  Layout_CP_Common MNToCommon_ConvPoints(DriversV2.File_DL_MN_New_ConvPoints l) := transform
    self.process_date       	:=  l.process_date;
    self.dt_first_seen      	:=  self.process_date;
    self.dt_last_seen       	:=  self.process_date;
    self.src_state          	:=  'MN';
    self.DLCP_KEY           	:= 	trim(l.DLNUMBER,left, right);
    self.VIOLATION_DATE     	:=  trim(l.OFFENSE_DATE[5..8] ,left,right)+ trim(l.OFFENSE_DATE[1..2] ,left,right) + trim(l.OFFENSE_DATE[3..4] ,left,right);
	FELONY_CODE1                :=	['K','L','M','N','W','X'];
	FELONY_CODE2                :=	['G','F'];
	self.SENTENCE          		:= IF(TrimUpper(l.FELONY) IN FELONY_CODE1, 'M',IF(TrimUpper(l.FELONY) IN FELONY_CODE2,'F',''));
	self.SENTENCE_DESC          := IF(TRIM(SELF.SENTENCE,LEFT,RIGHT)='M','MISDEMEANOR',IF(TRIM(SELF.SENTENCE,LEFT,RIGHT)='F','FELONY',''));
	self.ST_OFFENSE_CONV_DESC	:= TrimUpper(l.CONVICTION);
	self 						:= [];
  end;

  
  export Mapping_DL_MN_New_As_ConvPoints := project(DriversV2.File_DL_MN_New_ConvPoints,MNToCommon_ConvPoints(left));

