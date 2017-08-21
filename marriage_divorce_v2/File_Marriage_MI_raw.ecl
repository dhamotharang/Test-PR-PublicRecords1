

export File_Marriage_MI_raw := dataset('~thor_200::in::mar_div::mi::marriage_raw',Layout_Marriage_MI_Raw,csv(Heading(1),terminator('\n'), separator(',')))(regexfind( 'Congratulations!|^Groom|^Start|^End|tgerring',groom_name) = false and regexfind('Congratulations!',groom_age) = false);