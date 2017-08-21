export mac_Sync1PartSF(inSFName, seq_name) := macro
import _control;

#uniquename(SFname)
%SFname% := if(inSFName[1] = '~',inSFName[2..length(inSFName)],inSFName);

#uniquename(devIP)
#uniquename(prodIP)
%devIP% := _control.IPAddress.dataland_dali;
%prodIP% := _control.IPAddress.prod_thor_dali;

#uniquename(IPLength)
%IPLength% := length(%devIP%);

#uniquename(hereIP)
%hereIP% := thorlib.daliServers()[1..%IPLength%];

#uniquename(ImOnDev)
%ImOnDev% := %hereIP% = %devIP%;

#uniquename(foreignIP)
#uniquename(destclustername)
%foreignIP% := if(%ImOnDev%, %prodIP%, %devIP%);
%destclustername% := if(%ImOnDev%,'thor400_92','thor400_92');

#uniquename(forSubName)
%forSubName% := FileServices.GetSuperFileSubName('~foreign::' + %foreignIP% + '::' + %SFname%,1);

//***** Copy *****
#uniquename(namepos)
#uniquename(newsubname)
%namepos% := stringlib.StringFind(%forSubName%, %foreignIP%, 1) + %IPLength% + 2;  //2 for ::
%newsubname% := '~' + %forSubName%[%namepos%..length(%forSubName%)];
//newsubname := fileservices.ForeignLogicalFileName(forSubName, , true);

#uniquename(docopy)
%docopy% := FileServices.Copy(%newsubname%,%destclustername%,%newsubname%,%foreignIP%,,,400,true,true);
//docopy := FileServices.Copy('~' + forSFname, 'thor400_92', newsubname);

seq_name := sequential(
	%docopy%,
	output(fileservices.GetSuperFileSubName('~' + %SFNAME%, 1) + ' was removed from ' + %SFName%),
	fileservices.clearsuperfile('~' + %SFNAME%),
	fileservices.addsuperfile('~' + %SFNAME%, %newsubname%),
	output(%newsubname% + ' was added to ' + %SFName%));
	
endmacro;