/*

This common function is called by:
Doxie.SexOffender_Enh_Search

*/

import lib_ZipLib, SexOffender, autokey;

export SexOffender_Enh_Common(string5   pZip,
                              unsigned4 pZipRadius,
                              integer1  pGLB) := function
												
//  Use one zip if no radius entered, otherwise calculate zips within radius												
zipsToSearch := if(pZipRadius = 0, 
                   dataset([{pZip}], {integer4 z5int}), 
									 dataset(ZipLib.ZipsWithinRadius(pZip, pZipRadius), {integer4 z5int}));

// Convert zips to a set of strings
{string5 z5} convert({INTEGER4 z5int} l) := TRANSFORM
   self.z5 := intformat(l.z5int,5,1);
END;

ZipConvertZips := project(zipsToSearch, convert(LEFT));
//output(ZipConvertZips);
ZipSet         := set(ZipConvertZips, z5);

								
SO_Raw         := SexOffender.Key_SO_BestRel_glb_zip(alt_zip in ZipSet);

SO_Sorted      := sort(SO_Raw, lname);

return SO_Sorted;

END;  //FUNCTION