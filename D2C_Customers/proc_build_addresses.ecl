import PromoteSupers, header, ut;

/********* ADDRESS_HISTORY **********/     
EXPORT proc_build_addresses(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
  
   ds := map(mode = 1 => D2C_Customers.Files.FullHdrDS,            //FULL
             mode = 2 => D2C_Customers.Files.coreHdrDS,            //QUARTERLY
             mode = 3 => D2C_Customers.Files.coreHdrDerogatoryDS   //MONTHLY              
            );
   D2C_Customers.layouts.rAddressHist AddAddr(ds L) := transform
    self.LexID   := L.did;
    self.Address := stringlib.stringcleanspaces(L.prim_range + ' ' + L.predir + ' ' + L.prim_name + ' ' + L.suffix + ' ' + L.postdir + ', '
                    + L.unit_desig + ' ' + L.sec_range + if(L.unit_desig <> '' or L.sec_range <> '', ', ', '')
                    + L.city_name + ', ' + L.st + ' ' + L.zip);
    self.Date_First_Seen  := L.dt_first_seen;
    self.Date_Last_Seen   := L.dt_last_seen;
   end; 

   addr  := project(ds, AddAddr(left));

   // Rolling up all sub set date ranges within the super set date range
   addr rollUpDates(addr l, addr r) := TRANSFORM
	   SELF.Date_First_Seen := ut.Min2(l.Date_First_Seen, r.Date_First_Seen);//if(l.Date_First_Seen <= r.Date_First_Seen, l.Date_First_Seen, r.Date_First_Seen);
	   SELF.Date_Last_Seen  := if(l.Date_Last_Seen >= r.Date_Last_Seen, l.Date_Last_Seen, r.Date_Last_Seen);
	   self := l;
   END;

   // ut.Min2()

   inDS := rollup(sort(distribute(addr, hash(LexID)), LexID, Date_First_Seen, -Date_Last_Seen, local), rollUpDates(left,right), left.LexID = right.LexID and left.Date_First_Seen <= right.Date_First_Seen and left.Date_Last_Seen >= right.Date_Last_Seen, local);

   res   := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 2);
   return res;

END;                                         