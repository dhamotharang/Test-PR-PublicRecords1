import ut,mdr;

dob_score(integer d) := 
	MAP( d = 0 => 0,
         d < 10000 or d % 10000 = 0 or (d < 1000000 and d % 100 = 0)=> 1,
         d < 1000000 or d % 100 = 0 => 2,
         3 );

export 
Layout_header TRA_Merge_Headers(Layout_header l, Layout_header r) := transform
  self.src := MAP(l.src=r.src => l.src,
                  mdr.Source_Group(l.src)=' ' => 'MI',
                  'M'+mdr.Source_Group(l.src));
  self.dt_first_seen := 
	ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
				    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
  self.dt_last_seen := 
	ut.LatestDate(ut.LatestDate(if(l.rec_type = '1', l.dt_first_seen, 0),
								if(r.rec_type = '1', r.dt_first_seen, 0)),
				  ut.LatestDate(l.dt_last_seen,r.dt_last_seen));
  self.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported,r.dt_vendor_last_reported);
  self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported,r.dt_vendor_first_reported);
  self.dt_nonglb_last_seen := ut.LatestDate(l.dt_nonglb_last_seen,r.dt_nonglb_last_seen);
  self.rec_type := if ( l.rec_type='' or l.dt_last_seen<r.dt_last_seen, r.rec_type, l.rec_type );
  self.vendor_id := if (l.vendor_id='',r.vendor_id,l.vendor_id);
  self.phone := if ( length(trim(l.phone,all))<length(trim(r.phone,all)),r.phone,l.phone );
  self.ssn := if ( l.ssn = '', r.ssn, l.ssn );
  self.dob := if ( dob_score(l.dob) < dob_score(r.dob), r.dob, l.dob );
  self.title := if (l.title = '', r.title, l.title );
  self.fname := if (l.fname = '', r.fname, l.fname );
  self.mname := if (l.mname = '' or l.mname=r.mname[1], r.mname, l.mname );
  self.lname := if (l.lname = '', r.lname, l.lname );
  self.name_suffix := if (l.name_suffix = '' or ut.Translate_Suffix(l.name_suffix)=r.name_suffix, r.name_suffix, l.name_suffix );
  self.prim_range := if (l.prim_range = ''and l.zip4='', r.prim_range, l.prim_range );
  self.predir := if (l.predir = ''and l.zip4='', r.predir, l.predir );
  self.prim_name := if (l.prim_name = ''and l.zip4='', r.prim_name, l.prim_name );
  self.suffix := if (l.suffix = ''and l.zip4='', r.suffix, l.suffix );
  self.postdir := if (l.postdir = ''and l.zip4='', r.postdir, l.postdir );
  self.unit_desig := if (l.unit_desig = ''and l.zip4='', r.unit_desig, l.unit_desig );
  self.sec_range := if (l.zip4='' and r.dt_last_seen>l.dt_last_seen, r.sec_range, l.sec_range );
  self.city_name := if (l.city_name = ''and l.zip4='', r.city_name, l.city_name );
  self.st := if (l.st = ''and l.zip4='', r.st, l.st );
  self.zip := if (l.zip = ''and l.zip4='', r.zip, l.zip );
  self.zip4 := if (l.zip4 = '', r.zip4, l.zip4 );
  self.county := if (l.county = ''and (l.zip4='' or (r.county <> '' and r.zip4 <> '')), r.county, l.county );
  self.cbsa := if ((integer)l.cbsa = 0 and (l.zip4='' or ((integer)r.cbsa <> 0 and r.zip4 <> '')), r.cbsa, l.cbsa );
  self.geo_blk := if((integer)l.geo_blk = 0,r.geo_blk,l.geo_blk);
  self.pflag1 := if ( l.pflag1 = '', r.pflag1, l.pflag1 );
  self.pflag2 := map(l.pflag2 != 'A' and r.pflag2 = 'A' => l.pflag2,
					 l.pflag2 = 'A' and r.pflag2 != 'A' => r.pflag2,
					 l.pflag2 = 'A' and r.pflag2 = 'A' => 'A',
					 l.pflag2 = '' => r.pflag2,
					 l.pflag2);
  self.pflag3 := if((header.isPreGLB(l) and l.ssn = '' and //if adding GLB SSN to preGLB rec, then 'G'
					 ~header.isPreGLB(r) and r.ssn <> '') or
					(header.isPreGLB(r) and r.ssn = '' and 
					 ~header.isPreGLB(l) and l.ssn <> ''),
					'G', if((header.isPreGLB(l) and l.ssn <> '' and l.pflag3 = '') or 	//if adding preGLB SSN to 'G' rec, blank it out
							(header.isPreGLB(r) and r.ssn <> '' and r.pflag3 = ''), 
					'', if ( l.pflag3 = '', r.pflag3, l.pflag3 ))); //else, just bring a non-blank flag accross
  self.valid_ssn := if(l.ssn='',r.valid_ssn,l.valid_ssn);
  self := l;
  end;