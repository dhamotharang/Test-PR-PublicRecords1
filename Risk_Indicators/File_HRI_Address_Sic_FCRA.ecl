import business_header;

export File_HRI_Address_Sic_FCRA := dataset(business_header.foreign_prod+'~thor_data400::base::address_sic_code_FCRA',
                                       Layout_HRI_Address_Sic, flat);