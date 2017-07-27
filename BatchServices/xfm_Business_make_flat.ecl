
IMPORT BatchServices,Autokey_batch,AutoStandardI;

UCase := StringLib.StringToUpperCase;

EXPORT BatchServices.layout_Business_Batch_out xfm_Business_make_flat(
	Autokey_batch.Layouts.rec_inBatchMaster l,
	BatchServices.Layouts.Business.rec_acctnos_recs r) := 
	TRANSFORM

		SELF.acctno                   := l.acctno;
		
		tempmod_addr := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
			export allow_wildcard := false;
			export city_field := r.p_city_name;
			export city2_field := r.v_city_name;
			export pname_field := r.prim_name;
			export postdir_field := r.postdir;
			export prange_field := r.prim_range;
			export predir_field := r.predir;
			export state_field := r.st;
			export suffix_field := r.addr_suffix;
			export zip_field := r.zip;
			
			export city := l.p_city_name;
			export postdir := l.postdir;
			export predir := l.predir;
			export prim_name := l.prim_name;
			export prim_range := l.prim_range;
			export sec_range := l.sec_range;
			export state := l.st;
			export suffix := l.addr_suffix;
			export zip := l.z5;
		end;
		tempmod_addr2 := module(project(tempmod_addr,AutoStandardI.LIBIN.PenaltyI_Addr.full))
			export city_field := r.p_city_nameA;
			export city2_field := r.v_city_nameA;
			export pname_field := r.prim_nameA;
			export postdir_field := r.postdirA;
			export prange_field := r.prim_rangeA;
			export predir_field := r.predirA;
			export state_field := r.stA;
			export suffix_field := r.addr_suffixA;
			export zip_field := r.zipA;
		end;
		
		tempmod_bizname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
			export companyname := l.comp_name;
			export cname_field := r.name;
		end;
		
		tempmod_indvname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
			export allow_wildcard := false;
			export fname_field := r.exec1_fname;
			export mname_field := r.exec1_mname;
			export lname_field := r.exec1_lname;
			
			export firstname := l.name_first;
			export middlename := l.name_middle;
			export lastname := l.name_last;
		end;
		
		tempmod_indvname2 := module(project(tempmod_indvname,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full))
			export fname_field := r.exec2_fname;
			export mname_field := r.exec2_mname;
			export lname_field := r.exec2_lname;
		end;
		
		tempmod_indvname3 := module(project(tempmod_indvname,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full))
			export fname_field := r.exec3_fname;
			export mname_field := r.exec3_mname;
			export lname_field := r.exec3_lname;
		end;
		
		tempmod_indvname4 := module(project(tempmod_indvname,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full))
			export fname_field := r.exec4_fname;
			export mname_field := r.exec4_mname;
			export lname_field := r.exec4_lname;
		end;
		
		tempmod_indvname5 := module(project(tempmod_indvname,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full))
			export fname_field := r.exec5_fname;
			export mname_field := r.exec5_mname;
			export lname_field := r.exec5_lname;
		end;
		
		tempmod_indvname6 := module(project(tempmod_indvname,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full))
			export fname_field := r.exec6_fname;
			export mname_field := r.exec6_mname;
			export lname_field := r.exec6_lname;
		end;
		
		tempmod_indvname7 := module(project(tempmod_indvname,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full))
			export fname_field := r.exec7_fname;
			export mname_field := r.exec7_mname;
			export lname_field := r.exec7_lname;
		end;
		
		tempmod_indvname8 := module(project(tempmod_indvname,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full))
			export fname_field := r.exec8_fname;
			export mname_field := r.exec8_mname;
			export lname_field := r.exec8_lname;
		end;
		
		tempmod_indvname9 := module(project(tempmod_indvname,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full))
			export fname_field := r.exec9_fname;
			export mname_field := r.exec9_mname;
			export lname_field := r.exec9_lname;
		end;
		
		tempmod_indvname10 := module(project(tempmod_indvname,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full))
			export fname_field := r.exec10_fname;
			export mname_field := r.exec10_mname;
			export lname_field := r.exec10_lname;
		end;
		
		tempmod_phone := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
			export phone_field := r.phone;
			
			export phone := l.homephone;
		end;
		
		tempmod_phone2 := module(project(tempmod_phone,AutoStandardI.LIBIN.PenaltyI_Phone.full))
			export phone := l.workphone;
		end;
		
		SELF.penalt                   := if(r.name = '',0,
			min(
				/*r.p_city_name != '' or r.v_city_name != '' or r.zip != '' or r.st != '' or r.prim_name != '',*/AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod_addr),
				/*r.p_city_nameA != '' or r.v_city_nameA != '' or r.zipA != '' or r.stA != '' or r.prim_nameA != '',*/AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod_addr2)) +
			AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmod_bizname) +
			min(
				/*r.exec1_fname != '' or r.exec1_mname != '' or r.exec1_lname != '',*/AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmod_indvname),
				/*r.exec2_fname != '' or r.exec2_mname != '' or r.exec2_lname != '',*/AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmod_indvname2),
				/*r.exec3_fname != '' or r.exec3_mname != '' or r.exec3_lname != '',*/AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmod_indvname3),
				/*r.exec4_fname != '' or r.exec4_mname != '' or r.exec4_lname != '',*/AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmod_indvname4),
				/*r.exec5_fname != '' or r.exec5_mname != '' or r.exec5_lname != '',*/AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmod_indvname5),
				/*r.exec6_fname != '' or r.exec6_mname != '' or r.exec6_lname != '',*/AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmod_indvname6),
				/*r.exec7_fname != '' or r.exec7_mname != '' or r.exec7_lname != '',*/AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmod_indvname7),
				/*r.exec8_fname != '' or r.exec8_mname != '' or r.exec8_lname != '',*/AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmod_indvname8),
				/*r.exec9_fname != '' or r.exec9_mname != '' or r.exec9_lname != '',*/AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmod_indvname9),
				/*r.exec10_fname != '' or r.exec10_mname != '' or r.exec10_lname != '',*/AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmod_indvname10)) +
			(min(
				if(l.homephone != '',AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmod_phone),99),
				if(l.workphone != '',AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmod_phone2),99)) % 99));

		// Core
		
		SELF.bdid	                    := r.bdid;
		SELF.process_date             := r.process_date;
		SELF.company_name             := UCase(r.Name);
		SELF.street                   := UCase(r.Street);
		SELF.city                     := UCase(r.City);
		SELF.state                    := UCase(r.State);
		SELF.zip                      := r.Zip;
		SELF.phone                    := r.Phone;          
		
		SELF.sic_cd                   := r.Sic1;
		SELF.sic_desc                 := r.Text1;
		SELF.sales                    := r.sales;
		SELF.earnings                 := r.earnings;
		SELF.num_employees            := r.EMP_NUM;
		SELF.email                    := r.E_mail;
		SELF.url                      := r.URL;
		
		// Parent
		
		SELF.parent_company_name      := '';
		SELF.parent_street            := '';
		SELF.parent_city              := '';
		SELF.parent_state             := '';
		SELF.parent_zip               := '';
		SELF.parent_phone             := '';
		
		// Subsidiaries
		
		SELF.parent_subsid_1_company_name     := '';
		SELF.parent_subsid_1_street           := '';
		SELF.parent_subsid_1_city             := '';
		SELF.parent_subsid_1_state            := '';
		SELF.parent_subsid_1_zip              := '';
		SELF.parent_subsid_1_phone            := '';
		
		SELF.parent_subsid_2_company_name     := '';
		SELF.parent_subsid_2_street           := '';
		SELF.parent_subsid_2_city             := '';
		SELF.parent_subsid_2_state            := '';
		SELF.parent_subsid_2_zip              := '';
		SELF.parent_subsid_2_phone            := '';	
		
		// Contacts (10) 
		
		SELF.executive_1_name         := UCase(r.name_1);
		SELF.executive_1_title        := UCase(r.title_1);
		
		SELF.executive_2_name         := UCase(r.name_2);
		SELF.executive_2_title        := UCase(r.title_2);
                                 
		SELF.executive_3_name         := UCase(r.name_3);
		SELF.executive_3_title        := UCase(r.title_3);
                                 
		SELF.executive_4_name         := UCase(r.name_4);
		SELF.executive_4_title        := UCase(r.title_4);
                                 
		SELF.executive_5_name         := UCase(r.name_5);
		SELF.executive_5_title        := UCase(r.title_5);
                                 
		SELF.executive_6_name         := UCase(r.name_6);
		SELF.executive_6_title        := UCase(r.title_6);
                                 
		SELF.executive_7_name         := UCase(r.name_7);
		SELF.executive_7_title        := UCase(r.title_7);
                                 
		SELF.executive_8_name         := UCase(r.name_8);
		SELF.executive_8_title        := UCase(r.title_8);
                                 
		SELF.executive_9_name         := UCase(r.name_9);
		SELF.executive_9_title        := UCase(r.title_9);
                                 
		SELF.executive_10_name        := UCase(r.name_10);
		SELF.executive_10_title       := UCase(r.title_10);										
                                     
		// Secondary SICs (4)
		
		SELF.secondary_sic_1_cd       := r.Sic2;
		SELF.secondary_sic_1_desc     := UCase(r.Text2);
		SELF.secondary_sic_2_cd       := r.Sic3;
		SELF.secondary_sic_2_desc     := UCase(r.Text3);	
		SELF.secondary_sic_3_cd       := r.Sic4;
		SELF.secondary_sic_3_desc     := UCase(r.Text4);	
		SELF.secondary_sic_4_cd       := r.Sic5;
		SELF.secondary_sic_4_desc     := UCase(r.Text5);		
		                              
		SELF                          := r;
		                                
	END;