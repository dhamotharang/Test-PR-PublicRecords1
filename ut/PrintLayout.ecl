/***************************************************************************************************************************************
* NAME: PrintLayout
* PARAMETERS: 1) [REQUIRED]  in_layout  => any layout, dataset or index.
*             2) [OPTIONAL]  numberFields  => If set to TRUE, it will number the layout fields as 1) field1 2)field2 3)field3 etc (see example5 below).
*             3) [OPTIONAL]  Email_recipients  => a single or multiple string emails seperated by comma or semi colon (see example4 below).
*             4) [OPTIONAL]  EmailBody  => a string of text to be added to the email's body (see example4 below).
* PURPOSE: -Most of our layouts inherit fields from parent layouts (TYPEOF) and it takes many "F12"'s to actually view the entire layout.
*          -This Function macro efficiently and clearly prints out the FULLY QUALIFIED record structure of ANY layout, dataset or index.
*          -It handles BOTH flat (batch) and nested (iesp) layouts. 
*          -It also allows you to email the layout directly from the attribute as an email attachment [layoutNAME].txt. 
* USEAGE: -It can be used both to view layouts while debugging or to inherit full layout structures. This is useful when supplying Batch or ESP with layouts.
* EXAMPLE1: ut.PrintLayout(iesp.nac_search.t_NACSearchRequest); // This outputs all layout fields including the nested record and dataset structures.
* EXAMPLE2: ut.PrintLayout(iesp.rnareport.t_RNAReport); // This outputs all layout fields including the nested record and dataset structures - really nested!.
* EXAMPLE3: ut.PrintLayout(Header.key_AllPossibleSSNs,,'fn.ln@lexisnexis.com','additonal fields read from stored: includeAll\n\nDefault-TRUE.'); // This outputs all index fields including the nested records and dataset structures and emails it to the recipients .
* EXAMPLE4: ut.PrintLayout(NAC_V2_Services.Layouts.Batch_in,TRUE,'fn.ln@lexisnexis.com'); // This outputs numbered fields and emails them out.
* IMPORTANT INFO: -For best nested layout visuals, please copy/paste the output in a text editor such as notepad++ or a new builder window.
*									-This function does not handle Modules and Interfaces.
*****************************************************************************************************************************************/

