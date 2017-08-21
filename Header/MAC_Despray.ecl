export mac_despray(preinfile, bestaddr, outfile) := macro

//****** Filter out some old nasty DL recs
#uniquename(infile)
%infile% := preinfile(
	   ~mdr.Source_not4_Despray(src)
	   AND
	   ~(st = 'FL' and src = 'FD' and dt_first_seen = 200209 and dt_last_seen = 200209 and 
	   dt_vendor_last_reported  = 200209 and dt_vendor_first_reported = 200209 and  
	   dt_nonglb_last_seen = 200209));

//****** Split out these G recs
#uniquename(makeGLB)
typeof(%infile%) %makeGLB%(%infile% l) := transform
	self.dt_first_seen := if(l.dt_first_seen > 0 and l.dt_first_seen < 200107, 200107, l.dt_first_seen);
	self.dt_nonglb_last_seen := 0;
	self.pflag3 := '';
	self := l;
end;

#uniquename(gdouble)
%gdouble% := %infile% + project(%infile%(pflag3 = 'G' and dt_last_seen > 200106), %makeGLB%(left));

//****** Strip the SSN off the U (flagged) recs, 
//		 but also create a U (src group) rec that has it intact 
#uniquename(makeUsafe)
typeof(%infile%) %makeUsafe%(%infile% l) := transform
	self.ssn := '';			//picked up this ssn from utilities file, so we can't show it (yet)
	self.pflag3 := '';
    self.rec_type := '';
	self := l;
end;

#uniquename(makeUsrc)
typeof(%infile%) %makeUsrc%(%infile% l) := transform
	self.src := if(l.pflag3 in ['W','X'], 'UW', 'UT');		//UW is for work records
	self.pflag3 := '';
	self.TNT := if(self.src = 'UW' and (integer)l.phone > 0, 'W', l.TNT);
	self := l;
end;

#uniquename(uflags)
%uflags% := ['U','X'];	//'W' does not have dirty ssn, so we are okay

#uniquename(udouble)
%udouble% := %gdouble%(pflag3 not in %uflags%) + 							//those unaffected
		     project(%gdouble%(pflag3 in %uflags%), %makeUsafe%(left)) +  //make a clean one
			 project(%gdouble%((pflag3 in %uflags% or pflag3 = 'W') and ~mdr.source_is_on_Probation(src) and src not in mdr.Probation_Smartlinx_Override), 
				%makeUsrc%(left));    //make a U src rec


//****** Match to the BestAddress

#uniquename(iv)
%iv% := record
  bestaddr.did;
  bestaddr.rid;
  bestaddr.rec_type;
  end;

#uniquename(ta)
%ta% := table(bestaddr,%iv%);

#uniquename(add_rt)
typeof(%infile%) %add_rt%(%udouble% le,%ta% rt) := transform
  self.rec_type := if(header.isPreGLB(le), rt.rec_type, '');//a little extra protection b/c we have doubled some RIDs at this point
  self := le;
  end;
// distributing by DID implicitely distributes by RID too and helps with following sort
#uniquename(jt)
%jt% := join(distribute(%udouble%,hash(did)),
           distribute(%ta%,hash(did)),left.rid=right.rid,%add_rt%(left,right),local,left outer);

//****** Sort the file for the benefit of Mike Wyman - note only really needs clumping
#uniquename(int_header)
%int_header% := sort(%jt%, did,local);	

//-- Convert 6 digit integer date into 6 character string
//	 If date = 0, return empty string
#uniquename(convert_date6)
string6 %convert_date6%(integer4 date) := 
   MAP(date = 0 => '', 
       date % 100 = 0 => (string4)( date div 100 ) + '  ',
       date > (unsigned)ut.GetDate +  10000=> '',
       (string6)date );

//-- Convert 8 digit integer date into 8 character string
//	 If date = 0, return empty string
//	 If date has only 6 digits (missing DD), multiply by 100 (add 00)
#uniquename(convert_date8)
string8 %convert_date8%(integer4 date) := 
	map(date = 0 => '',
	    date > 100000 and date < 1000000 => (string8)(date * 100),
		(string8)date);

