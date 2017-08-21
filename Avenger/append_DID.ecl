import avenger, DID_add;
#option('multiplePersistInstances',FALSE);
//append DID
infile := Avenger.fn_mapping_assertion(avenger.file_in.assertion);

temp_rec := record

avenger.layout_in.assertion_clean_rec;

string input_prim_range;
string input_prim_name;
string input_sec_range;
string input_st;
string input_zip5;
unsigned6 input_did;
string billto_prim_range;
string billto_prim_name;
string billto_sec_range;
string billto_st;
string billto_zip;
unsigned6 billto_did;

end;
					
pTrim_Base_File := project(infile, transform(temp_rec,
						self.input_prim_range := left.input_clean.prim_range,
						self.input_prim_name := left.input_clean.prim_name,
						self.input_sec_range := left.input_clean.sec_range,
						self.input_st := left.input_clean.st,
						self.input_zip5 := left.input_clean.zip,
						self.input_did := left.input_clean.DID,
						self.billto_prim_range := left.billto_clean.prim_range,
						self.billto_prim_name := left.billto_clean.prim_name,
						self.billto_sec_range := left.billto_clean.sec_range,
						self.billto_st := left.billto_clean.st,
						self.billto_zip := left.billto_clean.zip,
						self.billto_did := left.billto_clean.DID,
						self := left));

	matchset_input := ['A','D','S','P','Z'];

	did_Add.MAC_Match_Flex(pTrim_Base_File, matchset_input,
												 Asser_Input_SSN, Asser_Input_DOB, Asser_Input_Name_First, asser_input_mname, Asser_Input_Name_last, asser_input_namesuffix, 
												 input_prim_range, input_prim_name, input_sec_range, input_zip5,
												 input_st, Asser_Input_Phone,
												 input_did,
												 temp_rec,
												 false, did_score_field,	//these should default to zero in definition
												 75,	  //dids with a score below here will be dropped 	
												 postDID_input);
												 
					matchset_billto := ['A','P','Z'];
								 
		did_Add.MAC_Match_Flex(postDID_input, matchset_billto,
												 '','', Asser_billto_Name_First, Asser_billto_mname, Asser_billto_Name_last, asser_billto_namesuffix, 
												 billto_prim_range, billto_prim_name, billto_sec_range, billto_zip,
												 billto_st, Asser_billto_Phone,
												 billto_did,
												 temp_rec,
												 false, did_score_field,	//these should default to zero in definition
												 75,	  //dids with a score below here will be dropped 	
												 postDID_billto);
												 										 
	did_ed := project(postDID_billto,transform(avenger.layout_common, 
	self.asser_input_lexid := intformat(left.input_did,12,1),self.asser_billto_lexid := intformat(left.billto_did,12,1),self := left));
											 
export	append_DID := did_ed : persist('~thor_data400::persist::avenger_assertion_DID');


