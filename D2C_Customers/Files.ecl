import doxie_build, mdr, d2c, Watchdog, Infutor, SexOffender, doxie_files, BankruptcyV2, LiensV2;

EXPORT Files := MODULE

    shared Wdog := Watchdog.File_Best_nonglb;
    shared inf  := Infutor.file_infutor_best;
    shared hdr := doxie_build.file_header_building(~MDR.sourceTools.SourceIsGLB(src), ~MDR.sourceTools.SourceIsDPPA(src), did > 0);//, src not in D2C.Constants.PersonHeaderRestrictedSources); 
    
    EXPORT FullInfutorDS := join(
      distribute(inf, hash(did)),
      distribute(Wdog, hash(did)),
      left.did = right.did,
      transform({inf, unsigned4 Date_of_Death}, self.Date_of_Death := (unsigned4)right.dod; self := left;),
      local);
    
    EXPORT FullHdrDS := join(
      distribute(hdr, hash(did)),
      distribute(Wdog, hash(did)),
      left.did = right.did,
      transform(left),
      local);
      
    EXPORT coreInfutorDS := join(
      distribute(inf, hash(did)),
      distribute(Wdog(adl_ind = 'CORE'), hash(did)),  // CORE - 248,957,730
      left.did = right.did,
      transform({inf, unsigned4 Date_of_Death}, self.Date_of_Death := (unsigned4)right.dod; self := left;),
      local);
   
    EXPORT coreHdrDS := join(
      distribute(hdr, hash(did)),
      distribute(Wdog(adl_ind = 'CORE'), hash(did)),  // CORE - 248,957,730
      left.did = right.did,
      transform(left),
      local);
    
    so    := SexOffender.Key_SexOffender_DID(false)(did > 0);//Unrestricted
    crims := doxie_files.File_Offenders((unsigned6)did > 0, data_type not in D2C.Constants.DOCRestrictedDataTypes, vendor not in D2C.Constants.DOCRestrictedVendors);
    bk    := BankruptcyV2.key_bankruptcy_did(false)(did > 0); //Unrestricted
    li    := LiensV2.key_liens_DID(did > 0);//Unrestricted
    
    EXPORT derogatoryDS := dedup(table(so, {(unsigned6)did}) + table(crims, {(unsigned6)did}) + table(bk, {did}) + table(li, {did}), all);
           
    EXPORT coreInfutorDerogatoryDS := join(
      distribute(coreInfutorDS, hash(did)),
      distribute(derogatoryDS, hash(did)),
      left.did = right.did,
      transform(left),
      local);
   
    EXPORT coreHdrDerogatoryDS := join(
      distribute(coreHdrDS, hash(did)),
      distribute(derogatoryDS, hash(did)),
      left.did = right.did,
      transform(left),
      local);

END;