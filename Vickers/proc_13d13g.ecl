EXPORT proc_13d13g(string filedate) := module

import lib_Stringlib,ut;


dFilterHdr := Vickers.Files_raw.d13D13G;

d_13d13gForm := sort( distribute( dFilterHdr, hash(form_type )),form_type,local);

dCodeLookupForm := File_Code_Lookup(code_type = 'formType' and code <> '' );
												 
//************Join lookup files with Infile													 

//FormType Join
												 
Vickers.Layouts_raw.Layout_13D13G_clean mapformcode ( d_13d13gForm l , dCodeLookupForm r ) := transform
								 
self.form_type_desc	:= ut.fnTrim2Upper(r.code_desc);
self.form_type_alpha	:= r.code_alpha;
self.form_type_desc2	:= ut.fnTrim2Upper(r.code_desc2);
self := l;
self := [];
end;

 
dJoin_1 := Join ( d_13d13gForm , dCodeLookupForm,
                           left.form_type = right.code,
													 mapformcode(left,right),
													 left outer,lookup);
													 
//TransType Join
													 
d_IFTrans := sort( distribute( dJoin_1, hash(trans_type )),trans_type,local);
dCodeLookupTrans := File_Code_Lookup(code_type = 'transType' and code <> '' );
													 
													 
													 
Vickers.Layouts_raw.Layout_13D13G_clean maptranscode ( d_IFTrans l , dCodeLookupTrans r ) := transform
								 
self.trans_type_desc	:= ut.fnTrim2Upper(r.code_desc);
self.trans_type_alpha	:= r.code_alpha;
self.trans_type_desc2	:= ut.fnTrim2Upper(r.code_desc2);
self := l;
self := [];
end;

dJoin_2 := Join ( d_IFTrans , dCodeLookupTrans ,
                           left.trans_type = right.code,
													 maptranscode(left,right),
													 left outer,lookup);


//Province Join
d_13d13gprov := sort( distribute( dJoin_2, hash(contact_province )),contact_province,local);

dCodeLookupProv := Vickers.File_Code_Lookup(code_type = 'province' );
												 
													 
													 
Vickers.Layouts_raw.Layout_13D13G_clean mapprovcode ( d_13d13gprov l , dCodeLookupProv r ) := transform
								 
self.contact_province_desc	:= ut.fnTrim2Upper(r.code_desc);

self := l;
self := [];
end;

 dJoin_3 := Join ( d_13d13gprov , dCodeLookupProv,
                           left.contact_province = right.code_alpha,
													 mapprovcode(left,right),
													 left outer,lookup);													 
		

//Country Join


d_13d13gcty := sort( distribute( dJoin_3, hash(contact_country )),contact_country,local);

dCodeLookupctry := Vickers.File_Code_Lookup(code_type = 'country' and code_alpha <> '');
												 
													 
													 
Vickers.Layouts_raw.Layout_13D13G_clean mapctrycode ( d_13d13gcty l , dCodeLookupctry r ) := transform
								 
self.contact_country_desc	:= ut.fnTrim2Upper(r.code_desc);

self := l;
self := [];
end;

 dJoin_4 := Join ( d_13d13gcty , dCodeLookupctry,
                           left.contact_country = right.code_alpha,
													 mapctrycode(left,right),
													 left outer,lookup);													 
		

//Reporter Type Join


d_13d13grpt := sort( distribute( dJoin_4, hash(reporter_type )),reporter_type,local);

dCodeLookuprpt := Vickers.File_Code_Lookup(code_type = 'reporterType' and code_alpha <> '');
												 
													 
													 
Vickers.Layouts_raw.Layout_13D13G_clean maprptcode ( d_13d13grpt l , dCodeLookuprpt r ) := transform
								 
self.reporter_type_desc	:= ut.fnTrim2Upper(r.code_desc);

self := l;
self := [];
end;

 dJoin_5 := Join ( d_13d13grpt , dCodeLookuprpt,
                           left.reporter_type = right.code_alpha,
													 maprptcode(left,right),
	                         left outer,lookup) : persist('~thor_data400::persist::vickers_13d13g_lookupjoin');
		
													 
//*************************************************************************************************************													 
//Clean name using NID




Vickers.Layouts_raw.Layout_13D13G_clean mapfinal ( dJoin_5 l ) := transform

