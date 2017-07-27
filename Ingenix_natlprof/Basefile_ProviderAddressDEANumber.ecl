
import Ingenix_natlprof;

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderAddressDEANumber.raw_srctype;
    string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
end;

ProviderAddressDEANumber := 

dataset('~thor_data400::base::ingenix_DEA', 
	          new_rec, flat);

export Basefile_ProviderAddressDEANumber := ProviderAddressDEANumber;









