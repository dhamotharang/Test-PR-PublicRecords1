import Drivers, Address, ut, lib_stringlib;

export Cleaned_DL_MO_Icissu(string processDate, string fileDate) := function

	in_file := ascii(DriversV2.File_DL_MO_Icissu_Update(fileDate));

	layout_out := drivers.Layout_MO_icissu_raw;
	
	layout_out mapClean(in_file l) := transform
	  self.process_date                 := lib_stringlib.stringlib.stringfilter(processDate,'0123456789');
	  self.D_NO_UNIQUE_ID_ISKEY         := stringlib.StringToUpperCase(trim(l.D_NO_UNIQUE_ID_ISKEY,left,right));
	  self.D_DA_DATE_ADDED_ISKEY        := stringlib.StringToUpperCase(trim(l.D_DA_DATE_ADDED_ISKEY,left,right));
	  self.D_DA_PURGE_ISKEY             := stringlib.StringToUpperCase(trim(l.D_DA_PURGE_ISKEY,left,right));
	  self.D_CD_SPECIAL_ISKEY           := stringlib.StringToUpperCase(trim(l.D_CD_SPECIAL_ISKEY,left,right));
	  self.D_NA_USER_ID_ISKEY           := stringlib.StringToUpperCase(trim(l.D_NA_USER_ID_ISKEY,left,right));
	  self.D_DA_PROCESS_ISKEY           := stringlib.StringToUpperCase(trim(l.D_DA_PROCESS_ISKEY,left,right));
	  self.FILLER                       := stringlib.StringToUpperCase(trim(l.FILLER,left,right));
	  self.D_CD_RECORD_TYPE_ISHIS       := stringlib.StringToUpperCase(trim(l.D_CD_RECORD_TYPE_ISHIS,left,right));
	  self.D_CD_TRANS_TYPE_ISHIS        := stringlib.StringToUpperCase(trim(l.D_CD_TRANS_TYPE_ISHIS,left,right));
	  self.D_CD_TRANS_CHG_ISHIS         := stringlib.StringToUpperCase(trim(l.D_CD_TRANS_CHG_ISHIS,left,right));
	  self.D_NO_SEQUENTIAL_YY_ISHIS     := stringlib.StringToUpperCase(trim(l.D_NO_SEQUENTIAL_YY_ISHIS,left,right));
	  self.D_NO_SEQUENTIAL_OFFICE_ISHIS := stringlib.StringToUpperCase(trim(l.D_NO_SEQUENTIAL_OFFICE_ISHIS,left,right));
	  self.D_NO_SEQUENTIAL_JUL_ISHIS    := stringlib.StringToUpperCase(trim(l.D_NO_SEQUENTIAL_JUL_ISHIS,left,right));
	  self.D_NO_SEQUENTIAL_NO1_ISHIS    := stringlib.StringToUpperCase(trim(l.D_NO_SEQUENTIAL_NO1_ISHIS,left,right));
	  self.D_NO_SEQUENTIAL_NO2_ISHIS    := stringlib.StringToUpperCase(trim(l.D_NO_SEQUENTIAL_NO2_ISHIS,left,right));
	  self.D_DA_EXPIRATION_ISHIS        := stringlib.StringToUpperCase(trim(l.D_DA_EXPIRATION_ISHIS,left,right));
	  self.D_CD_CLASS_ISHIS             := stringlib.StringToUpperCase(trim(l.D_CD_CLASS_ISHIS,left,right));
	  self.FILLER1                      := stringlib.StringToUpperCase(trim(l.FILLER1,left,right));
	  self.D_CD_ENDORSEMENTS_X_ISHIS    := stringlib.StringToUpperCase(trim(l.D_CD_ENDORSEMENTS_X_ISHIS,left,right));
	  self.D_CD_RESTRICTIONS_X_ISHS     := stringlib.StringToUpperCase(trim(l.D_CD_RESTRICTIONS_X_ISHS,left,right));
	  self.FILLER2                      := stringlib.StringToUpperCase(trim(l.FILLER2,left,right));
	  self.D_NO_TEST_NUMBER_ISHIS       := stringlib.StringToUpperCase(trim(l.D_NO_TEST_NUMBER_ISHIS,left,right));
	  self.D_NO_MICROFILM_ISHIS         := stringlib.StringToUpperCase(trim(l.D_NO_MICROFILM_ISHIS,left,right));
	  self.D_DA_MICROFILM_ISHIS         := stringlib.StringToUpperCase(trim(l.D_DA_MICROFILM_ISHIS,left,right));
	  self.D_DA_PROCESS_ISHIS           := stringlib.StringToUpperCase(trim(l.D_DA_PROCESS_ISHIS,left,right));
	  self.D_DA_LICENSE_MAILED_ISHIS    := stringlib.StringToUpperCase(trim(l.D_DA_LICENSE_MAILED_ISHIS,left,right));
	  self.D_CD_PROCESS_ISHIS           := stringlib.StringToUpperCase(trim(l.D_CD_PROCESS_ISHIS,left,right));
	  self.D_CD_PROCESS_REASON_ISHIS    := stringlib.StringToUpperCase(trim(l.D_CD_PROCESS_REASON_ISHIS,left,right));
      self.D_DA_RETAKE_ISSUED_ISHIS     := stringlib.StringToUpperCase(trim(l.D_DA_RETAKE_ISSUED_ISHIS,left,right));
	  self.D_CD_RETAKE_ISHIS            := stringlib.StringToUpperCase(trim(l.D_CD_RETAKE_ISHIS,left,right));
	  self.D_DA_LAST_UPDATE_ISHIS       := stringlib.StringToUpperCase(trim(l.D_DA_LAST_UPDATE_ISHIS,left,right));
	  self.D_NA_USER_ID_ISHIS           := stringlib.StringToUpperCase(trim(l.D_NA_USER_ID_ISHIS,left,right));
	  self.FILLER3                      := stringlib.StringToUpperCase(trim(l.FILLER3,left,right));
	  self.D_CD_COMPACT_TYPE_ISCPS      := stringlib.StringToUpperCase(trim(l.D_CD_COMPACT_TYPE_ISCPS,left,right));
	  self.D_DA_SURRENDER_ISCPS         := stringlib.StringToUpperCase(trim(l.D_DA_SURRENDER_ISCPS,left,right));
	  self.D_NA_STATE_ISCPS             := stringlib.StringToUpperCase(trim(l.D_NA_STATE_ISCPS,left,right));
	  self.D_CD_SURRENDER_TYPE_ISCPS    := stringlib.StringToUpperCase(trim(l.D_CD_SURRENDER_TYPE_ISCPS,left,right));
	  self.D_NO_OS_LICENSE_NO_ISCPS     := stringlib.StringToUpperCase(trim(l.D_NO_OS_LICENSE_NO_ISCPS,left,right));			
      self.D_DA_PROCESS_ISCPS           := stringlib.StringToUpperCase(trim(l.D_DA_PROCESS_ISCPS,left,right));
      self.D_NA_USER_ID_ISCPS           := stringlib.StringToUpperCase(trim(l.D_NA_USER_ID_ISCPS,left,right));
      self.FILLER4                      := stringlib.StringToUpperCase(trim(l.FILLER4,left,right));
      self.D_CD_COMPACT_TYPE_ISCPS_1    := stringlib.StringToUpperCase(trim(l.D_CD_COMPACT_TYPE_ISCPS_1,left,right));
      self.D_DA_SURRENDER_ISCPS_1       := stringlib.StringToUpperCase(trim(l.D_DA_SURRENDER_ISCPS_1,left,right));
      self.D_NA_STATE_ISCPS_1           := stringlib.StringToUpperCase(trim(l.D_NA_STATE_ISCPS_1,left,right));
      self.D_CD_SURRENDER_TYPE_ISCPS_1  := stringlib.StringToUpperCase(trim(l.D_CD_SURRENDER_TYPE_ISCPS_1,left,right));
	  self.D_NO_OS_LICENSE_NO_ISCPS_1   := stringlib.StringToUpperCase(trim(l.D_NO_OS_LICENSE_NO_ISCPS_1,left,right));
	  self.D_DA_PROCESS_ISCPS_1         := stringlib.StringToUpperCase(trim(l.D_DA_PROCESS_ISCPS_1,left,right));
	  self.D_NA_USER_ID_ISCPS_1         := stringlib.StringToUpperCase(trim(l.D_NA_USER_ID_ISCPS_1,left,right));
	  self.FILLER5                      := stringlib.StringToUpperCase(trim(l.FILLER5,left,right));
      self                              := l;		
	end;

	Cleaned_MO_Icissu_File := project(in_file, mapClean(left));
	
	return Cleaned_MO_Icissu_File;
end;
