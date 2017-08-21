flc0_v3_in:= dataset('~thor_data400::sprayed::flcrash0'
									,FLAccidents.Layout_FLCrash0_v3, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));

/////////////////////////////////////////////////////////////////////////
//Get Accident Date
/////////////////////////////////////////////////////////////////////////								
d := dataset('~thor_data400::sprayed::flcrash1'
									,FLAccidents.Layout_FLCrash1_v3, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));
									
layout := record
d.accident_nbr;
d.report_date;
total:= count(group);
end;

tbl_accDate := sort(table(d,layout,accident_nbr,report_date,few),accident_nbr,report_date):persist('~thor_data400::persist::tbl_accDate');			
/////////////////////////////////////////////////////////////////////////
FLAccidents.Layout_FLCrash0_v2 flc0_convert_to_old(flc0_v3_in l, tbl_accDate r) := transform
string8     fSlashedMDYtoCYMD(string pDateIn) :=
intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);


self.accident_date			:= if(L.accident_nbr=R.accident_nbr,fSlashedMDYtoCYMD(R.report_date),'');

	self.rec_type_o            := '0';
   self.ft_miles_from_intersect := map(l.ft_from_intersect <> '0000' => l.ft_from_intersect,
                                        l.miles_from_intersect <> '0000' => l.miles_from_intersect,'');
   self.ft_miles_code2       := map(	l.ft_from_intersect <> '0000' => 'F',
                                         l.miles_from_intersect <> '0000' => 'M','');
	self.ft_miles_code1        := map( l.ft_from_node <> '0000' => 'F',
	                                   l.miles_from_node <> '0000' => 'M' , '');
	self.ft_miles_node         := map(l.ft_from_node <> '0000' => l.ft_from_node, 
	                                  l.miles_from_node <> '0000' => l.miles_from_node , '');

	
	self                := l;
	self                := [];
end;

jrecs:= join(flc0_v3_in,tbl_accDate,
					left.accident_nbr = right.accident_nbr,
					flc0_convert_to_old(left,right),left outer);


export InFile_FLCrash0_v3 := jrecs;
