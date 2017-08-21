export Mac_flag_legacy_ssn(InDataset, flagged) := Macro
import header,ssnissue2;
#uniquename(dSyncd)
%dSyncd%:=distribute(header.fn_sync_legacy_ssn,hash(did));
#uniquename(dIn)
%dIn%:=distribute(InDataset,hash(did));
#uniquename(flagged0)
%flagged0%:=join(%dIn%,%dSyncd%
								,   left.did=right.did
								and left.ssn=right.ssn
								,transform({InDataset, boolean legacy}
										,self.legacy:=right.did>0
										,self:=left)
								,left outer
								,local
								);

flagged := join(%flagged0%,ssnissue2.file_ssnissue2((integer5)ssn5>0)
								,left.ssn[1..5]=right.ssn5
								,transform({%flagged0%}
										,self.legacy:=left.legacy or right.ssn5<>''
										,self:=left)
								,left outer
								,lookup
								);

EndMacro;