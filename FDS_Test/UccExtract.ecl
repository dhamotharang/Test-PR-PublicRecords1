import uccv2;
slimMainRec := record
			string31 	tmsid;	
			string23 	rmsid;	
			string8  	process_date;				
			string14 	orig_filing_number;				
			string8  	orig_filing_date;				 	
			string14 	filing_number;				 	
			string40 	filing_type;	
			string8  	filing_date;				
			string3  	filing_jurisdiction;					
			string512	collateral_desc;
			// string30	status_type;
			string8     expiration_date;
			string40    orig_filing_type;
			end;

combinedRec := record
			string31 	tmsid;	
			string23 	rmsid;
			string8  	process_date;				
			string      record_id;
			string1  	Party_type;            
			string20	c_fname;
			string20	c_mname;
			string20	c_lname;
			string5		c_name_suffix;
			string60	c_company_name;
			string10	c_prim_range;
			string2		c_predir;
			string28	c_prim_name;
			string4		c_suffix;
			string2		c_postdir;
			string10	c_unit_desig;
			string8		c_sec_range;
			string25	c_p_city_name;
			string2		c_st;
			string5		c_zip5;
			string4		c_zip4;	
			string20	d_fname;
			string20	d_mname;
			string20	d_lname;
			string5		d_name_suffix;
			string60	d_company_Name;
			string10	d_prim_range;
			string2		d_predir;
			string28	d_prim_name;
			string4		d_suffix;
			string2		d_postdir;
			string10	d_unit_desig;
			string8		d_sec_range;
			string25	d_p_city_name;
			string2		d_st;
			string5		d_zip5;
			string4		d_zip4;				
			string1     zipFlag;  //'1' = in requested zips
			integer1    debtor_cnt;
			integer1    creditor_cnt;
			integer1    filing_cnt;
			string5     sourceZip;							
			string14 	orig_filing_number;	
			string8  	orig_filing_date;				 	
			string14 	filing_number;				 	
			string40 	filing_type;	
			string8  	filing_date;				
			string3  	filing_jurisdiction;					
			string512	collateral_desc;
			// string30	status_type;
			string8     expiration_date;
			string40    orig_filing_type;
			end;
	
extractRec := record
			string  sourceZip;
			string 	record_id;	
			string 	d_fName;	
			string 	d_mName;
			string 	d_lName;
			string 	d_companyName;
			string 	d_street1;				
			string 	d_street2;
			string 	d_city;
			string 	d_state;
			string 	d_zip;			
			string 	c_fName;	
			string 	c_mName;
			string 	c_lName;
			string 	c_companyName;
			string 	c_street1;				
			string 	c_street2;
			string 	c_city;
			string 	c_state;
			string 	c_zip;				 	
			string 	filing_date;				 	
			string 	filing_type;	
			string 	filing_jurisdiction;				
			string 	filing_count;					
			string	filing_number;
			string  original_filing_number;
			string	original_filing_date;
			string	document_count;
			string	debtor_count;
			string	secured_count;
			string	collateral_desc;
			// string	status_type;
			string  expiration_date;
			string  orig_filing_type;
			end;	

//Get set of Party tmsids in order to know which Mains to use		  
zipPartyTmsids := dedup(sort(distribute(uccv2.File_UCC_Party_Base(zip5 in FDS_Test.ZipcodeSet),
			  hash(tmsid)),
			  tmsid,local),
			  tmsid,local);			 
			  // : persist('~thor_data400::persist::fds_ucc::zip_party_tmsids');			  
			  
//Get all the Party records that will be used (zip tmsids + associated tmsids)
dsP := distribute(uccv2.File_UCC_Party_Base,hash(tmsid));

recordof(dsP) getPartys(dsP L) := transform
	self := L;
	end;
	
selectedPartys := join(dsP,zipPartyTmsids,    
				 left.tmsid = right.tmsid,				
				 getPartys(left),local);
				 // : persist('~thor_data400::persist::fds_ucc::all_Partys_for_zip_tmsids');

//Assign a zipFlag and set sourceZip for the Party recs to be used.				 
layout_flagged_Party := record
recordof(selectedPartys);
string1 zipFlag;
string5 sourceZip;
integer c_count;
integer d_count;
integer f_count;
end;

