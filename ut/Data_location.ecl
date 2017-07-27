// to read the file from dataland sandbox export Person_header:= '~';   
// to read the file from prod sandbox  export Person_header:= ut.foreign_prod;
import Data_Services; 
export Data_location      := module 
export person_header      := Data_Services.Data_location.person_header: DEPRECATED('Use Data_Services.Data_location.person_header directly');
//already indexes changed to point to ut attribute so just referencing data services here.  
end; 