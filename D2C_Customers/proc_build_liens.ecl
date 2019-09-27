import std, PromoteSupers, LiensV2, Watchdog, D2C;

/********* LIENS_JUDGEMENTS **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));
// li := LiensV2.key_liens_DID(did > 0);//Unrestricted

li_main  := dataset('~thor_data400::base::liens::main', liensv2.Layout_liens_main_module.layout_liens_main, thor);
li_party := dataset('~thor_data400::base::liens::party', LiensV2.Layout_Liens_party_HeaderIngest, thor)(did > 0);
li := join(distribute(li_party, hash(tmsid)), distribute(li_main, hash(tmsid)), left.rmsid = right.rmsid and left.tmsid = right.tmsid, left outer, local);

EXPORT proc_build_liens(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(li, transform(layouts.liens,
    self.LexID         := (unsigned6)left.did;
    self.Name          := left.fname + ' ' + left.mname + ' ' + left.lname;
    self.Address       := left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.addr_suffix + ' ' + left.postdir + ', '
                + left.unit_desig + ' ' + left.sec_range + if(left.unit_desig <> '' or left.sec_range <>'', ', ', '')
                + left.p_city_name + ', ' + left.st + ' ' + left.zip;
    self.Original_Filing_Date  := (unsigned4)left.Orig_Filing_Date;
    self.Creditors             := if(left.name_type = 'C', left.cname);
    self.Eviction              := left.Eviction;
    self.Filing_Number         := left.Filing_Number;   
    self.Filing_Location       := left.Filing_jurisdiction;
    self.Filing_Type           := left.Orig_Filing_Type; 
    self.Amount                := left.Amount; 
    self.Book_Page             := left.filing_Book;  //most likely
    self.Release_Date          := (unsigned4)left.Release_Date;
    ));
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), Wdog, left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
   outDS := map( mode = 1 => fullDS,           //FULL
                 mode = 2 => coreDS,           //QUARTERLY
                 mode = 3 => coreDerogatoryDS  //MONTHLY
               );
   
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::liens',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('liens - INVALID MODE - ' + Mode), doit);

END;