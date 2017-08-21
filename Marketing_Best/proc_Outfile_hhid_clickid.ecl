import ut,_control,dma,doxie;

prep_rec:= record
marketing_best.layout_equifax;
string1   household_member_cnt:='';
string12  DID;
string10  prim_range;
string2   predir;
string28  prim_name;
string4   addr_suffix;
string2   postdir;
string10  unit_desig;
string8   sec_range;
string25  p_city_name;
string2   st;
string5   zip;
string20  lname;
string20  fname;
String3	  fips_county;
String4   msa;
String10 telephone;
String36 click_id:='';
String38 click_hhid:='';
end;

prep_rec tappendClickId(marketing_best.file_equifax_base l) := transform
self.did := if(l.did <> 0, (STRING12)INTFORMAT(l.did, 12, 1), '000000000000');
self.click_id := ut.fn_create_click_id(trim(l.prim_range,left,right)+' '+trim(l.predir,left,right)+' '+trim(l.prim_name,left,right)+' '+trim(l.addr_suffix,left,right)+' '+trim(l.postdir,left,right)+' '+trim(l.unit_desig,left,right)+' '+trim(l.sec_range,left,right),l.zip,l.lname,'','','');
self.click_hhid := ut.fn_create_click_id(trim(l.prim_range,left,right)+' '+trim(l.predir,left,right)+' '+trim(l.prim_name,left,right)+' '+trim(l.addr_suffix,left,right)+' '+trim(l.postdir,left,right)+' '+trim(l.unit_desig,left,right)+' '+trim(l.sec_range,left,right),l.zip,'','','','');

self := l;
self := [];				//Set those fields that are in key file but not base file, like mail_responsive_donor_indicator, to blank. 11/11/13
end;


appended_ds := PROJECT(marketing_best.file_equifax_base, tappendClickId(LEFT)); 

//Supress Do not call 

appended_ds  doJoin(appended_ds l, dma.key_DNC_Phone r) := TRANSFORM

self.telephone := if(L.telephone = R.phonenumber , '',L.telephone); 
self.Area_CodeAll_Available := if(L.telephone = R.phonenumber , '',L.Area_CodeAll_Available); 
self.TelephoneAll_Available  := if(L.telephone = R.phonenumber , '',L.TelephoneAll_Available); 
SELF := l;

END;

d_supp_phone:=JOIN(appended_ds, dma.key_DNC_Phone,keyed(LEFT.telephone = RIGHT.phonenumber),
				   doJoin(LEFT,right),LEFT outer) ; 


d_supp_phone_dist := distribute(d_supp_phone,hash(prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname)); 
file_supp := sort(distribute(dma.file_suppressionMPS,hash(prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname))
                  ,prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname,local); 
				  
file_suppd := dedup(file_supp,prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname,local);
				  
// Supress do not mail 

d_supp_phone_dist  doJoin1(d_supp_phone_dist l, file_suppd r) := TRANSFORM

boolean is_true := if(l.prim_name = ut.StripOrdinal(r.prim_name) AND
					   l.prim_range = TRIM(ut.CleanPrimRange(r.prim_range),LEFT) AND 
					   l.st = r.st AND
					   doxie.Make_CityCode(l.p_city_name) = doxie.Make_CityCode(r.p_city_name) AND 
					   l.zip = r.zip AND 
					   l.sec_range = r.sec_range AND 
					   l.lname = r.lname AND
					   l.fname = r.fname , true , false); 

self.ZIP_Code := if(is_true , '',l.ZIP_Code) ;   
self.ZIPPlus_4  := if(is_true , '',l.ZIPPlus_4) ;
self.House_Number:= if(is_true , '',l.House_Number) ;
self.Fraction := if(is_true , '',l.Fraction) ;
self.Street_Prefix_Direction  := if(is_true , '',l.Street_Prefix_Direction) ;
self.Contracted_Street_Address  := if(is_true , '',l.Contracted_Street_Address ) ;
self.Route_Designator_and_Number  := if(is_true , '',l.Route_Designator_and_Number) ;
self.Box_Designator_and_Number := if(is_true , '',l.Box_Designator_and_Number) ;
self.Secondary_Unit_Designation := if(is_true , '',l.Secondary_Unit_Designation) ;
self.Post_Office_Name  := if(is_true , '',l.Post_Office_Name) ;
self.State_Abbreviation  := if(is_true , '',l.State_Abbreviation) ;
SELF := l;

END;


d_supp_addr := JOIN(d_supp_phone_dist, file_suppd, 
                       LEFT.prim_name = ut.StripOrdinal(RIGHT.prim_name) AND
					   LEFT.prim_range = TRIM(ut.CleanPrimRange(right.prim_range),LEFT) AND 
					   LEFT.st = RIGHT.st AND
					   doxie.Make_CityCode(LEFT.p_city_name) = doxie.Make_CityCode(RIGHT.p_city_name) AND 
					   LEFT.zip = RIGHT.zip AND 
					   LEFT.sec_range = RIGHT.sec_range AND 
					   LEFT.lname = RIGHT.lname AND
					   LEFT.fname = RIGHT.fname,
					   doJoin1(LEFT,right),LEFT outer,local) ; 
					   

appended_ds1 := d_supp_addr(household_member_cnt='1');

marketing_best.layout_equifax_outfile appendClickId(appended_ds1 l) := transform
self.delivery_point := l.Delivery_Point_Code[1..2];
self.delivery_point_correction :=l.Delivery_Point_Code[3];
self := l;
end;


appended_ds2 := PROJECT(appended_ds1(AddressName_Censor_Code='K' and Address_Quality_Code= '0' and file_code = 'P'), appendClickId(LEFT)); 

eq_outfile := output(appended_ds2,,'~thor_data400::out::eq_total_source',Overwrite);

send_email := fileservices.SendEmail('steve.shelnut@lexisnexis.com,cdsdataops@lexisnexis.com,Ajit.Deshpande@lexisnexis.com,krishna.gummadi@lexisnexis.com','New Equifax file is available on edata10 /ucc_new_build2/eq_total_source/eq_total_source.d00','');

DestinationIP :=_control.IPAddress.edata10;
outfile      :='~thor_data400::out::eq_total_source';

despray  :=fileservices.despray( outfile, DestinationIP, '/ucc_new_build2/eq_total_source/eq_total_source.d00',,,,TRUE) ; 

export Proc_Outfile_hhid_clickid := sequential(eq_outfile,despray) :success(send_email), failure(FileServices.sendemail('cathy.tio@lexisnexis.com', 'Equifax failed to despray', failmessage));