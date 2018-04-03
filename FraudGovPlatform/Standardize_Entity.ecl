EXPORT Standardize_Entity       := 
module

export Clean_Address(pInputFile, pversion ) := 
functionmacro		
		import address;
		prepped_Addresses := dedup(table(pInputFile(address_1 <> '' and address_2 <> ''),{address_1, address_2}) + 
																													table(pInputFile(mailing_address_1 <> '' and mailing_address_2 <> ''),{mailing_address_1,mailing_address_2}),all);
		
		Address_Cache := project( prepped_Addresses ,transform( FraudGovPlatform.Layouts.address_cleaner,
				Clean_Address_182 							:= if (left.address_2 != '', address.CleanAddress182(left.address_1, left.address_2), '');
				self.address_1									:= left.address_1;
				self.address_2									:= left.address_2;
				self.clean_address.prim_range			:= Clean_Address_182[1..10]					; //prim_range
				self.clean_address.predir				:= Clean_Address_182[11..12]				; //predir
				self.clean_address.prim_name			:= Clean_Address_182[13..40]				; //prim_name
				self.clean_address.addr_suffix		:= Clean_Address_182[41..44]				; //addr_suffix
				self.clean_address.postdir				:= Clean_Address_182[45..46]				; //postdir
				self.clean_address.unit_desig			:= Clean_Address_182[47..56]				; //unit_desig
				self.clean_address.sec_range			:= Clean_Address_182[57..64]				; //sec_range
				self.clean_address.p_city_name		:= Clean_Address_182[65..89]				; //p_city_name
				self.clean_address.v_city_name		:= Clean_Address_182[90..114]				; //v_city_name
				self.clean_address.st						:= Clean_Address_182[115..116]			; //st
				self.clean_address.zip						:= Clean_Address_182[117..121]			; //zip
				self.clean_address.zip4					:= Clean_Address_182[122..125]			; //zip4
				self.clean_address.cart					:= Clean_Address_182[126..129]			; //cart
				self.clean_address.cr_sort_sz			:= Clean_Address_182[130]						; //cr_sort_sz
				self.clean_address.lot						:= Clean_Address_182[131..134]			; //lot
				self.clean_address.lot_order			:= Clean_Address_182[135]						; //lot_order
				self.clean_address.dbpc					:= Clean_Address_182[136..137]			; //dpbc
				self.clean_address.chk_digit			:= Clean_Address_182[138]						; //chk_digit
				self.clean_address.rec_type				:= Clean_Address_182[139..140]			; //record_type
				self.clean_address.fips_state 		:= Clean_Address_182[141..142]			; //ace_fips_state
				self.clean_address.fips_county		:= Clean_Address_182[143..145]			; //county
				self.clean_address.geo_lat				:= Clean_Address_182[146..155]			; //geo_lat
				self.clean_address.geo_long				:= Clean_Address_182[156..166]			; //geo_long
				self.clean_address.msa						:= Clean_Address_182[167..170]			; //msa
				self.clean_address.geo_blk				:= Clean_Address_182[171..177]			; //geo_blk
				self.clean_address.geo_match			:= Clean_Address_182[178]						; //geo_match
				self.clean_address.err_stat				:= Clean_Address_182[179..182]			; //err_stat				
				self								             := left															;
			));

				// OUTPUT(Address_Cache,,FraudGovPlatform.Filenames().Address_Cache + '_' + pversion, compressed, overwrite);
				
				
		  pInputFile addCleanAddress(pInputFile L, FraudGovPlatform.Layouts.address_cleaner R) := TRANSFORM
				self.clean_address.prim_range			:= R.clean_address.prim_range;	 
				self.clean_address.predir			 		:= R.clean_address.predir;			 
				self.clean_address.prim_name		 	:= R.clean_address.prim_name;		 
				self.clean_address.addr_suffix		:= R.clean_address.addr_suffix;		 
				self.clean_address.postdir			 	:= R.clean_address.postdir;			 
				self.clean_address.unit_desig			:= R.clean_address.unit_desig;		 
				self.clean_address.sec_range		 	:= R.clean_address.sec_range;		 
				self.clean_address.p_city_name		:= R.clean_address.p_city_name;		 
				self.clean_address.v_city_name		:= R.clean_address.v_city_name;		 
				self.clean_address.st				 		:= R.clean_address.st;				 
				self.clean_address.zip				 		:= R.clean_address.zip;				 
				self.clean_address.zip4				 	:= R.clean_address.zip4;				 
				self.clean_address.cart				 	:= R.clean_address.cart;				 
				self.clean_address.cr_sort_sz			:= R.clean_address.cr_sort_sz;		 
				self.clean_address.lot				 		:= R.clean_address.lot;				 
				self.clean_address.lot_order		 	:= R.clean_address.lot_order;		 
				self.clean_address.dbpc				 	:= R.clean_address.dbpc;				 
				self.clean_address.chk_digit		 	:= R.clean_address.chk_digit;		 
				self.clean_address.rec_type				:= R.clean_address.rec_type;			 
				self.clean_address.fips_state 		:= R.clean_address.fips_state; 		 
				self.clean_address.fips_county		:= R.clean_address.fips_county;		 
				self.clean_address.geo_lat			 	:= R.clean_address.geo_lat;			 
				self.clean_address.geo_long				:= R.clean_address.geo_long;			 
				self.clean_address.msa				 		:= R.clean_address.msa;				 
				self.clean_address.geo_blk			 	:= R.clean_address.geo_blk;			 
				self.clean_address.geo_match		 	:= R.clean_address.geo_match;		 
				self.clean_address.err_stat				:= R.clean_address.err_stat;
				SELF := L;
			END;
			
			Cleaned_Address_1 := join(
																			distribute(pInputFile,hash(address_1,address_2)),
																			distribute(Address_Cache,hash(address_1,address_2)),
																		 left.address_1 = right.address_1 and left.address_2 = right.address_2,
																		 addCleanAddress(LEFT,RIGHT),
																		 LEFT OUTER,
																		 LOCAL);
																		 
																		 
																		 

		  pInputFile addCleanAAddress(pInputFile L, FraudGovPlatform.Layouts.address_cleaner R) := TRANSFORM
				self.additional_address.prim_range		:= R.clean_address.prim_range;	 
				self.additional_address.predir			:= R.clean_address.predir;			 
				self.additional_address.prim_name		:= R.clean_address.prim_name;		 
				self.additional_address.addr_suffix	:= R.clean_address.addr_suffix;		 
				self.additional_address.postdir			:= R.clean_address.postdir;			 
				self.additional_address.unit_desig		:= R.clean_address.unit_desig;		 
				self.additional_address.sec_range		:= R.clean_address.sec_range;		 
				self.additional_address.p_city_name	:= R.clean_address.p_city_name;		 
				self.additional_address.v_city_name	:= R.clean_address.v_city_name;		 
				self.additional_address.st				 	:= R.clean_address.st;				 
				self.additional_address.zip				 	:= R.clean_address.zip;				 
				self.additional_address.zip4				:= R.clean_address.zip4;				 
				self.additional_address.cart				:= R.clean_address.cart;				 
				self.additional_address.cr_sort_sz		:= R.clean_address.cr_sort_sz;		 
				self.additional_address.lot				 	:= R.clean_address.lot;				 
				self.additional_address.lot_order		:= R.clean_address.lot_order;		 
				self.additional_address.dbpc				:= R.clean_address.dbpc;				 
				self.additional_address.chk_digit		:= R.clean_address.chk_digit;		 
				self.additional_address.rec_type			:= R.clean_address.rec_type;			 
				self.additional_address.fips_state 	:= R.clean_address.fips_state; 		 
				self.additional_address.fips_county	:= R.clean_address.fips_county;		 
				self.additional_address.geo_lat			:= R.clean_address.geo_lat;			 
				self.additional_address.geo_long			:= R.clean_address.geo_long;			 
				self.additional_address.msa				 	:= R.clean_address.msa;				 
				self.additional_address.geo_blk			:= R.clean_address.geo_blk;			 
				self.additional_address.geo_match		:= R.clean_address.geo_match;		 
				self.additional_address.err_stat			:= R.clean_address.err_stat;			
				SELF := L;
			END;
			
			Cleaned_Address_2 := join(
																			distribute(Cleaned_Address_1(mailing_address_1 <> '' and mailing_address_2 <> ''),hash(mailing_address_1,mailing_address_2)),
																			distribute(Address_Cache,hash(address_1,address_2)),			
																		 left.mailing_address_1 = right.address_1 and left.mailing_address_2 = right.address_2,
																		 addCleanAAddress(LEFT,RIGHT),
																		 INNER,
																		 LOCAL);


			pInputFile appendCleanMailingAddress(Cleaned_Address_1 L, Cleaned_Address_2 R) := transform
					self.additional_address.prim_range		:= if(R.additional_address.prim_range <> '',R.additional_address.prim_range, L.additional_address.prim_range) ;	 
					self.additional_address.predir						:= if(R.additional_address.predir <> '', R.additional_address.predir, L.additional_address.predir);			 
					self.additional_address.prim_name			:= if(R.additional_address.prim_name <> '', R.additional_address.prim_name, L.additional_address.prim_name);
					self.additional_address.addr_suffix	:= if(R.additional_address.addr_suffix <> '', R.additional_address.addr_suffix, L.additional_address.addr_suffix);
					self.additional_address.postdir					:= if(R.additional_address.postdir <> '', R.additional_address.postdir, L.additional_address.postdir);
					self.additional_address.unit_desig		:= if(R.additional_address.unit_desig <> '', R.additional_address.unit_desig, L.additional_address.unit_desig);
					self.additional_address.sec_range			:= if(R.additional_address.sec_range <> '', R.additional_address.sec_range, L.additional_address.sec_range);
					self.additional_address.p_city_name	:= if(R.additional_address.p_city_name <> '', R.additional_address.p_city_name, L.additional_address.p_city_name);
					self.additional_address.v_city_name	:= if(R.additional_address.v_city_name <> '', R.additional_address.v_city_name, L.additional_address.v_city_name);
					self.additional_address.st				 					:= if(R.additional_address.st <> '', R.additional_address.st, L.additional_address.st);
					self.additional_address.zip				 				:= if(R.additional_address.zip <> '', R.additional_address.zip, L.additional_address.zip);
					self.additional_address.zip4								:= if(R.additional_address.zip4 <> '', R.additional_address.zip4, L.additional_address.zip4);
					self.additional_address.cart								:= if(R.additional_address.cart <> '', R.additional_address.cart, L.additional_address.cart);
					self.additional_address.cr_sort_sz		:= if(R.additional_address.cr_sort_sz <> '', R.additional_address.cr_sort_sz, L.additional_address.cr_sort_sz);
					self.additional_address.lot				 				:= if(R.additional_address.lot <> '', R.additional_address.lot, L.additional_address.lot);
					self.additional_address.lot_order			:= if(R.additional_address.lot_order <> '', R.additional_address.lot_order, L.additional_address.lot_order);
					self.additional_address.dbpc								:= if(R.additional_address.dbpc <> '', R.additional_address.dbpc, L.additional_address.dbpc);
					self.additional_address.chk_digit			:= if(R.additional_address.chk_digit <> '', R.additional_address.chk_digit, L.additional_address.chk_digit);
					self.additional_address.rec_type				:= if(R.additional_address.rec_type <> '', R.additional_address.rec_type, L.additional_address.rec_type);
					self.additional_address.fips_state 	:= if(R.additional_address.fips_state <> '', R.additional_address.fips_state, L.additional_address.fips_state);
					self.additional_address.fips_county	:= if(R.additional_address.fips_county <> '', R.additional_address.fips_county, L.additional_address.fips_county);
					self.additional_address.geo_lat					:= if(R.additional_address.geo_lat <> '', R.additional_address.geo_lat, L.additional_address.geo_lat);
					self.additional_address.geo_long				:= if(R.additional_address.geo_long <> '', R.additional_address.geo_long, L.additional_address.geo_long);
					self.additional_address.msa				 				:= if(R.additional_address.msa <> '', R.additional_address.msa, L.additional_address.msa);
					self.additional_address.geo_blk					:= if(R.additional_address.geo_blk <> '', R.additional_address.geo_blk, L.additional_address.geo_blk);
					self.additional_address.geo_match			:= if(R.additional_address.geo_match <> '', R.additional_address.geo_match, L.additional_address.geo_match);
					self.additional_address.err_stat				:= if(R.additional_address.err_stat <> '', R.additional_address.err_stat, L.additional_address.err_stat);
					SELF := L;
			end;
																		 
			Cleaned_Addresses:=	 JOIN (	distribute(Cleaned_Address_1,hash(sequence)),
																															distribute(Cleaned_Address_2,hash(sequence)),
																															left.sequence = right.sequence,
																															appendCleanMailingAddress(left, right),
																															left outer,
																															local
																									);
																									
			
	return Cleaned_Addresses;
