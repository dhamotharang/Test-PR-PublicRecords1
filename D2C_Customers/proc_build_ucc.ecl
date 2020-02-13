import std, PromoteSupers, UCCV2, Watchdog, D2C;

/********* NATIONAL_UCC **********/

EXPORT proc_build_ucc(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   //400M records
   BaseFile := D2C_Customers.Files.UCCDS(mode);
   
   //200M records
   main  := UCCV2.File_UCC_Main_Base(D2C_Customers.SRC_Allowed.Check(14, filing_jurisdiction));

   D2C_Customers.layouts.rUCC CombineMain_Party(BaseFile L, main R) := transform
        self.LexID                 := L.did;
        self.Debtor                := stringlib.stringcleanspaces(if(L.party_type	= 'D', L.fname + ' ' + L.mname + ' ' + L.lname + ' ' + L.name_suffix,''));
        self.Address               := stringlib.stringcleanspaces(if(L.party_type	= 'D', L.orig_address1 + ', ' + if(L.orig_address1 <> '', L.orig_address2 + ', ', '') + L.orig_city + ', ' + L.orig_state + ' ' + L.orig_zip5,''));
        self.Secured_Name          := stringlib.stringcleanspaces(if(L.party_type	= 'S', L.fname + ' ' + L.mname + ' ' + L.lname + ' ' + L.name_suffix,''));
        self.Secured_Address       := stringlib.stringcleanspaces(if(L.party_type	= 'S', L.orig_address1 + ', ' + if(L.orig_address1 <> '', L.orig_address2 + ', ', '') + L.orig_city + ', ' + L.orig_state + ' ' + L.orig_zip5,''));
        self.Filing_Type           := R.Filing_Type;
        self.Original_Filing_Date  := (unsigned4)R.Orig_Filing_Date;
        self.Original_Filing_Number:= R.Orig_Filing_Number;
        self.Filing_Jurisdiction   := R.Filing_Jurisdiction;
        self.Filing_Agency         := R.Filing_Agency;   
        self.Filing_Agency_Address := R.address + ', ' + R.city + ', ' + R.state + ' ' + R.zip;
        self.Filing_Status         := R.Filing_Status;
        self.Expiration_Date       := (unsigned4)R.Expiration_Date;
   end;
   
   inDS := join(distribute(BaseFile, hash(tmsid, rmsid)),
                distribute(main, hash(tmsid, rmsid)), 
                left.tmsid = right.tmsid and left.rmsid = right.rmsid,
                CombineMain_Party(left,right),
                inner,
                local
                );
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 14);
   return res;

END;