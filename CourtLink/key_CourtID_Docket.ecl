import CourtLink, Doxie;

file_in := courtlink.files().base.qa + CourtLink.irs_dummy_litigous_debtors;

CourtLink.Layouts.keybuild2	trfkeybuild(file_in l)	:=	transform
	self	:=	l;		
end;
		
File_fixed := project(file_in,trfkeybuild(left));

dist_id_base := distribute(dedup(File_fixed,all), hash(CourtID, DocketNumber));
sort_id_base := sort(dist_id_base, CourtID, DocketNumber, local);

export key_CourtID_Docket := index(sort_id_base, {CourtID, DocketNumber},{sort_id_base},
				            '~thor_data400::key::courtLink::'+doxie.Version_SuperKey+'::courtID_Docket');