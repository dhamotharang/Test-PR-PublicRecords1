export createXMLStats(pStats, pBuildName, pBuildSubSet, pVersionName, pEmailNotifyList, rOut, pBuildView = '\'\'', pBuildType = '\'\'', pShouldExport = 'false',pShouldSendToStrata = 'true', omit_output_to_screen = 'false') := macro
					  
import _control, ut, lib_fileservices, Orbit3SOA;					  

#uniquename(basepath)
#uniquename(sourcefileName)
#uniquename(destfilename)
#uniquename(combinedEmailList)
#uniquename(buildSubSet)
#uniquename(rout1)
#uniquename(rout2)
#uniquename(rout3)
#uniquename(rout4)
#uniquename(rout5)
#uniquename(rout6)
#uniquename(ds1)
#uniquename(buildType)
#uniquename(buildView)
#uniquename(versionname)
#uniquename(clean)
#uniquename(buildname)
#uniquename(profilename)

string %clean%(string s) := stringlib.stringfindreplace(
                              stringlib.stringfindreplace(
							  stringlib.stringfindreplace(
							    stringlib.stringfilterout(s, ' ')
								,'&','_')
							  ,'-','_')
							, ':','_');


%buildname% 	:= %clean%(pBuildName);
%buildSubSet% := %clean%(if(pBuildSubSet = '', 'data', pBuildSubSet));
%buildType%   := %clean%(if(pBuildType = '', 'type', pBuildType));
%buildView%   := %clean%(if(pBuildView = '', 'view', pBuildView));
%versionname% := %clean%(if(pVersionName = '', 'version', pVersionName));

%combinedEmailList% := if(pEmailNotifyList = '', _control.myinfo.EmailAddressNotify + ',' + strata.settings.emailList, pEmailNotifyList + ',' + strata.settings.emailList);  

%basePath%       := strata.settings.basePath;

%sourcefileName% := %basePath% + %buildname% + '::' + %buildSubSet% + '::' + %versionname% + '::' + %buildType% + '::' + %buildView% + '::' + thorlib.wuid();

%profilename% := %buildname% + '_' + %buildSubSet% + '_' + %buildType% + '_' + %buildView%/* + '_' + %versionname%*/;

%rout1% := output(pStats,, %sourcefileName% + '.xml.pending', xml(heading('<Dataset ' + 'buildname="'   + %clean%(pBuildName) + '" ' + 'buildsubset="' + %buildSubSet% + '" ' + 'versionname="' + %versionname% + '" ' + 'buildtype="'   + %buildType% + '" ' + 'buildview="' + %buildView% + '" ' + '>\n', '</Dataset>\n'),trim));
%rout5% := output(pStats,, %sourcefileName% + '.testingxml',  xml(heading('<Dataset ' + 'buildname="'   + %clean%(pBuildName) + '" ' + 'buildsubset="' + %buildSubSet% + '" ' + 'versionname="' + %versionname% + '" ' + 'buildtype="'   + %buildType% + '" ' + 'buildview="' + %buildView% + '" ' + '>\n', '</Dataset>\n'),trim));
%rout2% := if(~omit_output_to_screen, output(choosen(pStats,all)));
%rout3% := output(pStats,,%sourcefileName% + '.csv.pending',csv(heading(single),separator(','),terminator('\r\n'),quote('"'),maxlength(32768)));
%rout4% := output(pStats,,%sourcefileName% + '.testingcsv' ,csv(heading(single),separator(','),terminator('\r\n'),quote('"'),maxlength(32768)));
%rout6%	:= Orbit3SOA.SubmitStat(pStats, %profilename%, 'Strata', %versionname%, '_' + %profilename%);

#if(pShouldExport = true)
export
#end
rOut := map(
					_control.thisenvironment.name = 'Dataland' and pShouldSendToStrata = true =>	parallel(%rout2%,%rout6%)
					,pShouldSendToStrata 					= true				=> 	parallel(%rout2%,%rout6%)
					,																								parallel(%rout2%/*,%rout6%*/)	//to test stats without sending to strata
			);		

endmacro;