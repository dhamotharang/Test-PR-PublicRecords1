import _control;

version := '12299';		// UPDATE EACH TIME
basename := 'SAM_Exclusions_Public_Extract_12286.CSV';
srcdir := '/data/hds_3/sam/';

dest := '~thor::in::epls::sam::';

						
sprayfileTxt(string filename) := 

		FileServices.SprayVariable(_control.IPAddress.bctlpedata10,
							srcdir + filename,
							8192,',',,'"',
							'thor40_241',
							dest + version,
							,,,true,true,false
						);

					
 //sprayfileTxt(basename);
//vxml := DISTRIBUTE(PROJECT(epls.File_Sam, epls.XForm(LEFT)),SKEW(0.1));
vxml := PROJECT(epls.File_Sam, epls.XForm(LEFT, COUNTER));

vxml1 := ITERATE(vxml, TRANSFORM(epls.Layout_EPLS_Ex,
						self.Actions := IF(RIGHT.classification='' AND LEFT.classification<>'',
															LEFT.Actions + Right.Actions,
															RIGHT.Actions);
						//self.classification := Right.classification;
						self.SAMNumber := IF(RIGHT.SAMNumber='', LEFT.SAMNumber,RIGHT.SAMNumber);
						self.seqnum := right.seqnum;
						self := IF(RIGHT.classification='' AND LEFT.classification<>'',LEFT,RIGHT);
						));
						
//vxml2 := vxml1a(classification <> '');
vxml2 := DEDUP(vxml1, SAMNumber, RIGHT);
vxml3 := PROJECT(vxml2,epls.Layout_EPLS);

oxml := epls.XMLHeader(PROJECT(vxml2,epls.Layout_EPLS));

Despray(string logicalname, string destinationIP , string destinationpath) :=

fileservices.Despray(logicalname,
	destinationIP,
	destinationpath,
	allowoverwrite := true);

SEQUENTIAL(
OUTPUT(epls.File_Sam,named('sam')),
OUTPUT(COUNT(epls.File_Sam),named('n_sam')),
OUTPUT(epls.File_Sam(classification=''),named('blanksam')),
OUTPUT(COUNT(epls.File_Sam(classification='')),named('n_blank')),
OUTPUT(vxml,named('vxml')),
OUTPUT(COUNT(vxml),named('n_vxml')),
OUTPUT(vxml1,named('vxml1')),
OUTPUT(COUNT(vxml1),named('n_vxml1')),
OUTPUT(vxml2,named('vxml2')),
OUTPUT(COUNT(vxml2),named('n_vxml2')),
OUTPUT(vxml3,named('vxml3')),
OUTPUT(vxml1(COUNT(actions)>1)),
OUTPUT(vxml1(COUNT(actions)>2)),
OUTPUT(vxml2(COUNT(actions)>1)),
OUTPUT(vxml2(COUNT(actions)>2)),
oxml,
Despray('~thor::out::epls::results', _Control.IPAddress.bctlpedata10,'/data/hds_3/sam/output/epls.xml')
);

