// output(choosen(, 100))



in_serviceName := 'Gong_Services.GongHistorySearchService' ;
samplesize := 50;

// #uniquename(up)	
up(string s) := stringlib.StringToUpperCase(s);

// f_raw := enth(roxielogs.File_LogsTrim.records_parsed(up(queryname)=up(in_serviceName)), samplesize);  //RIGHT
f_raw := choosen(roxielogs.File_LogsTrim.records_parsed(up(queryname)=up(in_serviceName)), samplesize);		//WRONG
	
// layout_input := recordof(roxielogs.File_LogsTrim.records_parsed);

f_in_dst := distribute(f_raw, random()) : independent;
// layout_input := recordof(f_in_dst);
// layout_input := {f_in_dst};
layout_input := record(f_in_dst)
end;

f_in_dst2 := project(f_in_dst, layout_input);

xlayout := roxielogs.LAYOUTS_XML_INPUT_SOAPCALL.GONG_SERVICES_GONGHISTORYSEARCHSSERVICE_OUTPUT;

roxie_ip := 'certstagingvip.hpcc.risk.regn.net:9876';
//roxie_ip := 'roxiebatch.br.seisint.com:9876';
// roxie_ip := 'http://10.173.3.5:9876/';
//roxie_ip := 'http://10.173.193.1:9876'; //qa
//roxie_ip := 'http://10.173.197.1:9856'; //batch
//roxie_ip := 'roxiedevvip.sc.seisint.com:9876';
//roxie_ip := 'roxiedevvip.sc.seisint.com:9876';					
									
// f_out_raw := soapcall(f_in_dst,roxie_ip,in_serviceName,{f_in_dst},dataset(xlayout));								 
f_out_raw := soapcall(f_in_dst2,roxie_ip,in_serviceName,layout_input,dataset(xlayout));								 
									 
// output(f_out_raw(output_seq_no<>0));
output(f_out_raw);

// sizeof(f_in_dst)

