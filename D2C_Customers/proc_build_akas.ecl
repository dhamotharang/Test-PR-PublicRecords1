import PromoteSupers, header;

/********* AKAS **********/     
EXPORT proc_build_akas(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := map( mode = 1 => D2C_Customers.Files.FullHdrDS,            //FULL
              mode = 2 => D2C_Customers.Files.coreHdrDS,            //QUARTERLY
              mode = 3 => D2C_Customers.Files.coreHdrDerogatoryDS   //MONTHLY
            );

   D2C_Customers.layouts.rAkas xf(ds L) := transform
    self.LexID       := L.did;
    self.Title       := L.title;
    self.Name        := stringlib.stringcleanspaces(L.fname + ' ' + L.mname + ' ' + L.lname + ' ' + L.name_suffix);
   end;         

   inDS  := project(ds, xf(left));

   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 3);
   return res;

END;