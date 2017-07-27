import ut;
t := file_tx_raw;
u := file_texas_update;

kill_dlnum := record
  u.dl_number;
  u.process_date;
  end;

kills := table(u(current_transaction = 'D' or current_transaction[1]='U'),kill_dlnum);

Layout_Dl intof(t le) := transform
  self.dt_first_seen := (unsigned8)le.process_date div 100;
  self.dt_last_seen := (unsigned8)le.process_date div 100;
  self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
  self.dt_vendor_last_reported := (unsigned8)le.process_date div 100;
  self.orig_state := 'TX';
  self.name := le.driver_name;
  self.addr1 := le.street_address;
  self.city := le.city_zipcode[..length(trim(le.city_zipcode))-5];
  self.state := le.ace_state;
  self.zip := le.city_zipcode[length(trim(le.city_zipcode))-4..];
  self.dob := ut.Date_MMDDYYYY_i2(le.date_of_birth);
  self.license_type := le.class;
  self.title := le.name_title;
  self.fname := le.name_first;
  self.mname := le.name_middle;
  self.lname := le.name_last;
  self.name_suffix := le.name_suffix;
  self.cleaning_score := le.name_score;
  self.st := le.ace_state;
  self.zip5 := le.ace_zip;
  self.zip4 := le.ace_zip4;
  self.rec_type := le.ace_rec_type;
  self.county := le.ace_county;
  self.issuance := le.last_transaction;
  self := le;
  end;

Layout_DL from_upd(u le) := transform
  self.dt_first_seen := (unsigned8)le.process_date div 100;
  self.dt_last_seen := (unsigned8)le.process_date div 100;
  self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
  self.dt_vendor_last_reported := (unsigned8)le.process_date div 100;
  self.orig_state := 'TX';
  self.name := le.new_driver_name;
  self.addr1 := le.new_street_address;
  self.city := le.new_city_zipcode[..length(trim(le.city_zipcode))-5];
  self.state := le.new_state;
  self.zip := le.new_city_zipcode[length(trim(le.city_zipcode))-4..];
  self.dob := ut.Date_MMDDYYYY_i2(le.new_date_of_birth);
  self.license_type := le.new_class;
  self.title := le.new_title;
  self.fname := le.new_fname;
  self.mname := le.new_mname;
  self.lname := le.new_lname;
  self.name_suffix := le.new_suffix;
  self.cleaning_score := le.new_name_score;
  self.prim_range := le.new_prim_range;
  self.sec_range := le.new_sec_range;
  self.prim_name := le.new_prim_name;
  self.p_city_name := le.new_p_city_name;
  self.v_city_name := le.new_v_city_name;
  self.cart := le.new_cart;
  self.predir := le.new_predir;
  self.postdir := le.new_postdir;
  self.suffix := le.new_addr_suffix;
  self.unit_desig := le.new_unit_desig;
  self.st := le.new_state;
  self.zip5 := le.new_zip5;
  self.zip4 := le.new_zip4;
  self.lot := le.new_lot;
  self.lot_order := le.new_lot_order;
  self.cr_sort_sz := le.new_cr_sort_sz;
  self.chk_digit := le.new_chk_digit;
  self.geo_lat := le.new_geo_lat;
  self.geo_blk := le.new_geo_blk;
  self.geo_long := le.new_geo_long;
  self.geo_match := le.new_geo_match;
  self.err_stat := le.new_err_stat;
  self.rec_type := le.new_rec_type;
  self.county := le.new_county;
  self.issuance := le.new_current_transaction;
  self.dl_number := le.new_dl_number;
  end;

news := project(u(current_transaction='O' or current_transaction[1]='U'),from_upd(left));
in_stream := project(t,intof(left))+news;

Layout_Dl Killed(in_stream le, kills ri) := transform
  self.history := IF( ri.dl_number='','','H');
  self := le;
  end;

out_stream := join(in_stream,kills,left.dl_number=right.dl_number and
                                   left.dt_first_seen < (unsigned8)right.process_date div 100,
                                   killed(left,right), left outer, lookup);

export Tx_As_Dl := out_stream : persist(Drivers.Cluster + 'Persist::DrvLic_TX_as_DL');
