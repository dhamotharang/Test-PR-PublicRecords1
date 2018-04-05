EXPORT fnEmailNotification := MODULE

	EXPORT Mac_ConstructEmailBody(ds, subj) := FUNCTIONMACRO

		//Construct the body of the message	
		#DECLARE (Indx)
		#SET (Indx,1);
		#DECLARE (EmailBody)
		#SET (EmailBody, '\'OKC Student List Update \'+'+#TEXT(subj)+'+\' - Top 25 OKC majors that are not mapped to ASL majors\\n\\n\\tMAJOR\\t\\t\\t\\t\\tCOUNT\\n\\t---------------------------------------------------------------------\\n\'');

		//Construct the body of the message	
		#LOOP
			#IF (%Indx% > 25)
				#BREAK
			#ELSE
				#APPEND(EmailBody, '+\'\\t\'+'+#TEXT(ds)+'['+%Indx%+'].major[1..25]+\'\\t\\t\\t\\t\'+'+#TEXT(ds)+'['+%Indx%+'].cnt+\'\\n\\r\'');
				#SET(Indx,%Indx%+1);
			#END
		#END	
	
		RETURN %EmailBody%;
		
	ENDMACRO;

	//This functiton output OKC majors that do not have mapping ASL college majors, 
	//and send a notification email listing top 100 majors without ASL major mapping.
	EXPORT noASLCollegeMajor(STRING pversion) := FUNCTION
	
		okc_base := OKC_Student_List.File_OKC_Base;
		//no major table
		okc_no_college_major := TABLE(DISTRIBUTE(okc_base(college_major=''),HASH(major)),{major,UNSIGNED cnt:=COUNT(GROUP)},major);
		okc_no_college_major_cnt := COUNT(okc_no_college_major);
		okc_no_college_major_srt := SORT(okc_no_college_major, -cnt);
		OUTPUT(okc_no_college_major_srt,,NAMED('OKC_Majors_No_ASL_Majors'));
		// email_subj:= 'OKC Student List Update ' + pversion +' - Top 100 OKC majors that are not mapped to ASL college majors';
		email_subj:= 'OKC Student List Update ' + pversion +' - OKC majors that are not mapped to ASL college majors';
		send_mail := fileservices.sendemail(OKC_Student_List.Constants().email_notification_missign_major_mapping,
		                                    email_subj,
		                                    Mac_ConstructEmailBody(okc_no_college_major_srt,pversion));
		
		RETURN send_mail;
	
	END; 
	
END;