import Address,Ut,_Validate,did_add,header,header_slimsort, didville, did_add,watchdog,_control;

export fn_build_death_appendAddy(string filedt) := function 

file_in := Death_Master.File_SSADeathmaster; 

temp_rec := record 

   string1  rec_type;
   string9  ssn;
   string20 lname;
   string4  name_suffix;
   string15 fname;
   string15 mname;
   string1 VorP_code;
   string8 dod8;
   string8 dob8;
   string2 st_country_code;
   string5 zip_lastres;
   string5 zip_lastpayment;
   string7 Blank :='';
   string2 state := '' ; 
   string5 zip5; 
   unsigned6 did := 0;
   unsigned1 did_score := 0;
   string10 phone_number:=''; 
   string1 source:='3';
   string35	Address1:='';
   string35	Address2:='';
   string35	City:='';
   string2 lf:='\r\n';
   
end; 

temp_rec reformat(file_in l ) := transform 

 
string73  clean_name := Address.CleanPersonLFM73(trim(l.lname,all) + ' '+trim(l.fname,all)+' '+ trim(l.mname,all)+' '+trim(l.name_suffix,all));

self.ssn := if(trim(l.ssn,all) in ['000000000', '111111111',
                                  '222222222','333333333','444444444','555555555', 
                                  '666666666','777777777','888888888','999999999','123456789'],'',l.ssn) ; 


self.fname :=  trim(clean_name[6..25],left,right)			    ;
self.mname := trim(clean_name[26..45],left,right)			;
self.lname := trim(clean_name[46..65],left,right)			;
self.name_suffix := trim(clean_name[66..70] ,left,right);
self.zip5 :=  if(trim(l.zip_lastres) != '', l.zip_lastres, l.zip_lastpayment);

self := l ;
end; 

mast_ready := project(file_in,reformat(left)); 

matchset := ['D','S','Z'];

did_add.mac_match_flex(mast_ready, matchset, 
                       ssn, dob8,
											 fname, mname, lname, name_suffix,
											 foo, foo, foo, zip5, state, foo,
											 did, temp_rec,
                       true, did_score, 90,
											 mast_did) ;


 best_phone := watchdog.File_Best_nonglb(phone!='');
 
 mast_did_dist := distribute(mast_did(rec_type <> 'D'),hash(did)); 
 best_phone_dist := distribute(best_phone,hash(did));
 
 recordof(mast_did_dist) tgetphone(recordof(mast_did_dist) l	,recordof(best_phone_dist) r) :=
		transform
		self.phone_number							:=r.phone;
		self 										:= l;
		end;
		
		getPhones	:= join( mast_did_dist
											,best_phone_dist
											,left.did = right.did
											,tgetphone(left,right)
											,left outer
											,local) : persist('~persist::death_phone');

transunion_NonGLB := Header.File_Transunion_did  +  Header.file_TUCS_did + Header.File_TN_did;
// remove transuinion records which already exist in header 

recordof(transunion_NonGLB) tjoin(recordof(transunion_NonGLB) l	,recordof(header.File_Headers_NonGLB) r) :=
		transform
		
		self 						:= l;
		end;
		
		trnsoutdups	:= join( distribute(transunion_NonGLB,hash(did))
							,distribute(header.File_Headers_NonGLB ,hash(did)),
						 left.did=right.did and 
		                 left.prim_range= right.prim_range and
			             left.prim_name = right.prim_name  and
			             left.sec_range = right.sec_range  and
			             left.zip       = right.zip
						,tjoin(left,right)
						,left only
						,local);

 
headerwtransunion := trnsoutdups + header.File_Headers_NonGLB ;

header.MAC_Best_Address(headerwtransunion ,did,10,headerwadd,true);

//header_dist := distribute(headerwadd,hash(did)); 

header_dist :=dedup(sort(distribute(headerwadd,hash(did)),did,prim_name,prim_range,sec_range,zip,local),did,prim_name,prim_range,sec_range,zip,local);

