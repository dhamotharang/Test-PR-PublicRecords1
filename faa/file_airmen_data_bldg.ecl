import ut, header_services, faa;

ds := dataset(ut.foreign_prod+'~thor_data400::base::faa_airmen_building',faa.layout_airmen_data_out,flat);

header_services.Supplemental_Data.mac_verify('file_faa_inj.thor',faa.layout_airmen_data_out,attr);
 
supp_data_in := attr();

start := max(ds,(unsigned)unique_id);

faa.layout_airmen_data_out add_id(faa.layout_airmen_data_out l) := transform
	self.unique_id := intformat(start + (unsigned)l.unique_id,7,1);
  self := l;
end;

supp_data := project(supp_data_in, add_id(left));

f := ds + supp_data;

// Add persistent record id 

ded_outseq :=dedup(sort( project (f, transform({f}, self.zip_code := trim(left.zip_code,left,right),
self.current_flag :=trim(left.current_flag,left,right) ,
 self.record_type :=  trim(left.record_type,left,right),
 self.letter_code :=  trim(left.letter_code,left,right) ,
 self.unique_id :=  trim(left.unique_id,left,right) ,
 self.orig_rec_type :=  trim(left.orig_rec_type,left,right) ,
 self.orig_fname :=  trim(left.orig_fname,left,right),
 self.orig_lname :=  trim(left.orig_lname,left,right) ,
self.street1 :=   trim(left.street1,left,right) ,
 self.street2 :=  trim(left.street2,left,right) ,
 self.city :=  trim(left.city,left,right) ,
  self.state := trim(left.state,left,right) ,
 self.country :=  trim(left.country,left,right) ,
 self.region :=  trim(left.region,left,right),
 self.med_class :=  trim( left.med_class,left,right) ,
 self.med_date :=  trim(left.med_date,left,right) ,
 self.med_exp_date := trim(left.med_exp_date,left,right),
 self.best_ssn := trim(left.best_ssn,left,right), 
 self.did_out := trim(left.did_out,left,right), self:= left)),current_flag,record_type,letter_code,unique_id,orig_rec_type,orig_fname,orig_lname,street1,street2,city,state,zip_code,country,region,med_class,med_date,med_exp_date,-date_last_seen) ,except date_first_seen, date_last_seen); 

outf:= project( ded_outseq, transform({faa.layout_airmen_Persistent_ID },
	                                 
																	 self.persistent_record_id :=hash64(trim(left.current_flag,left,right) +','+
   trim(left.record_type,left,right) +','+
   trim(left.letter_code,left,right) +','+
   trim(left.unique_id,left,right) +','+
   trim(left.orig_rec_type,left,right) +','+
   trim(left.orig_fname,left,right) +','+
   trim(left.orig_lname,left,right) +','+
   trim(left.street1,left,right) +','+
   trim(left.street2,left,right) +','+
   trim(left.city,left,right) +','+
   trim(left.state,left,right) +','+
   trim(left.zip_code,left,right) +','+
   trim(left.country,left,right) +','+
   trim(left.region,left,right) +','+
   trim( left.med_class,left,right) +','+
   trim(left.med_date,left,right) +','+
  trim(left.med_exp_date,left,right) ) , self := left));
	
export file_airmen_data_bldg := outf;