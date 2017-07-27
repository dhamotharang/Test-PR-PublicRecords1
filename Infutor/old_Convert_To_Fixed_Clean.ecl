rOneField :=  record
 string OneField;
end;

dOneField     :=       dataset('~thor_data400::in::trk_infutor_files_concat',rOneField,csv(terminator('\n'),separator('|')));
//output(dOneField);

fNonZero(string Input) := if((unsigned8)Input = 0,'',Input);
//fNonzero(string Input) :=
// if(length(trim(stringlib.stringfilter(Input,'0')))=length(trim(Input)),'',Input);

infutor.Layout_Infutor_FixedLength  tOneFieldToFixed(dOneField pInput) := transform
 self.name                     := pInput.OneField[1..58];
 self.current_address_complete := pInput.OneField[59..98];
 self.street                   := pInput.OneField[99..152];
 self.city                     := pInput.OneField[153..179];
 self.state                    := pInput.OneField[180..181];
 self.zip                      := fNonzero(pInput.OneField[182..186]);
 self.zip4                     := fNonzero(pInput.OneField[187..190]);
 self.crrt                     := pInput.OneField[191..194];
 self.effective_date           := pInput.OneField[195..200];
 self.ssn_1                    := fNonzero(pInput.OneField[201..209]);
 self.ssn_1_seq_number         := pInput.OneField[210..211];
 self.ssn_2                    := fNonzero(pInput.OneField[212..220]);
 self.dwelling_type            := pInput.OneField[221..221];
 self.fips_county              := fNonzero(pInput.OneField[222..224]);
 self.phone_number             := fNonzero(pInput.OneField[225..234]);
 self.original_filing_date     := pInput.OneField[235..242];
 self.last_activity_date       := pInput.OneField[243..250];
 self.dob                      := fNonzero(pInput.OneField[251..256]);
 self.gender                   := pInput.OneField[257..257];
 self.alias1                   := pInput.OneField[258..289];
 self.alias2                   := pInput.OneField[290..321];
 self.alias3                   := pInput.OneField[322..353];
 self.prev1_street                   := pInput.OneField[354..407];
 self.prev1_city                     := pInput.OneField[408..434];
 self.prev1_state                    := pInput.OneField[435..436];
 self.prev1_zip                      := pInput.OneField[437..441];
 self.prev1_address_effective_date   := pInput.OneField[442..449];
 self.prev2_street                   := pInput.OneField[450..501]; //Why is this length shorter than others?
 self.prev2_city                     := pInput.OneField[502..528];
 self.prev2_state                    := pInput.OneField[529..530];
 self.prev2_zip                      := pInput.OneField[531..535];
// self.prev2_csz                    := pInput.OneField[502..535];
 self.prev2_address_effective_date   := pInput.OneField[536..541];
 self.prev3_street                   := pInput.OneField[542..595];
 self.prev3_city                     := pInput.OneField[596..622];
 self.prev3_state                    := pInput.OneField[623..624];
 self.prev3_zip                      := pInput.OneField[625..629];
// self.prev3_csz                    := pInput.OneField[596..629];
 self.prev3_address_effective_date   := pInput.OneField[630..635];
 self.prev4_street                   := pInput.OneField[636..689];
 self.prev4_city                     := pInput.OneField[690..716];
 self.prev4_state                    := pInput.OneField[717..718];
 self.prev4_zip                      := pInput.OneField[719..723];
// self.prev4_csz                    := pInput.OneField[690..723];
 self.prev4_address_effective_date   := pInput.OneField[724..729];
 self.prev5_street                   := pInput.OneField[730..783];
 self.prev5_city                     := pInput.OneField[784..810];
 self.prev5_state                    := pInput.OneField[811..812];
 self.prev5_zip                      := pInput.OneField[813..817];
// self.prev5_csz                    := pInput.OneField[784..817];
 self.prev5_address_effective_date   := pInput.OneField[818..823];
 self.ncoa                     := pInput.OneField[824..824];
 self.ncoa_date                := pInput.OneField[825..830];
 self.filler                   := pInput.OneField[831..831];
 self.unique_id                := pInput.OneField[832..841];
end;

dInfutorFixed :=  project(dOneField,tOneFieldToFixed(left));
//output(dInfutorFixed);
count(dInfutorFixed);

/*
slimrec := record
 dInfutorFixed.unique_id;
end;

slimrec t1(dInfutorFixed l) := transform
 self := l;
end;

p1 := project(dInfutorFixed,t1(left));

p1_dedup := dedup(p1,all);
count(p1_dedup);
*/
name_rec := record
 dInfutorFixed.unique_id;
 string58 orig_name;
 string1  name_type;
 string1  name_format;
end;

name_rec tNormalizeName(infutor.Layout_Infutor_FixedLength l, integer C) := transform
 self.orig_name   := choose(C,l.name,l.alias1,l.alias2,l.alias3);
 self.name_type   := choose(C,'P','1','2','3');
 self.name_format := choose(C,'F','L','L','L');
 self := l;
end;

dNormalizeName := normalize(dInfutorFixed,4,tNormalizeName(left,counter));
count(dNormalizeName);
//dUniqueName := dedup(sort(distribute(dNormalizeName(trim(orig_name)<>''),hash(orig_name)),orig_name,local),orig_name,local);
dUniqueName := dedup(dNormalizeName(trim(orig_name)<>''),orig_name,all) : persist('persist::infutor_unique_names');
count(dUniqueName);