recordof(getPhones) tgetadd(recordof(getPhones) l	,recordof(header_dist) r) :=
		transform
		
		self.source     :='4';
		self.Address1   :=trim(r.prim_range,left,right)+' '+trim(r.predir,left,right)+' '+trim(r.prim_name,left,right)+' '+trim(r.suffix,left,right)+' '+trim(r.postdir,left,right); 
		self.Address2   :=trim(r.unit_desig,left,right)+' '+trim(r.sec_range,left,right); 
		self.City				:=r.city_name;
		self.State			:=r.st;
		self.zip_lastres			  :=r.zip;
		
		self 						:= l;
		end;
		
		RecsWithAddy	:= join( distribute(getPhones,hash(did))
								   ,header_dist
								,left.did = right.did
								,tgetadd(left,right)
								,left outer
								,local);


recordof(RecsWithAddy) tbadAddress(RecsWithAddy l) := transform

self.Address1 := if (regexfind('(DOD:|DOD :)',trim(l.Address1,left,right)),'',trim(l.Address1,left,right));
self :=l;
end;
fixedAddy_ds := project(RecsWithAddy, tbadAddress(left));

//take out all blank addresses.
FiltWithAddy := fixedAddy_ds(Address1 <>'' );

distribRecs := distribute(FiltWithAddy,hash(did,ssn,dod8,zip_lastres,address1,address2));
sortedRecs  := sort(distribRecs,did,ssn,dod8,zip_lastres,address1,address2,local);
dedupedRecs := dedup(sortedRecs,did,ssn,dod8,zip_lastres,address1,address2,local);

allRecs :=  mast_ready + dedupedRecs;

final_layout := record
string1		add_del_flag;
string9		ssn;
string20	Last_Name;
string4		Suffix;
string15	First_Name;
string15	Middle_Name;
string1		Verify;
string8		dod;
string8		dob ;
string2		State_last_residence;
string5		Zip_Codelast_residence;
string5		Zip_LumpSum_Payment;
string7		Blank;
string35	Address1_lastresidence;
string35	Address2_lastresidence;
string35	City_last_residence;
string10	Phone_Number;
string1		Source; 
string2   lf; 
end;

final_layout tfinal(allRecs l) := transform
self.add_del_flag:=l.rec_type;
self.Last_Name:=trim(l.lname,left,right);
self.Suffix:=trim(l.name_suffix,left,right);
self.First_Name:=trim(l.fname,left,right);
self.Middle_Name:=trim(l.mname,left,right);
self.Verify:=l.VorP_code;
self.dod:=l.dod8;
self.dob:=l.dob8;
self.State_last_residence:=l.state;
self.Zip_Codelast_residence:=l.zip_lastres;
self.Zip_LumpSum_Payment:=l.zip_lastpayment;
self.Address1_lastresidence:=l.address1;
self.Address2_lastresidence:=l.address2;
self.City_last_residence:=l.city;
self.Phone_Number:=l.phone_number;
self := l;
end;
 
final_ds := project(allRecs, tFinal(left));

write_out:= output(sort(final_ds,ssn,Source),,'~thor_data400::out::'+filedt+'_death_mnpls',Overwrite); 

DestinationIP :=_control.IPAddress.edata12;   
 
despray  :=fileservices.despray( '~thor_data400::out::'+filedt+'_death_mnpls', DestinationIP, '/hds_4/death_mnpls_update/death_mnpls_'+filedt+'.d00',,,,TRUE) ; 

send_email := fileservices.SendEmail('kgummadi@seisint.com,akayttala@seisint.com,','New death MN file is available on edata12 /hds_4/death_mnpls_update/death_mnpls_'+filedt+'.d00','');

desprayfile :=  sequential(write_out,despray) :success(send_email), failure(FileServices.sendemail('akayttala@seisint.com', 'death_mnpls_update failed to despray', failmessage));

return desprayfile;

end;








