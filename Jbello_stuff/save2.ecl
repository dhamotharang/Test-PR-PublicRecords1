/*
import ut;

v:=dataset(ut.foreign_prod+'~thor_data400::base::VehicleV2::Main', VehicleV2.Layout_Base_Main, flat);

rs:=RECORD
   source_code:=v.source_code;
   orig_vehicle_type_code:=v.orig_vehicle_type_code;
   orig_vehicle_type_desc:=v.orig_vehicle_type_desc;
   vina_model_desc:=v.vina_model_desc;
 END;

ds := table(v(vina_model_desc<>''),rs) : persist('~thor_data400::persist::jbello::veh_modelseries');

r0:=record
	vina_model_desc	:=	ds.vina_model_desc,
	model			:=	ds.vina_model_desc,
	series			:=	ds.vina_model_desc,
end;

d0:=table(ds,r0);

r0 tr(d0 l) := transform
	specia_case:=	['MONTE'
					,'GRAND'
					,'CROWN'
					,'TOWN'	
					,'EL'	
					,'CUTLASS'	
					,'DELTA'	
					];

	model_desc:=regexreplace('([^A-Z0-9])',trim((qstring)l.vina_model_desc,left,right),' ');
	w0:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$0');
	w1:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$1');
	w2:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$2');
	w3:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$3');
	w4:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$4');
	w5:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$5');

	self.model	:=if(w1 in specia_case
						,w1+' '+w2
						,w1);
	self.series	:=if(w1 in specia_case
						,		w3+' '+w4+' '+w5
						,w2+' '+w3+' '+w4+' '+w5);

	self :=l;
end;

d1:=distribute(project(d0,tr(left)),hash(vina_model_desc,model));

r1:=record
	d1.vina_model_desc,
	d1.model,
	d1.series,
	cnt:=count(group),
end;

t1:=table(d1,r1
				,d1.vina_model_desc
				,d1.model
				,d1.series
				,local)
		:persist('~thor_data400::persist::jbello:veh_ModelComponent_cnt')
		;


output(sort(t1,-cnt));


*/





r:=RECORD
  string15 first_name;
  string15 middle_initial;
  string25 last_name;
  string2 suffix;
  string15 former_first_name;
  string15 former_middle_initial;
  string25 former_last_name;
  string2 former_suffix;
  string15 former_first_name2;
  string15 former_middle_initial2;
  string25 former_last_name2;
  string2 former_suffix2;
  string15 aka_first_name;
  string15 aka_middle_initial;
  string25 aka_last_name;
  string2 aka_suffix;
  string57 current_address;
  string20 current_city;
  string2 current_state;
  string5 current_zip;
  string6 current_address_date_reported;
  string57 former1_address;
  string20 former1_city;
  string2 former1_state;
  string5 former1_zip;
  string6 former1_address_date_reported;
  string57 former2_address;
  string20 former2_city;
  string2 former2_state;
  string5 former2_zip;
  string6 former2_address_date_reported;
  string6 blank1;
  string9 ssn;
  EBCDIC string9 cid;
  string1 ssn_confirmed;
  string1 name_change;
  string1 addr_change;
  string1 ssn_change;
  string1 former_name_change;
  string1 new_rec;
  unsigned integer6 uid;
  string2 src;
  string5 title_1;
  string20 fname_1;
  string20 minit_1;
  string20 lname_1;
  string5 name_suffix_1;
  string20 fname_2;
  string20 minit_2;
  string20 lname_2;
  string5 name_suffix_2;
  string20 fname_3;
  string20 minit_3;
  string20 lname_3;
  string5 name_suffix_3;
  string20 fname_4;
  string20 minit_4;
  string20 lname_4;
  string5 name_suffix_4;
  string18 vendor_id;
  string1 jflag3;
 END;

import header,ut,address;
// d:=dataset('~thor_data400::persist::header_preprocess_name_clean',recordof(header.layout_new_records,flat);
dHeadersInNameCleaned:=dataset('~thor_data400::persist::header_preprocess_name_clean',r,flat);



// dHeadersInNameCleaned:=(d(	uid=4734
						// or	uid=17086
						// or	uid=27398
						// or	uid=29349
						// or	uid=24591
						// ))
	// : persist('~thor_data400::persist::jbello::dHeadersInNameCleaned2')

// dHeadersInNameCleaned:=(choosen(d(
							// fname_2<>''
							// and ssn<>''
							// and	(ut.NameMatch(fname_1,minit_1,lname_1
											// ,fname_2,minit_2,lname_2) < 3
								// or	datalib.gender(fname_1)<>datalib.gender(fname_2)
								// or	datalib.gender(minit_1)<>datalib.gender(minit_2)	)
							// ),10000))
	// : persist('~thor_data400::persist::jbello::dHeadersInNameCleaned')
	// ;
