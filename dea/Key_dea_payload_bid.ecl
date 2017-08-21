import doxie,autokeyb2;

b_in := DEA.File_Dea_bid;

sep_rec := record
unsigned6 fakeid := 0;
b_in;
string10 cprim_range;
string28 cprim_name;
string8  csec_range;
string25 cv_city_name;
string2  cst;
string5  czip;
unsigned1 zero := 0;
unsigned6 inDID;
unsigned6 inBDID;
end;

sep_rec into_bus(b_in L) := transform
 self.prim_range := if(l.is_company_flag,'',l.prim_range);
 self.prim_name := if(l.is_company_flag,'',l.prim_name);
 self.sec_range := if(l.is_company_flag,'',l.sec_range);
 self.v_city_name := if(l.is_company_flag,'',l.v_city_name);
 self.st := if(l.is_company_flag,'',l.st);
 self.zip := if(l.is_company_flag,'',l.zip);
 self.cprim_range := if(l.is_company_flag,l.prim_range,'');
 self.cprim_name := if(l.is_company_flag,l.prim_name,'');
 self.csec_range := if(l.is_company_flag,l.sec_range,'');
 self.cv_city_name := if(l.is_company_flag,l.v_city_name,'');
 self.cst := if(l.is_company_flag,l.st,'');
 self.czip := if(l.is_company_flag,l.zip,'');
 self.inDID := (unsigned6)l.did;
 self.inBDID := (unsigned6)l.bdid;
 self := l;
end;

b := project(b_in,into_bus(left));

export Key_dea_payload_bid := index(b,{fakeid},{b},'~thor_data400::key::dea::'+ doxie.Version_SuperKey + '::autokey::bid::payload');
