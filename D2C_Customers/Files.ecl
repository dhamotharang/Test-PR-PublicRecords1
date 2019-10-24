import doxie_build, mdr, d2c, Watchdog, Infutor, SexOffender, doxie_files, BankruptcyV2, LiensV2, header, death_master, AutoStandardI,Suppress;

EXPORT Files := MODULE
    
    infutor_best := Infutor.file_infutor_best;

    appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
    Suppress.MAC_Suppress(infutor_best,pulled_ssn_infutor,appType,Suppress.Constants.LinkTypes.SSN,ssn);
    Suppress.MAC_Suppress(pulled_ssn_infutor,cleaned_best_infutor,appType,Suppress.Constants.LinkTypes.DID,did);
    EXPORT fullInfutorDS := cleaned_best_infutor;

    infutor_hdr := Infutor.infutor_header;

    appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
    Suppress.MAC_Suppress(infutor_hdr,pulled_ssn_hdr,appType,Suppress.Constants.LinkTypes.SSN,ssn);
    Suppress.MAC_Suppress(pulled_ssn_hdr,cleaned_best_hdr,appType,Suppress.Constants.LinkTypes.DID,did);    
    EXPORT fullHdrDS     := cleaned_best_hdr;

    EXPORT coresDS       := Header.key_ADL_segmentation(ind1 = 'CORE');  

    EXPORT coreInfutorDS := join(
      distribute(fullInfutorDS, hash(did)),
      distribute(coresDS, hash(did)),  // CORE - 248,957,730
      left.did = right.did,
      transform(left),
      local);   
    EXPORT coreHdrDS := join(
      distribute(fullHdrDS, hash(did)),
      distribute(coresDS, hash(did)),  // CORE - 248,957,730
      left.did = right.did,
      transform(left),
      local);
    
    so    := SexOffender.Key_SexOffender_DID(false)(did > 0);//Unrestricted
    crims := doxie_files.File_Offenders((unsigned6)did > 0, data_type not in D2C.Constants.DOCRestrictedDataTypes, vendor not in D2C.Constants.DOCRestrictedVendors);
    bk    := BankruptcyV2.key_bankruptcy_did(false)(did > 0); //Unrestricted
    li    := LiensV2.key_liens_DID(did > 0);//Unrestricted
    
    EXPORT derogatoryDS := dedup(table(so, {(unsigned6)did}) + table(crims, {(unsigned6)did}) + table(bk, {did}) + table(li, {did}), all);
    shared SetofderogatoryDS := set(derogatoryDS, did);
           
    EXPORT coreInfutorDerogatoryDS := coreInfutorDS(did in SetofderogatoryDS);
    EXPORT coreHdrDerogatoryDS     := coreHdrDS(did in SetofderogatoryDS);

END;