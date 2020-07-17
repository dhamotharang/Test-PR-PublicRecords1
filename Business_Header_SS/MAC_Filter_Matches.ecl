EXPORT MAC_Filter_Matches
(
	infile,			 // in Layout_BDID_Mid_Batch
	outfile,		 // in Layout_BDID_Mid_Batch
	returnpayload = false
) := MACRO
import doxie, ut, AutoStandardI;
#uniquename(bh_key)
%bh_key% := business_header_ss.Key_BH_BDID_pl;
#UNIQUENAME(mod_access)			
%mod_access% :=doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
#uniquename(min2)
INTEGER %min2%(INTEGER l, INTEGER r) := IF(l < r, l, r);

#uniquename(AddPenalty)
#if(returnpayload)
{RECORDOF(infile);RECORDOF(%bh_key%) pl;} %AddPenalty%(infile l, %bh_key% r) := TRANSFORM
	SELF.pl := r;
#else
TYPEOF(infile) %AddPenalty%(infile l, %bh_key% r) := TRANSFORM
#end
	SELF.score := 100 -  
		%min2%(10,IF(l.company_name = '', 0, ut.CompanySimilar(l.company_name, r.company_name)*2 + ut.StringSimilar(l.company_name, r.company_name))) -
		(9 * %min2%(10,
		IF(l.predir = '' OR r.predir = l.predir, 0, 1) +
		IF(l.postdir = '' OR r.postdir = l.postdir, 0, 1) +
		IF(l.addr_suffix = '' OR r.addr_suffix = l.addr_suffix, 0, 1) +
		MAP(l.prim_name = '' OR r.prim_name = l.prim_name => 0,
							 r.prim_name = '' => 8,
							 ut.stringsimilar(l.prim_name, r.prim_name)) +
		MAP((UNSIGNED8) l.prim_range = 0 OR (UNSIGNED8) r.prim_range = (UNSIGNED8) l.prim_range => 0,
							 (UNSIGNED8) r.prim_range = 0 => 2,
							 ut.stringsimilar(l.prim_range, r.prim_range)) +
		MAP(l.sec_range = '' OR r.sec_range = l.sec_range => 0,
							 r.sec_range = '' => 2,
							 ut.stringsimilar(l.sec_range, r.sec_range)) +
		MAP(l.p_city_name = '' OR mile_radius_value > 0 OR r.city = l.p_city_name => 0,
							 r.city = '' AND l.z5 != '' => 1,
							 r.city = '' => 10,
							 ut.stringsimilar(l.p_city_name, r.city) < 3 => 1,
							 l.z5 != '' => 5,
							 10) +
		IF(l.st = '' OR r.state = l.st, 0, 10) +
		MAP(l.z5 = '' OR r.zip = (UNSIGNED3) l.z5 => 0,
				bh_zip_value != [] and r.zip in bh_zip_value => 1,
							 r.zip = 0 AND l.p_city_name != '' AND l.st != '' => 5,
							 r.zip = 0 => 10,
							 10) +
			//but if the zip is blank bc a radius is being used, then make sure our company is in range
		// IF(mile_radius_value = 0 or bh_zip_value = [] or r.zip in bh_zip_value, 0, 10) +
		MAP(l.phone10 = '' OR r.phone = (UNSIGNED6) l.phone10 => 0, 
			r.phone = 0 => 3,
			ut.stringsimilar(INTFORMAT(r.phone, 10, 1), l.phone10)) +
		MAP(l.fein = '' OR r.fein = (UNSIGNED4) l.fein => 0,
			r.fein = 0 => 3,
			ut.stringsimilar(INTFORMAT(r.fein, 9, 1), l.fein))));

	SELF.bdid := IF(r.bdid = 0, 0, IF(SELF.score > 0, r.bdid, 0));
	SELF := l;
END;	

#if(returnpayload)
outfile := JOIN(
	infile,
	%bh_key%,
	LEFT.bdid != 0 AND
	LEFT.bdid = RIGHT.bdid AND
	doxie.compliance.source_ok(%mod_access%.glb, %mod_access%.DataRestrictionMask, right.source) AND
  doxie.compliance.isBusHeaderSourceAllowed(right.source, %mod_access%.DataPermissionMask, %mod_access%.DataRestrictionMask),
	%AddPenalty%(LEFT, RIGHT),
	LEFT OUTER, LIMIT(0),KEEP(5000));
#else
#uniquename(filtered_bdids)
%filtered_bdids% := JOIN(
			infile, 
			%bh_key%,
		LEFT.bdid != 0 AND
		LEFT.bdid = RIGHT.bdid AND
		doxie.compliance.source_ok(%mod_access%.glb, %mod_access%.DataRestrictionMask, right.source) AND 
    doxie.compliance.isBusHeaderSourceAllowed(right.source, %mod_access%.DataPermissionMask, %mod_access%.DataRestrictionMask),
		%AddPenalty%(LEFT, RIGHT),
		LEFT OUTER, LIMIT(0),KEEP(5000));		
		// LEFT OUTER, ATMOST(5000));
		
#uniquename(bdids_sort)
%bdids_sort% := SORT(%filtered_bdids%, temp_id, bdid);

// Rollup the results to get rid of the filtered records.
// Multiple 0 bdids roll into one, nonzero replaces 0.
#uniquename(take_right)
TYPEOF(infile) %take_right%(%bdids_sort% r) := TRANSFORM
	SELF := r;
END;

outfile := ROLLUP(
	%bdids_sort%,
	LEFT.temp_id = RIGHT.temp_id AND LEFT.bdid = 0,
	%take_right%(RIGHT));
#end
ENDMACRO;
