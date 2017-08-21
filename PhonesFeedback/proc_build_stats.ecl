import didville, did_add, Header_Slimsort, ut, WatchDog;
export proc_build_stats ( string4 yr) := function

integer yearint := (integer) yr;
baseLayout := phonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base;
outrec := record
	baseLayout;
	string10 src_type;
 string	temp_suffix := '';
	end;

inrecLayout := phonesfeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_in;
	
tempLayout := record
inrecLayout;
string12 timestamp;
string10 src_type;
end;


//Sybase FCRA Data Follows (Online- Web)
tempLayout setDate(inrecLayout l) := transform
self.timestamp := phonesFeedback.dateMMMDDYYYY(trim(l.date_time_added,left,right));
self.src_type := 'online';
self := l;
end;

online1 := PhonesFeedback.File_PhonesFeedback_in_fcra_online;

online2 := project(online1,setDate(left));

online := dedup(sort(online2,phone_feedback_id,-timestamp),phone_feedback_id);


//Customer Dialer FCRA Data Follows
cust1 := PhonesFeedback.File_PhonesFeedback_in_fcra_customer;

tempLayout setDate_cust(inrecLayout l) := transform
self.timestamp := phonesFeedback.dateMMMDDYYYY(trim(l.date_time_added,left,right));
self.src_type := 'customer';
self := l;
end;

customer := project(cust1,setDate_cust(LEFT));

bothInput := distribute(online + customer,hash(phone_number));

allInput := dedup(sort(bothInput,record, except date_time_added,local),record,except date_time_added,local);

outrec trans(allInput input) := transform
	self.did          := (unsigned6) input.did;
	self.phone_number := stringlib.stringfilter(input.phone_number,'0123456789');
	self              := input;
	end;
				
allData      := project(allInput,trans(left));

//Convert date time added to YYYMMDD
cnvdate := project(allData,transform(outrec,self.date_time_added := (string) ut.cnvDateStr(LEFT.date_time_added),SELF := LEFT));

all_src := sort(cnvdate,record, except date_time_added) : persist('~thor_data400::persist::phonesfeedback_stats');

//Batch Customers Stats

Out_cust_base := all_src(src_type = 'customer');

Output(count(Out_cust_base),named('Total_Batch_Customer_Count'));

//By contact type for yr

Out_cust_base_yearint := Out_cust_base ( date_time_added[1..4] = yr );
Layout_batch_cust_yearint := record
Out_cust_base_yearint.phone_contact_type;
count(group);
end;

Tot_by_contact_yearint := sort(table(Out_cust_base_yearint,Layout_batch_cust_yearint,phone_contact_type,few),phone_contact_type);
output(choosen(Tot_by_contact_yearint,10),named('Total_Customer_Counts_Contact_type_yearint'));




custname_rec := record
outrec;
string150 CustomerName := '';
end;

custname_rec tCustName(Out_cust_base l) := transform
self.CustomerName := map(l.customerid = '1005590' => 'Asset Acceptance',
                         l.customerid = '1017750' => 'First Financial Asset Management',
												 l.customerid = '1018002' => 'Monarch Recovery Management, Inc',
												 l.customerid = '1006061'  => 'Accurint-- Developers(Accutrac and Plaza)',
												 l.customerid = '1007664' => 'Plaza',
												 l.customer_id = '1429844' => 'Rozlin',
												 l.customer_id = '1005391' => 'Zenith',
												 l.feedbacksource = '24'   =>   'Protocol',
												 l.feedback_source = '25'   =>  'Monarch',
												 l.customer_id <> '1429844' and l.customer_id <> '1005391' and l.date_time_added[1..4] > '2012' => 'NCO','');
self := l;
end;

Tot_Cust_count := project(Out_cust_base,tCustName(LEFT));



Cust_count_yearint := Tot_Cust_count(date_time_added[1..4] = yr and CustomerName <> '');

cust_yr_rec := record
Cust_count_yearint.CustomerName;
count(group);
end;

Tot_Cust_count_yearint := table(sort(Cust_count_yearint,CustomerName),cust_yr_rec,CustomerName,few);

Cust_Count_yearint_all := output(choosen(Tot_Cust_count_yearint,10),named('Total_Customer_Counts_yearint'));



//Online counts
Out_Online_base := all_src(src_type = 'online');

Tot_Online_cnt_yearint := Out_Online_base(date_time_added[1..4] = yr );

Online_Count_yearint_all := output(count(Tot_Online_cnt_yearint),named('Total_Online_Counts_yearint'));



return sequential(	Cust_Count_yearint_all,Online_Count_yearint_all);
end;
