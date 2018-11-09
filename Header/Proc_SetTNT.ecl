import mdr, PromoteSupers;

chk_rids := if(mdr.MAX_RID > 700000000000, fail('MAX RID is approaching or past max capacity - string12.  TS(7) TU RIDs also begin with 8.'));

outhead := distribute(header.Last_Rollup,hash(did));

PromoteSupers.MAC_SF_BuildProcess(outhead,'~thor_data400::base::header',tntset,,,true,pVersion:=Header.version_build);

export Proc_SetTNT := sequential(chk_rids,tntset);