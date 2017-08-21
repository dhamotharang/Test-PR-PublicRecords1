import ut, addresscleaner_monthly_testing, address, BO_Address;

  #workunit('protect',true);
  #workunit('name','AddressCleaner Build Enclarity Data '+ addresscleaner_monthly_testing.version);
  //#option('AllowedClusters','thor400_30,thor400_60');
  #OPTION('multiplePersistInstances',FALSE);
  //#option('AllowAutoSwitchQueue',TRUE);
	
	
r:=RECORD
unsigned6 record_id;
string line1;
string line2;
end;


d := dataset('~thor400_data::in::addresscleaner::perm_data',r,flat);



p:=RECORD
r;
string10 prange;
string2 ppre;
string28 pprim_name;
string4 psuffix;
string2 ppost;
string10 punit;
string8 psec_range;
string25 pcity;
string25 pvanity;
string2 pstate;
string5 pzip5;
string4 pzip4;
string4 pcart;
string1 psort;
string4 plot;
string1 porder;
string2 pdpbc;
string1 pchk;
string2 ptype;
string2 pfips_state;
string3 pfips_county;
string9 prural_rt_no;
string9 ppobox;
string50 psec_addr;
string1 prdi;
string64 paddr1_remainder;
string64 paddr1_extra1;
string64 paddr1_extra2;
string64 paddr1_extra3;
string64 paddr1_extra4;
string64 paddr1_extra5;
string64 paddr1_extra6;
string64 paddr1_extra7;
string64 paddr1_extra8;
string64 paddr1_extra9;
string64 paddr1_extra10;
string64 paddr2;
string10 paddr2_unit_no;
string10 paddr2_non_postal;
string10 paddr2_postal_type;
string10 pnon_postal_unit;
string10 pnon_postal_unit_nbr;
string10 prural_box_nbr;
string10 plat;
string11 plong;
string4 pmsa;
string7 pblock;
string1 pmatch;
string4 perror;
END;

c:=RECORD
r;
string10 crange;
string2 cpre;
string28 cprim_name;
string4 csuffix;
string2 cpost;
string10 cunit;
string8 csec_range;
string25 ccity;
string25 cvanity;
string2 cstate;
string5 czip5;
string4 czip4;
string4 ccart;
string1 csort;
string4 clot;
string1 corder;
string2 cdpbc;
string1 cchk;
string2 ctype;
string2 cfips_state;
string3 cfips_county;
string9 crural_rt_no;
string9 cpobox;
string50 csec_addr;
string1 crdi;
string64 caddr1_remainder;
string64 caddr1_extra1;
string64 caddr1_extra2;
string64 caddr1_extra3;
string64 caddr1_extra4;
string64 caddr1_extra5;
string64 caddr1_extra6;
string64 caddr1_extra7;
string64 caddr1_extra8;
string64 caddr1_extra9;
string64 caddr1_extra10;
string64 caddr2;
string10 caddr2_unit_no;
string10 caddr2_non_postal;
string10 caddr2_postal_type;
string10 cnon_postal_unit;
string10 cnon_postal_unit_nbr;
string10 crural_box_nbr;
string10 clat;
string11 clong;
string4 cmsa;
string7 cblock;
string1 cmatch;
string4 cerror;
END;


// c:=RECORD
// r;
// string crange;
// string cpre;
// string cprim_name;
// string csuffix;
// string cpost;
// string cunit;
// string csec_range;
// string ccity;
// string cvanity;
// string cstate;
// string czip5;
// string czip4;
// string ccart;
// string csort;
// string clot;
// string corder;
// string cdpbc;
// string cchk;
// string ctype;
// string cfips_state;
// string cfips_county;
// string crural_rt_no;
// string cpobox;
// string csec_addr;
// string crdi;
// string caddr1_remainder;
// string caddr1_extra1;
// string caddr1_extra2;
// string caddr1_extra3;
// string caddr1_extra4;
// string caddr1_extra5;
// string caddr1_extra6;
// string caddr1_extra7;
// string caddr1_extra8;
// string caddr1_extra9;
// string caddr1_extra10;
// string caddr2;
// string caddr2_unit_no;
// string caddr2_non_postal;
// string caddr2_postal_type;
// string cnon_postal_unit;
// string cnon_postal_unit_nbr;
// string crural_box_nbr;
// string clat;
// string clong;
// string cmsa;
// string cblock;
// string cmatch;
// string cerror;
// END;



