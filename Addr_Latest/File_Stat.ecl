export file_stat := dataset('~thor_data400::base::linebarger_stat',
                         {unsigned4 total_rec, unsigned4 hits, decimal5_2 unit_price, decimal10_2 total_price},
                          csv(separator(','), terminator('\n')));