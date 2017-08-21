import Ingenix_natlprof;

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderUPIN.raw_srctype;
    string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
end;


providerUPIN := 

dataset('~thor_data400::base::ingenix_UPIN', 
	          new_rec, flat);

export Basefile_providerUPIN := providerUPIN;

