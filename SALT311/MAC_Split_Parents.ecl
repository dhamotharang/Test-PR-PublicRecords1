// When enabled by HACK:BLOCKLINK_PARENTS, this macro will ripple BLOCKLINK-triggered
// IDFIELD splits upwards to each IDPARENTS field.  Unlike MAC_ParentId_Patch, which
// ripples IDFIELD merges upwards, these rippled splits are not needed to maintain ID
// integrity -- rather, it's a way of expressing that the need to apply a BLOCKLINK
// casts doubt on the past linking in the upper levels.  Note that merely _preventing_
// an IDFIELD merge does not trigger IDPARENTS splitting -- they are free to merge and
// stay merged going forward.
EXPORT MAC_Split_Parents(infile,patchfile,did_name,pid_name,o) := MACRO
	#uniquename(pids)
	#uniquename(infile_null)
	#uniquename(infile_nonnull)

	%infile_null%    := infile(pid_name=0);
	%infile_nonnull% := infile(pid_name<>0);

	%pids% := JOIN(
		%infile_nonnull%, patchfile,
		LEFT.did_name=RIGHT.did_name AND LEFT.pid_name<>0,
		TRANSFORM({LEFT.pid_name},SELF:=LEFT),
		KEEP(1));
	o := %infile_null% + JOIN(
		%infile_nonnull%, %pids%,
		LEFT.pid_name=RIGHT.pid_name,
		TRANSFORM(RECORDOF(LEFT),SELF.pid_name:=if(RIGHT.pid_name!=0,LEFT.did_name,LEFT.pid_name),SELF:=LEFT),
		LEFT OUTER, KEEP(1), HASH);
ENDMACRO;