export Out_weekly_report := module

//PhonesFeedback Stats
#workunit('name','PhoneFeedBack Stats');
import didville, did_add, Header_Slimsort, ut, WatchDog, AID;

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

//2010 Online phones

online_2010 := online4(date_time_added >= '20100101' and trim(phone_number,left,right)!='');

online_2013 := online4(date_time_added >= '20130101' and trim(phone_number,left,right)!='');

//Project deduped online records back to original input layout


//Customer Dialer FCRA Data Follows
customer := PhonesFeedback.File_PhonesFeedback_in_fcra_customer;

customer1 := project(customer,transform(PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_in,self.date_time_added := (string) ut.cnvDateStr(LEFT.date_time_added),SELF := LEFT));

//2010 Counts filter
customer1_2010 := customer1(date_time_added >= '20100101' and trim(phone_number,left,right)!='');

//2013 Counts filter

customer1_2013 := customer1(date_time_added >= '20130101' and trim(phone_number,left,right)!='');





//********Outputs

output(count(customer1_2010),named('Total_count_of_batch_phones_from_January_1st_2010_to_present'));

output(count(online_2010),named('Total_count_of_online_phones_from_January_1st_2010_to_present'));

output(count(customer1_2013),named('Total_count_of_batch_phones_YTD_2013'));

output(count(online_2013),named('Total_count_of_online_phones_YTD_2013'));

//2010 batch phones with disposition
customer_sort_2010 := sort(distribute(customer1_2010(trim(phone_number,left,right)!=''),hash32(phone_number)),
                     phone_number,ssn,fname,lname,mname,street_pre_direction,street_post_direction,street_number,street_name,street_suffix,          
                     unit_number,unit_designation,zip5,zip4,city,state,-date_time_added,local);
										 

customer_dedup_2010 := dedup(customer_sort_2010,
				phone_number,ssn,fname,lname,mname,street_pre_direction,street_post_direction,street_number,street_name,street_suffix,          
   unit_number,unit_designation,zip5,zip4,city,state,local);
	 
customer_type_2010 := customer_dedup_2010(phone_contact_type <> '');

output(count(customer_type_2010),named('Total_count_of_current_unique_batch_phones_with_a_disposition_January_1st_2010_to_present'));

//2010 online phones with disposition

ded_online1_2010 := dedup(sort(distribute(online_2010(trim(phone_number,left,right)!=''),hash32(phone_number)),record,local),record,local);

online2_2010 := project(ded_online1_2010,setDate(left));

//Get rid of duplicate phone_feedback_id's retaining the most recent date_time_added
online3_2010 := dedup(sort(distribute(online2_2010,hash32(phone_feedback_id)),phone_feedback_id,-timestamp,local),phone_feedback_id,local);

online_contact_type_2010 := online3_2010(phone_contact_type <> '');
output(count(online_contact_type_2010),named('Total_count_of_current_unique_online_phones_with_a_disposition_January_1st_2010_to_present'));


//2013 batch phones with disposition
customer_sort_2013 := sort(distribute(customer1_2013(trim(phone_number,left,right)!=''),hash32(phone_number)),
                     phone_number,ssn,fname,lname,mname,street_pre_direction,street_post_direction,street_number,street_name,street_suffix,          
                     unit_number,unit_designation,zip5,zip4,city,state,-date_time_added,local);
										 

customer_dedup_2013 := dedup(customer_sort_2013,
				phone_number,ssn,fname,lname,mname,street_pre_direction,street_post_direction,street_number,street_name,street_suffix,          
   unit_number,unit_designation,zip5,zip4,city,state,local);
	 
customer_type_2013 := customer_dedup_2013(phone_contact_type <> '');

output(count(customer_type_2013),named('Total_count_of_current_unique_batch_phones_with_a_disposition_YTD_2013'));

//2013 online phones with disposition

ded_online1_2013 := dedup(sort(distribute(online_2013(trim(phone_number,left,right)!=''),hash32(phone_number)),record,local),record,local);

online2_2013 := project(ded_online1_2013,setDate(left));

//Get rid of duplicate phone_feedback_id's retaining the most recent date_time_added
online3_2013 := dedup(sort(distribute(online2_2013,hash32(phone_feedback_id)),phone_feedback_id,-timestamp,local),phone_feedback_id,local);

online_contact_type_2013 := online3_2013(phone_contact_type <> '');
output(count(online_contact_type_2013),named('Total_count_of_current_unique_online_phones_with_a_disposition_YTD_2013'));

end;
