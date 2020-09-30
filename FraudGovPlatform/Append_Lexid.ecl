EXPORT Append_Lexid( pBaseFile ) := 
FUNCTIONMACRO
		import FraudShared,DID_Add,_Validate, Std;
		FirstRinID := FraudGovPlatform.Constants().FirstRinID;

		dFileBase 		:= distribute	(pull(pBaseFile),record_id	);
		
		with_rawlinkid := dFileBase(rawlinkid > 0);

		with_lexid := project(with_rawlinkid, transform( FraudShared.Layouts.Base.Main , self.did := left.rawlinkid, self:=left));

		without_rawlinkid := dFileBase(rawlinkid = 0);

		with_pii := without_rawlinkid
		(   
			(cleaned_name.fname !='' and cleaned_name.lname !='' and 
				(length(STD.Str.CleanSpaces(clean_ssn))=9 and regexfind('^[0-9]*$',STD.Str.CleanSpaces(clean_ssn)) =true ))
			or
			(cleaned_name.fname !='' and cleaned_name.lname !='' and  
				_Validate.Date.fIsValid(clean_dob) and (unsigned)clean_dob <= (unsigned)(STRING8)Std.Date.Today() and	clean_dob != '' and clean_dob != '00000000' and 
				( clean_phones.phone_number <> '' or clean_phones.cell_phone <> '' ) ) 
			or
			(
				(cleaned_name.fname !='' and cleaned_name.lname !='' and
					clean_address.prim_range != '' and clean_address.prim_name != '') and 
					(
						(clean_address.v_city_name != '' and clean_address.st != '')
						or
						(clean_address.zip != '')
					)
			)
		);

		without_pii 
		:= join(
				dFileBase,
				with_pii,
				left.record_id = right.record_id,
				only left,
				local
		);

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		FraudGovPlatform.Layouts.Temp.DidSlim tSlimForDiding(pBaseFile l, unsigned2 cnt) :=
		TRANSFORM
			SELF.fname				:= l.cleaned_name.fname;
			SELF.mname				:= l.cleaned_name.mname;
			SELF.lname				:= l.cleaned_name.lname;
			SELF.name_suffix	:= l.cleaned_name.name_suffix;
			SELF.prim_range		:= l.clean_address.prim_range;
			SELF.prim_name		:= l.clean_address.prim_name;
			SELF.sec_range		:= l.clean_address.sec_range;
			SELF.zip5		 			:= l.clean_address.zip;
			SELF.state				:= l.clean_address.st;
			SELF.phone				:= choose(cnt,l.clean_phones.phone_number,l.clean_phones.cell_phone);
			SELF.ssn					:= l.clean_ssn;
			SELF.dob					:= l.clean_dob;
			SELF.did					:= 0;
			SELF.did_score		:= 0;
			SELF		 	    		:= l;
		END;
			
		dSlimForDiding	:= normalize(with_pii
			,if(left.clean_phones.phone_number <>'' and left.clean_phones.cell_phone <> '',2,1)
			,tSlimForDiding(left,counter)
		);
																
		// Match to Headers by Contact Name and Address and phone
		Did_Matchset := ['D','S','P','A'];

		DID_Add.MAC_Match_Flex(
			 dSlimForDiding								// Input Dataset
			,Did_Matchset									// Did_Matchset  what fields to match on
			,ssn													// ssn
			,dob													// dob
			,fname												// fname
			,mname												// mname
			,lname												// lname
			,name_suffix									// name_suffix
			,prim_range										// prim_range
			,prim_name										// prim_name
			,sec_range	    					    // sec_range
			,zip5													// zip5
			,state												// state
			,phone												// phone10
			,did                      		// Did
			,FraudGovPlatform.Layouts.Temp.DidSlim	// output layout
			,TRUE                     		// Does output record have the score
			,did_score										// did score field
			,75														// score threshold
			,dDidOut											// output dataset			
		);                          


		dDidOut_dist			:= distribute	(dDidOut(did <> 0),record_id );
		dDidOut_sort			:= sort				(dDidOut_dist,record_id, -did_score	,local);
		dDidOut_dedup			:= dedup			(dDidOut_sort,record_id ,local);
		
		dAssignDids := join( with_pii
												,dDidOut_dedup
												,left.record_id = RIGHT.record_id
												,Transform(recordof(left)
												,self.did := if(right.did<>0,right.did,left.rawlinkid)
												,self.did_score := if(right.did_score<>0,right.did_score,if(left.rawlinkid >0 and left.rawlinkid <firstrinid,100,0)) 
												,self:=left)
												,left outer
												,local
											 );
											 
		RETURN with_lexid + without_pii + dAssignDids;
	
ENDMACRO;