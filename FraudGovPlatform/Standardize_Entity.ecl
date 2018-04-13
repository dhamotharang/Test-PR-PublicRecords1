EXPORT Standardize_Entity       := 
MODULE

EXPORT Clean_Address(pInputFile, pAddressCache ) := 
FUNCTIONMACRO		
				
		pInputFile addCleanAddress(pInputFile L, FraudGovPlatform.Layouts.Base.AddressCache R) := TRANSFORM
				SELF.clean_address.prim_range			:= R.clean_address.prim_range;	 
				SELF.clean_address.predir			 	:= R.clean_address.predir;			 
				SELF.clean_address.prim_name		 	:= R.clean_address.prim_name;		 
				SELF.clean_address.addr_suffix		:= R.clean_address.addr_suffix;		 
				SELF.clean_address.postdir			 	:= R.clean_address.postdir;			 
				SELF.clean_address.unit_desig			:= R.clean_address.unit_desig;		 
				SELF.clean_address.sec_range		 	:= R.clean_address.sec_range;		 
				SELF.clean_address.p_city_name		:= R.clean_address.p_city_name;		 
				SELF.clean_address.v_city_name		:= R.clean_address.v_city_name;		 
				SELF.clean_address.st				 		:= R.clean_address.st;				 
				SELF.clean_address.zip				 		:= R.clean_address.zip;				 
				SELF.clean_address.zip4				 	:= R.clean_address.zip4;				 
				SELF.clean_address.cart				 	:= R.clean_address.cart;				 
				SELF.clean_address.cr_sort_sz			:= R.clean_address.cr_sort_sz;		 
				SELF.clean_address.lot				 		:= R.clean_address.lot;				 
				SELF.clean_address.lot_order		 	:= R.clean_address.lot_order;		 
				SELF.clean_address.dbpc				 	:= R.clean_address.dbpc;				 
				SELF.clean_address.chk_digit		 	:= R.clean_address.chk_digit;		 
				SELF.clean_address.rec_type				:= R.clean_address.rec_type;			 
				SELF.clean_address.fips_state 		:= R.clean_address.fips_state; 		 
				SELF.clean_address.fips_county		:= R.clean_address.fips_county;		 
				SELF.clean_address.geo_lat			 	:= R.clean_address.geo_lat;			 
				SELF.clean_address.geo_long				:= R.clean_address.geo_long;			 
				SELF.clean_address.msa				 		:= R.clean_address.msa;				 
				SELF.clean_address.geo_blk			 	:= R.clean_address.geo_blk;			 
				SELF.clean_address.geo_match		 	:= R.clean_address.geo_match;		 
				SELF.clean_address.err_stat				:= R.clean_address.err_stat;
				SELF := L;
			END;
			
			Cleaned_Address_1 := join(	pInputFile,
										pAddressCache,
										left.address_id = RIGHT.address_id,
										addCleanAddress(LEFT,RIGHT),
										LEFT OUTER);			 

		  pInputFile addCleanAAddress(pInputFile L, FraudGovPlatform.Layouts.Base.AddressCache R) := TRANSFORM
				SELF.additional_address.prim_range		:= R.clean_address.prim_range;	 
				SELF.additional_address.predir			:= R.clean_address.predir;			 
				SELF.additional_address.prim_name		:= R.clean_address.prim_name;		 
				SELF.additional_address.addr_suffix	:= R.clean_address.addr_suffix;		 
				SELF.additional_address.postdir			:= R.clean_address.postdir;			 
				SELF.additional_address.unit_desig		:= R.clean_address.unit_desig;		 
				SELF.additional_address.sec_range		:= R.clean_address.sec_range;		 
				SELF.additional_address.p_city_name	:= R.clean_address.p_city_name;		 
				SELF.additional_address.v_city_name	:= R.clean_address.v_city_name;		 
				SELF.additional_address.st				:= R.clean_address.st;				 
				SELF.additional_address.zip				:= R.clean_address.zip;				 
				SELF.additional_address.zip4			:= R.clean_address.zip4;				 
				SELF.additional_address.cart			:= R.clean_address.cart;				 
				SELF.additional_address.cr_sort_sz	:= R.clean_address.cr_sort_sz;		 
				SELF.additional_address.lot				:= R.clean_address.lot;				 
				SELF.additional_address.lot_order	:= R.clean_address.lot_order;		 
				SELF.additional_address.dbpc			:= R.clean_address.dbpc;				 
				SELF.additional_address.chk_digit	:= R.clean_address.chk_digit;		 
				SELF.additional_address.rec_type		:= R.clean_address.rec_type;			 
				SELF.additional_address.fips_state := R.clean_address.fips_state; 		 
				SELF.additional_address.fips_county	:= R.clean_address.fips_county;		 
				SELF.additional_address.geo_lat			:= R.clean_address.geo_lat;			 
				SELF.additional_address.geo_long		:= R.clean_address.geo_long;			 
				SELF.additional_address.msa				:= R.clean_address.msa;				 
				SELF.additional_address.geo_blk		:= R.clean_address.geo_blk;			 
				SELF.additional_address.geo_match	:= R.clean_address.geo_match;		 
				SELF.additional_address.err_stat		:= R.clean_address.err_stat;			
				SELF := L;
			END;
			
			Cleaned_Address_2 := join(
										Cleaned_Address_1(mailing_address_1 <> '' and mailing_address_2 <> ''),
										pAddressCache,
										left.mailing_address_id = RIGHT.address_id,
										addCleanAAddress(LEFT,RIGHT),
										INNER);


			pInputFile appendCleanMailingAddress(Cleaned_Address_1 L, Cleaned_Address_2 R) := TRANSFORM
					SELF.additional_address.prim_range		:= if(R.additional_address.prim_range <> '',R.additional_address.prim_range, L.additional_address.prim_range) ;	 
					SELF.additional_address.predir			:= if(R.additional_address.predir <> '', R.additional_address.predir, L.additional_address.predir);			 
					SELF.additional_address.prim_name		:= if(R.additional_address.prim_name <> '', R.additional_address.prim_name, L.additional_address.prim_name);
					SELF.additional_address.addr_suffix	:= if(R.additional_address.addr_suffix <> '', R.additional_address.addr_suffix, L.additional_address.addr_suffix);
					SELF.additional_address.postdir			:= if(R.additional_address.postdir <> '', R.additional_address.postdir, L.additional_address.postdir);
					SELF.additional_address.unit_desig		:= if(R.additional_address.unit_desig <> '', R.additional_address.unit_desig, L.additional_address.unit_desig);
					SELF.additional_address.sec_range		:= if(R.additional_address.sec_range <> '', R.additional_address.sec_range, L.additional_address.sec_range);
					SELF.additional_address.p_city_name	:= if(R.additional_address.p_city_name <> '', R.additional_address.p_city_name, L.additional_address.p_city_name);
					SELF.additional_address.v_city_name	:= if(R.additional_address.v_city_name <> '', R.additional_address.v_city_name, L.additional_address.v_city_name);
					SELF.additional_address.st				:= if(R.additional_address.st <> '', R.additional_address.st, L.additional_address.st);
					SELF.additional_address.zip				:= if(R.additional_address.zip <> '', R.additional_address.zip, L.additional_address.zip);
					SELF.additional_address.zip4			:= if(R.additional_address.zip4 <> '', R.additional_address.zip4, L.additional_address.zip4);
					SELF.additional_address.cart			:= if(R.additional_address.cart <> '', R.additional_address.cart, L.additional_address.cart);
					SELF.additional_address.cr_sort_sz	:= if(R.additional_address.cr_sort_sz <> '', R.additional_address.cr_sort_sz, L.additional_address.cr_sort_sz);
					SELF.additional_address.lot				:= if(R.additional_address.lot <> '', R.additional_address.lot, L.additional_address.lot);
					SELF.additional_address.lot_order	:= if(R.additional_address.lot_order <> '', R.additional_address.lot_order, L.additional_address.lot_order);
					SELF.additional_address.dbpc			:= if(R.additional_address.dbpc <> '', R.additional_address.dbpc, L.additional_address.dbpc);
					SELF.additional_address.chk_digit	:= if(R.additional_address.chk_digit <> '', R.additional_address.chk_digit, L.additional_address.chk_digit);
					SELF.additional_address.rec_type		:= if(R.additional_address.rec_type <> '', R.additional_address.rec_type, L.additional_address.rec_type);
					SELF.additional_address.fips_state 	:= if(R.additional_address.fips_state <> '', R.additional_address.fips_state, L.additional_address.fips_state);
					SELF.additional_address.fips_county	:= if(R.additional_address.fips_county <> '', R.additional_address.fips_county, L.additional_address.fips_county);
					SELF.additional_address.geo_lat			:= if(R.additional_address.geo_lat <> '', R.additional_address.geo_lat, L.additional_address.geo_lat);
					SELF.additional_address.geo_long		:= if(R.additional_address.geo_long <> '', R.additional_address.geo_long, L.additional_address.geo_long);
					SELF.additional_address.msa				:= if(R.additional_address.msa <> '', R.additional_address.msa, L.additional_address.msa);
					SELF.additional_address.geo_blk		:= if(R.additional_address.geo_blk <> '', R.additional_address.geo_blk, L.additional_address.geo_blk);
					SELF.additional_address.geo_match	:= if(R.additional_address.geo_match <> '', R.additional_address.geo_match, L.additional_address.geo_match);
					SELF.additional_address.err_stat		:= if(R.additional_address.err_stat <> '', R.additional_address.err_stat, L.additional_address.err_stat);
					SELF := L;
			END;
																		 
			Cleaned_Addresses:=	 JOIN (	Cleaned_Address_1,
										Cleaned_Address_2,
										left.unique_id = RIGHT.unique_id,
										appendCleanMailingAddress(left, RIGHT),
										left outer);
																									
			
	RETURN Cleaned_Addresses;
