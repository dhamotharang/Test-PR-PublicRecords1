EXPORT proc_InsiderFiling(string filedate) := module

import Lib_StringLib,ut;


	
d_IFRel := sort( distribute( Files_raw.dFiling, hash(relationship )),relationship,local);

dCodeLookupRel := File_Code_Lookup(code_type = 'relationship' and code <> '');

Vickers.Layouts_raw.common_FF_clean maprelcode ( d_IFRel l , dCodeLookupRel r ) := transform
self.relationship_desc := r.code_desc;
self.relationship_alpha	:= r.code_alpha;								 
self.relationship_code := r.code;
self := l;
self := [];
end;

 dJoin_1 := Join ( d_IFRel , dCodeLookupRel ,
                           trim(left.relationship,left,right) = trim(right.code,left,right),
													 maprelcode(left,right),
													 left outer,lookup) ;
													 
d_IFDollar := sort( distribute( dJoin_1, hash(dollar_type )),dollar_type,local);

dCodeLookupDollar := File_Code_Lookup(code_type = 'dollarType' and code <> '');

													 

Vickers.Layouts_raw.common_FF_clean mapdolcode ( d_IFDollar l , dCodeLookupDollar r ) := transform
								 
self.dollar_type_desc	:= r.code_desc;
self.dollar_type_alpha	:= r.code_alpha;

self := l;
self := [];
end;

dJoin_2 := Join ( d_IFDollar , dCodeLookupDollar,
                           trim(left.dollar_type,left,right) = trim(right.code,left,right),
													 mapdolcode(left,right),
													 left outer,lookup);


d_IFTrans := sort( distribute( dJoin_2, hash(trans_type )),trans_type,local);
dCodeLookupTrans := File_Code_Lookup(code_type = 'transType' and code <> '');
													 
													 
													 
Vickers.Layouts_raw.common_FF_clean maptranscode ( d_IFTrans l , dCodeLookupTrans r ) := transform
								 
self.trans_type_desc	:= r.code_desc;
self.trans_type_alpha	:= r.code_alpha;
self.trans_type_desc2	:= r.code_desc2;
self := l;
self := [];
end;

dJoin_3 := Join ( d_IFTrans , dCodeLookupTrans ,
                           trim(left.trans_type,left,right) = trim(right.code,left,right),
													 maptranscode(left,right),
													 left outer,lookup);
													 
d_IFForm := sort( distribute( dJoin_3, hash(form_type )),form_type,local);
	dCodeLookupForm := File_Code_Lookup(code_type = 'formType' and code <> '');
												 
													 
													 
Vickers.Layouts_raw.common_FF_clean mapformcode ( d_IFForm l , dCodeLookupForm r ) := transform
								 
self.form_type_desc	:= r.code_desc;
self.form_type_alpha	:= r.code_alpha;
self.form_type_desc2	:= r.code_desc2;
self := l;
self := [];
end;

 dJoin_Filing := Join ( d_IFForm , dCodeLookupForm,
                           trim(left.form_type,left,right) = trim(right.code,left,right),
													 mapformcode(left,right),
													 left outer,lookup) : persist( '~thor_data400::persist::vickers::InsiderFiling_lookupJoin') ;
													 
													 
													 
d_IFCountry := Files_raw.dFiler;
	dCodeLookupother := Vickers.File_Code_Lookup(code_type = 'country' and code_alpha <> '');


Vickers.Layouts_raw.common_FF_clean mapcountrycode ( d_IFCountry l , dCodeLookupother r ) := transform
								 
self.country_desc	:= r.code_desc;

self := l;
self := [];
end;

  dJoin_Filer := Join ( d_IFCountry , dCodeLookupother,
                           trim(left.country) = trim(right.code_alpha),
													 mapcountrycode(left,right),
													 left outer,lookup) : persist( '~thor_data400::persist::vickers::InsiderFiler_lookupJoin');
													 
dist_IFiling := sort( distribute( dJoin_Filing, hash( filer_id)),filer_id,local);
dist_IFiler := sort( distribute( dJoin_Filer, hash( filer_id)),filer_id,local);
													 
Vickers.Layouts_raw.common_FF_clean conv2fixed ( dist_IFiling l , dist_IFiler r ) := transform

