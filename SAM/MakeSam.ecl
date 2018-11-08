import _Control;

vxml := PROJECT(File_Sam, sam.XForm(LEFT, COUNTER));

/*vxml1 := ITERATE(vxml, TRANSFORM(sam.Layout_BridgerEx,
						self.type := IF(Right.type='',Left.type,Right.type);
						self.SAMNumber := IF(RIGHT.SAMNumber='', LEFT.SAMNumber,RIGHT.SAMNumber);
						self.seqnum := right.seqnum;
						self := RIGHT;		//IF(RIGHT.type='' AND LEFT.type<>'',LEFT,RIGHT);
						));
*/						
vxml1a := SORT(DISTRIBUTE(vxml, HASH(SAMNumber)), SAMNumber, -type, LOCAL);
vxml2 := ROLLUP(vxml1a, TRANSFORM(sam.Layout_BridgerEx,
						//self.Actions := IF(RIGHT.classification='' AND LEFT.classification<>'',
						//									LEFT.Actions + Right.Actions,
						//									RIGHT.Actions);
						self.type := IF(Right.type='',Left.type,Right.type);
						self.SAMNumber := IF(RIGHT.SAMNumber='', LEFT.SAMNumber,RIGHT.SAMNumber);
						self.seqnum := left.seqnum;
						self.comments := left.comments + IF(right.comments='','',',' + right.comments);
						self.additional_info_list.additionalinfo := LEFT.additional_info_list.additionalinfo
																				+ RIGHT.additional_info_list.additionalinfo;
						self := LEFT;
						), SAMNumber);

oxml := sam.XMLHeader(PROJECT(vxml2,TRANSFORM(sam.Layout_Bridger,
								references := Sam.TrimReferences(LEFT.comments);
								SELF.comments := IF(references='','','Cross-Reference: ' + references);
								self.additional_info_list.additionalinfo := SAM.CombineInfo(
											left.additional_info_list.additionalinfo);
								self := LEFT;
						)));

Despray(string logicalname, string destinationIP , string destinationpath) :=

fileservices.Despray(logicalname,
	destinationIP,
	destinationpath,
	allowoverwrite := true);
	
EXPORT MakeSam(string version) := SEQUENTIAL(
SpraySam(version),
//OUTPUT(File_Sam,named('sam')),																// sample records						
//OUTPUT(COUNT(File_Sam),named('n_sam')),												// total records
//OUTPUT(COUNT(File_Sam(SAMNumber<>'')),named('n_parent')),			// parent records
//OUTPUT(COUNT(File_Sam(SAMNumber='')),named('n_child')),				// child records
oxml,
//OUTPUT(COUNT(File_Converted),named('n_result')),							// should equl n_parent
//OUTPUT(TABLE(Sam.File_Converted, {Sam.File_Converted.type, n := COUNT(GROUP)}, type)),	// sanity check
Despray('~thor::out::sam::results', _Control.IPAddress.bctlpedata10,'/data/hds_3/sam/output/sam.xml')
);
