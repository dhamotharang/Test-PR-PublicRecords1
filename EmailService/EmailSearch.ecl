import AutoStandardI, doxie;

export EmailSearch := module

	export params := interface(EmailSearchService_IDs.params,AutoStandardI.LIBIN.PenaltyI_Indv.base)
		export unsigned2 penaltThreshold;
		export boolean useGlobalScope;
		export boolean mult_results := false;
	end;
	
	export Search(params in_mod) := function

		email_ids		:= EmailSearchService_IDs.val(in_mod).by_email_val;
		ids			:= EmailSearchService_IDs.val(in_mod).ids;
		// by_email_key	:= if(in_mod.email<>'@',TRUE,EmailSearchService_IDs.val(in_mod).by_email_key);
		by_email_key	:= if(in_mod.email<>'@',TRUE,FALSE);
		
		
		//*** these inputs will be used to create instance of interface that is passed to
		//*** penalty function in EmailSearchService_Records
		mac_input() := macro
			self.seq										:= 1;
			self.addr										:= in_mod.addr;
			self.agehigh								:= in_mod.agehigh;
			self.agelow									:= in_mod.agelow;
			self.asisname								:= in_mod.asisname;
			self.city										:= in_mod.city;
			self.county									:= in_mod.county;
			self.input_did							:= in_mod.did;
			self.dob										:= in_mod.dob;
			self.firstname							:= in_mod.firstname;
			self.fname3									:= in_mod.fname3;
			self.isfcraval							:= in_mod.isfcraval;
			self.isprp									:= in_mod.isprp;
			self.lastname								:= in_mod.lastname;
			self.lfmname								:= in_mod.lfmname;
			self.lname									:= in_mod.lname;
			self.lname4									:= in_mod.lname4;
			self.lnbranded							:= in_mod.lnbranded;
			self.middlename							:= in_mod.middlename;
			self.nameasis								:= in_mod.nameasis;
			self.nonexclusion						:= in_mod.nonexclusion;
			self.phone									:= in_mod.phone;
			self.phoneticdistancematch	:= in_mod.phoneticdistancematch;
			self.phoneticmatch					:= in_mod.phoneticmatch;
			self.postdir								:= in_mod.postdir;
			self.predir									:= in_mod.predir;
			self.prim_name							:= in_mod.prim_name;
			self.prim_range							:= in_mod.prim_range;
			self.primname								:= in_mod.primname;
			self.primrange							:= in_mod.primrange;
			self.scorethreshold					:= in_mod.scorethreshold;
			self.ssn										:= in_mod.ssn;
			self.st											:= in_mod.st;
			self.st_orig								:= in_mod.st_orig;
			self.state									:= in_mod.state;
			self.statecityzip						:= in_mod.statecityzip;
			self.street_name						:= in_mod.street_name;
			self.suffix									:= in_mod.suffix;
			self.unparsedfullname				:= in_mod.unparsedfullname;
			self.z5											:= in_mod.z5;
			self.zip										:= in_mod.zip;
			self.zipradius							:= in_mod.zipradius;
			self.ssn_mask_value					:= in_mod.ssnmask;
			self.penalt_threshold				:= in_mod.PenaltThreshold;
			self.useGlobalScope         := in_mod.useGlobalScope;
		endmacro;

		Assorted_Layouts.did_w_input get_input(ids l) :=transform
			mac_input()
			self := l;
			self :=[];
		end;
		
		
		
		Assorted_Layouts.did_w_input get_input_E(email_ids l) :=transform
			mac_input()
			self := l;
			self :=[];
		end;		
		//*** Create dataset to pass into EmailSearchService_Records
		ids_w_inputs_ids := group(project(ids,get_input(left)),seq,did);
		ids_w_inputs_email := group(project(email_ids,get_input_E(left)),seq,did);
		ids_w_inputs := if(by_email_key,ids_w_inputs_email,ids_w_inputs_ids);

		// retrieve results
		tempresults := Email_Raw.get_email_search(ids_w_inputs,by_email_key,in_mod.mult_results,in_mod.applicationtype);
				
		// debugging
		// output(in_mod.email);
		// output(in_mod.email<>'@');
		// output(by_email_key,			named('by_email_key'));
		// output(ids, 							named('ids'));
		// output(ids_w_inputs_ids,			named('ids_w_inputs_ids'));
		// output(email_ids[1].did<>0,			named('email_ids1_did'));
		// output(ids_w_inputs_email,			named('ids_w_inputs_email'));
		// output(ids_w_inputs,			named('ids_w_inputs'));
		// output(tempresults, 			named('tempresults'));
		
		return tempresults;
 
  end;

end;