ENDMACRO;

EXPORT Clean_Name(pInputFile) := 
FUNCTIONMACRO
	import address, ut;
	pInputFile tr(pInputFile l) := TRANSFORM
						cleanperson73								:= Address.cleanperson73(l.raw_full_name);
						SELF.cleaned_name.title				:= ut.CleanSpacesAndUpper(cleanperson73[1..5]); 
						SELF.cleaned_name.fname				:= ut.CleanSpacesAndUpper(cleanperson73[6..25]);
						SELF.cleaned_name.mname				:= ut.CleanSpacesAndUpper(cleanperson73[26..45]); 
						SELF.cleaned_name.lname				:= ut.CleanSpacesAndUpper(cleanperson73[46..65]);
						SELF.cleaned_name.name_suffix		:= ut.CleanSpacesAndUpper(cleanperson73[66..70]); 
						SELF.cleaned_name.name_score		:= ut.CleanSpacesAndUpper(cleanperson73[71..73]);		
		SELF:=l;
		SELF:=[];
	END;

	cleaned_name := project(pInputFile,tr(left));

  RETURN cleaned_name;
	
ENDMACRO;

EXPORT Clean_Phone( pInputFile ) := 
FUNCTIONMACRO
	import tools;
	tools.mac_AppENDCleanPhone(pInputFile ,phone_number	,dphone_number	,clean_phones.phone_number	,,true);
	tools.mac_AppENDCleanPhone(dphone_number	,cell_phone		,dcell_phone		,clean_phones.cell_phone		,,true);
  RETURN dphone_number;
	
