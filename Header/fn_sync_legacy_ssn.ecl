export fn_sync_legacy_ssn := function

	dHeader  :=table(header.file_headers(ssn<>''),{ssn,did,rid});
	dSnapShot:=header.file_ssn_snapshot(ssn<>'');

	dSyncd0:=join(distribute(dHeader,hash(rid))
						,distribute(dSnapShot,hash(rid))
								,   left.rid=right.rid
								and left.ssn=right.ssn
								,transform({dHeader.ssn,dHeader.did},self:=left)
								,local);

	dSyncd:=dedup(distribute(dSyncd0,hash(did)),record,all,local);

	return dSyncd;
end;