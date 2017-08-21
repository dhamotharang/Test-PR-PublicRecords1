/*
	maybe need two record type flags on the contact file
		one for the contacts itself to see how many new/old/updated, etc records
		also one that comes from the company file that we can map to the old record type field
		because that is the way it is done in the old build
	Also, maybe need to split out the stats on the record type flags from the ingest process since
	it is modified after the ingest process because of the deletes.
	well, that should be taken care of by the stat macros, which could group by the record type field
	might want to add some SALT stats to this build too.
*/
