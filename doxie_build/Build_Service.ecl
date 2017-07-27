/*--SOAP--
<message loadXml="true" name="Build_Service" wuTimeout="-1" cluster="thor" async="1">
	<part name="DataType" type="xsd:string">
        <html>
          <td width="25%"><font face="Verdana" size="2">DataType:</font></td>
          <td><font face="Verdana" size="2">
            <select name="DataType">
				<Option value=""></Option>
				<Option value="Vehicle">Vehicle</Option>
				<Option value="DriverLicenses">Driver Licenses</Option>
				<Option value="DOC">Corrections</Option>
				<Option value="SexOffender">Sex Offender</Option>
				<Option value="CrimHistory">Criminal History</Option>
				<Option value="CrimHistoryDaily">Criminal History Daily</Option>
                </select>                              
           </font></td>
        </html>
	</part>
	<part name="BasicActions" type="xsd:string">
        <html>
          <td width="25%"><font face="Verdana" size="2">Basic Actions:</font></td>
          <td><font face="Verdana" size="2">
            <select name="BasicActions">
				<Option value=""></Option>
				<Option value="RunRawStats">1. RunRawStats</Option>
				<Option value="RunFullBuild">2. RunFullBuild</Option>
				<Option value="SaveToProduction">3. EarmarkKeysForProduction</Option>
                </select>                              
           </font></td>
        </html>
	</part>
	<part name="AdvancedActions" type="xsd:string">
        <html>
          <td width="25%"><font face="Verdana" size="2">Advanced Actions:</font></td>
          <td><font face="Verdana" size="2">
            <select name="AdvancedActions">
				<Option value=""></Option>
				<Option value="RunRawStats">1. RunRawStats</Option>
				<Option value="BuildBaseFile">2. BuildBaseFile</Option>
				<Option value="RunBaseStats">3. RunBaseStats</Option>
				<Option value="BuildKeys">4. BuildKeys</Option>
				<Option value="SaveToProduction">5. EarmarkKeysForProduction</Option>
				<Option value="RollBackToProduction">6. RollBackToProduction</Option>
				<Option value="CleanUp">7. CleanUp</Option>
                </select>                              
           </font></td>
        </html>
	</part>
</message>
*/
/*--INFO-- This service builds your data files for you.*/
export Build_Service := MACRO

messagelayout :=
RECORD
	string info;
END;


xout(string s) := output(dataset([{s}],messagelayout),NAMED('Messages'),EXTEND);


