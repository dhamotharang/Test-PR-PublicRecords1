import demo_data;
import faa;

#option('skipFileFormatCrcCheck', 1);

file_in:= dataset('~thor::base::demo_data_file_faa_airmen_certificate_prodcopy',faa.layout_airmen_certificate_out ,flat);

export scramble_faa_airmen_certificate  := dedup(sort(file_in,record),all);
