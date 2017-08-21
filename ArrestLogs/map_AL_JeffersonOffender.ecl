import Crim_Common, Address;

p	:= ArrestLogs.file_AL_Jefferson;

fJefferson := p(trim(p.ID,left,right)<>'ID' and
			   trim(p.Name,left,right)<>'Name');

Crim_Common.Layout_In_Court_Offender tJefferson(fJefferson input) := Transform

searchpattern1 := '(.*) (.*)';
searchpattern2 := '(.*) (.*) (.*)';
searchpattern3 := '(.*) (.*) (.*) (.*)';

string fCityFix(string pCityIn)
:=  regexreplace('BIRMINGHAMA',
	regexreplace('[0-9]|'+'DORM RM|'+'APT |'+'3RD AVE|'+'MEX ',
	regexreplace('  |'+'   |'+'    ',
	regexreplace('WARROIR',
	regexreplace('LOSANGELES|'+'LOS ANGELAS',
	regexreplace('BESS ',
	regexreplace('BHAM|'+'BHM|'+'BIRMINGHM',trim(pCityIn,left,right),'BIRMINGHAM'),'BESSEMER'),'LOS ANGELES'),'WARRIOR'),' '),''),'BIRMINGHAM');

string fStateFind(string pStateIn)
:= if(pStateIn in ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA',
				 'HI','ID','IL','IN','IA','KS','KY','LA','ME','MD',
				 'MA','MI','MN','MS','MO','MT','NE','NV','NY','NH',
				 'NJ','NM','NC','ND','OH','OK','OR','PA','RI','SC',
				 'SD','TN','TX','UT','VT','VA','WA','WV','WI','WY'], pStateIn,'');

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= (string)'AJ'+(integer)hash(trim(input.Name,left,right)+fSlashedMDYtoCYMD(input.book_dt));
self.vendor				:= 'AJ';
self.state_origin		:= 'AL';
self.data_type			:= '5';
self.source_file		:= '(CV)AL-JeffersonArrest';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.Book_Dt) < Crim_Common.Version_In_Arrest_Offender, 
							  fSlashedMDYtoCYMD(input.Book_Dt),
							  '');
self.pty_nm				:= trim(input.Name,left,right);
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= '';
self.orig_fname			:= '';     
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ			:= '0';
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= '';
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= '';
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= input.address;
self.street_address_2	:= '';
self.street_address_3	:= regexreplace('BIRMINGHAM AL',if(length(regexfind(searchpattern1,fCityFix(input.city_st),0))>1, regexfind(searchpattern1,fCityFix(input.city_st),1),
							if(length(regexfind(searchpattern2,fCityFix(input.city_st),0))>1, regexfind(searchpattern2,fCityFix(input.city_st),1)+' '+regexfind(searchpattern2,fCityFix(input.city_st),2),
							if(length(regexfind(searchpattern3,fCityFix(input.city_st),0))>1, regexfind(searchpattern3,fCityFix(input.city_st),1)+' '+regexfind(searchpattern3,fCityFix(input.city_st),2)+''+regexfind(searchpattern3,fCityFix(input.city_st),3),
							''))),'BIRMINGHAM');
self.street_address_4	:= if(length(regexfind(searchpattern1,fCityFix(input.city_st),0))>1, fStateFind(regexfind(searchpattern1,fCityFix(input.city_st),2)[1..2]),
							if(length(regexfind(searchpattern2,fCityFix(input.city_st),0))>1, fStateFind(regexfind(searchpattern2,fCityFix(input.city_st),3)[1..2]),
							if(length(regexfind(searchpattern3,fCityFix(input.city_st),0))>1, fStateFind(regexfind(searchpattern3,fCityFix(input.city_st),4)[1..2]),
							'')));
self.street_address_5	:= input.zip;
self.race				:= if(input.race ~in['','x','U'],input.race, '');
self.race_desc			:= MAP(input.race ='B' => 'Black',
								input.race ='N' =>'Black',
								input.race ='O' => 'Other', 
								input.race ='H' => 'Hispanic', 
								input.race ='M' => 'Hispanic',
								input.race ='I' => 'Indian',
								input.race ='O' => 'Other',
								input.race ='A' => 'Asian',
								input.race ='J' => 'Japanese',
								input.race ='C' => 'Chinese',
								'');
self.sex				:= input.sex;
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= '';//converted to inches
self.weight				:= '';
self.party_status		:= '';
self.party_status_desc	:= '';
self.prim_range 		:= ''; 
self.predir 			:= '';					   
self.prim_name 			:= '';
self.addr_suffix 		:= '';
self.postdir 			:= '';
self.unit_desig 		:= '';
self.sec_range 			:= '';
self.p_city_name 		:= '';
self.v_city_name 		:= '';
self.state 				:= '';
self.zip5 				:= '';
self.zip4 				:= '';
self.cart 				:= '';
self.cr_sort_sz 		:= '';
self.lot 				:= '';
self.lot_order 			:= '';
self.dpbc 				:= '';
self.chk_digit 			:= '';
self.rec_type 			:= '';
self.ace_fips_st		:= '';
self.ace_fips_county	:= '';
self.geo_lat 			:= '';
self.geo_long 			:= '';
self.msa 				:= '';
self.geo_blk 			:= '';
self.geo_match 			:= '';
self.err_stat 			:= '';
self.title 				:= '';
self.fname 				:= '';
self.mname 				:= '';
self.lname 				:= '';
self.name_suffix 		:= '';
self.cleaning_score 	:= ''; 

end;

pJefferson := project(fJefferson, tJefferson(left));

ArrestLogs.ArrestLogs_clean(pJefferson,cleanJefferson);

arrOut:= cleanJefferson;
//+ ArrestLogs.FileAbinitioOffender(vendor='AJ'); NOT KEEPING HISTORY

dd_arrOut:= dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
									,offender_key,pty_nm,pty_typ,local,left): 
									PERSIST('~thor_dell400::persist::Arrestlogs_AL_Jefferson_Offender');
				
export map_AL_JeffersonOffender := dd_arrOut;