EXPORT Regulatory := MODULE
import Suppress ;

	EXPORT applyEmploymentSup(base_ds) := FUNCTIONMACRO
		import paw, Suppress;

		local supLayout := suppress.applyregulatory.layout_in;

		local sup_in1 := suppress.applyregulatory.getFile('employment_sup.txt', supLayout);
		local sup_in2 := suppress.applyregulatory.getFile('businesscontactsbytitle_sup.txt', supLayout);
		local sup_in3 := suppress.applyregulatory.getFile('employmentall_sup.txt', supLayout);
		local sup_In := sup_in1 + sup_in2 + sup_in3;

		local dSuppressedIn := project(sup_In, suppress.applyregulatory.in_to_out(left));

		return join(base_ds, dSuppressedIn
						, hashmd5(intformat((unsigned6)left.bdid,12,1), intformat((unsigned6)left.did,15,1)) = right.hval 
							OR hashmd5(intformat((unsigned6)left.bdid,12,1), left.company_title, left.lname, left.fname) = right.hval 
							OR hashmd5(intformat((unsigned6)left.bdid,12,1)) = right.hval
						, transform(recordof(base_ds), SELF := LEFT)
						, left only
						, ALL);

		
	ENDMACRO;
	
// linkIDs section is copied from BIPV2.IDlaouts 

l_xlink_ids :=  Suppress.Layout_regulatory.LZ_l_xlink_ids ;

	EXPORT 	base_layout := RECORD
	
				string15	contact_id;
				string15	did; 

				string15	bdid; 

				string9   ssn;
				string3		score;
				string120 company_name;      
				string10 	company_prim_range;
				string2   company_predir;
				string28 	company_prim_name;
				string4  	company_addr_suffix;
				string2   company_postdir;
				string5  	company_unit_desig;
				string8  	company_sec_range;
				string25 	company_city;
				string2   company_state;
				string5 	company_zip;
				string4 	company_zip4;
				string35 	company_title;
				string35 	company_department;
				string10 	company_phone;
				string9 	company_fein;
				string5  	title;
				string20 	fname;
				string20 	mname;
				string20 	lname;
				string5  	name_suffix;
				string10 	prim_range;
				string2   predir;
				string28 	prim_name;
				string4  	addr_suffix;
				string2   postdir;
				string5  	unit_desig;
				string8		sec_range;
				string25	city;
				string2		state;
				string5		zip;
				string4 	zip4;
				string3   county;
				string4   msa;
				string10 	geo_lat;
				string11 	geo_long;
				string10	phone;
				string60	email_address;
				string8	  dt_first_seen;
				string8	  dt_last_seen;
				string1   record_type;	
				string1   active_phone_flag;
				string1   GLB;
				string2   source;
				string2	  DPPA_State;
				string3   old_score;
				string15  source_count;
				string3   dead_flag:= '000';
				string10  company_status:=''; 
				
    l_xlink_ids	linkIDs  ;			 
		
				string2		eor;	
		end;


	EXPORT applyEmploymentInj(base_ds) := FUNCTIONMACRO
		import paw, Suppress;

		local Base_File_In := suppress.applyregulatory.getFile('file_business_employment_v2_inj.txt', paw.Regulatory.base_layout);

		recordof(base_ds) reformated_header(Base_File_In L) := 
			transform
				self.contact_id 		:=  hash64 (l.did,
																				l.company_name,
																				l.company_prim_range,
																				l.company_predir,
																				l.company_prim_name,
																				l.company_addr_suffix,
																				l.company_unit_desig,
																				l.company_sec_range,
																				l.company_city,
																				l.company_state,
																				l.company_zip,
																				l.company_title,
																				l.company_phone,
																				l.company_fein,
																				l.fname,
																				l.mname,
																				l.lname,
																				l.name_suffix,
																				l.prim_range,
																				l.predir,
																				l.prim_name,
																				l.addr_suffix,
																				l.unit_desig,
																				l.sec_range,
																				l.city,
																				l.state,
																				l.zip,
																				l.phone,
																				l.email_address,
																				l.source);
				self.bdid 					:= (unsigned6)l.bdid;
				self.did  					:= (unsigned6)l.did;
				self.old_score			:= L.old_score;
				self.source_count		:= 1;
				self.dead_flag 			:= (unsigned6)l.dead_flag;
				self.company_status := '';
				self	 							       := L;
				self                := [];
		end;

		File_To_Append				 := project(Base_File_In, reformated_header(left)); 
		
		File_To_Process_To_Key := base_ds + File_To_Append;
		return File_To_Process_To_Key ;

	ENDMACRO;

	EXPORT applyEmploymentInj_atEnd(base_ds) := FUNCTIONMACRO
		import paw, Suppress;

		local Base_File_In := suppress.applyregulatory.getFile('file_business_employment_v2_inj.txt', paw.Regulatory.base_layout);
	
		UNSIGNED6 endMax := MAX(paw.File_Base, contact_id);
		
		recordof(base_ds) reformated_header(Base_File_In L, INTEGER c) := 
		transform
				self.contact_id 		:= endMax + c;
				self.bdid 					:= (unsigned6)l.bdid;
				self.did  					:= (unsigned6)l.did;
				self.old_score			:= L.score;
				self.source_count		:= 1;
				self.dead_flag 			:= (unsigned6)l.dead_flag;
				self.company_status := '';
				self	 							:= L;
				self								:= [];
		end;

		File_To_Append				 := project(Base_File_In, reformated_header(left, COUNTER)); 

		File_To_Process_To_Key := base_ds + File_To_Append;
		return File_To_Process_To_Key ;

	ENDMACRO;

END;