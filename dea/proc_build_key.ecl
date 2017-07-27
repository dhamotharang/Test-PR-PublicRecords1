import ut,RoxieKeyBuild;

export proc_build_key(string filedate) :=
function


//Revert to old base file format
//to allow key build 
//-------------------------------------------------

f_dea_old := '~thor_data400::base::dea_old' + thorlib.wuid();
							 
OUTPUT(file_dea,,f_dea_old,__COMPRESSED__,OVERWRITE);

s_dea_old := '~thor_data400::base::dea_old';

fileservices.clearsuperfile(s_dea_old,TRUE);
fileservices.addsuperfile(s_dea_old,f_dea_old);
//--------------------------------------------------


a := sequential(
   	              fileservices.startsuperfiletransaction(),
		          if (fileservices.getsuperfilesubcount('~thor_Data400::base::dea_BUILDING') > 0,
			          output('Nothing added to BUILDING Superfile'),
			          fileservices.addsuperfile('~thor_Data400::base::dea_BUILDING','~thor_data400::base::dea_old',0,true)),
				  fileservices.finishsuperfiletransaction()
		         );

//---- Start of New code for standardizing the key names
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(dea.Key_dea_did,'~thor_data400::key::dea::@version@::did','~thor_data400::key::dea::' + filedate + '::did',b);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(dea.Key_dea_bdid,'~thor_data400::key::dea::@version@::bdid','~thor_data400::key::dea::' + filedate + '::bdid',c);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(dea.Key_dea_linkids.Key,'~thor_data400::key::dea::@version@::linkids','~thor_data400::key::dea::' + filedate + '::linkids',d);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(dea.Key_dea_reg_num,'~thor_data400::key::dea::@version@::reg_num','~thor_data400::key::dea::' + filedate + '::reg_num',e);


RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~thor_data400::key::dea::@version@::did','~thor_data400::key::dea::' + filedate + '::did', b1);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~thor_data400::key::dea::@version@::bdid','~thor_data400::key::dea::' + filedate + '::bdid', c1);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~thor_data400::key::dea::@version@::linkids','~thor_data400::key::dea::' + filedate + '::linkids', d1);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~thor_data400::key::dea::@version@::reg_num','~thor_data400::key::dea::' + filedate + '::reg_num', e1);

RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dea::@version@::did', 'Q', b2);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dea::@version@::bdid', 'Q', c2);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dea::@version@::linkids', 'Q', d2);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dea::@version@::reg_num', 'Q', e2);
// --- end of new code

f := sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::base::dea_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::dea_BUILT','~thor_data400::base::dea_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::dea_BUILDING'),
		fileservices.finishsuperfiletransaction()
		);

ak := dea.proc_build_autokeys(filedate);
	
return if (fileservices.getsuperfilesubname('~thor_data400::base::dea',1) = fileservices.getsuperfilesubname('~thor_data400::base::dea_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(a,b,c,d,e,b1,c1,d1,e1,b2,c2,d2,e2,ak,f));

end;