import FLAccidents, FLAccidents_Ecrash, STD, prte2_ecrash, ut;

EXPORT files := module
#option ('multiplePersistInstances',false);

// EXPORT dvina	:= FLAccidents.File_VINA;

//Datasets and Projections are defined here.  Make sure there are no layouts or keys in this attribute.
EXPORT infile_boca 	:= DATASET(Constants.in_prefix_name + '::boca', layout_boca_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"'), maxlength(5200)) );
EXPORT infile_ins 	:= DATASET(Constants.in_prefix_name + '::ins',  Layout_insurance_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"'), maxlength(5200)) );

//New File for BuyCash KY Integration
EXPORT infile_agencycmbnd		:= dataset(Constants.in_prefix_name + '::agency', Layout_Agency_Ins, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));

//New File for Agency Key
EXPORT dsAgency							:= project(infile_agencycmbnd, transform(layouts.agency, self := left, self:= []));

EXPORT base_photo 				:= dataset([], FLAccidents_Ecrash.Layouts.PhotoLayout);

//Clean Jurisdiction Field
{recordof(infile_ins), unsigned rid} 	AppendRID(infile_ins L, integer cnt) := transform
	self.rid := cnt;
	self := L;
end;	

infile_ins_seq := project(infile_ins, AppendRID(left,counter)): persist('~prte::persist::ecrash_cru_juris');
EXPORT File_eCrashCRU 		:= fix_juris(infile_ins_seq, jurisdiction, rid);

export ecrash_basefile 		:= project(File_eCrashCRU, 
																		 transform(FLAccidents_Ecrash.Layout_Basefile, 
																							self.did 								  := (unsigned)left.did; 
																							self.is_terminated_agency := if(left.is_terminated_agency = '0',false,true);
																							self := left; 
																							self := []));

EXPORT base_alpharetta    := project(File_eCrashCRU, transform(FLAccidents.Layout_NtlAccidents_Alpharetta.clean, 
																													 self.did := (integer)left.did, 
																													 self := left, 
																													 self := []));
EXPORT base_cru_inquired	:= dataset([], FLAccidents_Ecrash.Layout_CRU_inquiries);


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
																				self.report_code			:= if(trim(left.report_code) = '', 'EA', left.report_code);
																				self.report_category	:= if(trim(left.report_category) = '','AUTO REPORT', left.report_category);
																				self.report_code_desc	:= if(trim(left.report_code_desc) = '','AUTO ACCIDENT', left.report_code_desc);
																				self.accident_nbr     := left.accident_nbr;
																				self.orig_accnbr      := left.accident_nbr; 
																				self := LEFT;
																				));

pntl0		:= project(base_alpharetta, transform(layouts.key_ecrash0, self := left, self := []));
pinq0		:= project(base_cru_inquired, transform(layouts.key_ecrash0, self := left, self := []));

// EXPORT ds_ecrash0 := dedup(pflc0 + pntl0 + pinq0, record, all);
EXPORT ds_ecrash0 := pflc0;
																												

// Ecrash1 Key
pflc1 := project(base_ecrash1, transform(layouts.key_ecrash1,
																				self.report_code			:= if(trim(left.report_code) = '', 'EA', left.report_code);
																				self.report_category	:= if(trim(left.report_category) = '','AUTO REPORT', left.report_category);
																				self.report_code_desc	:= if(trim(left.report_code_desc) = '','AUTO ACCIDENT', left.report_code_desc);
																				self.orig_accnbr      := left.accident_nbr; 
																				self := LEFT;
																				self := [];
																				));
EXPORT ds_ecrash1 := dedup(pflc1,all);  



// Ecrash2v Key
Layouts.key_ecrashv2 	xpndrecs2v(base_ecrash2v L, base_ecrash0 R) := transform
self.report_code						:= if(trim(l.report_code) = '', 'EA', l.report_code);
self.report_category				:= if(trim(l.report_category) = '','AUTO REPORT', l.report_category);
self.report_code_desc				:= if(trim(l.report_code_desc) = '','AUTO ACCIDENT', l.report_code_desc);
self.vehicle_incident_city	:= if(L.accident_nbr= R.accident_nbr,R.city_town_name,'');
self.vehicle_incident_st		:= l.jurisdiction_state;
self.carrier_name 					:= l.ins_company_name;
self.client_type_id					:= '';
self.accident_nbr           := l.accident_nbr;
self := L;
self := []
end;

EXPORT ds_ecrash2v := join(distribute(base_ecrash2v,hash(accident_nbr)),
														distribute(pull(base_ecrash0),hash(accident_nbr)),
															left.accident_nbr = right.accident_nbr,
																	xpndrecs2v(left,right),left outer,local);


