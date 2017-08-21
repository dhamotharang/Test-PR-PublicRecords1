// export MAC_GetTelecordiaOutput := 'todo';
export MAC_GetTelecordiaOutput(filename) := 
macro
#uniquename(spray_main)
#uniquename(layout)
#uniquename(d1)
#uniquename(LNID)
#uniquename(PH1)
#uniquename(phoneType1)
#uniquename(build_bk_keys)
#uniquename(sourceIP)
#uniquename(d1out)
#uniquename(despray_main)
#uniquename(tblD1)
#uniquename(total)
#uniquename(group_name)

#workunit('name',filename + ' Phone Types');

%sourceIP% := _control.IPAddress.edata12;

%group_name% :='thor400_92';

%spray_main% := FileServices.SprayVariable( %sourceIP% , '/thor_back5/cellphones/telecordia/'+filename, 4096,,,,%group_name%, 'in::' + filename,-1,,,true,true);

%layout% := record, maxlength(4096)
 string %LNID%;
 string %PH1%;
end;

%d1% := dataset('in::' + filename,%layout%,csv(terminator('\r\n'),quote('"'),separator(',')));

YellowPages.NPA_PhoneType(%d1%,%PH1%,%phoneType1%,%d1out%);

%despray_main%:=fileservices.Despray('in::d1_' + filename, %sourceIP%, '/thor_back5/cellphones/telecordia/archive_outfiles/' + filename,,,,true);

%tblD1% := table(%d1out%, {%phonetype1% , %total% := count(group)}, %phonetype1%);

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)

sequential(
	%spray_main%,
	output(count(%d1%), named('View_Input_File')),
	output(%d1out%,,'in::d1_' + filename,csv(terminator('\r\n'), separator(',')),overwrite),
	output(%tblD1%, named('Input_File_Stats')),
	%despray_main%);
	// ,
	// FileServices.SendEmail( 'cguyton@seisint.com, sbarnes@seisint.com',filename +' Despray Complete',Thorlib.WUID() + '\n'+ filename));

endmacro;