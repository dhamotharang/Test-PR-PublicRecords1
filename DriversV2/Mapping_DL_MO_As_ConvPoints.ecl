Import Drivers, DriversV2, lib_stringlib;

export Mapping_DL_MO_As_ConvPoints := module

  //********* Conviction Mapping *****************************************************************************
  in_Conv_file   := ascii(DriversV2.File_DL_MO_Points);

  alphanumeric := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 ';

  in_Conv_file_fltd := in_Conv_file(length(stringlib.stringFilter(D_CD_CONV_VIOL_PTCONV, alphanumeric)) > 0);

  Layout_Conv_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;

  Layout_Conv_Common trfToConviction(in_Conv_file_fltd l) :=  transform
     self.process_date         := StringLib.stringFilter(l.process_date, '0123456789');
     self.dt_first_seen        := self.process_date;
     self.dt_last_seen         := self.process_date;
     self.src_state            := 'MO';   
     self.DLCP_KEY             := trim(l.D_NO_UNIQUE_ID_PTUKEY,left,right);   
     self.TYPE_CD              := stringlib.StringToUpperCase(trim(l.D_CD_CONV_VIOL_PTCONV,left,right));
     self.TYPE_DESC            := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO.Conviction_Type(self.TYPE_CD));
     self.VIOLATION_DATE       := stringlib.stringFilter(l.D_DA_ARREST_PTCONV,'0123456789');
     self.CONVICTION_DATE      := stringlib.stringFilter(l.D_DA_CONVICTION_PTCONV,'0123456789');
     self.COURT_NAME_CD        := stringlib.StringToUpperCase(trim(l.D_NO_COURT_ORI_PTCONV,left,right));
     self.COURT_NAME_DESC      := stringlib.StringToUpperCase(Tables_CP_MO.Court(self.COURT_NAME_CD));
     self.COURT_TYPE_CD        := stringlib.StringToUpperCase(trim(l.D_NO_ARST_AGY_ORI_PTCONV,left,right));
     self.COURT_TYPE_DESC      := stringlib.StringToUpperCase(Tables_CP_MO.Court(self.COURT_TYPE_CD));
     self.ST_OFFENSE_CONV_CD   := stringlib.StringToUpperCase(trim(l.D_CD_CONV_VIOL_PTCONV,left,right));
     self.ST_OFFENSE_CONV_DESC := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO.Convictions(self.ST_OFFENSE_CONV_CD));
     self.POINTS               := stringlib.StringToUpperCase(trim(l.D_NO_POINTS_ASSESSED_PTCONV,left,right));
     self.ACD_OFFENSE_CD       := stringlib.StringToUpperCase(trim(l.D_CD_ARST_VIOL_PTCONV,left,right));
     self.ACD_OFFENSE_DESC     := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO.Convictions(self.ACD_OFFENSE_CD));
     self.STATE_OF_ORIGIN      := stringlib.StringToUpperCase(trim(l.D_CD_CONV_VIOL_PTCONV,left,right));   
     self                      := l;
     self                      := [];   
  end;

  export MO_As_Convictions := project(in_Conv_file_fltd, trfToConviction(left));
  
  //********* Suspension Mapping *****************************************************************************
  
  in_Susp_file   := ascii(DriversV2.File_DL_MO_Actions);

  Layout_Susp_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Suspensions;

  Layout_Susp_Common trfToSuspensions(in_Susp_file l) :=  transform
     self.process_date         := StringLib.stringFilter(l.process_date, '0123456789');
     self.dt_first_seen        := self.process_date;
     self.dt_last_seen         := self.process_date;
     self.src_state            := 'MO';   
     self.DLCP_KEY             := trim(l.D_NO_UNIQUE_ID_ATKEY,left,right);
     self.TYPE_CD              := stringlib.StringToUpperCase(trim(l.D_CD_ACTION_STAT_ATCAS,left,right));
     self.TYPE_DESC            := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO.Suspension_Type(self.TYPE_CD));
     self.ACTION_DATE          := stringlib.stringFilter(l.D_DA_ACTION_STAT_ATCAS,'0123456789');
     self.START_DATE           := stringlib.stringFilter(l.D_DA_EFFECTIVE_ATCAS,'0123456789');
     self.END_DATE             := stringlib.stringFilter(l.D_DA_ELIG_REINST_ATCAS,'0123456789');
     self.COURT_CASE_NBR       := stringlib.StringToUpperCase(trim(l.D_NO_CASE_ATCAS,left,right));
     self.WD_REASON_CD         := stringlib.StringToUpperCase(trim(l.D_CD_ACTION_TYPE_ATCAS,left,right));
     self.WD_REASON_DESC       := stringlib.StringToUpperCase(Tables_CP_MO.Suspensions(self.WD_REASON_CD));
     self.CONVICTION_DATE      := stringlib.stringFilter(l.D_DA_CONVICTED_ATCAS,'0123456789');
     self.ARREST_DATE          := stringlib.stringFilter(l.D_DA_ARREST_ATCAS,'0123456789');
     self.ACCIDENT_DATE        := stringlib.stringFilter(l.D_DA_OFFENSE_ATCAS,'0123456789');
     self                      := l;
     self                      := [];
  end;

  export MO_As_Suspension := project(in_Susp_file, trfToSuspensions(left));
  
  //********* Drivers Record Information Mapping *****************************************************************
  
  in_DR_Info_file   := ascii(DriversV2.File_DL_MO_DPRDPS);

  Layout_DR_Info_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Driver_Record_Info;

  Layout_DR_Info_Common trfToDRInfo(in_DR_Info_file l) :=  transform
     self.process_date         := StringLib.stringFilter(l.process_date, '0123456789');
     self.dt_first_seen        := self.process_date;
     self.dt_last_seen         := self.process_date;
     self.src_state            := 'MO';      
     self.DLCP_KEY             := trim(l.D_NO_UNIKEY,left,right);
     self.TYPE_CD              := stringlib.StringToUpperCase(trim(l.D_CD_PRIV_TYPE_LDPRDP,left,right));
     self.TYPE_DESC            := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO.Convictions(self.TYPE_CD));
     self.ACTION_DATE          := stringlib.stringFilter(l.D_DA_EFFECTIVE_LDPRDP,'0123456789');
     self.EXPUNGED_DATE        := stringlib.stringFilter(l.D_DA_EXPIRATION_LDPRDP,'0123456789');
     self                      := l;
     self                      := [];   
  end;

  export MO_As_DR_Info := project(in_DR_Info_file, trfToDRInfo(left));


end;