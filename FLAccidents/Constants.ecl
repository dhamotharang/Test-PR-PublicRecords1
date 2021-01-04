Import FLAccidents_Ecrash;
Import dx_eCrash as dx;

export Constants := module
	
//***************************************************************
//           autokeys constants for eCrashV2
//***************************************************************
  export ak_skipSet	:= dx.Constants.ak_skipSet;
	export ak_typeStr	:= dx.Constants.ak_typeStr;
	
	export eV2_keyname  := dx.Constants.ak_keyname;
	export eV2_dataset	:= dx.Constants.ak_dataset;
end;
