#workunit('name', ebr.Dataset_Name + ' Build All ' + ebr.version);

build_bases		:= ebr.Proc_Build_Base_Files 	: success(output('All EBR base files created successfully'));
build_keys		:= ebr.Proc_Build_Keys 		: success(output('All EBR keys created successfully'));
run_stats			:= ebr.Query_BDID_Stats		: success(output('BDID Stats completed successfully'));
as_bus_hdr		:= ebr.EBR_As_Business_Header;
as_bus_hdr_out 	:= output(ebr.Dataset_Name + ' as Bus Header total records: ' + count(as_bus_hdr));
as_bus_hdr_sample 	:= output(enth(as_bus_hdr, 1000), named('Sample_As_Bus_Header_Recs'),all);
send_email 		:= EBR.Send_Build_Completion_Email();

sequential(
	 build_bases
	,build_keys
	,run_stats
	,as_bus_hdr_out
	,as_bus_hdr_sample
	,send_email
);
