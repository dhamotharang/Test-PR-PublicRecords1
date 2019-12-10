import std, PromoteSupers, prof_licensev2, Watchdog, D2C;

/********* PROFESSIONAL_LICENSES **********/
//SRC code - 'PL'

EXPORT proc_build_professional_licenses(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
   
   //461M records
   BaseFile := D2C_Customers.Files.PLDS(mode);

   inDS := project(BaseFile, transform(D2C_Customers.layouts.rProfessional_Licenses,
            self.LexID            := left.did;
            self.License_Number   := left.orig_license_number;
            self.License_State    := left.Source_St;
            self.License_Type     := left.License_Type;
            self.Profession_Board := left.Profession_or_Board;
            self.Issue_Date       := (unsigned4)left.Issue_Date;
            self.Expiration_Date  := (unsigned4)left.Expiration_Date;
            self.License_Status   := left.status;
            ));

   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 17);
   return res;

END;