clean_name_rec := record
 name_rec;
 string73 pname;
end;

clean_name_rec tCleanName(dUniqueName l) := transform
 self.pname := if(l.name_format='F',AddrCleanLib.CleanPersonFML73(l.orig_name),AddrCleanLib.CleanPersonLFM73(l.orig_name));
 self := l;
end;

dCleanName := project(dUniqueName,tCleanName(left));

addr_rec := record
 dInfutorFixed.unique_id;
 string54 street;
 string31 city;
 string2  state;
 string5  zip;
 string1  addr_type;
end;

addr_rec tNormalizeAddr(infutor.Layout_Infutor_FixedLength l, integer C) := transform
 self.street := choose(C,l.street,l.prev1_street,l.prev2_street,l.prev3_street,l.prev4_street,l.prev5_street);
 self.city   := choose(C,l.city,l.prev1_city,l.prev2_city,l.prev3_city,l.prev4_city,l.prev5_city);
 self.state  := choose(C,l.state,l.prev1_state,l.prev2_state,l.prev3_state,l.prev4_state,l.prev5_state);
 self.zip    := choose(C,l.zip,l.prev1_zip,l.prev2_zip,l.prev3_zip,l.prev4_zip,l.prev5_zip);
 self.addr_type := choose(C,'P','1','2','3','4','5');
 self := l;
end;

dNormalizeAddr := normalize(dInfutorFixed,5,tNormalizeAddr(left,counter));
count(dNormalizeAddr);
//dUniqueAddr := dedup(sort(distribute(dNormalizeAddr(trim(street)<>'' or trim(city)<>''),hash(street,city,state,zip)),street,city,state,zip,local),street,city,state,zip,local);
dUniqueAddr := dedup(dNormalizeAddr(trim(street)<>'' or trim(city)<>''),street,city,state,zip,all) : persist('persist::infutor_unique_addresses');
count(dUniqueAddr);

addr_rec_csz := record
 addr_rec;
 string40 csz;
end;

addr_rec_csz tCreateCSZ(dUniqueAddr l) := transform
 self.csz := trim(l.city)+' '+trim(l.state)+' '+trim(l.zip);
 self := l;
end;

dUniqueAddrCSZ := project(dUniqueAddr,tCreateCSZ(left));

Address.MAC_Address_Clean(dUniqueAddrCSZ,street,csz,true,dCleanAddr);

output(dCleanName,,'out::infutor_pname',__compressed__);
output(dCleanAddr,,'out::infutor_clean_addr',__compressed__);
 

/*
infutor.Layout_Infutor_FixedLength_Clean tCleanNameAddr(infutor.Layout_Infutor_FixedLength l) := transform
 self.clean_dob  := if(trim(l.dob)<>'',l.dob+'00','');
 self.pname_name := AddrCleanLib.CleanPersonFML73(l.name);
 self.clean_addr := AddrCleanLib.CleanAddress182(l.street,l.csz);
 self := l;
 self := [];
end;
 
p1 := project(dInfutorFixed,tCleanNameAddr(left));
 
//p1_has_alias := p1(trim(alias1)<>'' or trim(alias2)<>'' or trim(alias3)<>'');
//p1_no_alias  := p1(trim(alias1)='' and trim(alias2)='' and trim(alias3)='');
p1_has_alias := p1(trim(alias1)<>'');
p1_no_alias  := p1(trim(alias1)='');

infutor.Layout_Infutor_FixedLength_Clean tCleanAlias(infutor.Layout_Infutor_FixedLength_Clean l) := transform 
 self.pname_alias1 := AddrCleanLib.CleanPersonLFM73(l.alias1);
 self.pname_alias2 := AddrCleanLib.CleanPersonLFM73(l.alias2);
 self.pname_alias3 := AddrCleanLib.CleanPersonLFM73(l.alias3);
 self := l;
end;
 
p2 := project(p1_has_alias,tCleanAlias(left))+p1_no_alias;
 
p2_has_prev_addr := p2(trim(prev1_street)<>'' or trim(prev1_csz)<>'');
p2_no_prev_addr  := p2(trim(prev1_street)='' and trim(prev1_csz)='');
 
infutor.Layout_Infutor_FixedLength_Clean tCleanPrevAddr(infutor.Layout_Infutor_FixedLength_Clean l) := transform
 self.clean_prev1_addr := AddrCleanLib.CleanAddress182(l.prev1_street,l.prev1_csz);
 self.clean_prev2_addr := AddrCleanLib.CleanAddress182(l.prev2_street,l.prev2_csz);
 self.clean_prev3_addr := AddrCleanLib.CleanAddress182(l.prev3_street,l.prev3_csz);
 self.clean_prev4_addr := AddrCleanLib.CleanAddress182(l.prev4_street,l.prev4_csz);
 self.clean_prev5_addr := AddrCleanLib.CleanAddress182(l.prev5_street,l.prev5_csz);
 self := l;
end;
 
p3 := project(p2_has_prev_addr,tCleanPrevAddr(left))+p2_no_prev_addr;
  
Convert_To_Fixed_Clean := p3 : persist('persist::infutor_fixedlength');
 
count(Convert_To_Fixed_Clean);
output(Convert_To_Fixed_Clean);
*/