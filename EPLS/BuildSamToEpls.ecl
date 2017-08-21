vxml := PROJECT(epls.File_Sam, epls.XForm(LEFT, COUNTER));

vxml1 := ITERATE(vxml, TRANSFORM(epls.Layout_EPLS_Ex,
						self.Actions := IF(RIGHT.classification='' AND LEFT.classification<>'',
															LEFT.Actions + Right.Actions,
															RIGHT.Actions);
						self.SAMNumber := IF(RIGHT.SAMNumber='', LEFT.SAMNumber,RIGHT.SAMNumber);
						self.seqnum := right.seqnum;
						self := IF(RIGHT.classification='' AND LEFT.classification<>'',LEFT,RIGHT);
						));
						
vxml2 := DEDUP(vxml1, SAMNumber, RIGHT);
vxml3 := PROJECT(vxml2,epls.Layout_EPLS);

oxml := epls.XMLHeader(PROJECT(vxml2,epls.Layout_EPLS));

Despray(string logicalname, string destinationIP , string destinationpath) :=

fileservices.Despray(logicalname,
	destinationIP,
	destinationpath,
	allowoverwrite := true);

EXPORT BuildSamToEpls(string version) := SEQUENTIAL(
	SpraySam(version);
	OUTPUT(epls.File_Sam,named('sam'));
	OUTPUT(COUNT(epls.File_Sam),named('n_sam'));		// number of input records
	epls.XMLHeader(vxml3);
	Despray('~thor::out::epls::results', 'edata12-bld.br.seisint.com','/hds_3/epls/epls.xml');
);
