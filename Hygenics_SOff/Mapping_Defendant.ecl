import ut, lib_stringlib;

//Fix Oregon Sex Offenders
//hyg_ORSOR 	:= sort(hygenics_soff.File_In_SO_Defendant(sourcename='OREGON_SEX_OFFENDER_REGISTRY'), lastname, firstname, dob);
//hyg_ORWSOR 	:= sort(hygenics_soff.File_In_SO_Defendant(sourcename='OREGON_WEB_SEX_OFFENDER_REGISTRY'), lastname, firstname, dob);
hyg_Remain	:= hygenics_soff.File_In_SO_Defendant(sourcename not in ['OREGON_SEX_OFFENDER_REGISTRY']);
all_defend	:= hyg_Remain;

//Defendant Input File
ds_d 			:= distribute(all_defend, hash(RecordID));

	ds_d appendSemi(ds_d l):= transform
		self.defendantadditionalinfo := if(l.defendantadditionalinfo<>'' and l.defendantadditionalinfo[length(l.defendantadditionalinfo)]<>';',
												l.defendantadditionalinfo+';',
												l.defendantadditionalinfo);
		self := l;
	end; 

ds_d1			:= project(ds_d, appendSemi(left));

//Alias Input File
ds_d2 			:= dedup(sort(distribute(hygenics_soff.file_in_so_alias,hash(RecordID, akaname)), recordid, akaname, local), recordid, akaname, local);

	//Populate akaDOB
	akadobLayout := record
		ds_d1;
		string akadob;
	end;
	
	akadobLayout fixDef(ds_d1 l):= transform
		self.akadob 	:= '';
		self 			:= l;
	end;
	
	def 		:= distribute(project(ds_d1, fixDef(left)), hash(recordid));
	defendt_ds  := sort(def, RecordID,local);
	
	//Populate DOB
	dobLayout := record
		ds_d2;
		string dob;
	end;
	
	dobLayout fixAlias(ds_d2 l):= transform
		self.dob 	:= '';
		self 		:= l;
	end;
	
	alias 		:= project(ds_d2, fixAlias(left));
	alias_ds 	:= sort(distribute(alias,hash(recordid)), recordid, local);
	
	//Map Aliases
	akadobLayout transformds(defendt_ds L, alias_ds R) := transform
		
		//filter out akas where they are the same as the primary
		self.Name		:= if(stringlib.StringToUpperCase(r.AKAName)<>'' and stringlib.StringToUpperCase(r.AKAName) <> stringlib.StringToUpperCase(l.Name),
								stringlib.StringToUpperCase(r.AKAName),
								'');
		self.LastName	:= if(stringlib.StringToUpperCase(r.AKALastName)<>'' and stringlib.StringToUpperCase(r.AKAName) <> stringlib.StringToUpperCase(l.Name),
								stringlib.StringToUpperCase(r.AKALastName),
								'');
		self.FirstName	:= if(stringlib.StringToUpperCase(r.AKAFirstName)<>'' and stringlib.StringToUpperCase(r.AKAName) <> stringlib.StringToUpperCase(l.Name),
								stringlib.StringToUpperCase(r.AKAFirstName),
								'');
		self.MiddleName	:= if(stringlib.StringToUpperCase(r.AKAMiddleName) not in ['', 'NMN ', 'NMI '] and stringlib.StringToUpperCase(r.AKAName) <> stringlib.StringToUpperCase(l.Name),
								stringlib.StringToUpperCase(r.AKAMiddleName),
								'');
		self.Suffix		:= if(stringlib.StringToUpperCase(r.AKASuffix)<>'' and stringlib.StringToUpperCase(r.AKAName) <> stringlib.StringToUpperCase(l.Name),
								stringlib.StringToUpperCase(r.AKASuffix),
								'');
		self.DOB		:= if(((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)l.dob[1..4])>=18 and l.dob[1..2] in ['19','20'],
								trim(l.dob, left, right),
								'');
		self.akadob		:= if(((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)r.akadob[1..4])>=18 and r.akadob[1..2] in ['19','20'],
								r.akadob, 
								'');
		self.Nametype	:= '2';
		self			:= l;
	end;

	alias_recs	:= join(defendt_ds, alias_ds,
						left.RecordID = right.RecordID and
						left.statecode = right.statecode,
						transformds(left,right),
						local)(name<>'');
	
	//Join Defendants + Aliases;
	def_r	:= defendt_ds + alias_recs :persist('~thor200_144::in::sex_offender::hd::defendant_all1');
	output(count(def_r), named('def_r'));
		
	//AKA DOB values to Primary Name Records
	sort_defend_recs:= sort(defendt_ds, recordid);
	dedup_alias_recs:= dedup(sort(alias_recs(akadob<>''), recordid)); 
	
	akadobLayout addAKADOB(sort_defend_recs l, dedup_alias_recs r):= transform
		self.akadob := if(l.nametype<>'2' and r.akadob<>'',
							r.akadob,
							'');
		self := l;
	end;
	
	def_ds := dedup(sort(join(sort_defend_recs, dedup_alias_recs,
					left.recordid = right.recordid,
					addAKADOB(left, right), left outer), recordid, name, lastname, firstname, middlename, dob, -akadob), except akadob) :persist('~thor200_144::in::sex_offender::hd::defendant_dedup'); //remove duplicates with blank dobs
					
	def_recs := def_ds + alias_recs;
	output(count(def_recs), named('def_recs'));
	
	addFields := record
		Hygenics_Soff.Layout_In_Offender;
		string LastName;
		string FirstName;
		string MiddleName;
		string Suffix;
		string NameType;
		string Recordid;
		string src_upload_date;
	end;

