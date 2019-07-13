IMPORT      data_services,dx_Header;

EXPORT      Key_Addr_Unique_Expanded(boolean isFCRA=false) := 

            if(isFCRA,
                        dx_Header.Key_Addr_Unique_Expanded(data_services.data_env.iFCRA),
                        dx_Header.Key_Addr_Unique_Expanded()

            ):DEPRECATED('Use dx_Header.Key_Addr_Unique_Expanded');