self.contact_city := StringLib.StringFilterOut( trim(l.contact_city)[1..40],'\t');
  self.contact_street2 := StringLib.StringFilterOut ( trim(l.contact_street2)[1..37],'\t');
  self.form_id := StringLib.StringFilterOut( trim(l.form_id)[1..18],'\t');
  self.lf := '\n';
  self.cusip := StringLib.StringFilterOut(trim(l.cusip)[1..9],'\t');
  self.amend_nbr := StringLib.StringFilterOut(trim(l.amend_nbr)[1..4],'\t');
  self.contact_title := ut.fnTrim2Upper(StringLib.StringFilterOut(trim(l.contact_title)[1..30],'\t'));
  self.summary_text := ut.fnTrim2Upper(StringLib.StringFilterOut(trim(l.summary_text)[1..3000],'\t'));
  self.form_type := ut.fnTrim2Upper(StringLib.StringFilterOut(trim(l.form_type)[1..2],'\t'));
  self.signer_title := ut.fnTrim2Upper(StringLib.StringFilterOut(trim(l.signer_title)[1..30],'\t'));
  self.signer_name := ut.fnTrim2Upper(StringLib.StringFilterOut( trim(l.signer_name)[1..49],'\t'));
  self.contact_name := ut.fnTrim2Upper(StringLib.StringFilterOut( trim(l.contact_name)[1..50],'\t'));
  self.contact_street := ut.fnTrim2Upper(StringLib.StringFilterOut( trim(l.contact_street)[1..50],'\t'));
  self.contact_state := StringLib.StringFilterOut( trim(l.contact_state)[1..2],'\t');
  self.contact_zip := StringLib.StringFilterOut( trim(l.contact_zip)[1..10],'\t');
  self.contact_zip4 := StringLib.StringFilterOut( trim(l.contact_zip4)[1..4],'\t');
  self.contact_phone := StringLib.StringFilterOut( trim(l.contact_phone)[1..20],'\t');
  self.contact_province := StringLib.StringFilterOut( trim(l.contact_province)[1..2],'\t');
  self.contact_country := StringLib.StringFilterOut( trim(l.contact_country)[1..3],'\t');
  self.filer_id := StringLib.StringFilterOut( trim(l.filer_id)[1..6],'\t');
  self.filer_name := ut.fnTrim2Upper(StringLib.StringFilterOut( trim(l.filer_name)[1..70],'\t'));
  self.trans_date_from := StringLib.StringFilterOut( trim(l.trans_date_from)[1..8],'\t');
  self.trans_date_to := StringLib.StringFilterOut( trim(l.trans_date_to)[1..8],'\t');
  self.trans_amount := StringLib.StringFilterOut( trim(l.trans_amount)[1..10],'\t');
  self.trans_type := ut.fnTrim2Upper(StringLib.StringFilterOut( trim(l.trans_type)[1..2],'\t'));
  self.amount_owned := StringLib.StringFilterOut( trim(l.amount_owned)[1..11],'\t');
  self.sole_vote := StringLib.StringFilterOut( trim(l.sole_vote)[1..11],'\t');
  self.sole_disp := StringLib.StringFilterOut( trim(l.sole_disp)[1..11],'\t');
  self.shared_vote := StringLib.StringFilterOut( trim(l.shared_vote)[1..15],'\t');
  self.shared_disp := StringLib.StringFilterOut( trim(l.shared_disp)[1..15],'\t');
  self.percent_share_out := StringLib.StringFilterOut( trim(l.percent_share_out)[1..6],'\t');
  self.reporter_type := StringLib.StringFilterOut( trim(l.reporter_type)[1..35],'\t');
  self.comment := StringLib.StringFilterOut( trim(l.comment)[1..255],'\t');
	self := l;
	end;
	
	 dWithCleanName := project(dJoin_5,mapfinal(left));
	 
	dNamecln := Standardize_Name.cln_13d13g(dWithCleanName).cln_all;


dAddrCln		:= Standardize_Addr.cln_13d13g(dNamecln).dbase : persist('~thor_data400::persist::13d13g_cln');

	
	
Vickers.Layouts_raw.Layout_13D13G_clean cleandate( dAddrCln l) := transform

self.filing_date := StringLib.Stringfilterout(l.filing_date, '-')[1..8];
self.entered_date := if ( l.entered_date[1..2] < '15' ,'20'+ trim(l.entered_date),'19'+ trim(l.entered_date));
self.upd_date := if ( l.upd_date[1..2] < '15' ,'20'+ trim(l.upd_date),'19'+ trim(l.upd_date));
self := l;	
	
