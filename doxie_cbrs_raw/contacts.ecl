import AutoStandardI, business_header, doxie_cbrs, doxie, MDR, suppress;

export contacts(
	dataset(doxie_cbrs.layout_references) bdids,
	boolean Include_val = false,
	unsigned3 Max_val = 0,
	string32 appType
) := MODULE

shared k := Business_Header.Key_Business_Contacts_BDID;
nn := Max_val * 4;

doxie_cbrs.mac_RollStart
	(bdids, outfile, k,
	 nn,Include_val,bdid,right.from_hdr = 'N',bdid,did,lname+fname)

mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

outf0 := Suppress.MAC_SuppressSource(outfile, mod_access);

out_f0a0 := outf0(NOT MDR.sourceTools.SourceIsEBR(source) OR NOT doxie.DataRestriction.EBR);
out_f0a := out_f0a0(business_header.is_ContactName(fname, lname));
Suppress.MAC_Suppress(out_f0a,out_f0b,appType,Suppress.Constants.LinkTypes.SSN,ssn);
Suppress.MAC_Suppress(out_f0b,outf1,appType,Suppress.Constants.LinkTypes.DID,did);
shared out_f := outf1;
shared simple_count :=
	count(project(k(keyed(bdid in SET(doxie_cbrs.ds_SupergroupLevels(bdids), bdid)) and from_hdr = 'N'), transform({k.bdid,k.from_hdr}, self := left)));

	export records := out_f;
	export record_count(boolean count_only = false) :=
													IF(count_only,simple_count,count(out_f));

END;
