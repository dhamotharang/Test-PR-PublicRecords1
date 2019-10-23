IMPORT Std, VersionControl;
EXPORT proc_delete_records(DATASET($.Layout_Delete) deletes,
										DATASET($.Layout_Tradeline_base) tradelines = $.Files.Base,
										string8 file_version = (string8)VersionControl.fGetFilenameVersion($.Promote().sfDels)) := FUNCTION 

		d := DISTRIBUTE(deletes, hash32(ACCOUNT_KEY, AR_DATE));
		t := DISTRIBUTE(tradelines(status<>'D'), hash32(ACCOUNT_KEY, AR_DATE));
		integer4 deldate := (integer4)file_version;
		j := JOIN(t, d, left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE,
						TRANSFORM($.Layout_Tradeline_base,
							self.status := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, 'D', left.status);
							self.deletion_date := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.deletion_date);
							self.dt_vendor_last_reported := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.dt_vendor_last_reported);
							self := left;),
						LEFT OUTER, LOCAL);
						
		return j + tradelines(status='D');
END;
