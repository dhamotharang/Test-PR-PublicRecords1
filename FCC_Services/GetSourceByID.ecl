// ========================================================
// Returns FCC's info from the source file;
// ========================================================

IMPORT FCC,doxie, codes, census_data, suppress, ut;

out_rec := FCC_Services.layouts.SourceOutput;

// trims leading zeros, appends the desired "tail" after decimal point:
string FormatString (string source, unsigned1 decimals) := FUNCTION
  unsigned1 tail_len := IF (decimals > 6, 6, decimals);
  string zero_str := '000000';

  //cut leading and trailing zeros:
  real val := (real) source;
  string temp := (string) val;

  // set desired number of chars after decimal point
  dec_point := stringlib.stringFind (temp, '.', 1);
  len := length (temp);
  res := IF (dec_point = 0, temp + '.' + zero_str[1..tail_len],
            temp + zero_str[1..tail_len - (len - dec_point)]);
  return IF (val = 0, '', res);
END;
 
EXPORT out_rec GetSourceByID (GROUPED DATASET (FCC_Services.layouts.id) in_ids, string32 appType) := FUNCTION

  out_rec GetCommonInfo (FCC.key_fcc_seq R) := TRANSFORM
//    SELF.gender_exp := codes.GENERAL.gender (stringlib.stringtouppercase (R.GENDER_CD)[1]);
    SELF.name_attention.title := R.attention_title;
    SELF.name_attention.fname := R.attention_fname;
    SELF.name_attention.mname := R.attention_mname;
    SELF.name_attention.lname := R.attention_lname;
    SELF.name_attention.name_suffix := R.attention_name_suffix;
    SELF.name_attention.name_score := R.attention_name_score;

    SELF.address.prim_range := R.prim_range;
    SELF.address.predir := R.predir;
    SELF.address.prim_name := R.prim_name;
    SELF.address.addr_suffix := R.addr_suffix;
    SELF.address.postdir := R.postdir;
    SELF.address.unit_desig := R.unit_desig;
    SELF.address.sec_range := R.sec_range;
    SELF.address.p_city_name := R.p_city_name;
    SELF.address.v_city_name := R.v_city_name;
    SELF.address.st := R.st;
    SELF.address.zip5 := R.zip5;
    SELF.address.zip4 := R.zip4;
    SELF.address.fips_state := R.fips_state;
    SELF.address.fips_county := R.fips_county;
    SELF.address.addr_rec_type := R.addr_rec_type;

    // set state
    SELF.address.state := stringlib.StringToUpperCase (codes.general.state_long (R.st));
    // county full name calculated after
    SELF.address.county := '';

    SELF.addr_firm := R.firm;
    // set state
    SELF.addr_firm.state := stringlib.StringToUpperCase (codes.general.state_long (R.firm.st));
    // county full name calculated after
    SELF.addr_firm.county := '';

    // translations
    SELF.license_type_desc := FCC_Services.MapLicenseType (R.license_type);
    SELF.pending_granted_desc := MAP (
      R.pending_or_granted = 'P' => 'PENDING',
      R.pending_or_granted = 'G' => 'GRANTED',
      '');
    SELF.service_code_desc := FCC_Services.MapServiceCode (R.radio_service_code);
    // get class description
    v3codes := codes.key_codes_v3 (keyed(file_name='FCC'), keyed(field_name='CLASS_OF_STATION'), keyed(field_name2=''), keyed(code='MO'));
    SELF.class_desc := SET (LIMIT (v3codes, 1, KEYED), long_desc)[1];

    SELF.last_change_desc := MAP (
      R.type_of_last_change = 'A' => 'ASSIGNMENT',
      R.type_of_last_change = 'C' => 'CONVERSION',
      R.type_of_last_change = 'D' => 'DUPLICATE',
      R.type_of_last_change = 'E' => 'EXPIRED',
      R.type_of_last_change = 'F' => 'MODIFICATION, ASSIGNMENT, RENEWAL',
      R.type_of_last_change = 'G' => 'ASSIGNMENT, RENEWAL',
      R.type_of_last_change = 'H' => 'MODIFICATION, RENEWAL',
      R.type_of_last_change = 'M' => 'MODIFICATION',
      R.type_of_last_change = 'N' => 'NEW',
      R.type_of_last_change = 'O' => 'OTHER',
      R.type_of_last_change = 'R' => 'RENEWAL FROM 574',
      R.type_of_last_change = 'S' => 'SUPERSEDE',
      R.type_of_last_change = 'T' => 'TRANSFER OF CONTROL',
      R.type_of_last_change = 'U' => 'RENEWAL FROM FORM 574R OR 405A',
      R.type_of_last_change = 'W' => 'WITHDRAWN',
      R.type_of_last_change = 'X' => 'REINSTATEMENT',
      R.type_of_last_change = 'Z' => 'CHANGE OF NAME OR MAILING ADDRESS',
      '');

    pre_lat := (unsigned1) R.latitude [1..2] + (decimal8_6)(((real) R.latitude[3..4]) / 60 + ((real) R.latitude[5..6]) / 3600); 
    pre_long := (unsigned1) R.longitude [1..3] + (decimal9_6)(((real) R.longitude[4..5]) / 60 + ((real) R.longitude[6..7]) / 3600); 
	
    SELF.latitude := IF(pre_lat=0,'',(STRING)pre_lat);
    SELF.longitude := IF(pre_long=0,'',(STRING)pre_long);

    SELF.transmitters_antenna_height         := FormatString (R.transmitters_antenna_height, 2); // "8-digit" fields in spec (7, actually)
    SELF.transmitters_height_above_avg_terra := FormatString (R.transmitters_height_above_avg_terra, 2);
    SELF.transmitters_height_above_ground_le := FormatString (R.transmitters_height_above_ground_le, 2);
    SELF.power_of_this_frequency             := FormatString (R.power_of_this_frequency, 2);            // "9-digit"
    SELF.frequency_Mhz                       := FormatString (R.frequency_Mhz, 4);
    SELF.effective_radiated_power            := FormatString (R.effective_radiated_power, 2);

    // cut leading zeros and suppress output, if zero
    n_units := (unsigned4) R.number_of_units_authorized_on_freq;
    SELF.number_of_units_authorized_on_freq := IF (n_units = 0, '', (string) n_units);

    SELF := R;
  END;
  
  fetched := JOIN (in_ids, FCC.key_fcc_seq,
                   keyed (Left.fcc_seq = Right.fcc_seq),
                   GetCommonInfo (Right),
                   KEEP (1)); 

  // pull DIDs
	Suppress.MAC_Suppress(fetched,did_pulled,appType,Suppress.Constants.LinkTypes.DID,attention_did);

  // add county name
  census_data.MAC_Fips2County_Keyed (did_pulled, address.st, address.fips_county, address.county, ds_cnty);
  census_data.MAC_Fips2County_Keyed (ds_cnty, addr_firm.st, addr_firm.fips_county, addr_firm.county, ds_cnty_firm);

  // need some sorting
  fetched_srt := SORT (ds_cnty_firm, callsign_of_license, licensees_name, 
                                     name_attention.lname, name_attention.lname, name_attention.mname, 
                                     address, frequency_mhz);

  RETURN fetched_srt;
END;
