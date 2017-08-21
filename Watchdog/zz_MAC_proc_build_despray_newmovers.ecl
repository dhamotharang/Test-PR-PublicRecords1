export MAC_proc_build_despray_newmovers(filedate,result) := 
macro
send_email:= fileservices.SendEmail('akayttala@seisint.com,cdsdataops@seisint.com,skasavajjala@seisint.com','New Movers file is built and available on edata12 /hds_180/newmovers/newmovers_'+filedate+'.d00','');
  send_bad_email := FileServices.sendemail('akayttala@seisint.com', 'New Movers build failed', failmessage,'');
	DestinationIP :=_control.IPAddress.edata12;
	
	ut.MAC_SF_BuildProcess(Watchdog.Best_NewMovers_Delta(filedate),
                       '~thor_data400::base::NewMovers',Build_Base, 2,,true) ;
	
	write_out:= output(Watchdog.Newmovers_enhancements,,'~thor_data400::out::'+filedate+'_newmovers'); 
    
	despray  :=fileservices.despray( '~thor_data400::out::'+filedate+'_newmovers', DestinationIP, '/hds_180/newmovers/newmovers_'+filedate+'.d00',,,,TRUE) ; 


	result := sequential(Build_Base
				    	,write_out
	            ,despray
						) :success(send_email), failure(send_bad_email);

endmacro;
 
