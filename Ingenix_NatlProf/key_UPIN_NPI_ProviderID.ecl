import ingenix_natlprof, Doxie;


UPIN_in := 	distribute(Ingenix_natlprof.Basefile_ProviderUPIN,hash(filetyp,providerid));
NPI_in	:=	distribute(Ingenix_NatlProf.Basefile_ProviderNPI,hash(filetyp,providerid));

new_rec := record
	Ingenix_Natlprof.Layout_in_ProviderUPIN;
  string8	dt_first_seen;
  string8 dt_last_seen;
  string8 dt_vendor_first_reported;
  string8 dt_vendor_last_reported;
	string	NPI;
	string	EnumerationDate;
	string	NPICompanyCount;
	string	NPITierTypeID;
	string	TaxonomyCode;
	string	PrimaryIndicator;
end;

new_rec Join_UPIN2NPI(UPIN_in l,NPI_in R) := Transform
	self 														:= L;
	self 														:= R;
end;

Joined_UPIN2NPI := 	join(	UPIN_in,
													NPI_in,
													left.FILETYP = right.FILETYP and 
													left.ProviderId = right.ProviderId,
													Join_UPIN2NPI(left,right), 
													left outer,
													local
												 );	
										
dist_id_base := distribute(dedup(Joined_UPIN2NPI(trim(NPI,left,right)<>''),all), hash(providerid));
sort_id_base := sort(dist_id_base, providerid, local);

export key_UPIN_NPI_providerid := index(	sort_id_base, 
																					{unsigned6 l_providerid := (unsigned6)providerid},
																					{sort_id_base},
																					'~thor_data400::key::ingenix_UPIN_NPI_providerid_' + Doxie.Version_SuperKey);