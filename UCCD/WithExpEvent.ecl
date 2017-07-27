import ut,ucc, codes;
//incoming experian determined by set of exp states
expin := ucc.File_UCC_Filing_Events;
expin_filtered := expin(file_state not in uccd.set_DirectStates);

exp_filed_place_in := ucc.File_UCC_Filing_Place;
//expanded layout
rec := uccd.Layout_WithExpEvent;

//project exp into exanded layout
rec formatexp(expin_filtered l,exp_filed_place_in r) := transform
	self.ucc_vendor 		:= ut.st2FipsCode(l.file_state);
	self.ucc_process_date 	:= '';//new
	self.processing_rule 	:= '';//new
	self.ucc_key 			:= uccd.constructUCCkey(l.file_state, l.orig_filing_num);
	self.event_key 			:= if (l.filing_type='0801', uccd.constructUCCkey(l.file_state, l.orig_filing_num),l.filing_type+'-'+l.filing_date);
	self.event_action_cd 	:= '';//new
	self.event_action_desc 	:= '';//new
	self.filing_type_desc 	:= codes.UCC_FILING.FILING_TYPE((string)l.filing_type);
	self.filed_place_desc  	:= r.orig_court_name;
	self.isDirect 			:= false;
	self.record_type 		:= 'C';
	self :=l;
end;

expfor := join(expin_filtered ,exp_filed_place_in, left.filed_place=right.filing_place_id, formatexp(left,right), lookup );
//output(expfor);


//incoming direct
dirin := uccd.File_Event_Base;

// direct into expanded layout
rec formatdir(dirin l) := transform
	self.file_state 		:= l.ucc_state_origin;
	//self.rec_code 		:= '';    //not mapped
	self.contrib_num1 		:= '';
	//self.contrib_num2 	:= '';	//not mapped
	//self.contrib_num3 	:= '';	//not mapped
	//self.value_2900 		:= '';  //not mapped
	self.orig_filing_num 	:= l.ucc_filing_num;
	//self.experian_rec_type := '';	//not mapped
	
	self.filing_type 		:= if (l.ucc_state_origin='AL',l.event_action_cd, l.event_type_cd);
	self.filing_type_desc 	:= if (l.ucc_state_origin='AL',l.event_action_desc, l.event_type_desc);
	
	self.event_action_cd	:= if (l.ucc_state_origin='AL', '', l.event_action_cd);
	self.event_action_desc	:= if (l.ucc_state_origin='AL', '', l.event_action_desc);

	self.document_num 		:= l.event_document_num;
	self.filing_date 		:= l.event_date;
	self.orig_filing_date 	:= l.ucc_filing_date;
	//self.collateral_code 	:= ''; 	//not mapped
	//self.fk_debtor_orig_st := '';	//not mapped	
	//self.fk_filing_seq_num := '';	//not mapped	
	
	self.filed_place 		:= l.event_place_id;
	self.filed_place_desc  	:= l.event_place_desc;

	//self.debtor_change 	:= ''; 	//not mapped
	//self.secured_change 	:= '';	//not mapped


	self.isDirect 			:= true;

	self := l;
end;

dirfor := project(dirin, formatdir(left));
//output(dirfor);

export WithExpEvent := expfor + dirfor : independent;

