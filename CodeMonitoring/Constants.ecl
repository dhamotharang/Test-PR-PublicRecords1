IMPORT  _Control; 

EXPORT Constants := MODULE

EXPORT ESP_IP_ADDRESS := MAP 
       ( _Control.ThisEnvironment.NAME = 'Prod_Thor' => '10.173.84.202', // boca prod thor 
         _Control.ThisEnvironment.NAME = 'Dataland'  => '10.241.12.207', // boca dataland 
         _Control.ThisEnvironment.NAME = 'Prod'      => '10.194.12.2',  // Alpha Prod 
         _Control.ThisEnvironment.NAME = 'Alpha_Dev' => '10.194.73.202' ,
				 _Control.ThisEnvironment.NAME = 'Dev' => '10.194.73.202' , //UK dev 
         ''
         ); 

EXPORT 	USERNAME := '';
EXPORT  USER_PW  := '';

EXPORT	FULL_USER_INFO := MAP
		(
			USERNAME != '' AND USER_PW != '' => USERNAME + ':' + USER_PW + '@',
			USERNAME != ''  =>  USERNAME + '@',
			''
		);
EXPORT dataland  :=  '10.241.12.207:8145' ;
EXPORT alpahdev  :=  '10.194.73.202:8145' ;  
EXPORT BocaProd  :=  '10.173.84.202:8145'; 
EXPORT Ukdev     :=  '10.193.64.21:9145' ;
EXPORT AlphaProd :=  '10.194.12.2:8145';
END; 