ENDMACRO;

EXPORT Append_Lexid( pInputFile ) := 
FUNCTIONMACRO
		import DID_Add;

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		FraudGovPlatform.Layouts.Temp.DidSlim tSlimForDiding(pInputFile l, unsigned2 cnt) :=
		TRANSFORM
			SELF.fname			:= l.cleaned_name.fname;
			SELF.mname			:= l.cleaned_name.mname;
			SELF.lname			:= l.cleaned_name.lname;
			SELF.name_suffix	:= l.cleaned_name.name_suffix;
			SELF.prim_range	:= l.clean_address.prim_range;
			SELF.prim_name		:= l.clean_address.prim_name;
			SELF.sec_range		:= l.clean_address.sec_range;
			SELF.zip5		 		:= l.clean_address.zip;
			SELF.state			:= l.clean_address.st;
			SELF.phone			:= choose(cnt,l.clean_phones.phone_number,l.clean_phones.cell_phone);
			SELF.ssn				:= l.ssn;
			SELF.dob				:= l.dob;
			SELF.did				:= 0;
			SELF.did_score		:= 0;
			SELF		 	    		:= l;
		END;
			
		dSlimForDiding	:= normalize(pInputFile
																,if(left.clean_phones.phone_number <>'' and left.clean_phones.cell_phone != '',2,1)
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
			,name_suffix										// name_suffix
			,prim_range										// prim_range
			,prim_name										// prim_name
			,sec_range	    					      	// sec_range
			,zip5												// zip5
			,state												// state
			,phone												// phone10
			,did                      				// Did
			,FraudGovPlatform.Layouts.Temp.DidSlim	// output layout
			,TRUE                     				// Does output record have the score
			,did_score										// did score field
			,75													// score threshold
			,dDidOut											// output dataset			
		);                          


		dDidOut_dist			:= distribute	(dDidOut(did != 0),unique_id );
		dDidOut_sort			:= sort				(dDidOut_dist,unique_id, -did_score	,local);
		dDidOut_dedup		:= dedup			(dDidOut_sort,unique_id ,local);
		
		dAddUniqueId_dist := distribute	(pInputFile,unique_id	);

 			 
		pInputFile tAssignDIDs(pInputFile l, FraudGovPlatform.Layouts.Temp.DidSlim r) :=
		TRANSFORM

			SELF.did				:= if(r.did <> 0, r.did				, 0);
			SELF.did_score	:= if(r.did_score <> 0, r.did_score	, 0);
			SELF 						:= l;

		END;
 
		dAssignDids := join( dAddUniqueId_dist
												,dDidOut_dedup
												,left.unique_id = RIGHT.unique_id
												,tAssignDIDs(left, RIGHT)
												,left outer
												,local
											 );
		
		RETURN dAssignDids;
	
