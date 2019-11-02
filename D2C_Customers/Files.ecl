import std, ut, d2c, mdr, Infutor, SexOffender, doxie_files, BankruptcyV2, LiensV2, header, death_master, AutoStandardI,Suppress,doxie, faa, bankruptcyV2, ln_propertyv2, Email_Data, eMerges, paw, Phonesplus_v2, prof_licensev2, sexoffender, American_student_list, UCCV2, VotersV2;

EXPORT Files := MODULE

    shared TestBuild := false : stored('TestBuild');    
    
    /********* FULL DS **********/
    infutor_hdr := Infutor.infutor_header(D2C_Customers.SRC_Allowed.Check(1, src));

    TS_rec  := infutor_hdr(src = 'TS');
    INF_rec := infutor_hdr(src = 'IF');
    cnt_TS_rec  := count(TS_rec);  //2,163,551,849
    cnt_INF_rec := count(INF_rec); //1,282,733,656

    //As per agreement, only 70% of TS and 33% of IF transactions are allowed for My Life
    //The records are selected based on lowest did/rid
    TS_70per_rec  := choosen(sort(distribute(TS_rec, hash(did)), did, rid, local), cnt_TS_rec*0.70);   //1,514,486,294
    INF_33per_rec := choosen(sort(distribute(INF_rec, hash(did)), did, rid, local), cnt_INF_rec*0.33); //  423,302,106

    //Final set of header records allowed
    inf_hdr_allowed_recs := infutor_hdr(src not in ['TS', 'IF']) + TS_70per_rec + INF_33per_rec; //7,491,686,415        
    inf_hdr_w_suppr := D2C_Customers.MAC_Suppressions(inf_hdr_allowed_recs, 1);    
    EXPORT FullHdrDS := choosen(inf_hdr_w_suppr, if(TestBuild, 1000, CHOOSEN:ALL));
    
    infutor_best := Infutor.file_infutor_best : independent;  //705,593,920
    inf_best_w_suppr := D2C_Customers.MAC_Suppressions(infutor_best, 1);
    AllowedDidFomHdr := dedup(fullHdrDS, did, all);
    //Select ONLY allowed dids from infutor best by joining with hdr
    //101,198,920 dids are dropped from infutor best beacuse of join
    j_best_w_hdr := join(distribute(inf_best_w_suppr, hash(did)), distribute(AllowedDidFomHdr, hash(did)), left.did = right.did, inner, local); 
    EXPORT fullInfutorDS := choosen(j_best_w_hdr, if(TestBuild, 1000, CHOOSEN:ALL));  //604,395,000 

    /********* CORE DS **********/
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

    /********* DEROGATORY DS **********/
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

    /********* AIRCRAFT **********/
    AirCraft  := faa.file_aircraft_registration_out((unsigned6)did_out > 0);
    AirCraft_p := project(AirCraft, transform({recordof(AirCraft) - [did_out], unsigned6 did}, self.did := (unsigned6)left.did_out; self := left));
    EXPORT AircraftDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(AirCraft_p, derogatoryDS, mode, 10);
        
    /********* AIRMEN **********/
    Airmen  := faa.file_airmen_data_out((unsigned6)did_out > 0 and current_flag = 'A'); //Select ONLY ACTIVE records
    Airmen_p := project(Airmen, transform({recordof(Airmen) - [did_out], unsigned6 did}, self.did := (unsigned6)left.did_out; self := left));
    EXPORT AirmenDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Airmen_p, derogatoryDS, mode, 11);

    /********* BANKRUPTCY **********/
    Bankruptcy := bankruptcyV2.file_bankruptcy_search_v3(name_type='D' and lname!='' and prim_name!='', (unsigned6)did > 0);
    Bankruptcy_p := project(Bankruptcy, transform({recordof(Bankruptcy) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));
    EXPORT BankruptcyDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Bankruptcy_p, derogatoryDS, mode, 5);
    
    /********* CRIMINAL_RECORDS **********/
    Crims := doxie_files.File_Offenders((unsigned6)did > 0, data_type not in D2C.Constants.DOCRestrictedDataTypes, vendor not in D2C.Constants.DOCRestrictedVendors, D2C_Customers.SRC_Allowed.Check(7, vendor));
    Crims_p := project(Crims, transform({recordof(Crims) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));
    EXPORT CrimsDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Crims_p, derogatoryDS, mode, 7);

    /********* DEEDS_MORTGAGES **********/
    Deeds := ln_propertyv2.File_Search_DID(did > 0, D2C_Customers.SRC_Allowed.Check(20, ln_fares_id));
    EXPORT DeedsDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Deeds, derogatoryDS, mode, 20);

    /********* EMAIL_ADDRESSES **********/
    Emails := Email_Data.File_Email_Base(
         did > 0,
         current_rec=true,
         Clean_Email<>'',
         email_src not in D2C.Constants.EmailRestrictedSources,
         D2C_Customers.SRC_Allowed.Check(9, email_src));
    EXPORT EmailsDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Emails, derogatoryDS, mode, 9);

    /********* HUNTING_FISHING_PERMITS **********/
    Hunting := eMerges.file_hunters_out(
            (unsigned6)did_out > 0,
             Source_Code not in D2C.Constants.CCWRestrictedSources,
             D2C_Customers.SRC_Allowed.Check(12, source_code));
    Hunting_p := project(Hunting, transform({recordof(Hunting) - [did_out], unsigned6 did}, self.did := (unsigned6)left.did_out; self := left));             
    EXPORT HuntingDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Hunting_p, derogatoryDS, mode, 12);

    /********* LIENS_JUDGEMENTS **********/
    Liens := dataset('~thor_data400::base::liens::party', LiensV2.Layout_Liens_party_HeaderIngest, thor)((unsigned6)did > 0);
    Liens_p := project(Liens, transform({recordof(Liens) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));             
    EXPORT LiensDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Liens_p, derogatoryDS, mode, 13);

    /********* PEOPLE_AT_WORK **********/
    Paw := paw.files().base.built(
            (unsigned6)did > 0,
            score>'003',
            D2C_Customers.SRC_Allowed.Check(15, source)
            );
    Paw_p := project(Paw, transform({recordof(Paw) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));             
    EXPORT PawDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Paw_p, derogatoryDS, mode, 15);

    /********* PHONES **********/
    f_phonesplus := Phonesplus_v2.File_phonesplus_base(
                 did > 0,
                 current_rec,
                 D2C_Customers.SRC_Allowed.Check(16, vendor)
                 );
    ut.mac_suppress_by_phonetype(f_phonesplus,cellphone,state,_fphonesplus_cell,true,did);
    _keybuild_phonesplus_base := f_phonesplus(cellphone<>'');
    Phones := _keybuild_phonesplus_base(vendor not in D2C.Constants.PhonesPlusV2RestrictedSources);
    EXPORT PhonesDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Phones, derogatoryDS, mode, 16);

    /********* PROFESSIONAL_LICENSES **********/
    PL := prof_licensev2.File_ProfLic_Base(
          (unsigned6)did > 0,
          D2C_Customers.SRC_Allowed.Check(17, vendor)
          );
    PL_p := project(PL, transform({recordof(PL) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));             
    EXPORT PLDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(PL_p, derogatoryDS, mode, 17);

    /********* SEX_OFFENDERS **********/
    SO := sexoffender.file_Main(D2C_Customers.SRC_Allowed.Check(18, source_file));
    SO_p := project(SO, transform({recordof(SO) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));             
    EXPORT SODS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(SO_p, derogatoryDS, mode, 18);

    /********* STUDENTS **********/
    ASL := American_student_list.File_american_student_DID(did > 0, D2C_Customers.SRC_Allowed.Check(22, source));
    EXPORT ASLDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(ASL, derogatoryDS, mode, 22);

    /********* TAX_ASSESSMENTS **********/
    //Recs filtered based on ln_fares_id[1..2]
    //Will include the latest tax record for each property owned over the last 10 years 
    Tax := ln_propertyv2.File_Search_DID(
                       did > 0,
                       Std.Date.YearsBetween((unsigned4)process_date,
                       Std.Date.Today()) < 10,
                       D2C_Customers.SRC_Allowed.Check(21, ln_fares_id));
    EXPORT TaxDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Tax, derogatoryDS, mode, 21);

    /********* NATIONAL_UCC **********/
    UCC := UCCV2.File_UCC_Party_Base(did > 0);
    EXPORT UCCDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(UCC, derogatoryDS, mode, 14);

    /********* VOTER_REGISTRATION **********/
    Voters := VotersV2.File_Voters_Base(did > 0, D2C_Customers.SRC_Allowed.Check(19, source));
    EXPORT VotersDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Voters, derogatoryDS, mode, 19);

    /********* CONCEALED_WEAPONS **********/
    CCW := eMerges.file_ccw_base(
              (unsigned6)did_out > 0,
              Source_Code not in D2C.Constants.CCWRestrictedSources,
              D2C_Customers.SRC_Allowed.Check(15, source_state)
              );
    CCW_p := project(CCW, transform({recordof(CCW) - [did_out], unsigned6 did}, self.did := (unsigned6)left.did_out; self := left));                           
    EXPORT CCWDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(CCW_p, derogatoryDS, mode, 15);

END;