#uniquename(string_rec)
%string_rec% := record
//-- These 2 are integers being put into strings
	string12 	did := intformat(%int_header%.did,12,1);	//converted from int
	//string12 	preGLB_did := intformat(%int_header%.preGLB_did,12,1);	//converted from int
	string12 	rid := intformat(%int_header%.rid,12,1);  //converted from int

    string2     src := header.moxie_src_translation(%int_header%.src,%int_header%.vendor_id);
//--  These next five need to be converted
	string6 	dt_first_seen := %convert_date6%(%int_header%.dt_first_seen);
	string6     dt_last_seen := %convert_date6%(%int_header%.dt_last_seen);
	string6     dt_vendor_last_reported := 
      IF ( mdr.Source_is_DPPA(%int_header%.src) and %int_header%.dt_last_seen<>0,
           %convert_date6%(%int_header%.dt_last_seen),
           %convert_date6%(%int_header%.dt_vendor_last_reported));
	string6     dt_vendor_first_reported := 
      Map ( mdr.Source_is_DPPA(%int_header%.src) and %int_header%.dt_first_seen<>0 => %convert_date6%(%int_header%.dt_first_seen),
		  %convert_date6%(ut.Min2(%int_header%.dt_first_seen,%int_header%.dt_vendor_first_reported))[5..6]= '  ' => %convert_date6%(ut.Max2(%int_header%.dt_first_seen,%int_header%.dt_vendor_first_reported)),
           %convert_date6%(ut.Min2(%int_header%.dt_first_seen,%int_header%.dt_vendor_first_reported)));
	string6     dt_nonglb_last_seen := %convert_date6%(%int_header%.dt_nonglb_last_seen);

	string1     rec_type := %int_header%.rec_type;
	string18    vendor_id := if(mdr.Source_is_DPPA(%int_header%.src),
							    mdr.get_DPPA_st(%int_header%.src, %int_header%.st) + %int_header%.vendor_id,
							    %int_header%.vendor_id);
	string10    phone := %int_header%.phone;
	string9     ssn := if((integer)%int_header%.ssn<1000000 or %int_header%.pflag3<>'' , '', intformat((integer)%int_header%.ssn,9,1));
//-- This one needs to be converted
	string8     dob := if((%convert_date8%(%int_header%.dob))[1]='*','',%convert_date8%(%int_header%.dob));

	string5     title := %int_header%.title;
	string20    fname := %int_header%.fname;
	string20    mname := %int_header%.mname;
	string20    lname := %int_header%.lname;
	string5     name_suffix := if ( ut.is_unk(%int_header%.name_suffix),'',%int_header%.name_suffix);
	string10    prim_range := %int_header%.prim_range;
	string2     predir := %int_header%.predir;
	string28    prim_name := if(%int_header%.src not in ['DE','DS'], %int_header%.prim_name, '');
	string4     suffix := %int_header%.suffix;
	string2     postdir := %int_header%.postdir;
	string10    unit_desig := %int_header%.unit_desig;
	string8     sec_range := %int_header%.sec_range;
	string25    city_name := %int_header%.city_name;
	string2     st := %int_header%.st;
	string5     zip := if(%int_header%.zip = '', '', intformat((integer)%int_header%.zip,5,1));
	string4     zip4 := if(%int_header%.zip4 = '', '', intformat((integer)%int_header%.zip4,4,1));
	string3     county := %int_header%.county;
	string4     msa := if((integer)%int_header%.cbsa=0,'0000',%int_header%.cbsa[1..4]);
	string1     tnt := if(%int_header%.tnt = 'P' or header.isMonthsFromNew(%int_header%.dt_last_seen, 3), 
						  'Y', 
						  %int_header%.tnt );  
	string1		valid_ssn := if((integer)%int_header%.ssn<1000000 or %int_header%.pflag3<>'','',%int_header%.valid_ssn);
end;
//****** Put header into %string_rec% format
//string_header := table(choosen(%int_header%,2000), %string_rec%);	//just try a few to look at
outfile := table(%int_header%, %string_rec%);


endmacro;