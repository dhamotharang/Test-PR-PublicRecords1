import std, PromoteSupers, VotersV2, Watchdog, D2C;

/********* VOTER_REGISTRATION **********/
//SRC code - 'VO'

EXPORT proc_build_voters(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
   
   //500M records
   BaseFile := D2C_Customers.Files.VotersDS(mode);

   inDS := project(BaseFile, transform(D2C_Customers.layouts.rVoter_Registration,
            self.LexID            := (unsigned6)left.did;
            self.Name             := stringlib.stringcleanspaces(left.first_name + ' ' + left.middle_name + ' ' + left.last_name + ' ' + left.name_suffix);
            self.Resident_Address := stringlib.stringcleanspaces(left.res_addr1 + ', ' + left.res_addr1 + if(left.res_addr1 <> '', ', ','') + left.res_city + ', ' + left.res_state + ' ' + left.res_zip);
            self.Gender           := left.Gender;
            self.Ethnicity        := left.race;
            self.Last_Vote_Date   := (unsigned4)left.lastdatevote;
            self.Registration_Date     := (unsigned4)left.regdate;
            self.State_of_registration := left.res_state;
            self.Status                := left.voter_status;
            ));
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 19);
   return res;

END;