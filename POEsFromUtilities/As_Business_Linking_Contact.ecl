IMPORT BIPV2, ut, mdr, _Validate;

Export As_Business_Linking_Contact (DATASET(POEsFromUtilities.Layouts.base) pBase = POEsFromUtilities.Files().base.qa) := FUNCTION

	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(POEsFromUtilities.layouts.base l) := TRANSFORM
        SELF.source                      	:= 	l.source; 
				SELF.dt_first_seen              	:= 	l.dt_first_seen;
				SELF.dt_last_seen               	:=  l.dt_last_seen;
				SELF.company_bdid			   	       	:= 	l.bdid;
				self.contact_did									:=	l.did;
				SELF.company_name 			         	:= 	l.company_name;
				SELF.company_address.prim_range 	:= 	l.subject_address.prim_range;
				SELF.company_address.predir 			:=	l.subject_address.predir;
				SELF.company_address.prim_name 		:= 	l.subject_address.prim_name;
				SELF.company_address.addr_suffix 	:= 	l.subject_address.addr_suffix;
				SELF.company_address.postdir 			:= 	l.subject_address.postdir;
				SELF.company_address.unit_desig 	:= 	l.subject_address.unit_desig;
				SELF.company_address.sec_range 		:= 	l.subject_address.sec_range;
				SELF.company_address.v_city_name	:= 	l.subject_address.city_name;
				SELF.company_address.st 					:= 	l.subject_address.st;
				SELF.company_address.zip 					:= 	l.subject_address.zip;
				SELF.company_address.zip4 				:=	l.subject_address.zip4;
				self.company_Aceaid								:=	l.subject_aceaid;
				self.company_rawaid								:=	l.subject_rawaid;
				SELF.company_phone              	:= 	(string)l.company_phone;
				SELF.phone_type                 	:= 	'';
				SELF.contact_name.title 					:= 	l.subject_name.title;
				SELF.contact_name.fname 					:=	l.subject_name.fname;
				SELF.contact_name.mname 					:= 	l.subject_name.mname;
				SELF.contact_name.lname 					:= 	l.subject_name.lname;
				SELF.contact_name.name_suffix 		:= 	l.subject_name.name_suffix;
				SELF.contact_email              	:=	'';
				SELF.contact_phone              	:= 	(string)l.subject_phone;
				self.company_fein									:=	(string)l.company_fein;
				SELF 							   							:= 	l;
				SELF 							   							:= [];
		end;																										
		from_MH_norm	:= project(pBase, trfMAPBLInterface(LEFT));

	  BIPV2.Layout_Business_Linking_Full RollupMH(BIPV2.Layout_Business_Linking_Full L, 
                                                BIPV2.Layout_Business_Linking_Full R) := TRANSFORM
		  SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
					                                ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
		  SELF.dt_last_seen                := Max(L.dt_last_seen,R.dt_last_seen);
		  SELF.dt_vendor_first_reported    := ut.EarliestDate(ut.EarliestDate(L.dt_vendor_first_reported,R.dt_vendor_first_reported),
					                                ut.EarliestDate(L.dt_vendor_last_reported,R.dt_vendor_last_reported));
		  SELF.dt_vendor_last_reported     := Max(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
		  SELF.company_address.prim_range  := IF(L.company_address.prim_range  <> '', L.company_address.prim_range,  R.company_address.prim_range);
			SELF.company_address.predir      := IF(L.company_address.predir      <> '', L.company_address.predir,      R.company_address.predir);
			SELF.company_address.prim_name   := IF(L.company_address.prim_name   <> '', L.company_address.prim_name,   R.company_address.prim_name);
			SELF.company_address.addr_suffix := IF(L.company_address.addr_suffix <> '', L.company_address.addr_suffix, R.company_address.addr_suffix);
			SELF.company_address.postdir     := IF(L.company_address.postdir     <> '', L.company_address.postdir,     R.company_address.postdir);
			SELF.company_address.unit_desig  := IF(L.company_address.unit_desig  <> '', L.company_address.unit_desig,  R.company_address.unit_desig);
			SELF.company_address.sec_range   := IF(L.company_address.sec_range   <> '', L.company_address.sec_range,   R.company_address.sec_range);
			SELF.company_address.p_city_name := IF(L.company_address.p_city_name <> '', L.company_address.p_city_name, R.company_address.p_city_name);
			SELF.company_address.v_city_name := IF(L.company_address.v_city_name <> '', L.company_address.v_city_name, R.company_address.v_city_name);
			SELF.company_address.st          := IF(L.company_address.st          <> '', L.company_address.st,          R.company_address.st);
			SELF.company_address.zip	       := IF(L.company_address.zip         <> '', L.company_address.zip,         R.company_address.zip);
			SELF.company_address.zip4        := IF(L.company_address.zip4        <> '', L.company_address.zip4,        R.company_address.zip4);
			SELF.company_phone               := IF(L.company_phone               <> '', L.company_phone,               R.company_phone);
			SELF.contact_phone               := IF(L.contact_phone               <> '', L.contact_phone,               R.contact_phone);
		  SELF                             := L;
	  END;
		
    from_MH_dist   := DISTRIBUTE(from_MH_norm,HASH(company_bdid,company_name));
    from_MH_sort   := SORT(from_MH_dist, company_bdid, company_name, company_address.st, 
                           company_address.p_city_name, company_address.zip, company_address.prim_range,
                           company_address.predir, company_address.prim_name, company_address.addr_suffix,
                           company_address.postdir, company_address.unit_desig, contact_name.lname, 
                           contact_name.fname, contact_name.mname, contact_name.name_suffix, 
                           contact_name.title, company_phone, contact_phone, -dt_last_seen,
                           LOCAL);
		from_MH_rollup := ROLLUP(from_MH_sort, 
                             LEFT.company_bdid									= RIGHT.company_bdid AND
                             LEFT.company_name                	= RIGHT.company_name AND
                             (LEFT.company_address.st 					= '' OR 	
														  RIGHT.company_address.st 					= '' OR
                              LEFT.company_address.st 					= RIGHT.company_address.st) AND
                             (LEFT.company_address.p_city_name 	= '' OR 
															RIGHT.company_address.p_city_name = '' OR
                              LEFT.company_address.p_city_name 	= RIGHT.company_address.p_city_name) AND
                             (LEFT.company_address.v_city_name 	= '' OR 
															RIGHT.company_address.v_city_name = '' OR
                              LEFT.company_address.v_city_name 	= RIGHT.company_address.v_city_name) AND
                             (LEFT.company_address.zip 					= '' OR 
															RIGHT.company_address.zip 				= '' OR
                              LEFT.company_address.zip 					= RIGHT.company_address.zip) AND
                             (LEFT.company_address.prim_range 	= '' OR 
															RIGHT.company_address.prim_range 	= '' OR
                              LEFT.company_address.prim_range 	= RIGHT.company_address.prim_range) AND
                             (LEFT.company_address.predir 			= '' OR 
															RIGHT.company_address.predir 			= '' OR
                              LEFT.company_address.predir 			= RIGHT.company_address.predir) AND
                             (LEFT.company_address.prim_name 		= '' OR 
															RIGHT.company_address.prim_name 	= '' OR
                              LEFT.company_address.prim_name 		= RIGHT.company_address.prim_name) AND
                             (LEFT.company_address.addr_suffix 	= '' OR 
															RIGHT.company_address.addr_suffix = '' OR
                              LEFT.company_address.addr_suffix 	= RIGHT.company_address.addr_suffix) AND
                             (LEFT.company_address.postdir			= '' OR 
															RIGHT.company_address.postdir 		= '' OR
                              LEFT.company_address.postdir 			= RIGHT.company_address.postdir) AND
                             (LEFT.company_address.unit_desig 	= '' OR 
															RIGHT.company_address.unit_desig 	= '' OR
                              LEFT.company_address.unit_desig 	= RIGHT.company_address.unit_desig) AND
															LEFT.contact_name.lname          	= RIGHT.contact_name.lname AND
															LEFT.contact_name.fname          	= RIGHT.contact_name.fname AND
															LEFT.contact_name.mname          	= RIGHT.contact_name.mname AND
															LEFT.contact_name.name_suffix    	= RIGHT.contact_name.name_suffix AND
															(LEFT.contact_phone = '' OR RIGHT.contact_phone = '' OR LEFT.contact_phone = RIGHT.contact_phone),
                             RollupMH(LEFT, RIGHT),
                             LOCAL);
    
    //Returning records that have a company name and either an address or phone
		RETURN from_MH_rollup(company_name != '' AND ((company_address.prim_name != '' OR company_address.p_city_name != '' OR
                                                  company_address.v_city_name != '' OR company_address.st != '' OR company_address.zip != '')
							            )
                          );
END;