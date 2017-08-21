import ut;
EXPORT GetPublicationDate(string ListName) := FUNCTION
		dt := PubDates(WatchListname=ListName)[1].WatchListDate;
		return ut.ConvertDate(dt,'%m/%d/%Y %H:%M:%S',
			'%Y-%m-%dT%H:%M:%S') + '.0000000Z';
END;