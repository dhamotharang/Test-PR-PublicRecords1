import header,doxie, lib_fileservices, header_services;
#workunit ('name', 'Build Relatives keys');

//************************************************************************
//ADD INFORMATION - CNG 20070426 - 400 way - W20070426-112230
//************************************************************************

Drop_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
  string15  person1;
  string15  person2;
  string8   recent_cohabit;
  string8   zip;
  string5   prim_range;
  string1   same_lname;
  string5   number_cohabits;
  string2   eor;
end; 

header_services.Supplemental_Data.mac_verify('file_relatives_inj.txt', Drop_Layout, attr); 

Base_File_Append_In := attr();

header.Layout_Relatives reformat_layout(Base_File_Append_In L) := 
 transform
	self.person1 := (unsigned6) L.person1;
	self.person2 := (unsigned6) L.person2;
	self.recent_cohabit := (integer3) L.recent_cohabit;
	self.zip := (integer3) L.zip;
	self.prim_range := (integer2) L.prim_range;
	self.same_lname := (boolean) L.same_lname;
	self.number_cohabits := (unsigned2) L.number_cohabits;
    self := L;
 end;
Base_File_Append := project(Base_File_Append_In, reformat_layout(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

//***********END*************************************************************

ro := dataset('~thor_data400::base::relatives_for_moxie',header.Layout_Relatives,flat);

Suppression_Layout := header_services.Supplemental_Data.layout_in;

header_services.Supplemental_Data.mac_verify('associates_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashDIDAddress := header_services.Supplemental_Data.layout_out; 

ro_temp_rec := record
 header.layout_Relatives;
 data16 hval1;
 data16 hval2;
end;

ro_temp_rec tHash_vals(header.Layout_relatives l) := transform                            
 self.hval1 := hashmd5(intformat(l.person1,15,1),intformat(l.person2,15,1));
 self.hval2 := hashmd5(intformat(l.person2,15,1),intformat(l.person1,15,1));
 self := l;
end;

ro_temp := project(ro, tHash_vals(left));

header.layout_relatives tSuppress(ro_Temp l, dSuppressedIn r) := transform
 self := l;
end;

rs := join(ro_temp,dSuppressedIn,
                          (left.hval1=right.hval or left.hval2=right.hval),
						  tSuppress(left,right),
						  left only,all);

r:= rs + Base_File_Append;


header.MAC_Despray_Relatives(r,first_thing);

u := doxie.File_Relatives_Unix_Plus;


two := BUILDINDEX(u,{same_lname,person1,person2,number_cohabits,recent_cohabit, (big_endian unsigned8 )__filepos},
			'key::moxie.relatives.same_lname.person1.person2.number_cohabits.recent_cohabit.key',moxie,overwrite);

	
three := BUILDINDEX(u,{same_lname,person2,person1,number_cohabits,recent_cohabit, (big_endian unsigned8 )__filepos},
			'key::moxie.relatives.same_lname.person2.person1.number_cohabits.recent_cohabit.key',moxie,overwrite);
			
sequential(first_thing,parallel(two,three));