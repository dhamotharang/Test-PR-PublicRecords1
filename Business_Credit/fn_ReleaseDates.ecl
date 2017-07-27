import dops,ut,STD;
EXPORT fn_ReleaseDates(string pversion = (STRING8)Std.Date.Today()):= function
dops_r := dops.GetReleaseHistory('B', 'N', 'SBFECVKeys');

release_ly := Business_Credit.Layouts.rReleaseDate;

// Remove any invalid versions from DOPS
dops_release := project(dops_r(certversion<>'NA'),transform(release_ly,
														SELF.version			:=	LEFT.certversion;
														fmtsin						:=	'%m/%d/%Y %I:%M:%S %p'; //	Ex.	3/29/2016 12:35:03 AM
														fmtout						:=	'%Y%m%d %H%M%S';				//	Ex. 20160329 003503
														cleanCertDate			:=	ut.ConvertDate(LEFT.certwhenupdated,fmtsin,fmtout);
														cleanProdDate			:=	ut.ConvertDate(LEFT.prodwhenupdated,fmtsin,fmtout);

														SELF.cert_date		:=	Ut.Word(cleanCertDate, 1, ' ');
														SELF.cert_time		:=	Ut.Word(cleanCertDate, 2, ' ');
														SELF.prod_date		:=	Ut.Word(cleanProdDate, 1, ' ');
														SELF.prod_time		:=	Ut.Word(cleanProdDate, 2, ' ');
														SELF.update_type	:=	LEFT.updateflag;
														SELF.first_date		:=	(STRING8)Std.Date.Today();
														SELF.last_date		:=	(STRING8)Std.Date.Today()));


current_table := Business_Credit.Files().releasedate(prod_date <> '');

release_table := dops_release + current_table;

release_ly t_rollup(release_ly le, release_ly ri) := transform
self.first_date :=  (string8)ut.EarliestDate((unsigned)le.first_date, (unsigned)ri.first_date);
self.last_date  :=  (string8)MAX((unsigned)le.last_date, (unsigned)ri.last_date);
self := ri;
end;

						 
release_table_r := rollup(sort(release_table, version, cert_date, prod_date, update_type),
					left.version = right.version and
					ut.NNEQ(left.cert_date , right.cert_date) and
					ut.NNEQ(left.prod_date , right.prod_date) and
					ut.NNEQ(left.update_type , right.update_type),
					t_rollup(left, right));
					
//Propagate prod or cert dates/times when versions are not released to cert or prod

//Versions from Roxie release DOPS are in Cert, but not released to prod
Business_Credit.Layouts.rReleaseDate IterVersions(Business_Credit.Layouts.rReleaseDate le, Business_Credit.Layouts.rReleaseDate ri) := TRANSFORM
propagate := ri.version < le.version and le.prod_date <> '' and ri.prod_date = '';
self.prod_date := IF(propagate, le.prod_date,ri.prod_date);
self.prod_time := IF(propagate, le.prod_time,ri.prod_time);
self := ri;
END;

propagate_no_releases := ITERATE(sort(release_table_r, -version),IterVersions(LEFT,RIGHT));

all_version := table(Business_Credit.Files().Active(active), {process_date, count(group)}, process_date, few);

//Versions in linkid key that were built, but never released to cert.  Assuming this data was released to cert in a subsequent version
no_cert_versions := join(all_version, propagate_no_releases, left.process_date = right.version, left only);

EarliestCertVersion	:=	MIN(dops_r(certversion<>'NA'),certversion);
init:= project(no_cert_versions, transform(Business_Credit.Layouts.rReleaseDate, 
														self.version			:=	left.process_date;
														// Anything before the first Cert version was a 'F'ull Build
														self.update_type	:=	IF((UNSIGNED)self.version<(UNSIGNED)EarliestCertVersion,'F',
																										IF(ut.weekday((unsigned6)self.version[1..8]) IN ['SATURDAY','SUNDAY'],
																												'F','D')
																									);
														self := []));

all_versions := propagate_no_releases + init;

//Propagate cert and prod date/times for versions that were built in thor, but never released to cert
Business_Credit.Layouts.rReleaseDate IterVersions2(Business_Credit.Layouts.rReleaseDate le, Business_Credit.Layouts.rReleaseDate ri) := TRANSFORM
propagate := (ri.version < le.version and ((le.prod_date <> '' and ri.prod_date = '') or (le.cert_date <> '' and ri.cert_date = '')));
self.cert_date := IF(propagate, le.cert_date,ri.cert_date);
self.cert_time:= IF(propagate, le.cert_time,ri.cert_time);
self.prod_date := IF(propagate, le.prod_date,ri.prod_date);
self.prod_time := IF(propagate, le.prod_time,ri.prod_time);
self.first_date := IF(propagate, le.first_date,ri.first_date);
self.last_date := IF(propagate, le.last_date ,ri.last_date );
self := ri;
END;

propagate_no_releases_to_cert := ITERATE(sort(all_versions, -version),IterVersions2(LEFT,RIGHT));	

//Temp change to predict prod date of versions not released to prod at the time this process runs
predict_unknown_prod_date := project(propagate_no_releases_to_cert,
														transform(Business_Credit.Layouts.rReleaseDate,
														self.prod_date := IF(left.cert_date  = '' or left.prod_date = '', (STRING8)Std.Date.Today(), left.prod_date),
														self.prod_time := IF(left.cert_date  = '' or left.prod_date = '', '230000', left.prod_time),
														self.first_date := IF(left.cert_date  = '' or left.prod_date = '', (string) ut.EarliestDate((integer)Std.Date.Today(), (integer)left.first_date), left.first_date),
													  self.last_date := IF(left.cert_date  = '' or left.prod_date = '',(STRING8)Std.Date.Today(), left.last_date),
														self := left));
																		 
buildf := predict_unknown_prod_date;

return buildf;
end;