self.date_entered := l.date_entered[1..8];
self.upd_date     := l.upd_date[1..8];
self.market_value := l.market_value[1..15];
self.filer_name    :=       r.filer_name  ;
self.street        :=       r.street      ;
self.street2       :=       r.street2     ;
self.city          :=       r.city        ;
self.state         :=       r.state       ;
self.province      :=       r.province    ;
self.country       :=       r.country     ;
self.country_desc  :=       r.country_desc ;
self.zip_code      :=       r.zip_code    ;
self.zip_code4     :=       r.zip_code4   ;

self := l;
self := r;
end;

  dCommonFF := Join ( dist_IFiling, dist_IFiler,
                    left.filer_id=right.filer_id,
										conv2fixed(left,right),
										local
									 ): persist( '~thor_data400::persist::vickers::InsiderFiler_test');
									 
//Remove Tabs from all the fields									 
Vickers.Layouts_raw.common_FF_clean  removetab( dCommonFF l ) := transform

self.form_id                   := StringLib.StringFilterout(   l.form_id           ,'\t');
self.row_nbr                   := StringLib.StringFilterout(   l.row_nbr           ,'\t');
self.cusip                     := StringLib.StringFilterout(   l.cusip             ,'\t');
self.filer_id                  := StringLib.StringFilterout(   l.filer_id          ,'\t');
self.filer_name                := ut.fnTrim2Upper(StringLib.StringFilterout(   l.filer_name        ,'\t'));
self.street                    := ut.fnTrim2Upper(StringLib.StringFilterout(   l.street            ,'\t'));
self.street2                   := ut.fnTrim2Upper(StringLib.StringFilterout(   l.street2           ,'\t'));
self.city                      := ut.fnTrim2Upper(StringLib.StringFilterout(   l.city              ,'\t'));
self.state                     := ut.fnTrim2Upper(StringLib.StringFilterout(   l.state             ,'\t'));
self.province                  := StringLib.StringFilterout(   l.province          ,'\t');
self.country                   := ut.fnTrim2Upper(StringLib.StringFilterout(   l.country           ,'\t'));
self.country_desc              := ut.fnTrim2Upper(StringLib.StringFilterout(   l.country_desc      ,'\t'));
self.zip_code                  := StringLib.StringFilterout(   l.zip_code          ,'\t');
self.zip_code4                 := StringLib.StringFilterout(   l.zip_code4         ,'\t');
self.relationship_code         := StringLib.StringFilterout(   l.relationship_code      ,'\t');
self.relationship_desc         := ut.fnTrim2Upper(StringLib.StringFilterout(   l.relationship_desc ,'\t'));
self.relationship_alpha        := StringLib.StringFilterout(   l.relationship_alpha,'\t');
self.trans_date_from           := StringLib.StringFilterout(   l.trans_date_from   ,'\t');
self.trans_date_to             := StringLib.StringFilterout(   l.trans_date_to     ,'\t');
self.trans_amt                 := StringLib.StringFilterout(   l.trans_amt         ,'\t');
self.market_value              := StringLib.StringFilterout(   l.market_value      ,'\t');
self.trans_amt_type            := StringLib.StringFilterout(   l.trans_amt_type    ,'\t');
self.dollar_type               := StringLib.StringFilterout(   l.dollar_type       ,'\t');
self.dollar_type_desc          := ut.fnTrim2Upper(StringLib.StringFilterout(   l.dollar_type_desc  ,'\t'));
self.dollar_type_alpha         := StringLib.StringFilterout(   l.dollar_type_alpha ,'\t');
self.trans_type                := StringLib.StringFilterout(   l.trans_type        ,'\t');
self.trans_type_desc           := ut.fnTrim2Upper(StringLib.StringFilterout(   l.trans_type_desc   ,'\t'));
self.trans_type_alpha          := StringLib.StringFilterout(   l.trans_type_alpha  ,'\t');
self.trans_type_desc2          := StringLib.StringFilterout(   l.trans_type_desc2  ,'\t');
self.trans_price_from          := StringLib.StringFilterout(   l.trans_price_from  ,'\t');
self.trans_price_to            := StringLib.StringFilterout(   l.trans_price_to    ,'\t');
self.amt_owned                 := StringLib.StringFilterout(   l.amt_owned         ,'\t');
self.owned_type                := StringLib.StringFilterout(   l.owned_type        ,'\t');
self.form_type                 := StringLib.StringFilterout(   l.form_type         ,'\t');
self.form_type_desc            := ut.fnTrim2Upper(StringLib.StringFilterout(   l.form_type_desc    ,'\t'));
self.form_type_alpha           := StringLib.StringFilterout(   l.form_type_alpha   ,'\t');
self.form_type_desc2           := StringLib.StringFilterout(   l.form_type_desc2   ,'\t');
self.broker_code               := StringLib.StringFilterout(   l.broker_code       ,'\t');
self.date_entered              := StringLib.StringFilterout(   l.date_entered      ,'\t');
self.upd_date                  := StringLib.StringFilterout(   l.upd_date          ,'\t');
self := l;
end;

