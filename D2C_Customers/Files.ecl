import doxie_build, mdr, d2c, Watchdog, Infutor, SexOffender, doxie_files, BankruptcyV2, LiensV2, header, death_master, AutoStandardI,Suppress,doxie;

EXPORT Files := MODULE

    //pass thorugh ccpa supprerssion
    // MDR.macGetGlobalSid(hdrIn,'PersonHeaderKeys','src','global_sid');
    // mod_access                 := MODULE(doxie.IDataAccess) END; // default mod_access
    // suppress_global_sid        := Suppress.MAC_SuppressSource (cleaned_best_infutor, mod_access, , , TRUE);

    infutor_hdr := Infutor.infutor_header(D2C_Customers.SRC_Allowed.Check(1, src));  //7,491,686,415
    appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
    Suppress.MAC_Suppress(infutor_hdr,pulled_ssn_hdr,appType,Suppress.Constants.LinkTypes.SSN,ssn);
    Suppress.MAC_Suppress(pulled_ssn_hdr,cleaned_best_hdr,appType,Suppress.Constants.LinkTypes.DID,did);    
    EXPORT fullHdrDS     := cleaned_best_hdr;

    infutor_best := Infutor.file_infutor_best : independent;  //705,593,920
    appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
    Suppress.MAC_Suppress(infutor_best,pulled_ssn_infutor,appType,Suppress.Constants.LinkTypes.SSN,ssn);
    Suppress.MAC_Suppress(pulled_ssn_infutor,cleaned_best_infutor,appType,Suppress.Constants.LinkTypes.DID,did);    
    EXPORT fullInfutorDS := cleaned_best_infutor;

    EXPORT coresDS       := Header.key_ADL_segmentation(ind1 = 'CORE'); //257,216,208 

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
    death := Header.File_DID_Death_MasterV2 ((unsigned6)did >0 and state_death_id=death_master.fn_fake_state_death_id(ssn,lname,dod8)) ; 
    //crlf='SA' flags Direct records where the SSN was overlaid w/ one from the SSA
    dist_death := distribute(death(crlf<>'SA'), hash(did));
        
    EXPORT derogatoryDS := dedup(table(so, {(unsigned6)did})
                               + table(crims, {(unsigned6)did})
                               + table(bk, {did})
                               + table(li, {did})
                               + table(dist_death, {(unsigned6)did})
                               ,all);
    shared SetofderogatoryDS := set(derogatoryDS, did);

    //use join instead set       
    EXPORT coreInfutorDerogatoryDS := join(distribute(coreInfutorDS, hash(did)),
                                           distribute(derogatoryDS, hash(did)),
                                           left.did = right.did,
                                           transform(left),
                                           local);
    EXPORT coreHdrDerogatoryDS := join(distribute(coreHdrDS, hash(did)),
                                           distribute(derogatoryDS, hash(did)),
                                           left.did = right.did,
                                           transform(left),
                                           local);

END;