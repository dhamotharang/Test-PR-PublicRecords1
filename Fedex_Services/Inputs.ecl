import fedex_services, doxie, address;

doxie.MAC_Header_Field_Declare()

export Inputs := MODULE

export phone 						:= phone_value;
export valid_phone			:= length(trim(phone)) >= fedex_services.Contants.min_LengthPhoneInput;

/* might want this code later to prevent them entering bogus phones.  cant use this as-is though because it calls all 800 number bogus.
my current thinking is that we arent going to be able to perfectly prevent these
//could also use something like Fedex_Services.fn_isBogusPhone
export phone 						:= phone_value;
shared phone_trim				:= trim(phone);
export valid_phone_len	:= length(phone_trim) >= fedex_services.Contants.min_LengthPhoneInput;
export valid_npanxx			:= exists(Risk_Indicators.Key_Telcordia_tds(keyed(npa = phone_trim[1..3] and nxx = phone_trim[4..6])));
export valid_phone			:= valid_phone_len and valid_npanxx;
*/
export isCanadaSearch   := addr_origin_country_value = address.Components.Country.CA;
shared cpc							:= can_poscode_value;
export valid_cpc				:= cpc <> '';

shared prim_range 			:= prange_value;
export valid_prim_range := prim_range <> '';

shared prim_name        := pname_value;
export valid_prim_name  := prim_name <> '';

shared zip							:= zip_value;		
export valid_zip				:= zip <> [];

export valid_addr				:= (valid_zip or valid_cpc) and (valid_prim_range or valid_prim_name);

export lname						:= lname_value;
export valid_lname			:= length(trim(lname)) >= fedex_services.Contants.min_LengthLnameInput;

export state						:= state_value;
export valid_state			:= length(trim(state)) = 2;
export CustomerDataOnly := false:stored('CustomerDataOnly');
export CustomerDataMaxRecords := fedex_services.Contants.max_FedexSourcedResultsAdmin:stored('CustomerDataMaxRecords');

END;