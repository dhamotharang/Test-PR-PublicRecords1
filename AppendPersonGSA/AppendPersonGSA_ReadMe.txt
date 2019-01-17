Append Person GSA ReadMe
Version 1.0

===========================================================
                      Plugin Type
===========================================================
This is a COMPUTE plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin returns 2 different output. 
A main output for which a flag is appended showing whether a person has sanction and
a details output with GSA sanctions details as well as any columns from the input that 
the user wants in the details output. The details output is meant to be used with a graph 
to show details about an entity in the graph. 

===========================================================
                    What to Input
===========================================================

The Prefix input will be appended to the front of the newly created fields for the Main Output

The dsInput is the input dataset.

All these columns need to be specified by the user from the input dataset:
	LexID
	Entity Context UID - the entity context UID of the LexID used
	Append Fields - Any columns that should be in the details output layout

The following options are currently required regardless of the data not needing restrictions
	DPPA Purpose
	GLB Purpose
	Data Restriction Mask
These variables will typically be set as global variables and passed in through the whole composition 
and should be known beforehand.

===========================================================
                      Output
===========================================================

For the main output, dsOutput, this plugin appends the following columns
	HasGsa - an integer displaying 1 if the person has GSA.

For the details output, dsDetails, this plugin returns the following columns.
This output is created for use in a graph
	Append Fields - any columns selected in the Append Fields input
	GsaName - the business with GSA sanctions name
	GsaClassification - Populated in GSA Business data 100%
	GsaCTType - Populated in GSA Business data 100%
	GsaDescription - Populated in GSA Business data 85%
	GsaActionDate - Populated in GSA Business data 99%
	GsaTermDate - Populated in GSA Business data 10%
	GsaTermDateIndefinite - Populated in GSA Business data 90%
	GsaCTCode - Populated in GSA Business data 68%
	GsaAgencyComponent - Populated in GSA Business data 99%
	GraphId - the entity context UID
	PersonHasGsa - an indicator that the entity business has a GSA record
	PersonHasGsaDescription - 'Y' if the person has GSA, 'N' otherwise

===========================================================
                      Side Effects
===========================================================
Hit Rate: Counts of how many records had a Gsa match either by Prox or by Sele, check these to make sure 
that it matches your expectation based on the input.
