import AutoStandardI, codes;

export IndustryClass := MODULE
  export Knowx_IC := 'CNSMR';
  export is_Knowx := AutoStandardI.InterfaceTranslator.industry_class_value.val(
    project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_value.params)) = Knowx_IC;
  codesV3 := codes.Key_Codes_V3;

  export BH_Knowx_src := set(codesV3(file_name = 'BUSINESS-HEADER'

                                    AND field_name= (STRING50)'CONSUMER-PORTAL'

                                    AND field_name2= (STRING5)'ALLOW' )
                             ,code);

  //ENTITLEMENT ATTRIBUTES
  SHARED string8 EntMonthVal1 := '': stored('ENTRP_Month_Value');
  EXPORT is_ENTRP := EntMonthVal1<>'';
  EXPORT integer EntMonthVal := (integer)EntMonthVal1;
  EXPORT integer EntDateVal :=  IF(EntMonthVal1<>'',IF(EntMonthVal in [0,1] ,EntMonthVal,EntMonthVal/12*365),0);

  EXPORT Get() := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));

END;
