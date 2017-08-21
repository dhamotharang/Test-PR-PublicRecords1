IMPORT Drivers, DriversV2, lib_stringlib, _Validate, ut;

EXPORT Mapping_DL_WY_As_ConvPoints := MODULE

  //********* Conviction Mapping *****************************************************************************
  in_Conv_file   := DriversV2.File_DL_WY_ConvPoints;

  Layout_Conv_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;

  Layout_Conv_Common trfToConviction(in_Conv_file l) :=  TRANSFORM
     SELF.process_date         := IF(_Validate.Date.fIsValid(l.process_date),l.process_date,'');
     SELF.dt_first_seen        := IF(_Validate.Date.fIsValid(stringlib.stringfilter(TRIM(l.Entrd_Sys_Date,LEFT,RIGHT),'0123456789') + '01') AND
	                                   _Validate.Date.fIsValid(stringlib.stringfilter(TRIM(l.Entrd_Sys_Date,LEFT,RIGHT),'0123456789') + '01',_Validate.Date.Rules.DateInPast)
																		,stringlib.stringfilter(TRIM(l.Entrd_Sys_Date,LEFT,RIGHT),'0123456789') + '01','');
     SELF.dt_last_seen         := IF(_Validate.Date.fIsValid(l.Conviction_Date),l.Conviction_Date,'');
     SELF.src_state            := 'WY';   
     SELF.DLCP_KEY             := ut.CleanSpacesAndUpper(l.DL_NUMBER);   
     SELF.TYPE_CD              := ut.CleanSpacesAndUpper(l.Record_Type);
     SELF.TYPE_DESC            := stringlib.StringToUpperCase(DriversV2.Tables_CP_WY.Record_Type(SELF.TYPE_CD));
     SELF.VIOLATION_DATE       := IF(_Validate.Date.fIsValid(l.offense_date) AND
	                                   _Validate.Date.fIsValid(l.offense_date,_Validate.Date.Rules.DateInPast),l.offense_date,'');
     SELF.CONVICTION_DATE      := IF(_Validate.Date.fIsValid(l.Conviction_Date) AND
	                                   _Validate.Date.fIsValid(l.Conviction_Date,_Validate.Date.Rules.DateInPast),l.Conviction_Date,'');
     SELF.ST_OFFENSE_CONV_CD   := TRIM(l.Conv_Code,LEFT,RIGHT);
     SELF.ST_OFFENSE_CONV_DESC := ut.CleanSpacesAndUpper(l.Conv_Desc);
     SELF.ACD_OFFENSE_CD       := TRIM(l.ACD_Code,LEFT,RIGHT);
     SELF.ACD_OFFENSE_DESC     := stringlib.StringToUpperCase(DriversV2.Tables_CP_WY.ACD_Code(SELF.ACD_OFFENSE_CD));
     SELF.STATE_OF_ORIGIN      := 'WY';    
     SELF                      := l;
     SELF                      := [];   
  END;

  EXPORT WY_As_Convictions := PROJECT(in_Conv_file, trfToConviction(LEFT));
	
END;