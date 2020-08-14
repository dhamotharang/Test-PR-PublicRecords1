export MAC_Field_Declare := MACRO
import VehicleV2_Services, ut, STD;

string8 agerlow := '': stored('agelow');
#stored('agelower',agerlow);
string8 agerhigh :=  '': stored('agehigh');
#stored('agehigher',agerhigh);

boolean is_remote := false : stored('RemoteOptimization');

// We can't call Doxie.MAC_Header_Field_Declare because of a conflict with the type of the "Zip"
// input, so we need to recreate (with small changes) a few of its entries here...
string30 vin_val    := '' : stored('VIN');
string20 tag_val    := '' : stored('Tag');
string30 county_val := '' : stored('County');
string30 fname_val  := '' : stored('FirstName');
string30 mname_val  := '' : stored('MiddleName');
string30 lname_val  := '' : stored('LastName');
string30 city_val   := '' : stored('City');
string2  state_val  := '' : stored('State');
unsigned8 MaxResults_val         := 2000  : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000  : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val        := 0     : stored('SkipRecords');
unsigned1 DPPA_Purpose           := 0     : stored('DPPAPurpose');
integer CurrentYear              := 0     : stored('CurrentYear');
boolean UseTagBlur               := false : stored('UseTagBlur');
boolean noFail                   := false : stored('NoFail');
boolean raw_records              := false : stored('Raw');
boolean ln_branded_value         := false : stored('LnBranded');
boolean is_a_neighbor            := false : stored('isANeighbor');
boolean IncludeCriminalIndicators         := false : stored('IncludeCriminalIndicators');
boolean IncludeNonRegulatedVehicleSources := false : stored('IncludeNonRegulatedVehicleSources');
STRING6 ssn_mask_val       := 'NONE'    : stored('SSNMask');
unsigned1 dl_mask_val      := 0         : stored('DLMask');
string DataRestrictionMask := '1    0'  : stored('DataRestrictionMask');
set of string256 neighbor_service := [] : stored('NeighborService');
neighbor_data  := dataset([],doxie.Layout_Neighbors) : stored('NeighborData',few);
vin_value      := stringlib.stringtouppercase(vin_val)    : global;
tag_value      := stringlib.stringtouppercase(tag_val)    : global;
county_value   := stringlib.stringtouppercase(county_val) : global;
city_value     := stringlib.stringtouppercase(city_val)   : global;
state_value    := stringlib.stringtouppercase(state_val)  : global;
dppa_ok        := dppa_purpose > 0 and dppa_purpose < 8;
ssn_mask_value := StringLib.StringToUpperCase(ssn_mask_val) : global;
dl_mask_value  := dl_mask_val=1;

modelIndex := vehicle_wildcard.Key_ModelIndex;
bodyIndex  := Vehicle_Wildcard.Key_BodyStyle;

boolean containsSearch := false : stored('containsSearch');

// Zip inputs
set of string5 zips_in    := [] : stored('Zip');
string5  zip5_value       := '' : stored('Zip5');
unsigned2 zipradius_value := 1  : stored('ZipRadius');
string5 city_zip_value    := ziplib.CityToZip5(state_value,city_value) : global;

// Are we using wildcards in the Tag, VIN, or Zip fields?
doWild    := LENGTH(StringLib.StringFilter(tag_value,'*?')) > 0 : STORED('doWild');
doWildVIN := LENGTH(StringLib.StringFilter(vin_value,'*?')) > 0 : STORED('doWildVIN');
doWildZip := LENGTH(StringLib.StringFilter(zip5_value,'*?')) > 0 : STORED('doWildZip');

