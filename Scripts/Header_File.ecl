Import data_services,dx_header;

hdr := Dataset(data_services.foreign_prod+'thor_data400::base::header_raw::latest_built',dx_header.layout_header, Thor): Independent;

// 21b records slimmed to x amount
Export Header_file := Choosen(hdr, 100000);
