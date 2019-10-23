EXPORT Wait4Event(
  string pevent
) :=
wait(event(pevent,'*'));
