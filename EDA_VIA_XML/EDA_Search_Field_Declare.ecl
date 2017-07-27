export EDA_Search_Field_Declare := MACRO

// Query options
string2 queryType_val_raw := '' : stored('queryType');
string2 queryType_val := Stringlib.StringToUpperCase(queryType_val_raw);

unsigned4 startRow_val := 1 : stored('startRow');
unsigned4 rowsRequested_val := 30 : stored('rowsRequested');

string1 showNonPublished_val_raw := 'Y' : stored('showNonPublished');
string1 showNonPublished_val := Stringlib.StringToUpperCase(showNonPublished_val_raw);

string1 useFirstInitial_val_raw := 'Y' : stored('useFirstInitial');
string1 useFirstInitial_val := Stringlib.StringToUpperCase(useFirstInitial_val_raw);

// Request attributes
unsigned2 surroundMiles_val := 0 : stored('surroundMiles');

string120 bizGovName_val_raw := '' : stored('bizGovName');
string120 bizGovName_val := Stringlib.StringToUpperCase(bizGovName_val_raw);

string20 firstName_val_raw := '' : stored('firstName');
string20 firstName_val := Stringlib.StringToUpperCase(firstName_val_raw);

string1 useSimilarFirstNames_val_raw := 'Y' : stored('useSimilarFirstNames');
string1 useSimilarFirstNames_val := Stringlib.StringToUpperCase(useSimilarFirstNames_val_raw);

string20 lastName_val_raw := '' : stored('lastName');
string20 lastName_val := Stringlib.StringToUpperCase(lastName_val_raw);

string1 useSimilarLastNames_val_raw := 'Y' : stored('useSimilarLastNames');
string1 useSimilarLastNames_val := Stringlib.StringToUpperCase(useSimilarLastNames_val_raw);

string25 city_val_raw := '' : stored('city');
string25 city_val := Stringlib.StringToUpperCase(city_val_raw);

string3 state_val_raw := '' : stored('state');
string3 state_val := Stringlib.StringToUpperCase(state_val_raw);

string5 postalCode_val := '' : stored('postalCode');
string4 postalCodeDetails_val := '' : stored('postalCodeDetails');
string3 phoneNpa_val := '' : stored('phoneNpa');
string3 phoneNxx_val := '' : stored('phoneNxx');
string4 phoneLine_val := '' : stored('phoneLine');

string120 address_val_raw := '' : stored('address');
string120 address_val := Stringlib.StringToUpperCase(address_val_raw);

string20 houseNumRange_val := '' : stored('houseNumRange');
string10 houseNum_val := '' : stored('houseNum');

string25 streetName_val_raw := '' : stored('streetName');
string25 streetName_val := Stringlib.StringToUpperCase(streetName_val_raw);

string1 sortCode_val := 'A' : stored('sortCode');

ENDMACRO;