IMPORT data_services;
IMPORT $;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_addr_unique_expanded_fcra,
                                     $.names().i_addr_unique_expanded);

EXPORT      Key_Addr_Unique_Expanded(integer data_category = 0) :=

            INDEX({$.layouts.i_addr_ind_full.did},$.layouts.i_addr_ind_full,fname(data_category));
