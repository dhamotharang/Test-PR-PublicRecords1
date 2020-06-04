import std, PromoteSupers, Email_Data, Watchdog, D2C;

/********* EMAIL_ADDRESSES **********/

EXPORT proc_build_emails(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
   
   //6B records
   BaseFile := D2C_Customers.Files.EmailsDS(mode);

   //keeping ONLY 3 email address per did based on latest date_last_seen
   em_d  := dedup(sort(distribute(BaseFile, hash(did)), did, clean_email, -date_last_seen, local), did, clean_email, all, local);  
   em_g  := group(em_d, did);
   em_t  := topn(em_g, 3, did);
   em_ug := group(em_t); //ungroup

   inDS := project(em_ug, transform(D2C_Customers.layouts.rEmails,
            self.LexID         := (unsigned6)left.did;
            self.Email_Address := left.clean_email;       
            ));

   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 9);
   return res;


END;