EXPORT PrintLayout(in_layout,numberFields=FALSE,Email_recipients='\'\'',EmailBody='\'\'') := FUNCTIONMACRO
IMPORT STD;
	#DECLARE(text_layout); #SET(text_layout,'');
	#DECLARE(currentlyIn); #SET(currentlyIn,''); //stack - DS - D vs Rec - R
	#DECLARE(tab); #SET(tab,'');
	#DECLARE(field_alignment_space); #SET(field_alignment_space,'');
	#DECLARE(defaultValue); #SET(defaultValue,'');
	#DECLARE(len_dt); #SET(len_dt,0);
	#DECLARE(fieldNum); #SET(fieldNum,'');
	#DECLARE(i); #SET(i,0);
	
	LOCAL LayoutName   := TRIM(#TEXT(in_layout),ALL);
	LOCAL LayNameLen   := LENGTH(LayoutName);
	LOCAL RightStarLen := STD.Str.Repeat('*',IF(LayNameLen>26,LayNameLen,26));
	//Get current date and time formatted as - On MM/DD/YY At HH:MM:SS PM/AM 
	LOCAL CurrentDateTime := STD.Date.SecondsToString(STD.Date.CurrentSeconds(TRUE),'On %D At %r');
	LOCAL EChar:='&nbps;';BR:='\n';I_DS:='/** ';I_REC:='/*  ';End_DS_REC:=' */';
	
	#APPEND(text_layout,'//*******************' + EChar + RightStarLen    + BR
                     +'//*Layout Full Name :' + EChar + LayoutName      + BR	
                     +'//*Total # of Fields:' + EChar + '~field_count~' + BR
                     +'//*Layout Generated :' + EChar + CurrentDateTime + BR 
	                   +'//*******************' + EChar + RightStarLen    + BR
										 +'//*** BEGIN_LAYOUT ***'+ EChar + ' '             + BR); 
										 
	#EXPORTXML(fields,RECORDOF(in_layout));
	#FOR(fields)
		#FOR(Field)
			#IF(%'{@isDataset}'%='1')
				#APPEND(currentlyIn,'D');
				#SET(defaultValue, IF(%'Expression'%='','',' := ' + STD.Str.CleanSpaces(%'Expression'%))); //format default value if there is one
				#APPEND(text_layout,%'tab'% + I_DS + 'BEGIN_DATASET' + EChar + %'{@label}'% + %'defaultValue'% + End_DS_REC + BR);
				#APPEND(tab,'\t');
			#ELSEIF(%'{@isRecord}'%='1')
				#APPEND(currentlyIn,'R');
				#APPEND(text_layout,%'tab'% + I_REC + 'BEGIN_RECORD' + EChar + %'{@label}'% + ' (' + %'{@ecltype}'% + ')' + End_DS_REC + BR);
				#APPEND(tab,'\t');
			#ELSEIF(%'{@isEnd}'%='1' AND STD.Str.EndsWith(%'currentlyIn'%,'D'))
				#SET(currentlyIn,STD.Str.RemoveSuffix(%'currentlyIn'%,'D'));
				#SET(tab,STD.Str.RemoveSuffix(%'tab'%,'\t'));
				#APPEND(text_layout,%'tab'% + I_DS + 'END___DATASET' + EChar + %'{@name}'% + End_DS_REC + BR);
			#ELSEIF(%'{@isEnd}'%='1' AND STD.Str.EndsWith(%'currentlyIn'%,'R'))
				#SET(currentlyIn,STD.Str.RemoveSuffix(%'currentlyIn'%,'R'));
				#SET(tab,STD.Str.RemoveSuffix(%'tab'%,'\t'));
				#APPEND(text_layout,%'tab'% + I_REC + 'END___RECORD' + EChar + %'{@name}'% + End_DS_REC + BR);
			#ELSE 
				#SET(len_dt,LENGTH(%'{@ecltype}'%));
				#SET(field_alignment_space, STD.Str.Repeat(' ',IF(%len_dt%<=9,9-%len_dt%,0))); //aligns string, string1, string10, string100
				#SET(defaultValue, IF(%'Expression'%='','',' := ' + STD.Str.CleanSpaces(%'Expression'%))); //format default value if there is one
				#SET(i,%i% + 1);
				#SET(fieldNum,IF(numberFields,%i% +') ',''));
				#APPEND(text_layout,%'tab'% + %'fieldNum'% + %'{@ecltype}'% + %'field_alignment_space'% + EChar + %'{@label}'% + %'defaultValue'% + ';' + BR);
			#END
		#END
	#END
	
	#APPEND(text_layout,'//*** END___LAYOUT ***' + EChar + ' ' + BR); 
	
	//evaluate string layout from XML and populate actual field_count value
	LOCAL layout_ready := STD.Str.FindReplace(%'text_layout'%, '~field_count~',%'i'%);
	
	LOCAL string_to_ds := DATASET(STD.Str.SplitWords(layout_ready,BR),{STRING dt_field_concat});
	
	LOCAL formatted_output_ds := 
		PROJECT(string_to_ds,
							TRANSFORM({STRING datatype, STRING field},
								dt_field_ds   := STD.Str.SplitWords(LEFT.dt_field_concat,EChar);
								SELF.datatype := dt_field_ds[1]; //we don't want to clean spaces here because we purposely inserted them in the xml string to align the fields
								SELF.field    := dt_field_ds[2]; //we already ran this through STD.Str.CleanSpaces to handle malformed empty strings so := '         ' becomes := ' '
							));

	//EMAIL info
	LOCAL Email_subject := 'Layout - ' + LayoutName;
	LOCAL Email_body := 'Please see attached file to view ' + Email_subject + '.' + BR + BR
	              + IF(EmailBody<>'', RightStarLen + BR + EmailBody + BR + RightStarLen + BR + BR,'')
	              + '*** This email was automatically generated via UT.PrintLayout (' + WORKUNIT + ') by ' + thorlib.jobowner() + '. Please do not reply ***';
	LOCAL Email_attachment := STD.Str.FindReplace(layout_ready, EChar,' ');
	LOCAL Email_attachment_type := 'text/plain;';
	LOCAL Email_attachment_name := LayoutName + '.txt';

	RETURN SEQUENTIAL(OUTPUT(CHOOSEN(formatted_output_ds,100000))
										,IF(Email_recipients<>'',STD.System.Email.SendEmailAttachText(
																																					Email_recipients,
																																					Email_subject,
																																					Email_body,
																																					Email_attachment,
																																					Email_attachment_type,
																																					Email_attachment_name)));
ENDMACRO;