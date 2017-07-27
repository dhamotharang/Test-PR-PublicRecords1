import mdr;
export fn_FCRA_sync_legacy_ssn := function

	dHeader  :=table(header.file_headers(ssn<>'',src in mdr.sourceTools.set_scoring_FCRA),{ssn,did,rid});
	dSnapShot:=header.file_ssn_snapshot(ssn<>'',src in mdr.sourceTools.set_scoring_FCRA);

	dSyncd0:=join(distribute(dHeader,hash(rid))
						,distribute(dSnapShot,hash(rid))
								,   left.rid=right.rid
								and left.ssn=right.ssn
								,transform({dHeader.ssn,dHeader.did},self:=left)
								,local);

	dSyncd:=dedup(distribute(dSyncd0,hash(did)),record,all,local): persist('~thor_data400::persist::fn_FCRA_sync_legacy_ssn');

	return dSyncd;
end;