endmacro;

export Clean_Name(pInputFile) := 
functionmacro
	import address, ut;
	pInputFile tr(pInputFile l) := transform
						cleanperson73										:= Address.cleanperson73(l.raw_full_name);
						self.cleaned_name.title						:= ut.CleanSpacesAndUpper(cleanperson73[1..5]); 
						self.cleaned_name.fname						:= ut.CleanSpacesAndUpper(cleanperson73[6..25]);
						self.cleaned_name.mname						:= ut.CleanSpacesAndUpper(cleanperson73[26..45]); 
						self.cleaned_name.lname						:= ut.CleanSpacesAndUpper(cleanperson73[46..65]);
						self.cleaned_name.name_suffix				:= ut.CleanSpacesAndUpper(cleanperson73[66..70]); 
						self.cleaned_name.name_score				:= ut.CleanSpacesAndUpper(cleanperson73[71..73]);		
		self:=l;
		self:=[];
	end;

	cleaned_name := project(pInputFile,tr(left));

  return cleaned_name;
	
endmacro;

export Clean_Phone( pInputFile ) := 
functionmacro
	import tools;
	tools.mac_AppendCleanPhone(pInputFile ,phone_number	,dphone_number	,clean_phones.phone_number	,,true);
	tools.mac_AppendCleanPhone(dphone_number	,cell_phone		,dcell_phone		,clean_phones.cell_phone		,,true);
  return dphone_number;
	