// Ecrash3V Key
EXPORT ds_ecrash3v := project(base_ecrash3v, transform(layouts.key_ecrash3v,
																												 self.report_code				:= if(trim(left.report_code) = '', 'EA', left.report_code);
																												 self.report_category		:= if(trim(left.report_category) = '','AUTO REPORT', left.report_category);
																												 self.report_code_desc	:= if(trim(left.report_code_desc) = '','AUTO ACCIDENT', left.report_code_desc);
																												 self.orig_accnbr 			:= left.accident_nbr; 
																												 self	:= left;
																												 self := [];
																													));




// Ecrash5 Key
pflc5:= project(base_ecrash5, transform(Layouts.key_ecrash5,
																				self.report_code			:= if(trim(left.report_code) = '', 'EA', left.report_code);
																				self.report_category	:= if(trim(left.report_category) = '','AUTO REPORT', left.report_category);
																				self.report_code_desc	:= if(trim(left.report_code_desc) = '','AUTO ACCIDENT', left.report_code_desc);
																				self.orig_accnbr 			:= left.accident_nbr; 
																				self := LEFT;
																				self := [];
																				));
EXPORT ds_ecrash5 := dedup(pflc5,all); 


// Ecrash6 Key
pflc6:= project(base_ecrash6, transform(layouts.key_ecrash6,
																				self.report_code			:= if(trim(left.report_code) = '', 'EA', left.report_code);
																				self.report_category	:= if(trim(left.report_category) = '','AUTO REPORT', left.report_category);
																				self.report_code_desc	:= if(trim(left.report_code_desc) = '','AUTO ACCIDENT', left.report_code_desc);
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
																				self.report_code			:= if(trim(left.report_code) = '', 'EA', left.report_code);
																				self.report_category	:= if(trim(left.report_category) = '','AUTO REPORT', left.report_category);
																				self.report_code_desc	:= if(trim(left.report_code_desc) = '','AUTO ACCIDENT', left.report_code_desc);
																				self.orig_accnbr 			:= left.accident_nbr; 
																				self := LEFT;
																				self := [];
																				));
EXPORT ds_ecrash7  := dedup(pflc7,all);


//Ecrash8 Key
pflc8:= project(base_ecrash8, transform(layouts.key_ecrash8,
																				self.report_code			:= if(trim(left.report_code) = '', 'EA', left.report_code);
																				self.report_category	:= if(trim(left.report_category) = '','AUTO REPORT', left.report_category);
																				self.report_code_desc	:= if(trim(left.report_code_desc) = '','AUTO ACCIDENT', left.report_code_desc);
																				self.orig_accnbr 				:= left.accident_nbr; 
																				self := LEFT;
																				));

EXPORT ds_ecrash8 :=dedup(pflc8,all); 



//Creating Supplemental file 
shared supplemental:= project(File_eCrashCRU, transform(FLAccidents_Ecrash.Layouts.ReportVersion, 
															 self.super_report_id 			:= left.report_id;
															 self.hash_key 							:= left.image_hash;
															 self.report_code 					:= left.report_code;
															 self.is_terminated_agency  := if(left.is_terminated_agency = '0',false,true);
															 self := left; 
															 self := [])); 

ds_supplemental_filter := supplemental( u_d_flag <> 'D' and  (((trim(report_type_id,all) in ['A','DE'] or STD.str.ToUpperCase(trim(vendor_code,left,right)) = 'CMPD')) or 
																											  trim(vendor_code,left,right) = 'COPLOGIC'));
dst_allrecs := distribute(ds_supplemental_filter, hash(super_report_id));
srt_base    := sort(dst_allrecs, super_report_id,hash_key,report_code,creation_date,Sent_to_HPCC_DateTime,map(u_d_flag='' => 3,u_d_flag = 'U' => 2, 1),report_id, local);
export ded_supplemental    := dedup(srt_base, super_report_id,hash_key,report_code,right, local);  



//Creating Reportid file
EXPORT ds_reportid :=  supplemental(( ((trim(report_type_id,all) in ['A','DE'] or STD.str.ToUpperCase(trim(vendor_code,left,right)) = 'CMPD') and 
																				trim(vendor_code, left,right) <> 'COPLOGIC')) or trim(vendor_code, left, right) = 'COPLOGIC');


//Photo Key
ds_SupplementalBase := supplemental(TRIM(report_type_id,all) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD');

ds_SuperReport := DEDUP(SORT(DISTRIBUTE(ds_SupplementalBase, HASH64(Super_report_id)), super_report_id,report_id, LOCAL), Super_report_id,report_id,LOCAL);
																 
layouts.ecrashv2_photoid 	trans_PhotoSuperReport(base_photo le, ds_SupplementalBase ri):= transform
	self.Super_report_id := ri.Super_report_id;
	self := le;
	self := [];
end;

EXPORT ds_photoid	:= JOIN(base_photo, ds_SupplementalBase,
													 trim(LEFT.incident_id,left,right) = trim(RIGHT.Incident_id, left,right)
													 , trans_PhotoSuperReport(Left, Right), hash);



END;