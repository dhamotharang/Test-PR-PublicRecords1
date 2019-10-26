import std, PromoteSupers, Infutor, Relationship, Header, death_master;

/********* CONSUMER_FILE **********/

EXPORT proc_build_consumers(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   death := Header.File_DID_Death_MasterV2 ((integer)did >0 and state_death_id=death_master.fn_fake_state_death_id(ssn,lname,dod8)) ; 
   //crlf='SA' flags Direct records where the SSN was overlaid w/ one from the SSA
   dist_death := distribute(death(crlf<>'SA'), hash(did));
   dsDeath := dedup(sort(dist_death, did, -filedate, local), did, filedate, local);

   Infutor_Best := map( mode = 1 => D2C_Customers.Files.FullInfutorDS,            //FULL
                        mode = 2 => D2C_Customers.Files.coreInfutorDS,            //QUARTERLY
                        mode = 3 => D2C_Customers.Files.coreInfutorDerogatoryDS   //MONTHLY
                      );   
   ds := join(
      distribute(Infutor_Best, hash(did)),
      distribute(dsDeath, hash((unsigned6)did)),
      left.did = (unsigned6)right.did,
      transform({Infutor_Best, unsigned4 Date_of_Death}, self.Date_of_Death := (unsigned4)right.dod8; self := left;),
      left outer,
      local);
   
   //Get all transunion records with dob whch needs to be blank out
   //needs to find out the transunion srcs
   //the cluster has records with TU with dob and no other srcs has dob
   notTU := dedup(Infutor.infutor_header(src not in ['TS', 'LT', 'TU'], dob > 0), did, all);
   notTU_dids := set(notTU, did);

   //cannot send more than 75% TU records with low dids - TBD
   //how many unqique lexid has TU records in infutor header
   //src GN for Neustar - breakdown of segmentation
   //src 1F for Infutor - breakdown of segmentation
   //infutor header conists of GONG(GO) and GN

   relatives := distribute(Relationship.key_relatives_v3(not(confidence IN ['NOISE','LOW'])), hash(did1));
   //Get all dids which are NOT the primary core dids
   notPrimary_dids := join(distribute(ds, hash(did)), relatives, left.did = right.did1, left only, local); //56,740,234
   setofNonCoreDids := set(notPrimary_dids, did);
   
   //Get all dids which are NOT the primary core dids and exist as associations ONLY
   // Associations_ONLY := join(distribute(notPrimary_dids, hash(did)), distribute(relatives, hash(did2)), left.did = right.did2, inner, local);  //752,653
   // Associations_ONLY_dids := set(Associations_ONLY, did);
   
   inDS := project(ds, transform(D2C_Customers.layouts.rConsumers,
            self.LexID         := left.did;
            self.Best_Name     := stringlib.stringcleanspaces(left.fname + ' ' + left.mname + ' ' + left.lname + ' ' + left.name_suffix);
            self.Best_Address  := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.suffix + ' ' + left.postdir + ', '
                                + left.unit_desig + ' ' + left.sec_range + if(left.unit_desig  <> '' or left.sec_range <> '', ', ', '')
                                + left.city_name + ', ' + left.st + ' ' + left.zip);
            self.Best_DOB      := if(left.did in notTU_dids, (unsigned4)(((string8)left.dob)[1..6] + '00'), 0);   //Last 2 digit(DD) is masked
            self.Derived_Age   := Std.Date.YearsBetween(left.dob ,Std.Date.Today());
            self.Date_of_Death := left.Date_of_Death;
            //needs to revisit this
            self.Report_Candidate := if(left.did in setofNonCoreDids and mode = 1, 'N', 'Y');
            ));
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 1);
   return res;

END;