//Map to Offender Fields////////////////////////////////////
	addFields refOff(def_recs l):= transform
			
		//Pull Data from DefendantAdditionalInfo///////////////////////////////////////////////////
			county				:= if(regexfind('COUNTY:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'COUNTY:', 1)+8..(stringlib.stringfind(l.defendantadditionalinfo, 'COUNTY:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'COUNTY:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										l.county);
								
			corrective_lenses	:= if(regexfind('CORRECTIVE LENSES:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'CORRECTIVE LENSES:', 1)+19..(stringlib.stringfind(l.defendantadditionalinfo, 'CORRECTIVE LENSES:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'CORRECTIVE LENSES:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
								
			date_verification	:= if(regexfind('DATE OF LAST VERIFICATION:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'DATE OF LAST VERIFICATION:', 1)+27..(stringlib.stringfind(l.defendantadditionalinfo, 'DATE OF LAST VERIFICATION:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'DATE OF LAST VERIFICATION:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
								
			drivers_license_no	:= if(regexfind('DRIVERS LICENSE NUMBER:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'DRIVERS LICENSE NUMBER:', 1)+24..(stringlib.stringfind(l.defendantadditionalinfo, 'DRIVERS LICENSE NUMBER:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'DRIVERS LICENSE NUMBER:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										l.dlnumber);
								
			drivers_license_st	:= if(regexfind('DRIVERS LICENSE STATE:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'DRIVERS LICENSE STATE:', 1)+23..(stringlib.stringfind(l.defendantadditionalinfo, 'DRIVERS LICENSE STATE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'DRIVERS LICENSE STATE:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										l.dlstate);
												
			employer			:= if(regexfind('EMPLOYER:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER:', 1)+10..(stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('EMPLOYER ADDRESSES:', l.defendantadditionalinfo, 0)<>'' and l.statecode='IN',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ADDRESSES:', 1)+20..(stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ADDRESSES:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ADDRESSES:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('REGISTERED EMPLOYERS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTERED EMPLOYERS:', 1)+22..(stringlib.stringfind(l.defendantadditionalinfo, 'REGISTERED EMPLOYERS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTERED EMPLOYERS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'')));
									
			employer_address	:= if(regexfind('EMPLOYER ADDRESSES:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ADDRESSES:', 1)+20..(stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ADDRESSES:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ADDRESSES:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('EMPLOYER ADDRESS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ADDRESS:', 1)+18..(stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ADDRESS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ADDRESS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('EMPLOYMENT ADDRESS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYMENT ADDRESS:', 1)+20..(stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYMENT ADDRESS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYMENT ADDRESS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('WORK ADDRESS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'WORK ADDRESS:', 1)+14..(stringlib.stringfind(l.defendantadditionalinfo, 'WORK ADDRESS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'WORK ADDRESS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										''))));
									
			employer_state		:= if(regexfind('EMPLOYER STATE:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER STATE:', 1)+16..(stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER STATE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER STATE:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
								
			employer_zip		:= if(regexfind('EMPLOYER ZIP:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ZIP:', 1)+14..(stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ZIP:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYER ZIP:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
								
			employment		 	:= if(regexfind('EMPLOYMENT:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYMENT:', 1)+12..(stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYMENT:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EMPLOYMENT:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
								
			finger_print		:= if(regexfind('FINGER PRINT:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'FINGER PRINT:', 1)+14..(stringlib.stringfind(l.defendantadditionalinfo, 'FINGER PRINT:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'FINGER PRINT:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
														
			incarcerated		:= if(regexfind('INCARCERATED:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'INCARCERATED:', 1)+14..(stringlib.stringfind(l.defendantadditionalinfo, 'INCARCERATED:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'INCARCERATED:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
		
			occupation 		:= if(regexfind('OCCUPATION:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'OCCUPATION:', 1)+12..(stringlib.stringfind(l.defendantadditionalinfo, 'OCCUPATION:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'OCCUPATION:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
									
			offender_category	:= if(regexfind('ABSCONDER/PREDATOR:', l.defendantadditionalinfo, 0)<>'' and trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'ABSCONDER/PREDATOR:', 1)+19..(stringlib.stringfind(l.defendantadditionalinfo, 'ABSCONDER/PREDATOR:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'ABSCONDER/PREDATOR:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right)='YES',
										'PREDATOR',
									if(regexfind('OFFENDER TYPE:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'OFFENDER TYPE:', 1)+14..(stringlib.stringfind(l.defendantadditionalinfo, 'OFFENDER TYPE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'OFFENDER TYPE:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),		
									if(regexfind('WANTED:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'WANTED:', 1)..(stringlib.stringfind(l.defendantadditionalinfo, 'WANTED:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'WANTED:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),	
									if(l.defendantstatus<>'' and l.statecode in ['FL','IL','KS','OH','TN'],
										trim(l.defendantstatus, left, right),
										''))));				
			
			operated_vehicle	:= if(regexfind('OPERATED VEHICLE:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'OPERATED VEHICLE:', 1)+18..(stringlib.stringfind(l.defendantadditionalinfo, 'OPERATED VEHICLE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'OPERATED VEHICLE:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
								
			other				:= if(regexfind('OTHER:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'OTHER:', 1)+7..(stringlib.stringfind(l.defendantadditionalinfo, 'OTHER:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'OTHER:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
								
			owned_vehicle		:= if(regexfind('OWNED VEHICLE:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'OWNED VEHICLE:', 1)+15..(stringlib.stringfind(l.defendantadditionalinfo, 'OWNED VEHICLE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'OWNED VEHICLE:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
								
			palm_print			:= if(regexfind('PALM PRINT:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PALM PRINT:', 1)+12..(stringlib.stringfind(l.defendantadditionalinfo, 'PALM PRINT:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PALM PRINT:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');	
			
			photodate			:= if(regexfind('PHOTO LAST UPDATED:', l.defendantadditionalinfo, 0)<>'',		
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO LAST UPDATED:', 1)+19..(stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO LAST UPDATED:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO LAST UPDATED:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
										
			fix_ph_date 		:= if(stringlib.stringfind(photodate,'/',1)=3,
										photodate[7..10]+photodate[1..2]+photodate[4..5],
										'');
			
			photo_date			:= if(regexfind('PHOTO DATE:', l.defendantadditionalinfo, 0)<>'' and regexfind('[A-Z]+', l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1)+12..(stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)],0)<>'',
										hygenics_soff._functions.fn_dateMMMDDYYYY(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1)+12..(stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)]),
									if(regexfind('PHOTO DATE:', l.defendantadditionalinfo, 0)<>'',	
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1)+12..(stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),	
									if(regexfind('PHOTODATE:', l.defendantadditionalinfo, 0)<>'' and regexfind('[A-Z]+', l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTODATE:', 1)+12..(stringlib.stringfind(l.defendantadditionalinfo, 'PHOTODATE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTODATE:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)],0)<>'',
										hygenics_soff._functions.fn_dateMMMDDYYYY(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTODATE:', 1)+12..(stringlib.stringfind(l.defendantadditionalinfo, 'PHOTODATE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTODATE:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)]),
									if(regexfind('PHOTODATE:', l.defendantadditionalinfo, 0)<>'',	
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTODATE:', 1)+12..(stringlib.stringfind(l.defendantadditionalinfo, 'PHOTODATE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTODATE:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										fix_ph_date))));
									
			place_of_birth		:= if(regexfind('PLACE OF BIRTH:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PLACE OF BIRTH:', 1)+16..(stringlib.stringfind(l.defendantadditionalinfo, 'PLACE OF BIRTH:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PLACE OF BIRTH:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
								
			police_agency		:= if(regexfind('SUPERVISING AGENCY:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SUPERVISING AGENCY:', 1)+20..(stringlib.stringfind(l.defendantadditionalinfo, 'SUPERVISING AGENCY:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SUPERVISING AGENCY:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
			
			prof_licenses		:= if(regexfind('PROFESSIONAL LICENSES:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PROFESSIONAL LICENSES:', 1)+23..(stringlib.stringfind(l.defendantadditionalinfo, 'PROFESSIONAL LICENSES:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PROFESSIONAL LICENSES:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
												
			registration_exp_dt	:= if(regexfind('REGISTRATION EXPIRATION DATE:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATION EXPIRATION DATE:', 1)+30..(stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATION EXPIRATION DATE:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATION STATUS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');
								
			registration_length	:= if(regexfind('LENGTH OF REGISTRATION:', l.defendantadditionalinfo, 0)<>'',
											trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'LENGTH OF REGISTRATION:', 1)+23..(stringlib.stringfind(l.defendantadditionalinfo, 'LENGTH OF REGISTRATION:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'LENGTH OF REGISTRATION:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										if(regexfind('REGISTRATION DURATION:', l.defendantadditionalinfo, 0)<>'', 	
											trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATION DURATION:', 1)+22..(stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATION DURATION:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATION DURATION:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
											''));
										
			registration_type	:= if(l.defendantstatus<>'' and l.statecode in ['PA'],
															trim(l.defendantstatus, left, right),
														if(regexfind('REGEND:', l.defendantadditionalinfo, 0)<>'' and l.statecode in ['WI'],
															trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGEND:', 1)+7..(stringlib.stringfind(l.defendantadditionalinfo, 'REGEND:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGEND:', 1)..length(l.defendantadditionalinfo)], ']', 1)-2)], left, right),
															''));			

			residency		 	:= if(regexfind('RESIDENCY:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'RESIDENCY:', 1)+11..(stringlib.stringfind(l.defendantadditionalinfo, 'RESIDENCY:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'RESIDENCY:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');	
			
			risk_level_code		:= if(regexfind('SO RISK LEVEL:', l.defendantstatus, 0)<>'',// and trim(l.statecode, left, right) in ['AR','IA','LA','MT','NV','TX','WA'],
										trim(l.defendantstatus, left, right)[15..],
										'');

			risk_level_description	:= if(regexfind('SO RISK LEVEL:', l.defendantstatus, 0)<>'',// and trim(l.statecode, left, right) in ['AZ','DE','ND','NY'],
										trim(l.defendantstatus, left, right),//[15..],
										'');

			school 				:= if(regexfind('SCHOOL:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL:', 1)+8..(stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('SCHOOLS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOLS:', 1)+9..(stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOLS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOLS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('SCHOOL ATTENDING:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL ATTENDING:', 1)+18..(stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL ATTENDING:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL ATTENDING:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('HIGHER EDUCATION:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'HIGHER EDUCATION:', 1)+18..(stringlib.stringfind(l.defendantadditionalinfo, 'HIGHER EDUCATION:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'HIGHER EDUCATION:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('EDUCATION:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EDUCATION:', 1)+11..(stringlib.stringfind(l.defendantadditionalinfo, 'EDUCATION:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'EDUCATION:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'')))));
								
			school_address		:= if(regexfind('SCHOOL ADDRESS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL ADDRESS:', 1)+16..(stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL ADDRESS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL ADDRESS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('SCHOOL ADDRESSES:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL ADDRESSES:', 1)+18..(stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL ADDRESSES:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'SCHOOL ADDRESSES:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										''));
								
			status 				:= if(regexfind('ADDITIONAL STATUS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'ADDITIONAL STATUS:', 1)+18..(stringlib.stringfind(l.defendantadditionalinfo, 'ADDITIONAL STATUS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'ADDITIONAL STATUS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),		
									if(regexfind('COMPLIANCE STATUS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'COMPLIANCE STATUS:', 1)+18..(stringlib.stringfind(l.defendantadditionalinfo, 'COMPLIANCE STATUS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'COMPLIANCE STATUS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('COMPLIANT:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'COMPLIANT:', 1)+11..(stringlib.stringfind(l.defendantadditionalinfo, 'COMPLIANT:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'COMPLIANT:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('COMPLIANT:', l.defendantadditionalinfo, 0)<>'' and l.statecode = 'WI',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'COMPLIANT:', 1)+11..length(l.defendantadditionalinfo)], left, right),	
									if(regexfind('OTHER:', l.defendantadditionalinfo, 0)<>'' and l.statecode = 'CO',
										regexreplace('OTHER:', l.defendantadditionalinfo, ''),
									if(regexfind('REGISTRANT STATUS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRANT STATUS:', 1)+18..(stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRANT STATUS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRANT STATUS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('REGISTRATION STATUS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATION STATUS:', 1)+20..(stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATION STATUS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATION STATUS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('REGISTRATIONSTATUS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATIONSTATUS:', 1)+19..(stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATIONSTATUS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'REGISTRATIONSTATUS:', 1)..length(l.defendantadditionalinfo)], ']', 1)-2)], left, right),										
									if(regexfind('THIS OFFENDER IS REQUIRED UNDER A.S. 12.63.010 TO REGISTER WITH THE SEX OFFENDER/CHILD KIDNAPPER REGISTRATION PROGRAM AND IS IN COMPLIANCE WITH THE REGISTRATION REQUIREMENTS.', l.defendantadditionalinfo, 0)<>'',
										'COMPLIANT',
									if(regexfind('STATUS:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'STATUS:', 1)+7..(stringlib.stringfind(l.defendantadditionalinfo, 'STATUS:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'STATUS:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('VIOLATION:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'VIOLATION:', 1)+8..(stringlib.stringfind(l.defendantadditionalinfo, 'VIOLATION:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'VIOLATION:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
									if(regexfind('ABSCONDER/PREDATOR:', l.defendantadditionalinfo, 0)<>'' and trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'ABSCONDER/PREDATOR:', 1)+19..(stringlib.stringfind(l.defendantadditionalinfo, 'ABSCONDER/PREDATOR:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'ABSCONDER/PREDATOR:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right)='YES',
										'ABSCONDER',
									if(regexfind('INCARCERATED:', l.defendantadditionalinfo, 0)<>'' and trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'INCARCERATED:', 1)+13..(stringlib.stringfind(l.defendantadditionalinfo, 'INCARCERATED:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'INCARCERATED:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right)='YES',
										'INCARCERATED',
										'')))))))))))));										

			vehicle_desc		:= if(regexfind('VEHICLE DESC:', l.defendantadditionalinfo, 0)<>'',
										trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'VEHICLE DESC:', 1)+14..(stringlib.stringfind(l.defendantadditionalinfo, 'VEHICLE DESC:', 1) + stringlib.stringfind(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'VEHICLE DESC:', 1)..length(l.defendantadditionalinfo)], ';', 1)-2)], left, right),
										'');

		self.recordid							:= l.recordid;
		self.source   							:= map(trim(l.sourcename, left, right) = 'ALABAMA_SEX_OFFENDER_REGISTRY' 				=> 'AL_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'ALASKA_SEX_OFFENDER_REGISTRY' 				=> 'AK_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'ARIZONA_SEX_OFFENDER_REGISTRY' 				=> 'AZ_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'ARKANSAS_SEX_OFFENDER_REGISTRY' 				=> 'AR_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'CALIFORNIA_SEX_OFFENDER_REGISTRY' 			=> 'CA_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'COLORADO_SEX_OFFENDER_REGISTRY' 				=> 'CO_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'CONNECTICUT_SEX_OFFENDER_REGISTRY' 			=> 'CT_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'DELAWARE_SEX_OFFENDER_REGISTRY' 				=> 'DE_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'DISTRICT_OF_COLUMBIA_SEX_OFFENDER_REGISTRY' 	=> 'DC_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'FLORIDA_SEX_OFFENDER_REGISTRY' 				=> 'FL_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'GEORGIA_SEX_OFFENDER_REGISTRY' 				=> 'GA_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'HAWAII_SEX_OFFENDER_REGISTRY' 				=> 'HI_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'IDAHO_SEX_OFFENDER_REGISTRY' 				=> 'ID_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'ILLINOIS_SEX_OFFENDER_REGISTRY' 				=> 'IL_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'INDIANA_SEX_OFFENDER_REGISTRY' 				=> 'IN_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'IOWA_SEX_OFFENDER_REGISTRY' 					=> 'IA_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'KANSAS_SEX_OFFENDER_REGISTRY' 				=> 'KS_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'KENTUCKY_SEX_OFFENDER_REGISTRY' 				=> 'KY_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'LOUISIANA_SEX_OFFENDER_REGISTRY' 			=> 'LA_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'MAINE_SEX_OFFENDER_REGISTRY' 				=> 'ME_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'MARYLAND_SEX_OFFENDER_REGISTRY' 				=> 'MD_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'MASSACHUSETTS_SEX_OFFENDER_REGISTRY' 		=> 'MA_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'MICHIGAN_SEX_OFFENDER_REGISTRY' 				=> 'MI_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'MINNESOTA_SEX_OFFENDER_REGISTRY' 			=> 'MN_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'MISSISSIPPI_SEX_OFFENDER_REGISTRY' 			=> 'MS_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'MISSOURI_SEX_OFFENDER_REGISTRY' 				=> 'MO_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'MONTANA_SEX_OFFENDER_REGISTRY' 				=> 'MT_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'NEBRASKA_SEX_OFFENDER_REGISTRY' 				=> 'NE_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'NEVADA_SEX_OFFENDER_REGISTRY' 				=> 'NV_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'NEW_HAMPSHIRE_SEX_OFFENDER_REGISTRY' 		=> 'NH_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'NEW_JERSEY_SEX_OFFENDER_REGISTRY' 			=> 'NJ_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'NEW_MEXICO_SEX_OFFENDER_REGISTRY' 			=> 'NM_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'NEW_YORK_SEX_OFFENDER_REGISTRY' 				=> 'NY_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'NORTH_CAROLINA_WEB_SEX_OFFENDER_REGISTRY' 	=> 'NC_WEB_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'NORTH_DAKOTA_SEX_OFFENDER_REGISTRY' 			=> 'ND_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'OHIO_SEX_OFFENDER_REGISTRY' 					=> 'OH_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'OKLAHOMA_SEX_OFFENDER_REGISTRY' 				=> 'OK_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'OREGON_SEX_OFFENDER_REGISTRY' 				=> 'OR_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'PENNSYLVANIA_SEX_OFFENDER_REGISTRY' 			=> 'PA_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'RHODE_ISLAND_SEX_OFFENDER_REGISTRY' 			=> 'RI_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'SOUTH_CAROLINA_SEX_OFFENDER_REGISTRY' 		=> 'SC_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'SOUTH_DAKOTA_SEX_OFFENDER_REGISTRY' 			=> 'SD_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'TENNESSEE_SEX_OFFENDER_REGISTRY' 			=> 'TN_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'TEXAS_SEX_OFFENDER_REGISTRY' 				=> 'TX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'UTAH_SEX_OFFENDER_REGISTRY' 					=> 'UT_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'VERMONT_SEX_OFFENDER_REGISTRY' 				=> 'VT_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'VIRGINIA_SEX_OFFENDER_REGISTRY' 				=> 'VA_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'WASHINGTON_SEX_OFFENDER_REGISTRY' 			=> 'WA_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'WEST_VIRGINIA_SEX_OFFENDER_REGISTRY' 		=> 'WV_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'WISCONSIN_SEX_OFFENDER_REGISTRY' 			=> 'WI_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'WYOMING_SEX_OFFENDER_REGISTRY' 				=> 'WY_SEX_OFFENDER_REGISTRY',
														trim(l.sourcename, left, right) = 'NEVADA_VEGAS_SEX_OFFENDER_REGISTRY' 				=> 'NV_VEGAS_SEX_OFFENDER_REGISTRY',													
                            trim(l.sourcename, left, right) = 'ALABAMA-COUSHATTA_TRIBES_OF_TEXAS_SEX_OFFENDER_REGISTRY' => 'AL_COUSHATTA_TRIBES_OF_TX_SOR',
														trim(l.sourcename, left, right) = 'CHEYENNE_RIVER_SIOUX_TRIBE_SEX_OFFENDER_REGISTRY' => 'CHEYENNE_RIVER_SIOUX_TRIBE_SOR',
														trim(l.sourcename, left, right) = 'COLORADO_BUREAU_OF_INVESTIGATION_SEX_OFFENDER_REGISTRY' 	=> 'CO_BUREAU_OF_INVESTIGATION_SOR',
														trim(l.sourcename, left, right) = 'COLORADO_SOTAR_SEX_OFFENDER_REGISTRY'	=> 'CO_SOTAR_SOR',
														trim(l.sourcename, left, right) = 'KAIBAB_PAIUTE_TRIBE_SEX_OFFENDER_REGISTRY' => 'KAIBAB_PAIUTE_TRIBE_SOR',
														trim(l.sourcename, left, right) = 'LUMMI_NATION_SEX_OFFENDER_REGISTRY' => 'LUMMI_NATION_SOR',
														trim(l.sourcename, left, right) = 'MUSCOGEE_CREEK_NATION_SEX_OFFENDER_REGISTRY'	=> 'MUSCOGEE_CREEK_NATION_SOR',
														trim(l.sourcename, left, right) = 'PUEBLO_OF_SANTO_DOMINGO_SEX_OFFENDER_REGISTRY'	=> 'PUEBLO_OF_SANTO_DOMINGO_SOR',
														trim(l.sourcename, left, right) = 'UTE_INDIAN_TRIBE_SEX_OFFENDER_REGISTRY' => 'UTE_INDIAN_TRIBE_SOR',
														trim(l.sourcename, left, right) = 'YANKTON_SIOUX_TRIBE_SEX_OFFENDER_REGISTRY'	=> 'YANKTON_SIOUX_TRIBE_SOR',
														trim(l.sourcename, left, right) = 'EASTERN_BAND_OF_CHEROKEE_INDIANS_SEX_OFFENDER_REGISTRY'	=> 'ESTRN_BAND_OF_CHEROKEE_IND_SOR',
														l.sourcename);
		self.date_added   						:= ut.getdate;
		self.date_updated   					:= ut.GetDate;
		//self.src_dt_added						:= l.recorduploaddate;
		self.src_upload_date					:= l.recorduploaddate;
		self.state_of_origin   					:= l.statecode;
		self.name_orig   						:= l.name;
		self.firstname							:= l.firstname;
		self.middlename							:= if(stringlib.StringToUpperCase(l.middlename) not in ['', 'NMN ', 'NMI '],
														l.middlename,
														'');
		self.lastname							:= l.lastname;
		self.suffix								:= l.suffix;
		self.nametype							:= if(trim(l.nametype, left, right)<>'2',
														'0',
														l.nametype);
		self.name_aka   						:= '';
		self.intnet_email_address_1   			:= '';//l.emailaddress;
		self.intnet_email_address_2   			:= '';
		self.intnet_email_address_3   			:= '';
		self.intnet_email_address_4   			:= '';
		self.intnet_email_address_5   			:= '';
		self.intnet_instant_message_addr_1   	:= '';
		self.intnet_instant_message_addr_2   	:= '';
		self.intnet_instant_message_addr_3   	:= '';
		self.intnet_instant_message_addr_4   	:= '';
		self.intnet_instant_message_addr_5   	:= '';
		self.intnet_user_name_1   				:= '';
		self.intnet_user_name_1_url   			:= '';
		self.intnet_user_name_2   				:= '';
		self.intnet_user_name_2_url   			:= '';
		self.intnet_user_name_3   				:= '';
		self.intnet_user_name_3_url   			:= '';
		self.intnet_user_name_4   				:= '';
		self.intnet_user_name_4_url   			:= '';
		self.intnet_user_name_5   				:= '';
		self.intnet_user_name_5_url   			:= '';
		self.offender_status   					:= if(trim(l.defendantstatus, left, right)<>'' and regexfind('SO RISK LEVEL', l.defendantstatus, 0)='',
														trim(l.defendantstatus, left, right),
														status);
		self.offender_category   				:= offender_category;
		self.risk_level_code   					:= risk_level_code;
		self.risk_description   				:= risk_level_description;
		self.police_agency   					:= police_agency;
		self.police_agency_contact_name   		:= '';
		self.police_agency_address_1   			:= '';
		self.police_agency_address_2   			:= '';
		self.police_agency_phone   				:= '';
		self.registration_type   				:= if(registration_length<>'',
														registration_length,
														registration_type);
		self.reg_date_1   						:= if(regexfind('19|20', l.sexoffenderregistrydate[1..2], 0)<>'',
														l.sexoffenderregistrydate,
														'');
		self.reg_date_1_type   					:= if(l.sexoffenderregistrydate<>'',
														'Registration Date',
														'');
		self.reg_date_2   						:= if(regexfind('-|/', l.sexoffenderregexpirationdate, 0)<>'' and length(trim(l.sexoffenderregexpirationdate, left, right))=8,
														'20'+l.sexoffenderregexpirationdate[7..8]+l.sexoffenderregexpirationdate[1..2]+l.sexoffenderregexpirationdate[4..5],
														'');												
		self.reg_date_2_type   					:= if(l.sexoffenderregexpirationdate<>'',
														'Registration Expiration Date',
														'');
		self.reg_date_3   						:= '';
		self.reg_date_3_type   					:= '';
		self.registration_address_1   			:= trim(l.street, left, right);//+' '+trim(l.unit, left, right), left, right);
		
			filter_city 						:= if(trim(l.city, left, right)= 'X',
														'',
													if(regexfind('XX', trim(l.city, left, right), 0)<>'',
														'',
														trim(l.city, left, right)));
		
		self.registration_address_2   			:= if(filter_city='' or trim(l.orig_state, left, right)='',
														trim(filter_city+' '+trim(trim(l.orig_state, left, right)+' '+trim(l.orig_zip, left, right), left, right), left, right),
														trim(filter_city+', '+trim(trim(l.orig_state, left, right)+' '+trim(l.orig_zip, left, right), left, right), left, right));	
		self.registration_county   				:= county;
		self.registration_home_phone   			:= l.phone;
		self.registration_cell_phone   			:= '';
		self.other_registration_county   		:= '';
		self.other_registration_phone   		:= '';
		self.temp_lodge_address_1   			:= '';
		self.temp_lodge_address_2   			:= '';
		self.temp_lodge_address_3   			:= '';
		self.temp_lodge_address_4   			:= '';
		self.temp_lodge_address_5   			:= '';
		self.temp_lodge_county   				:= '';
		self.temp_lodge_phone  	 				:= '';
		self.employer   						:= employer;
		self.employer_address_1   				:= employer_address;
		self.employer_address_2   				:= if(employer_state<>'' and employer_zip<>'',
														employer_state+' '+employer_zip,
													if(employer_state<>'',
														employer_state,
													if(employer_zip<>'',
														employer_zip,
														'')));
		self.employer_address_3   				:= '';
		self.employer_address_4   				:= '';
		self.employer_address_5   				:= '';
		self.employer_county   					:= '';
		self.employer_phone   					:= '';
		self.employer_comments   				:= if(occupation<>'',
														'OCCUPATION: '+occupation,
														'');
		self.professional_licenses_1   			:= prof_licenses;
		self.professional_licenses_2   			:= '';
		self.professional_licenses_3   			:= '';
		self.professional_licenses_4   			:= '';
		self.professional_licenses_5   			:= '';
		self.school   							:= if(l.institutionname<>'',
														l.institutionname,
														school);
		self.school_address_1   				:= school_address;
		self.school_address_2   				:= '';
		self.school_address_3   				:= '';
		self.school_address_4   				:= '';
		self.school_address_5   				:= '';
		self.school_county   					:= '';
		self.school_phone   					:= '';
		self.school_comments   					:= '';
		self.offender_id   						:= l.recordid;
		self.doc_number   						:= l.docnumber;
		self.sor_number   						:= l.sexoffenderregistrynumber;
		self.st_id_number   					:= l.stateidnumber;
		self.fbi_number   						:= l.fbinumber;
		self.ncic_number   						:= '';
		self.orig_ssn   						:= l.orig_ssn;
		self.date_of_birth   					:= if(l.dob[1..2] in ['19','20'] and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)l.dob[1..4])>=18,
														trim(l.dob,left,right),
														'');
		self.date_of_birth_aka   				:= if(l.akadob[1..2] in ['19','20'] and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)l.akadob[1..4])>=18,
														trim(l.akadob,left,right),
														'');
		self.age   								:= l.age;
		self.dna   								:= '';
		self.race   							:= MAP(trim(l.race)='A' 						=> 'ASIAN/PACIFIC ISLAND',
														trim(l.race)='B' 						=> 'BLACK',
														trim(l.race)='H' 						=> 'HISPANIC',
														trim(l.race)='I' 						=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='W' 						=> 'WHITE',
														trim(l.race)='AM IND' 					=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='AMER. INDIAN OR ALAS' 	=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='AMER INDIAN/ALASKAN' 		=> 'AMER INDIAN/ALASKAN', 
														trim(l.race)='AMERICAN INDIAN OR A' 	=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='AMERICAN INDIAN, ALA' 	=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='AMER IND' 				=> 'AMER INDIAN/ALASKAN',            
														trim(l.race)='AMER INDIAN/ALASKAN' 		=> 'AMER INDIAN/ALASKAN', 
														trim(l.race)='AMERICAN INDIAN' 			=> 'AMER INDIAN/ALASKAN',     
														trim(l.race)='AMERICAN INDIAN / AL' 	=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='AMERICAN INDIAN OR A' 	=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='AMERICAN INDIAN/ALAS' 	=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='NAT AM INDIAN' 			=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='NATIVE AMERICAN' 			=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='NATIVE AMERICAN OR A' 	=> 'AMER INDIAN/ALASKAN',
														
                            trim(l.race)='AMERICAN INDIAN/ALASKAN' 	=> 'AMER INDIAN/ALASKAN',														
														trim(l.race)='NATIVE AMERICAN OR ALASKAN' 	=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='AMERICAN INDIAN/ALASKAN NATIVE' 	=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='AMERICAN INDIAN OR ALASKAN NAT' 	=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='AMERICAN INDIAN, ALASKAN NATIVE' 	=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='AMERICAN INDIAN OR ALASKAN NATIVE' 	=> 'AMER INDIAN/ALASKAN',
														trim(l.race)='INDIAN ( AMERICAN OR ALASKAN NATIVE )' 	=> 'AMER INDIAN/ALASKAN',	
														
														trim(l.race)='ASIAN' 					=> 'ASIAN/PACIFIC ISLAND',
														trim(l.race)='ASIAN INDIAN' 			=> 'ASIAN INDIAN',
														trim(l.race)='ASIAN OR PAC. ISL.' 		=> 'ASIAN/PACIFIC ISLAND',
														trim(l.race)='ASIAN OR PACIFIC ISL' 	=> 'ASIAN/PACIFIC ISLAND',
														trim(l.race)='ASIAN/PACIFIC ISLAND' 	=> 'ASIAN/PACIFIC ISLAND',
														trim(l.race)='ASIAN OR PACIFIC ISL' 	=> 'ASIAN/PACIFIC ISLAND',
														trim(l.race)='ASIAN/PAC.ISLD' 			=> 'ASIAN/PACIFIC ISLAND',      
														trim(l.race)='ASIAN/PACIFIC ISLAND' 	=> 'ASIAN/PACIFIC ISLAND',
                            
 														trim(l.race)='ASIAN OR PACIFIC ISLANDER' 	=> 'ASIAN/PACIFIC ISLAND',
                            trim(l.race)='ASIAN/PACIFIC ISLANDER' 	=> 'ASIAN/PACIFIC ISLAND',														
                            trim(l.race)='ASIAN OR PACIFI' 	=> 'ASIAN/PACIFIC ISLAND',														
														
														trim(l.race) in ['CAMBODIAN','CHINESE',
															'FILIPINO','GUAMANIAN','HAWAIIAN',
															'JAPANESE','KOREAN','LAOTIAN',
															'MICRONESIAN','PACIFIC ISLANDER',
															'SAMOAN','TONGAN','VIETNAMESE'] 	=> 'ASIAN/PACIFIC ISLAND',
														trim(l.race)='BLACK' 					=> 'BLACK',
														trim(l.race)='BLACK OR AFRICAN AME' 	=> 'BLACK',
														trim(l.race)='AFR AMER' 				=> 'BLACK',
														trim(l.race)='AFRICAN AMERICAN' 		=> 'BLACK',
														
														trim(l.race)='BLACK/AFRICAN AMERICAN' 		=> 'BLACK',
														
														trim(l.race)='HISPANIC' 				=> 'HISPANIC',
														trim(l.race)='CAUCASIAN' 				=> 'WHITE',
														trim(l.race)[1..5]='WHITE' 				=> 'WHITE',
														'');
														
		self.ethnicity   						:= l.ethnicity;
		
		self.sex   								:= map(l.gender[1..1] in ['M','F'] => l.gender[1..1],
														'');
		
		self.hair_color   						:= map(l.haircolor in ['AUBURN'] 								=> 'AUBURN',
														 l.haircolor in ['BAL','BALD','BALD/UNKNO','BLD']		=> 'BALD',
														 l.haircolor in ['BLK','BLACK']							=> 'BLACK',
														 l.haircolor[1..4] in ['BLOND']							=> 'BLONDE',
														 l.haircolor in ['BLN']									=> 'BLONDE',
														 l.haircolor in ['BLUE']								=> 'BLUE',
														 l.haircolor[1..3] in ['BRO']							=> 'BROWN',
														 l.haircolor in ['DARK BROWN']							=> 'BROWN',
														 l.haircolor[1..3] in ['RED']							=> 'RED',
														 l.haircolor in ['BLACK-GRAY','BLACK/GRAY',
																'BROWN-GRAY','BROWN/GRAY',
																'GRAY','GRAY OR PA','GRAY/PARTI',
																'GREY','GREY OR PA','GRY']						=> 'GRAY ',
														 l.haircolor in ['GREEN']								=> 'GREEN',
														 l.haircolor in ['ONG','ORANGE']						=> 'ORANGE',
														 l.haircolor in ['PINK']								=> 'PINK',
														 l.haircolor in ['PURPLE']								=> 'PURPLE',
														 l.haircolor[1..4] in ['SANDY','SANDY BLON','SDY']		=> 'SANDY',
														 l.haircolor in ['STRAWBERRY']							=> 'STRAWBERRY',
														 l.haircolor[1..3] in ['WHI']							=> 'WHITE',
														 l.haircolor[1..3] in ['UNK']							=> '',						 
														 '');
														 
		self.eye_color   						:= map(l.eyecolor in ['BLK','BLACK']									=> 'BLACK',
														 l.eyecolor[1..3] in ['BLU']									=> 'BLUE',
														 l.eyecolor[1..3] in ['BRO']									=> 'BROWN',
														 l.eyecolor in ['GRAY','GREY','GRY']							=> 'GRAY ',
														 l.eyecolor in ['GREEN','GRN']									=> 'GREEN',
														 l.eyecolor[1..3] in ['HAZ']									=> 'HAZEL',
														 l.eyecolor[1..3] in ['MAR']									=> 'MAROON',
														 l.eyecolor in ['MIXED','MUL','MULTI','MULTI-COLO','MULTICOLOR']=> 'MULTI',
														 l.eyecolor[1..3] in ['UNK']									=> '',						 
														 '');   

		self.height   							:= hygenics_soff._functions.fn_height_to_inches(l.height);
		
		self.weight   							:= if((integer) stringlib.stringfilter(l.weight,'1234567890')<>0,
														stringlib.stringfilter(l.weight,'1234567890'),
														'');
														
		self.skin_tone   						:= l.skincolor;
		self.build_type   						:= l.physicalbuild;
		self.scars_marks_tattoos   				:= l.bodymarks;
		self.shoe_size   						:= '';
		self.corrective_lense_flag   			:= corrective_lenses;
		self.addl_comments_1   					:= if(l.birthplace<>'',
														'PLACE OF BIRTH: '+l.birthplace,
													if(place_of_birth<>'',	
														'PLACE OF BIRTH: '+place_of_birth,
														''));
		self.addl_comments_2   					:= '';
		self.orig_dl_number   					:= drivers_license_no;
		self.orig_dl_state   					:= drivers_license_st;
		self.orig_dl_link   					:= '';
		self.orig_dl_date   					:= '';
		self.passport_type   					:= '';
		self.passport_code   					:= '';
		self.passport_number   					:= '';
		self.passport_first_name   				:= '';
		self.passport_given_name   				:= '';
		self.passport_nationality   			:= '';
		self.passport_dob   					:= '';
		self.passport_place_of_birth   			:= ''; 
		self.passport_sex   					:= '';
		self.passport_issue_date   				:= '';
		self.passport_authority   				:= '';
		self.passport_expiration_date   		:= '';
		self.passport_endorsement   			:= '';
		self.passport_link   					:= '';
		self.passport_date   					:= '';
		self.orig_veh_year_1   					:= vehicle_desc;
		self.orig_veh_color_1   				:= '';
		self.orig_veh_make_model_1   			:= '';
		self.orig_veh_plate_1   				:= '';
		self.orig_registration_number_1   		:= '';
		self.orig_veh_state_1   				:= '';
		self.orig_veh_location_1   				:= '';
		self.orig_veh_year_2   					:= '';
		self.orig_veh_color_2   				:= '';
		self.orig_veh_make_model_2   			:= '';
		self.orig_veh_plate_2   				:= '';
		self.orig_registration_number_2   		:= '';
		self.orig_veh_state_2   				:= '';
		self.orig_veh_location_2   				:= '';
		self.orig_veh_year_3   					:= '';
		self.orig_veh_color_3   				:= '';
		self.orig_veh_make_model_3  	 		:= '';
		self.orig_veh_plate_3   				:= '';
		self.orig_registration_number_3   		:= '';
		self.orig_veh_state_3   				:= '';
		self.orig_veh_location_3   				:= '';
		self.orig_veh_year_4   					:= '';
		self.orig_veh_color_4   				:= '';
		self.orig_veh_make_model_4   			:= '';
		self.orig_veh_plate_4   				:= '';
		self.orig_registration_number_4   		:= '';
		self.orig_veh_state_4   				:= '';
		self.orig_veh_location_4  				:= '';
		self.orig_veh_year_5   					:= '';
		self.orig_veh_color_5   				:= '';
		self.orig_veh_make_model_5   			:= '';
		self.orig_veh_plate_5   				:= '';
		self.orig_registration_number_5   		:= '';
		self.orig_veh_state_5   				:= '';
		self.orig_veh_location_5   				:= '';
		self.fingerprint_link   				:= '';
		self.fingerprint_date   				:= '';
		self.palmprint_link   					:= '';
		self.palmprint_date   					:= '';
		self.image_link   						:= if(trim(l.photoname, left, right)<>''
		                                      and trim(l.sourcename, left, right) = 'COLORADO_SOTAR_SEX_OFFENDER_REGISTRY',
																					  'CS'+'SOR_'+trim(Stringlib.StringToUpperCase(l.photoname)), 
													            	if(trim(l.photoname, left, right)<>'',trim(l.statecode, left, right)+'SOR_'+trim(Stringlib.StringToUpperCase(l.photoname)),
														             ''));
		self.image_date   						:= photo_date;						
	end;

	ds_df 		:= project(def_recs, refOff(left)):persist('~thor_200::persist::soff_defendant_beforefix');

	//Remove Cities from Registration Address 1	
	ds_filter 	:= ds_df(state_of_origin='NV');
	ds_remain	:= ds_df(state_of_origin<>'NV');
	
	ds_df removeCitiesTran(ds_filter l):= transform	
	
		registration_address_1		:= trim(l.registration_address_1, left, right)+', '+trim(l.registration_address_2, left, right);
		
		prep_address				:= stringlib.stringfilter(trim(registration_address_1, left, right),
											' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ,');
		
		prep_state 					:= if(regexfind(',', prep_address, 0)<>'',
											trim(prep_address[stringLib.Stringfind(trim(prep_address, left, right), ',', 2)+1..stringLib.Stringfind(trim(prep_address, left, right), ',', 2)+3], left, right),//+2..length(prep_address)-stringlib.stringfind(stringLib.StringReverse(trim(prep_address, left, right)), ',', 2)+4]),
											'');
																		
		prep_city					:= if(regexfind(',', prep_address, 0)<>'',
											trim(prep_address[stringlib.stringfind(trim(prep_address, left, right), ',', 1)+1..stringlib.stringfind(trim(prep_address, left, right), ',', 2)-1], left, right),
											'');
		
		prep_zip					:= if(regexfind('[0-9]+', prep_address, 0)<>'',
											trim(prep_address[stringLib.Stringfind(trim(prep_address, left, right), ',', 2)+4..], left, right),
											'');
		
		string c_4token  			:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-3)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-3)+40], ''),
										'');
		
		string c_3token  			:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-2)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-2)+40], ''),
										'');
	
		string c_2token  			:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-1)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-1)+40], ''),
										'');
	
		string c_1token  			:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' '))+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' '))+40], ''),
										'');
	
		//city list derived from zip
		find_city					:= ziplib.ZipToCities(stringlib.stringfilter(prep_zip, '0123456789')[1..5]);
		
		drvd_city 					:= if(trim(prep_zip)<>'' and stringlib.stringfind(find_city, ',', 2)<>0,
											trim(find_city[stringlib.stringfind(find_city, ',', 1)+1..stringlib.stringfind(find_city, ',', 2)-1], left, right),
										if(trim(prep_zip)<>'' and stringlib.stringfind(find_city, ',', 2)=0,
											trim(find_city[stringlib.stringfind(find_city, ',', 1)+1..], left, right),
											''));
	
		//city pulled from input address line 1 that exists in derived list
		prsd_city 					:= if(trim(c_4token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_4token,left,right),drvd_city),
											c_4token,
											if(trim(c_3token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_3token,left,right),drvd_city),
											c_3token,
											if(trim(c_2token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_2token,left,right),drvd_city),
											c_2token,
											if(trim(c_1token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_1token,left,right),drvd_city),
											c_1token,
											''))));
											
		address_1 					:= if(prsd_city != '',
											lib_StringLib.StringLib.StringToUpperCase(trim(regexreplace(trim(prsd_city,left,right),prep_address[1..stringlib.stringfind(prep_address, ',', 1)-1],''),left,right)),
											if(regexfind(',', prep_address, 0)<>'',
											prep_address[1..stringlib.stringfind(prep_address, ',', 1)-1-stringlib.stringfind(StringLib.StringReverse(trim(prep_address, left, right)), ',', 1)-1],
											''));
	
		address_2					:= lib_StringLib.StringLib.StringToUpperCase(trim(prsd_city,left,right) + if(trim(prsd_city, left, right) <> '',', ','') + trim(prep_state, left, right) + ' ' + trim(prep_zip, left, right)[1..5]);
		self.registration_address_1 := address_1;
		self.registration_address_2 := address_2;
		self := l;
	end;
	
	ds_dfd 	:= project(ds_filter, removeCitiesTran(left));
	ds_def 	:= ds_dfd + ds_remain;
	
	//Add Fixes
	ds_def transformFix(ds_def l):= transform
		
		list_offender_category	:= ['AWAITING CLASSIFICATION','CHILD MURDERER','JUVENILE SEX OFFENDER (WALSH)','OFFENDER','OFFENDER AGAINST CHILDREN','PREDATOR','SEX OFFENDER','SEXUAL','SEXUAL PREDATOR','SEXUALLY DANGEROUS','SEXUALLY VIOLENT','SEXUALLY VIOLENT PREDATOR','VIOLENT'];
		list_registration_type	:= ['ADULT PENDING','LIFE','LIFE REGISTRATION','LIFETIME','LIFETIME OFFENDER','TEN YEAR OFFENDER'];
		
		parse_offender_status  	:= if(l.offender_status[stringlib.stringfind(l.offender_status, ',', 1)-1] in ['0','1','2','3','4','5','6','7','8','9'],
										l.offender_status[stringlib.stringfind(l.offender_status, ',', 1)+2..length(l.offender_status)],
									if(regexfind(', ABSCONDED', l.offender_status, 0)<>'' or regexfind(', ABSCONDED', l.risk_description, 0)<>'' ,
										'ABSCONDED',
									if(regexfind(', ACTIVE WARRANT', l.offender_status, 0)<>'' or regexfind(', ACTIVE WARRANT', l.risk_description, 0)<>'' ,
										'ACTIVE WARRANT',
									if(regexfind(', CIVIL COMMITMENT', l.offender_status, 0)<>'' or regexfind(', CIVIL COMMITTMENT', l.risk_description, 0)<>'',
										'CIVIL COMMITMENT',
									if(regexfind(', COMPLIANT', l.offender_status, 0)<>'' or regexfind(', COMPLIANT', l.risk_description, 0)<>'',
										'COMPLIANT',
									if(regexfind(', CONFINEMENT', l.offender_status, 0)<>'' or regexfind(', CONFINEMENT', l.risk_description, 0)<>'',
										'CONFINEMENT',	
									if(regexfind(', DECEASED', l.offender_status, 0)<>'' or regexfind(', DECEASED', l.risk_description, 0)<>'',
										'DECEASED',
									if(regexfind(', DEPORTED', l.offender_status, 0)<>'' or regexfind(', DEPORTED', l.risk_description, 0)<>'',
										'DEPORTED',
									if(regexfind(', LOCATION UNKNOWN', l.offender_status, 0)<>'' or regexfind(', LOCATION UNKNOWN', l.risk_description, 0)<>'',
										'LOCATION UNKNOWN',
									if(regexfind(', NONCOMPLIANT', l.offender_status, 0)<>'' or regexfind(', NONCOMPLIANT', l.risk_description, 0)<>'',
										'NONCOMPLIANT',
									if(regexfind(', NON-COMPLIANT', l.offender_status, 0)<>'' or regexfind(', NON-COMPLIANT', l.risk_description, 0)<>'',
										'NON-COMPLIANT',
									if(regexfind('SEX OFFENDER HAS BEEN IN VIOLATION OF REGISTRATION REQUIREMENTS', l.offender_status, 0)<>'',
										'NON-COMPLIANT',
									if(regexfind(', RELEASED - REQUIRED TO REGISTER', l.offender_status, 0)<>'' or regexfind(', RELEASED - REQUIRED TO REGISTER', l.risk_description, 0)<>'',
										'RELEASED - REQUIRED TO REGISTER',
									if(regexfind('STAYED BY COURT', l.offender_status, 0)<>'',
										l.offender_status,
									if(regexfind(', SUPERVISED - FL DEPT OF CORRECTIONS', l.offender_status, 0)<>'' or regexfind(', SUPERVISED - FL DEPT OF CORRECTIONS', l.risk_description, 0)<>'',
										'SUPERVISED - FL DEPT OF CORRECTIONS',
									if(regexfind(', SUPERVISED - FL DEPT OF JUVENILE JUSTICE', l.offender_status, 0)<>'' or regexfind(',  SUPERVISED - FL DEPT OF JUVENILE JUSTICE', l.risk_description, 0)<>'',
										'SUPERVISED - FL DEPT OF JUVENILE JUSTICE',
									if(regexfind(', SUPERVISED - US PROBATION', l.offender_status, 0)<>'' or regexfind(', SUPERVISED - US PROBATION', l.risk_description, 0)<>'',
										'SUPERVISED - US PROBATION',	
	
									if(regexfind(', DELINQUENT REGISTERED', l.risk_description, 0)<>'',
										'DELINQUENT REGISTERED',
	
									if(regexfind(', DOMICILED', l.risk_description, 0)<>'',
										'DOMICILED',
									if(regexfind(', HOMELESS', l.risk_description, 0)<>'',
										'HOMELESS',
									if(regexfind(', INCARCERATED NOT REGISTERED', l.risk_description, 0)<>'',
										'INCARCERATED NOT REGISTERED',
									if(regexfind(', INCARCERATED REGISTERED', l.risk_description, 0)<>'',	
										'INCARCERATED REGISTERED',
									if(regexfind(', INCARCERATED', l.risk_description, 0)<>'',	
										'INCARCERATED',
									if(regexfind(', NON-COMPLIANT (PER NRS 179D.550)', l.risk_description, 0)<>'',	
										'NON-COMPLIANT (PER NRS 179D.550)',
									if(regexfind(', NON-COMPLIANT REGISTRANT', l.risk_description, 0)<>'',	
										'NON-COMPLIANT REGISTRANT',
									if(regexfind(', NON-COMPLIANT', l.risk_description, 0)<>'',	
										'NON-COMPLIANT',
									if(regexfind(', REGISTERED', l.risk_description, 0)<>'',
										'REGISTERED',
									
									if(l.offender_status not in list_offender_category and regexfind('(PRE AWA)|TIER I', l.offender_status, 0) = '' and l.offender_status not in list_registration_type,
										l.offender_status,
										''))))))))))))))))))))))))))));
		
		filter_off_st_off_cat	:= if(regexfind('SO RISK LEVEL:', l.risk_description[1..14], 0)<>'' and regexfind(', ALIASES:', l.risk_description, 0)='' and stringlib.stringfind(l.risk_description, ',', 2)<>0,
										l.risk_description[stringlib.stringfind(l.risk_description, ',', 1)+2..stringlib.stringfind(l.risk_description, ',', 2)-1],
									if(l.offender_status[1..15]='CHILD MURDERER,',
										'CHILD MURDERER',
									if(l.offender_status[1..30]='JUVENILE SEX OFFENDER (WALSH),',
										'JUVENILE SEX OFFENDER (WALSH)',
									if(l.offender_status[1..13]='SEX OFFENDER,',
										'SEX OFFENDER',
									if(l.offender_status[1..26]='OFFENDER AGAINST CHILDREN,',
										'OFFENDER AGAINST CHILDREN',
									if(l.offender_status[1..9]='OFFENDER,',
										'OFFENDER',
									if(l.offender_status[1..16]='SEXUAL PREDATOR,',
										'SEXUAL PREDATOR',
									if(l.offender_status[1..9]='PREDATOR,',
										'PREDATOR',
									if(l.offender_status[1..19]='SEXUALLY DANGEROUS,',
										'SEXUALLY DANGEROUS',
									if(l.offender_status[1..17]='SEXUALLY VIOLENT,',
										'SEXUALLY VIOLENT',
									if(regexfind('STAYED BY COURT', l.offender_status, 0)<>'',
										'',
										l.offender_category)))))))))));
							
		filter_off_st_risk_lev	:= if(regexfind('SO RISK LEVEL:', l.risk_description, 0)<>'' and regexfind(', ALIASES:', l.risk_description, 0)<>'',
										l.risk_description[stringlib.stringfind(l.risk_description, 'SO RISK LEVEL', 1)+15..stringlib.stringfind(l.risk_description, ', ALIASES:', 1)-1],
									if(regexfind('LIFETIME, SO RISK LEVEL:', l.risk_description[1..24], 0)<>'' and regexfind(', ALIASES:', l.risk_description, 0)='' and stringlib.stringfind(l.risk_description, ',', 2)<>0,
										l.risk_description[26..stringlib.stringfind(l.risk_description, ',', 2)-1],
									if(regexfind('SO RISK LEVEL:', l.risk_description[1..14], 0)<>'' and regexfind(',', l.risk_description, 0)<>'',
										l.risk_description[stringlib.stringfind(l.risk_description, 'SO RISK LEVEL:', 1)+15..stringlib.stringfind(l.risk_description, ',', 1)-1],
									if(regexfind('SO RISK LEVEL:', l.risk_description[1..14], 0)<>'' and regexfind(',', l.risk_description, 0)='',	
										regexreplace('SO RISK LEVEL:', l.risk_description, ''),	
										l.risk_description))));
		
		filter_reg_type 		:= if(regexfind('LIFETIME,', l.risk_description[1..10], 0)<>'',
										l.risk_description[1..8],
										l.registration_type);
		
		self.date_of_birth_aka 	:= if(l.date_of_birth = l.date_of_birth_aka,
										'',
										l.date_of_birth_aka);
										
		self.offender_status 	:= if(regexfind('INCARCERATED', l.registration_address_1, 0) <> '' or regexfind('INCARCERATED', l.registration_address_2, 0) <> '',
										'INCARCERATED',
										parse_offender_status);	
		
		self.offender_category	:= if(trim(l.offender_category, left, right) = '' and l.offender_status in list_offender_category,	
										l.offender_status,
										filter_off_st_off_cat);
										
		self.risk_level_code	:= if(regexfind('SO RISK LEVEL:', l.risk_description, 0)<>'' and regexfind(',', l.risk_description, 0)='',
										trim(regexreplace('SO RISK LEVEL:', l.risk_description, ''), left, right),
										'');
		
		self.risk_description	:= if(regexfind('SOR RISK LEVEL:', filter_off_st_risk_lev, 0)<>'',
										trim(regexreplace('SO RISK LEVEL:', filter_off_st_risk_lev, ''), left, right),
										trim(filter_off_st_risk_lev, left, right));
		
		self.registration_type	:= if(trim(l.registration_type, left, right) = '' and l.offender_status in list_registration_type,
										l.offender_status,
										filter_reg_type);
										
		self := l;
	end;
	
	ds_defendant 	:= project(ds_def, transformFix(left)):persist('~thor_200::persist::soff_defendant');
	output(count(ds_defendant), named('ds_defendant'));

	noAKADOB_def 	:= ds_defendant(date_of_birth_aka='');
	addAKADOB_def 	:= ds_defendant(date_of_birth_aka<>'');
	
	addAKADOB_def addAddlRec(addAKADOB_def l):= transform
		self.nametype 			:= '3';
		self.date_of_birth		:= l.date_of_birth_aka;
		self.date_of_birth_aka 	:= l.date_of_birth_aka;
		self 					:= l;
	end;
	
	addAKADOB_defendant := project(addAKADOB_def, addAddlRec(left));
	
	all_defendants		:=  dedup(sort(noAKADOB_Def + addAKADOB_def + addAKADOB_defendant, record), except date_of_birth_aka) :persist('~thor_200::persist::soff_defendant_akas');

export Mapping_Defendant := all_defendants;