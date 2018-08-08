EXPORT Mac_LexidAppend(DatasetIn,DatasetOut) := macro
IMPORT FraudDefenseNetwork, DID_Add;

  #uniquename(inData)
  %inData%               := DatasetIn;
	#uniquename(tAddUniqueId)
	#uniquename(dAddUniqueId)
  #uniquename(tempDidSlimLayout)
	%tempDidSlimLayout%     := FraudDefenseNetwork.Layouts.Temp.DidSlim	;
  #uniquename(tSlimForDiding)	
  #uniquename(dSlimForDiding)	
  #uniquename(tAssignDIDs)
  #uniquename(Did_Matchset)
  #uniquename(dAddUniqueId_dist)
  #uniquename(dDidOut)
  #uniquename(dDidOut_dist)
  #uniquename(dDidOut_sort)
  #uniquename(dDidOut_dedup)	
		
		//Populate unique id
		typeof(%inData%) %tAddUniqueId%(%inData% l, unsigned8 cnt) :=
		transform
 		  self.unique_id	:= cnt;
			self            := l;
		end;   
		
		%dAddUniqueId% := project(%inData%, %tAddUniqueId%(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		%tempDidSlimLayout% %tSlimForDiding%(recordof(%inData%) l, unsigned2 cnt) :=
		TRANSFORM
		
     SELF.fname         := l.cleaned_name.fname;
     SELF.mname         := l.cleaned_name.mname;
     SELF.lname         := l.cleaned_name.lname;
     SELF.name_suffix   := l.cleaned_name.name_suffix;
     SELF.prim_range    := l.clean_address.prim_range;
     SELF.prim_name     := l.clean_address.prim_name;
     SELF.sec_range     := l.clean_address.sec_range;
     SELF.zip5          := l.clean_address.zip;
     SELF.state         := l.clean_address.st;
     SELF.phone         := choose(cnt,l.clean_phones.phone_number,l.clean_phones.cell_phone);
     SELF.ssn           := l.ssn;
     SELF.dob           := l.dob;
     SELF.did           := 0;
     SELF.did_score     := 0;
     SELF               := l;
		END;
			
    %dSlimForDiding%    := normalize(%dAddUniqueId%
																,if(left.clean_phones.phone_number <>'' and left.clean_phones.cell_phone != '',2,1)
																,%tSlimForDiding%(left,counter)
																);
																
		// Match to Headers by Contact Name and Address and phone
		%Did_Matchset%      := ['D','S','P','A'];

		DID_Add.MAC_Match_Flex(
			 %dSlimForDiding%								// Input Dataset
			,%Did_Matchset%									// Did_Matchset  what fields to match on
			,ssn													// ssn
			,dob													// dob
			,fname												// fname
			,mname												// mname
			,lname												// lname
			,name_suffix										// name_suffix
			,prim_range										// prim_range
			,prim_name										// prim_name
			,sec_range	    					      	// sec_range
			,zip5												// zip5
			,state												// state
			,phone												// phone10
			,did                      				// Did
			,%tempDidSlimLayout%	// output layout
			,TRUE                     				// Does output record have the score
			,did_score										// did score field
			,75													// score threshold
			,%dDidOut%											// output dataset			
		);                          


		%dDidOut_dist%			:= distribute	(%dDidOut%(did != 0),unique_id );
		%dDidOut_sort%			:= sort				(%dDidOut_dist%,unique_id, -did_score	,local);
		%dDidOut_dedup% 		:= dedup			(%dDidOut_sort%,unique_id ,local);
		
		%dAddUniqueId_dist% := distribute	(%dAddUniqueId%,unique_id	);

 			 
		typeof(%inData%) %tAssignDIDs%(%inData% l, %tempDidSlimLayout% r) :=
		TRANSFORM

			SELF.did				  := if(r.did <> 0, r.did				, 0);
			SELF.did_score	:= if(r.did_score <> 0, r.did_score	, 0);
			SELF.Unique_id  := 0;
			SELF 						  := l;

		END;
 
		DatasetOut := join( %dAddUniqueId_dist%
												,%dDidOut_dedup%
												,left.unique_id = right.unique_id
												,%tAssignDIDs%(left, RIGHT)
												,left outer
												,local
											 );
ENDMACRO;