import ut, iBehavior;

export sampleRecords(string version) := function

samplefile := topn(iBehavior.files.File_consumer, 100, -process_date,-date_last_seen);


//consumer samples
consumer_base := iBehavior.files.file_consumer(trim(primary_phone_number) <> '');
consumer_base_father := dataset('~thor_data400::base::ibehavior_consumer_father',iBehavior.layouts.Layout_consumer,flat)(trim(primary_phone_number) <> '');

dist_base := distribute(consumer_base,HASH32(ib_individual_id,ib_household_id,primary_phone_number));
dist_base_father := distribute(consumer_base_father,HASH32(ib_individual_id,ib_household_id,primary_phone_number));
ibehavior.layouts.layout_consumer join_consumer_tr(dist_base l,dist_base_father r) := transform
self := l;
end;


join_consumer := join(dist_base,dist_base_father,
                        LEFT.ib_individual_id = RIGHT.ib_individual_id 
                        AND LEFT.ib_household_id = RIGHT.ib_household_id,
                        join_consumer_tr(LEFT,RIGHT),LEFT ONLY,local);

samplefile1 := choosen(join_consumer,100);


//purchase samples
purchase_base := ibehavior.files.File_behavior(trim(first_order_date) <> '' and trim(first_online_order_date) <> '');
purchase_base_father := dataset('~thor_data400::base::ibehavior_behavior_father',iBehavior.layouts.layout_behavior,flat)(trim(first_order_date) <> '' and trim(first_online_order_date) <> '');

dist_base_purch := distribute(purchase_base,HASH32(ib_individual_id,ib_household_id));
dist_base_father_purch := distribute(purchase_base_father,HASH32(ib_individual_id,ib_household_id));

iBehavior.layouts.layout_behavior join_purch_tr(dist_base_purch l,dist_base_father_purch r) := transform
self := l;
end;

join_purch := join(dist_base_purch,dist_base_father_purch,
                    LEFT.ib_individual_id = RIGHT.ib_individual_id 
                    AND LEFT.ib_household_id = RIGHT.ib_household_id,
                    join_purch_tr(LEFT,RIGHT),LEFT ONLY,local);

samplefile2 := choosen(join_purch,100);


sampleout:=  sequential(
                        output(samplefile,named('SampleNewRecordsForQA')),
                        output(samplefile1,named('SampleConsumerRecordsForQA')),
                        output(samplefile2,named('SamplePurchaseRecordsForQA'))
                      );

return sampleout;

end;