// output(dHeadersInNameCleaned);



rNormalizedAddresses
 :=
  record
	string15 first_name;
	string15 middle_initial;
	string25 last_name;
	string2	 suffix;
	string15 former_first_name;
	string15 former_middle_initial;
	string25 former_last_name;
	string2	 former_suffix;
	string15 former_first_name2;
	string15 former_middle_initial2;
	string25 former_last_name2;
	string2	 former_suffix2;
	string15 aka_first_name;
	string15 aka_middle_initial;
	string25 aka_last_name;
	string2	 aka_suffix;
	string57 addr;
	string20 orig_city;
	string2	 orig_state;
	string5	 zip;
	string6	 address_date_reported;
	string25	 ssn;
	string9	 cid;
    string1	 rec_type;
	string5	 title;
    string20 fname;
    string20 mname;
    string20 lname;
    string5  name_suffix;
	string18 vendor_id;
	string1  jflag3;
	string30 temp_addr2;			// created from components below
	header.Layout_Source_ID;
  end
 ;


ssn(string	pF1
	,string	pM1
	,string	pL1
	,string	pF2
	,string	pM2
	,string	pL2
	,string	pSSN)
	:=
	function

	threshld	:=5;

	f1			:=trim(pF1,all);
	m1			:=trim(pM1,all);
	l1			:=trim(pL1,all);
	f2			:=trim(pF2,all);
	m2			:=trim(pM2,all);
	l2			:=trim(pL2,all);


	match1a	:=	if(length(f1)>1 and f2<>''	//	not needed
					,if(ut.NameMatch(Metaphonelib.DMetaPhone1(f1),'X','X'
									,Metaphonelib.DMetaPhone1(f2),'X','X') < threshld
						,1,0)
					,0);

	match1b	:=	if(length(f1)>1 and m2<>''
					,if(ut.NameMatch(Metaphonelib.DMetaPhone1(f1),'X','X'
									,Metaphonelib.DMetaPhone1(m2),'X','X') < threshld
						,1,0)
					,0);

	match1c	:=	if(length(f1)>1 and l2<>''
					,if(ut.NameMatch(Metaphonelib.DMetaPhone1(f1),'X','X'
									,Metaphonelib.DMetaPhone1(l2),'X','X') < threshld
						,1,0)
					,0);


	match2a	:=	if(length(m1)>1 and f2<>''
					,if(ut.NameMatch(Metaphonelib.DMetaPhone1(m1),'X','X'
									,Metaphonelib.DMetaPhone1(f2),'X','X') < threshld
						,1,0)
					,0);

	match2b	:=	if(length(m1)>1 and m2<>''
					,if(ut.NameMatch(Metaphonelib.DMetaPhone1(m1),'X','X'
									,Metaphonelib.DMetaPhone1(m2),'X','X') < threshld
						,1,0)
					,0);

	match2c	:=	if(length(m1)>1 and l2<>''
					,if(ut.NameMatch(Metaphonelib.DMetaPhone1(m1),'X','X'
									,Metaphonelib.DMetaPhone1(l2),'X','X') < threshld
						,1,0)
					,0);


	match3a	:=	if(length(f1)>1 and datalib.gender(f1) in ['M','F'] and f2<>''
					,if( datalib.gender(f1) = datalib.gender(if(ut.NameMatch(f1,'X','X'
																			,f2,'X','X') < threshld,f1,f2))
						,1,0)
					,0);

	match3b	:=	if(length(f1)>1 and datalib.gender(f1) in ['M','F'] and m2<>''
					,if( datalib.gender(f1) = datalib.gender(if(ut.NameMatch(f1,'X','X'
																			,m2,'X','X') < threshld,f1,m2))
						,1,0)
					,0);

	match3c	:=	if(length(f1)>1 and datalib.gender(f1) in ['M','F'] and l2<>''
					,if( datalib.gender(f1) = datalib.gender(if(ut.NameMatch(f1,'X','X'
																			,l2,'X','X') < threshld,f1,l2))
						,1,0)
					,0);


	match4a	:=	if(length(m1)>1 and datalib.gender(m1) in ['M','F'] and f2<>''
					,if( datalib.gender(m1) = datalib.gender(if(ut.NameMatch(m1,'X','X'
																			,f2,'X','X') < threshld,m1,f2))
						,1,0)
					,0);

	match4b	:=	if(length(m1)>1 and datalib.gender(m1) in ['M','F'] and m2<>''
					,if( datalib.gender(m1) = datalib.gender(if(ut.NameMatch(m1,'X','X'
																			,m2,'X','X') < threshld,m1,m2))
						,1,0)
					,0);

	match4c	:=	if(length(m1)>1 and datalib.gender(m1) in ['M','F'] and l2<>''
					,if( datalib.gender(m1) = datalib.gender(if(ut.NameMatch(m1,'X','X'
																			,l2,'X','X') < threshld,m1,l2))
						,1,0)
					,0);


	match5	:=	if(	ut.NameMatch(f1,m1,l1,f2,m2,l2) < threshld,1,0);


	match6a	:=	if(	f1[1]+m1[1]=f2 or f1[1]+m1[1]=m2,1,0);

	match6b	:=	if(	f2[1]+m2[1]=f1 or f2[1]+m2[1]=m1,1,0);


	match7a	:=	if(	f1[1]=f2[1] and m1[1]=m2[1],1,0);

	match7b	:=	if(	f1[1]=m2[1] and m1[1]=f2[1],1,0);


	match8a	:=	if(f1<>''
					,if(f1=f2 or f1=m2 or f1=l2,1,0)
					,0);

	match8b	:=	if(m1<>''
					,if(m1=f2 or m1=m2 or m1=l2,1,0)
					,0);


	match10a	:=	if(ut.NameMatch(f1,m1,'X',f2,m2,'X') < threshld,1,0);	//	not needed

	match10b	:=	if(ut.NameMatch(f1,'X','X',f2,'X','X') < threshld,1,0);


	match11a	:=	if(ut.NameMatch( Metaphonelib.DMetaPhone1(f1),Metaphonelib.DMetaPhone1(m1),'X'
									,Metaphonelib.DMetaPhone1(f2),Metaphonelib.DMetaPhone1(m2),'X')
									< threshld,1,0);

	match11b	:=	if(ut.NameMatch( Metaphonelib.DMetaPhone1(f1),'X','X'
									,Metaphonelib.DMetaPhone1(f2),'X','X')
									< threshld,1,0);

	score	:=	
				// (string)+match1a	//	not needed
				// +(string)match1b
				// +(string)match1c
				
				// +(string)match2a
				// +(string)match2b
				// +(string)match2c
				
				// +(string)match3a
				// +(string)match3b
				// +(string)match3c
				
				// +(string)match4a
				// +(string)match4b
				// +(string)match4c
				
				// +(string)match5

				// +(string)match6a
				// +(string)match6b

				// +(string)match7a
				// +(string)match7b

				// +(string)match8a
				// +(string)match8b

				// +(string)match10a	//	not needed
				// +(string)match10b

				// +(string)match11a
				// +(string)match11b
				// +match1a
				+match1b
				+match1c
				
				+match2a
				+match2b
				+match2c
				
				+match3a
				+match3b
				+match3c
				
				+match4a
				+match4b
				+match4c
				
				+match5

				+match6a
				+match6b

				+match7a
				+match7b

				+match8a
				+match8b

				// +match10a
				+match10b

				+match11a
				+match11b
				;

	// ssn	:=	if( length(trim(regexreplace('0',score,''),all)) > 0, score, '' );
	ssn	:=	if( score > 0, pSSN, '' );

	return	ssn;

