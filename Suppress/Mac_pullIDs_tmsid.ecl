export Mac_pullIDs_tmsid(infile, outfile,pull_app_ssn=false, pull_ssn=true, in_appType, product='\'\'') := macro

inf := infile;

Suppress.MAC_Suppress(inf,mid1,in_appType,Suppress.Constants.LinkTypes.DID,did);

#if(pull_ssn)
Suppress.MAC_Suppress(mid1,mid2,in_appType,Suppress.Constants.LinkTypes.SSN,ssn);
outf := mid2;
#else
outf := mid1;
#end

// Suppress by TMSID
#if(ut.fnTrim2Upper(product)	=	'BK')
	Suppress.MAC_Suppress(outf,outf1,in_appType,,,Suppress.Constants.DocTypes.BK_TMSID,tmsid);
#elseif(ut.fnTrim2Upper(product) = 'LIENS')
	Suppress.MAC_Suppress(outf,outf1,in_appType,,,Suppress.Constants.DocTypes.LIENS_TMSID,tmsid);
#elseif(ut.fnTrim2Upper(product) = 'UCC')
	Suppress.MAC_Suppress(outf,outf1,in_appType,,,Suppress.Constants.DocTypes.UCC_TMSID,tmsid);
#else
	outf1	:=	outf;
#end

#if(pull_app_ssn)
Suppress.MAC_Suppress(outf1,outf2,in_appType,Suppress.Constants.LinkTypes.SSN,app_ssn);
outf_final := outf2;
#else
outf_final := outf1;
#end

outfile := outf_final;

endmacro;