
IMPORT BatchServices,Autokey_batch,AutoStandardI;

UCase := StringLib.StringToUpperCase;

EXPORT BatchServices.layout_Business_Batch_out xfm_Business_make_flat_yp(
	Autokey_batch.Layouts.rec_inBatchMaster l,
	BatchServices.Layouts.Business.rec_acctnos_recs_yp r) := 
	TRANSFORM

		SELF.acctno                   := l.acctno;
		
		tempmod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI.full,opt))
			export allow_wildcard := false;
			export bdid_field := (string)r.bdid;
			export city_field := r.p_city_name;
			export city2_field := r.v_city_name;
			export cname_field := r.business_name;
			export county_field := '';
			export did_field := '';
			export dob_field := '';
			export fein_field := '';
			export fname_field := r.exec_fname;
			export mname_field := r.exec_mname;
			export lname_field := r.exec_lname;
			export phone_field := '';
			export pname_field := r.prim_name;
			export postdir_field := r.postdir;
			export prange_field := r.prim_range;
			export predir_field := r.predir;
			export ssn_field := '';
			export state_field := r.st;
			export suffix_field := r.suffix;
			export zip_field := r.zip;

			export firstname := l.name_first;
			export middlename := l.name_middle;
			export lastname := l.name_last;
			export prim_range := l.prim_range;
			export predir := l.predir;
			export prim_name := l.prim_name;
			export suffix := l.addr_suffix;
			export postdir := l.postdir;
			export sec_range := l.sec_range;
			export city := l.p_city_name;
			export state := l.st;
			export zip := l.z5;
			export ssn := l.ssn;
			export dob := (unsigned8)l.dob;
			export agehigh := 0;
			export agelow := 0;
			export phone := '';
			export did := intformat(l.did,14,1);
			export fein := l.fein;
			export companyname := l.comp_name;
		end;
		
		tempmod_phone1 := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
			export phone := l.homephone;
			export phone_field := r.phone10;
		end;
		
		tempmod_phone2 := module(project(tempmod_phone1,AutoStandardI.LIBIN.PenaltyI_Phone.full))
			export phone := l.workphone;
		end;
		
		SELF.penalt                   := if(r.business_name = '',0,
			AutoStandardI.LIBCALL_PenaltyI.val(tempmod) +
			map(
				l.homephone != '' and l.workphone != '' =>
					min(
						AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmod_phone1),
						AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmod_phone2)),
				l.homephone != '' =>
					AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmod_phone1),
				l.workphone != '' =>
					AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmod_phone2),
				0));

		// Core
		
		SELF.bdid	                    := r.bdid;
		SELF.company_name             := UCase(r.Business_Name);
		SELF.street                   := UCase(r.Orig_Street);
		SELF.city                     := UCase(r.Orig_City);
		SELF.state                    := UCase(r.Orig_State);
		SELF.zip                      := r.Orig_Zip;
		SELF.phone                    := r.Orig_Phone10;          
		
		SELF.sic_cd                   := r.Sic_Code;
		SELF.sic_desc                 := r.Heading_String;
		SELF.num_employees            := case(UCase(r.Employee_Code),
																			 'A' => '1-4',
																			 'B' => '5-9',
																			 'C' => '10-19',
																			 'D' => '20-49',
																			 'E' => '50-99',
																			 'F' => '100-249',
																			 'G' => '250-499',
																			 'H' => '500-999',
																			 'I' => '1000+',
																			 '');
		SELF.email                    := r.Email_Address;
		SELF.url                      := r.Web_Address;
		
		// Contacts (10) 
		
		SELF.executive_1_name         := UCase(r.executive_name);
		SELF.executive_1_title        := UCase(r.executive_title);
                                     
		SELF                          := [];
		                                
	END;