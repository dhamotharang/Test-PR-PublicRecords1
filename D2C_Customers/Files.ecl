import std, ut, d2c, mdr, Infutor, SexOffender, doxie_files, BankruptcyV2, LiensV2, header, death_master, Suppress,doxie, faa, bankruptcyV2, ln_propertyv2, Email_Data, eMerges, paw, Phonesplus_v2, prof_licensev2, sexoffender, American_student_list, UCCV2, VotersV2, Transunion_PTrak, Property;

EXPORT Files := MODULE

    shared TestBuild := false : stored('TestBuild');     

    //Infutor Header -            9,331,483,588
    //After applying src filter,  7,504,725,548 
    EXPORT infutor_hdr  := distribute(Infutor.infutor_header(D2C_Customers.SRC_Allowed.Check(1, src)), hash(did));
    EXPORT infutor_best := Infutor.file_infutor_best;  //708,358,966
    EXPORT coresDS      := Header.key_ADL_segmentation(ind1 = 'CORE'); //257,216,208       
    
    /********* AIRCRAFT **********/
    AirCraft  := faa.file_aircraft_registration_out((unsigned6)did_out > 0);
    AirCraft_p := project(AirCraft, transform({recordof(AirCraft) - [did_out], unsigned6 did}, self.did := (unsigned6)left.did_out; self := left));
    EXPORT AircraftDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(AirCraft_p, mode, 10);
            
    /********* AIRMEN **********/
    Airmen  := faa.file_airmen_data_out((unsigned6)did_out > 0 and current_flag = 'A'); //Select ONLY ACTIVE records
    Airmen_p := project(Airmen, transform({recordof(Airmen) - [did_out], unsigned6 did}, self.did := (unsigned6)left.did_out; self := left));
    EXPORT AirmenDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Airmen_p, mode, 11);

    /********* BANKRUPTCY **********/
    Bankruptcy := bankruptcyV2.file_bankruptcy_search_v3(name_type='D' and lname!='' and prim_name!='', (unsigned6)did > 0);
    Bankruptcy_p := project(Bankruptcy, transform({recordof(Bankruptcy) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));
    EXPORT BankruptcyDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Bankruptcy_p, mode, 5);
    
    /********* CRIMINAL_RECORDS **********/
    Crims := doxie_files.File_Offenders((unsigned6)did > 0, data_type not in D2C.Constants.DOCRestrictedDataTypes, vendor not in D2C.Constants.DOCRestrictedVendors, D2C_Customers.SRC_Allowed.Check(7, vendor));
    Crims_p := project(Crims, transform({recordof(Crims) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));
    EXPORT CrimsDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Crims_p, mode, 7);

    /********* DEEDS_MORTGAGES **********/
    Deeds := ln_propertyv2.File_Search_DID(did > 0, D2C_Customers.SRC_Allowed.Check(20, ln_fares_id));
    EXPORT DeedsDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Deeds, mode, 20);
    
    /********* EMAIL_ADDRESSES **********/
    Emails := Email_Data.File_Email_Base(
         did > 0,
         current_rec=true,
         Clean_Email<>'',
         email_src not in D2C.Constants.EmailRestrictedSources,
         D2C_Customers.SRC_Allowed.Check(9, email_src));
    EXPORT EmailsDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Emails, mode, 9);

    /********* HUNTING_FISHING_PERMITS **********/
    Hunting := eMerges.file_hunters_out(
            (unsigned6)did_out > 0,
             Source_Code not in D2C.Constants.CCWRestrictedSources,
             D2C_Customers.SRC_Allowed.Check(12, source_code));
    Hunting_p := project(Hunting, transform({recordof(Hunting) - [did_out], unsigned6 did}, self.did := (unsigned6)left.did_out; self := left));             
    EXPORT HuntingDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Hunting_p, mode, 12);

    /********* LIENS_JUDGEMENTS **********/
    Liens := dataset('~thor_data400::base::liens::party', LiensV2.Layout_Liens_party_HeaderIngest, thor)((unsigned6)did > 0);
    Liens_p := project(Liens, transform({recordof(Liens) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));             
    EXPORT LiensDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Liens_p, mode, 13);

    /********* PEOPLE_AT_WORK **********/
    Paw := paw.files().base.built(
            (unsigned6)did > 0,
            score>'003',
            D2C_Customers.SRC_Allowed.Check(15, source)
            );
    Paw_p := project(Paw, transform({recordof(Paw) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));             
    EXPORT PawDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Paw_p, mode, 15);

    /********* PHONES **********/
    f_phonesplus := Phonesplus_v2.File_phonesplus_base(
                 did > 0,
                 current_rec,
                 D2C_Customers.SRC_Allowed.Check(16, vendor)
                 );
    IR_src_maxlastdt := max(f_phonesplus(vendor = 'IR'), datevendorlastreported); 
    phoneplus := f_phonesplus(vendor <> 'IR') + f_phonesplus(vendor = 'IR' and datevendorlastreported = IR_src_maxlastdt);
    ut.mac_suppress_by_phonetype(phoneplus,cellphone,state,_fphonesplus_cell,true,did);
    _keybuild_phonesplus_base := _fphonesplus_cell(cellphone<>'');
    Phones := _keybuild_phonesplus_base(vendor not in D2C.Constants.PhonesPlusV2RestrictedSources);
    EXPORT PhonesDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Phones, mode, 16);

    /********* PROFESSIONAL_LICENSES **********/
    PL := prof_licensev2.File_ProfLic_Base(
          (unsigned6)did > 0,
          D2C_Customers.SRC_Allowed.Check(17, vendor)
          );
    PL_p := project(PL, transform({recordof(PL) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));             
    EXPORT PLDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(PL_p, mode, 17);

    /********* SEX_OFFENDERS **********/
    //TBD 30% of data(substantial)
    SO := sexoffender.file_Main(D2C_Customers.SRC_Allowed.Check(18, source_file));
    SO_p := project(SO, transform({recordof(SO) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));             
    EXPORT SODS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(SO_p, mode, 18);

    /********* STUDENTS **********/
    ASL := American_student_list.File_american_student_DID(did > 0, D2C_Customers.SRC_Allowed.Check(22, source));
    EXPORT ASLDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(ASL, mode, 22);

    /********* TAX_ASSESSMENTS **********/
    //Recs filtered based on ln_fares_id[1..2]
    //Will include the latest tax record for each property owned over the last 10 years 
    Tax := ln_propertyv2.File_Search_DID(
                       did > 0,
                       Std.Date.YearsBetween((unsigned4)process_date,
                       Std.Date.Today()) < 10,
                       D2C_Customers.SRC_Allowed.Check(21, ln_fares_id));
    EXPORT TaxDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Tax, mode, 21);

    /********* NATIONAL_UCC **********/
    UCC := UCCV2.File_UCC_Party_Base(did > 0);
    EXPORT UCCDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(UCC, mode, 14);

    /********* VOTER_REGISTRATION **********/
    Voters := VotersV2.File_Voters_Base(did > 0, D2C_Customers.SRC_Allowed.Check(19, source));
    EXPORT VotersDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(Voters, mode, 19);

    /********* CONCEALED_WEAPONS **********/
    CCW := eMerges.file_ccw_base(
              (unsigned6)did_out > 0,
              Source_Code not in D2C.Constants.CCWRestrictedSources,
              D2C_Customers.SRC_Allowed.Check(15, source_state)
              );
    CCW_p := project(CCW, transform({recordof(CCW) - [did_out], unsigned6 did}, self.did := (unsigned6)left.did_out; self := left));                           
    EXPORT CCWDS(unsigned1 mode) := D2C_Customers.MAC_BaseFile(CCW_p, mode, 15);

    Foreclosure := Property.File_Foreclosure_Base_v2(name1_did <> '' or name2_did <> '' or name3_did <> '' or name4_did <> '');
    EXPORT ForeclosureDS(unsigned1 mode) := Foreclosure;//D2C_Customers.MAC_BaseFile(Foreclosure, mode, 23);

/********* FULL DS **********/
    wAllowedDeeds    := D2C_Customers.MAC_GetAllowedRecs(infutor_hdr, DeedsDS(1),  '[\'LP\']');
    wAllowedTax      := D2C_Customers.MAC_GetAllowedRecs(wAllowedDeeds, TaxDS(1), '[\'LA\']');
    wAllowedPL       := D2C_Customers.MAC_GetAllowedRecs(wAllowedTax, PLDS(1), '[\'PL\']');
    wAllowedHunting  := D2C_Customers.MAC_GetAllowedRecs(wAllowedPL, HuntingDS(1), '[\'E2\',\'E1\']');
    wAllowedLiens    := D2C_Customers.MAC_GetAllowedRecs(wAllowedHunting, LiensDS(1), '[\'L2\',\'LI\']');
    wAllowedCCW      := D2C_Customers.MAC_GetAllowedRecs(wAllowedLiens, CCWDS(1), '[\'E3\']');
    wAllowedPhones   := D2C_Customers.MAC_GetAllowedRecs(wAllowedCCW, PhonesDS(1), '[\'GO\',\'WP\',\'PN\',\'GN\']');
    wAllowedVoters   := D2C_Customers.MAC_GetAllowedRecs(wAllowedPhones, VotersDS(1), '[\'VO\']');

/*****Infutor Header********/
    shared TotalHdrRecs := if(TestBuild, topn(wAllowedVoters, 1000, did), wAllowedVoters);
    
/*****Infutor Best********/
    AllowedDidFomHdr := dedup(TotalHdrRecs, did, all);
//Select ONLY allowed dids from infutor best by joining with hdr
//101,198,920 dids are dropped from infutor best beacuse of join
    TotalBestRecs := join(distribute(infutor_best, hash(did)), distribute(AllowedDidFomHdr, hash(did)), left.did = right.did, transform(left), inner, local); 
    
    derogatoryDS := dedup(table(SODS(1), {did})
                        + table(CrimsDS(1), {did})
                        + table(BankruptcyDS(1), {did})
                        + table(LiensDS(1), {did})
                    ,all);
    BestDerogatory := join(distribute(infutor_best, hash(did)), distribute(derogatoryDS, hash(did)), left.did = right.did, transform(left), inner, local);                     
    
    FullInfBestDS := if(TestBuild, topn(TotalBestRecs, 1000, did), TotalBestRecs);
    DerogatoryInfBestDS := if(TestBuild, topn(BestDerogatory, 1000, did), BestDerogatory); 

    //FULL - 604,395,000
    //CORE - 248,957,730
    EXPORT InfutorBest(unsigned1 mode) := D2C_Customers.MAC_BaseFile(if(mode = 3, DerogatoryInfBestDS, FullInfBestDS), mode, 1) : persist('~persist::d2c::' + D2C_Customers.Constants.sMode(mode) + '::infutor_best');
    
    //FULL - 5,645,398,427
    EXPORT InfutorHdr(unsigned1 mode)  := D2C_Customers.MAC_BaseFile(TotalHdrRecs, mode, 0) : persist('~persist::d2c::' + D2C_Customers.Constants.sMode(mode) + '::infutor_hdr');      
END;