export proc_build_key(filedate,fstep) := 
macro

// Add the contents of the base superfile to building superfile

#uniquename(pre)
%pre% := sequential(
		fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount('~thor_Data400::base::bk_search_did_BUILDING') > 0,
			output('Nothing added to BUILDING Superfile'),
			fileservices.addsuperfile('~thor_Data400::base::bk_search_did_BUILDING','~thor_data400::base::bankruptV2_search',0,true)),
		fileservices.finishsuperfiletransaction()
		);

// Build Index

#uniquename(a)
#uniquename(b)
#uniquename(c)
#uniquename(d)
#uniquename(e)
#uniquename(f)
#uniquename(g)
#uniquename(h)
#uniquename(i)
#uniquename(j)
#uniquename(k)
#uniquename(l)
#uniquename(m)
#uniquename(n)
#uniquename(p)


RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.key_bkrupt_did,'~thor_Data400::key::bkrupt_did','~thor_data400::key::bankrupt::'+filedate+'::did',%a%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.key_bkrupt_casenum,'~thor_data400::key::bkrupt_casenum','~thor_data400::key::bankrupt::'+filedate+'::casenum',%b%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.key_bkrupt_didslim,'~thor_Data400::key::bankrupt_didslim','~thor_data400::key::bankrupt::'+filedate+'::didslim',%c%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.key_bkrupt_full,'~thor_data400::key::bkrupt_full','~thor_data400::key::bankrupt::'+filedate+'::full',%d%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(bankrupt.key_bankrupt_bdid,'~thor_data400::key::bankrupt_bdid','~thor_data400::key::bankrupt::'+filedate+'::bdid',%e%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Riskwise.key_bkrupt_ssn,'~thor_data400::key::bkrupt_ssn','~thor_data400::key::bankrupt::'+filedate+'::ssn',%f%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Riskwise.key_bkrupt_address,'~thor_data400::key::bkrupt_address','~thor_data400::key::bankrupt::'+filedate+'::address',%g%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.Key_BocaShell_bkrupt, '~thor_data400::key::bankrupt::bocashell_did', '~thor_data400::key::bankrupt::'+filedate+'::bocashell_did',%l%);

