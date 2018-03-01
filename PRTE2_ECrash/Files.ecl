import FLAccidents, FLAccidents_Ecrash, STD, prte2_ecrash;

EXPORT files := module

//Datasets and Projections are defined here.  Make sure there are no layouts or keys in this attribute.

EXPORT infile := DATASET(Constants.in_prefix_name, Layouts.Input, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"'), maxlength(5200)) );
EXPORT dvina	:= FLAccidents.File_VINA;

EXPORT base_photo 				:= dataset([], FLAccidents_Ecrash.Layouts.PhotoLayout);
EXPORT base_supplemental 	:= dataset([], FLAccidents_Ecrash.Layouts.ReportVersion);
EXPORT base_tmafterf			:= dataset([], FLAccidents_Ecrash.Layouts.slim_layout);
EXPORT base_alpharetta    := dataset([], FLAccidents.Layout_NtlAccidents_Alpharetta.clean);
EXPORT base_cru_inquired	:= dataset([], FLAccidents_Ecrash.Layout_CRU_inquiries);

//New File for BuyCash KY Integration
EXPORT base_agencycmbnd		:= dataset([], FLAccidents_Ecrash.Layout_Infiles_Fixed.agency_cmbnd);


EXPORT basefile 			:= DATASET(Constants.base_prefix_name, Layouts.Base, thor );
EXPORT base_ecrash0 	:= DATASET(Constants.base_prefix_ecrash+ '0', layouts.base_flCrash0, 	thor );
EXPORT base_ecrash1 	:= DATASET(Constants.base_prefix_ecrash+ '1', layouts.base_flCrash1, 	thor );
EXPORT base_ecrash2v 	:= DATASET(Constants.base_prefix_ecrash+ '2', layouts.base_flCrash2v, thor );
EXPORT base_ecrash3v 	:= DATASET(Constants.base_prefix_ecrash+ '3', layouts.base_flCrash3v, thor );
EXPORT base_ecrash4 	:= DATASET(Constants.base_prefix_ecrash+ '4', layouts.base_flCrash4, 	thor );
EXPORT base_ecrash5 	:= DATASET(Constants.base_prefix_ecrash+ '5', layouts.base_flCrash5, 	thor );
EXPORT base_ecrash6 	:= DATASET(Constants.base_prefix_ecrash+ '6', layouts.base_flCrash6, 	thor );
EXPORT base_ecrash7 	:= DATASET(Constants.base_prefix_ecrash+ '7', layouts.base_flCrash7, 	thor );
EXPORT base_ecrash8 	:= DATASET(Constants.base_prefix_ecrash+ '8', layouts.base_flCrash8, 	thor );
EXPORT base_ecrash9 	:= DATASET(Constants.base_prefix_ecrash+ '9', layouts.base_flCrash9, 	thor );

/*************************************************************************************************/
// Ecrash0 Key
pflc0 := project(base_ecrash0, transform(layouts.key_ecrash0,
																				self.report_code			:= 'EA';
																				self.report_category	:= 'AUTO REPORT';
																				self.report_code_desc	:= 'AUTO ACCIDENT';
																				self.accident_nbr     := left.accident_nbr;
																				self.orig_accnbr      := left.accident_nbr; 
																				self := LEFT;
																				));

pntl0		:= project(base_alpharetta, transform(layouts.key_ecrash0, self := left, self := []));
pinq0		:= project(base_cru_inquired, transform(layouts.key_ecrash0, self := left, self := []));

EXPORT ds_ecrash0 := dedup(pflc0 + pntl0 + pinq0, record, all);
																												

// Ecrash1 Key
pflc1 := project(base_ecrash1, transform(layouts.key_ecrash1,
																				self.report_code			:= 'EA';
																				self.report_category	:= 'AUTO REPORT';
																				self.report_code_desc	:= 'AUTO ACCIDENT';
																				self.accident_nbr     := left.accident_nbr;
																				self.orig_accnbr      := left.accident_nbr; 
																				self := LEFT;
																				self := [];
																				));
EXPORT ds_ecrash1 := dedup(pflc1,all);  



// Ecrash2v Key
Layouts.key_ecrashv2 	xpndrecs2v(base_ecrash2v L, base_ecrash0 R) := transform
self.report_code						:= 'EA';
self.report_category				:= 'AUTO REPORT';
self.report_code_desc				:= 'AUTO ACCIDENT';
self.vehicle_incident_city	:= if(L.accident_nbr= R.accident_nbr,R.city_town_name,'');
self.vehicle_incident_st		:= l.jurisdiction_state;
self.carrier_name 					:= l.ins_company_name;
self.client_type_id					:= '';
self.accident_nbr           := l.accident_nbr;
self.orig_accnbr           	:= l.accident_nbr; 
self.vehicle_owner_dob			:= l.vehicle_owner_dob[5..8]+l.vehicle_owner_dob[1..4] ; 
self.direction_travel_desc  := ''; 
self := L;
self := []
end;

EXPORT ds_ecrash2v := join(distribute(base_ecrash2v,hash(accident_nbr)),
														distribute(pull(base_ecrash0),hash(accident_nbr)),
															left.accident_nbr = right.accident_nbr,
																	xpndrecs2v(left,right),left outer,local);


// Ecrash3V Key
EXPORT ds_ecrash3v := project(base_ecrash3v, transform(layouts.key_ecrash3v,
																												 self.report_code				:= 'EA';
																												 self.report_category		:= 'AUTO REPORT';
																												 self.report_code_desc	:= 'AUTO ACCIDENT';
																												 self.accident_nbr 			:= left.accident_nbr;
																												 self.orig_accnbr 			:= left.accident_nbr; 
																												 self	:= left;
																												 self := [];
																													));




// Ecrash5 Key
pflc5:= project(base_ecrash5, transform(Layouts.key_ecrash5,
																				self.report_code			:= 'EA';
																				self.report_category	:= 'AUTO REPORT';
																				self.report_code_desc	:= 'AUTO ACCIDENT';
																				self.accident_nbr 		:= left.accident_nbr;
																				self.orig_accnbr 			:= left.accident_nbr; 
																				self := LEFT;
																				self := [];
																				));
EXPORT ds_ecrash5 := dedup(pflc5,all); 


// Ecrash6 Key
pflc6:= project(base_ecrash6, transform(layouts.key_ecrash6,
																				self.report_code			:= 'EA';
																				self.report_category	:= 'AUTO REPORT';
																				self.report_code_desc	:= 'AUTO ACCIDENT';
																				self.accident_nbr 		:= left.accident_nbr;
																				self.orig_accnbr 			:= left.accident_nbr;
																				self.ded_dob 					:= left.ded_dob[5..8]+ left.ded_dob[1..4] ;
																				self.ped_race_desc := '';
																				self.ped_sex_desc := '';
																				self := Left;
																				self := [];
																				));

EXPORT ds_ecrash6 := dedup(pflc6,all);


// Ecrash7 Key
pflc7:= project(base_ecrash7, transform(Layouts.key_ecrash7,
																				self.report_code			:= 'EA';
																				self.report_category	:= 'AUTO REPORT';
																				self.report_code_desc	:= 'AUTO ACCIDENT';
																				self.accident_nbr			:= left.accident_nbr;
																				self.orig_accnbr 			:= left.accident_nbr; 
																				self := LEFT;
																				self := [];
																				));
EXPORT ds_ecrash7  := dedup(pflc7,all);


//Ecrash8 Key
pflc8:= project(base_ecrash8, transform(layouts.key_ecrash8,
																				self.report_code				:= 'EA';
																				self.report_category		:= 'AUTO REPORT';
																				self.report_code_desc		:= 'AUTO ACCIDENT';
																				self.accident_nbr 			:= left.accident_nbr;
																				self.orig_accnbr 				:= left.accident_nbr; 
																				self := LEFT;
																				));

EXPORT ds_ecrash8 :=dedup(pflc8,all); 



//Supplemental Key
EXPORT ds_Supplemental := base_supplemental((u_d_flag <> 'D' and trim(report_type_id,all) in ['A','DE']) or ( u_d_flag <> 'D' and trim(vendor_code,left,right) = 'COPLOGIC'));

EXPORT ds_reportid := base_Supplemental((trim(report_type_id,all) in ['A','DE'] and trim(vendor_code, left,right) <> 'COPLOGIC') or (trim(vendor_code, left, right) = 'COPLOGIC'));


//PrefName State Key																						 
layouts.ecrashv2_photoid 	trans_PhotoSuperReport(base_photo le, base_supplemental ri):= transform
	self.Super_report_id := ri.Super_report_id;
	self := le;
	self := [];
end;

EXPORT ds_photoid	:= JOIN(base_photo, base_supplemental,
													 trim(LEFT.incident_id,left,right) = trim(RIGHT.Incident_id, left,right)
													 , trans_PhotoSuperReport(Left, Right), hash);

END;