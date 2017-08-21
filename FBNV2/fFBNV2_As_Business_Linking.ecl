IMPORT ut, Business_Header,mdr,nid,Address,Prte2_FBN;

export fFBNV2_As_Business_Linking(
                dataset(FBNV2.Layout_Common.Contact_AID) pContact_Base =FBNV2.File_FBN_Contact_Base_AId (tmsid[1..3] not in ['ACU']) 
                ,dataset(FBNV2.Layout_Common.Business_AID) pCompany_Base =FBNV2.File_FBN_Business_Base_AID (tmsid[1..3] not in ['ACU'])
                ,boolean isPRCT=false
) := function                                                                                                                                          
                                                                                                                                                                                                                                                                                
fCleanNamePrep(DATASET(FBNV2.Layout_Common.Contact_AID) pTempFileInput) := FUNCTION                                                                                                                                                                                                                                                                     
                NID.Mac_CleanFullNames( pTempFileInput
                                        , cleanContacts
                                        , contact_name
                                        , includeInRepository:=true
                                        , normalizeDualNames:=true
                                        );                                                                                                                                                                                                             

return    cleanContacts;
end;

PRCT_Contact_Base := project(pContact_Base,
     Transform(prte2_FBN.Layouts.Clean_Layout,
		 self.cln_title:=left.title;
		 self.cln_fname:=left.fname;
		 self.cln_mname:=left.mname;
		 self.cln_lname:=left.lname;
		 self.cln_suffix:=left.name_suffix;
		 Self:=Left;
     self := []; 
     ));
		 
CleanNames:= if(isPRCT, PRCT_Contact_Base, fCleanNamePrep(pContact_Base));   

													
																	
Business_Header.Layout_Business_Linking.Contact x1(CleanNames l) := transform,skip(l.cln_fname='' and l.cln_lname='')
  self.tmp_join_id_contact         := l.Tmsid;
  self.dt_first_seen_contact       := l.dt_first_seen;
  self.dt_last_seen_contact        := l.dt_last_seen;
  self.contact_did                 := l.did;
  self.contact_name.title          := l.cln_title;
  self.contact_name.fname          := l.cln_fname;
  self.contact_name.mname          := l.cln_mname;
  self.contact_name.lname          := l.cln_lname;
	self.contact_name.name_score   	 := l.name_score;
	self.contact_name.name_suffix  	 := l.cln_suffix;	
  self.contact_ssn                 := l.ssn;
  self.contact_phone               := ut.cleanphone(l.CONTACT_PHONE);
  self.contact_address.prim_range  := l.prim_range;
  self.contact_address.predir      := l.predir;
  self.contact_address.prim_name   := l.prim_name;
  self.contact_address.addr_suffix := l.addr_suffix;
  self.contact_address.postdir     := l.postdir;
  self.contact_address.unit_desig  := l.unit_desig;
  self.contact_address.sec_range   := l.sec_range;		
  self.contact_address.v_city_name := l.v_city_name;
  self.contact_address.st          := l.st;
  self.contact_address.zip	       := l.zip5;
  self.contact_address.zip4        := l.zip4;
  self.contact_address.fips_county := if(regexfind('[a-z]+',l.fips_county,NOCASE),'',l.fips_county);
	self.contact_address.fips_state	 := if(regexfind('[a-z]+',l.fips_state,NOCASE),'',l.fips_state);
  self.contact_address.geo_lat     := l.geo_lat;
  self.contact_address.geo_long    := l.geo_long;
  self.contact_address.geo_blk		 := l.geo_blk;
  self.contact_address.geo_match	 := l.geo_match;
  self.contact_address.rec_type	   := l.addr_rec_type;	
  self.contact_address.err_stat	   := l.err_stat;
  self.contact_address_type        := if (l.prim_name!='','C','');
  self.contact_rawaid              :=	l.RawAID;
  self.contact_aceaid              :=	l.aceAID;
	
  self := [];
end;

mapping_contacts  := project(CleanNames,x1(left));

//COMPANY MAPPING
Layouts_UniqueId :=record
	unsigned6 unique_id;
	FBNV2.Layout_Common.Business_AID;
end;

//Add unique id
Layouts_UniqueId tAddUniqueId(FBNV2.Layout_Common.Business_AID l, unsigned6 cnt) :=transform
	self.unique_id	:= cnt	;
	self						:= l	;