//FCRA
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local (doxie_files.key_bkrupt_didslim_FCRA, '~thor_Data400::key::bankrupt::fcra::didslim', '~thor_data400::key::bankrupt::fcra::'+filedate+'::didslim',%h%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local (doxie_files.key_bkrupt_full_FCRA, '~thor_Data400::key::bankrupt::fcra::full', '~thor_data400::key::bankrupt::fcra::'+filedate+'::full',%i%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local (doxie_files.Key_BocaShell_bkrupt_FCRA,'~thor_data400::key::bankrupt::fcra::bocashell_did', '~thor_data400::key::bankrupt::fcra::'+filedate+'::bocashell_did', %m%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local (doxie_files.key_bkrupt_did_fcra,'~thor_Data400::key::bkrupt_did_fcra','~thor_data400::key::bankrupt::fcra::'+filedate+'::did',%n%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local (doxie_files.key_bkrupt_casenum_fcra,'~thor_data400::key::bankrupt::fcra::' + doxie.Version_SuperKey + '::casenum','~thor_data400::key::bankrupt::fcra::'+filedate+'::casenum',%p%);

// Key Difference

#uniquename(mv1)
#uniquename(mv2)
#uniquename(mv3)
#uniquename(mv4)

RoxieKeyBuild.Mac_SK_Diff(doxie_files.key_bkrupt_did,'~thor_Data400::key::bkrupt_did','~thor_data400::key::bankrupt::'+filedate+'::did',%mv1%,,true);
RoxieKeyBuild.Mac_SK_Diff(doxie_files.key_bkrupt_casenum,'~thor_data400::key::bkrupt_casenum','~thor_data400::key::bankrupt::'+filedate+'::casenum',%mv2%,,true);
RoxieKeyBuild.Mac_SK_Diff(doxie_files.key_bkrupt_didslim,'~thor_Data400::key::bankrupt_didslim','~thor_data400::key::bankrupt::'+filedate+'::didslim',%mv3%,,true);
RoxieKeyBuild.Mac_SK_Diff(doxie_files.key_bkrupt_full,'~thor_data400::key::bkrupt_full','~thor_data400::key::bankrupt::'+filedate+'::full',%mv4%,,true);

// Move new keys to Built superfile

#uniquename(move1)
#uniquename(move2)
#uniquename(move3)
#uniquename(move4)
#uniquename(move5)
#uniquename(move6)
#uniquename(move7)
#uniquename(move8)
#uniquename(move9)
#uniquename(move10)
#uniquename(move11)
#uniquename(move12)
#uniquename(move13)
#uniquename(move14)
#uniquename(move15)

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_Data400::key::bkrupt_did','~thor_data400::key::bankrupt::'+filedate+'::did',%move1%);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bkrupt_casenum','~thor_data400::key::bankrupt::'+filedate+'::casenum',%move2%);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_Data400::key::bankrupt_didslim','~thor_data400::key::bankrupt::'+filedate+'::didslim',%move3%);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bkrupt_full','~thor_data400::key::bankrupt::'+filedate+'::full',%move4%);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankrupt_bdid','~thor_data400::key::bankrupt::'+filedate+'::bdid',%move5%);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bkrupt_ssn','~thor_data400::key::bankrupt::'+filedate+'::ssn',%move6%);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bkrupt_address','~thor_data400::key::bankrupt::'+filedate+'::address',%move7%);
Roxiekeybuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::bankrupt::bocashell_did','~thor_data400::key::bankrupt::'+filedate+'::bocashell_did', %move12%);

//FCRA
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_Data400::key::bankrupt::fcra::didslim', '~thor_data400::key::bankrupt::fcra::'+filedate+'::didslim', %move8%);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_Data400::key::bankrupt::fcra::full', '~thor_data400::key::bankrupt::fcra::'+filedate+'::full', %move9%);
Roxiekeybuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::bankrupt::fcra::bocashell_did','~thor_data400::key::bankrupt::fcra::'+filedate+'::bocashell_did',%move13%);
Roxiekeybuild.Mac_SK_Move_To_Built_v2('~thor_Data400::key::bkrupt_did_fcra','~thor_data400::key::bankrupt::fcra::'+filedate+'::did',%move14%);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankrupt::fcra::@version@::casenum','~thor_data400::key::bankrupt::fcra::'+filedate+'::casenum',%move15%);

// Move the contents of building superfile to Built superfile

#uniquename(h_seq)

%h_seq% := sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.addsuperfile('~thor_data400::base::bk_Search_did_BUILT_Delete','~thor_data400::base::bk_Search_did_BUILT',0,true),
		fileservices.clearsuperfile('~thor_data400::base::bk_Search_did_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::bk_Search_did_BUILT','~thor_data400::base::bk_Search_did_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::bk_Search_did_BUILDING'),
		fileservices.finishsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::base::bk_Search_did_BUILT_Delete',true)
		);

// Move Keys to QA superfile

#uniquename(sktoqa)
//#uniquename(fstep)

%sktoqa% := bankrupt.Proc_Accept_SK_To_QA;

fstep := if (fileservices.getsuperfilesubname('~thor_data400::base::bankruptV2_search',1) = fileservices.getsuperfilesubname('~thor_data400::base::bk_Search_did_BUILT',1),
				output('BASE = BUILT, Nothing done.'),
				sequential(%pre%,
				parallel(/*%a%,%b%,%c%,%d%,%e%,%f%,%g%,%l%,*/%m%,%n%, %h%, %i%,%p%),
				//parallel(%mv1%,%mv2%,%mv3%,%mv4%),
				parallel(/*%move1%,%move2%,%move3%,%move4%,%move5%,%move6%,%move7%,%move12%,*/%move13%,%move8%,%move9%,%move14%,%move15%),
				%h_seq%,%sktoqa%));


endmacro;