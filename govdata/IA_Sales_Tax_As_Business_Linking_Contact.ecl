IMPORT BIPV2, ut, mdr, _Validate, Address, Business_Header;

EXPORT IA_Sales_Tax_As_Business_Linking_Contact (
	  DATASET(govdata.Layout_IA_SalesTax_Base) pBase = govdata.File_IA_SalesTax_Base) := FUNCTION
  	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(govdata.Layout_IA_SalesTax_Base l) := TRANSFORM
				SELF.source                      := MDR.sourceTools.src_IA_Sales_Tax;       
				SELF.dt_first_seen               := IF(_Validate.date.fIsValid(l.issue_date), (UNSIGNED4)l.issue_date, 0);
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid(govdata.IA_Sales_Tax_File_Date), (UNSIGNED4)govdata.IA_Sales_Tax_File_Date, 0);
				SELF.company_bdid			   	       := l.bdid;
				SELF.company_name 			         := l.company_name_1;
				SELF.company_address.prim_range  := l.mailingAddress.prim_range;
				SELF.company_address.predir      := l.mailingAddress.predir;
				SELF.company_address.prim_name   := l.mailingAddress.prim_name;
				SELF.company_address.addr_suffix := l.mailingAddress.addr_suffix;
				SELF.company_address.postdir     := l.mailingAddress.postdir;
				SELF.company_address.unit_desig  := l.mailingAddress.unit_desig;
				SELF.company_address.sec_range   := l.mailingAddress.sec_range;
				SELF.company_address.p_city_name := l.mailingAddress.p_city_name;
				SELF.company_address.v_city_name := l.mailingAddress.v_city_name;
				SELF.company_address.st          := l.mailingAddress.st;
				SELF.company_address.zip	       := l.mailingAddress.zip;
				SELF.company_address.zip4        := l.mailingAddress.zip4;
				SELF.contact_name.title          := l.ownerName.title;
				SELF.contact_name.fname          := l.ownerName.fname;
				SELF.contact_name.mname          := l.ownerName.mname;
				SELF.contact_name.lname          := l.ownerName.lname;
				SELF.contact_name.name_suffix		 := l.ownerName.name_suffix;
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;
																										
		from_IA_proj	:= PROJECT(pBase, trfMAPBLInterface(LEFT));

	  BIPV2.Layout_Business_Linking_Full RollupIA_Sales_Tax(BIPV2.Layout_Business_Linking_Full L, 
                                                          BIPV2.Layout_Business_Linking_Full R) := TRANSFORM
		  SELF.dt_first_seen            := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
					                             ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
		  SELF.dt_last_seen             := max(L.dt_last_seen,R.dt_last_seen);
		  SELF                          := L;
	  END;
		
    from_IA_dist   := DISTRIBUTE(from_IA_proj,HASH(company_bdid,company_name));
    from_IA_sort   := SORT(from_IA_dist, company_bdid, company_name, company_address.st, 
                           company_address.p_city_name, company_address.zip, company_address.prim_range,
                           company_address.predir, company_address.prim_name, company_address.addr_suffix,
                           company_address.postdir, company_address.unit_desig, contact_name.lname, 
                           contact_name.fname, contact_name.mname, contact_name.name_suffix, 
                           contact_name.title, dt_first_seen,
                           LOCAL);
		from_IA_rollup := ROLLUP(from_IA_sort, 
                             LEFT.company_bdid                = RIGHT.company_bdid AND
                             LEFT.company_name                = RIGHT.company_name AND
                             LEFT.company_address.st          = RIGHT.company_address.st AND
                             LEFT.company_address.p_city_name = RIGHT.company_address.p_city_name AND
                             LEFT.company_address.v_city_name = RIGHT.company_address.v_city_name AND
                             LEFT.company_address.zip         = RIGHT.company_address.zip AND
                             LEFT.company_address.prim_range  = RIGHT.company_address.prim_range AND
                             LEFT.company_address.predir      = RIGHT.company_address.predir AND
                             LEFT.company_address.prim_name   = RIGHT.company_address.prim_name AND
                             LEFT.company_address.addr_suffix = RIGHT.company_address.addr_suffix AND
                             LEFT.company_address.postdir     = RIGHT.company_address.postdir AND
                             LEFT.company_address.unit_desig  = RIGHT.company_address.unit_desig AND
                             LEFT.contact_name.lname          = RIGHT.contact_name.lname AND
                             LEFT.contact_name.fname          = RIGHT.contact_name.fname AND
                             LEFT.contact_name.mname          = RIGHT.contact_name.mname AND
                             LEFT.contact_name.name_suffix    = RIGHT.contact_name.name_suffix AND
                             LEFT.contact_name.title          = RIGHT.contact_name.title,
                             RollupIA_Sales_Tax(LEFT, RIGHT),
                             LOCAL);

		RETURN from_IA_rollup;
END;
