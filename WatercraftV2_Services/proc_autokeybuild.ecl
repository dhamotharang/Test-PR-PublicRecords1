import autokeyb2,doxie,ut,corp2,address,watercraft;

export proc_autokeybuild(string filedate) := FUNCTION

Base_file := Watercraft.File_Base_Search_Dev_Ph_Supressed_bdid;

dis_watercraft :=distribute(Base_file(watercraft_key <> ''),hash(watercraft_key));

layout_watercraft := record
Watercraft.Layout_Watercraft_Search_Base_slim;
	unsigned6 ldid;
	unsigned6 lbdid;
	string10 phone :='';
	unsigned1 zero := 0;
	string25 city;
	string2 bstate :='';
	string25 bcity :='';
	string10 bphone :='';
	string10	bprim_range :='';
	string28	bprim_name :='';
	string8		bsec_range :='';
	string5 bzip5 :='';
	string9 fein_use :='';
	string9 ssn_use := '';
END;




layout_watercraft both_cities(dis_watercraft le,integer C):=transform
self.city :=choose(C,le.p_city_name,if(le.v_city_name='' or le.v_city_name=le.p_city_name,skip,le.v_city_name ));
self.ldid :=(unsigned6) le.did;
self.lbdid :=(unsigned6) le.bdid;
self :=le;
end;

//capture both city names
watercraft_both_cities :=normalize(dis_watercraft,2,both_cities(left,counter));


//capture all phones

layout_watercraft all_phones(layout_watercraft le,integer C):=transform
self.phone :=choose(C,le.phone_1,if(le.phone_2='' or le.phone_2=le.phone_1,skip,le.phone_2));
self :=le;
end;

watercraft_both_phones :=dedup(normalize(watercraft_both_cities,2, all_phones(left,counter)),record,all,local );


layout_watercraft_use := record
Watercraft.Layout_Watercraft_Search_Base.watercraft_key;
Watercraft.Layout_Watercraft_Search_Base.sequence_key;
Watercraft.Layout_Watercraft_Search_Base.state_origin;
Watercraft.Layout_Watercraft_Search_Base.fname;
Watercraft.Layout_Watercraft_Search_Base.lname;
Watercraft.Layout_Watercraft_Search_Base.mname;
Watercraft.Layout_Watercraft_Search_Base.dob;
Watercraft.Layout_Watercraft_Search_Base.prim_name;
Watercraft.Layout_Watercraft_Search_Base.prim_range;
Watercraft.Layout_Watercraft_Search_Base.st;
Watercraft.Layout_Watercraft_Search_Base.zip5;
Watercraft.Layout_Watercraft_Search_Base.sec_range;
Watercraft.Layout_Watercraft_Search_Base.company_name;	
	unsigned6 ldid;
	unsigned6 lbdid;
	string10 phone :='';
	unsigned1 zero := 0;
	string25 city;
	string2 bstate :='';
	string25 bcity :='';
	string10 bphone :='';
	string10	bprim_range :='';
	string28	bprim_name :='';
	string8		bsec_range :='';
	string5 bzip5 :='';
	string9 fein_use :='';
	string9 ssn_use := '';
  //CCPA-206 Add 2 CCPA fields
  UNSIGNED4	global_sid:=0;
  UNSIGNED8	record_sid:=0;
END;

layout_watercraft_use w_bState(layout_watercraft le):=transform
c :=le.company_name <> '';
self.fein_use :=if(le.orig_fein <> '',le.orig_fein,le.fein);
self.ssn_use :=if(le.orig_ssn <>'',le.orig_ssn,le.ssn);
self.bstate := if(c,le.st,'');
self.bcity := if(c,le.city,'');
self.bzip5 :=if(c,le.zip5,'');
self.bprim_name := if(c,le.prim_name,'');
self.bprim_range :=if(c,le.prim_range,'');
self.bsec_range :=if(c,le.sec_range,'');
self.bphone :=if(c,le.phone,'');
self :=le;
END;

watercraft :=project(watercraft_both_phones,w_bState(left));

persistname := '~thor_data400::' + 'persist::WaterCraftV2_services::BWR_buildautokey';
autokey_ready := watercraft :persist(persistname);

//autokey_ready :=dataset(persistname,layout_watercraft,flat);
/*
t:= WatercraftV2_Services.Constants(filedate).ak_keyname;
ut.mac_create_superkey_files(t + 'Address');
ut.mac_create_superkey_files(t + 'CityStName');
ut.mac_create_superkey_files(t + 'Name');
ut.mac_create_superkey_files(t + 'Phone');
ut.mac_create_superkey_files(t + 'SSN');
ut.mac_create_superkey_files(t + 'StName');
ut.mac_create_superkey_files(t + 'Zip');
ut.mac_create_superkey_files(t + 'Payload');
*/



AutoKeyB2.MAC_Build (autokey_ready,fname,mname,lname,
						ssn_use,
						dob,
						phone,
						prim_name,prim_range,st,city,zip5,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						ldid,
						company_name,
						fein_use,
						bphone,
						bprim_name,bprim_range,	bstate,bcity,	bzip5,bsec_range,
						lbdid,
						WatercraftV2_Services.Constants(filedate).ak_keyname,
						WatercraftV2_Services.Constants(filedate).ak_logical,
						outaction,false,
						[],true,WatercraftV2_Services.Constants(filedate).ak_typeStr,true,,,zero) 



AutoKeyB2.MAC_AcceptSK_to_QA(WatercraftV2_Services.Constants(filedate).ak_keyname,mymove)


Autokey_ret := sequential(outaction,mymove);

return Autokey_ret;

END;