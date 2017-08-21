#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import lib_stringlib, lib_date, ut;

//Join Defendant and AddressHistory Files
ds_defend 	:= sort(distribute(hygenics_soff.Mapping_Defendant, hash(recordid)), recordid, local);
ds_address	:= sort(distribute(hygenics_soff.Mapping_Denorm_Address, hash(recordid)), recordid, local);

	def_addr_layout := record
		ds_defend;
		string registration_address_3;
		string registration_address_4;
		string registration_address_5;
		string other_registration_address_1;
		string other_registration_address_2;
		string other_registration_address_3;
		string other_registration_address_4;
		string other_registration_address_5;
	end;
	
	def_addr_layout def_addrRef(ds_defend l, ds_address r):= transform
		self := l;
		self := r;
	end;
	
	def_addr_j 		:= join(ds_defend, ds_address,
							left.recordid = right.recordid,
							def_addrRef(left, right),
							left outer, local);

def_addr_join		:= sort(distribute(def_addr_j, hash(recordid)), recordid, local);

//Join Charge File
ds_chrg	:= sort(distribute(hygenics_soff.Mapping_Charge, hash(recordid)), recordid, local);

	def_addr_layout def_addr_chrgRef(def_addr_join l, ds_chrg r) := transform	
		self.police_agency 	:= r.police_agency;
		self 				:= l;	
	end;

	def_addr_chrg_j := join(def_addr_join, ds_chrg,
							left.recordid = right.recordid,
							def_addr_chrgRef(left,right),
							left outer, local);
							
def_addr_chrg_join	:= sort(distribute(def_addr_chrg_j, hash(recordid)), recordid, local);

//Join Offense File
ds_off	:= sort(distribute(hygenics_soff.Mapping_Denorm_Offense, hash(recordid)), recordid, local);

	def_addr_off_layout := record
		def_addr_layout;
		string arrest_date_1;
		string arrest_warrant_1 ;
		string conviction_jurisdiction_1;
		string conviction_date_1;
		string court_1;
		string court_case_number_1;
		string offense_date_1 ;
		string offense_code_or_statute_1;
		string offense_description_1;
		string offense_description_1_2;
		string offense_level_1;
		string victim_minor_1;
		string victim_age_1;
		string victim_gender_1;
		string victim_relationship_1;
		string offense_location_1;
		string disposition_dt_1;

		string arrest_date_2;
		string arrest_warrant_2;
		string conviction_jurisdiction_2;
		string conviction_date_2;
		string court_2;
		string court_case_number_2;
		string offense_date_2;
		string offense_code_or_statute_2;
		string offense_description_2;
		string offense_description_2_2;
		string offense_level_2;
		string victim_minor_2;
		string victim_age_2;
		string victim_gender_2;
		string victim_relationship_2;
		string offense_location_2;
		string disposition_dt_2;

		string arrest_date_3;
		string arrest_warrant_3;
		string conviction_jurisdiction_3;
		string conviction_date_3;
		string court_3;
		string court_case_number_3;
		string offense_date_3;
		string offense_code_or_statute_3;
		string offense_description_3;
		string offense_description_3_2;
		string victim_minor_3;
		string offense_level_3;
		string victim_age_3;
		string victim_gender_3;
		string victim_relationship_3;
		string offense_location_3;
		string disposition_dt_3;

		string arrest_date_4;
		string arrest_warrant_4;
		string conviction_jurisdiction_4;
		string conviction_date_4;
		string court_4;
		string court_case_number_4;
		string offense_date_4;
		string offense_code_or_statute_4;
		string offense_description_4;
		string offense_description_4_2;
		string offense_level_4;
		string victim_minor_4;
		string victim_age_4;
		string victim_gender_4;
		string victim_relationship_4;
		string offense_location_4;
		string disposition_dt_4;

		string arrest_date_5;
		string arrest_warrant_5;
		string conviction_jurisdiction_5;
		string conviction_date_5;
		string court_5;
		string court_case_number_5;
		string offense_date_5;
		string offense_code_or_statute_5;
		string offense_description_5;
		string offense_description_5_2;
		string offense_level_5;
		string victim_minor_5;
		string victim_age_5;
		string victim_gender_5;
		string victim_relationship_5;
		string offense_location_5;
		string disposition_dt_5;	
	end;
	
	def_addr_off_layout def_addr_offRef(def_addr_chrg_join l, ds_off r) := transform	
		self := l;
		self := r;
	end;

	def_addr_chrg_off_j := join(def_addr_chrg_join, ds_off,
								left.recordid = right.recordid,
								def_addr_offRef(left,right),
								left outer, local);
								
