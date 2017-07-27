export Layouts :=
module

	/**************************************************************************************/
	export	rRawCacheUpdate	:=
	record
		Constants.xAID					AID;
		Constants.xDateString		DateSeenFirst;
		Constants.xDateString		DateSeenLast;
		boolean									IsNormalized;
		Constants.xFlags				NormalizeFlags;
		Constants.xFlags				Flags;
		Constants.xVersion			StdVersion;
		Constants.xAID					StdAID;
		Constants.xAID					ReferAID;
	end;

	/**************************************************************************************/
	export	rStdCacheUpdate	:=
	record
		Constants.xAID					AID;
		Constants.xDateString		DateSeenFirst;
		Constants.xDateString		DateSeenLast;
		Constants.xAddressType	Cleaner;
		Constants.xAID					CleanAID;
		Constants.xDateString		DateCleanLast;
		Constants.xDateString		DateValidFirst;
		Constants.xDateString		DateValidLast;
		Constants.xDateString		DateErrorFirst;
		Constants.xDateString		DateErrorLast;
		Constants.xCleanStatus	ReturnCode;
		Constants.xAID					ReferAID;
	end;

	/**************************************************************************************/
	export	rACECacheUpdate	:=
	record
		Constants.xAID					AID;
		Constants.xDateString		DateSeenFirst;
		Constants.xDateString		DateSeenLast;
		Constants.xAID					CleanAID;
		Constants.xAID					ReferAID;
	end;

end;