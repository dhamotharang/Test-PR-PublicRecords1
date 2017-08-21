import Prof_License;
Export File_Infutor_Raw(string filedate):=module
EXPORT Infutor_Raw := dataset('~thor_data400::in::prolic_infutor_'+filedate+'_raw',Prof_License.Layout_infutor_in,CSV(SEPARATOR(['\t']), quote('"'), TERMINATOR(['\r\n', '\n'])));;
end;