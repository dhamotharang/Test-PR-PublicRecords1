import ut;

head_full  := Header_Joined;

//****** APPLY THE PREGLB_DIDS
//File_DID_PG := header.Did_Rules1_PreGLB;
//head_pg := head_full(header.isPreGLB(head_full));
//Header.MAC_ApplyDid1(head_pg,PreGLB_did,File_Did_PG,outfile_PG)
//outfile_plus := outfile_PG + head_full(~header.isPreGLB(head_full));

//****** APPLY THE GOOD OLE DIDS
File_DID_Reg := header.Did_Rules1;
Header.MAC_ApplyDid1(head_full,DID,File_DID_Reg,outfile_both)

tmp := outfile_both : persist('persist::with_did_mid');

header.EntropyMatch(tmp,entropy_matches)
Header.MAC_ApplyDid1(tmp,DID,entropy_matches,veryoutfile)

export With_Did := veryoutfile : persist('With_Did');