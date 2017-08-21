
EXPORT _Common := MODULE
	EXPORT Email_Notify(STRING sendTo, STRING subject, STRING body) := FUNCTION
		sendMail := FileServices.sendemail(sendTo,subject,body);
		RETURN sendMail;
	END;
END;