dWithouttab := project( dCommonFF ,removetab(left));



//Apply NID to clean names


dMastername_cln := Standardize_Name.InsiderFF(dWithouttab).clname;


dWithClean 		:= Standardize_Addr.InsiderFF(dMastername_cln).dbase : persist('~thor_data400::persist::insider_filing_cln');



Layout_Insider_Filing_In cleanfinal( dWithClean l) := transform
self.name_prefix   := l.clean_name.title ;   
self.name_first    := l.clean_name.fname;  
self.name_middle   := l.clean_name.mname; 
self.name_last     := l.clean_name.lname; 
self.name_suffix   := l.clean_name.name_suffix; 
self.name_score    := '';
  
self.prim_range         :=  l.clean_address.prim_range  ;  
self.predir             :=  l.clean_address.predir      ;  
self.prim_name         :=  l.clean_address.prim_name   ;   
self.addr_suffix        :=  l.clean_address.addr_suffix ;  
self.postdir            :=  l.clean_address.postdir     ;  
self.unit_desig        :=  l.clean_address.unit_desig  ;   
self.sec_range          :=  l.clean_address.sec_range   ;  
self.p_city_name       :=  l.clean_address.p_city_name ;   
self.v_city_name       :=  l.clean_address.v_city_name ;   
self.st                 :=  l.clean_address.st          ;  
self.zip                :=  l.clean_address.zip         ;  
self.zip4                 :=  l.clean_address.zip4          ;  
self.cart               :=  l.clean_address.cart        ;  
self.cr_sort_sz         :=  l.clean_address.cr_sort_sz  ;  
self.lot                :=  l.clean_address.lot         ;  
self.lot_order          :=  l.clean_address.lot_order   ;  
self.dpbc               :=  l.clean_address.dbpc        ;  
self.chk_digit          :=  l.clean_address.chk_digit   ;  
self.record_type           :=  l.clean_address.rec_type    ;  
self.ace_fips_st        :=  l.clean_address.fips_state ;  
self.fipscounty             :=  l.clean_address.fips_county      ;  
self.geo_lat           :=  l.clean_address.geo_lat     ;   
self.geo_long          :=  l.clean_address.geo_long    ;   
self.msa                :=  l.clean_address.msa         ;  
self.geo_blk            :=  l.clean_address.geo_blk     ;  
self.geo_match          :=  l.clean_address.geo_match   ;  
self.err_stat           :=  l.clean_address.err_stat    ;  

self := l;

end;


dCleanFFAll := project ( dWithClean , cleanfinal(left)) : persist('~thor_data400::persist::vickers_insider_clnparse');



build_insider_filing := Sequential( fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::insider_filing'),

                                     output(dCleanFFAll,,'~thor_data400::in::vickers::'+filedate+'::insider_filing_in',overwrite)
																		);

transac_insider_filing := sequential(fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::delete::insider_filing','~thor_data400::in::vickers::sprayed::grandfather::insider_filing',,true),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::grandfather::insider_filing'),
								fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::grandfather::insider_filing','~thor_data400::in::vickers::sprayed::father::insider_filing',,true),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::father::insider_filing'),
								fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::father::insider_filing','~thor_data400::in::vickers::sprayed::insider_filing',,true),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::insider_filing'),
								fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::insider_filing','~thor_data400::in::vickers::'+filedate+'::insider_filing_in'),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::delete::insider_filing',true));

export dInsiderFinal := Sequential( build_insider_filing,transac_insider_filing);

end;
