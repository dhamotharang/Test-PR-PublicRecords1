import ut;

iu_infiles := PROJECT(			
                      dataset(CanadianPhones.thor_cluster +'base::canadianWP',
										          CanadianPhones.layoutCanadianWhitepagesBase - [global_sid,record_sid],thor)
//infousa files											
									  + dataset(CanadianPhones.thor_cluster +'base::infousaBiz',
											CanadianPhones.layoutCanadianWhitepagesBase - [global_sid,record_sid],thor),
											TRANSFORM(CanadianPhones.layoutCanadianWhitepagesBase,
											          SELF.global_sid := 0;
																SELF.record_sid := 0;
																SELF            := LEFT
											         )
										 );
//iu_infiles has one record per person/phone combination/vendor
											
ax_infiles := PROJECT( 						
//axiom files
									    distribute(dataset(CanadianPhones.thor_cluster +'base::axciomres',
											CanadianPhones.layoutCanadianWhitepagesBase - [global_sid,record_sid],thor)
									  + dataset(CanadianPhones.thor_cluster +'base::axciombus',
											CanadianPhones.layoutCanadianWhitepagesBase - [global_sid,record_sid],thor),hash(phonenumber)),
											TRANSFORM(CanadianPhones.layoutCanadianWhitepagesBase,
											          SELF.global_sid := 0;
																SELF.record_sid := 0;
																SELF            := LEFT
											         )
										 );
//ax_infiles (axciom files) are ff replace but we are keeping history which causes several dupes											

dd_ax := dedup(ax_infiles,phonenumber
					,stringlib.stringtouppercase(lastname)
					,stringlib.stringtouppercase(firstname)
					,stringlib.stringfilter(stringlib.stringtouppercase(company_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890')
					,stringlib.stringtouppercase(vendor),all,local);
//dd_ax = axciom files deduped so that they are one record per person/phone/vendor combination so that they are apples to apples with the infousa files											

dd_infiles:= dedup(sort(distribute(iu_infiles+dd_ax,hash(phonenumber))
					,phonenumber
					,stringlib.stringtouppercase(lastname)
					,stringlib.stringtouppercase(firstname)
					,stringlib.stringfilter(stringlib.stringtouppercase(company_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890')
					,stringlib.stringtouppercase(vendor)
					,local)
					
					,phonenumber
					,stringlib.stringtouppercase(lastname)
					,stringlib.stringtouppercase(firstname)
					,stringlib.stringfilter(stringlib.stringtouppercase(company_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890')
					,left,local);	
					
//The infousa and axciom files are combined and deduped on phone, name, and vendor.  Keeping first so that when there is the existence of matching axciom and infousa records the axciom record is kept.
//due to contractual agreement:  infoUSA records must make up less than 50% of the file.
cmbnd_files := dd_infiles + ax_infiles;

//additional axciom records are added back in and later rolled up.

cmbnd_files tr0(cmbnd_files L) := TRANSFORM
	self.company_name   := stringlib.StringToUpperCase(l.company_name);
	self.firstname	 	:= stringlib.StringToUpperCase(l.firstname);
	self.middlename		:= stringlib.StringToUpperCase(l.middlename);
	self.lastname	    := stringlib.StringToUpperCase(l.lastname);
	self.streetname   := stringlib.StringToUpperCase(l.streetname);
  self.suburbancity  :=  stringlib.StringToUpperCase(l.suburbancity);
  self.postalcity   :=  stringlib.StringToUpperCase(l.postalcity);
  self.city         :=  stringlib.StringToUpperCase(l.city);

SELF := L;
END;

precs := project(cmbnd_files,tr0(left));

precs tr(precs L, precs R) := TRANSFORM
self.Date_last_reported := R.Date_last_reported;
self.pub_date := R.pub_date;
SELF := L;
END;

rlld_infiles:= ROLLUP(sort(precs,phonenumber,Date_first_reported), tr(LEFT, RIGHT), RECORD, EXCEPT Date_first_reported, Date_last_reported,record_id,latitude,longitude) :persist('persist::base::canadianPhones');

export file_CanadianWhitePagesBase := rlld_infiles;
											
											
