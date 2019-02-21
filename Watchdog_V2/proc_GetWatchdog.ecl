IMPORT Watchdog;

// standard return layout
Layout := Watchdog.Layout_best_flags;

fGetWatchdog(unsigned8 permissions
			,dataset({unsigned8 bitmap_permissions,unsigned8 Did}) dsDID
			,boolean useLegacy = true) := FUNCTION

	k := Watchdog_V2.Key_Watchdog_Merged(useLegacy);
	d := IF(exists(dsDID)
			,LIMIT(join(dsDID,k
				,keyed(left.did=right.did)
				and (right.bitmap_permissions & left.bitmap_permissions)=permissions
					,transform(right)
				,keep(10)
				,limit(0)
				), 50, fail('OOOOOOOOH, OH!!!!!'))
			,k(bitmap_permissions & permissions<>0)
			);

	AsLegacy := PROJECT(d, TRANSFORM(Layout,
							self.total_records := left.counts((bitmap_Permissions & permissions) <> 0)[1].total_records;
							self := LEFT;
							self := []));

	return AsLegacy;

END;


EXPORT proc_GetWatchdog(
		unsigned8			permissions
		,dataset({unsigned8 bitmap_permissions, unsigned8 did}) dsDid
		,boolean				useLegacy = true) := FUNCTION
		
		return IF( (permissions -1) & permissions = 0
				,fGetWatchdog (permissions,dsDID,useLegacy)
				,Dataset([],Layout)
				);

END;