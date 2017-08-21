
ApplicableSSNRecords := ['FV','FD','MA'];
ApplicableDLRecords  := ['FV','FD','MA'];

myHeader_ := dataset(header.Filename_Header,header.Layout_Header,flat);

headerslim := record
 string2  src;
 string9  ssn;
 string20 lname;
 string18 vendor_id;
end;

headerslim tslimheader(myHeader_ l) := transform
 self := l;
end;

myHeader := project(myHeader_,tslimheader(left));

layout :=
RECORD
	STRING   userid;
	STRING   uniqueid;
	STRING   date_run;
	STRING14 dl_number;
	STRING9  ssn;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5  name_suffix;
	STRING8  deceased;
	STRING20 best_fname;
	STRING20 best_mname;
	STRING20 best_lname;
	STRING5  best_name_suffix;
	STRING   address;
	STRING   city;
	STRING2  state;
	STRING5  zip;
	STRING10 phone;
	STRING   name_dual;
	STRING8  date_first;
	STRING8  date_last;
	STRING9  best_ssn;
END;

ds := dataset('~thor_data200::in::nowl_new_200607',layout,csv(QUOTE('"')));;

common := record
 string20 lname;
 string2  src;
 string30 src_translate;
end;

ssn_layout := record
 string9  ssn;
 common;
end;

dl_layout := record
 string14 dl_number;
 common;
end;

ssn_fl := ds;
dl_fl  := ds;

ssn_layout tslimssn(ssn_fl l) := transform
 self := l;
 self := [];
end;

dl_layout tslimdl(dl_fl l) := transform
 self := l;
 self := [];
end;
 
ssn_data_ := project(ssn_fl((integer)ssn<>0,deceased='N'),tslimssn(left));
dl_data_  := project(dl_fl(dl_number<>'',deceased='N'),tslimdl(left));
// split
ssn_data := DEDUP(SORT(ssn_data_,ssn),ssn);
dl_data  := DEDUP(SORT(dl_data_, dl_number),dl_number);

OUTPUT(COUNT(ssn_data), NAMED('NumberOfSSNsInFL'));
OUTPUT(COUNT(dl_data), NAMED('NumberOfDLsInFL'));

// get sources for FL
ssn_layout ssn_match(headerslim l, ssn_layout r) := transform
 self.src := l.src;
 self.src_translate := header.translateSource(l.src);
 self := r;
end;

ssn_layout ssn_match2(headerslim l, ssn_layout r) := transform
 //self.src := l.src;
 //self.src_translate := header.translateSource(l.src);
 self := r;
end;

get_ssn_ := JOIN(myHeader(src IN ApplicableSSNRecords), ssn_data
                ,LEFT.ssn=RIGHT.ssn AND LEFT.lname=RIGHT.lname
				,ssn_match(LEFT,RIGHT), LOOKUP) : persist('~thor_dell400::persist::badssn_fl');

get_ssn := dedup(get_ssn_,ssn,lname,src,all);

get_ssn_dist  := sort(distribute(get_ssn,hash(ssn,lname)),ssn,lname,local);

header_other_ := myHeader(src NOT IN ApplicableSSNRecords,ssn<>'',lname<>'') : persist('~thor_dell400::persist::header_src_not_fd_fv_ma');
header_other  := sort(distribute(header_other_,hash(ssn,lname)),ssn,lname,local);

ssn_not_in_other_sources_ := join(header_other, get_ssn_dist
                                 ,left.ssn=right.ssn and left.lname=right.lname
							     ,ssn_match2(left,right), right only,local);
								
ssn_not_in_other_sources  := dedup(ssn_not_in_other_sources_,ssn,src,all);

output(ssn_not_in_other_sources,NAMED('SSNsOnlyInFDFVMA'));
							
source_ssn_count_layout := 
RECORD
	ssn_not_in_other_sources.ssn;
	ssn_not_in_other_sources.src;
	ssn_not_in_other_sources.src_translate;
	cnt := COUNT(GROUP);
END;
source_ssn_count := TABLE(ssn_not_in_other_sources, source_ssn_count_layout, ssn,src,src_translate, few);
output(source_ssn_count,NAMED('SourceCountPerSSN'));

dl_layout dl_match(headerslim l, dl_layout r) := transform
 self.src := l.src;
 self.src_translate := header.translateSource(l.src);
 self := r;
end;

get_dl_sources_ := JOIN(myHeader(src IN ApplicableDLRecords), dl_data
                       ,LEFT.vendor_id=RIGHT.dl_number AND LEFT.lname=RIGHT.lname
					   ,dl_match(LEFT,RIGHT), LOOKUP) : persist('persist::baddl_fl');

get_dl_sources  := DEDUP(get_dl_sources_, dl_number, src, ALL);

source_dl_count_layout := 
RECORD
	get_dl_sources.dl_number;
	get_dl_sources.src;
	get_dl_sources.src_translate;
	cnt := COUNT(GROUP);
END;
source_dl_count := TABLE(get_dl_sources, source_dl_count_layout, dl_number,src,src_translate, few);
output(source_dl_count,NAMED('SourceCountPerDL'));

ssn_count_layout :=
RECORD
	source_ssn_count.src;
	source_ssn_count.src_translate;
	cnt := SUM(GROUP,source_ssn_count.cnt);
END;
ssn_count := TABLE(source_ssn_count,ssn_count_layout,src,src_translate,few);
output(ssn_count,NAMED('SourceCountForSSN'),all);

dl_count_layout :=
RECORD
	source_dl_count.src;
	source_dl_count.src_translate;
	cnt := SUM(GROUP,source_dl_count.cnt);
END;
dl_count := TABLE(source_dl_count,dl_count_layout,src,src_translate,few);
output(dl_count,NAMED('SourceCountForDL'),all);

output(source_ssn_count(src='DE'),NAMED('SupposedlyDead'),all);