def_addr_chrg_off_join 	:= sort(distribute(def_addr_chrg_off_j, hash(recordid)), recordid, local);

//Join Sentence File
ds_sent	:= sort(distribute(hygenics_soff.Mapping_Denorm_Sentence, hash(recordid)), recordid, local);

	def_addr_off_sent_layout := record
		def_addr_off_layout;
		string sentence_description_1;
		string sentence_description_1_2;
		string sentence_description_2;
		string sentence_description_2_2;
		string sentence_description_3;
		string sentence_description_3_2;
		string sentence_description_4;
		string sentence_description_4_2;
		string sentence_description_5;
		string sentence_description_5_2;
	end;
	
	def_addr_off_sent_layout def_addr_sentRef(def_addr_chrg_off_join l, ds_sent r) := transform	
		self := l;
		self := r;
	end;

	def_addr_chrg_off_sent_j := join(def_addr_chrg_off_join, ds_sent,
									left.recordid = right.recordid,
									def_addr_sentRef(left,right),
									left outer, local);

def_addr_chrg_off_sent_join := sort(distribute(def_addr_chrg_off_sent_j, hash(recordid)), recordid, local);

//Join Other File
ds_other	:= sort(distribute(hygenics_soff.Mapping_Other, hash(recordid)), recordid, local);

	//def_addr_off_sent_layout otherRef(def_addr_chrg_off_sent_join l, ds_other r):= transform
	def_addr_off_sent_layout otherRef(def_addr_chrg_off_sent_join l):= transform
		self.intnet_email_address_1 := ''; //r.intnet_email_address_1;
		self 						:= l;
	end;
	
// def_addr_chrg_off_sent_other_j 		:= join(def_addr_chrg_off_sent_join, ds_other,
											// left.recordid = right.recordid,
											// otherRef(left,right),
											// left outer, local);

def_addr_chrg_off_sent_other_j := project(def_addr_chrg_off_sent_join, otherRef(LEFT));

def_addr_chrg_off_sent_other_join 	:= sort(distribute(def_addr_chrg_off_sent_other_j, hash(recordid)), recordid, local);

ds_dedupsAkaName 					:= DEDUP(SORT(def_addr_chrg_off_sent_other_join
													,state_of_origin
													,name_orig
													,nametype
													,registration_address_1
													,registration_address_2
													,date_of_birth
													,date_of_birth_aka
													,offense_description_1
													,offense_code_or_statute_1
													,-image_link)
													,except nametype
														,Image_Link);

sorted_ds_dedupedAkaName 			:= SORT(ds_dedupsAkaName
													,state_of_origin
													,recordid
													,nametype
													,name_orig
													,date_of_birth
													,date_of_birth_aka);

sorted_ds_dedupedAkaName_final 	:= sorted_ds_dedupedAkaName(~(trim(name_orig)='CAMPOS, OROSCO' and trim(date_of_birth)='19920813'));

//Added 60 Day Restriction to INDIANA Sourced Data///////////////////////////////////////////////////////////////////

	ds_filter 	:= sorted_ds_dedupedAkaName_final(state_of_origin<>'IN'); 
	ds_IN				:= sorted_ds_dedupedAkaName_final(state_of_origin='IN' and LIB_Date.DaysApart(src_upload_date,ut.GetDate )<=60);
											
filtered_recs	:= ds_filter + ds_IN;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

defendant_filter 							:= filtered_recs(trim(name_orig, left, right)<>''):persist('~thor_200::persist::soff_offender');
											
//export mapping_offender 			:= defendant_filter(length(trim(recordid, left, right))<=16);

export mapping_offender 			:= defendant_filter;