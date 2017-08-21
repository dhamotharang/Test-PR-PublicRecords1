import Ingenix_natlprof;

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderDegree.raw_srctype;
    string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
end;

providerdegree:= 

dataset('~thor_data400::base::ingenix_degree', 
	          new_rec, flat);

export Basefile_providerdegree:= providerdegree;