end;


rNormalizedAddresses tNormalizeAddresses(dHeadersInNameCleaned pInput, unsigned1 pCounter)
 :=
  transform
  
    string9 ssn_1_2 := ssn(pInput.fname_1, pInput.minit_1, pInput.lname_1, pInput.fname_2, pInput.minit_2, pInput.lname_2, pInput.ssn);
	string9 ssn_1_3 := ssn(pInput.fname_1, pInput.minit_1, pInput.lname_1, pInput.fname_3, pInput.minit_3, pInput.lname_3, pInput.ssn);
	string9 ssn_1_4 := ssn(pInput.fname_1, pInput.minit_1, pInput.lname_1, pInput.fname_4, pInput.minit_4, pInput.lname_4, pInput.ssn);
  
    self.addr := choose(pCounter,
	               pInput.current_address,pInput.former1_address,pInput.former2_address,
				   pInput.current_address,pInput.former1_address,pInput.former2_address,
				   pInput.current_address,pInput.former1_address,pInput.former2_address,
				   pInput.current_address,pInput.former1_address,pInput.former2_address
				   );
    self.orig_city := choose(pCounter,
	                   pInput.current_city,pInput.former1_city,pInput.former2_city,
				       pInput.current_city,pInput.former1_city,pInput.former2_city,
				       pInput.current_city,pInput.former1_city,pInput.former2_city,
				       pInput.current_city,pInput.former1_city,pInput.former2_city
				       );
    self.orig_state := choose(pCounter,
	                    pInput.current_state,pInput.former1_state,pInput.former2_state,
				        pInput.current_state,pInput.former1_state,pInput.former2_state,
				        pInput.current_state,pInput.former1_state,pInput.former2_state,
				        pInput.current_state,pInput.former1_state,pInput.former2_state
				        );
    self.zip := choose(pCounter,
	             pInput.current_zip,pInput.former1_zip,pInput.former2_zip,
			     pInput.current_zip,pInput.former1_zip,pInput.former2_zip,
			     pInput.current_zip,pInput.former1_zip,pInput.former2_zip,
			     pInput.current_zip,pInput.former1_zip,pInput.former2_zip
			     );
    self.address_date_reported := choose(pCounter,
	             pInput.current_address_date_reported,pInput.former1_address_date_reported,pInput.former2_address_date_reported,
			     pInput.current_address_date_reported,pInput.former1_address_date_reported,pInput.former2_address_date_reported,
			     pInput.current_address_date_reported,pInput.former1_address_date_reported,pInput.former2_address_date_reported,
			     pInput.current_address_date_reported,pInput.former1_address_date_reported,pInput.former2_address_date_reported
			     );

	self.rec_type := choose(pCounter,
	               '1','2','2',
				   '2','2','2',
				   '3','3','3',
				   '3','3','3'
				   );
    
	self.title := pInput.title_1;				   
    self.fname := choose(pCounter,
	               pInput.fname_1,pInput.fname_1,pInput.fname_1,
				   pInput.fname_2,pInput.fname_2,pInput.fname_2,
				   pInput.fname_3,pInput.fname_3,pInput.fname_3,
				   pInput.fname_4,pInput.fname_4,pInput.fname_4
				   );
    self.mname := choose(pCounter,
	               pInput.minit_1,pInput.minit_1,pInput.minit_1,
				   pInput.minit_2,pInput.minit_2,pInput.minit_2,
				   pInput.minit_3,pInput.minit_3,pInput.minit_3,
				   pInput.minit_4,pInput.minit_4,pInput.minit_4
				   );
    self.lname := choose(pCounter,
	               pInput.lname_1,pInput.lname_1,pInput.lname_1,
				   pInput.lname_2,pInput.lname_2,pInput.lname_2,
				   pInput.lname_3,pInput.lname_3,pInput.lname_3,
				   pInput.lname_4,pInput.lname_4,pInput.lname_4
				   );
    self.name_suffix := choose(pCounter,
	                     pInput.name_suffix_1,pInput.name_suffix_1,pInput.name_suffix_1,
						 pInput.name_suffix_2,pInput.name_suffix_2,pInput.name_suffix_2,
						 pInput.name_suffix_3,pInput.name_suffix_3,pInput.name_suffix_3,
						 pInput.name_suffix_4,pInput.name_suffix_4,pInput.name_suffix_4
						 );
						 
	self.temp_addr2	:= address.Addr2FromComponents(self.orig_city,self.orig_state,self.zip);


    self.ssn := choose(pCounter,
					   pInput.ssn,pInput.ssn,pInput.ssn,

					   ssn_1_2,ssn_1_2,ssn_1_2,
					   ssn_1_3,ssn_1_3,ssn_1_3,
					   ssn_1_4,ssn_1_4,ssn_1_4
					   );

	self 			:= pInput;
end;

dNormalizedAddresses0			:=	normalize(dHeadersInNameCleaned,12,tNormalizeAddresses(left,counter));
//this is a tighter filter than what's in header.mac_normalize_header
dNormalizedAddresses            := dNormalizedAddresses0(fname<>'' and lname<>'' and addr<>'');

// count(dNormalizedAddresses(ssn=''));
// count(dNormalizedAddresses(ssn<>''));
// output(dNormalizedAddresses(length(trim(regexreplace('0',ssn,''),all))=1));
// dd:=dNormalizedAddresses(length(trim(regexreplace('0',ssn,''),all))=1)
// dd:=dNormalizedAddresses()
output(dNormalizedAddresses((trim(lname)='LUBER' and orig_state='NJ' and (trim(fname)='HAROLD' or trim(fname)='ESTA'))))
	: persist('~thor_data400::persist::jbello::dHeaders_selection')
	;

// r0:=record
	// dd.ssn;
	// cnt:=count(group,dd.ssn);
// end;

// t:=table(dd,r0,dd.ssn);

// output(sort(t
// (length(trim(ssn,all))>9)
// (length(trim(regexreplace('0',ssn,''),all))=1)
// ,ssn));



