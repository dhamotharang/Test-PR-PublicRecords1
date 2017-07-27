//Build a test base of 1000 Names

fnames_male :=['JOHN','FRANK','JOSE','PEDRO','SUNIL','RAVI','WOLF','WILLIAM','NICHOLAS','PAUL','SIMON'];
fnames_female :=['JOAN','FRANCES','ANGELA','MEENA','RITA','CORAZON','TRISHA','TASHA','SUSAN','CARLA','ASHA'];
lastnames :=['SMITH','JONES','RAMIREZ','CHO','PATEL','JOHANSSEN','BORDEN','CAMPBELL','COHN','KHAN','ALI'];
sufx := ['','JR','','SR','','II','','III'];
//
//
layout_names := RECORD
Integer id   ;
String fname;
String middle;
String lname;
String suffix; 
END;

layout_names genFirstNames(layout_names l, integer C) := TRANSFORM
self.id := C;
self.fname := fnames_male[(C % 11)+1];
self :=l;
END;
blank_ds := DATASET([{0,'FRANK','LLOYD','BRIGHT','JR'}],layout_names);

fnames_ds := normalize(blank_ds,10,genFirstNames(left,counter));

layout_names genMiddleNames(layout_names l, integer C) := TRANSFORM
self.id := C;
self.middle := fnames_male[(C % 11)+1];
self :=l;
END;

mnames_ds := normalize(fnames_ds,10,genMiddleNames(left,counter));

layout_names genLastNames(layout_names l, integer C) := TRANSFORM
self.id := C;
self.lname := lastnames[(C % 11)+1];
self.suffix :=sufx[(c%8)+1];
self :=l;
END;

lnames_ds := normalize(mnames_ds,10,genLastNames(left,counter));

layout_names genFemaleNames(layout_names l, integer C) := TRANSFORM
self.id := C;
self.fname := fnames_female[(C % 11)+1];
self.middle := fnames_female[(C*C*C% 11)+1];
self.lname:= lastnames[((c*C*C+3) % 11)+1];
self.suffix:= '';
END;

layout_cleanNames:=RECORD
layout_names;
String78 clean_name;
END;

layout_cleanNames cleanNames(layout_names l):= TRANSFORM
String nam:=TRIM((L.FNAME+' '+L.MIDDLE+' '+L.LNAME+' '+L.SUFFIX),LEFT,RIGHT);
self.clean_name := AddrCleanLib.CleanPersonFML73(trim(regexreplace('^O ',nam,'O')));
self :=l;
END;



blank_female := DATASET([{0,'JULIA','ROBERTS','SAMSON',''}],layout_names);
//malenames_ds := normalize(blank_ds,500,genMaleNames(left,counter));
//femalenames_ds := normalize(blank_female,500,genFemaleNames(left,counter));
znames_ds:= project(lnames_ds,cleanNames(left));
znames_hash:= sum(znames_ds,HASH(clean_name,fname,middle,lname));
output(znames_hash);
export buildTestNames 
:= IF(znames_hash != 2184127774635, 
      'NAMES TEST FAILED',
      '1000 CLEAN NAMES TEST SUCCESSFUL'
			);//: PERSIST('TEST::CleanNames');




