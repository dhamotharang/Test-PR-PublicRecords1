
  
import  Address, did_add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville,paw, Ingenix_NatlProf,lib_fileservices,_control,Martindale_Hubbell;

export cjr_test:=function

AutoInsu_rec:=record
	string 		Consumer_ID;
	string 		DID;
	string 		LinkID;
	string 		FIRST_NAME;
	string 		MIDDLE_NAME;
	string 		LAST_NAME;
	string 		APT_NBR;
	string 		HOUSE_NBR;
	string 		STREET;
	string 		CITY;
	string 		STATE;
	string 		ZIP;
	string 		ZIP4;
	string 		SSN;
	string 		DOB;
end;


AutoInsu_ds:=dataset(ut.foreign_prod + '~thor_data400::data_in::autoinsuapp',AutoInsu_rec,CSV(HEADING(1),SEPARATOR([',']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));

         		Upper(string s) := function
         			 return stringlib.StringToUppercase(s); 
         		end;
slim_AutoInsu_rec :=record
	string 		Consumer_ID;
	//string 		DID;
	string 		LinkID;
	string 		FIRST_NAME;
	string 		MIDDLE_NAME;
	string 		LAST_NAME;
	string 		APT_NBR;
	string 		HOUSE_NBR;
	string 		STREET;
	string 		CITY;
	string 		STATE;
	string 		ZIP;
	string 		ZIP4;
	string 		SSN;
	string 		DOB;
	string name;
   	string fname;
	string mname;
   	string lname;
	string name_suffix;
   	string temp1_address1;
   	string temp1_address2;
   	string prim_range;
	string predir;
   	string prim_name; 
    string sec_range;
	string Suffix ;  
	string postdir ;
	string unit_desig ;
	string street_address;
   	string p_city_name;
   	//string v_city_name;
	string clean_st;
	string clean_zip;
	string clean_zip4;
end;



 remove (string d):=function
   t:=lib_stringlib.StringLib.StringFind(d, '/', 1);
  
    dob:= if(length(d)=8,d[5..8]+'0'+d[1]+'0'+d[3], //		4/7/1989
	      if(length(d)=10,d[7..10]+d[1..2]+d[4..5], // 07/08/1978
	      if(length(d)=9 and t=2,d[6..9]+'0'+d[1]+d[3..4],d[6..9]+d[1..2]+'0'+d[4])));  // 12/5/1978 &  2/15/1978
    return dob;
    end;
 
slim_AutoInsu_rec Trans_slim(  AutoInsu_rec l) := transform
   	self.name               					:=trim( Upper(l.first_name))+ trim(' '+Upper(l.MIDDLE_NAME))+trim(' '+Upper(l.last_name));
   	string73 tempname 							:=Address.CleanPerson73(trim( Upper(l.first_name))+ trim(' '+Upper(l.MIDDLE_NAME))+trim(' '+Upper(l.last_name)));
   	self.fname									:=tempname[6..25];
	self.mname								    :=tempname[26..45];
	self.lname									:=tempname[46..65];
	self.name_suffix                            :=tempname[66..70];  
   	self.dob                                    :=if(l.dob<>'' and (integer)remove(l.dob)<>0 ,remove(l.dob),'');
	self.ssn                                    :=if(l.ssn<>'' and (integer)l.ssn<>0 ,trim(l.ssn,left,right),'');
	
    self.temp1_address1							:= trim( Upper(l.HOUSE_NBR))+ trim(' '+Upper(l.STREET))+trim(' '+Upper(l.APT_NBR));
												
    self.temp1_address2							:= trim(Upper(l.CITY ))+trim( ' ' + Upper(l.state) )+ trim(' ' + Upper(l.ZIP));
	self.clean_st								:= trim(Upper(l.state),left,right);
	self.city                                   :=trim(Upper(l.CITY ),left,right);
	self.clean_zip                              :=if(l.zip<>'' and (integer)l.zip<>0 ,l.ZIP,'');
	self.clean_zip4                             :=if(l.zip4<>'' and (integer)l.zip4<>0 ,l.ZIP4,'');
   	self										:=l;
    self										:=[];
 end;
            clean_CJR:= project(AutoInsu_ds,Trans_slim(left)); 
			
            
            Address.MAC_Address_Clean( clean_CJR,  //input file
            				          temp1_address1,       //addr1
            				          temp1_address2,       //addr2
            				          true,                  
            				          Clean_Addr_File)       //output file
            
     slim_AutoInsu_rec getAddrCache(Clean_Addr_File l):= transform
            	self.prim_range    						:= l.clean[1..10];
				self.predir							    :=l.clean[11..12];
            	self.prim_name 	  						:= l.clean[13..40];
            	self.sec_range 	  						:= l.clean[57..64];
				self.Suffix                             :=l.clean[41..44];
				self.postdir                            :=l.clean[45..46];
				self.unit_desig                         :=l.clean[47..56];
				
				self.street_address						:=trim(l.clean[1..10])+trim(' '+l.clean[11..12])+ 
															trim(' '+l.clean[13..40])+trim(' '+l.clean[41..44])+
															trim(' '+l.clean[45..46])+trim(' '+l.clean[47..56])+trim(' ' +l.clean[57..64]);
															
															
				self.p_city_name	  					:= l.clean[65..89];
				//self.v_city_name	  					:= l.clean[90..114];
            	self.clean_st 			      			:= if(l.clean[115..116] = '',ziplib.ZipToState2(l.clean[117..121]),
            											l.clean[115..116]);
            	self.clean_zip 		      				:= l.clean[117..121];
            	self	    							:= l;
            end;
            
            clean_cache_CJR	:= project(Clean_Addr_File, getAddrCache(left)) :persist('~thor_data400::persist::AutoInsu_clean');
//		output(clean_cache_CJR);
//		 output(clean_cache_CJR(Consumer_ID='1999384631'),named('output_consumer'));
//		count(clean_cache_CJR);
   		
   
   AutoInsu_Slim_CJR :=record
	string 		Consumer_ID;
	string 		LinkID;
	string 		FIRST_NAME;
	string 		MIDDLE_NAME;
	string 		LAST_NAME;
	string 		APT_NBR;
	string 		HOUSE_NBR;
	string 		STREET;
	string 		CITY;
	string 		STATE;
	string 		ZIP;
	string 		ZIP4;
	string 		SSN;
	string 		DOB;
	string 		name;
   	string 		fname;
	string 		mname;
   	string 		lname;
	string 		name_suffix;
   	string 		prim_range;
	string 		predir;
   	string 		prim_name; 
    string 		sec_range;
	string 		Suffix ;  
	string 		postdir ;
	string 		unit_desig ;
	string 		street_address;
   	string 		p_city_name;
   //	string 		v_city_name;
	string 		clean_st;
	string 		clean_zip;
	string 		clean_zip4;
    unsigned6 	did :=0;     		  
end;
   					 
   matchset :=['A','S','D'];
   
   did_Add.MAC_Match_Flex(clean_cache_CJR, matchset,
   	 ssn,dob, fname, mname, lname, name_suffix, 
   	 prim_range, prim_name, sec_range, clean_zip, clean_st,'',
   	 did,   			
   	AutoInsu_Slim_CJR, 
   	 false, did_score_field,	//these should default to zero in definition
   	 75,	  //dids with a score below here will be dropped 
   	 outfile);
   	 CJR_Dids:=outfile:persist('~thor_data400::persist::AutoInsuCJR_did');
   	 
   dNonzero_CJR_Dids :=dedup(sort(distribute(CJR_Dids(did<>0),hash64(did)),did,local),did);//valid dids form input file

   	//Zero did's form input file
   	
   zero_Dids:=CJR_Dids(did=0):persist('~thor_data400::persist::zero_did');
  
   AutoInsu_Slim_CJR_HHId:=record
   AutoInsu_Slim_CJR;
   unsigned6 HHID;
   
   end;
   
   did_HHId_Only := record
   unsigned6 did;
   unsigned6 HHID;
   unsigned4 last_current ;
   	end;
   
   Header_HHId 		:=project(Header.File_HHID,did_HHId_Only)(did<>0 and HHId<>0);
   fg := GROUP(SORT(DISTRIBUTE(Header_HHId, HASH64(did)), did, LOCAL), did);
   dHeader_HHId := DEDUP(SORT(fg, -last_current), did):persist('~thor_data400::AutoInsu_header_HHID');//only latest HHId records
   
   Nonzero_Header_Did 	:=sort(distribute(dHeader_HHId,hash64(Did)),Did,local);
   
   AutoInsu_Slim_CJR_HHID  trfJoinCJR_HHID(did_HHId_Only l, AutoInsu_Slim_CJR r) := transform
      self := r;
      self.HHID:=l.hhid;
	  self:=[];
      
   end;
   
   join_CJR_HHID 		:= join(Nonzero_Header_Did ,dNonzero_CJR_Dids,
   					             left.Did=right.Did, 
   								  trfJoinCJR_HHID(left,right),right outer ,local
   					              );
   								  
   	//input file people with associated house hold ids
       sjoin_CJR_HHID :=sort(distribute(join_CJR_HHID ,hash64(did)),did,local):persist('~thor_data400::AutoInsu_In_did_HHid');
   	
   	djoin_CJR_HHID :=sort(distribute(join_CJR_HHID ,hash64(HHID)),HHId,local);
   	
   	Nonzero_Header_HHid 	:=sort(distribute(dHeader_HHId,hash64(HHID)),HHID,local);
   	
   //	output(sjoin_CJR_HHID);
   
   	
 AutoInsu_slim_CJR_HHID1:=record
 AutoInsu_slim_CJR_HHId;
unsigned6 did1;
end;
	//extracting house hold associated did's form HHid file and appending those to input file as "did1" column 
 AutoInsu_slim_CJR_HHID1   trfJoinCJR_HHID_did(did_HHId_Only l,  AutoInsu_slim_CJR_HHId r) := transform
 
 self.did1:=l.did;
   self := r;
   
   
end;


join_CJR_HHID_did 		:= join(Nonzero_Header_HHid ,djoin_CJR_HHID,
					             left.HHID=right.HHID, 
								  trfJoinCJR_HHID_did(left,right),right outer ,local
					              );
								  

djoin_CJR_HHID_did :=sort(distribute(join_CJR_HHID_did ,hash64(Did1)),Did1,local);

did_HHId := record
unsigned6 did;
unsigned6 HHID;
string 	Consumer_ID;
string 		LinkID;
	end;

//Filtering house hold associated "dids" form input file people so that house hold people info can be pulled form header

 did_HHId transChild( AutoInsu_slim_CJR_HHId1 l,AutoInsu_slim_CJR r):=transform
 self.did :=l.did1;
 self:=l;
 end;
 
 HHID_DID:=join(djoin_CJR_HHID_did,dNonzero_CJR_Dids,
                left.did1= right.did,
				transChild(left,right),
				left only,local);
				
	dHHID_DID:= dedup(sort(distribute(HHID_DID(did<>0 and hhid<>0) ,hash64(Did)),Did,local),did):persist('~thor_data400::AutoInsu_HHid_did');//house hold  associated did's
 
 	


AutoInsu_slim_CJR_HHID_header:=record
	AutoInsu_slim_CJR_HHID;
 //unsigned6 did;
  qstring10 phone;
/*   qstring9 ssn;
     integer4 dob;
     qstring5 title;
     qstring20 fname;
     qstring20 mname;
     qstring20 lname;
     qstring5 name_suffix;
     qstring10 prim_range;
     string2 predir;
     qstring28 prim_name;
     qstring4 suffix;
     string2 postdir;
     qstring10 unit_desig;
     qstring8 sec_range;
     qstring25 city_name;
     string2 st;
     qstring5 zip;
     qstring4 zip4;
     unsigned3 addr_dt_last_seen;
     qstring8 dod;
     qstring17 prpty_deed_id;
     qstring22 vehicle_vehnum;
     qstring22 bkrupt_crtcode_caseno;
     integer4 main_count;
     integer4 search_count;
     qstring15 dl_number;
     qstring12 bdid;
     integer4 run_date;
     integer4 total_records;
     unsigned8 rawaid;
     unsigned3 addr_dt_first_seen;
     string10 adl_ind;
     string1 valid_ssn;
    END;
*/

	end;  
	

Watchdog_HeaderBest_DIDs:=	dedup(sort (distribute(Watchdog.File_Best,hash64(did)),- addr_dt_last_seen,did,local),did):persist('~thor::data_400::WatchdogBest');
         

 AutoInsu_slim_CJR_HHID_header trfJoinCJR_HHID_HD(recordof(Watchdog_HeaderBest_DIDs) l, sjoin_CJR_HHID r) := transform
         
			self.dob      	:=if(r.dob ='' and (integer) r.dob=0,(string)l.dob,r.dob);
		    self.ssn     	:=if(r.ssn =''and (integer) r.ssn=0,l.ssn,r.ssn); 
		    self 			:= r;
		    self 			:=l;
		  
         end;
         
	join_In_CJR_HHID_Header 			:= join(Watchdog_HeaderBest_DIDs, sjoin_CJR_HHID,
													left.did=right.did,
													trfJoinCJR_HHID_HD(left,right),right outer,local):persist('~thor_data400::In_AutoInsu_CJR_HHID_Header');
				



				
AutoInsu_slim_CJR_HHID_header trfJoinCJR_HHID_child_HD(recordof (Watchdog_HeaderBest_DIDs) l,recordof(dHHID_DID)  r) := transform
         
		  
		  self.first_name		:=l.fname;
		  self.middle_name		:=l.mname;
		  self.last_name		:=l.lname;
		  self.APT_NBR		    := trim(l.unit_desig)+trim(' '+l.sec_range);
   	      self.HOUSE_NBR        := trim(l.prim_range,left,right);
		  self.STREET			:=trim(' '+l.predir)+
									 trim(' '+l.prim_name)+
									 trim(' '+l.Suffix)+
									 trim(' '+l.postdir);
		  self.CITY				:= l.city_name;
		  self.STATE			:= l.st;
          self.zip				:=l.zip;
		  self.ZIP4				:= l.zip4;
		  self.ssn				:=l.ssn;
		  self.dob				:=(string)l.dob;
		  self.name				:=trim(l.fname) + trim(' '+ l.mname) + trim(' '+ l.lname) + trim(' '+ l.name_suffix);
		  self.fname			:=l.fname;
          self.mname			:=l.mname;
          self.lname			:=l.lname;
          self.name_suffix		:= l.name_suffix;
		  self.phone			:=l.phone; 
		  self.prim_range		:=l.prim_range;
          self.prim_name		:=l.prim_name;
          self.sec_range		:=l.sec_range;
		  self.street_address	:=trim(l.prim_range)+trim(' '+l.predir)+
									 trim(' '+l.prim_name)+
									 trim(' '+l.Suffix)+
									 trim(' '+l.postdir)+
									 trim(' '+l.unit_desig) +trim(' '+l.sec_range);
		  self.p_city_name		:=l.city_name;
		 // self.v_city_name		:=l.city_name;
		  self.clean_st			:=l.st;
		  self.clean_zip		:=l.zip;
		  self.clean_zip4		:=l.zip4;
		  self.did              :=r.did;
		  self.HHId				:=r.hhid;
		  self.Consumer_ID		:= r.Consumer_ID;
		  self.LinkID			:= r.LinkID;
		  self					:=l;
         end;
		 
		 
	House_hold_data := join(Watchdog_HeaderBest_DIDs,dHHID_DID,
													left.did=right.did,
													trfJoinCJR_HHID_child_HD(left,right),right outer,local):persist('~thor_data400::AutoInsu_Cjr_HHID_did_Header');//house hold did recods getting name and address info from header
 



Full_file:= dedup(sort(distribute(join_In_CJR_HHID_Header+House_hold_data,hash(did)),did),did):persist('~thor_data400::AutoInsu_Cjr_fullFile');
 AutoInsu_slim_CJR_HHID_header zdid(AutoInsu_Slim_CJR  l):=transform
	self	:=l;
	self	:=[];
  end;
  
  zerodid:=project(zero_Dids,zdid(left));
			//excluding Dunn&Bradstreet  records and confidence score of 3 and less from Paw file.
			pAwFile := dedup(group(sort(PAW.File_Base(source<>'D ' and did<>0 and bdid<>0),did,bdid,-dt_last_seen),did,bdid),did,bdid);
			pAw_file := sort(distribute(pAwFile,hash(did)),did,local):persist('~thor_data400::paw::did');

AutoInsu_slim_CJR_HHID_header_paw := record
AutoInsu_slim_CJR_HHID_header;
	unsigned6 bdid;  
  //unsigned6 contact_id;
  //unsigned6 did;
 // string9 ssn;
  //string3 score;
  string120 company_name;
  string150 company_street;
  string25 company_city;
  string2 company_state;
  string5 company_zip;
  string4 company_zip4;
  string35 company_title;
  string35 company_department;
  string10 company_phone;
 // string9 company_fein;
  //string5 title;
/*   string20 fname;
     string20 mname;
     string20 lname;
     string5 name_suffix;
     string10 prim_range;
     string2 predir;
     string28 prim_name;
     string4 addr_suffix;
     string2 postdir;
     string5 unit_desig;
     string8 sec_range;
     string25 city;
     string2 state;
     string5 zip;
     string4 zip4;
     string3 county;
     string4 msa;
     string10 geo_lat;
     string11 geo_long;
*/
  string10 paw_phone;
  //string60 email_address;
/*   string8 dt_first_seen;
     string8 dt_last_seen;

  string1 record_type;
  string1 active_phone_flag;
  string1 glb;
  string2 source;
  string2 dppa_state;
  string3 old_score;
  unsigned6 source_count;
  unsigned1 dead_flag;
  string10 company_status;
  string from_hdr;
  string vendor_id;
  unsigned8 rawaid;
 unsigned8 company_rawaid; */
 END;

	

AutoInsu_slim_CJR_HHID_header_paw trfJoinCJR_HHId_header_paw(recordof(paw_file) l,AutoInsu_slim_CJR_HHID_header r) := transform
      self 					:= r;
	  self.paw_phone 		:= l.phone;
	  self.company_street   := 	trim(l.company_prim_range)+		trim(' '+l.company_predir)+
								trim(' '+l.company_prim_name)+	trim(' '+l.company_addr_suffix)+
								trim(' '+l.company_postdir)+	trim(' '+l.company_unit_desig)+
								trim(' '+l.company_sec_range);
	  self					:=l;
   end;
   
join_CJR_HHID_Header_paw	:= join(pAw_file ,Full_file,
                                 left.did=right.did ,
								   trfJoinCJR_HHId_header_paw(left,right),right outer,local
					              );
								  
NewAutoInsu_slim_CJR_HHID_header_paw:=record
AutoInsu_slim_CJR_HHID_header_paw -did;
string12 did;
end;	
	
	NewAutoInsu_slim_CJR_HHID_header_paw trf(AutoInsu_slim_CJR_HHID_header_paw l) := Transform
	self.did 		:= if(trim((string) l.did)!='',intformat(l.did, 12, 1),'');
	self 			:= l;
end;

djoin_CJR_HHID_Header_paw:=dedup(sort(project(join_CJR_HHID_Header_paw,trf(left)),did),did):persist('~thor_data400::_CJR_HHID_Header_paw');

slim_ingenix_ProvDid_Degree := record
string12 			DID;
string  			FILETYP;
string150  			Provider_street;
string25 			prov_Clean_p_city_name	    ;
//string25 			prov_Clean_v_city_name	    ;
string2  			prov_Clean_st				;
string5  			prov_Clean_zip			    ;
string				Degree;

end;

   	Ingenix_ProviderDid		:=	sort (distribute(Ingenix_NatlProf.Basefile_Provider_Did((integer)did <>0 and (integer)ProviderID<>0),hash(ProviderID)),ProviderID ,-dt_last_seen,local);
   	Ingenix_ProviderDegree 	:=	sort (distribute(Ingenix_NatlProf.Basefile_ProviderDegree( (integer)ProviderID<>0),hash(ProviderID)),ProviderID,-dt_last_seen,local);
   	
   	slim_ingenix_ProvDid_Degree  trfJoinIngenix_Did_Degree(recordof(Ingenix_NatlProf.Basefile_Provider_Did) l,recordof(Ingenix_NatlProf.Basefile_ProviderDegree) r) := transform
          self 				    := l;
   		  self.Provider_street	:=  trim(l.prov_Clean_prim_range)+ trim(' '+l.prov_Clean_predir)+
									trim(' '+l.prov_Clean_prim_name)+ trim(' '+l.prov_Clean_addr_suffix)+
									trim(' '+l.prov_Clean_postdir)+	trim(' '+l.prov_Clean_unit_desig)+
									trim(' '+l.prov_Clean_sec_range);
          self 					:= r;
       end;
            
  	join_Ingenix_Did_Degree			:= join(Ingenix_ProviderDid,Ingenix_ProviderDegree,
   													trim(left.ProviderID,left,right)=trim(right.ProviderID,left,right),
   													trfJoinIngenix_Did_Degree(left,right),left outer,local);
													
		djoin_Ingenix_Did_Degree:=dedup(sort( join_Ingenix_Did_Degree,did),did):persist('~thor_data400::provider::Ingenix_Did_Degree');
		
NewAutoInsu_slim_CJR_HHID_header_paw_ingenix := record

			NewAutoInsu_slim_CJR_HHID_header_paw 			;
			string  			FILETYP						;
			string150  			Provider_street				;
			string25 			prov_Clean_p_city_name	    ;
			//string25 			prov_Clean_v_city_name	    ;
			string2  			prov_Clean_st				;
			string5  			prov_Clean_zip			    ;
			string				Degree						;

end;


NewAutoInsu_slim_CJR_HHID_header_paw_ingenix trfJoinCJR_paw_HHID_Header_ingenix(slim_ingenix_ProvDid_Degree l,NewAutoInsu_slim_CJR_HHID_header_paw r) := transform
          self 								:= r;	  
      	  self 								:=l;
    end;
         
	join_CJR_HHID_Header_paw_ingenix			:= join(djoin_Ingenix_Did_Degree,djoin_CJR_HHID_Header_paw,
												trim(left.did,left,right)=trim(right.did,left,right),
													trfJoinCJR_paw_HHID_Header_ingenix(left,right),right outer);

							 	
	
	
djoin_CJR_HHID_Header_paw_ingenix:=dedup( sort (join_CJR_HHID_Header_paw_ingenix,did),did):persist('~thor_data400::CJR_HHID_Header_paw_ingenix');


 
  Martindale_Hubbell_AI:=RECORD,maxLength(5024000)
	unsigned6 bdid;
	string12 did;
	unsigned4 dt_last_seen;									
	string5 MH_title;
	string20 MH_fname;
	string20 MH_mname;
	string20 MH_lname;
    string10 faxs_fax_number;
    string10 phones_phone_number;
    string10 header_aff_indiv_indiv_cell_phone_number;
    string10 header_aff_indiv_indiv_fax_fax_number;
    string10 header_aff_indiv_indiv_phone_phone_number;
	string100 mailing_streetAddress;//address1;
	string50 mailing_cityStateZip;//address2;
	string100 location_streetAddress;
	string50 location_cityStateZip;
 END;
 
 //Miscellaneous.Affiliated_Individuals.Cleaned_Phones		clean_phones
 Martindale_Hubbell_AI transMH( recordof(Martindale_Hubbell.Files().Base.Affiliated_Individuals.qa) l):=transform

	self.MH_title									:=l.clean_contact_name.title;
	self.MH_fname									:=l.clean_contact_name.fname;
	self.MH_mname									:=l.clean_contact_name.mname;
	self.MH_lname									:=l.clean_contact_name.lname;
	self.faxs_fax_number					:=l. clean_phones.contact_faxs_fax_number;
	self.phones_phone_number				:=l. clean_phones.contact_phones_phone_number;
	self.header_aff_indiv_indiv_cell_phone_number	:=l. clean_phones.header_aff_indiv_indiv_cell_phone_number;
	self.header_aff_indiv_indiv_fax_fax_number		:=l. clean_phones.header_aff_indiv_indiv_fax_fax_number;
	self.header_aff_indiv_indiv_phone_phone_number	:=l. clean_phones.header_aff_indiv_indiv_phone_phone_number;
    self.mailing_streetAddress 				:=l.contact_mailing_address1;
	self.mailing_cityStateZip 				:=l.contact_mailing_address2;
	self.location_streetAddress 			:=l.contact_location_address1;
	self.location_cityStateZip 				:=l.contact_location_address2;
	self.did 										:= if(trim((string) l.did)!='',intformat(l.did, 12, 1),'');
	self 											:= l;
end;
MH_ds:= project(Martindale_Hubbell.Files().Base.Affiliated_Individuals.qa(did<>0),transMH(left));
dMartindale_Hubbell:= dedup(sort(MH_ds,-dt_last_seen,did),did);
 
	NewAutoInsu_slim_CJR_HHID_header_paw_ingenix_MHubbell := record
		NewAutoInsu_slim_CJR_HHID_header_paw_ingenix;
	string5  	MH_title;
	string20 	MH_fname;
	string20 	MH_mname;
	string20 	MH_lname;
    string10 	faxs_fax_number;
    string10 	phones_phone_number;
    string10 	header_aff_indiv_indiv_cell_phone_number;
    string10 	header_aff_indiv_indiv_fax_fax_number;
    string10 	header_aff_indiv_indiv_phone_phone_number;
	string100 	mailing_streetAddress;//address1;
	string50	mailing_cityStateZip;//address2;
	string100 	location_streetAddress;
	string50 	location_cityStateZip;
 END;
 
 NewAutoInsu_slim_CJR_HHID_header_paw_ingenix_MHubbell trfJoinCJR_paw_HHID_Header_ingenix_MH(Martindale_Hubbell_AI l,NewAutoInsu_slim_CJR_HHID_header_paw_ingenix r) := transform
		  self 								:= r;	  
      	  self 								:=l;
    end;
         
	join_CJR_HHID_Header_paw_ingenix_MH			:= join(dMartindale_Hubbell,djoin_CJR_HHID_Header_paw_ingenix,
														trim(left.did,left,right)=trim(right.did,left,right),
														trfJoinCJR_paw_HHID_Header_ingenix_MH(left,right),right outer);

							 	
	
	
djoin_CJR_HHID_Header_paw_ingenix_MH:=dedup( sort (join_CJR_HHID_Header_paw_ingenix_MH,did),did):persist('~thor_data400::AutoInsu_cjr_HHID_Header_paw_ingenix_MH');
  
  NewAutoInsu_slim_CJR_HHID_header_paw_ingenix_MHubbell Tran_zdid(AutoInsu_Slim_CJR  l):=transform
	
	self.did := if(trim((string) l.did)!='',intformat(l.did, 12, 1),'');
	self	:=l;
	self	:=[];
  end;
  
  zerodid_rec:=project(zero_Dids,Tran_zdid(left));
  


NewAutoInsu_slim_CJR_HHID_header_paw_ingenix_MHubbell trans_final(NewAutoInsu_slim_CJR_HHID_header_paw_ingenix_MHubbell l):=transform 
  
  
  self                              :=  l;
 // self.lf                           :='\r\n';
end;

AutoInsu_CJR_out:= project(djoin_CJR_HHID_Header_paw_ingenix_MH+zerodid_rec,trans_final(left)):persist('~thor_data400::AutoInsu_cjr_append_HHID_MH_final');
cjr_Field_PopulationStats:= record
  
   countgroup		:=count(group);
   did				:=	ave(group,if(AutoInsu_CJR_out.did<>'',100,0));
   ssn				:=	ave(group,if(AutoInsu_CJR_out.ssn	<>'',100,0));
   Dob			:=	ave(group,if(AutoInsu_CJR_out.dob	<>'',100,0));
   HHid				:=	ave(group,if(AutoInsu_CJR_out.HHid	<>0,100,0));
 
 end;

AutoInsu_CJR_final2_fieldPOP:=table(AutoInsu_CJR_out,cjr_Field_PopulationStats,all);	
	
	
despray_cjr2 	:= FileServices.despray('~thor_data400::out::cjr::AutoInsu_append_HHID_MH_final_2',_control.IPAddress.edata10,'/export/home/smyana/AutoInsurance_appendCJR_first.txt',,,,true);
despray_cjr1 	:= FileServices.despray('~thor_data400::out::cjr::AutoInsu_append_HHID_final_1',_control.IPAddress.edata10,'/export/home/smyana/AutoInsurance_appendCJR_second.txt',,,,true);
	return sequential( 
						output(AutoInsu_ds,named('raw_File_data')),
						output(count(AutoInsu_ds),named('raw_FileCount')),
						output(count(dNonzero_CJR_Dids),named('count_InFile_unique_nonZero_didRec')),
						output(count(zero_Dids),named('countInFile_Zero_DidRec')),
						output(dedup(sort(join_In_CJR_HHID_Header,did),did)  ,named('In_file_data')),
						output(dedup(sort(House_hold_data,did),did),named('House_hold_data')),
						output(Full_file((phone<>'')),named('HeaderSamplerecords')),
						output(djoin_CJR_HHID_Header_paw_ingenix,named('CJR_HHID_Header_paw_ingenix')),
						output(djoin_CJR_HHID_Header_paw_ingenix_MH(degree<>''),named('IngenixProvSampleRecords')),
						output(djoin_CJR_HHID_Header_paw_ingenix_MH(MH_fname<>''),named('MarhubSampleRecords')),
						output(djoin_CJR_HHID_Header_paw_ingenix_MH(company_name<>''),named('PeopleATWorkSampleRec')),
						output(choosen(AutoInsu_CJR_out,2000),named('Final_appendSampleRecords')),
						output(count(AutoInsu_CJR_out),named('count_Final_append')),
						output(AutoInsu_CJR_out,,'~thor_data400::out::cjr::AutoInsu_append_HHID_MH_final_2',CSV(SEPARATOR(['|']),maxlength(99999999)),overwrite,__COMPRESSED__)
					    ,output(Full_file+zerodid,,'~thor_data400::out::cjr::AutoInsu_append_HHID_final_1',CSV(SEPARATOR(['|']),maxlength(99999999)),overwrite,__COMPRESSED__)
						,output('stats_2')
						,output(count(AutoInsu_CJR_out))
						,output(AutoInsu_CJR_out)
						,output(count(dedup(sort(AutoInsu_CJR_out,consumer_id),consumer_id)),named('stats_2_Distinct_consumer_id'))
						,output(count(dedup(sort(AutoInsu_CJR_out,did),did)),named('stats_2_Distinct_did'))
						,output(count(dedup(sort(AutoInsu_CJR_out,hhid),hhid)),named('stats_2_Distinct_hhid'))
						,output('stats_1')
						,output(count(Full_file+zerodid))
						,output(count(dedup(sort(Full_file+zerodid,consumer_id),consumer_id)),named('stats_1_Distinct_consumer_id'))
						,output(count(dedup(sort(Full_file+zerodid,did),did)),named('stats_1_Distinct_did'))
						,output(count(dedup(sort(Full_file+zerodid,hhid),hhid)),named('stats_1_Distinct_hhid'))
						,output(AutoInsu_CJR_final2_fieldPOP,named('CJR_Part2_field_pop'))
						,despray_cjr2
						,despray_cjr1
					);
		end;