//BOCleanAddressEnclarity (const string line1,const string line2,
//							const string server = BO_Address.BO_Server, 
//							unsigned2 port = BO_Address.BO_Port)	:= FUNCTION
p TransP (d X) := TRANSFORM
//        Clean  		:= BO_Address.BOCleanAddressEnclarity(TRIM(X.line1,RIGHT,LEFT),TRIM(X.line2,RIGHT,LEFT),server := BO_Address.BO_EnclarityServer,port :=BO_Address.BO_EnclarityPort);
					Clean  		:= BO_Address.CleanAddressEnclarity(TRIM(X.line1,RIGHT,LEFT),TRIM(X.line2,RIGHT,LEFT),server := '10.173.11.21',port :=BO_Address.BO_EnclarityPort);
STRING5   v_zip       		  := Clean[117..121];
STRING4   v_zip4      		  := Clean[122..125];			 
SELF.prange                 := Clean[1..10];
SELF.ppre                   := Clean[11..12];
SELF.pprim_name	            := Clean[13..40];
SELF.psuffix                := Clean[41..44];
SELF.ppost                  := Clean[45..46];
SELF.punit                  := Clean[47..56];
SELF.psec_range             := Clean[57..64];
SELF.pcity                  := Clean[65..89];
SELF.pvanity                := Clean[90..114];
SELF.pstate                 := Clean[115..116];
SELF.pzip5                  := if(v_zip='00000','',v_zip);
SELF.pzip4                  := if(v_zip4='0000','',v_zip4);
SELF.pcart                  := Clean[126..129];
SELF.psort                  := Clean[130..130];
SELF.plot                   := Clean[131..134];
SELF.porder                 := Clean[135..135];
SELF.pdpbc     	            := Clean[136..137];
SELF.pchk                   := Clean[138..138];
SELF.ptype                  := Clean[139..140];
SELF.pfips_state            := Clean[141..142];
SELF.pfips_county           := Clean[143..145];
SELF.prural_rt_no           := Clean[146..154];
SELF.ppobox                 := Clean[155..163];
SELF.psec_addr              := Clean[164..213];
SELF.prdi                   := Clean[214];
SELF.paddr1_remainder       := Clean[215..278];
SELF.paddr1_extra1          := Clean[279..342];
SELF.paddr1_extra2          := Clean[343..406];
SELF.paddr1_extra3          := Clean[407..470];
SELF.paddr1_extra4          := Clean[471..534];
SELF.paddr1_extra5          := Clean[535..598];
SELF.paddr1_extra6          := Clean[599..662];
SELF.paddr1_extra7          := Clean[663..726];
SELF.paddr1_extra8          := Clean[727..790];
SELF.paddr1_extra9          := Clean[791..854];
SELF.paddr1_extra10         := Clean[855..918];
SELF.paddr2                 := Clean[919..982];
SELF.paddr2_unit_no         := Clean[983..992];
SELF.paddr2_non_postal      := Clean[993..1002];
SELF.paddr2_postal_type     := Clean[1003..1012];
SELF.pnon_postal_unit       := Clean[1013..1022];
SELF.pnon_postal_unit_nbr   := Clean[1023..1032];
SELF.prural_box_nbr         := Clean[1033..1042];
SELF.plat                   := Clean[1043..1052];
SELF.plong                  := Clean[1053..1063];
SELF.pmsa                   := Clean[1064..1067];
SELF.pblock                 := Clean[1068..1074];
SELF.pmatch                 := Clean[1075];
SELF.perror                 := Clean[1076..1079];
SELF                        := X
END;

dProjP			:= PROJECT ( d , TransP ( LEFT ) )	;

//BOCleanAddressEnclarity (const string line1,const string line2,
//							const string server = BO_Address.BO_Server, 
//							unsigned2 port = BO_Address.BO_Port)	:= FUNCTION
//sap_troxieinterlb.br.seisint.com 
 c TransC (d X) := TRANSFORM
//        Clean  		:= BO_Address.CleanAddressEnclarity(TRIM(X.line1,RIGHT,LEFT),TRIM(X.line2,RIGHT,LEFT),'10.121.146.134',21600);
        Clean  		:= BO_Address.CleanAddressEnclarity(TRIM(X.line1,RIGHT,LEFT),TRIM(X.line2,RIGHT,LEFT),'postalclean18.br.seisint.com',21600);
