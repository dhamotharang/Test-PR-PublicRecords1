export layout_gong_stats := RECORD
  string vendor;
  unsigned8 phone_conn_cnt;
  unsigned8 phone_disc_cnt;
  unsigned8 phone_name_conn_cnt;
  unsigned8 phone_name_disc_cnt;
  unsigned8 phone_addr_conn_cnt;
  unsigned8 phone_addr_disc_cnt;
  string8 cal_date;
END;

export file_gong_stats := dataset('~thor_data400::base::monitoring::gong_diff_stats', layout_gong_stats, thor);