layout_flagged_Party setFlag(selectedPartys L) := transform
	self.zipFlag := if(L.zip5 in FDS_Test.ZipcodeSet,
					   '1',
					   '0');
	self.sourceZip := if(L.zip5 in FDS_Test.ZipcodeSet,
					   L.zip5,
					   '');
    self := L;
	self := [];
	end;

allPartys := project(selectedPartys,setFlag(left)); 
					  // :	persist('~thor_data400::persist::fds_ucc::all_partys_to_use_flagged');

//Populate the Source Zip with the first Source Zip encountered for a tmsid
//Needed to keep associated tmsids together when doing a final sort on zip						
layout_flagged_Party popSourceZips(allPartys L,allPartys R,integer cntr) := transform
	self.sourceZip := if(cntr=1,
						 R.sourceZip,
						 L.sourceZip);
	self := R;
	end;

allPartys2 := iterate(group(sort(distribute(allPartys,hash(tmsid)),
						   tmsid,-sourceZip,local),
						   tmsid,local),
						   popSourceZips(left,right,counter));
						   // : persist('~thor_data400::persist::fds_ucc::popSourceZips');
						   						  		
//Sort and dedup the flagged fullParty file (zip tmsids + associated tmsids)
dedupedAllPartys := dedup(sort(distribute(allPartys2,hash(tmsid,rmsid)),
								tmsid,rmsid,party_type,
								fname,mname,lname,company_name,
								prim_name,suffix,p_city_name,st,zip5,local),
								tmsid,rmsid,party_type,
								fname,mname,lname,company_name,
								prim_name,suffix,p_city_name,st,zip5,local);
								// : persist('~thor_data400::persist::fds_ucc::all_partys_to_use');			  		

//Get the creditor and debtor counts 
tempLayout1 := record
dedupedAllPartys.tmsid;
dedupedAllPartys.rmsid;
integer d_count := sum(group,if(dedupedAllPartys.party_type='D',1,0));
integer c_count := sum(group,if(dedupedAllPartys.party_type in ['C','S','A'],1,0));
end;

t1 := table(dedupedAllPartys,tempLayout1,tmsid,rmsid,local); 
            // : persist('~thor_data400::persist::fds_ucc::dc_counts');		  

//Get the filing counts 
tempLayout2 := record
dedupedAllPartys.tmsid;
integer f_count := count(group);
end;

fcntRecs0 := distribute(dedupedAllPartys,hash(tmsid));
fcntRecs1 := sort(fcntRecs0,tmsid,rmsid,local);
fcntRecs2 := dedup(fcntRecs1,tmsid,rmsid,local);

  t2 := table(fcntRecs2,tempLayout2,tmsid,local);
			// : persist('~thor_data400::persist::fds_ucc::filing_counts');

// ********************* Below - add counts to structure
recordof(dedupedAllPartys) add_dc_counts(dedupedAllPartys L,t1 R) := transform
			self := R;
			self := L;
			end;
			
added_dc_counts := join(dedupedAllPartys,t1,
						left.tmsid=right.tmsid and
						left.rmsid=right.rmsid,
						add_dc_counts(left,right),local);
						// : persist('~thor_data400::persist::fds_ucc::added_dc_counts');

recordof(dedupedAllPartys) add_f_counts(added_dc_counts L,t2 R) := transform
			self := R;
			self := L;
			end;
		
dist_added_dc_counts := distribute(added_dc_counts,hash(tmsid));		
added_f_counts := join(dist_added_dc_counts,t2,
						left.tmsid=right.tmsid,						
						add_f_counts(left,right),local);
						// : persist('~thor_data400::persist::fds_ucc::added_f_counts');						
						
// ********************* Above - add counts to structure

d_added_f_counts := distribute(added_f_counts,hash(tmsid,rmsid));

//separate the party types		 
creditors := d_added_f_counts(party_type in ['C','S','A']);
debtors   := d_added_f_counts(party_type = 'D');