STRING5   v_zip       		  := Clean[117..121];
STRING4   v_zip4      		  := Clean[122..125];			 
SELF.crange                 := Clean[1..10];
SELF.cpre                   := Clean[11..12];
SELF.cprim_name	            := Clean[13..40];
SELF.csuffix                := Clean[41..44];
SELF.cpost                  := Clean[45..46];
SELF.cunit                  := Clean[47..56];
SELF.csec_range             := Clean[57..64];
SELF.ccity                  := Clean[65..89];
SELF.cvanity                := Clean[90..114];
SELF.cstate                 := Clean[115..116];
SELF.czip5                  := if(v_zip='00000','',v_zip);
SELF.czip4                  := if(v_zip4='0000','',v_zip4);
SELF.ccart                  := Clean[126..129];
SELF.csort                  := Clean[130..130];
SELF.clot                   := Clean[131..134];
SELF.corder                 := Clean[135..135];
SELF.cdpbc     	            := Clean[136..137];
SELF.cchk                   := Clean[138..138];
SELF.ctype                  := Clean[139..140];
SELF.cfips_state            := Clean[141..142];
SELF.cfips_county           := Clean[143..145];
SELF.crural_rt_no           := Clean[146..154];
SELF.cpobox                 := Clean[155..163];
SELF.csec_addr              := Clean[164..213];
SELF.crdi                   := Clean[214];
SELF.caddr1_remainder       := Clean[215..278];
SELF.caddr1_extra1          := Clean[279..342];
SELF.caddr1_extra2          := Clean[343..406];
SELF.caddr1_extra3          := Clean[407..470];
SELF.caddr1_extra4          := Clean[471..534];
SELF.caddr1_extra5          := Clean[535..598];
SELF.caddr1_extra6          := Clean[599..662];
SELF.caddr1_extra7          := Clean[663..726];
SELF.caddr1_extra8          := Clean[727..790];
SELF.caddr1_extra9          := Clean[791..854];
SELF.caddr1_extra10         := Clean[855..918];
SELF.caddr2                 := Clean[919..982];
SELF.caddr2_unit_no         := Clean[983..992];
SELF.caddr2_non_postal      := Clean[993..1002];
SELF.caddr2_postal_type     := Clean[1003..1012];
SELF.cnon_postal_unit       := Clean[1013..1022];
SELF.cnon_postal_unit_nbr   := Clean[1023..1032];
SELF.crural_box_nbr         := Clean[1033..1042];
SELF.clat                   := Clean[1043..1052];
SELF.clong                  := Clean[1053..1063];
SELF.cmsa                   := Clean[1064..1067];
SELF.cblock                 := Clean[1068..1074];
SELF.cmatch                 := Clean[1075];
SELF.cerror                 := Clean[1076..1079];
SELF                        := X
END;

dProjC			:= PROJECT ( d , TransC ( LEFT ) )	;

inRec :=RECORD
string line1; 
string line2;     
string prange;
string ppre;
string pprim_name;
string psuffix;
string ppost;
string punit;
string psec_range;
string pcity;
string pvanity;
string pstate;
string pzip5;
string pzip4;
string pcart;
string psort;
string plot;
string porder;
string pdpbc;
string pchk;
string ptype;
string pfips_state;
string pfips_county;
string prural_rt_no;
string ppobox;
string psec_addr;
string prdi;
string paddr1_remainder;
string paddr1_extra1;
string paddr1_extra2;
string paddr1_extra3;
string paddr1_extra4;
string paddr1_extra5;
string paddr1_extra6;
string paddr1_extra7;
string paddr1_extra8;
string paddr1_extra9;
string paddr1_extra10;
string paddr2;
string paddr2_unit_no;
string paddr2_non_postal;
string paddr2_postal_type;
string pnon_postal_unit;
string pnon_postal_unit_nbr;
string prural_box_nbr;
string plat;
string plong;
string pmsa;
string pblock;
string pmatch;
string perror;
string crange;
string cpre;
string cprim_name;
string csuffix;
string cpost;
string cunit;
string csec_range;
string ccity;
string cvanity;
string cstate;
string czip5;
string czip4;
string ccart;
string csort;
string clot;
string corder;
string cdpbc;
string cchk;
string ctype;
string cfips_state;
string cfips_county;
string crural_rt_no;
string cpobox;
string csec_addr;
string crdi;
string caddr1_remainder;
string caddr1_extra1;
string caddr1_extra2;
string caddr1_extra3;
string caddr1_extra4;
string caddr1_extra5;
string caddr1_extra6;
string caddr1_extra7;
string caddr1_extra8;
string caddr1_extra9;
string caddr1_extra10;
string caddr2;
string caddr2_unit_no;
string caddr2_non_postal;
string caddr2_postal_type;
string cnon_postal_unit;
string cnon_postal_unit_nbr;
string crural_box_nbr;
string clat;
string clong;
string cmsa;
string cblock;
string cmatch;
string cerror;
END;	

inRec processed_key_records_output(dProjP l, dProjC r) := TRANSFORM
 // Self := le;
//	Self := ri;
	//Self := [];
