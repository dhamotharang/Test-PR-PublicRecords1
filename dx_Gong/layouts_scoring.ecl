EXPORT layouts_scoring := MODULE

  EXPORT gong_partial := RECORD
    string1 dual_name_flag:='';
    unsigned integer8 sequence_number:=0;
    string1 listing_type_bus:='';
    string1 listing_type_res:='';
    string1 listing_type_gov:='';
    string1 publish_code:='';
    string1 style_code:='';
    string1 indent_code:='';
    string3  prior_area_code:= '';
    string1 dwelling:='';
    string1 omit_address:='';
    string1 omit_phone:='';
    string1 omit_locality:='';
    string1 privacy_flag:='';
    string60 fsn;
    string20 name_first:='';
    string20 name_middle:='';
    string20 name_last:='';
    string5 name_suffix:='';
    string120 company_name:='';
    string10 phone10;
    string4 vendor := '';
    string10 prim_range:='';
    string2 predir:='';
    string28 prim_name:='';
    string4 suffix:='';
    string2 postdir:='';
    string10 unit_desig:='';
    string8 sec_range:='';
    string25 p_city_name:='';
    string25 v_city_name:='';
    string2 st:='';
    string5 z5:='';
    string4 z4:='';
    unsigned integer6 did:=0;
    unsigned integer6 hhid:=0;
    unsigned integer6 bdid:=0;
    string8 dt_first_seen:='';
    unsigned integer2 disc_cnt6:=0;
    unsigned integer2 disc_cnt12:=0;
    unsigned integer2 disc_cnt18:=0;
  END;

  EXPORT phone_level := RECORD
    string10  phone10;
    unsigned2 days_in_service := 0;  //  Number of days that the current phone has been in service
    unsigned2 num_phone_owners_hist := 0;  //  Number of owners associated to the phone in EDA history
    unsigned2 num_phone_owners_cur := 0;  //  Number of owners associated to the phone in current EDA
    unsigned2 days_phone_first_seen := 0;  //  Number of days since the phone was seen in EDA data
  END;

  EXPORT did_Level := RECORD
    unsigned integer6 did:=0;
    unsigned2    num_phones_indiv := 0;  //  Number of phones owned by DID
    unsigned2    num_phones_connected_indiv := 0;  //  Number of phones currently connected to DID
    unsigned2    num_phones_discon_indiv := 0;  //Number of phones disconnected for DID
    unsigned2    avg_days_connected_indiv := 0;  //  Average number of days a phone is connected to DID
    unsigned2    min_days_connected_indiv := 0;  //  Min number of days a phone is connected to DID
    unsigned2    max_days_connected_indiv := 0;  //  Max number of days a phone is connected to DID
    boolean    is_discon_15_days  := false;  //   True/False Has the DID had a phone connected for 15 days or less?
    boolean    is_discon_30_days  := false;  //   True/False Has the DID had a phone connected for 30 days or less?
    boolean    is_discon_60_days  := false;  // True/False Has the DID had a phone connected for 60 days or less?
    boolean    is_discon_90_days  := false;  // True/False Has the DID had a phone connected for 90 days or less?
    boolean    is_discon_180_days  := false;  //   True/False Has the DID had a phone connected for 180 days or less?
    boolean    is_discon_360_days  := false;  //   True/False Has the DID had a phone connected for 360 days or less?
    unsigned2    days_indiv_first_seen := 0;  //  Number of days since DID was first seen in EDA data
    boolean    address_match_best := false;  //  True/False The address listed matches best?
    unsigned2    months_addr_last_seen := 0;  //  Number of months since the address has been seen last 
  END;

  EXPORT phone_did_Level := RECORD
    unsigned integer6 did:=0;
    string10  phone10;
    unsigned2 num_interrupts_cur := 0;  //  Number of service interruptions for the current phone/DID
    unsigned2 avg_days_interrupt := 0;  //  Average number of days the phone was disconnected during the interruption
    unsigned2 min_days_interrupt := 0;  //  Min number of days the phone was disconnected during the interruption
    unsigned2 max_days_interrupt := 0;  //  Max number of days the phone was disconnected during the interruption
    boolean   is_current_in_hist  := false;  //   True/False Is the phone/DID in current EDA also in EDA history?
    unsigned2 days_indiv_first_seen_with_phone := 0;  //  Number of days since DID associated with the current phone was first seen in EDA data
    boolean   has_cur_discon_15_days  := false;  //   True/False The current phone has had a disconnect where stayed connected for 15 days or less
    boolean   has_cur_discon_30_days  := false;  //   True/False The current phone has had a disconnect where stayed connected for 30 days or less
    boolean   has_cur_discon_60_days  := false;  //   True/False The current phone has had a disconnect where stayed connected for 60 days or less
    boolean   has_cur_discon_90_days  := false;  //   True/False The current phone has had a disconnect where stayed connected for 90 days or less
    boolean   has_cur_discon_180_days  := false;  //   True/False The current phone has had a disconnect where stayed connected for 180 days or less
    boolean   has_cur_discon_360_days  := false;  // True/False The current phone has had a disconnect where stayed connected for 360 days or less
  END;

  EXPORT address_Level := RECORD
    string    adr;
    unsigned2 num_phones_connected_addr := 0;  //_addr  Number of phones connected to the address
    unsigned2 num_phones_discon_addr := 0;  //  Number of phones disconnected to the address
  END;

  EXPORT Hhid_Level := RECORD
    unsigned integer6 hhid:=0;
    unsigned2 num_phones_connected_hhid := 0;  //  Number of phones connected to HHID
    unsigned2 num_phones_discon_hhid := 0;  //  Number of phones disconnected to HHID
  END;

  SHARED scoring_attributes := RECORD
    Phone_level     and not[phone10];
    Did_Level       and not[did];
    Phone_Did_Level and not[phone10, did];
    Address_Level   and not[adr] ;
    Hhid_Level      and not[hhid];
  END;

  EXPORT attribute_key := RECORD
    gong_partial;
    scoring_attributes;
    unsigned4 global_sid := 0;
    unsigned8 record_sid := 0;    
  END;

END;