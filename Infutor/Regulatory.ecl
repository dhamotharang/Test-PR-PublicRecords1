
EXPORT Regulatory := module

		// copied from infutor.infutor_layout_main.layout_base_tracker
		export infutor_supplement_layout := record 		
		
				string3  	orig_name_prefix;		
				string15 	orig_first_name;		
				string15 	orig_middle_name;		
				string25 	orig_last_name;		
				string3  	orig_name_suffix;		
				string9  	ssn ; 		
				string10 	phone;		
				string8  	orig_filing_dt;		
				string8  	last_activity_dt;		
				string8  	orig_dob_dd_appended ; 		
				string1  	orig_gender;		
				string32 	alias1;		
				string32 	alias2;		
				string32 	alias3;		
					
				string40 	orig_addr_street_blob;		
				string10 	orig_house_number;		
				string2  	orig_predir;		
				string28 	orig_street_name;		
				string4  	orig_street_suffix;		
				string2  	orig_postdir;		
				string8  	orig_apt_no;		
				string27 	orig_city;		
				string2  	orig_st;		
				string5  	orig_zip;		
				string4  	orig_zip4;		
				string4  	orig_crrt;		
				string6  	effective_dt;		
					
				string88  prev1_addr;		
				string6   prev1_addr_effective_dt;		
				string88  prev2_addr;		
				string6   prev2_addr_effective_dt;		
				string88  prev3_addr;		
				string6   prev3_addr_effective_dt;		
				string88  prev4_addr;		
				string6   prev4_addr_effective_dt;		
				string88  prev5_addr;		
				string6   prev5_addr_effective_dt;		
					
				string5   title;		
				string20  fname;		
				string20  mname;		
				string20  lname;		
				string5   name_suffix;		
				string3   name_score;		
				string2   name_type ; 		
				string10  prim_range;		
				string2   predir;		
				string28  prim_name;		
				string4   addr_suffix;		
				string2   postdir;		
				string10  unit_desig;		
				string8   sec_range;		
				string25  p_city_name;		
				string25  v_city_name;		
				string2   st;		
				string5   zip;		
				string4   zip4;		
				string4   cart;		
				string1   cr_sort_sz;		
				string4   lot;		
				string1   lot_order;		
				string2   dbpc;		
				string1   chk_digit;		
				string2   rec_type;		
				string5   county;		
				string10  geo_lat;		
				string11  geo_long;		
				string4   msa;		
				string7   geo_blk;		
				string1   geo_match;		
				string4   err_stat;		
				string2   addr_type ; 		
					
				string1  	dwelling_type;		
				string3  	fips_county;		
				string1   ncoa_cd;		
				string6   ncoa_dt;		
				string10  unique_id;		
				string1   record_type;		
				unsigned6 boca_id;		
				string1   which_ssn;		
				unsigned6 did:=0;		
				string9   append_ssn := ''; 		
				unsigned8 RawAID:=0;		
		end;		

							
		export Supplement_InfutorS(ds) := 
				functionmacro		
						import Suppress;
						
						Infut_Hash1(recordof(ds) L) := hashmd5(intformat(l.did,15,1));				
						Infut_Hash2(recordof(ds) L) := hashmd5(trim(l.ssn, left, right));
						Infut_Hash3(recordof(ds) L) := hashmd5(intformat(l.did,15,1), trim(l.ssn, left, right));

						return Suppress.applyRegulatory.complex_sup_trio(ds, 'ridinfutor_sup.txt', Infut_Hash1, Infut_Hash2, Infut_Hash3);

				endmacro; // Supplement_InfutorS							


		export Supplement_InfutorI() := 
				functionmacro		
						import Suppress;

						return Suppress.applyRegulatory.getFile('file_infutor_inj.txt', infutor.regulatory.infutor_supplement_layout); 

				endmacro; // Supplement_InfutorI	

		
		export Reflection(ds_base) :=
				functionmacro
				
						ff_base := Infutor.regulatory.Supplement_InfutorS(ds_base);

						Bfile_in := Infutor.regulatory.Supplement_InfutorI();
	
						UNSIGNED6 endMax := MAX(ds_base, boca_id);
	
						layout_tmp :=record
								Bfile_in ;
								string25 city ;
								string4 state ;
						end ;
	
						layout_tmp reformated_base(Bfile_in L, INTEGER c) := transform	 
								self.boca_id := endMax + c ;
								self.city := if (L.p_city_name <> '', L.p_city_name, '');
								self.state := L.st ;
								self := L ;
						end ;

						base_reformated := project(Bfile_in, reformated_base(LEFT, counter) ); 
	
						business_header.macGetCleanAddr(base_reformated,   
											 prim_range, predir, prim_name, addr_suffix, postdir, unit_desig,  
											 sec_range, p_city_name, state, zip, zip4, RawAID,  
										   'false', 'false', Base_out);  
	
						base_file_out := distribute(Table(Base_out, {Base_out} - {state, city}), hash(did));   
											 
				return ff_base + base_file_out;

		endmacro; // Reflection						
		
		
		export Reflection_Header(ds_base) :=
				functionmacro
				
						ff_base := Infutor.Regulatory.Supplement_InfutorS(ds_Xform);
						
						Bfile_in := Infutor.Regulatory.Supplement_InfutorI();
						
						UNSIGNED6 endMax := MAX(ds_Xform(intformat(rid, 14, 0)[1..2] = '15' and length(trim(intformat(rid, 14, 0))) = 14), rid);
						
						loadfile:=nothor(STD.File.SUPERFILECONTENTS(infutor.filename_infutor));   

						SearchPattern:='thor_dell400::in::infutor::([^ ]*)::';
						cversion_dev:=regexfind(SearchPattern,loadfile[1].name,1); 

						header.layout_header reformat(infutor.infutor_layout_main.layout_base_tracker l, integer c) := transform

	/* //check date validity by length, number values, and between 1901 and today */  
 
						Valid_Date_Range(string in_date) := in_date[1..6] between '190101' and ut.GetDate[1..6];
								self.did := l.did;
								self.rid := endMax + c;
								self.src := 'IF';
								self.dt_last_seen := map(l.addr_type='O' => max((unsigned)l.last_activity_dt[1..6],(unsigned)l.effective_dt[1..6]), 
													 stringlib.stringtouppercase(l.addr_type) = 'P1' => (unsigned)l.prev1_addr_effective_dt[1..6],
													 stringlib.stringtouppercase(l.addr_type) = 'P2' => (unsigned)l.prev2_addr_effective_dt[1..6],
													 stringlib.stringtouppercase(l.addr_type) = 'P3' => (unsigned)l.prev3_addr_effective_dt[1..6],
													 stringlib.stringtouppercase(l.addr_type) = 'P4' => (unsigned)l.prev4_addr_effective_dt[1..6],
													 stringlib.stringtouppercase(l.addr_type) = 'P5' => (unsigned)l.prev5_addr_effective_dt[1..6],
													 0);
								self.dt_first_seen := map(l.addr_type='O' => (unsigned)l.effective_dt[1..6], self.dt_last_seen);
								self.dt_vendor_last_reported := (unsigned)cversion_dev[1..6];
								self.dt_vendor_first_reported := (unsigned)cversion_dev[1..6];
								self.dt_nonglb_last_seen := 0;
								self.vendor_id := (qstring18)l.boca_id;
								self.dob := (integer4)l.orig_dob_dd_appended;
								self.suffix := l.addr_suffix;
								self.city_name := l.v_city_name; // changed from p to v as v is used in other examples and is completely spelled out
								self.rec_type := '';
								self.county := l.county[3..];
								self := l;
						end;

						base_reformated := distribute(project(Bfile_in, reformat(left, counter)), hash(did));
						
						header.macGetCleanAddr(base_reformated , RawAID , 'true' , base_file_out) ;
																		 										 
				return ff_base + base_file_out;

		endmacro; // Reflection_header		
		
end;
