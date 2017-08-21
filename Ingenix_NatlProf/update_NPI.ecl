import Ingenix_natlprof,ut;
  
Provider_NPI 					:= 	distribute(File_in_ProviderNPI.Allsrc,hash(FILETYP,ProviderId,NPI));

Provider_NPITaxonomy	:=	distribute(File_in_ProviderNPITaxonomy.Allsrc,hash(FILETYP,ProviderId,NPI));

new_rec := record
	Ingenix_Natlprof.Layout_in_ProviderNPI.raw_srctype;
	string	TaxonomyCode;
	string	PrimaryIndicator;
	string8	dt_first_seen;
	string8	dt_last_seen;
	string8	dt_vendor_first_reported;
	string8	dt_vendor_last_reported;
end;

new_rec Join_NPITaxonomy(Provider_NPI l,Provider_NPITaxonomy R) := Transform
	self.dt_first_seen              := '';
	self.dt_last_seen               := '';
	self.dt_vendor_first_reported   := L.processdate;
	self.dt_vendor_last_reported    := L.processdate;
	self 														:= L;
	self 														:= R;
end;

Joined_NPITaxonomy :=	join(	Provider_NPI,
														Provider_NPITaxonomy,
														left.FILETYP = right.FILETYP and 
														left.ProviderId = right.ProviderId and
														left.NPI = right.NPI,
														Join_NPITaxonomy(left,right), 
														left outer,
														local
													);	

file_dist := distribute(Joined_NPITaxonomy, hash(FILETYP, ProviderID));
file_sort := sort(file_dist,FILETYP, ProviderID, NPI, -ProcessDate, local);

new_rec  rollupXform(new_rec l, new_rec r) := transform
		self.Processdate    					:= if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
		self.dt_First_Seen 						:= if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
		self.Dt_Last_Seen  						:= if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
		self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self := l;
end;

export update_NPI := rollup(file_sort, rollupXform(LEFT,RIGHT), FILETYP, ProviderID, NPI,local);