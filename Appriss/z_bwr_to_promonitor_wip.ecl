import _control;

espserver:='http://'+_control.ThisEnvironment.ESP_IPAddress+':'+_control.PortAddress.esp_html+'/FileSpray';

booking_for_promonitor_file_name := appriss.cluster_name+'::out::appriss_bookings_for_promonitor'; 
charges_for_promonitor_file_name := appriss.cluster_name+'::out::appriss_charges_for_promonitor';

bookings_for_promonitor := appriss.file_bookings_prepa(stringlib.StringToUpperCase(action) not in ['DELETE']);
charges_for_promonitor := appriss.file_charges_prepa;

o1:=output(bookings_for_promonitor,,	booking_for_promonitor_file_name, 	CSV(HEADING(1),SEPARATOR('|'),TERMINATOR('\n')),OVERWRITE);
o2:=output(charges_for_promonitor ,,	charges_for_promonitor_file_name, 	CSV(HEADING(1),SEPARATOR('|'),TERMINATOR('\n')),OVERWRITE);


d1 :=FileServices.DeSpray
   (booking_for_promonitor_file_name,//logicalname
    _control.IPAddress.edata12,//desination IP
		'/hds_180/appriss/promonitor/appriss_bookings_for_promonitor',		// destinationpath
		-1,// timeout
		espserver,//espserver IP Port
		1,//Max connections
		true// OVERWRITE
		);
		
d2 :=FileServices.DeSpray
   (charges_for_promonitor_file_name,//logicalname
    _control.IPAddress.edata12,//desination IP
		'/hds_180/appriss/promonitor/appriss_charges_for_promonitor',// destinationpath
		-1,// timeout
		espserver,//espserver IP Port
		1,//Max connections
		true// OVERWRITE
		);

sequential(parallel(o1,o2),parallel(d1,d2));