ENDMACRO;

EXPORT Clean_InputFields(pInputFile) := 
FUNCTIONMACRO
	import std;
	pInputFile tr(pInputFile l) := TRANSFORM
		SELF.clean_ssn				:= If(regexfind('^[0-9]*$',STD.Str.CleanSpaces(l.ssn)),STD.Str.CleanSpaces(l.ssn),'');
		SELF.clean_Ip_address := If(Count(Std.Str.SplitWords(l.ip_address,'.')) =4,l.ip_address,''); 
		SELF.clean_Zip				:= If(regexfind('^[0-9]*$',STD.Str.CleanSpaces(regexreplace('-',l.zip,''))),if(length(STD.Str.CleanSpaces(regexreplace('-',l.zip,''))) in [5,9],l.zip,''),'');		
		SELF:=l;
		SELF:=[];
	END;

	Cleaned_InputFields := project(pInputFile,tr(left));

  RETURN Cleaned_InputFields;
	
ENDMACRO;

EXPORT dRefreshLexid(pInputFile) := 
FUNCTIONMACRO

	// Append Lexid only to those records without DID
	DID_unassigned := pInputFile;
	RefreshLexid := Standardize_Entity.Append_Lexid (DID_unassigned);
	
	pInputFile t1(pInputFile L, RefreshLexid R) := transform
		self.did := IF(R.did > 0, R.did, L.did);
		self.did_score := IF(R.did_score > 0, R.did_score, L.did_score);
		self := IF(R.did > 0, R, L);
	end;
	
	updateInputFile := join(pInputFile,
					 RefreshLexid,
					 left.unique_id = right.unique_id,
					 t1(left,right),
					 left outer);
	
	RETURN updateInputFile;
	
ENDMACRO;

