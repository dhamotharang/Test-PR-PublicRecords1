

FNto := 'prte::ct::base::email_data_Alpha12_SAVE';
FNfrom := 'prte::ct::base::email_data_w20130906-105509';		// sitting in old boca dev thor40_241
ThorName := ThorLib.Cluster();

Act1 := fileservices.copy('~'+FNfrom,ThorName,'~'+FNto,,,,,true,true);
SEQUENTIAL(Act1);