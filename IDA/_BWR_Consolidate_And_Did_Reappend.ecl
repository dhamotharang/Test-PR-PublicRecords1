import std,ida;

EXPORT _BWR_Consolidate_And_Did_Reappend(string pversion='',boolean pUseProd=false) := function
version:=if(pversion='',IDA._Constants(pUseProd).filesdate,pversion);
return if(IDA._Flags().IDA_Daily_Base_Build_Active='',IDA.FN_Consolidate_And_Reappend_Did(pversion,pUseProd,false).All,Output('Daily Base Build Still Running,Please Try Run Later'));

end;
