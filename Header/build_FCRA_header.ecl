import PromoteSupers;

export build_FCRA_header(string filedate,boolean inc) := function

outhead := distribute(header.FCRA_Last_Rollup,hash(did));

PromoteSupers.Mac_SF_BuildProcess(outhead,'~thor_data400::base::FCRA_header',tntset_mnt,,,true,pVersion:=filedate);
PromoteSupers.Mac_SF_BuildProcess(outhead,'~thor_data400::base::FCRA_header_inc',tntset_inc,,,true,pVersion:=filedate);

return sequential(if(inc,tntset_inc,tntset_mnt));
end;