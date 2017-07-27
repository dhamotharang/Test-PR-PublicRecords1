export MAC_Header_Blanks(f,thresh, outputname) := macro
#uniquename(r)
%r% := record
  f.st;
  total_recs := count(group);
  blank_did := sum(group, if( f.did = 0, 1, 0));
  blank_rid := sum(group, if( f.rid = 0, 1, 0));
  blank_pflag1 := sum(group,if( f.pflag1='', 1, 0));
  blank_pflag2 := sum(group,if( f.pflag2='', 1, 0));
  blank_pflag3 := sum(group,if( f.pflag3='', 1, 0));
  blank_src := sum(group,if(f.src='',1,0));
  blank_dt_first_seen := sum(group,if((integer)f.dt_first_seen=0,1,0));
  blank_dt_last_seen := sum(group,if((integer)f.dt_last_seen=0,1,0));
  blank_dt_last_reported := sum(group,if((integer)f.dt_vendor_last_reported=0,1,0));
  blank_dt_first_reported := sum(group,if((integer)f.dt_vendor_first_reported=0,1,0));
  blank_dt_nonglb_last_seen := sum(group,if((integer)f.dt_nonglb_last_seen=0,1,0));
  blank_rec_type := sum(group,if(f.rec_type='',1,0));
  blank_vendor_id := sum(group,if(f.vendor_id='',1,0));
  blank_phone := sum(group,if((integer)f.phone=0,1,0));
  short_phone := sum(group,if((integer)f.phone<>0 and length(trim(f.phone))<>10,1,0));
  blank_ssn := sum(group,if((integer)f.ssn=0,1,0));
  blank_dob := sum(group,if(f.dob=0,1,0));
  short_dob := sum(group,if(f.dob<>0 and (f.dob div 100) * 100 = f.dob,1,0));
  blank_title := sum(group,if(f.title='',1,0));
  blank_fname := sum(group,if(f.fname='',1,0));
  short_fname := sum(group,if(length(trim(f.fname))=1,1,0));
  blank_mname := sum(group,if(f.mname='',1,0));
  short_mname := sum(group,if(length(trim(f.mname))=1,1,0));
  blank_lname := sum(group,if(f.lname='',1,0));
  short_lname := sum(group,if(length(trim(f.lname))=1,1,0));
  blank_name_suffix := sum(group,if(f.name_suffix='',1,0));
  blank_prim_range := sum(group,if(f.prim_range='',1,0));
  blank_prim_name := sum(group,if(f.prim_name='',1,0));
  blank_predir := sum(group,if(f.predir='',1,0));
  blank_suffix := sum(group,if(f.suffix='',1,0));
  blank_postdir := sum(group,if(f.postdir='',1,0));
  blank_unit_desig := sum(group,if(f.unit_desig='',1,0));
  blank_sec_range := sum(group,if(f.sec_range='',1,0));
  blank_city_name := sum(group,if(f.city_name='',1,0));
  blank_zip := sum(group,if((integer)f.zip=0,1,0));
  blank_zip4 := sum(group,if((integer)f.zip4=0,1,0));
  blank_count := sum(group,if(f.county='',1,0));
  blank_geo := sum(group,if(f.geo_blk='',1,0));
  blank_cbsa := sum(group,if(f.cbsa='',1,0));
  blank_tnt := sum(group,if(f.tnt='',1,0));
  end;

#uniquename(myt)
%myt% := table(f,%r%,f.st);

outputname := output(choosen(%myt%(total_recs>thresh),1000), NAMED('header_blanks'));

endmacro;