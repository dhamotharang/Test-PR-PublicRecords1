/*--SOAP--
<message loadXml="true" name="Riskwise Seed data build" wuTimeout="-1" cluster="thor_200" async="1">
	<part name="Action" type="xsd:string">
        <html>
          <td width="25%"><font face="Verdana" size="2">Action:</font></td>
          <td><font face="Verdana" size="2">
            <select name="Action">
				<Option value=""></Option>
				<Option value="CopyFiles">CopyFiles</Option>
				<Option value="BuildKeys">BuildKeys</Option>
				</select>                              
           </font></td>
        </html>
	</part>
	<part name="Seed Data Type" type="xsd:string">
        <html>
          <td width="25%"><font face="Verdana" size="2">Seed Data Type:</font></td>
          <td><font face="Verdana" size="2">
            <select name="SeedDataType">
				<Option value=""></Option>
				<Option value="Attribute">Attribute</Option>
				<Option value="CustomerInstantID">CustomerInstantID</Option>
				<Option value="BusinessInstantID">BusinessInstantID</Option>
				<Option value="LegacySeed">LegacySeed</Option>
				</select>                              
           </font></td>
        </html>
	</part>
	<part name="DatalandFilename" type="xsd:string"/>
	<part name="BuildVersion" type="xsd:string"/>
</message>
*/
/*--INFO-- This service copies and/or build keys for seed data.*/
export Web_Service := MACRO

messagelayout :=
RECORD
	string info;
END;


xout(string s) := output(dataset([{s}],messagelayout),NAMED('Messages'),EXTEND);

sequential
(
#if ( %'Action'% = 'CopyFiles')
	#if (%'SeedDataType'% = 'Attribute' and %'DatalandFilename'% <> '')
		xout('Copying files for attribute'),
		seed_files.Copy_Attribute_File(%'DatalandFilename'%,%'BuildVersion'%),
	#end
	#if (%'SeedDataType'% = 'CustomerInstantID' and %'DatalandFilename'% <> '')
		xout('Copying files for customer InstantID'),
		seed_files.Copy_ciid_File(%'DatalandFilename'%,%'BuildVersion'%),
	#end
	#if (%'SeedDataType'% = 'BusinessInstantID' and %'DatalandFilename'% <> '')
		xout('Copying files for Business InstantID'),
		seed_files.Copy_biid_File(%'DatalandFilename'%,%'BuildVersion'%),
	#end
	#if (%'SeedDataType'% = 'LegacySeed' and %'DatalandFilename'% <> '')
		xout('Copying files for Legacy Seed'),
		seed_files.Copy_legacy_seed_File(%'DatalandFilename'%,%'BuildVersion'%),
	#end
	#if (%'SeedDataType'% = '' or %'DatalandFilename'% = '')
		xout('Nothing to do, either DatalandFilename is empty or no seed data type selected'),
	#end
#end

#if ( %'Action'% = 'BuildKeys')
	#if (%'SeedDataType'% = 'Attribute' and %'BuildVersion'% <> '')
		xout('Build Keys for attribute'),
		seed_files.Proc_RiskViewAttr_Keys(%'BuildVersion'%),
	#end
	#if ( (%'SeedDataType'% = 'CustomerInstantID' or %'SeedDataType'% = 'BusinessInstantID')and %'BuildVersion'% <> '')
		xout('Build Keys for instant id'),
		seed_files.Proc_InstantID_Keys(%'BuildVersion'%),
	#end
	#if (%'SeedDataType'% = 'LegacySeed' and %'BuildVersion'% <> '')
		xout('Build Keys for legacy seed'),
		seed_files.proc_build_seed_keys(%'BuildVersion'%),
	#end
	#if (%'SeedDataType'% = '' or %'BuildVersion'% = '')
		xout('Nothing to do, either build version is empty or no seed data type selected'),
	#end
#end

#if (%'Action'% = '')
xout('Nothing To Do'),
#end

xout('Tasks Completed Successfully')
)

ENDMACRO;