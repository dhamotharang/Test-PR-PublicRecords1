IMPORT ADDRESS, FBNV2;

ds := DATASET('~thor_data400::base::fbnv2::contact_w20120316-173630',fbnv2.Layout_Common.Contact_AID , flat);
ds_filtered := ds(contact_name!='' and lname = '' and dt_last_seen >20120310);

Layout_Clean_Name := record
			fbnv2.layout_common.Contact_AID;
			string1         name_flag;
			string5         cln_title;
			string20        cln_fname;
			string20        cln_mname;
			string20        cln_lname;
			string5         cln_suffix;
			string5         cln_title2;
			string20        cln_fname2;
			string20        cln_mname2;
			string20        cln_lname2;
			string5         cln_suffix2;	
end;


	fbnv2.layout_common.contact_aid  trfCleanName(Layout_Clean_Name  l) := transform
		self.title			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
																								 l.name_flag = 'U' => l.title, 
																								 ''
													);
		self.fname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
																								 l.name_flag = 'U' => l.fname, 
																								 ''
													);
		self.mname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
													 											 l.name_flag = 'U' => l.mname, 
																								 ''
													);
		self.lname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
																								 l.name_flag = 'U' => l.lname, 
																								 ''
													);
		self.name_suffix:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
																								 l.name_flag = 'U' => l.name_suffix, 
																								 ''
													);
		self						:=	l;
		self						:=	[];
end;		

//Call Mac_Is_Business to clean up Contact_Name.
Address.Mac_Is_Business(ds_filtered, contact_name, Cleaned_Name, name_flag, false, true );

//Populate Layout_Clean_Name with cln_* fields
dNameClean := project(Cleaned_Name,transform(Layout_Clean_Name,self := left;self := []));

//Populate Contact_AID layout with cln_* fields
dsFixed    := project(dNameClean,trfCleanName(LEFT));

OUTPUT(dsFixed,,'~thor_data400::temp::fbnv2::sbutler::cleaned',overwrite);