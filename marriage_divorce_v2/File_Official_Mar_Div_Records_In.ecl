import ut;


filter1_ds := dataset('~thor_200::out::official_records_marriage_divorce_party',marriage_divorce_v2.Layout_Official_Mar_Div_Records_In,flat,OPT);






 filter2_ds:= filter1_ds( not(  state_origin = 'CO' or
																state_origin = 'KY' or
																state_origin = 'ME' or
																state_origin = 'NC' or
																state_origin = 'NV' or
																state_origin = 'OH' or
																state_origin = 'TX' or
															(	regexfind('CIRCUIT',filter1_ds.entity_nm)) or 
															( state_origin = 'CT' and filing_type = '3') or
														  (	state_origin = 'CA' and stringlib.stringtouppercase(trim(county_name)) = 'EL DORADO'))); 





filter3_ds := filter2_ds( regexfind('STATE',entity_nm,nocase)=false and
													regexfind('^STATE ',entity_nm,nocase)= false and
													regexfind(' COUNTY ',entity_nm,nocase)= false and
													regexfind('^COUNTY ',entity_nm,nocase)= false and
													regexfind(' GRANTEE INDEXED ',entity_nm,nocase)= false and
													regexfind('^GRANTEE INDEXED',entity_nm,nocase)= false and
													regexfind('STATE ',entity_nm,nocase)=false and
													regexfind('ST OF ',entity_nm,nocase)=false and
													regexfind('GRANTOR',entity_nm,nocase)=false and
													regexfind('GRANTEE',entity_nm,nocase)=false and
													regexfind('CHILDREN',entity_nm,nocase)=false and	
													regexfind('TO WHOM IT MAY CONCERN',entity_nm,nocase)=false and
													trim(stringlib.stringtouppercase(entity_nm),left,right) != 'OMIT' and
													trim(stringlib.stringtouppercase(entity_nm),left,right) != 'NONE');
													



/*
output(filter3_ds(official_record_key='171349348021' or 
													official_record_key='171340252021' or
													official_record_key='171335094021' or
													official_record_key='171335093021' or
													official_record_key='17133671021'));

*/													
layout_join_record := record
  string8 process_date;
  string2 vendor;
  string2 state_origin;
  string30 county_name;
  string60 official_record_key;
  string25 doc_instrument_or_clerk_filing_num;
  string8 doc_filed_dt;
  string60 doc_type_desc;
	string1 filing_type;
  string5 entity_sequence;
  string15 entity_type_cd;
  string50 entity_type_desc;
  string80 entity_nm;
  string1 entity_nm_format;
  string8 entity_dob;
  string9 entity_ssn;
  string5 title1;
  string20 fname1;
  string20 mname1;
  string20 lname1;
  string5 suffix1;
  string3 pname1_score;
 	string1 master_party_type_cd;
	string30 county_name2:='';
	string60 official_record_key2:='';
	string25 doc_instrument_or_clerk_filing_num2:='';
	string8 doc_filed_dt2:='';
	string60 doc_type_desc2:='';
	string50 entity_type_desc2:='';
	string1 filing_type2:='';
	string80 entity_nm2:='';
	string1 entity_nm_format2:='';
	string5 title2:='';
  string20 fname2:='';
  string20 mname2:='';
  string20 lname2:='';
	string3 pname2_score:='';
  string1 master_party_type_cd2:='';	
	boolean grantor:=false;
	boolean grantee:=false;
	end;

distribFilterRecs := distribute(filter3_ds,hash(official_record_key));
	
//copy original dataset into rec structure below to later join and only keep records with pairs.
r1 := record
 distribFilterRecs.official_record_key;
 integer official_record_key_ct := 1;
end;


r1 t1(distribFilterRecs le) := transform
 self := le;
end;

p1 := project(distribFilterRecs,t1(left));

r1 t2(p1 le, p1 ri) := transform
 self.official_record_key_ct := le.official_record_key_ct+1;
 self             := le;
end;


p2 := rollup(p1,left.official_record_key=right.official_record_key,t2(left,right),local);


keep_those_with_only_2 := p2(official_record_key_ct=2);

layout_join_record t_join_back_to_orig(marriage_divorce_v2.Layout_Official_Mar_Div_Records_In le, keep_those_with_only_2 ri) := transform
 self := le;
end;

ds_with_only_2 := join(distribFilterRecs,keep_those_with_only_2,left.official_record_key=right.official_record_key,t_join_back_to_orig(left,right),local);



layout_join_record tjoinupparties(layout_join_record l, layout_join_record r) :=
transform
  boolean left_Grantor 													:= (l.master_party_type_cd='1' and r.master_party_type_cd='5'); 
  boolean right_Grantee 												:= (r.master_party_type_cd='5' and l.master_party_type_cd='1');
	
  self.county_name															:= l.county_name;
	self.official_record_key											:= l.official_record_key;
  self.doc_instrument_or_clerk_filing_num				:= l.doc_instrument_or_clerk_filing_num;
	self.doc_filed_dt															:= l.doc_filed_dt;
	self.doc_type_desc													  := l.doc_type_desc;
	self.filing_type															:= l.filing_type;
	self.entity_nm															  := if(left_Grantor,l.entity_nm,r.entity_nm);
	self.entity_nm_format													:= if(left_Grantor,l.entity_nm_format,r.entity_nm_format);
	self.entity_type_desc											    := if(left_Grantor,l.entity_type_desc,r.entity_type_desc);
	self.title1																		:= if(left_Grantor,l.title1,r.title1);
  self.fname1																		:= if(left_Grantor,l.fname1,r.fname1);
  self.mname1																		:= if(left_Grantor,l.mname1,r.mname1);
  self.lname1																		:= if(left_Grantor,l.lname1,r.lname1);
	self.pname1_score															:= if(left_Grantor,l.pname1_score,r.pname1_score);
  self.master_party_type_cd											:= if(left_Grantor,l.master_party_type_cd,r.master_party_type_cd);



  self.county_name2															:= r.county_name;
  self.official_record_key2											:= r.official_record_key;
  self.doc_instrument_or_clerk_filing_num2			:= r.doc_instrument_or_clerk_filing_num;
	self.doc_filed_dt2														:= r.doc_filed_dt;
	self.doc_type_desc2													  := r.doc_type_desc;
	self.filing_type2															:= r.filing_type;
	self.entity_nm2															  := if(right_Grantee,r.entity_nm,l.entity_nm);
	self.entity_nm_format2												:= if(right_Grantee,r.entity_nm_format,l.entity_nm_format);
	self.entity_type_desc2											  := if(right_Grantee,r.entity_type_desc,l.entity_type_desc);
	self.title2																		:= if(right_Grantee,r.title1,l.title1);
  self.fname2																		:= if(right_Grantee,r.fname1,l.fname1);
  self.mname2																		:= if(right_Grantee,r.mname1,l.mname1);
  self.lname2																		:= if(right_Grantee,r.lname1,l.lname1);
	self.pname2_score															:= if(right_Grantee,r.pname1_score,l.pname1_score);
  self.master_party_type_cd2										:= if(right_Grantee,r.master_party_type_cd,l.master_party_type_cd);
  self.grantor																  := left_Grantor;
	self.grantee																	:= right_Grantee;
  self	:= l;
end;


join_parties := join(ds_with_only_2
										 ,ds_with_only_2
										 ,left.official_record_key = right.official_record_key and
										  left.entity_nm != right.entity_nm
										 ,tjoinupparties(left,right)
										 ,local
										);


dedupedRecords := dedup(join_parties,official_record_key,local);


export File_Official_Mar_Div_Records_In := dedupedRecords;