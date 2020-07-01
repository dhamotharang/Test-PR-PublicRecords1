import header_services;

//************************************************************************
//ADD INFORMATION - CNG 20070426 - W20070426-113000
//************************************************************************

Drop_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
  string13  person1;
  string13  person2;
  string8   recent_cohabit;
  string8   zip;
  string5   prim_range;
  string1   same_lname;
  string5   number_cohabits;
  string2   eor;
end; 

header_services.Supplemental_Data.mac_verify('file_relatives_inj.txt',Drop_Header_Layout,attr);
 
Base_File_Append_In := attr();

doxie.layout_relatives_plus reformat_header(Base_File_Append_In L) := 
 transform
	self.person1 := (unsigned6) L.person1;
	self.person2 := (unsigned6) L.person2;
	self.recent_cohabit := (integer3) L.recent_cohabit;
	self.zip := (integer3) L.zip;
	self.prim_range := (integer2) L.prim_range;
	self.same_lname := (boolean) L.same_lname;
	self.number_cohabits := (unsigned2) L.number_cohabits;
	self.relative_matches:= '';
  self.relatives_match_score := ''; 
  self.shared_addr_score  :=0;
  self.Match_by_zip_score := 0 ; 
  self.nbr_of_addresses := 0 ; 
  self.dt_last_relative := 0 ; 
	self.current_relatives := true;
	self.__filepos := 0;
   self := L;
	self:= []; 
 end;
Base_File_Append := project(Base_File_Append_In, reformat_header(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT


//***********END*************************************************************

ro := dataset(doxie.Filename_Relatives_Plus,doxie.layout_relatives_plus,flat);

Suppression_Layout := header_services.Supplemental_Data.layout_in;

header_services.Supplemental_Data.mac_verify('associates_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashVal := header_services.Supplemental_Data.layout_out;

ro_temp_rec := record
 doxie.layout_Relatives_plus;
 data16 hval1;
 data16 hval2;
 data16 hval3;
 data16 hval4;
end;

ro_temp_rec tHash_vals(doxie.Layout_relatives_plus l) := transform                            
 self.hval1 := hashmd5(intformat(l.person1,15,1),intformat(l.person2,15,1));
 self.hval2 := hashmd5(intformat(l.person2,15,1),intformat(l.person1,15,1));
 self.hval3 := hashmd5(intformat(l.person1,15,1));
 self.hval4 := hashmd5(intformat(l.person2,15,1));
 self := l;
end;

ro_temp := project(ro, tHash_vals(left));

doxie.layout_relatives_plus tSuppress(ro_Temp l, dSuppressedIn r) := transform
 self := l;
end;

rs := join(ro_temp,dSuppressedIn,
                          (left.hval1=right.hval or left.hval2=right.hval or left.hval3=right.hval or left.hval4=right.hval),
						  tSuppress(left,right),
						  left only,all);

export File_Relatives_Plus := rs + Base_File_Append;
//actually matches 1031 header, this date a product of mid-month header run, oops