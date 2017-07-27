/*To add a new file:
SEQUENTIAL(
FileServices.StartSuperFileTransaction(),
FileServices.ClearSuperFile('~thor_data400::Base::Gong'),
FileServices.AddSuperFile('~thor_data400::Base::Gong','~thor_data400::in::gong_20040318'),
FileServices.FinishSuperFileTransaction()
);
*/
d:= distribute(dataset('~thor_data400::base::gong',Gong.layout_gong,flat),random());

Layout_bscurrent_raw trecs(d L) := transform
self.phone10 := L.phoneno;
self.listed_name := L.company_name;
self := L;
end;

precs:= project(d,trecs(left));


export File_Gong_Dirty := precs;