end;   
		
dAddUniqueId := project(pCompany_Base, tAddUniqueId(left,counter));

Business_Header.Layout_Business_Linking.Company_  x2(Layouts_UniqueId	 L, integer ctr) := transform
	self.tmp_join_id_company        	:= l.tmsid;
	self.company_name               	:= Stringlib.StringToUpperCase(l.bus_name);
	self.company_name_type_raw				:= 'FBN';
	self.vl_id                       	:= l.tmsid;
	self.source                     	:= MDR.sourceTools.fFBNV2(l.tmsid);
	self.source_record_id           	:= l.source_rec_id;
	self.company_bdid				 					:= l.bdid;
	self.company_phone               	:= ut.cleanphone(l.bus_phone_num);
	self.phone_type										:= 'T';
	self.phone_score                 	:= if((integer)self.company_phone=0,0,1);
	self.company_address_type_raw			:= choose(ctr,'',if (l.mail_prim_name != '','MAILING',''));
	self.company_rawaid				 				:= choose(ctr, l.rawaid 			,l.mail_rawaid);
	self.company_aceaid				 				:= choose(ctr, l.aceaid 			,l.mail_aceaid);	
	self.company_address.prim_range  	:= choose(ctr, l.prim_range		,l.mail_prim_range);
	self.company_address.predir      	:= choose(ctr, l.predir				,l.mail_predir);
	self.company_address.prim_name   	:= choose(ctr, l.prim_name		,l.mail_prim_name);
	self.company_address.addr_suffix 	:= choose(ctr, l.addr_suffix	,l.mail_addr_suffix);
	self.company_address.postdir     	:= choose(ctr, l.postdir			,l.mail_postdir);
	self.company_address.unit_desig  	:= choose(ctr, l.unit_desig		,l.mail_unit_desig);
	self.company_address.sec_range   	:= choose(ctr, l.sec_range		,l.mail_sec_range);
	self.company_address.v_city_name 	:= choose(ctr, l.v_city_name	,l.mail_v_city_name);
	self.company_address.st          	:= choose(ctr, l.st						,l.mail_st);
	self.company_address.zip        	:= choose(ctr, l.zip5					,l.mail_zip);
	self.company_address.zip4        	:= choose(ctr, l.zip4					,l.mail_zip4);
	self.company_address.fips_county 	:= choose(ctr, l.fips_county	,l.mail_fips_county);
	self.company_address.fips_state  	:= choose(ctr, l.fips_state		,l.mail_fips_state);	
	self.company_address.geo_lat     	:= choose(ctr, l.geo_lat			,l.mail_geo_lat);
	self.company_address.geo_long    	:= choose(ctr, l.geo_long			,l.mail_geo_long);
	self.company_address.rec_type    	:= choose(ctr, l.addr_rec_type,l.mail_addr_rec_type);
	self.company_address.geo_blk    	:= choose(ctr, l.geo_blk			,l.mail_geo_blk);
	self.company_address.geo_match   	:= choose(ctr, l.geo_match		,l.mail_geo_match);	
	self.company_address.err_stat   	:= choose(ctr, l.err_stat			,l.mail_err_stat);	
	self.company_sic_code1           	:= l.SIC_CODE;
	self.dt_first_seen               	:= l.dt_first_seen;
	self.dt_last_seen                	:= l.dt_last_seen;
	self.dt_vendor_last_reported     	:= l.dt_vendor_last_reported;
	self.dt_vendor_first_reported    	:= l.dt_vendor_last_reported;
	self.current                     	:= true;
	self.company_fein                	:= IF(Business_Header.ValidFEIN(l.orig_FEIN), (string)l.orig_FEIN, '');
	self := l;
	self := [];
end;
	
from_FBN_norm      		:= normalize(dAddUniqueId,if(left.mail_rawaid<>0 and left.mail_rawaid!= left.rawaid ,2,1),x2(left,counter));																										
from_fbn_norm_dist 		:= distribute(from_fbn_norm,hash(tmp_join_id_company));
from_fbn_norm_sort    := sort(from_fbn_norm_dist,tmp_join_id_company,company_name,-company_address.zip,company_address.prim_name, company_address.prim_range, -company_address.v_city_name, -company_address.st,local);
	
Business_Header.Layout_Business_Linking.Company_  x3(Business_Header.Layout_Business_Linking.Company_  L, Business_Header.Layout_Business_Linking.Company_  R) := transform
	self := l;
