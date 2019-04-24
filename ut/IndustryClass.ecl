import AutoStandardI,codes,lib_date;

export IndustryClass := MODULE
	export Knowx_IC := 'CNSMR';
	export ENTRP_IC := 'ENTRP';
	export UTILI_IC := 'UTILI';
	export is_Knowx := AutoStandardI.InterfaceTranslator.industry_class_value.val(
		project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_value.params)) = Knowx_IC;	
	shared codesV3 := codes.Key_Codes_V3;

  export BH_Knowx_src := set(codesV3(file_name = 'BUSINESS-HEADER'

                                    AND field_name= (STRING50)'CONSUMER-PORTAL'

                                    AND field_name2= (STRING5)'ALLOW' )
									           ,code);
  	
	shared set of string gong_Hdr_src := ['R'];
	shared set of string gong_BHdr_src := ['B','G'];
	shared string search_type :='':STORED('GONG_SEARCHTYPE');
	shared set of string gong_src := IF(search_type='PERSON',gong_Hdr_src,IF(search_type='BUSINESS',gong_BHdr_src,[]));
  shared set of string gong_src1 := IF(Is_Knowx,gong_src,[]);		
	EXPORT gong_knowx_src := gong_src1;

  //ENTITLEMENT ATTRIBUTES
	SHARED string8 EntMonthVal1 := '': stored('ENTRP_Month_Value');
	EXPORT is_ENTRP := EntMonthVal1<>'';
	EXPORT integer EntMonthVal := (integer)EntMonthVal1;
	EXPORT integer EntDateVal :=  IF(EntMonthVal1<>'',IF(EntMonthVal in [0,1] ,EntMonthVal,EntMonthVal/12*365),0);
  export sys_date := (string)StringLib.GetDateYYYYMMDD():GLOBAL;
	EXPORT boolean is_valid_entrp(string dt) :=  (LIB_Date.DaysApart(dt ,sys_date)<= EntDateVal);
	
	EXPORT Get() := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));	
	//EXPORT Is_Utility := Get() = UTILI_IC;	// --deprecated, use Doxie.Compliance.isUtilityRestricted() instead
	
END;