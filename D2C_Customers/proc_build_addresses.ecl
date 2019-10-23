import PromoteSupers, header;

/********* ADDRESS_HISTORY **********/     
EXPORT proc_build_addresses(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
  
   ds := map(mode = 1 => D2C_Customers.Files.FullHdrDS,            //FULL
             mode = 2 => D2C_Customers.Files.coreHdrDS,            //QUARTERLY
             mode = 3 => D2C_Customers.Files.coreHdrDerogatoryDS   //MONTHLY              
            );
   D2C_Customers.layouts.rAddressHist xf(ds L) := transform
    self.LexID   := L.did;
    self.Address := stringlib.stringcleanspaces(L.prim_range + ' ' + L.predir + ' ' + L.prim_name + ' ' + L.suffix + ' ' + L.postdir + ', '
                    + L.unit_desig + ' ' + L.sec_range + if(L.unit_desig <> '' or L.sec_range <> '', ', ', '')
                    + L.city_name + ', ' + L.st + ' ' + L.zip);
    self.Date_First_Seen  := L.dt_first_seen;
    self.Date_Last_Seen   := L.dt_last_seen;
   end; 

   inDS  := project(ds, xf(left));
   res   := MAC_WriteCSVFile(inDS, mode, ver, 'address_history');
   return res;

END;                                         