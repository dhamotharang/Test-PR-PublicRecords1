import lib_fileservices;

#workunit('name','Spray Header Files');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91
//tapeload02=10.121.145.44

date_suffix := '20050829';

east := fileservices.sprayfixed('10.121.145.44', 
                               'd:\\HEADERDATAE.DAT',
	    	                     567,
								'thor_dell400_2',
								'~thor_dell400_2::in::hdr_east_raw_' + date_suffix,,,,true,true);

central := fileservices.sprayfixed('10.121.145.44', 
                               'e:\\efx_hdrs\\HEADERDATAC.DAT',
	    	                     567,
								'thor_dell400_2',
								'~thor_dell400_2::in::hdr_cent_raw_' + date_suffix,,,,true,true);
						   
west := fileservices.sprayfixed('10.121.145.44', 
                               'd:\\efx_hdrs\\HEADERDATAW.DAT',
	    	                     567,
								'thor_dell400_2',
								'~thor_dell400_2::in::hdr_west_raw_' + date_suffix,,,,true,true);

south := fileservices.sprayfixed('10.121.145.44', 
                               'e:\\efx_hdrs\\HEADERDATAS.DAT',
	    	                     567,
								'thor_dell400_2',
								'~thor_dell400_2::in::hdr_sout_raw_' + date_suffix,,,,true,true);

sequential(
	parallel(east,central),
	parallel(west,south)
);
