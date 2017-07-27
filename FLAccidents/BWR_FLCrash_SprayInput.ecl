#workunit('name', 'FLCrash Spray Input')
//use to spray files to dataland. If the destination is prod, the 4th parameter of 
//the fileservices.sprayfixed function should be 'thor_dell400'

import flaccidents;
       //spraying flcrash0_time_location
       fileservices.sprayfixed('192.168.0.39', 
                               '/flcrash_14/flcrash0.d00',
	    	                     400,
		 		           'thor_data400',
				           'in::flcrash0_' + thorlib.wuid());
        flaccidents.mac_flcrash_sprayinput('~thor_data400::in::flcrash0');  
             
       //spraying flcrash1_accident_char
       fileservices.sprayfixed('192.168.0.39', 
                               '/flcrash_14/flcrash1.d00',
      	                     400,
     		                'thor_data400',
  			                'in::flcrash1_' + thorlib.wuid());
  	  flaccidents.mac_flcrash_sprayinput('~thor_data400::in::flcrash1');						
	
       //spraying flcrash2_vehicle    
       fileservices.sprayfixed('192.168.0.39', 
                               '/flcrash_14/flcrash2v.d00',
      	                     929,
 			                'thor_data400',
                               'in::flcrash2v_' + thorlib.wuid());
       flaccidents.mac_flcrash_sprayinput('~thor_data400::in::flcrash2v');					
           		 
       //spraying flcrash3_towed_trailer_veh  
       fileservices.sprayfixed('192.168.0.39', 
                               '/flcrash_14/flcrash3v.d00',
    	                          649,
 		                     'thor_data400',
 				           'in::flcrash3v_' + thorlib.wuid());
 	  flaccidents.mac_flcrash_sprayinput('~thor_data400::in::flcrash3v');					
               
       //spray flcrash4_driver
       fileservices.sprayfixed('192.168.0.39', 
                               '/flcrash_14/flcrash4.d00',
    	                          680,
 		                     'thor_data400',
		                     'in::flcrash4_' + thorlib.wuid());
   	  flaccidents.mac_flcrash_sprayinput('~thor_data400::in::flcrash4');					
           
       //spray flcrash5_passenger  
       fileservices.sprayfixed('192.168.0.39', 
                               '/flcrash_14/flcrash5.d00',
	    	                     680,
 	 		                'thor_data400',
 			                'in::flcrash5_' + thorlib.wuid());
   	  flaccidents.mac_flcrash_sprayinput('~thor_data400::in::flcrash5');					
           
       //spray flcrash6_pedestrian
       fileservices.sprayfixed('192.168.0.39', 
                               '/flcrash_14/flcrash6.d00',
    	                          680,
          		           'thor_data400',
			                'in::flcrash6_' + thorlib.wuid());
  	  flaccidents.mac_flcrash_sprayinput('~thor_data400::in::flcrash6'); 					
           
       //spray flcrash7_property
       fileservices.sprayfixed('192.168.0.39', 
                               '/flcrash_14/flcrash7.d00',
	    	                     680,
	 		                'thor_data400',
 			                'in::flcrash7_' + thorlib.wuid());
       flaccidents.mac_flcrash_sprayinput('~thor_data400::in::flcrash7');