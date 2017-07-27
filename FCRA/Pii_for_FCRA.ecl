filterDIDs := dataset('~thor_data400::base::override::fcra::qa::flag',fcra.Layout_override_flag,flat)
				(did <> '' and flag_file_id in FCRA.Suppress_Flag_File_ID);


did_rec := record
	string12 did;
end;

did_rec getdids(filterDIDs l) := transform
	self.did := l.did;
end;

did_out := project(filterDIDs,getDIDs(left));

pcrds := dataset('~thor_data400::base::override::fcra::qa::pcr',fcra.layout_override_pcr,flat);

fcra.layout_override_pcr join_recs(pcrds l,did_out r) := transform
	self := l;
end;


kf := join(pcrds,did_out,left.did = right.did,join_recs(left,right),left only);

export Pii_for_FCRA := PROJECT (kf, layout_override_pii);