// Determine allowable zip codes based on Zip5, ZipRadius, Zip, County, City and State inputs
set of integer4 zipr_set := ut.fn_GetZipSet(,,zip5_value,,,zipradius_value);
set of integer4 zipcity_set := ut.fn_GetZipSet(,,city_zip_value,,,zipradius_value);
set of integer4 zipcnty_set := ut.fn_GetZipSet(,state_value,,county_value);
zipr_ds := project(dataset(zipr_set,{integer4 zip}),transform({string5 zip},self.zip := intformat(left.zip,5,1)));
zipcnty_ds := project(dataset(zipcnty_set,{integer4 zip}),transform({string5 zip},self.zip := intformat(left.zip,5,1)));
zipcity_ds := project(dataset(zipcity_set,{integer4 zip}),transform({string5 zip},self.zip := intformat(left.zip,5,1)));
set of string5 zips := map(
 doWildZip => [], // Zip wildcards override everythig else
 exists(zipr_ds) => set(zipr_ds,zip), // zip radius is preferred (Zip5+ZipRadius)
 exists(zipcity_ds) => set(zipcity_ds,zip), // zip radius of city (cityZip+ZipRadius)
 exists(zips_in) => zips_in,  // a list of zips is next-best (Zip)
 exists(zipcnty_ds) => set(zipcnty_ds,zip), // zips derived from county are better than nothing (County+State)
 []);
zip_dataset := dataset(zips, {string5 zip});
zip_use := set(zip_dataset, (unsigned3)zip) : STORED('zip_use');
// NOTE: One might argue that wildcard is supposed to behave more like a filter than a search, and
// therefore we should really be taking the union of the three different ways of entering zip
// codes. That seems pretty reasonable, but I don't believe anyone in product has asked for
// it. Thus, for now at least, it makes the most sense to make the minimal change to existing
// behavior here and just continue using an order of preference among the three methods.

zipCd:={string5 zip,unsigned1 code};
zipCdRec := dataset([{city_zip_value,ut.St2Code(ziplib.ZipToState2(city_zip_value))}],zipCd);
zipCdRecs := project(zip_dataset,transform(zipCd,
 self.zip:=left.zip,
 self.code:=ut.St2Code(ziplib.ZipToState2(left.zip))
 ));
set of unsigned1 state_use := set(dedup(sort(zipCdRec(code!=0)+zipCdRecs,code),code),code) : STORED('state_use');
  
string2 regState := '' : stored('registerState');
unsigned1 regState_use := IF(regState = '', -1, 
  ut.St2Code(stringlib.stringtouppercase(regState))) : STORED('regstate_use');

set of string4 _make := [] : stored('make');
make_use := vehicle_wildcard.Make2Code(_make) : stored('make_use');

set of string3 _majorColor := [] : stored('majorColor');
vehicle_wildcard.MAC_SetConvert(_majorColor, vehicle_wildcard.Color2Code, 
 majorColor_use, 'majorColor_use')

set of string3 _minorColor := [] : stored('minorColor');
vehicle_wildcard.MAC_SetConvert(_minorColor, vehicle_wildcard.Color2Code, 
 minorColor_use, 'minorColor_use')

set of string36 _model := [] : stored('model');
model_dataset := dataset(_model, {string36 m});

model_convert := JOIN(dedup (model_dataset, m, all), modelIndex,
  keyed((QSTRING36)LEFT.m = RIGHT.str[1..LENGTH(TRIM(Left.m))]),
  KEEP (100));
model_use := set(model_convert, i) : STORED('model_use');

set of string36 _body := [] : stored('body');
body_dataset := dataset(_body, {string36 b});

set of unsigned1 SortByTagTypes := [] : stored('SortByTagTypes');

body_convert := JOIN(dedup (body_dataset, b, all), bodyIndex,
  keyed(Stringlib.StringToUpperCase(LEFT.b) = RIGHT.body_style),
  KEEP (100));

body_use := set(body_convert, i) : stored('body_use');

STRING8 _modelYearStart    := '' : stored('modelYearStart');
integer modelYearStart_use := (INTEGER)_modelYearStart : STORED('modelYearStart_use');

STRING8 _modelYearEnd    := '' : stored('modelYearEnd');
integer modelYearEnd_use := (INTEGER)_modelYearEnd : STORED('modelYearEnd_use');

