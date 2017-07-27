import doxie, AutoStandardI, Accident_Services;

export FLCrash_Search_Records (dataset (doxie.layout_references) dids) := function

glbMod := AutoStandardI.GlobalModule();

tempmod := MODULE(PROJECT(glbMod,Accident_Services.IParam.searchRecords,opt));
	EXPORT BOOLEAN  EnableNationalAccidents := FALSE : STORED('EnableNationalAccidents');
	EXPORT BOOLEAN  EnableExtraAccidents := FALSE : STORED('EnableExtraAccidents');
	EXPORT STRING32 ApplicationType := '': STORED('ApplicationType');
	EXPORT STRING2  Accident_State := '' : STORED('AccidentState');
	EXPORT BOOLEAN  mask_dl := AutoStandardI.InterfaceTranslator.dl_mask_value.val(
			PROJECT(glbMod,AutoStandardI.InterfaceTranslator.dl_mask_value.params)); 
	EXPORT UNSIGNED4 dateVal := AutoStandardI.InterfaceTranslator.dateVal.val(
			PROJECT(glbMod,AutoStandardI.InterfaceTranslator.gdate.params)); 
end;

fcrash_recs := Accident_Services.Raw.CrsAccidentRpt(dids,tempmod);

return fcrash_recs;
end;
