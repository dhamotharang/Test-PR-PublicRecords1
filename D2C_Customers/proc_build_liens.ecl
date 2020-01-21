import std, PromoteSupers, LiensV2, Watchdog, D2C;

/********* LIENS_JUDGEMENTS **********/

// li := LiensV2.key_liens_DID(did > 0);//Unrestricted
//SRC code - 'L2','LI'

EXPORT proc_build_liens(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
   
   //771M records
   BaseFile := D2C_Customers.Files.LiensDS(mode);
   //371M records
   li_main  := dataset('~thor_data400::base::liens::main', liensv2.Layout_liens_main_module.layout_liens_main, thor)(D2C_Customers.SRC_Allowed.Check(13, filing_state));

   li := join(distribute(BaseFile, hash(tmsid)), distribute(li_main, hash(tmsid)), left.rmsid = right.rmsid and left.tmsid = right.tmsid, left outer, local);

   inDS := project(li, transform(D2C_Customers.layouts.rLiens,
    self.LexID         := left.did;
    self.Name          := stringlib.stringcleanspaces(left.fname + ' ' + left.mname + ' ' + left.lname + ' ' + left.name_suffix);
    self.Address       := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.addr_suffix + ' ' + left.postdir + ', '
                + left.unit_desig + ' ' + left.sec_range + if(left.unit_desig <> '' or left.sec_range <>'', ', ', '')
                + left.p_city_name + ', ' + left.st + ' ' + left.zip);
    self.Original_Filing_Date  := (unsigned4)left.Orig_Filing_Date;
    self.Creditors             := if(left.name_type = 'C', left.cname, '');
    self.Eviction              := left.Eviction;
    self.Filing_Number         := left.Filing_Number;   
    self.Filing_Location       := left.Filing_jurisdiction;
    self.Filing_Type           := left.Orig_Filing_Type; 
    self.Amount                := left.Amount; 
    self.Book_Page             := left.filing_Book;  //most likely
    self.Release_Date          := (unsigned4)left.Release_Date;
    ));
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 13);
   return res;

END;