// Trying to define an interface to get the specific merged key you want by passing the dataset and
//   the bitmap.
IMPORT Watchdog;

EXPORT IKeys := INTERFACE
  EXPORT UNSIGNED6 did;
  EXPORT UNSIGNED8 bitmap_permissions;
	EXPORT DATASET(Watchdog.Layout_Best_Merged) ds;
END;

// Instantiate the key interface.
KeyInstance(UNSIGNED6 pdid, UNSIGNED8 pbitmap_permissions, DATASET(Watchdog.Layout_Best_Merged) input) := MODULE
  EXPORT did := pdid;
  EXPORT bitmap_permissions := pbitmap_permissions;
	EXPORT DATASET(Watchdog.Layout_Best_Merged) ds := input;
END;
