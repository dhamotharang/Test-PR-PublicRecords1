//PhonesFeedback Stats

import didville, did_add, Header_Slimsort, ut, WatchDog, AID, phonesFeedback;

//***********************************************************************************
baseLayout := phonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base;

//***********************************************************************************
didTempRec := record
	baseLayout;
	temp_suffix := '';
	end;

//***********************************************************************************
inrecLayout := phonesfeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_in;

//***********************************************************************************	
temp_inrecLayout := record
inrecLayout;
string100   prep_addr_line1			:= '';
string50	prep_addr_line_last		:= '';
unsigned8	raw_aid					:=  0;
end;	
	
//***********************************************************************************
tempLayout := record
inrecLayout;
string12 timestamp;
end;

//Sybase FCRA Data Follows (Online - Web)
tempLayout setDate(inrecLayout l) := transform
self.timestamp := phonesFeedback.dateMMMDDYYYY(trim(l.date_time_added,left,right));
self := l;
end;

online1 := PhonesFeedback.File_PhonesFeedback_in_fcra_online;

online4 := project(online1,transform(PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_in,self.date_time_added := (string) ut.cnvDateStr(LEFT.date_time_added),SELF := LEFT));

online5 := online4(date_time_added >= '20130101');

output(count(online5(trim(phone_number,left,right)!='')),named('Total_count_of_online_phones'));



//Get rid of online entire record duplicates to minimize records passed to setDate
ded_online1 := dedup(sort(distribute(online5(trim(phone_number,left,right)!=''),hash32(phone_number)),record,-date_time_added,local),record,local);

output(count(ded_online1),named('Total_count_of_current_unique_online_phones'));

online2 := project(ded_online1,setDate(left));

//Get rid of duplicate phone_feedback_id's retaining the most recent date_time_added
online3 := dedup(sort(distribute(online2,hash32(phone_feedback_id)),phone_feedback_id,-timestamp,local),phone_feedback_id,local);

//Project deduped online records back to original input layout


//Customer Dialer FCRA Data Follows
customer := PhonesFeedback.File_PhonesFeedback_in_fcra_customer;

customer1 := project(customer,transform(PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_in,self.date_time_added := (string) ut.cnvDateStr(LEFT.date_time_added),SELF := LEFT));
customer2 := customer1(date_time_added >= '20130101');


output(count(customer2(trim(phone_number,left,right)!='')),named('Total_count_of_batch_phones'));



//Get rid of customer entire record duplicates disregarding date_time_added
ded_customer_sort := sort(distribute(customer2(trim(phone_number,left,right)!=''),hash32(phone_number)),
                     phone_number,ssn,fname,lname,mname,street_pre_direction,street_post_direction,street_number,street_name,street_suffix,          
                     unit_number,unit_designation,zip5,zip4,city,state,-date_time_added,local);
										 

ded_customer_dedup := dedup(ded_customer_sort,
				phone_number,ssn,fname,lname,mname,street_pre_direction,street_post_direction,street_number,street_name,street_suffix,          
   unit_number,unit_designation,zip5,zip4,city,state,local);
	

output(count(ded_customer_dedup),named('Total_count_of_current_unique_batch_phones'));

ded_customer_type := ded_customer_dedup(phone_contact_type <> '');

output(count(ded_customer_type),named('Total_count_of_current_unique_batch_phones_with_a_disposition'));

ded_online1_type := ded_online1(phone_contact_type <> '');

output(count(ded_online1_type),named('Total_count_of_current_unique_online_phones_with_a_disposition'));

batch_disp := record
string2 contact_type;
string description := '';
end;

batch_cust_type := project(ded_customer_type,transform(batch_disp,self.description := map(LEFT.phone_contact_type = '1' => 'Right Party Contact',
                                                         LEFT.phone_contact_type = '2' => 'Relative or Associate',
																												 LEFT.phone_contact_type = '3' => 'Wrong Party',
																												 LEFT.phone_contact_type = '4' => 'Phone Disconnected',
																												 LEFT.phone_contact_type = '5' => 'No Contact Or Knowledge of Debtor',
																												 LEFT.phone_contact_type = '7' => 'Alternate Phone Provided',
																												 LEFT.phone_contact_type = '8' => 'Other Information Provided',
																												 LEFT.phone_contact_type = '0' => 'n/a','');
																 self.contact_type := left.phone_contact_type;
																 ));
																 
batch_disp2 := record
batch_cust_type.contact_type;
batch_cust_type.description;
count(group);
end;

batch_tab := table(batch_cust_type,batch_disp2,contact_type,description,few);

output(choosen(sort(batch_tab,contact_type),all),named('Batch_Phone_Contact_type_Counts'));

online_disp := record
string2 contact_type;
string description := '';
end;

online_type := project(ded_online1_type,transform(online_disp,self.description := map(LEFT.phone_contact_type = '1' => 'Right Party Contact',
                                                         LEFT.phone_contact_type = '2' => 'Relative or Associate',
																												 LEFT.phone_contact_type = '3' => 'Wrong Party',
																												 LEFT.phone_contact_type = '4' => 'Phone Disconnected',
																												 LEFT.phone_contact_type = '5' => 'No Contact Or Knowledge of Debtor',
																												 LEFT.phone_contact_type = '7' => 'Alternate Phone Provided',
																												 LEFT.phone_contact_type = '8' => 'Other Information Provided',
																												 LEFT.phone_contact_type = '0' => 'n/a','');
																 self.contact_type := left.phone_contact_type;
																 ));
																 
online_disp2 := record
online_type.contact_type;
online_type.description;
count(group);
end;

online_tab := table(online_type,online_disp2,contact_type,description,few);

output(choosen(sort(online_tab,contact_type),all),named('Online_Phone_Contact_type_Counts'));


