export MAC_Header_Field_Declare(isFCRA = false) := MACRO

doxie.MAC_Header_Field_Declare(isFCRA);

string60 sid_value            := ''    : stored('SeisintPrimaryKey');
boolean newIncludeHistorical := false : stored('IncludeHistoricalAddresses');
boolean newIncludeUnRegistered := false :stored('IncludeUnRegisteredAddresses');
boolean IncludeAssociates := false : stored('IncludeAssociatedAddresses');

boolean oldIncludeHistorical := false : stored('IncludeHistoricalAltAddresses');
boolean oldIncludeNonRegistered := false : stored('IncludeNonRegisteredAltAddresses');
boolean oldIncludeRelatives := false : stored('IncludeRelativeAltAddresses');

boolean  includeHistorical    := newIncludeHistorical or oldIncludeHistorical;
boolean  includeRelatives     := IncludeAssociates or oldIncludeRelatives;
boolean  excludeRegistered    := false : stored('ExcludeRegisteredAltAddresses');
boolean  includeNonRegistered := newIncludeUnRegistered or oldIncludeNonRegistered;
boolean is_sexoffender_report := false : stored('IsSexOffenderReport');

boolean	 includeExtra := (includeHistorical OR includeRelatives OR includeNonRegistered) AND
                                             (is_sexoffender_report or 
									(pname_value<>'' OR prange_value<>'' OR zip_value<>[] OR city_value<>'' OR state_value<>''));

boolean    is_zip_only_search := ssn_value='' and lname_value='' and fname_value='' and mname_value='' and rel_fname_val1='' and
                                 addr_value='' and city_value='' and state_val='' //state_value can get value from zip
						   and phone_value='' and did_value='' and zip_value<>[];

boolean    is_zip_city_search := ssn_value='' and lname_value='' and fname_value='' and mname_value='' and rel_fname_val1='' and
                                 addr_value='' and city_value<>'' 
						   and phone_value='' and find_year_low=0 and find_year_high=0
						   and did_value='' and zip_value<>[];

boolean    is_zip_mname_search := ssn_value='' and lname_value='' and fname_value='' and mname_value<>'' and rel_fname_val1='' and
                                  addr_value='' and city_value='' and state_val='' //state_value can get value from zip
						    and phone_value='' and find_year_low=0 and find_year_high=0
						    and did_value='' and zip_value<>[];
						   
ENDMACRO;