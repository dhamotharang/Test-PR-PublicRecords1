import monitoring;

export file_customer_base_delta := dataset('~thor_data400::base::monitoring_customer_base_delta',
                                           monitoring.layout_delta_file_out, csv(separator(','), terminator('\n'), quote('"')), opt);