combinedRec combineRecs(creditors L, debtors R) := transform
			self.tmsid := r.tmsid;
			self.rmsid := r.rmsid;
			self.d_fName := trim(r.fname,left,right);	
			self.d_mName := trim(r.mname,left,right);
			self.d_lName := trim(r.lname,left,right);
			self.d_Name_suffix := trim(r.name_suffix,left,right);
			self.d_company_Name := trim(r.company_name,left,right);
			self.d_prim_range := trim(r.prim_range,left,right);	
			self.d_predir := trim(r.predir,left,right);
			self.d_prim_name := trim(r.prim_name,left,right);
			self.d_suffix := trim(r.suffix,left,right);
			self.d_postdir := trim(r.postdir,left,right);								 
			self.d_unit_desig  := trim(r.unit_desig,left,right);
			self.d_sec_range  := trim(r.sec_range,left,right);
			self.d_p_city_name := trim(r.p_city_name,left,right);
			self.d_st := trim(r.st,left,right);
			self.d_zip5		 := trim(r.zip5,left,right);
			self.d_zip4		 := trim(r.zip4,left,right);
			self.c_fName	 := trim(l.fname,left,right);
			self.c_mName := trim(l.mname,left,right);
			self.c_lName := trim(l.lname,left,right);
			self.c_Name_suffix := trim(l.name_suffix,left,right);
			self.c_company_Name  :=  trim(l.company_name,left,right);
			self.c_prim_range := trim(l.prim_range,left,right);	
			self.c_predir := trim(l.predir,left,right);
			self.c_prim_name := trim(l.prim_name,left,right);
			self.c_suffix := trim(l.suffix,left,right);
			self.c_postdir := trim(l.postdir,left,right);								 
			self.c_unit_desig  := trim(l.unit_desig,left,right);
			self.c_sec_range  := trim(l.sec_range,left,right);
			self.c_p_city_name := trim(l.p_city_name,left,right);
			self.c_st := trim(l.st,left,right);
			self.c_zip5	 := trim(l.zip5,left,right);
			self.c_zip4	 := trim(l.zip4,left,right);
			self.sourceZip := if(l.sourceZip<>'',
								 l.sourceZip,
								 if(r.sourceZip<>'',
									r.sourceZip,
									''));
			self.zipFlag := if(l.zipFlag<>'',
								 l.zipFlag,
								 if(r.zipFlag<>'',
									r.zipFlag,
									''));
			self.debtor_cnt := if(l.d_count<>0,
								 l.d_count,
								 if(r.d_count<>0,
									r.d_count,
									0));
			self.creditor_cnt := if(l.c_count<>0,
								 l.c_count,
								 if(r.c_count<>0,
									r.c_count,
									0));
			self.filing_cnt := if(l.f_count<>0,
								 l.f_count,
								 if(r.f_count<>0,
									r.f_count,
									0));
			self := [];
	end;

combinedZipPartys := join(creditors,debtors,
						left.tmsid=right.tmsid and
						left.rmsid=right.rmsid,
						combineRecs(left,right),local);
						// : persist('~thor_data400::persist::fds_ucc::combined_zip_partys'); 						

//Get all Main recs then dedup for most current tmsid
Main := uccv2.File_UCC_Main_Base;
slimMain := project(Main,transform(slimMainRec,self:=left));							   
dMain := distribute(slimMain,hash(tmsid,rmsid));
MainSort := sort(dMain,tmsid,rmsid,-process_date,local);						   
MainDedup := dedup(MainSort,tmsid,rmsid,local);
					// : persist('~thor_data400::persist::fds_ucc::all_main_tmsid_rmsid');
distMainDedup := distribute(MainDedup,hash(tmsid));

//Get Main recs associated with the set of Party recs being used and dedup results
//This provides a set of Mains to use as a starting point to build vendor records.
slimMainRec getMains(MainDedup L) := transform
	self := L;
	end;
	
matchedMains := join(distMainDedup,zipPartyTmsids,    
				 left.tmsid = right.tmsid,				
				 getMains(left),local);
				 // : persist('~thor_data400::persist::fds_ucc::zip_mains');	
dedupedMain := dedup(sort(matchedMains,record),record);			 
				 
//Join combinedZipPartys and deDupedMain
//This provides a set of Mains to use as a starting point to build vendor records.
combinedRec getMainInfo(combinedZipPartys L,dedupedmain R) := transform
	self := R;
	self := L;
	end;
	
combined := join(combinedZipPartys,dedupedmain,
				 trim(left.tmsid,left,right) = trim(right.tmsid,left,right) and
				 trim(left.rmsid,left,right) = trim(right.rmsid,left,right),
				 getMainInfo(left,right));
				 // : persist('~thor_data400::persist::fds_ucc::combined');

//Get rid of duplicate records				 
dedupedCombined := dedup(sort(distribute(combined,hash(tmsid)),record,local),record,local);
				   // : persist('~thor_data400::persist::fds_ucc::deduped_combined');

