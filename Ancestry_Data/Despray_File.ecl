Import STD, _control;

lfn := '~thor_data400::out::ancestry_data::20201027::hist_address_file2';

destinationIP := _control.IPAddress.bctlpedata12;

destdirectory := '/data/projects/ancestry/';

Export Despray_File := STD.File.DeSpray(lfn, destinationIP, destdirectory+'hist_address_file2.csv', allowoverwrite := true );