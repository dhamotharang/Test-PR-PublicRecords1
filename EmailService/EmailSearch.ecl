import AutoStandardI, doxie, EmailService;

export EmailSearch := module

  export params := interface(EmailService.EmailSearchService_IDs.params,AutoStandardI.LIBIN.PenaltyI_Indv.base)
    export unsigned2 penaltThreshold;
    export boolean useGlobalScope;
    export boolean mult_results := false;
    export string SearchType := '';
  end;
  
  IdentifySearchType (Params in_mod) := map(
                       EmailService.Constants.SearchType.isValid(in_mod.SearchType) => in_mod.SearchType,
                       in_mod.email <> EmailService.Constants.NULL_EMAIL => EmailService.Constants.SearchType.EIA, //email identity append
                       EmailService.Constants.SearchType.EAA);  // email address append

  export Search(params in_mod) := function

    email_ids  := EmailService.EmailSearchService_IDs.val(in_mod).by_email_val;
    ids      := EmailService.EmailSearchService_IDs.val(in_mod).ids;
    
    by_email_key := in_mod.email <> EmailService.Constants.NULL_EMAIL;
    
    
    //*** these inputs will be used to create instance of interface that is passed to
    //*** penalty function in EmailSearchService_Records
    EmailService.Assorted_Layouts.did_w_input get_input(EmailService.Assorted_Layouts.did_w_deepdive l) :=transform
      self.seq                    := 1;
      self.addr                    := in_mod.addr;
      self.agehigh                := in_mod.agehigh;
      self.agelow                  := in_mod.agelow;
      self.asisname                := in_mod.asisname;
      self.city                    := in_mod.city;
      self.county                  := in_mod.county;
      self.input_did              := in_mod.did;
      self.dob                    := in_mod.dob;
      self.firstname              := in_mod.firstname;
      self.fname3                  := in_mod.fname3;
      self.isfcraval              := in_mod.isfcraval;
      self.isprp                  := in_mod.isprp;
      self.lastname                := in_mod.lastname;
      self.lfmname                := in_mod.lfmname;
      self.lname                  := in_mod.lname;
      self.lname4                  := in_mod.lname4;
      self.lnbranded              := in_mod.lnbranded;
      self.middlename              := in_mod.middlename;
      self.nameasis                := in_mod.nameasis;
      self.nonexclusion            := in_mod.nonexclusion;
      self.phone                  := in_mod.phone;
      self.phoneticdistancematch  := in_mod.phoneticdistancematch;
      self.phoneticmatch          := in_mod.phoneticmatch;
      self.postdir                := in_mod.postdir;
      self.predir                  := in_mod.predir;
      self.prim_name              := in_mod.prim_name;
      self.prim_range              := in_mod.prim_range;
      self.primname                := in_mod.primname;
      self.primrange              := in_mod.primrange;
      self.scorethreshold          := in_mod.scorethreshold;
      self.ssn                    := in_mod.ssn;
      self.st                      := in_mod.st;
      self.st_orig                := in_mod.st_orig;
      self.state                  := in_mod.state;
      self.statecityzip            := in_mod.statecityzip;
      self.street_name            := in_mod.street_name;
      self.suffix                  := in_mod.suffix;
      self.unparsedfullname        := in_mod.unparsedfullname;
      self.z5                      := in_mod.z5;
      self.zip                    := in_mod.zip;
      self.zipradius              := in_mod.zipradius;
      self.ssn_mask_value          := in_mod.ssnmask;
      self.penalt_threshold        := in_mod.PenaltThreshold;
      self.useGlobalScope         := in_mod.useGlobalScope;
      self := l;
      self :=[];
    end;
    
    // Create dataset to pass into EmailSearchService_Records
    ids_w_inputs_ids := group(project(ids,get_input(left)),seq,did);
    ids_w_inputs_email := group(project(email_ids,get_input(left)),seq,did);
    ids_w_inputs := if(by_email_key,ids_w_inputs_email,ids_w_inputs_ids);

    // identify type of search needed - EIA, EAA or EIC
    search_type := IdentifySearchType(in_mod);  
    isEICsearch := EmailService.Constants.SearchType.isEIC(search_type);
     
    // retrieve results
    search_results := EmailService.Email_Raw.get_email_search(ids_w_inputs,search_type,in_mod.mult_results,in_mod.applicationtype);

    subject_lexid := if(isEICsearch and (unsigned)in_mod.did=0, EmailService.Functions.Get_Dids()[1].did, (unsigned)in_mod.did);

    res_with_relationship := EmailService.Functions.AddEmailRelationshipInfo (search_results, in_mod.email, subject_lexid);  

    recs_out := if(isEICsearch, res_with_relationship, search_results);
        
    // debugging
    // output(in_mod.email);
    // output(in_mod.email<>'@');
    // output(by_email_key,      named('by_email_key'));
    // output(ids,               named('ids'));
    // output(ids_w_inputs_ids,      named('ids_w_inputs_ids'));
    // output(email_ids[1].did<>0,      named('email_ids1_did'));
    // output(ids_w_inputs_email,      named('ids_w_inputs_email'));
    // output(ids_w_inputs,      named('ids_w_inputs'));
    // output(search_results,       named('search_results'));
    // output(subject_lexid,       named('subject_lexid'));
    
    return recs_out;
 
  end;

end;