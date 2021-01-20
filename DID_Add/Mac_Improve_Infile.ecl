/*2008-11-13T15:31:24Z (wma)
c:\SuperComputer\Dataland\QueryBuilder\workspace\wma\Dataland_400_Staging\wma\Mac_Improve_Infile\2008-11-13T15_31_24Z.ecl
*/
export Mac_Improve_Infile(infile,src_field,fname_field,mname_field,lname_field,prim_range_field,
prim_name_field, sec_range_field,zip_field,ssn_field,dob_field,outfile) := macro

IMPORT mdr, header;

fn_cleanup(string pIn) := function
 pOut1 := trim(regexreplace('[!$^*<>?]',pIn,' '),left,right);
 pOut  := trim(stringlib.stringfindreplace(pOut1,'\'',''),left,right);
 return pOut;
end;

#uniquename(improve_infile1)
typeof(infile) %improve_infile1%(infile le) := transform

 self.fname_field     := fn_cleanup(le.fname_field);
 self.mname_field     := fn_cleanup(le.mname_field);
 self.lname_field     := fn_cleanup(le.lname_field);

 string4 v_dob   := (string)le.dob_field[1..4];
 boolean bad_dob := (~(v_dob between '1800' and ut.getdate[1..4])) and le.dob_field>0;
 self.dob_field       := if(bad_dob=true,0,le.dob_field);

 string v_prim_name := fn_cleanup(le.prim_name_field);
 boolean prim_name_is_bogus := ut.bogusstreets(v_prim_name);

 prim_name	:= if(prim_name_is_bogus,'',v_prim_name);;
 sec_range	:= if(prim_name_is_bogus,'',fn_cleanup(le.sec_range_field));

 self.prim_name_field	:= prim_name;
 self.prim_range_field := if(prim_name_is_bogus or trim(le.prim_range_field)='0','',le.prim_range_field);
 self.sec_range_field  := sec_range;
 self.ssn_field        := if(mdr.sourceTools.sourceisdeath(le.src_field) and length(trim(stringlib.stringfilter(le.ssn_field,'0123456789'),left,right))=9,le.ssn_field,
                          if(length(trim(stringlib.stringfilter(le.ssn_field,'0123456789'),left,right))=9,le.ssn_field[6..9],
                          if(le.src_field in ['BA','L2'] and length(trim(le.ssn_field,left,right))=4 and le.ssn_field=stringlib.stringfilter(le.ssn_field,'0123456789'),le.ssn_field,
						  '')));
 self.zip_field        := if((integer)le.zip_field=0,'',le.zip_field);
 self           := le;
end;

#uniquename(p1)
%p1% := project(infile,%improve_infile1%(left));

//Patch where mname equals 'NMI' or 'NMN'
#uniquename(keep_em_mname)
#uniquename(keep_em_better_pr)
#uniquename(keep_em_better_dob)
#uniquename(improve_infile2)
header.MAC_NMI_NMN(%p1%,mname_field,%keep_em_mname%)

//fix any funky prim_ranges

header.MAC_Improve_Prim_Range(%keep_em_mname%,prim_range_field, %keep_em_better_pr%)

//Fix any funky DOBs
header.MAC_format_DOB(%keep_em_better_pr%, dob_field,%keep_em_better_dob%)

//trim dob and mname and keep the same length in name source file
typeof(infile) %improve_infile2%(%keep_em_better_dob% le) := transform

self.mname_field := le.mname_field[1];
self.dob_field   := (integer)(string)le.dob_field[1..4];
self := le;
end;

outfile := project(%keep_em_better_dob%, %improve_infile2%(left));

endmacro;
