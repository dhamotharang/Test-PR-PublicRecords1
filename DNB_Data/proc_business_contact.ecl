import business_header, address,watchdog;
export proc_business_contact :=
module

	BC := 	DATASET(business_header.Bus_Thor + 'base::dnb_data::firstphase::nj_and_ga::contacts', business_header.Layout_Business_Contact_Full, THOR);
	
	BC_nonproblematic := BC(source not in DNB_Data.SetExcludeSources and bdid != 0);

	pobox_regex := '^P[.]?O[.]? BOX';

	Layouts.out.business_contacts tConvert2OutputLayout(business_header.Layout_Business_Contact_Full l) :=
	transform
		is_pobox := regexfind(pobox_regex, l.prim_name, NOCASE) 
								or (l.prim_range = '' and l.zip4 != 0);

		is_pobox_company := regexfind(pobox_regex, l.company_prim_name, NOCASE) 
								or (l.company_prim_range = '' and l.company_zip4 != 0);

		address_line_1 := Address.Addr1FromComponents(
												 l.prim_range
												,l.predir
												,l.prim_name
												,l.addr_suffix
												,l.postdir
												,l.unit_desig
												,l.sec_range
											);
		Company_address_line_1 := Address.Addr1FromComponents(
												 l.company_prim_range
												,l.company_predir
												,l.company_prim_name
												,l.company_addr_suffix
												,l.company_postdir
												,l.company_unit_desig
												,l.company_sec_range
											);
		use_contact_address := if(address_line_1 != '', true, false);
		
		contact_address_same_as_business_address := if(address_line_1 = Company_address_line_1 
																							and l.zip = l.company_zip
																							and l.zip4 = l.company_zip4, 'Y', 'N');
																							
	
		self.bdid																			:= intformat(l.bdid, 12,1);
		self.did																			:= if(l.did != 0, intformat(l.did, 12,1), '');
		self.Contact_Name.title												:= l.title				;
		self.Contact_Name.fname												:= l.fname				;
		self.Contact_Name.mname												:= l.mname				;
		self.Contact_Name.lname												:= l.lname				;
		self.Contact_Name.name_suffix									:= l.name_suffix	;
		self.Contact_Name.name_score									:= l.name_score	;
		self.is_best_contact_name											:= '';
		self.company_title														:= l.company_title;
		self.phone																		:= if(l.phone != 0, (string10)l.phone, '');
		//if contact address is not blank, use it
		//otherwise use company address
		//
		self.address_line_1														:= map(address_line_1 != '' and is_pobox = false => address_line_1
																										 ,address_line_1 = '' and Company_address_line_1 != '' and is_pobox_company = false => Company_address_line_1,
																										 ''
																										 );
		self.mailing_address													:= map(address_line_1 != '' and is_pobox => address_line_1
																										 ,address_line_1 = '' and Company_address_line_1 != '' and is_pobox_company => Company_address_line_1,
																										 ''
																										 );
		self.city																			:= if(use_contact_address, l.city, l.company_city);
		self.state																		:= if(use_contact_address, l.state, l.company_state);
		self.zip																			:= if(use_contact_address, 
																												if(l.zip != 0, intformat(l.zip, 5, 1), ''),
																												if(l.company_zip != 0, intformat(l.company_zip, 5, 1), ''));
		self.zip4																			:= if(use_contact_address, 
																												if(l.zip4 != 0, intformat(l.zip4, 4, 1), ''),
																												if(l.company_zip4 != 0, intformat(l.company_zip4, 4, 1), ''));

		self.contact_address_same_as_business_address	:= contact_address_same_as_business_address;
		self.Dnb_record																:= if(l.source = 'D', 'Y', 'N');
	end;

	BC_outformat := project(BC_nonproblematic, tConvert2OutputLayout(left));
	
	//now match to watchdog non-glb best
	thebest := Watchdog.File_Best_nonglb;
	
	thebest_dist := distribute(thebest, did);
	
	bc_outformat_did_dist := distribute(BC_outformat, (unsigned6)did);
	
	Layouts.out.business_contacts tgetbestname(Layouts.out.business_contacts l, thebest_dist r) :=
	transform
		is_best := if(		
		              l.Contact_Name.fname	= r.fname and r.fname != ''	and		
		              l.Contact_Name.mname	= r.mname			and
		              l.Contact_Name.lname	= r.lname and r.lname != ''
									, true, false);			
		self.is_best_contact_name := if(is_best, 'Y', '');
		self := l;
	end;
	
	bc_output_best := join(bc_outformat_did_dist,
												thebest_dist,
												(unsigned6)left.did = right.did,
												tgetbestname(left,right)
												,local
												,left outer);
	
	
	export myoutput := 
		sequential(
			output(bc_output_best(mailing_address = ''),,thor_clusters.files + 'base::dnb_data::20061210::contacts::address', overwrite)
			,output(bc_output_best(mailing_address != ''),,thor_clusters.files + 'base::dnb_data::20061210::contacts::mailing_address', overwrite)
		);
			

end;