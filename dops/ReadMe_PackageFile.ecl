// l_esp := '10.173.3.10';
// l_roxietarget := 'roxie_devoneway_10_prod';
// l_port := '8010';
// l_sourceesp := '10.173.162.41';
// l_sourcedaliip := '10.173.162.42';
// l_sourceport := '8010';
// l_sourcetarget := 'roxie_162';

// deploying package file to one-way
// 1. publish all needed queries to one-way (operations or query person)
// 2. build package file (update keys if needed)
// 3. add package file (don't make it active)
// 4. validate package file (look for errors)
// 5. list package files (to get what is active)
// 6. deactivate the active package
// 7. activate the new deployed package in 3.
// 8. check for any suspended queries

// get all missing queries/keys used by missing query, if a package file is used
// get the content from package file as well
// ds := dops.fBldPkgWithMissingQueries(l_esp,l_roxietarget);

// Update keys/data
// 1. need to know where to get the data from
// 2. if another roxie then use dops.GetRoxiePackage().Keys
// 3. if from thor use STD.File.SuperFileSubList if all the needed files are super
// 4. or build your own super/logical file dataset
// 5. depending on where the keys are coming from use the respective dali ip

// below example shows the keys are coming from cert fcra dali

// sourceds := dops.GetRoxiePackage(l_sourceesp,l_sourceport,l_sourcetarget).Keys();

// dops.GetRoxiePackage('', '', '').rPackageKeyInfoWithQueries xGetNewKeyVersions(ds l, sourceds r) := transform
	// self.superfile := r.superfile;
	// self.subfile := r.subfile;
	// self.daliip := if (l.superfile <> '',l_sourcedaliip,'');
	// self := l;
// end;

// dUpdateKeys := dedup(join(ds
									// ,sourceds
									// ,left.superfile = right.superfile
									// ,xGetNewKeyVersions(left,right)
									// ,left outer),record);
									
//////////// IF PACKAGE IS DEPLOYED BY OPS USE THE EXAMPLE BELOW /////////////////////
// 1. create the XML file from above dataset
// 2. despray the XML file to a package server that ops can access, by default it desprays to PR DOPS Package server location
// 3. if using default package server then after despray, provide the following url to OPS to use it for deploy
// 4. URL for OPS, if using default package server: http://uspr-dopsroxiepkg.risk.regn.net/~rpt_srv_acct/pkgfiles/<yourpackagename.txt>
// destip := 'databuilddev01.risk.regn.net';
// destlocation := '/home/rpt_srv_acct/public_html/pkgfiles/<yourpackagename.txt>'
// dPackageDatasetasXML := dops.GetRoxiePackage('','','').fDatasetAsXMLPackage(dUpdateKeys);

// sequential
// (
	// output(dPackageDatasetasXML,,'~<yourfilename>',xml('',heading('<RoxiePackages>\n','</RoxiePackages>\n'),OPT),overwrite)
	// ,STD.File.Despray('~<yourfilename>',destip,destlocation,,,,TRUE)
// );

/////////////// END OPS DEPLOYE //////////////////////

//////////// IF PACKAGE IS DEPLOYED FROM ECL USE THE EXAMPLE BELOW ////////////////////
// pkgxmlstring := dops.GetRoxiePackage('','','').fGetXMLPackageAsString(dUpdateKeys);


// dops.PackageFile(l_esp,l_port).AddPackage('test.pkg'
											// ,l_roxietarget
											// ,l_sourcedaliip
											// ,pkgxmlstring
											// ,replacepackagemap := '0'
											// ,activate := '0'
											// ,updatesuperfiles := '0');

// delete package files if needed											
// dops.PackageFile(l_esp,'8010').DeletePackage(l_roxietarget
																						// ,'test.pkg');

// validate package file
// choosen(dops.PackageFile(l_esp,l_port).ValidatePackage('test.pkg'
																									// ,l_roxietarget
																									
																									
																									// ),all);

// list all package files		
// choosen(dops.PackageFile(l_esp,l_port).ListAllPackages(l_roxietarget),all);

// de-activate package file
// choosen(dops.PackageFile(l_esp,l_port).DeActivatePackage(l_roxietarget,'test.pkg'),all);

// activate package file
// choosen(dops.PackageFile(l_esp,l_port).ActivatePackage(l_roxietarget,'addresscleaner.pkg'),all);

// dops.PackageFile has more functionalities related to package file deploy
// dops.GetRoxiePackage has more functionalities related to reading content from a package file on roxie
///////
	
