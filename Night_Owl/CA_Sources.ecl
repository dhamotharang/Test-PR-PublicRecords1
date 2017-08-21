ApplicableSSNRecords := ['DE','EQ','MW','TU','UT','UW','MU','FV','FD','PD','VD','BA',
					'CC','AL','DC','LI'];

ApplicableDLRecords := ['FV','FD','KD','PD','AD','CD','ND','MD','ED','OD','SD','TD','WD','VD','YD','CC'];

myHeader := dataset(header.Filename_Header,header.Layout_Header,flat);

ds := Night_Owl.File_Group_Two_CA;

ssn_ca := ds;
dl_ca := ds;

// split
ssn_data := DEDUP(SORT(ssn_ca((INTEGER)ssn<>0,deceased='N'), ssn),ssn);
dl_data := DEDUP(SORT(dl_ca(dl_number<>'',deceased='N'), dl_number),dl_number);

OUTPUT(COUNT(ssn_data), NAMED('NumberOfSSNsInCA'));
OUTPUT(COUNT(dl_data), NAMED('NumberOfDLsInCA'));

// get sources for CA
source_layout :=
RECORD
	STRING9 ssn;
	STRING14 dl_number;
	STRING2 src;
	STRING30 src_translate;
END;

source_layout get_sources(myHeader le, ds ri) :=
TRANSFORM
	SELF.src := le.src;
	SELF.src_translate := header.translateSource(le.src);
	SELF := ri;
END;
get_ssn_sources_ := JOIN(myHeader(src IN ApplicableSSNRecords), ssn_data, 
						LEFT.ssn=RIGHT.ssn AND LEFT.lname=RIGHT.lname, get_sources(LEFT,RIGHT), LOOKUP) : persist('persist::badssn');

get_dl_sources_ := JOIN(myHeader(src IN ApplicableDLRecords), dl_data, 
						LEFT.vendor_id=RIGHT.dl_number AND LEFT.lname=RIGHT.lname, get_sources(LEFT,RIGHT), LOOKUP) : persist('persist::baddl');

get_ssn_sources := DEDUP(get_ssn_sources_, ssn, src, ALL);
get_dl_sources := DEDUP(get_dl_sources_, dl_number, src, ALL);


source_ssn_count_layout := 
RECORD
	get_ssn_sources.ssn;
	get_ssn_sources.src;
	get_ssn_sources.src_translate;
	cnt := COUNT(GROUP);
END;
source_ssn_count := TABLE(get_ssn_sources, source_ssn_count_layout, ssn,src,src_translate, few);
output(source_ssn_count,NAMED('SourceCountPerSSN'));

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
