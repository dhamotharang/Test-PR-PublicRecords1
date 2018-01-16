import liensv2, Doxie, Data_Services;

get_recs := project(LiensV2.file_liens_party,transform(liensv2.layout_liens_party_ssn,self:=left));


new_rec := record
	get_recs.tax_id;
	get_recs.tmsid;
	get_recs.rmsid;
end;

new_rec tremovetempDID(Liensv2.layout_liens_party_ssn L) := transform
self.tax_id := if(L.tax_id <> '', if(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), L.app_tax_id);
self := L;

end;

slim_party := project(get_recs,tremovetempDID(left));

slim_dist   := distribute(slim_party, hash(tmsid, rmsid, tax_id));
slim_sort   := sort(slim_dist, tmsid, rmsid, tax_id, local);
slim_dedup  := dedup(slim_sort, tmsid, rmsid, tax_id, local);

export Key_liens_TAXID := index(slim_dedup,{tax_id},{TMSID,RMSID},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::TAXID_' + doxie.Version_SuperKey);
