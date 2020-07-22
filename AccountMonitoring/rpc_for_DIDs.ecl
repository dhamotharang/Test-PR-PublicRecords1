
IMPORT Didville, did_add;

EXPORT rpc_for_Dids( DATASET(layouts.DIDMetaRec) batch_in ) :=
	FUNCTION

		UCase := StringLib.StringToUpperCase;
		
		DidVille.Layout_Did_InBatch xfm_to_inbatch(layouts.DIDMetaRec l) :=
			TRANSFORM
				SELF.seq         := l.seq;
				SELF.ssn         := (qSTRING9) UCase(l.ssn);
				SELF.dob         := (qSTRING8) UCase(l.dob);
				SELF.phone10     := (qstring10)UCase(l.phone10);
				SELF.title       := (qSTRING5) '';
				SELF.fname       := (qSTRING20)UCase(l.fname);
				SELF.mname       := (qSTRING20)UCase(l.mname);
				SELF.lname       := (qSTRING20)UCase(l.lname);
				SELF.suffix      := (qSTRING5) UCase(l.suffix);
				SELF.prim_range  := (qSTRING10)UCase(l.prim_range);
				SELF.predir      := (qSTRING2) UCase(l.predir);
				SELF.prim_name   := (qSTRING28)UCase(l.prim_name);
				SELF.addr_suffix := (qSTRING4) UCase(l.addr_suffix);
				SELF.postdir     := (qSTRING2) UCase(l.postdir);
				SELF.unit_desig  := (qSTRING10)UCase(l.unit_desig);
				SELF.sec_range   := (qSTRING8) UCase(l.sec_range);
				SELF.p_city_name := (qSTRING25)UCase(l.p_city_name);
				SELF.st          := (qSTRING2) UCase(l.st);
				SELF.z5          := (qSTRING5) UCase(l.z5);
				SELF.zip4        := (qSTRING4) UCase(l.zip4);
			END;
			
		f_in     := PROJECT( batch_in, xfm_to_inbatch(LEFT) );

		in_batch := record
	   DidVille.Layout_Did_InBatch;
		  integer8	did;
	 end;
	 
	 out_batch := record
	   DidVille.Layout_Did_OutBatch;
	 end;
	 
	 /*
   matchset   -
      'A' = Address
      'D' = DOB
      'Z' = zip code matching
      'G' = age matching
					 '4' = ssn4 matching (last 4 digits of ssn)
  */
	 
	 matchset :=['A', 'D', 'Z', 'G', '4'];
	 
	 did_Add.Mac_Match_Flex_V2(
	                            f_in,				        //	infile
	                            matchset,					   //	matchset
	                            ssn,							      //	ssn_field
	                            dob,								     //	dob_field
	                            fname,						     //	fname_field
	                            mname,						     //	mname_field
	                            lname,						     //	lname_field
	                            suffix,			       //	suffix_field
	                            prim_range,				  //	prange_field
	                            prim_name,				   //	pname_field
	                            sec_range,				   //	srange_field
	                            z5,							       //	zip_field
	                            st,								      //	state_field
	                            phone10,						   //	phone_field
	                            did,					        //	DID_field
	                            out_batch,					  //	outrec
	                            FALSE,						     //	bool_outrec_has_score
	                            did_score_field,	//	DID_Score_field
	                            75,								      //	low_score_threshold
	                            f_out,			        //	outfile
	                            FALSE,							    //	bool_infile_has_name_source
	                            ,							         //	src_field
	                            ,									       //	bool_outrec_has_indiv_scores
	                            ,									       //	score_n_field
	                            ,									       //	bool_clean_addr
	                            ,									       //	predir_field
	                            ,									       //	addr_suffix_field
	                            ,									       //	postdir_field
	                            ,									       //	udesig_field
	                            p_city_name,					//	city_field
	                            ,									       //	zip4_field
	                            FALSE,							    //	bool_switch_priority
	                            ,									       //	weight_threshold
	                            ,									       //	distance
	                            FALSE							     //	segmentation
  );
		
		f_out_slim := PROJECT( f_out, {DidVille.Layout_Did_OutBatch.seq, DidVille.Layout_Did_OutBatch.did} );
		best_out_slim := DISTRIBUTE(f_out_slim, seq);

		RETURN best_out_slim; // layout is UNSIGNED4 + UNSIGNED6
	END;

