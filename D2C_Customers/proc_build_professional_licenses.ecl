import std, PromoteSupers, prof_licensev2, Watchdog, D2C;

/********* PROFESSIONAL_LICENSES **********/
pl := prof_licensev2.File_ProfLic_Base((unsigned6)did > 0, D2C_Customers.SRC_Allowed(17, Vendor));//Unrestricted

EXPORT proc_build_professional_licenses(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(pl, transform(D2C_Customers.layouts.rProfessional_Licenses,
            self.LexID            := (unsigned6)left.did;
            self.License_Number   := left.orig_license_number;
            self.License_State    := left.Source_St;
            self.License_Type     := left.License_Type;
            self.Profession_Board := left.Profession_or_Board;
            self.Issue_Date       := (unsigned4)left.Issue_Date;
            self.Expiration_Date  := (unsigned4)left.Expiration_Date;
            self.License_Status   := left.status;
            ));
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), distribute(D2C_Customers.Files.coresDS, hash(did)), left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
   inDS := map(mode = 1 => fullDS,          //FULL
               mode = 2 => coreDS,          //QUARTERLY
               mode = 3 => coreDerogatoryDS //MONTHLY
               );
   
   res := MAC_WriteCSVFile(inDS, mode, ver, 'professional_licenses');
   return res;

END;