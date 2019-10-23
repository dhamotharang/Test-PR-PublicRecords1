import doxie_build, mdr, d2c, Watchdog, Infutor, SexOffender, doxie_files, BankruptcyV2, LiensV2, header, death_master;

EXPORT Files := MODULE

    death := Header.File_DID_Death_MasterV2 ((integer)did <>0 and state_death_id=death_master.fn_fake_state_death_id(ssn,lname,dod8)) ; 
    //crlf='SA' flags Direct records where the SSN was overlaid w/ one from the SSA
    dist_death := distribute(death(crlf<>'SA'), hash(did));
    shared dsDeath := dedup(sort(dist_death, did, -filedate, local), did, filedate, local);
 
    EXPORT coresDS := Header.key_ADL_segmentation(ind1 = 'CORE');
    shared inf     := Infutor.file_infutor_best;
    shared hdr     := Infutor.infutor_header;
    
    EXPORT FullInfutorDS := join(
      distribute(inf, hash(did)),
      distribute(dsDeath, hash((unsigned6)did)),
      left.did = (unsigned6)right.did,
      transform({inf, unsigned4 Date_of_Death}, self.Date_of_Death := (unsigned4)right.dod8; self := left;),
      local);
    
    EXPORT FullHdrDS := hdr;

    shared core_and_infutor := join(
      distribute(inf, hash(did)),
      distribute(coresDS, hash(did)),  // CORE - 248,957,730
      left.did = right.did,
      transform(left),
      local);

    EXPORT coreInfutorDS := join(
      distribute(core_and_infutor, hash(did)),
      distribute(dsDeath, hash((unsigned6)did)),
      left.did = (unsigned6)right.did,
      transform({core_and_infutor, unsigned4 Date_of_Death}, self.Date_of_Death := (unsigned4)right.dod8; self := left;),
      local);
   
    EXPORT coreHdrDS := join(
      distribute(hdr, hash(did)),
      distribute(coresDS, hash(did)),  // CORE - 248,957,730
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