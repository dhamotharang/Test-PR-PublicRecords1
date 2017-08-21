import PromoteSupers;

outhead := distribute(header.FCRA_Last_Rollup,hash(did));

PromoteSupers.Mac_SF_BuildProcess(outhead,'~thor_data400::base::FCRA_header',tntset,,,true,pVersion:=Header.version_build);

export build_FCRA_header := tntset;