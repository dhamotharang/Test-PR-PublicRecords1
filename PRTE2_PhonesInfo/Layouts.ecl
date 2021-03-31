EXPORT Layouts := MODULE
Export transactions:=RECORD
  string10 phone;
  string5 source;
  string2 transaction_code;
  unsigned8 transaction_start_dt;
  string6 transaction_start_time;
  unsigned8 transaction_end_dt;
  string6 transaction_end_time;
  unsigned8 transaction_count;
  unsigned8 vendor_first_reported_dt;
  string6 vendor_first_reported_time;
  unsigned8 vendor_last_reported_dt;
  string6 vendor_last_reported_time;
  string3 country_code;
  string2 country_abbr;
  string10 routing_code;
  string1 dial_type;
  string10 spid;
  string60 carrier_name;
  string10 phone_swap;
  string6 ocn;
  string10 alt_spid;
  string10 lalt_spid;
  unsigned4 global_sid;
  unsigned8 record_sid;
 END;
 
 Export phone_type:=RECORD
  string10 phone;
  string5 source;
  unsigned8 vendor_first_reported_dt;
  string6 vendor_first_reported_time;
  unsigned8 vendor_last_reported_dt;
  string6 vendor_last_reported_time;
  string30 reference_id;
  string3 reply_code;
  string10 local_routing_number;
  string6 account_owner;
  string60 carrier_name;
  string10 carrier_category;
  string5 local_area_transport_area;
  string10 point_code;
  string1 serv;
  string1 line;
  string10 spid;
  string60 operator_fullname;
  string2 high_risk_indicator;
  string2 prepaid;
  unsigned4 global_sid;
  unsigned8 record_sid;
 END;

 End;
