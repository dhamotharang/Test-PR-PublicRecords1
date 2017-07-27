import ut;

iu_infiles := 							dataset(CanadianPhones.thor_cluster +'base::canadianWP',
											CanadianPhones.layoutCanadianWhitepagesBase,thor)
									  + dataset(CanadianPhones.thor_cluster +'base::infousaBiz',
											CanadianPhones.layoutCanadianWhitepagesBase,thor);

											
ax_infiles := 						
									    distribute(dataset(CanadianPhones.thor_cluster +'base::axciomres',
											CanadianPhones.layoutCanadianWhitepagesBase,thor)
									  + dataset(CanadianPhones.thor_cluster +'base::axciombus',
											CanadianPhones.layoutCanadianWhitepagesBase,thor),hash(phonenumber));
											
dd_ax := dedup(ax_infiles,phonenumber
					,stringlib.stringtouppercase(lastname)
					,stringlib.stringtouppercase(firstname)
					,stringlib.stringfilter(stringlib.stringtouppercase(company_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890')
					,stringlib.stringtouppercase(vendor),all);
											
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
//contractual agreement:  infoUSA records must make up less than 50% of the file.
cmbnd_files := dd_infiles + ax_infiles;

cmbnd_files tr(cmbnd_files L, cmbnd_files R) := TRANSFORM
self.Date_last_reported := R.Date_last_reported;
self.pub_date := R.pub_date;
SELF := L;
END;

rlld_infiles:= ROLLUP(sort(cmbnd_files,phonenumber,Date_first_reported), tr(LEFT, RIGHT), RECORD, EXCEPT Date_first_reported, Date_last_reported,record_id,latitude,longitude) :persist(CanadianPhones.thor_cluster +'persist::base::canadianPhones');

export file_CanadianWhitePagesBase := rlld_infiles;
											
											