endmacro;


export Append_Lexid( pInputFile ) := 
functionmacro
		import DID_Add;
		//Add unique id
		pInputFile tAddUniqueId(pInputFile l, unsigned8 cnt) :=
		transform
 		  self.unique_id	:= cnt;
			self            := L;

		end;   
		
		dAddUniqueId := project(pInputFile, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		FraudGovPlatform.Layouts.Temp.DidSlim tSlimForDiding(pInputFile l, unsigned2 cnt) :=
		transform
			self.fname				:= l.cleaned_name.fname		    	;
			self.mname				:= l.cleaned_name.mname	 	    	;
			self.lname				:= l.cleaned_name.lname					;
			self.name_suffix	:= l.cleaned_name.name_suffix		;
			self.prim_range		:= l.clean_address.prim_range		;
			self.prim_name		:= l.clean_address.prim_name			;
			self.sec_range		:= l.clean_address.sec_range			;
			self.zip5		 			:= l.clean_address.zip						;
			self.state		    := l.clean_address.st						;
			self.phone				:= choose(cnt,l.clean_phones.phone_number,l.clean_phones.cell_phone);
			self.ssn					:= l.ssn											;
			self.dob					:= l.dob											;
			self.did					:= 0  												;
			self.did_score		:= 0  												;
			self		 	    		:= l  												;
		end;
			
		dSlimForDiding	:= normalize(dAddUniqueId
																,if(left.clean_phones.phone_number <>'' and left.clean_phones.cell_phone != '',2,1)
																,tSlimForDiding(left,counter)
																);
																
		// Match to Headers by Contact Name and Address and phone
		Did_Matchset := ['D','S','P','A'];

		DID_Add.MAC_Match_Flex(
			 dSlimForDiding										// Input Dataset
			,Did_Matchset     					      // Did_Matchset  what fields to match on
			,ssn              					  	  // ssn
			,dob              					   		// dob
			,fname														// fname
			,mname			     									// mname
			,lname			     									// lname
			,name_suffix     									// name_suffix
			,prim_range	    					        // prim_range
			,prim_name	      						   	// prim_name
			,sec_range	    					      	// sec_range
			,zip5				        							// zip5
			,state			         						 	// state
			,phone			          						// phone10
			,did                      				// Did
			,FraudGovPlatform.Layouts.Temp.DidSlim  					// output layout
			,TRUE                     				// Does output record have the score
			,did_score               				 	// did score field
			,75                     			  	// score threshold
			,dDidOut													// output dataset			
		);                          


		dDidOut_dist			:= distribute	(dDidOut(did != 0)	,unique_id );
		dDidOut_sort			:= sort				(dDidOut_dist		,unique_id, -did_score	,local);
		dDidOut_dedup			:= dedup			(dDidOut_sort		,unique_id ,local);
		
		dAddUniqueId_dist := distribute	(dAddUniqueId		,unique_id	);

 			 
		pInputFile tAssignDIDs(pInputFile l, FraudGovPlatform.Layouts.Temp.DidSlim r) :=
		transform

			self.did				:= if(r.did <> 0, r.did				, 0);
			self.did_score	:= if(r.did_score <> 0, r.did_score	, 0);
			self 						:= l;

		end;
 
		dAssignDids := join( dAddUniqueId_dist
												,dDidOut_dedup
												,left.unique_id = right.unique_id
												,tAssignDIDs(left, right)
												,left outer
												,local
											 );
		
		return dAssignDids;
	
endmacro;

export Clean_InputFields(pInputFile) := 
functionmacro
	import std;
	pInputFile tr(pInputFile l) := transform
		self.clean_ssn				:= If(regexfind('^[0-9]*$',STD.Str.CleanSpaces(l.ssn)),STD.Str.CleanSpaces(l.ssn),'');
		Self.clean_Ip_address := If(Count(Std.Str.SplitWords(l.ip_address,'.')) =4,l.ip_address,''); 
		SELF.clean_Zip				:= If(regexfind('^[0-9]*$',STD.Str.CleanSpaces(regexreplace('-',l.zip,''))),if(length(STD.Str.CleanSpaces(regexreplace('-',l.zip,''))) in [5,9],l.zip,''),'');		
		self:=l;
		self:=[];
	end;

	Cleaned_InputFields := project(pInputFile,tr(left));

  return Cleaned_InputFields;
	
endmacro;

end; 