self.line1             := l.line1;    
self.line2             := l.line2;     
self.prange            := l.prange;
self.ppre						   := l.ppre;
self.pprim_name        := l.pprim_name;
self.psuffix           := l.psuffix;
self.ppost             := l.ppost;
self.punit             := l.punit;
self.psec_range        := l.psec_range;
self.pcity             := l.pcity;
self.pvanity           := l.pvanity;
self.pstate            := l.pstate;
self.pzip5             := l.pzip5;
self.pzip4             := l.pzip4;
self.pcart             := l.pcart;
self.psort             := l.psort;
self.plot              := l.plot;
self.porder            := l.porder;
self.pdpbc             := l.pdpbc;
self.pchk              := l.pchk;
self.ptype             := l.ptype;
self.pfips_state       := l.pfips_state;
self.pfips_county      := l.pfips_county;
self.prural_rt_no      := l.prural_rt_no;
self.ppobox            := l.ppobox;
self.psec_addr         := l.psec_addr;
self.prdi              := l.prdi;
self.paddr1_remainder  := l.paddr1_remainder;
self.paddr1_extra1     := l.paddr1_extra1;
self.paddr1_extra2     := l.paddr1_extra2;
self.paddr1_extra3     := l.paddr1_extra3;
self.paddr1_extra4     := l.paddr1_extra4;
self.paddr1_extra5     := l.paddr1_extra5;
self.paddr1_extra6     := l.paddr1_extra6;
self.paddr1_extra7     := l.paddr1_extra7;
self.paddr1_extra8     := l.paddr1_extra8;
self.paddr1_extra9     := l.paddr1_extra9;
self.paddr1_extra10    := l.paddr1_extra10;
self.paddr2            := l.paddr2;
self.paddr2_unit_no    := l.paddr2_unit_no;
self.paddr2_non_postal := l.paddr2_non_postal;
self.paddr2_postal_type := l.paddr2_postal_type;
self.pnon_postal_unit    := l.pnon_postal_unit;
self.pnon_postal_unit_nbr := l.pnon_postal_unit_nbr;
self.prural_box_nbr        := l.prural_box_nbr;
self.plat                  := l.plat;
self.plong                 := l.plong;
self.pmsa                  := l.pmsa;
self.pblock                := l.pblock;
self.pmatch                := l.pmatch;
self.perror                := l.perror;
self.crange            := r.crange;
self.cpre						   := r.cpre;
self.cprim_name        := r.cprim_name;
self.csuffix           := r.csuffix;
self.cpost             := r.cpost;
self.cunit             := r.cunit;
self.csec_range        := r.csec_range;
self.ccity             := r.ccity;
self.cvanity           := r.cvanity;
self.cstate            := r.cstate;
self.czip5             := r.czip5;
self.czip4             := r.czip4;
self.ccart             := r.ccart;
self.csort             := r.csort;
self.clot              := r.clot;
self.corder            := r.corder;
self.cdpbc             := r.cdpbc;
self.cchk              := r.cchk;
self.ctype             := r.ctype;
self.cfips_state       := r.cfips_state;
self.cfips_county      := r.cfips_county;
self.crural_rt_no      := r.crural_rt_no;
self.cpobox            := r.cpobox;
self.csec_addr         := r.csec_addr;
self.crdi              := r.crdi;
self.caddr1_remainder  := r.caddr1_remainder;
self.caddr1_extra1     := r.caddr1_extra1;
self.caddr1_extra2     := r.caddr1_extra2;
self.caddr1_extra3     := r.caddr1_extra3;
self.caddr1_extra4     := r.caddr1_extra4;
self.caddr1_extra5     := r.caddr1_extra5;
self.caddr1_extra6     := r.caddr1_extra6;
self.caddr1_extra7     := r.caddr1_extra7;

self.caddr1_extra8     := r.caddr1_extra8;
self.caddr1_extra9     := r.caddr1_extra9;
self.caddr1_extra10    := r.caddr1_extra10;
self.caddr2            := r.caddr2;
self.caddr2_unit_no    := r.caddr2_unit_no;
self.caddr2_non_postal := r.caddr2_non_postal;
self.caddr2_postal_type := r.caddr2_postal_type;
self.cnon_postal_unit    := r.cnon_postal_unit;
self.cnon_postal_unit_nbr := r.cnon_postal_unit_nbr;
self.crural_box_nbr        := r.crural_box_nbr;
self.clat                  := r.clat;
self.clong                 := r.clong;
self.cmsa                  := r.cmsa;
self.cblock                := r.cblock;
self.cmatch                := r.cmatch;
self.cerror                := r.cerror;

END;	

	
processed_key_records := join(dProjP,dProjC,LEFT.record_id = RIGHT.record_id, processed_key_records_output(left,right));
output(processed_key_records,,'~thor400_data::addresscleaner_enclarity::'+addresscleaner_monthly_testing.version+'::processed',compressed,overwrite);	
fileservices.RemoveOwnedSubFiles('~thor400_data::addresscleaner::enclarity::monthly::processed');
fileservices.addsuperfile('~thor400_data::addresscleaner::enclarity::monthly::processed','~thor400_data::addresscleaner_enclarity::'+addresscleaner_monthly_testing.version+'::processed');						
OUTPUT(choosen(processed_key_records,500));

