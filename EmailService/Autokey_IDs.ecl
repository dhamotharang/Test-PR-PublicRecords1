import AutoKeyB2,AutoKeyI,Email_Data;

export AutoKey_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard := true;
		export boolean noFail := false;
		export string120 email;
	end;
	
	export val(params in_mod) := MODULE
		shared ak_keyname := Email_Data.Constants('').ak_qa_keyname;
		shared ak_typestr := Email_Data.Constants('').ak_typeStr;
		shared ak_dataset := Email_Data.Constants('').ak_dataset;
		shared ak_skipset := Email_Data.Constants('').ak_skipSet;

		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := ak_keyname;
			export string typestr := ak_typeStr;
			export set of string1 get_skip_set := ak_skipset;
			export boolean useAllLookups := true;
		end;
		shared idsI := dedup(sort(AutoKeyI.AutoKeyStandardFetch(tempmod).ids,id),id);
		
		//*** The dids from the autokeys will be real if did exists and fake if did does not exist
		shared ids_did	:= project(idsI,transform(EmailService.Assorted_Layouts.did_w_deepdive,
			self.isdeepdive := FALSE, self.did:=left.id));
		
		//*** Payload join will get back only records with no did because the payload key was built from
		//*** only no did records
		
		AutokeyB2.mac_get_payload(idsI, ak_keyname, ak_dataset, outpl, did, 0, ak_typeStr)		
		ids_no_did := project(outpl,EmailService.Assorted_Layouts.did_w_deepdive);
		
		dup_did :=dedup(ids_did + ids_no_did,did);
		
		// Added to assist in debugging
		//output(ids_did,named('esakids_ids_did'));
		//output(ids_no_did,named('esakids_ids_no_did'));
		//output(dup_did,named('esakids_dup_did'));
		
    export ids := dup_did;
	
	end;
end;