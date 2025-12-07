// Detects race start trigger

default
{
    collision_start(integer total)
    {
        llMessageLinked(LINK_ROOT, 100, "", llGetKey());
    }
}
