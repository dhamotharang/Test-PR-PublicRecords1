import infutor, watchdog, std, seo;

EXPORT actionBuildSEO(unsigned1 mode, STRING sVersion) := MODULE

// Find CORE LexIds from consumers

knowx := DISTRIBUTE(Pull(infutor.Key_Header_Infutor_Knowx)(Length(TRIM(fname))>1,Length(TRIM(lname))>1), did);
segs := DISTRIBUTE(watchdog.file_best(adl_ind='CORE'),did);

core := join(knowx, segs, left.did=right.did,
						TRANSFORM(RECORDOF(knowx), self := LEFT;), INNER, LOCAL) :
						persist('~thor::persist::seo_core');

j := project(core,
						TRANSFORM(Seo.Layout_Seo,
								self.LexId := left.did;
								self := left;));
								
d := DEDUP(SORT(DISTRIBUTE(j, LexId), LexId, fname, lname, LOCAL), LexId, fname, lname, LOCAL);

Layout_SEO_Address_Temp := RECORD
	unsigned6	LexId;
	integer     last_seen;
	string50	street1;
	string28	city1;
	string2		state1;
	string5		zip1;
	string50	street2;
	string28	city2;
	string2		state2;
	string5		zip2;
END;

addresses1 := PROJECT(core, 
						TRANSFORM(Layout_SEO_Address_Temp,
								self.LexId := left.did;
								self.last_seen := left.dt_last_seen;
								self.Street1 := Std.Str.CleanSpaces(left.prim_range+' '+left.predir+' '+
															left.prim_name+' '+left.suffix+' '+left.postdir+' '+
															left.unit_desig+' '+left.sec_range);
								self.city1 := left.city_name;
								self.state1 := left.st;
								self.zip1 := left.zip;
                self:=[]
               ));
							 
// sort reverse last seen. Also choose the longer street (which may have a secondary unit)						
addresses := DEDUP(SORT(DISTRIBUTE(addresses1(street1<>''), LexId), 
										LexId, -last_seen, -street1, city1, state1, zip1, LOCAL),
										LexId,              street1, city1, state1, zip1, LOCAL);


g := GROUP(addresses, LexId);
g1 := TOPN(g, 2, -last_seen, -street1, city1, state1, zip1);	// get the top 2 addresses

temp := ROLLUP(g1, TRANSFORM(Layout_SEO_Address_Temp,
									self.street2 := right.street1;
									self.city2 := right.city1;
									self.state2 := right.state1;
									self.zip2 := right.zip1;
									self := left;
                                             ),true);
addr := PROJECT(temp, Seo.Layout_SEO_Address); 

lfn := '~thor::seo::' + sVersion;
lfn2 := '~thor::seo_addr::' + sVersion;

writeit := OUTPUT(d,,lfn,COMPRESSED, CSV(
										SEPARATOR(',')
										, TERMINATOR('\r\n')
										, HEADING(1,SINGLE)
										,QUOTE('"')
										),
				OVERWRITE);
writeaddr := OUTPUT(addr,,lfn2,COMPRESSED, CSV(
											SEPARATOR(',')
											, TERMINATOR('\r\n')
											, HEADING(1,SINGLE)
											,QUOTE('"')
											),
				OVERWRITE);													
sfBase := '~thor::seo';
sfBaseAddr := '~thor::seo_addr';
												
set of string	SFList := [
						sfBase,
						sfBase+'::father',
						sfBase+'::delete'];
set of string	SFListAddr := [
						sfBaseAddr,
						sfBaseAddr+'::father',
						sfBaseAddr+'::delete'];
PromoteFiles(string lfn) := NOTHOR(Std.File.PromoteSuperFileList(SFList, lfn, true));
PromoteAddrFiles(string lfn) := NOTHOR(Std.File.PromoteSuperFileList(SFListAddr, lfn, true));

EXPORT all := if(mode = 1
				,SEQUENTIAL(
					writeit,
					writeaddr,
					SEO.DesprayFile(lfn, 'seo', sVersion),
					SEO.DesprayFile(lfn2, 'seoaddr', sVersion),
					PromoteFiles(lfn),
					PromoteAddrFiles(lfn2)
					)
				,output('SEO FILE IS ONLY CREATED DURING FULL/QUARTERLY RUN!!')
				);

END;