combinedRec setDate(combinedRec L,combinedRec R,integer cntr) := transform
	  self.orig_filing_date := if(cntr=1,
							      R.orig_filing_date,
								  if(R.orig_filing_date<>'',
								     R.orig_filing_date,
									 L.orig_filing_date));
	  self := R;
	  end;

ds2 := iterate(group(sort(distribute(dedupedCombined,hash(tmsid)),
					 tmsid,-orig_filing_date,local),
					 tmsid,local),
					 setDate(left,right,counter));

finalSelect := dedup(sort(group(ds2),sourceZip,tmsid,rmsid,filing_date,process_date,-zipFlag),
					 tmsid,keep(5));
					 
//Populate the record_ids
recordof(finalSelect) setRecordID(finalSelect L,finalSelect R) := transform
	self.record_ID := if(L.record_ID = '',
						'1',
						if(L.tmsid = R.tmsid,
							L.record_ID,
							(string)((integer)L.record_ID + 1)));
    self := R;
	end;
							
results1 := iterate(finalSelect,setRecordID(left,right));
// results2 := sort(results1,sourceZip,-zipFlag,tmsid,rmsid,filing_date,process_date);
results2 := sort(results1,sourceZip,tmsid,rmsid,filing_date,process_date,-zipFlag);

//Build final records
extractRec  popFinal(results2 L) := transform
	self.sourceZip  := l.sourceZip;
	self.record_id  := 	l.record_id;
	self.d_fName  := 	l.d_fname;
	self.d_mName  := l.d_mname;
	self.d_lName  := l.d_lname;
	self.d_companyName  := l.d_company_Name;
	self.d_street1  := 	trim(trim(l.d_prim_range,left,right) + ' ' +	
						   trim(l.d_predir,left,right)  + ' ' +
						   trim(l.d_prim_name,left,right)  + ' ' + 
						   trim(l.d_suffix,left,right)  + ' ' +
						   trim(l.d_postdir,left,right)
						   ,left,right);		
	self.d_street2  :=  trim(trim(l.d_unit_desig,left,right) + ' ' +	
							trim(l.d_sec_range,left,right)  
								,left,right);
	self.d_city  := l.d_p_city_name;
	self.d_state  := l.d_st;
	self.d_zip  := 	l.d_zip5;		
	self.c_fName  := l.c_fname;	
	self.c_mName  := l.c_mname;
	self.c_lName  := l.c_lname;
	self.c_companyName  := l.c_company_Name;
	self.c_street1  := 	trim(trim(l.c_prim_range,left,right) + ' ' +	
						   trim(l.c_predir,left,right)  + ' ' +
						   trim(l.c_prim_name,left,right)  + ' ' + 
						   trim(l.c_suffix,left,right)  + ' ' +
						   trim(l.c_postdir,left,right)
						   ,left,right);			
	self.c_street2  :=  trim(trim(l.c_unit_desig,left,right) + ' ' +	
							trim(l.c_sec_range,left,right)  
								,left,right);
	self.c_city  := l.c_p_city_name;
	self.c_state  := l.c_st;
	self.c_zip  := 	l.c_zip5;			 	
	self.filing_date  := l.filing_date[5..8]+l.filing_date[1..4];
	self.filing_type  := trim(l.filing_type,left,right);								
	self.filing_jurisdiction  := l.filing_jurisdiction;	
	self.filing_count  := 	(string)l.filing_cnt;
	self.filing_number  := l.filing_number;
	self.original_filing_number  := l.orig_filing_number;
	self.original_filing_date  := l.orig_filing_date[5..8]+l.orig_filing_date[1..4];
	self.document_count  := '';
	self.debtor_count  := (string)l.debtor_cnt;
	self.secured_count  := (string)l.creditor_cnt;
	self.collateral_desc  := trim(l.collateral_desc,left,right);
	// self.status_type    := trim(l.status_type,left,right);
	self.expiration_date  := l.expiration_date[5..8]+l.expiration_date[1..4];
	self.orig_filing_type := trim(l.orig_filing_type,left,right);
	end;

results3 := project(results2,popFinal(left))
			: persist('~thor_data400::persist::fds_ucc::extract_final');

output(choosen(results3,1000),named('FDS_Final_Results'));

output(results3,,'~thor_data400::temp::fds_test::ucc::extract_final',csv(separator('|')),overwrite);

export UccExtract := results3;
 
