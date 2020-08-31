EXPORT MAC_Doxie_Wildcard_Search() := MACRO
IMPORT WSInput;

WSInput.MAC_Vehicle_Tag_Types_Help_Text();

#WEBSERVICE(FIELDS(
    //single line text fields
        'FirstName','MiddleName','LastName',
        'sex','sex_use','Tag','VIN',
        'City','State','County','Zip5','ZipRadius',
        'agehigh','AgeHigher','agelow','AgeLower','ageRangeStart_use','ageRangeEnd_use',
        'modelYearStart','modelYearStart_use','modelYearEnd','modelYearEnd_use',
        'recordbydate','RecordStatus','registerState','RegistrationType','regstate_use',
        'CurrentYear','MaxResults','MaxResultsThisTime','SkipRecords','lexidsourceoptout',
        'DataRestrictionMask','DLMask','DPPAPurpose','glbpurpose','industryclass','SSNMask',
    //boolean options
        'IncludeCriminalIndicators','IncludeNonRegulatedVehicleSources','containsSearch',
        'allowall','allowdppa','allowglb','keepoldssns','includeminors','usingkeepssns',
        'RemoteOptimization','UseTagBlur','NoFail','Raw',
    //datasets / sets / multiline text fields
        'SortByTagTypes','body','body_use','majorColor','majorcolor_use','make','make_use',
        'model','model_use','state_use','Zip','zip_use'
),HELP(help_text));

ENDMACRO;