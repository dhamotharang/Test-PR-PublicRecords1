import prof_licensev2,D2C_Customers;

//461M records
PL := prof_licensev2.File_ProfLic_Base(
          (unsigned6)did > 0,
          D2C_Customers.SRC_Allowed.Check(17, vendor)
          );

// dMain:=DEDUP(SORT(DISTRIBUTE(reunion.mapping_reunion_main,HASH(did)),RECORD,LOCAL),LOCAL);
// PL_p := project(PL, transform({recordof(PL) - [did], unsigned6 did}, self.did := (unsigned6)left.did; self := left));
// dAliasesOnly:=JOIN(dAliasesDeduped,dMain,LEFT.main_adl=RIGHT.adl AND LEFT.title=RIGHT.best_title AND LEFT.fname=RIGHT.best_fname AND LEFT.mname=RIGHT.best_mname AND LEFT.lname=RIGHT.best_lname AND LEFT.name_suffix=RIGHT.best_name_suffix,TRANSFORM(RECORDOF(dAliasesDeduped),SELF:=LEFT;),LEFT ONLY,LOCAL);

// inDS := project(BaseFile, transform(D2C_Customers.layouts.rProfessional_Licenses,
//             self.LexID            := left.did;
//             self.License_Number   := left.orig_license_number;
//             self.License_State    := left.Source_St;
//             self.License_Type     := left.License_Type;
//             self.Profession_Board := left.Profession_or_Board;
//             self.Issue_Date       := (unsigned4)left.Issue_Date;
//             self.Expiration_Date  := (unsigned4)left.Expiration_Date;
//             self.License_Status   := left.status;
//             ));

	
	EXPORT mapping_reunion_pl:=PL:PERSIST('~thor::persist::mylife::mapping_pl');