sequential(

#if (%'DataType'% = 'Vehicle' AND (%'AdvancedActions'% = 'RunRawStats' OR %'BasicActions'% = 'RunRawStats'))
xout('Doing Vehicle Raw Stats'),
doxie_stats.proc_vehicle_in,
#end
#if (%'DataType'% = 'Vehicle' AND (%'AdvancedActions'% = 'BuildBaseFile' OR %'BasicActions'%='RunFullBuild'))
xout('Doing Vehicle Base File Build'),
doxie_build.Proc_Build_Vehicle_Search_Base,
#end
#if (%'DataType'% = 'Vehicle' AND (%'AdvancedActions'% = 'RunBaseStats' OR %'BasicActions'%='RunFullBuild'))
xout('Doing Vehicle Base File Stats'),
doxie_stats.proc_vehicle_base,
#end
#if (%'DataType'% = 'Vehicle' AND (%'AdvancedActions'% = 'BuildKeys' OR %'BasicActions'%='RunFullBuild'))
xout('Doing Vehicle Key Build'),
sequential(doxie_build.proc_build_Vehicle_search_Keys, doxie_build.Proc_AcceptSK_veh_toQA),
#end
#if (%'DataType'% = 'Vehicle' AND (%'AdvancedActions'% = 'SaveToProduction' OR %'BasicActions'%='SaveToProduction'))
xout('Doing Vehicle Save Keys to Production'),
doxie_build.Proc_AcceptSK_veh_toProd,
#end
#if (%'DataType'% = 'Vehicle' AND (%'AdvancedActions'% = 'RollBackToProduction'))
xout('Doing Vehicle Roll Back'),
doxie_build.Proc_RollbackSK_veh,
#end
#if (%'DataType'% = 'Vehicle' AND %'AdvancedActions'% = 'CleanUp')
xout('Doing Vehicle Clean Up'),
doxie_build.proc_cleanup_vehlic,
#end

#if (%'DataType'% = 'DriverLicenses' AND (%'AdvancedActions'% = 'RunRawStats' OR %'BasicActions'% = 'RunRawStats'))
xout('Doing Driver Licenses Raw Stats'),
doxie_stats.proc_dl_in,
#end
#if (%'DataType'% = 'DriverLicenses' AND (%'AdvancedActions'% = 'BuildBaseFile' OR %'BasicActions'%='RunFullBuild'))
xout('Doing Driver Licenses Base File Build'),
doxie_build.Proc_Build_DL_Search_Base,
#end
#if (%'DataType'% = 'DriverLicenses' AND (%'AdvancedActions'% = 'RunBaseStats' OR %'BasicActions'%='RunFullBuild'))
xout('Doing Driver Licenses Base File Stats'),
doxie_stats.proc_dl_base,
#end
#if (%'DataType'% = 'DriverLicenses' AND (%'AdvancedActions'% = 'BuildKeys' OR %'BasicActions'%='RunFullBuild'))
xout('Doing Driver Licenses Key Build'),
sequential(doxie_build.proc_build_dl_search_Keys, doxie_build.Proc_AcceptSK_dl_toQA),
#end
#if (%'DataType'% = 'DriverLicenses' AND (%'AdvancedActions'% = 'SaveToProduction' OR %'BasicActions'%='SaveToProduction'))
xout('Doing Driver Licenses Save Keys to Production'),
doxie_build.Proc_AcceptSK_dl_toProd,
#end
#if (%'DataType'% = 'DriverLicenses' AND (%'AdvancedActions'% = 'RollBackToProduction'))
xout('Doing Driver Licenses Roll Back'),
doxie_build.Proc_RollbackSK_dl,
#end
#if (%'DataType'% = 'DriverLicenses' AND %'AdvancedActions'% = 'CleanUp')
xout('Doing Driver Licenses Clean Up'),
doxie_build.proc_cleanup_dl,
#end

#if (%'DataType'% = 'SexOffender' AND (%'AdvancedActions'% = 'RunRawStats' OR %'BasicActions'% = 'RunRawStats'))
xout('Doing Sex Offender Raw Stats'),
doxie_stats.proc_so_in,
#end
#if (%'DataType'% = 'SexOffender' AND (%'AdvancedActions'% = 'BuildBaseFile' OR %'BasicActions'%='RunFullBuild'))
xout('Doing Sex Offender Base File Build'),
sequential(snarra_pa_sor.build_pa_sor,doxie_build.proc_build_so_search_base,snarra_pa_sor.clear_pa_sor_in),
#end
#if (%'DataType'% = 'SexOffender' AND (%'AdvancedActions'% = 'RunBaseStats' OR %'BasicActions'%='RunFullBuild'))
xout('Doing Sex Offender Base File Stats'),
doxie_stats.proc_so_base,
#end
#if (%'DataType'% = 'SexOffender' AND (%'AdvancedActions'% = 'BuildKeys' OR %'BasicActions'%='RunFullBuild'))
xout('Doing Sex Offender Key Build'),
sequential(doxie_build.Proc_Build_SO_Search_Keys, doxie_build.Proc_AcceptSK_so_toQA),
#end
#if (%'DataType'% = 'SexOffender' AND (%'AdvancedActions'% = 'SaveToProduction' OR %'BasicActions'%='SaveToProduction'))
xout('Doing Sex Offender Save Keys to Production'),
doxie_build.Proc_AcceptSK_so_toProd,
#end
#if (%'DataType'% = 'SexOffender' AND (%'AdvancedActions'% = 'RollBackToProduction'))
xout('Doing Sex Offender Roll Back'),
doxie_build.Proc_RollbackSK_SO,
#end
#if (%'DataType'% = 'SexOffender' AND %'AdvancedActions'% = 'CleanUp')
// snarra_pa_sor.clear_pa_sor_in
xout('There is no cleanup necessary for Corrections.'),
#end

#if (%'DataType'% = 'DOC' AND (%'AdvancedActions'% = 'RunRawStats' OR %'BasicActions'% = 'RunRawStats'))
xout('Doing DOC Raw Stats'),
doxie_stats.proc_doc_in,
#end
#if (%'DataType'% = 'DOC' AND (%'AdvancedActions'% = 'BuildBaseFile' OR %'BasicActions'%='RunFullBuild'))
xout('Doing DOC Base File Build'),
doxie_build.proc_build_doc_bases,
#end
#if (%'DataType'% = 'DOC' AND (%'AdvancedActions'% = 'RunBaseStats' OR %'BasicActions'%='RunFullBuild'))
xout('Doing DOC Base File Stats'),
doxie_stats.proc_doc_base,
#end
#if (%'DataType'% = 'DOC' AND (%'AdvancedActions'% = 'BuildKeys' OR %'BasicActions'%='RunFullBuild'))
xout('Doing DOC Key Build'),
sequential(doxie_build.proc_build_DOC_keys,doxie_build.proc_AcceptSK_DOC_To_QA),
#end
#if (%'DataType'% = 'DOC' AND (%'AdvancedActions'% = 'SaveToProduction' OR %'BasicActions'%='SaveToProduction'))
xout('Doing DOC Save Keys to Production'),
doxie_build.Proc_AcceptSK_DOC_to_Prod,
#end
#if (%'DataType'% = 'DOC' AND (%'AdvancedActions'% = 'RollBackToProduction'))
xout('Doing DOC Roll Back'),
doxie_build.Proc_RollbackSK_DOC,
#end
#if (%'DataType'% = 'DOC' AND %'AdvancedActions'% = 'CleanUp')
xout('There is no cleanup necessary for Corrections.'),
#end


#if (%'DataType'% = 'CrimHistoryDaily' AND (%'AdvancedActions'% = 'RunRawStats' OR %'BasicActions'% = 'RunRawStats'))
xout('Doing CrimHistoryDaily Raw Stats'),
xout('NotYetImplemented'),
#end
#if (%'DataType'% = 'CrimHistoryDaily' AND (%'AdvancedActions'% = 'BuildBaseFile' OR %'BasicActions'%='RunFullBuild'))
xout('Doing CrimHistoryDaily Base File Build'),
doxie_build.Proc_Build_CrimHist_Daily_bases,
#end
#if (%'DataType'% = 'CrimHistoryDaily' AND (%'AdvancedActions'% = 'RunBaseStats' OR %'BasicActions'%='RunFullBuild'))
xout('Doing CrimHistoryDaily Base File Stats'),
xout('NotYetImplemented'),
//doxie_stats.proc_CrimHistory_base,
#end
#if (%'DataType'% = 'CrimHistoryDaily' AND (%'AdvancedActions'% = 'BuildKeys' OR %'BasicActions'%='RunFullBuild'))
xout('Doing CrimHistoryDaily Key Build'),
doxie_build.proc_AcceptSK_CrimHistory_To_QA,
#end
#if (%'DataType'% = 'CrimHistoryDaily' AND (%'AdvancedActions'% = 'SaveToProduction' OR %'BasicActions'%='SaveToProduction'))
xout('Doing CrimHistoryDaily Save Keys to Production'),
doxie_build.Proc_AcceptSK_CrimHistory_to_Prod,
#end
#if (%'DataType'% = 'CrimHistoryDaily' AND (%'AdvancedActions'% = 'RollBackToProduction'))
xout('Doing CrimHistoryDaily Roll Back'),
xout('NotYetImplemented'),
//doxie_build.Proc_RollbackSK_CrimHistory,
#end
#if (%'DataType'% = 'CrimHistoryDaily' AND %'AdvancedActions'% = 'CleanUp')
xout('Doing CrimHistoryDaily Clean Up'),
xout('Not Yet Implemented'),
#end


#if (%'DataType'% = 'CrimHistory' AND (%'AdvancedActions'% = 'RunRawStats' OR %'BasicActions'% = 'RunRawStats'))
xout('Doing CrimHistory Raw Stats'),
xout('NotYetImplemented'),
#end
#if (%'DataType'% = 'CrimHistory' AND (%'AdvancedActions'% = 'BuildBaseFile' OR %'BasicActions'%='RunFullBuild'))
xout('Doing CrimHistory Base File Build'),
doxie_build.Proc_Build_CrimHist_bases,
#end
#if (%'DataType'% = 'CrimHistory' AND (%'AdvancedActions'% = 'RunBaseStats' OR %'BasicActions'%='RunFullBuild'))
xout('Doing CrimHistory Base File Stats'),
xout('NotYetImplemented'),
//doxie_stats.proc_CrimHistory_base,
#end
#if (%'DataType'% = 'CrimHistory' AND (%'AdvancedActions'% = 'BuildKeys' OR %'BasicActions'%='RunFullBuild'))
xout('Doing CrimHistory Key Build'),
sequential(doxie_build.proc_build_CrimHist_keys,doxie_build.proc_AcceptSK_CrimHist_To_QA),
#end
#if (%'DataType'% = 'CrimHistory' AND (%'AdvancedActions'% = 'SaveToProduction' OR %'BasicActions'%='SaveToProduction'))
xout('Doing CrimHistory Save Keys to Production'),
doxie_build.Proc_AcceptSK_CrimHistory_to_Prod,
#end
#if (%'DataType'% = 'CrimHistory' AND (%'AdvancedActions'% = 'RollBackToProduction'))
xout('Doing CrimHistory Roll Back'),
xout('NotYetImplemented'),
//doxie_build.Proc_RollbackSK_CrimHistory,
#end
#if (%'DataType'% = 'CrimHistory' AND %'AdvancedActions'% = 'CleanUp')
xout('Doing CrimHistory Clean Up'),
xout('Not Yet Implemented'),
#end

#if (%'DataType'% = 'Images' AND (%'AdvancedActions'% = 'RunRawStats' OR %'BasicActions'% = 'RunRawStats'))
xout('No Stats for Images'),
#end
#if (%'DataType'% = 'Images' AND (%'AdvancedActions'% = 'BuildBaseFile' OR %'BasicActions'%='RunFullBuild'))
xout('Doing Images Base File Build'),
Images.proc_build_base,
#end
#if (%'DataType'% = 'Images' AND (%'AdvancedActions'% = 'RunBaseStats' OR %'BasicActions'%='RunFullBuild'))
xout('No Image Base File Stats'),
#end
#if (%'DataType'% = 'Images' AND (%'AdvancedActions'% = 'BuildKeys' OR %'BasicActions'%='RunFullBuild'))
xout('Doing Images Key Build'),
sequential(images.proc_build_keys, images.proc_accept_sk_to_qa),
#end
#if (%'DataType'% = 'Images' AND (%'AdvancedActions'% = 'SaveToProduction' OR %'BasicActions'%='SaveToProduction'))
xout('Doing Images Save Keys to Production'),
images.proc_accept_sk_to_prod,
#end
#if (%'DataType'% = 'Images' AND (%'AdvancedActions'% = 'RollBackToProduction'))
xout('Doing Images Roll Back'),
images.Proc_RollbackSK,
#end
#if (%'DataType'% = 'Images' AND %'AdvancedActions'% = 'CleanUp')
xout('No Image Clean Up'),
#end

#if (%'DataType'% = '' AND %'AdvancedActions'% = '' AND %'BasicActions'%='')
xout('Nothing To Do'),
#end

xout('Tasks Completed Successfully'))

ENDMACRO;