end;

dWithClean := project( dAddrCln,cleandate(left)) : persist('~thor_data400::persist::vickers_13d13g_clean');;


//Filter only addresses that are successfully cleaned


Layout_13d13g_In splitfields( dWithClean l ) := transform

self.signer_name_prefix   := l.clean_signer_name.title;     
self.signer_name_first    := l.clean_signer_name.fname;    
self.signer_name_middle   := l.clean_signer_name.mname;   
self.signer_name_last     := l.clean_signer_name.lname;   
self.signer_name_suffix   := l.clean_signer_name.name_suffix;   
self.signer_name_score    := '';   
self.contact_name_prefix    := l.clean_contact_name.title;  
self.contact_name_first    := l.clean_contact_name.fname;  
self.contact_name_middle    := l.clean_contact_name.mname; 
self.contact_name_last     := l.clean_contact_name.lname; 
self.contact_name_suffix    := l.clean_contact_name.name_suffix;
self.contact_name_score     := '';
self.filer_name_prefix      := l.clean_filer_name.title;    
self.filer_name_first      := l.clean_filer_name.fname;    
self.filer_name_middle     := l.clean_filer_name.mname;   
self.filer_name_last       := l.clean_filer_name.lname;   
self.filer_name_suffix      := l.clean_filer_name.name_suffix;  
self.filer_name_score       := '';  
self.prim_range         :=  l.clean_contact_address.prim_range  ;          
self.predir             :=  l.clean_contact_address.predir      ;          
self.prim_name         :=  l.clean_contact_address.prim_name   ;           
self.addr_suffix        :=  l.clean_contact_address.addr_suffix ;          
self.postdir            :=  l.clean_contact_address.postdir     ;          
self.unit_desig        :=  l.clean_contact_address.unit_desig  ;           
self.sec_range          :=  l.clean_contact_address.sec_range   ;          
self.p_city_name       :=  l.clean_contact_address.p_city_name ;           
self.v_city_name       :=  l.clean_contact_address.v_city_name ;           
self.st                 :=  l.clean_contact_address.st          ;          
self.zip                :=  l.clean_contact_address.zip         ;          
self.zip4                 :=  l.clean_contact_address.zip4          ;      
self.cart               :=  l.clean_contact_address.cart        ;          
self.cr_sort_sz         :=  l.clean_contact_address.cr_sort_sz  ;          
self.lot                :=  l.clean_contact_address.lot         ;          
self.lot_order          :=  l.clean_contact_address.lot_order   ;          
self.dpbc               :=  l.clean_contact_address.dbpc        ;          
self.chk_digit          :=  l.clean_contact_address.chk_digit   ;          
self.record_type           :=  l.clean_contact_address.rec_type    ;       
self.ace_fips_st        :=  l.clean_contact_address.fips_state ;           
self.fipscounty             :=  l.clean_contact_address.fips_county      ; 
self.geo_lat           :=  l.clean_contact_address.geo_lat     ;           
self.geo_long          :=  l.clean_contact_address.geo_long    ;           
self.msa                :=  l.clean_contact_address.msa         ;          
self.geo_blk            :=  l.clean_contact_address.geo_blk     ;          
self.geo_match          :=  l.clean_contact_address.geo_match   ;          
self.err_stat           :=  l.clean_contact_address.err_stat    ;          

self := l;
end;

 dSplitAddress := project( dWithClean, splitfields(left));



 
 
 build_13d13g_in := Sequential ( fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::13d13g'),
                                 output(dSplitAddress,,'~thor_data400::in::vickers::'+filedate+'::13d13g_in',overwrite);
                                );



transac_13d13g := sequential(fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::delete::13d13g','~thor_data400::in::vickers::sprayed::grandfather::13d13g',,true),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::grandfather::13d13g'),
								fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::grandfather::13d13g','~thor_data400::in::vickers::sprayed::father::13d13g',,true),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::father::13d13g'),
								fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::father::13d13g','~thor_data400::in::vickers::sprayed::13d13g',,true),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::13d13g'),
								fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::13d13g','~thor_data400::in::vickers::'+filedate+'::13d13g_in'),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::delete::13d13g',true)																	
								);
export d13D13GFinal := Sequential( build_13d13g_in, transac_13d13g);

end;