import ut ; 
export File_CtyState_Lookup_Alias := DATASET( '~thor_data400::lookup::usps_ais::ctystate::alias',
                                             usps_ais.Layouts_CtyState_Product.Alias_Record_Lookup,THOR);