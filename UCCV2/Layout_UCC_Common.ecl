/*Now (jhuang_prod)
Text In Open Window
*/
import BIPV2;
export Layout_UCC_Common
  :=
  module
   export Did_Bdid 
		:= record
      unsigned6 dt_first_seen;
			unsigned6	dt_last_seen;
			unsigned6 dt_vendor_last_reported;
			unsigned6	dt_vendor_first_reported;
			string8   process_date;
			string5		title;
			string20	fname;
			string20	mname;
			string20	lname;
			string5		name_suffix;
			string3		name_score;
			//string3		name_cleaning_score;
			string60	company_name;
			string10	prim_range;
			string2		predir;
			string28	prim_name;
			string4		suffix;
			string2		postdir;
			string10	unit_desig;
			string8		sec_range;
			string25	p_city_name;
			string25	v_city_name;
			string2		st;
			string5		zip5;
			string4		zip4;
			string3		county;
			string4		cart;
			string1		cr_sort_sz;
			string4		lot;
			string1		lot_order;
			string2		dpbc;
			string1		chk_digit;
			string2		rec_type;
			string2		ace_fips_st;
			string3		ace_fips_county;
			string10	geo_lat;
			string11	geo_long;
			string4		msa;
			string7		geo_blk;
			string1		geo_match;
			string4		err_stat;
			unsigned6	bdid :=0;
			unsigned6 did  :=0;
			unsigned6	did_score :=0;
			unsigned6 bdid_score :=0;
   end;
  
  
   export Party				
	     :=Record
			string120 	Orig_name:='';
			string25 	Orig_lname:='';
			string25	Orig_fname:='';
			string35	Orig_mname:='';
			string10	Orig_suffix:='';
			string9  	duns_number:='';
			string9  	hq_duns_number:='';
			string9 	ssn:='';
			string10 	fein:='';
			string45 	Incorp_state:='';
			string30 	corp_number:='';
			string30 	corp_type:='';
			string60 	Orig_address1:='';
			string60 	Orig_address2:='';
			string30 	Orig_city:='';
			string2  	Orig_state:='';
			string5  	Orig_zip5:='';
			string4  	Orig_zip4:='';
			string30	Orig_country:='';
			string30 	Orig_province:='';
			string9  	Orig_postal_code:='';
			string1  	foreign_indc:='';
			string1  	Party_type:='';
            Did_bdid;
		 end;
	
	export Layout_party
	      :=Record,maxlength(32767)
			string31 	tmsid;	
			string23 	rmsid:='';
			party;
	      end;

	export Layout_party_With_AID :=Record,maxlength(32767)
			Layout_party;			
			unsigned8	source_rec_id  :=  0;
			BIPV2.IDlayouts.l_xlink_ids;
			string100	prep_addr_line1;
			string50	prep_addr_last_line; 			
			unsigned8	RawAid	:= 0;
			unsigned8	ACEAID	:= 0;	
			unsigned8 persistent_record_id:=0;
	end;
	
	export	Collateral
	     :=Record
		    
	        string512	collateral_desc:='';
			string145 	prim_machine:='';
			string145 	sec_machine:='';
			string5     manufacturer_code:='';	
			string120	manufacturer_name:='';
			string15 	model:='';
			string4 	model_year:='';
			string50	model_desc:='';
			string5 	collateral_count:='';
			string4 	manufactured_year:='';
			string1 	new_used:='';
			string30 	serial_number:='';
			string50 	Property_desc:='';
			string9 	borough:='';
			string5 	block:='';
			string4 	lot:='';
			string60 	collateral_address:='';
			string1 	air_rights_indc:='';
			string1 	subterranean_rights_indc:='';
			string1 	easment_indc:='';
		End;
		
	 export	Filing		
	    := Record
			string31 	tmsid;	
			string23 	rmsid:='';	
			string8  	process_date;	
			string12 	static_value:='';	
			string8  	date_vendor_removed:='';
			string8     date_vendor_changed:='';
			string3  	Filing_Jurisdiction:='';	
			string25 	orig_filing_number:='';	
			string40 	orig_filing_type:='';	
			string8  	orig_filing_date:='';	
			string4  	orig_filing_time:='';	
			string25 	filing_number:='';	
			string1  	filing_number_indc :='';	
			string40 	filing_type:='';	
			string8  	filing_date:='';	
			string4  	filing_time:='';
			string8     filing_status:='';
			string30	Status_type:='';
			string3  	page:='';	
			string8  	expiration_date:='';	
			string9  	contract_type:='';	
			string8  	vendor_entry_date:='';	
			string4  	vendor_upd_date:='';	
			string3  	statements_filed:='';	
			string8  	continuious_expiration:='';	
			string17 	microfilm_number:='';	
			string17 	amount:='';	
			string17 	irs_serial_number:='';	
			string8  	effective_date:='';	
			string75 	Signer_Name:='';	
			string60 	title:='';	
			string120 	filing_agency:='';	
			string64 	address:='';	
			string30 	city:='';	
			string2  	state:='';	
			string30 	county:='';	
			string9  	zip:='';	
			string9  	duns_number:='';	
			string8  	cmnt_effective_date:='';	
			string500	description:='';	
		   
		End;
	export	Layout_UCC		
	    := 
		Record   ,MAXLENGTH(32767)
	       Filing;
		   collateral;
		  // dataset(party)      party;
		 
        end;
	export	Layout_UCC_new
	    := 
		Record   ,MAXLENGTH(32767)
	       Layout_UCC;
		   String3 volume:='';
			 unsigned8 persistent_record_id:=0;
		 
        end;
 
END;