Import data_services;
r:=RECORD
  string2 st;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 zip;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
 END;

d	:=dataset([],r);

EXPORT Key_Auto_Stname(string Platform ) :=	Index(d,{d},
																									data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																									+Platform +'::qa::autokey::stname');