STRING8 _ageRangeStart := '' : stored('AgeLower');
integer ageRangeStart_ := IF(LENGTH(TRIM(_ageRangeStart)) < 4, 
 (INTEGER)_ageRangeStart,
 (INTEGER)ut.Age((UNSIGNED4)_ageRangeStart));

STRING8 _ageRangeEnd := '' : stored('AgeHigher');
integer ageRangeEnd_ := IF(LENGTH(TRIM(_ageRangeEnd)) < 4,
 (INTEGER)_ageRangeEnd,
 (INTEGER)ut.Age((UNSIGNED)_ageRangeEnd));

integer ageRangeStart_use := IF(ageRangeStart_ < ageRangeEnd_, ageRangeStart_, ageRangeEnd_) : stored('ageRangeStart_use'); 
integer ageRangeEnd_use   := IF(ageRangeStart_ < ageRangeEnd_, ageRangeEnd_, ageRangeStart_) : stored('ageRangeEnd_use');

STRING1 _sex := '' : stored('sex');
STRING8 sex_use := stringlib.stringtouppercase(_sex) : stored('sex_use');
STRING5 _filterLimit := '' : stored('filterLimit');
integer filterLimit_use := IF ((unsigned4 )_filterLimit=0, 500, (unsigned4)_filterLimit);

unsigned8 pre_MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');

set of string256 _neighbor_service_ip := [] : stored('NeighborService');

// allows to choose between record timeline statuses
historyConstant := VehicleV2_services.Constant.HISTORY;
unsigned1 USE_RECENT     := historyConstant.USE_RECENT; // CURRENT+EXPIRED
unsigned1 USE_CURRENT    := historyConstant.USE_CURRENT;
unsigned1 USE_EXPIRED    := historyConstant.USE_EXPIRED;
unsigned1 USE_HISTORICAL := historyConstant.USE_HISTORICAL;
unsigned1 USE_ALL        := historyConstant.USE_ALL;
boolean incDetailedReg := false      : stored('IncludeDetailedRegistrationType');
unsigned1 tline_temp1  := USE_RECENT : stored ('RegistrationType');
unsigned1 tline_temp2  := USE_RECENT : stored ('RecordStatus'); // no longer the preferred input value
unsigned1 tline_use    := map(
 tline_temp1>USE_RECENT AND tline_temp1<=USE_ALL => tline_temp1,
 tline_temp1=USE_RECENT AND tline_temp2<=USE_ALL => tline_temp2,
 USE_RECENT);
// NOTE: logic of EXPIRED records found to be different between wildcard and vehicle party:
// Wildcard Expired logic: "An Expired Registration is defined as a registration that has an expiration date in the past at the time of the build, but no more than twelve months in the past"
// Vehicle Party Expired logic: "An Expired flag will be set when no current record for same vehicle_key and iteration key and registration latest effective date within 12 months at the time of build"
// as a result expired records in wild file pulls flag from party record that could be either 'E' or 'H'
// So, we expect wildfile to contain only CURRENT('') or EXPIRED('E','H') records
set of string1 tline_allow := case(
 tline_use,
 USE_CURRENT => historyConstant.CURRENT,
 USE_EXPIRED => historyConstant.EXPIRED,
 USE_HISTORICAL => historyConstant.HISTORICAL,
 USE_ALL  => historyConstant.INCLUDEALL,
 historyConstant.INCLUDEALL);
// NOTE: Between 2007 and mid-2012, a change was in place that added EXPIRED records to the
// Wildfile and made them selectable in the query -- however, the query code erroneously
// referred to them as HISTORICAL records. This proved to be a point of significant
// confusion when a requirement to add HISTORICAL records was raised. Anyway, from
// this point forward we're calling them what they are: CURRENT, EXPIRED, or HISTORICAL.
// For backward compatibility, though, the incDetailedReg flag will indicate whether to
// use the corrected terminology in the history_name output field.

ENDMACRO;