EXPORT dRefreshAID(pInputFile) := 
FUNCTIONMACRO
	
	// Clean only those addresses that in the past they weren't cleaned
	nonCleanAddresses := pInputFile(clean_address.err_stat[1]='E');
	getNewAddresses := Functions.refresh_addresses(nonCleanAddresses);	
	RefreshAID := Standardize_Entity.Clean_Address(nonCleanAddresses, getNewAddresses );

	pInputFile t1(pInputFile L, RefreshAID R) := transform
		self.clean_address.prim_range := IF(R.clean_address.prim_range <> '', R.clean_address.prim_range, L.clean_address.prim_range);
		self.clean_address.predir	:= IF(R.clean_address.predir <> '', R.clean_address.predir, L.clean_address.predir);
		self.clean_address.prim_name := IF(R.clean_address.prim_name <> '', R.clean_address.prim_name, L.clean_address.prim_name);
		self.clean_address.addr_suffix:= IF(R.clean_address.addr_suffix <> '', R.clean_address.addr_suffix, L.clean_address.addr_suffix);
		self.clean_address.postdir	:= IF(R.clean_address.postdir <> '', R.clean_address.postdir, L.clean_address.postdir);
		self.clean_address.unit_desig:= IF(R.clean_address.unit_desig <> '', R.clean_address.unit_desig, L.clean_address.unit_desig);
		self.clean_address.sec_range:= IF(R.clean_address.sec_range <> '', R.clean_address.sec_range, L.clean_address.sec_range);
		self.clean_address.p_city_name:= IF(R.clean_address.p_city_name <> '', R.clean_address.p_city_name, L.clean_address.p_city_name);
		self.clean_address.v_city_name:= IF(R.clean_address.v_city_name <> '', R.clean_address.v_city_name, L.clean_address.v_city_name);
		self.clean_address.st:= IF(R.clean_address.st <> '', R.clean_address.st, L.clean_address.st);
		self.clean_address.zip:= IF(R.clean_address.zip <> '', R.clean_address.zip, L.clean_address.zip);
		self.clean_address.zip4	:= IF(R.clean_address.zip4 <> '', R.clean_address.zip4, L.clean_address.zip4);
		self.clean_address.cart	:= IF(R.clean_address.cart <> '', R.clean_address.cart, L.clean_address.cart);
		self.clean_address.cr_sort_sz:= IF(R.clean_address.cr_sort_sz <> '', R.clean_address.cr_sort_sz, L.clean_address.cr_sort_sz);
		self.clean_address.lot:= IF(R.clean_address.lot <> '', R.clean_address.lot, L.clean_address.lot);
		self.clean_address.lot_order:= IF(R.clean_address.lot_order <> '', R.clean_address.lot_order, L.clean_address.lot_order);
		self.clean_address.dbpc	:= IF(R.clean_address.dbpc <> '', R.clean_address.dbpc, L.clean_address.dbpc);
		self.clean_address.chk_digit:= IF(R.clean_address.chk_digit <> '', R.clean_address.chk_digit, L.clean_address.chk_digit);
		self.clean_address.rec_type:= IF(R.clean_address.rec_type <> '', R.clean_address.rec_type, L.clean_address.rec_type);
		self.clean_address.fips_state:= IF(R.clean_address.fips_state <> '', R.clean_address.fips_state, L.clean_address.fips_state);
		self.clean_address.fips_county:= IF(R.clean_address.fips_county <> '', R.clean_address.fips_county, L.clean_address.fips_county);
		self.clean_address.geo_lat	:= IF(R.clean_address.geo_lat <> '', R.clean_address.geo_lat, L.clean_address.geo_lat);
		self.clean_address.geo_long:= IF(R.clean_address.geo_long <> '', R.clean_address.geo_long, L.clean_address.geo_long);
		self.clean_address.msa:= IF(R.clean_address.predir <> '', R.clean_address.predir, L.clean_address.predir);
		self.clean_address.geo_blk	:= IF(R.clean_address.geo_blk <> '', R.clean_address.geo_blk, L.clean_address.geo_blk);
		self.clean_address.geo_match:= IF(R.clean_address.geo_match <> '', R.clean_address.geo_match, L.clean_address.geo_match);
		self.clean_address.err_stat:= IF(R.clean_address.err_stat <> '', R.clean_address.err_stat, L.clean_address.err_stat);
		self := IF(R.clean_address.err_stat <> '', R, L);
	end;
	
	updateInputFile := join(pInputFile,
					 RefreshAID,
					 left.unique_id = right.unique_id,
					 t1(left,right),
					 left outer);
	
	RETURN updateInputFile;

ENDMACRO;

END; 