end;

from_fbn_norm_rollup := rollup(	from_fbn_norm_sort
																,left.tmp_join_id_company = right.tmp_join_id_company and 
																left.company_name = right.company_name and
																((left.company_address.zip = right.company_address.zip and 	
																	left.company_address.prim_name = right.company_address.prim_name and 	
																	left.company_address.prim_range = right.company_address.prim_range and 	
																	left.company_address.v_city_name = right.company_address.v_city_name and 	
																	left.company_address.st = right.company_address.st
																 )  or
																 (right.company_address.zip='' and 
																	right.company_address.prim_name='' and 
																	right.company_address.prim_range='' and 
																	right.company_address.v_city_name='' and 
																	right.company_address.st='')
																),x3(left,right),local);
									 
ds_contact := distribute(mapping_contacts,hash(tmp_join_id_contact));

ds_company := dedup(sort(distribute(from_fbn_norm_rollup,hash(tmp_join_id_company))
													,tmp_join_id_company,company_name,company_address.prim_name ,company_address.v_city_name,company_address.st,company_address.zip ,company_sic_code1,company_fein,-dt_last_seen,local)
													,tmp_join_id_company,company_name,company_address.prim_name ,company_address.v_city_name,company_address.st,company_address.zip ,company_sic_code1,company_fein,local);
													
Business_Header.Layout_Business_Linking.Combined x8( ds_company L, Business_Header.Layout_Business_Linking.Contact R) := transform
	self.contact_address_type			:= 	if(l.company_aceaid=r.contact_aceaid and l.company_aceaid != 0, 'CC', r.contact_address_type);
	self.company_address_type_raw := 	if(l.company_aceaid=r.contact_aceaid and l.company_aceaid != 0, 'CC', l.company_address_type_raw);	
	self													:=	l;
	self 													:= 	r;
end;

j1 := join(	ds_company
						,ds_contact
						,left.tmp_join_id_company=right.tmp_join_id_contact
						,x8(left,right)
						,left outer
						,local
					 );			 
				 
Business_Header.Layout_Business_Linking.Combined x9(Business_Header.Layout_Business_Linking.Combined l, Business_Header.Layout_Business_Linking.Contact r) := transform
	self.company_rawaid  			 				:= r.contact_rawaid;
	self.company_aceaid  			 				:= r.contact_aceaid;	
	self.company_address.prim_range  	:= r.contact_address.prim_range;
	self.company_address.predir      	:= r.contact_address.predir;
	self.company_address.prim_name   	:= r.contact_address.prim_name;
	self.company_address.addr_suffix 	:= r.contact_address.addr_suffix;
	self.company_address.postdir     	:= r.contact_address.postdir;
	self.company_address.unit_desig 	:= r.contact_address.unit_desig;
	self.company_address.sec_range   	:= r.contact_address.sec_range;		
	self.company_address.v_city_name 	:= r.contact_address.v_city_name;
	self.company_address.st         	:= r.contact_address.st;
	self.company_address.zip        	:= r.contact_address.zip;
	self.company_address.zip4        	:= r.contact_address.zip4;
	self.company_address.fips_county 	:= r.contact_address.fips_county;
	self.company_address.fips_state 	:= r.contact_address.fips_state;	
	self.company_address.msa         	:= r.contact_address.msa;
	self.company_address.geo_lat     	:= r.contact_address.geo_lat;
	self.company_address.geo_long    	:= r.contact_address.geo_long;
	self.company_address_type_raw    	:= if(l.company_aceaid=r.contact_aceaid and l.company_aceaid!=0, 'CC', r.contact_address_type);
	self := l;
end;

//add contact name to the join to avoid mingling every contact with every other contact's address	
j2 := join(	j1
						,ds_contact(contact_address.prim_range<>'' or contact_address.prim_name<>'' or contact_address.zip<>'')
						,left.tmp_join_id_company=right.tmp_join_id_contact and left.contact_name.fname=right.contact_name.fname and left.contact_name.lname=right.contact_name.lname
						,x9(left,right)
						,local
					 );
		 
concat      := j1+j2;
concat_dupd := dedup(project(concat,Business_Header.Layout_Business_Linking.Linking_Interface),except contact_name.name_score,company_rawaid,all);

return concat_dupd	;
end;
