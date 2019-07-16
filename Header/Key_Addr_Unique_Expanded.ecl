IMPORT data_services;
IMPORT dx_Header;

data_category(boolean isFCRA)    := if(isFCRA 
                                    ,data_services.data_env.iFCRA
                                    ,data_services.data_env.iNonFCRA);

EXPORT      Key_Addr_Unique_Expanded(boolean isFCRA=false) := 

            dx_Header.Key_Addr_Unique_Expanded( data_category(isFCRA) )
            
            :DEPRECATED('Use dx_Header.Key_Addr_Unique_Expanded');
