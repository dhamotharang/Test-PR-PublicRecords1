import ut,AutoKey, std;
 infile :=DriversV2.File_Uber_auto_base;

 //NORMALIZING WORDS
    
   fld_cnst(string fld) := Autokey.UBER_Constants.Uber_FieldData(FieldName=fld)[1].FieldID;	
   	
   Layouts_DL_Uber.Layout_Plus IntoInversion(infile le,unsigned2 c) := transform
     self.word := choose(c,(string)le.FNAME,(string)le.PFNAME,(string)le.MNAME
   	,(string)le.LNAME,(string)le.DPH_LNAME,(string)le.PRIM_RANGE,(string)le.PREDIR
   	,(string)le.PRIM_NAME,(string)le.SUFFIX,(string)le.POSTDIR
   	,(string)le.UNIT_DESIG,(string)le.SEC_RANGE,(string)le.P_CITY_NAME
   	,(string)le.ST,(string)le.ZIP5,(string)le.DOB,SKIP);
   
     self.field := choose(c,fld_cnst('FNAME'),fld_cnst('PFNAME'),fld_cnst('MNAME')
   	,fld_cnst('LNAME'),fld_cnst('DPH_LNAME'),fld_cnst('PRANGE'),fld_cnst('PREDIR')
   	,fld_cnst('PNAME'),fld_cnst('SUFFIX'),fld_cnst('POSTDIR')
   	,fld_cnst('UNIT_DESIG'),fld_cnst('SEC_RANGE'),fld_cnst('CITY')
   	,fld_cnst('STATE'),fld_cnst('ZIP'),fld_cnst('DOB'),SKIP);
   	
     self.uid := le.FAKEID;
   end;
   
   nfields_r := normalize(infile,16,IntoInversion(left,counter),local);
   
   //NORMALIZING ADDR
   	Layouts_DL_Uber.Layout_Plus tr(infile le,unsigned c,unsigned typ,unsigned fld) := transform
   	  new_word := MAP(typ =1=>le.prim_range
   		               ,typ =2=>le.predir
   		               ,typ =3=>le.prim_name
   		               ,typ =4=>le.suffix
   		               ,typ =5=>le.postdir
   		               ,typ =6=>le.unit_desig
   		               ,typ =7=>le.sec_range
   									 ,'');
   	  self.word := ut.Word((string)new_word,c);
   		self.uid := le.fakeid;
   		self.field := fld;
   	end;
   
   cnt_flds := normalize(infile,std.Str.CountWords((string)left.prim_range,' '),tr(left,counter,1,fld_cnst('ADDR')),local)
              +normalize(infile,std.Str.CountWords((string)left.predir,' '),tr(left,counter,2,fld_cnst('ADDR')),local)
              +normalize(infile,std.Str.CountWords((string)left.prim_name,' '),tr(left,counter,3,fld_cnst('ADDR')),local)
      	      +normalize(infile,std.Str.CountWords((string)left.suffix,' '),tr(left,counter,4,fld_cnst('ADDR')),local)
      	      +normalize(infile,std.Str.CountWords((string)left.postdir,' '),tr(left,counter,5,fld_cnst('ADDR')),local)
      	      +normalize(infile,std.Str.CountWords((string)left.unit_desig,' '),tr(left,counter,6,fld_cnst('ADDR')),local)
      	      +normalize(infile,std.Str.CountWords((string)left.sec_range,' '),tr(left,counter,7,fld_cnst('ADDR')),local);
   
   //WORD TABLE
   invert_records := (nfields_r + cnt_flds)(word<>'');
   
 export File_uber_in := dedup(sort(invert_records,uid,word,field,local),uid,word,field,local):PERSIST('~thor400_88_staging::dl::uber::uni_words');;