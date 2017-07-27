import ut, roxiekeybuild, autokeyb2; 

rec_ds_std:= RECORD
//recordof(file_bookings_base);
string15  BOOKING_SID;
string10	prim_range;
string28	prim_name;
string8	  sec_range;
string25	p_city_name;
string2		state;
string5		zip5;
string20	fname;
string20	mname;
string20	lname;
string9		ssn;
string8   DATE_OF_BIRTH;	
unsigned8 did;
string25  HOME_PHONE;	
string30  work_phone;	

//string DID_str;
unsigned1 zero := 0;    // These dummy fields used to plug in field names
string1 blank := '';  // not required into a prev defined macro
END;

rec_ds_std tMakeStd(file_bookings_base L):= TRANSFORM
//self.did_str:=(string)L.did;
self.ssn := if( L.ssn ='' or (integer)L.ssn =0  ,l.ap_ssn,L.ssn); 
self.prim_range := trim(l.prim_range,left,right);
self.prim_name  := trim(l.prim_name,left,right);

self.HOME_PHONE := If(length(stringlib.stringfilterout(l.home_phone,'()+- ')) < 10 ,'',stringlib.stringfilterout(l.home_phone,'()- '));
self.WORK_PHONE := If(length(stringlib.stringfilterout(l.work_phone,'()+- ')) < 10 ,'',stringlib.stringfilterout(l.work_phone,'()- '));

self:= L;
END;

ds_for_autokey:= PROJECT(file_bookings_base, tMakeStd(LEFT));


export proc_build_autokey(string filedate) := function

//c						:= entiera_constants(filedate);
ak_keyname		:= '~thor_200::key::Appriss::autokey::@version@::';//c.ak_keyname;
//ak_qa_keyname	:= '~thor_200::key::Appriss::autokey::qa::';//c.ak_logical;
ak_logical  	:= '~thor_200::key::Appriss::'+filedate+'::autokey::';
ak_dataset		:= ds_for_autokey;//file_bookings_prepa;//c.ak_dataset;
//ak_skipSet		:= ['P','B'];//c.ak_skipSet;
            //P in this set to skip personal phones
							//Q in this set to skip business phones
							//S in this set to skip SSN
							//F in this set to skip FEIN
							//C in this set to skip ALL personal (Contact) data
							//B in this set to skip ALL Business data
//ak_typeStr	:= 'AK';
              //AK is default in MACRO ,
							//was 'BC' for Entiera .. ** NO IDEA WHAT THIS MEANSc.ak_typeStr;


AutoKeyB2.MAC_Build (ak_dataset,fname,mname,lname,
						 ssn,
						 DATE_OF_BIRTH,  //zero,
						 home_phone,
						 prim_name, prim_range,state,p_city_name,zip5,sec_range,
						 zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 zero,
						 did,//did_out6,
						 blank,//Business_Name, // compname which is string thus "blank"
						 zero,
						 work_phone,
						 //premise_prim_name,premise_prim_range,premise_st,premise_p_city_name,premise_zip,premise_sec_range,
						 blank,blank,blank,blank,blank,blank,
						 //bdid6, // bdid_out
						 zero,
						 ak_keyname,
						 ak_logical,
						 bld_auto_keys,false,
						 ak_skipSet,true,ak_typeStr,
						 true,,,zero);


return bld_auto_keys;

end;