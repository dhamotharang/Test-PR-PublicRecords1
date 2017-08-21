import lib_fileservices,_control;

export Proc_magnify_SICCodes(string ReceiveInputDate , string ExportOutDate ) := function
#workunit('name', 'Magnify_SICCodes' );
spray         := fspray_SICCodes(ReceiveInputDate[1..8]);
Magnify_base  := Proc_build_base_magnify(ReceiveInputDate,,);
Magnify_stats := Magnify_Base_Stats_Population(ReceiveInputDate[1..8],ExportOutDate);
despray_MagnifySICCodes 	:= FileServices.despray('~thor_data400::base::magnify_Extract',_control.IPAddress.edata10,
         																'/data_build_4/magnify/data/'+ReceiveInputDate[1..8]+'/magnifySICCodes_'+ReceiveInputDate[1..8],
         																,,,true);
despray_MagnifySICCodes_stats := FileServices.despray('~thor_data400::out::'+ReceiveInputDate[1..8]+'::magnify_Extract_stats',_control.IPAddress.edata10,
																			'/data_build_4/magnify/data/'+ReceiveInputDate[1..8]+'/stats_'+ReceiveInputDate[1..8]+'.txt',
																			,,,true);
result:=sequential(
					spray
					,Magnify_base
					,Magnify_stats
					,despray_MagnifySICCodes
					,despray_MagnifySICCodes_stats
					,output('You may want to pick up desprayed MagnifySICCodes & Stats file at edata10//data_build_4/magnify/data/'+ReceiveInputDate[1..8])
				 );		 
return result;

end;